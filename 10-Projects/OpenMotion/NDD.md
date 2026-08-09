---
tags: [project, design, networking]
project: OpenMotion
status: accepted
date: 2026-08-09
version: 0.2
freigabe: "Freigabe Glieder 2026-08-09 (Netz-Entscheidungen Q1-Q5, inkl. Save & Resume)"
---

# OpenMotion — Networking Design Document (NDD)

> Status: **FREIGEGEBEN (accepted)** — Freigabe durch Glieder am 2026-08-09 (Netz-Entscheidungen Q1–Q5, inkl. Save & Resume), Freigabe-Regel ADR-004
> Version 0.2 · Datum 2026-08-09
> Autor: Hermes (Senior Networking Specialist, Senior Lead Game Developer)
> Zweck: legt Designentscheidung **D4 „Multiplayer-Architektur (Lockstep-Details)"** aus dem [[Projektplan]] zur Freigabe vor.
> Konsistenz: baut auf [[Gesamtkonzept]] §3 (Multiplayer-Architektur), [[60-Decisions/ADR-005_OpenMotion|ADR-005]] und dem freigegebenen [[60-Decisions/ADR-006_OpenMotion-Tech-Stack|ADR-006]] auf. Keine widersprüchlichen Festlegungen; alle Freigabe-Fragen Q1–Q5 sind entschieden (2026-08-09, Entscheider: Glieder), dokumentiert in §13.

---

## 1. Architekturüberblick

### 1.1 Lockstep-Prinzip (feste Grundsätze)

OpenMotion nutzt **Deterministic Lockstep** als Multiplayer-Kern (Gesamtkonzept §3, ADR-005/006):

- **EIN Simulationskern**, der auf jedem Client **bit-identisch** läuft (Fixed-Point-Mathematik, kein float in der Simulation).
- Übertragen werden **nur Spielereingaben** (`InputFrame`), **NIE der Weltzustand**. Das gilt ausnahmslos — auch für Resync und Late-Join (§5.4).
- Alle Clients rechnen denselben deterministischen Tick → Abweichungen sind **per Konstruktion ausgeschlossen**; jede verbleibende Abweichung wird durch Tick-Hash-Vergleich erkannt (§5).
- **Replay-Log = Eingabe-Log**: Jede Partie ist eine vollständige, deterministisch abspielbare Eingabe-Sequenz (Debugging, Desync-Analyse, Resync).
- **Host-Migration**: Fällt der Host aus, übernimmt ein anderer Client nahtlos (§6).
- **Netz**: Steamworks P2P (Steam Datagram Relay als NAT-Fallback), **kein Dedicated Server im MVP** → 0 € Serverkosten (ADR-006).

### 1.2 Komponenten & Datenfluss

| Komponente | Aufgabe | Deterministisch? |
|------------|---------|------------------|
| **Sim-Kern** (`SimulationCore`) | Rechnet die gesamte Welt (Wirtschaft, Linien, Fahrzeuge, SIM-Bewohner) in C# mit Fix32; verarbeitet ausschließlich Eingaben. | Ja (hart) |
| **Input-Pipeline** | Sammelt lokale Eingaben, sendet sie an den Host, empfängt konsolidierte `InputFrame`s, hält die Tick-Barriere. | Nein (reine Vermittlung) |
| **Replay/Resync** (`InputLog`, `HashVerifier`) | Führt das Eingabe-Log, berechnet Tick-Hashes, erkennt und behebt Desyncs, ermöglicht Late-Join. | Hash-Berechnung ja; Transport nein |
| **Netz-Transport** (`SteamTransport`) | Steamworks.NET, Lobbies, P2P via SDR; kapselt alle Steam-APIs hinter einem Interface (testbar ohne Steam, §11.3). | Nein |

Datenfluss pro Tick:

```
Spielereingabe (lokal) → Input-Pipeline → Host (konsolidiert) → Broadcast an alle Clients
   → Eingabe-Log (append) → Sim-Kern (Tick T) → Weltzustand (nur lokal!)
   → Rendering/UI (float, nicht-deterministisch erlaubt)
   → Tick-Hash (alle N Ticks) → Host vergleicht → Desync-Alarm?
```

### 1.3 Topologie

- **Star (Host = Hub)** im MVP: Alle Clients senden ihre `InputFrame`s an den Host; der Host konsolidiert sie in deterministischer Reihenfolge (§2.2) und broadcastet die vollständige Tick-Eingabe an alle.
- Der Host ist **keine Autorität über die Simulation** (die ist auf jedem Client identisch deterministisch), sondern nur **Transport-Ordnungsgeber + Session-Verwaltung** (Join/Leave/Pause/Migration, Replay-Log-Archiv, Hash-Vergleich). Diese Rollentrennung macht Host-Migration trivial (§6).
- Begründung Star statt Full-Mesh: eine einzige Ordnungsinstanz macht die deterministische Eingabe-Reihenfolge konstruktiv einfach; die Bandbreite ist irrelevant (Eingaben sind winzig, §7.3). Full-Mesh bleibt Phase-2-Option, falls Latenz es erfordert (kein MVP-Thema).

---

## 2. Tick- & Eingabe-Modell

### 2.1 Tick-Rate

- **Kern-/Netz-Tick: 30 Ticks/s — fest bestätigt (Entscheidung Q4, 2026-08-09, Entscheider: Glieder)**, konsistent mit ODF-1 (GDD). Kein Fallback auf 20 Ticks/s (Gesamtkonzept-Beispiel entfällt).
- Die Tick-Rate ist eine **Build-Zeit-Konstante** (`SimTickRate`), niemals zur Laufzeit änderbar; sie wird im Handshake mitgeführt (Protokoll-Version).
- **Rendering interpoliert** zwischen Ticks (nicht-deterministisch erlaubt, Standard in Sim-Spielen).
- **SIM-Bewohner**: Agenten-Sub-Tick 10 Hz über einen deterministischen Scheduler (§7.2), Gesamtkonzept §2.2a.

### 2.2 Input-Frame & Eingabe-Pipeline

Pro Tick und Spieler existiert **genau ein `InputFrame`** (ggf. leer — „leerer Frame" ist explizite Absichtserklärung, unterscheidbar von „kein Frame").

```csharp
// Illustrativ — exakte Feld-Layouts je InputKind werden als Kind-Tabelle
// Teil der Sim-API spezifiziert (binär, fixed layout, §3.5).
[StructLayout(LayoutKind.Sequential, Pack = 1)]
public readonly struct InputFrameHeader
{
    public readonly uint   Tick;         // globaler Tick-Index
    public readonly byte   PlayerId;     // 0..7 (deterministische Sitzordnung, s. u.)
    public readonly byte   CommandCount; // 0..MaxCommandsPerFrame
    public readonly ushort FrameSeq;     // Schutz gegen Duplikate/Reordering
}

public readonly struct InputCommand
{
    public readonly InputKind Kind;   // BuildRoad, BuildTrack, PlaceStop, BuildDepot,
                                      // BuyVehicle, SetLine, SetTimetable, SetPrices, Pause, ...
    public readonly Fix32    X;       // Welt-/Zellkoordinaten (fixed-point)
    public readonly Fix32    Y;
    public readonly uint     ParamA;  // Entity-/Linien-/Fahrzeug-ID usw.
    public readonly uint     ParamB;
}
```

**Pipeline (Host-seitig konsolidiert):**

1. Jeder Client sendet seinen `InputFrame` für Tick T an den Host.
2. Host wartet auf Frames **aller Spieler** für T (Tick-Barriere), sortiert sie deterministisch (**aufsteigend nach `PlayerId`**, dann `FrameSeq`), hängt Control-Frames an (Join/Leave/Pause/Migration, §8) und broadcastet die konsolidierte Tick-Eingabe an alle.
3. Alle Clients appenden die Tick-Eingabe an ihr Eingabe-Log (§5.3) und lassen den Sim-Kern Tick T verarbeiten.
4. Erst wenn T verarbeitet ist, wird T+1 angegangen.

**Bausystem:** Alle Bau-Eingaben (Straßen, Schienen, Haltestellen, Depots, Tunnel/Brücken — Bausystem Stufe 1, Gesamtkonzept §2.2b) sind gewöhnliche `InputCommand`s und laufen durch exakt diese Pipeline. Die Gültigkeit (Budget, Platzierung, Überlappung) prüft **die Simulation deterministisch** — nicht der Client und nicht das Netz (§9.2).

### 2.3 Pufferung & Stall

- **Input-Buffer (Jitter-Puffer): 2–3 Ticks** Vorlauf pro Client gegen Latenz/Jitter. Lokale Eingaben werden sofort gesendet, aber erst verarbeitet, wenn die Barriere für T geschlossen ist.
- Fehlt ein Frame (Verlust/Verzögerung), **stallt die gesamte Session** am aktuellen Tick (Lockstep-Barriere): alle Clients warten, UI zeigt „Warte auf Spieler X…" (i18n DE/EN, ADR-004). Kein Tick läuft mit unvollständigen Eingaben.
- Stall-Timeout → Spielerabfall-Behandlung (§8.4, §10).

### 2.4 Late-Join (Überblick)

Ein beitretender Spieler erhält vom Host das **Eingabe-Log ab Tick 0** (bzw. ab dem letzten Log-Checkpoint), spielt die Simulation headless im Fast-Forward nach und tritt nach Hash-Verifikation live bei. **Kein Weltzustand wird übertragen** — der Tick-0-Zustand ist durch den Seed vollständig bestimmt (§5.4, §8.2). Die Ladezeit wird über Log-Checkpoints begrenzt (gleicher Mechanismus wie Save & Resume, §12).

---

## 3. Deterministische Simulation

Die Regeln dieses Abschnitts sind **harte Lockstep-Disziplin** (ADR-006 „Ergänzende Festlegungen", Gesamtkonzept §11 Risiko „Desync trotz Lockstep"). Verstöße sind Code-Review-Blocker (ADR-004).

### 3.1 Fixed-Point (Fix32)

- Eigene kleine Math-Bibliothek `FixMath`: `Fix32` als `struct` über `int32` (Q16.16, 16 Nachkommastellen, Bereich ±32767). ADR-006 legt Fix32 fest.
- **Alle** Sim-Arithmetik läuft über `Fix32`/`FixMath` (+, −, ×, ÷, √, sin/cos-Tabellen deterministisch, Vergleich, Rundung). **Kein float/double in der Simulation** — floats nur außerhalb (Rendering, UI, Netz-Diagnostik), ADR-006.
- Definierte Overflow-/Underflow-Semantik (saturierend, dokumentiert und getestet); Division durch 0 → definierter Ersatzwert, niemals Exception.
- Falls kumulative Größen (Geld/Bilanzen) den Fix32-Bereich sprengen können, wird intern ein 64-bit-Fix-Typ ergänzt — **rein interner Typ, kein Netz-Format-Effekt** (Entscheidung bei Implementierung, kein Freigabe-Thema).
- Karten-Dimensionen werden so begrenzt, dass sie in Fix32 passen (Karten-Bounds sind Teil der Seed-Definition, §8.2).
- Typen als `struct`, keine Allokationen im Tick (Performance bei 10k+ Agenten, ADR-006).

### 3.2 Deterministischer RNG

- Eigener deterministischer PRNG (z. B. xoshiro256\*\*), **niemals** `System.Random`/`Random.Shared`.
- **Seed-Ableitung:** Master-Seed (aus Lobby/Map-Seed, §8.2) → pro Subsystem deterministisch abgeleitete Seeds (z. B. SplitMix64(seed, subsystemId)). Jeder SIM-Bewohner erhält seinen festen Agenten-Seed (Gesamtkonzept §2.2a).
- RNG-Zustand gehört **zum Sim-Zustand** und ist damit Teil des Tick-Hashes (§5.1).

### 3.3 Verbote (Lockstep-Disziplin)

In Sim-Pfaden verboten (nicht-deterministisch oder plattformabhängig):

- `float`/`double`-Arithmetik, `MathF`, `Math.Sqrt` (statt FixMath), trigonometrische Systemfunktionen.
- Zeitabhängigkeit: `DateTime`, `Stopwatch`, `Environment.TickCount`, `Time.GetTicksMsec()` — **keine** Echtzeit in der Simulation. Zeit existiert im Sim nur als Tick-Index.
- Ungeordnete Sammlungen: `Dictionary`/`HashSet`-**Iteration** (Iterationsreihenfolge nicht garantiert); siehe §3.4.
- Threading/Timing: `Task`-Scheduling, `lock`-abhängige Ordnung, `Thread.Sleep`, Parallelisierung mit nicht-deterministischer Reduktion.
- Reflection, `unsafe`-Pointer, `BinaryFormatter` (obsolet/unsicher), culture-abhängige APIs (`ToString`/`Parse` nur mit `InvariantCulture` oder binär).
- Jede Netz-Abhängigkeit im Sim-Kern (der Sim-Kern kennt das Netz nicht — er verarbeitet nur bereits geordnete Eingaben; dadurch ist er headless und in CI ohne Netz testbar, §11).

### 3.4 Sammlungen & Reihenfolge

- ADR-006: „deterministische Reihenfolge aller Sammlungen".
- Sim-interne Container: Listen mit fester Einfügeordnung, `SortedDictionary`/`SortedSet` mit **explizitem** `IComparer`, oder eigene kleine Container. Niemals von Hash-Iterationsreihenfolge abhängig sein.
- Tie-Break-Regeln für jede Sortierung explizit definieren (z. B. nach `PlayerId`, dann Entity-Id) — auch in §2.2.

### 3.5 Serialisierung

- **Binär, Little-Endian explizit** (kein Plattform-Endianness-Vertrauen), feste Layouts (`StructLayout.Sequential, Pack = 1`), manuelle (De-)Serialisierung (kein Reflection, kein `BinaryFormatter`).
- **Schema-Versionierung:** Jedes Paket-/Log-Format trägt eine Format-Version; inkompatible Versionen werden beim Handshake abgelehnt (Desync-Schutz durch Versions-Mismatch).
- Replay-Export: JSON (ADR-006: „JSON für Export/Replays"); **Netz-** und **Resync-**Format ist binär (klein, schnell), JSON ist reines Export-/Analyse-Format.

---

## 4. Netz-Transport

### 4.1 Steamworks.NET & Lobbies

- **Steamworks.NET** (MIT, C#) als Binding (ADR-006).
- Session-Typ: **Steam Lobby** (Public oder FriendsOnly, konfigurierbar), Slot-Limit 8 = maximale Spielerzahl inkl. Host.
- Lobby-Metadaten (beim Erstellen gesetzt, beim Joinen gelesen): `MapSeed` (uint64), `Gamemode` (Coop/Competitive), `SimTickRate`, `ProtocolVersion`, `SessionDisplayName`.
- Lobby-Mitgliedschaft **ist** die Zugangskontrolle: nur Mitglieder können der Session beitreten (§9.3).

### 4.2 P2P via SDR & NAT-Fallback

- Transport: **SteamNetworkingSockets via Steamworks.NET**; Steam Datagram Relay (SDR) stellt P2P mit automatischem NAT-Relay-Fallback bereit (ADR-006). **Kein eigener Server** — kein Hosting, 0 € Serverkosten.
- Die Steam-Transport-Schicht verschlüsselt die Pakete (§9.3); OpenMotion fügt keine eigene Krypto-Schicht im MVP hinzu.
- AppID/App-Check und `ProtocolVersion` werden bei jeder Verbindungsaufnahme geprüft.

### 4.3 Verbindungsaufbau & Handshake

1. Host erstellt Lobby + setzt Metadaten.
2. Client joinit Lobby, liest Metadaten, prüft `ProtocolVersion` + `SimTickRate` (hart; Abweichung → Join abgelehnt mit klarer Meldung, i18n).
3. Client baut P2P-Verbindung zum Host auf (SteamNetworkingSockets).
4. **Handshake:** beide Seiten tauschen SteamID, Session-Token und Tick-Stand. Host prüft: SteamID ∈ Lobby-Mitglieder (sonst Abbruch).
5. Host sendet das **Eingabe-Log ab Tick 0** (bzw. Checkpoint) → Client startet Resync (§5.4). Bei Session-Start (Tick 0) entfällt das (Seed-basierter Start, §8.2).
6. Client bestätigt mit Hash des erreichten Ticks; Host gibt ihn in die laufende Runde frei (Control-Frame `PlayerJoined`).

### 4.4 Paketformate (binär)

Gemeinsamer Header (alle Pakete, binär, Little-Endian):

```
Magic          uint32  0x4F4D4E31 ("OMN1")
ProtocolVer    uint16  Protokoll-Version (hart geprüft)
MessageType    uint8   s. Tabelle
Flags          uint8   (reserviert)
Tick           uint32  zugehöriger Tick (0 falls nicht tickgebunden)
SenderId       uint64  SteamID des Absenders
PayloadLength  uint32  Länge des Payloads
Payload        bytes   typabhängig
```

| `MessageType` | Richtung | Kanal | Inhalt |
|---------------|----------|-------|--------|
| `Handshake` | beide | reliable | Version, SteamID, Session-Token, Tick-Stand |
| `InputFrame` | Client→Host, Host→alle | reliable ordered | konsolidierte Tick-Eingabe (§2.2) |
| `InputLogChunk` | Host→Client | reliable ordered | Eingabe-Log-Abschnitt für Resync/Late-Join (§5.4) |
| `HashReport` | alle→Host | reliable | Tick + `SimHash64` (§5.2) |
| `ControlFrame` | Host→alle | reliable ordered | `PlayerJoined`/`PlayerLeft`/`Pause`/`Resume`/`PlayerDisconnected`/`HostMigration` (an Tick T gebunden, §8) |
| `DesyncReport` | alle | reliable | Desync-Alarm: Tick, erwarteter/aktueller Hash |
| `Heartbeat` | beide | unreliable | Keepalive (§10.2) |

### 4.5 Kanäle & Zuverlässigkeit

- **Reliable ordered** für alles Sim-relevante (InputFrames, Log-Chunks, Control-Frames, HashReports): Verlust wird von Steam nachgeliefert; die Bandbreite ist so klein, dass Reliable keine Nachteile bringt (§7.3). Paketverlust wird damit zu Verzögerung → Jitter-Puffer/Stall (§2.3, §10.1).
- **Unreliable** nur für `Heartbeat`.
- Maximale Paketgröße: 1 MB (Steam-Limit); realistisch bleiben Pakete < 1 KB.

---

## 5. Desync-Erkennung & Replay

### 5.1 Tick-Hash (Entscheidung + Begründung)

**Entscheidung: nicht-kryptografischer 64-bit-Hash** (eigene deterministische Implementierung, z. B. FNV-1a 64 oder xxHash3 — NuGet nur nach Lockstep-Check, ADR-006-Regel) über die deterministische Serialisierung des **gesamten Sim-Zustands inkl. aller SIM-Bewohner** (Gesamtkonzept §2.2a: „Tick-Hash prüft alle Agenten mit").

Begründung:

1. **Zweck ist Bit-Gleichheit, nicht Sicherheit:** Der Hash soll erkennen, dass zwei Clients denselben Zustand haben. Manipulationsschutz ist bei Lockstep ohnehin nicht erreichbar (§9.1) — ein krypto-Hash bringt hier keinen Sicherheitsgewinn.
2. **Kollisionswahrscheinlichkeit:** 64 bit bei ~10⁷ Ticks pro 60-min-Session → vernachlässigbar für Desync-Erkennung. (Replay-Authentizität für Post-Game-Review kann bei Bedarf separat mit HMAC-SHA256 ergänzt werden — Phase 2.)
3. **Performance:** SHA-256 über den vollen 10k-Agenten-Zustand bei 20–30 Hz kostet CPU auf jedem Client und in CI; ein 64-bit-Hash ist um Größenordnungen billiger.

### 5.2 Hash-Broadcast & Vergleich

- Jeder Client berechnet pro Tick seinen `SimHash64`; **alle 10 Ticks** (≈ 3×/s) sendet er den **Ganzzustands-Hash** an den Host (`HashReport`) — **Standard bestätigt (Entscheidung Q5, 2026-08-09, Entscheider: Glieder)**.
- **Per-Region-Hashes:** bei Hash-Abweichung (Desync-Verdacht) kann der Host zusätzlich **Per-Region-Hashes alle 10 Ticks** aktivieren (Regionen = deterministische Kartenaufteilung), um den abweichenden Bereich schnell zu lokalisieren (mehr CPU, gleiche Bandbreite) — nur bei Verdacht, nicht im Dauerbetrieb (Q5).
- Host vergleicht die Hashs aller Clients pro Berichts-Tick. Abweichung → `DesyncReport` an alle + Log-Eintrag (Tick, betroffene Clients, erwarteter/aktueller Hash).
- **Hash-Verifikation beim Resume:** Derselbe `SimHash64` sichert auch das Laden von Save-Dateien ab (Datei-Hash vs. lokal nachgerechneter Hash, §12.6) — Erweiterung aus Q2/Save & Resume.
- Bandbreite: 8 B × 3/s × 8 Spieler ≈ 0,2 kbit/s — vernachlässigbar (§7.3).
- Der Hash ist **deterministisch über Plattformen** — die CI vergleicht Windows- und Linux-Runner-Hashes (ADR-006, §11.1).

### 5.3 Replay-Aufzeichnung (Eingabe-Log)

- **Replay-Log = Eingabe-Log:** vollständige, geordnete Sequenz aller konsolidierten Tick-Eingaben inkl. Control-Frames ab Tick 0. Nur Eingaben — **keine** Agenten-/Weltzustände (Agenten-Verhalten ist über den Tick-Hash verifiziert, nicht über Log-Einträge).
- Jeder Client führt lokal eine Kopie (in-memory + persistiert in **SQLite**, ADR-006); Export als **JSON** am Partieende (ADR-006: Replay-Format).
- Log-Größe: 60 min × 30 Ticks × (8 B Header + Befehle, typisch < 32 B) ≈ 1–2 MB — unkritisch.
- Verwendung: Desync-Analyse (welcher Tick, welcher Client, welche Eingabe), Late-Join/Resync (§5.4), Post-Game-Review (§9.2), M7-Lasttests.

### 5.4 Reconnect/Resync aus Replay

- **Auslöser:** Hash-Abweichung (Desync) oder Wiederbeitritt nach Verbindungsverlust.
- **Verfahren (kein Weltzustand-Transfer, feste Regel):**
  1. Host sendet dem betroffenen Client das Eingabe-Log ab Tick 0 (bzw. ab letztem Checkpoint).
  2. Client spielt die Simulation **headless im Fast-Forward** nach (deterministisch, gleicher Seed → gleicher Zustand).
  3. Client verifiziert seinen `SimHash64` am aktuellen Tick gegen die Hashs der anderen Clients.
  4. Bei Übereinstimmung: Wiedereinstieg über `ControlFrame PlayerJoined`; sonst zweiter Versuch → **Eskalation (Entscheidung Q3, 2026-08-09, Entscheider: Glieder): betroffenen Client trennen, die Partie läuft für die übrigen weiter**. Abbruch nur bei **Host-Desync** (→ Host-Migration, §6) oder wenn **> 50 % der Clients** desynct sind (§10, §13/Q3).
- **Kein Zustand-Snapshot-Transfer:** Der Tick-0-Zustand ist durch den Seed vollständig bestimmt (§8.2), alles danach durch das Eingabe-Log. Damit bleibt „NIE Weltzustand" ausnahmslos gültig.
- **Fast-Forward-Performance** (60-min-Session → Join-Zeit) wird über **Log-Checkpoints** begrenzt — dieselbe Snapshot-/Checkpoint-Technik wie Save & Resume (§12); die Ladezeit ist damit Implementierungs-/Optimierungsthema, keine offene Design-Frage mehr.

---

## 6. Host-Migration

### 6.1 Zustand & Rollenmodell

- Der **Sim-Zustand ist auf allen Clients identisch** (Determinismus). Der Host hält **keinen** Sonderzustand der Simulation.
- Host-Rolle = Transport/Session: Lobby-Verwaltung, Eingabe-Konsolidierung, Eingabe-Log-Archiv, Hash-Vergleich, Control-Frames. Das ist **reine Rollen- und Datenvermittlung** — daher ist Migration keine Zustandsübertragung, sondern eine **Rollenübergabe**.

### 6.2 Verfahren

1. Clients erkennen Host-Ausfall über Heartbeat-Timeout (§10.2) → Sim pausiert deterministisch (Control-Frame `PlayerDisconnected(HostId)` am zuletzt verarbeiteten Tick, §8.3).
2. **Deterministische Wahl des neuen Hosts:** niedrigste SteamID unter den verbleibenden Spielern. Keine Abstimmung, kein Rennen — alle Clients kommen unabhängig zum selben Ergebnis (kein Split-Brain, §10.5).
3. **Übergabe-Tick T\* = letzter gemeinsam verarbeiteter Tick** — alle Clients haben dafür identischen Zustand und identisches Eingabe-Log.
4. Der neue Host injiziert `ControlFrame HostMigration` an Tick T\*+1 (deterministisch von allen verarbeitet) und übernimmt ab T\*+1 das Sammeln/Broadcasten der Eingaben.
5. Das Eingabe-Log des alten Hosts ist bei allen Clients bereits vollständig vorhanden — nichts muss nachgeliefert werden.
6. Reconnect des alten Hosts (falls gewollt) läuft als normaler Late-Join (§5.4).

### 6.3 Determinismus beim Übergang

- Migration selbst ist **kein Sim-Ereignis** außer dem `ControlFrame HostMigration` — alle Clients verarbeiten denselben Frame am selben Tick, der Zustand bleibt bit-identisch.
- Lobby-seitig übernimmt der neue Host die Lobby-Ownership (Steam-API `SetLobbyOwner`).
- **Absicherung/Härtung** (Edge-Cases, parallele Ausfälle, Migration unter Last) ist laut [[Projektplan]] Phase-2-Thema („Host-Migration-Absicherung"); der MVP (M7) liefert das Grundverfahren inkl. Tests (§11).

---

## 7. Skalierung

### 7.1 Spieler (2–8)

- 2–8 Spieler (Lobby-Limit 8 inkl. Host). Star-Topologie: der Host ist der einzige Verstärker — bei Eingaben von wenigen Bytes/Tick ist er kein Flaschenhals (§7.3).
- Sitzordnung (`PlayerId` 0–7) wird beim Start-Sync deterministisch festgelegt (Sortierung nach SteamID) — stabil über die ganze Session, Grundlage für die Eingabe-Sortierung (§2.2).

### 7.2 SIM-Bewohner 10k+ & Agent-LOD

- **Jeder Bewohner ist ein eigener Agent** mit festem deterministischem Seed (Gesamtkonzept §2.2a); Ziel **10.000+ Bewohner** auf Mid-Hardware.
- **Agent-LOD (deterministisch, Entscheidung Q1, 2026-08-09, Entscheider: Glieder):** **3 Stufen** — (1) **voll: 30 Hz** in Spielernähe (~200 m), (2) **reduziert: 10 Hz** (~600 m), (3) **abstrakt: 2 Hz** in der Ferne. Gleiche Ergebnisse durch deterministischen Scheduler, nur weniger Detail-Ticks (Gesamtkonzept §2.2a).
- **LOD-Grenzen/Wechsel ausschließlich tick-basiert** (deterministische Agenten-Positionen → deterministische LOD-Entscheidung an Tick-Grenzen); keine Echtzeit-/Frame-Zeit in der LOD-Logik (Q1).
- Performance: `struct`-Agenten, keine Allokationen im Tick, Sub-Tick 10 Hz (§2.1). Agenten werden **nie** über das Netz übertragen.

### 7.3 Bandbreiten-Budget

| Strom | Größe | Worst Case (8 Spieler) |
|-------|-------|------------------------|
| `InputFrame` | ~8 B Header + ~16 B/Befehl | 30 Hz × 8 × 24 B ≈ **5,8 kbit/s** (Client), Host-Relay ≈ 46 kbit/s |
| `HashReport` | 8 B | 3/s × 8 × 8 B ≈ **0,2 kbit/s** |
| `InputLogChunk` (Resync) | einmalig | 60-min-Log ≈ 1–2 MB einmalig |
| Heartbeat/Overhead | < 1 kbit/s | vernachlässigbar |

- **Ziel: < 16 kbit/s sustained pro Client** — locker erfüllt; Netz ist kein Engpass, CPU (Sim) ist der Engpass (M7-Perf-Budget).

---

## 8. Session-Lifecycle

### 8.1 Lobby-Phasen

```
Create Lobby → Join (Metadaten/Version prüfen) → ReadyUp (alle bereit)
→ StartSync (Tick 0) → Running → [Pause/Resume] → End (Replay-Export, Stats)
```

- Host verwaltet die Phasen; alle Phasenwechsel außerhalb des Sim laufen über Steuerungsnachrichten, **innerhalb** des Sim nur als `ControlFrame` an gebundenen Ticks.
- i18n DE/EN: alle UI-Texte des Lifecycles (Einladungen, Fehler, Status) über das i18n-System (ADR-004, hartes Gate) — keine hardcodierten Strings.

### 8.2 Spielstart-Sync

- Beim Lobby-Erstellen wird der **Master-Seed** festgelegt (MVP: Referenzkarte = fester Seed; Phase 2: Mapgenerator-Seed, ADR-006: seeded + deterministisch, Teil der Simulation).
- **Tick-0-Zustand ist durch den Seed vollständig bestimmt** — alle Clients erzeugen ihn lokal identisch (inkl. RNG-Seeds, §3.2), es wird kein Weltzustand übertragen.
- Ablauf: alle Clients laden deterministisch → jeder sendet `HashReport` für Tick 0 → Host vergleicht → erst bei Übereinstimmung wird die erste Eingabe freigegeben.
- `PlayerId`-Zuweisung: deterministisch (SteamID-Sortierung), siehe §7.1.

### 8.3 Pause (deterministisch)

- **Pause ist ein Sim-Ereignis:** `Pause`/`Resume` sind Control-Frames an einem konkreten Tick; alle Clients stoppen/fahren am selben Tick fort (kein Tick läuft weiter, kein Zustand driftet).
- Pause bei Spielerabfall: Host injiziert `PlayerDisconnected` am aktuellen Tick; die Session pausiert gemäß Reconnect-Politik (**Entscheidung Q2, 2026-08-09, Glieder: 60-s-Fenster, Pause während des Fensters**), bis der Spieler zurück ist (Resync, §5.4) oder die Session nach Ablauf ohne ihn fortgesetzt wird (keine KI-Übernahme im MVP). Während der Pause kann der Host jederzeit speichern (§12.3).

### 8.4 Leave/Timeout/Spielerabfall

- **Sauberer Leave:** `ControlFrame PlayerLeft` → Sim verarbeitet das Ausscheiden deterministisch: Linien/Fahrzeuge des Spielers laufen mit dem letzten Fahrplan weiter (keine KI im MVP — bewusste Nicht-Zielsetzung), sein Budget wird eingefroren; die Welt bleibt synchron.
- **Timeout/Absturz:** erkannt über Heartbeat (10.2) → wie Spielerabfall behandelt; bei Host → Host-Migration (§6).
- **Reconnect:** innerhalb des **60-s-Reconnect-Fensters** via Resync (§5.4); danach gilt der Spieler als ausgeschieden und die Partie läuft **ohne KI-Übernahme** weiter (Entscheidung Q2, 2026-08-09, Entscheider: Glieder).

---

## 9. Sicherheit

### 9.1 Anti-Cheat-Grenzen bei Lockstep (ehrliche Einordnung)

- Bei Lockstep **rechnet jeder Client die gesamte Welt** und kennt damit alles (keine Geheimnisse, kein Fog-of-War möglich — das wäre nicht lockstep-kompatibel und ist Nicht-Ziel).
- Ein Cheater kann seinen **eigenen Client patchen** (Speicher, Assembler): unbegrenztes Geld, beliebige Eingaben, Manipulation der Anzeige. Das ist ohne Server/Trusted-Compute **nicht verhinderbar** — bewusst akzeptiert (0 € Serverkosten, ADR-006). Es gibt **keine vertraulichen Sim-Daten** im Netz, die geschützt werden müssten.

### 9.2 Minimierungsmaßnahmen

1. **Eingabe-Validierung in der Simulation:** Der Sim-Kern validiert jede Eingabe deterministisch (Budget, Platzierungsregeln, Überlappung, Kapazitäten). Regelverletzende Eingaben werden **von allen Clients identisch abgelehnt** — der Sim ist die Autorität, Eingaben sind nur Anfragen. Ein Cheat, der die Regeln bricht, wirkt damit nicht.
2. **Rate-Limits:** max. `MaxCommandsPerFrame` (z. B. 64) Befehle pro Spieler und Tick; Host verwirft übermäßige Frames (Protokoll-Ebene).
3. **Replay-Review:** Alle Eingaben liegen im Eingabe-Log; Post-Game-Analyse/Anomalie-Erkennung und Report-Funktion (Phase 2) sind damit ohne zusätzliche Telemetrie möglich.
4. **Keine vertraulichen Sim-Daten:** Es existieren keine (s. o.) — nichts, was über das Netz geschützt werden müsste.

### 9.3 Steam-Auth & Transport

- **Steam-Auth:** Login via Steamworks (Ein-Klick); Session-Zugang nur für Lobby-Mitglieder; SteamID wird pro Paket geprüft (Absender ∈ Session).
- **Transport-Verschlüsselung:** SteamNetworkingSockets/SDR verschlüsselt die Pakete (Steam-Schicht); keine zusätzliche Krypto im MVP.
- **Handshake-Härten:** `ProtocolVersion`- und `SimTickRate`-Abgleich (§4.3), Session-Token gegen Fremd-Pakete.
- **Secrets:** keine Credentials/Keys im Code oder in eingecheckten Dateien (ADR-004, harte Regel); die Steam AppID ist kein Secret.

---

## 10. Fehlerbehandlung

| Fehler | Erkennung | Reaktion |
|--------|-----------|----------|
| Paketverlust | Reliable-Channel-Nachlieferung (Steam) | Verzögerung → Jitter-Puffer/Stall (§2.3); kein Zustandsverlust |
| Jitter/Reordering | Steam reliable ordered | Puffer 2–3 Ticks; `FrameSeq`-Schutz |
| Verbindungs-Timeouts | Heartbeat (2 s, 3× ausbleiben → Timeout) | Spielerabfall (§8.4); bei Host → Migration (§6) |
| Client-Absturz | Timeout + ggf. Steam-Disconnect-Event | Spielerabfall; Reconnect-Fenster 60 s (Q2) |
| Desync (Hash-Abweichung) | `HashReport`-Vergleich (§5.2) | Auto-Resync-Versuch (§5.4); bei Misserfolg Client trennen, Partie läuft weiter; Abbruch nur bei Host-Desync oder >50 % (Q3) |
| Split-Brain (zwei „Hosts") | — (konstruktiv ausgeschlossen) | Deterministische Host-Wahl über SteamID (§6.2) |
| Inkompatible Version | Handshake (§4.3) | Join-Ablehnung mit klarer i18n-Meldung |

### 10.1 Paketverlust & Jitter

- Sim-relevante Pakete laufen reliable ordered (§4.5): Verlust wird nachgeliefert, Reihenfolge bleibt erhalten; der Preis ist Verzögerung, die der Jitter-Puffer (2–3 Ticks) abfedert.
- Bei Überschreiten der Pufferung stallt die Session (Barriere, §2.3) mit sichtbarem Hinweis — nie ein Tick mit unvollständigen Eingaben.

### 10.2 Timeouts & Heartbeat

- Heartbeat alle 2 s (unreliable); 3 ausbleibende Heartbeats (= ~6 s) → Verbindung gilt als verloren.

### 10.3 Reconnect-Fenster

- **Reconnect-Fenster: 60 s** (Entscheidung Q2, 2026-08-09, Entscheider: Glieder). Während des Fensters pausiert die Session (§8.3); der Spieler kehrt per Resync zurück (§5.4). Nach Ablauf wird die Session ohne den Spieler fortgesetzt (keine KI-Übernahme im MVP). Ein „Save & Resume" während des Fensters ist möglich (§12.3).

### 10.4 Absturz eines Clients

- Wie Spielerabfall (§8.4); ist der abgestürzte Client der Host → Host-Migration (§6). Kein „Partieende durch Host-Ausfall" (Gesamtkonzept §3.3).

### 10.5 Split-Brain

- Durch die deterministische Host-Wahl (niedrigste SteamID) kommen alle Clients unabhängig zum selben Ergebnis; zwei konkurrierende Hosts sind konstruktiv ausgeschlossen. Härtung unter parallelen Ausfällen: Phase 2 (Projektplan).

---

## 11. Teststrategie

TDD-Pflicht und „keine Platzhalter" (ADR-004): Alle hier genannten Tests sind echte CI-Tests, kein Stub. CI: GitHub Actions, Windows- **und** Linux-Runner (ADR-006).

### 11.1 Deterministische Tests

- **Golden-Hash-Tests:** gleicher Seed + gleiche Eingabe-Sequenz über N Ticks (z. B. 10 000) → erwarteter `SimHash64` wird als Fixture gespeichert; jede Änderung am Sim-Kern, die Hashes verschiebt, fällt sofort auf (bewusst — Hash-Stabilität ist Vertrag).
- **Plattform-Kreuzvergleich:** identische Testfälle auf Windows- und Linux-Runner; Hashs müssen übereinstimmen (ADR-006: „Lockstep-Tests vergleichen Simulations-Hashes über N Ticks auf Windows- und Linux-Runner").
- **FixMath-Tests:** Overflow/Underflow, Division, Rundung, trigonometrische Tabellen — property-based gegen Referenzwerte.

### 11.2 N-Client-Simulation in CI

- **Headless-Sim-Instanzen** (Godot `--headless`, ADR-006) mit **Fake-Transport** (In-Memory-Queue statt Steam): N = 2…8 Instanzen erhalten identische Eingabe-Streams; nach jedem Tick werden alle `SimHash64` verglichen.
- Szenarien: 8-Spieler-Marathon (60 min simuliert, beschleunigt), Late-Join, Desync-Injektion (ein Client bekommt eine abweichende Eingabe → Desync muss erkannt und der betroffene Client identifiziert werden), Host-Migration, Reconnect.
- M5-Ausstiegskriterium „Desync-Tests grün" (Projektplan) wird hier verankert.

### 11.3 Netz-Simulation

- **Fake-Transport mit konfigurierbarer Latenz/Jitter/Loss/Reordering** (Interface-Abstraktion aus §1.2): Tests für Stall-Verhalten, Puffer, Timeouts, Reconnect-Fenster, Migration unter Verlust.
- **Echte Steam-P2P-Tests** können nicht in CI laufen (Steam-Client nötig): manuelle/geplante Test-Sessions in M5 (2–8 Spieler) und M7 (8-Spieler-Lasttests, Reconnect, Host-Migration — Projektplan M7).

### 11.4 Fuzzing

- **Eingabe-Fuzzing:** zufällige/zweckentfremdete Eingabe-Sequenzen (property-based) — der Sim-Kern darf nie crashen und nie nicht-deterministisch werden (gleiche Sequenz → gleicher Hash).
- **Netz-Fuzzing:** Pakete mit korrupten Headern/Längen/Feldern → müssen sauber verworfen werden (kein Crash, kein Zustands-Effekt).

### 11.5 Meilenstein-Anbindung

- **M2** (Lockstep-Kern): Golden-Hash-, FixMath- und 2-Client-Tests (§11.1/11.2).
- **M5** (Steam MP): N-Client-Tests + Desync-Tests grün, erste echte Steam-Sessions.
- **M7** (Stabilisierung): 8-Spieler-Tests, Reconnect, Host-Migration, Performance (10k+ Agenten, Bandbreiten-Budget §7.3), Netz-Simulation unter Loss/Jitter.

---

## 12. Save & Resume (Session-Persistenz)

*Entscheidung Q2-Erweiterung, 2026-08-09, Entscheider: Glieder — eine laufende Session muss speicherbar sein, sodass das Spiel gespeichert und **später** fortgesetzt werden kann.*

### 12.1 Ziel & Prinzip

- Die Session wird als **Save-Datei** persistiert und kann **zu einem späteren Zeitpunkt** (neue Laufzeit, ggf. anderer Rechner/andere Session) exakt dort fortgesetzt werden, wo sie unterbrochen wurde.
- Lockstep-treues Prinzip: Die Save-Datei enthält **keine** „fertige Welt", sondern (a) den **deterministischen Zustands-Snapshot** und (b) das **Eingabe-Log (Replay)** — beide zusammen machen die Fortsetzung deterministisch und verifizierbar.
- Save & Resume ist die **Verallgemeinerung des Checkpoint-/Late-Join-Mechanismus** (§5.4): Ein Resume ist formal ein Late-Join mit lokalem Zustand statt Replay-ab-Tick-0.

### 12.2 Persistenz-Format (SQLite, ADR-006)

Eine Save-Datei = **eine SQLite-Datei** (ADR-006: SQLite für lokale Persistenz) mit zwei logischen Bereichen:

1. **Zustand (State-Snapshot):**
   - Header: `SaveFormatVersion`, `ProtocolVersion`, `SimTickRate` (beim Laden hart geprüft, §12.7),
   - **Tick-Nummer** des Save-Zeitpunkts (Resume-Tick T\*),
   - **Master-Seed** (und daraus deterministisch abgeleitete Seeds, §3.2/§8.2) — der Tick-0-Zustand ist dadurch vollständig bestimmt,
   - **Sim-State als deterministischer Snapshot**: binär, Little-Endian, feste Layouts (deterministische Serialisierung, §3.5) — Sim-Zustand inkl. RNG-Zustand (gehört zum Sim-Zustand, §3.2),
   - **`SimHash64` des gespeicherten Zustands** (Verifikation, §12.6).
2. **Eingabe-Log (Replay):** vollständige, geordnete Eingabe-Sequenz inkl. Control-Frames **ab Tick 0 bzw. ab dem letzten Checkpoint** (identisch mit dem Replay-Log aus §5.3).

### 12.3 Wann gespeichert wird

- **Jederzeit durch den Host** über das Menü („Spiel speichern", i18n DE/EN): Der Host besitzt das Eingabe-Log-Archiv (§1.3) und erzeugt den Snapshot deterministisch — alle Clients haben denselben bit-identischen Zustand (§3), der Host speichert seinen lokalen Zustand.
- **Auto-Save bei Host-Migration** (§6): Vor/beim Rollenwechsel wird der Stand gesichert, damit die Partie bei späteren Problemen aus der Save-Datei fortsetzbar ist.
- **Bei geplantem Ende** („Save & Quit"): automatischer Save am letzten verarbeiteten Tick, optional ergänzt um den JSON-Replay-Export (§3.5).

### 12.4 Fortsetzen (Resume)

- **Laden:** Datei auswählen („Spiel fortsetzen", i18n DE/EN) → Header prüfen (§12.7) → **Hash-Verifikation** (§12.6) → erst dann Start.
- **Zwei Resume-Modi:**
  1. **Replay-Modus:** Simulation **ab Tick 0 (bzw. ab letztem Checkpoint) deterministisch nachspielen** aus dem Eingabe-Log (gleicher Seed → gleicher Zustand) — kein Snapshot nötig; danach Übergang in den Live-Betrieb.
  2. **Snapshot-Modus:** direkt **vom gespeicherten Zustand starten** (Tick T\*); das Eingabe-Log dient ab T\* als laufende Aufzeichnung.
- **Beide Modi enden mit Hash-Verifikation** (Erweiterung Q2: Hash-/Replay-Konsistenz **auch beim Laden** sicherstellen): der lokal nachgerechnete `SimHash64` am Resume-Tick muss mit dem in der Datei gespeicherten Hash übereinstimmen. Abweichung → **kein Resume**, klare i18n-Fehlermeldung (§12.6).
- Resume ist ein **Host-gesteuerter Vorgang**: Alle Clients laden dieselbe Datei bzw. erhalten vom Host denselben Snapshot/Log-Stand. Es gilt weiterhin **kein Weltzustand-Transfer über das Netz** — die Save-Datei ist Datei-/Archiv-Semantik (§12.2), der Sim-Zustand entsteht auf jedem Client lokal deterministisch.

### 12.5 Multiplayer-Besonderheit

- Die Save-Datei enthält die **Session-Konfiguration**: Spielerliste (SteamIDs), `PlayerId`-Sitzordnung, Seeds, Gamemode, `SimTickRate`, `ProtocolVersion` (§4.1).
- **Entscheidung (2026-08-09, Glieder): Fortsetzen mit gleicher Lobby-Struktur ist Standard und empfohlen** — gleiche Spieler, gleiche Sitzordnung → identische deterministische Zuordnung, kein Eingriff in die Sitzordnung (§7.1).
- **Neue Spieler treten als Late-Join bei** (§5.4): Sie sind nicht Teil der gespeicherten Spielerliste, spielen die Simulation ab dem Checkpoint nach und joinen live am aktuellen Tick; ihre historischen Eingaben sind deterministisch leer (leerer Frame = explizite Absichtserklärung, §2.2).
- **Abwesende Spieler beim Resume:** `PlayerId`s bleiben stabil; abwesende Spieler liefern deterministisch leere Frames (wie §2.2/§8.4), bis sie per Reconnect/Late-Join zurückkehren.
- Abweichende Spielerliste (z. B. Ersatzspieler) nur mit **expliziter Bestätigung des Hosts**; die deterministische Sitzordnung (§7.1) bleibt maßgeblich.

### 12.6 Integrität & Checksummen

- **Datei-Integrität:** **SHA-256**-Checksumme über die gesamte Save-Datei (Erkennung von Korruption/Manipulation beim Laden).
- **Sim-Konsistenz:** `SimHash64` des Zustands-Snapshots (§12.2) — beim Resume gegen den lokal berechneten Hash geprüft (§12.4).
- **Prüfablauf beim Laden:** (1) Header/Format-Version prüfen → (2) SHA-256 der Datei prüfen → (3) Zustand laden bzw. Replay nachspielen → (4) `SimHash64`-Abgleich am Resume-Tick → erst dann Freigabe für den Live-Betrieb. Jede Stufe schlägt fehl → **kein Resume**, i18n-Fehlermeldung (DE/EN), Log-Eintrag.

### 12.7 Speicherformat-Versionierung

- `SaveFormatVersion` ist Teil des Datei-Headers und wird **hart geprüft**: inkompatible Version → Laden abgelehnt mit klarer i18n-Meldung (analog `ProtocolVersion`-Handshake, §4.3).
- Zusätzlich werden `ProtocolVersion` und `SimTickRate` in der Datei geführt und beim Laden geprüft (Abweichung → Ablehnung; Desync-Schutz durch Versions-Mismatch, §3.5).
- Save-Migration älterer Formate: **nicht im MVP** (nur Ablehnung + Hinweis), optional Phase 2.

### 12.8 i18n

- Die Simulations-/Netz-Schicht enthält **keine UI-Texte** (i18n dort nicht relevant).
- Alle **Save-/Load-Menü-Texte** („Spiel speichern", „Spiel fortsetzen", „Speichern nicht möglich", „Save-Datei beschädigt", „Inkompatible Version") laufen über das i18n-System **DE/EN** (ADR-004, hartes Gate) — keine hardcodierten Strings.

### 12.9 Verhältnis zu Replay/Resync & Tests

- Das Eingabe-Log der Save-Datei ist **dasselbe Log** wie in §5.3; Save & Resume teilt sich die Infrastruktur mit Late-Join/Resync (Checkpoints, Hash-Verifikation).
- **Neue CI-Tests (§11):** Save→Load-Roundtrip (speichern bei Tick T, laden, N Ticks weiterspielen → identischer `SimHash64` wie ohne Save/Load), Korruptions-Test (beschädigte SHA-256 → Ablehnung), Versions-Test (inkompatible `SaveFormatVersion` → Ablehnung), N-Client-Resume (§11.2: alle Clients laden denselben Save → identische Hashs).

---

## 13. Offene Design-Fragen (Freigabe-Runde Q1–Q5)

Alle Fragen dieser Runde sind **ENTSCHEIDEN** (2026-08-09, Entscheider: Glieder) und in den jeweiligen Abschnitten eingearbeitet:

1. **Agent-LOD-Konfiguration — ENTSCHIEDEN (2026-08-09, Entscheider: Glieder):** 3 Stufen (voll 30 Hz in Spielernähe ~200 m / reduziert 10 Hz ~600 m / abstrakt 2 Hz Ferne), Grenzen tick-basiert → §7.2.
2. **Reconnect- & Pause-Politik — ENTSCHIEDEN (2026-08-09, Entscheider: Glieder):** Reconnect-Fenster 60 s, Pause während des Fensters, danach Fortsetzen ohne KI-Übernahme → §8.3/§8.4/§10.3. **Erweiterung beschlossen:** Save & Resume (Session-Persistenz) → §12.
3. **Desync-Eskalation — ENTSCHIEDEN (2026-08-09, Entscheider: Glieder):** betroffenen Client trennen, Partie läuft weiter; Abbruch nur bei Host-Desync (→ Host-Migration) oder >50 % desyncte Clients → §5.4/§10.
4. **Tick-Rate final — ENTSCHIEDEN (2026-08-09, Entscheider: Glieder):** 30 Ticks/s fest (konsistent mit ODF-1/GDD); Agenten-Sub-Tick bleibt 10 Hz → §2.1.
5. **Hash-Umfang/-Intervall — ENTSCHIEDEN (2026-08-09, Entscheider: Glieder):** Ganzzustands-Hash alle 10 Ticks als Standard; Per-Region-Hashes alle 10 Ticks nur bei Verdacht aktivierbar; Hash-Verifikation auch beim Laden von Save-Dateien (Q2-Erweiterung) → §5.2/§12.6.

---

## Verlinkungen

- [[README|Projekt-README]]
- [[Gesamtkonzept|Gesamtkonzept]] (insb. §3 Multiplayer-Architektur, §2.2a SIM-Bewohner)
- [[Projektplan|Projektplan]] (M2/M5/M7, D4)
- [[Backlog|Backlog]]
- [[60-Decisions/ADR-005_OpenMotion|ADR-005 — Projektgründung]]
- [[60-Decisions/ADR-006_OpenMotion-Tech-Stack|ADR-006 — Tech-Stack (freigegeben)]]
- [[60-Decisions/ADR-004_Arbeitsregeln|ADR-004 — Arbeitsregeln]]
