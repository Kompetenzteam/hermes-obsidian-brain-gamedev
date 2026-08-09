---
tags: [project, concept, gdd]
project: OpenMotion
status: draft
date: 2026-08-09
---
# OpenMotion — Gesamtkonzept

> Status: **DRAFT — wartet auf manuelle Freigabe durch Glieder** (Freigabe-Regel ADR-004)
> Autor: Hermes (Lead Gamedesigner, Senior Lead Game Developer, Senior Networking Specialist)
> Referenz-Spielgefühl: Cities in Motion 2 — **kein 1:1-Klon**, eigenes Art-Konzept, eigene Umsetzung.

---

## 1. Vision (Elevator Pitch)

**OpenMotion** ist ein moderner Nahverkehrs-Simulator: Du baust und betreibst das öffentliche Verkehrsnetz einer wachsenden Stadt — Busse, Trams und U-Bahnen, Linien, Fahrpläne, Wirtschaft. Das Besondere: **alles zusammen mit bis zu 8 Spielern in einer gemeinsamen, garantiert desync-freien Welt** — die Schwachstelle des Referenzspiels ist unser Kernfeature. Eigene prozedurale Karten, SteamWorkshop und komplette Steam-Anbindung runden das Paket ab.

**Ein Satz:** „CIM2-Spielgefühl, aber Multiplayer, der einfach funktioniert."

---

## 2. Spielkonzept (Core Loop)

### 2.1 Der Spieler-Zyklus („Was tue ich jede Minute?")
1. **Stadt beobachten:** Wo entstehen Bedarfe? (Wohngebiete → Gewerbe/Industrie, Pendlerströme)
2. **Netz planen:** Haltestelle setzen, Linie ziehen, Fahrzeug zuweisen
3. **Fahrplan justieren:** Takt, Einsatzzahlen, Preise
4. **Wirtschaft im Blick:** Budget, Ticketpreise, Subventionen, Kredite
5. **Optimieren:** Fahrgastzahlen, Auslastung, Konflikte mit Mitspielern lösen (oder provozieren)

### 2.2 Kernmechaniken (MVP)
| Mechanik | Beschreibung |
|----------|--------------|
| **Bausystem (integral)** | Spieler baut die Verkehrsinfrastruktur aktiv: Straßen, Schienen, Haltestellen, Depots, (Tunnel/Brücken) — Teil des Kernloops, kein Abziehbild |
| Linienplanung | Haltestellen, Routen über Straßennetz, Umlaufzeiten |
| Verkehrsmittel | Bus (Straße), Tram (Schiene), U-Bahn (Tunnel/Untergrund) — jeweils eigene Kosten/ Kapazität/Geschwindigkeit |
| Wirtschaft | Ticketpreise, Betriebskosten, Fahrzeugkauf, Kredite, Subventionen |
| **SIM-Bewohner (einzeln simuliert)** | **Jeder Bewohner ist ein eigener Agent** mit Ziel, Tagesablauf, Umsteigeverhalten, Zufriedenheit — determinstisch simuliert (Lockstep-kompatibel) |
| **Wuselfaktor** | Bewohner tummeln sich sichtbar an Haltestellen: Warten, Ein-/Aussteigen, Wuseln — die Stadt fühlt sich lebendig an |
| Stadt-Wachstum | Nachfrage steigt mit Netzqualität (Wohn/Gewerbe-Balance) |
| Multiplayer (Kern!) | 2–8 Spieler, gemeinsame Stadt, gemeinsame Wirtschaft, getrennte Budgets |

### 2.2a SIM-Bewohner & Wuselfaktor — technische Einordnung (Lead)
- **Simulation:** Jeder Bewohner = Agent mit festem deterministischem Seed (Lockstep-konform). Sim-Tick ~10–20 Hz, Rendering interpoliert dazwischen (Standard in Sim-Spielen).
- **Skalierung:** Agent-LOD — volle Simulation in Spielernähe, entfernte Bereiche abstrahiert (gleiche Ergebnisse durch deterministischen Scheduler, nur weniger Detail-Ticks). Ziel: **10.000+ Bewohner** auf Mid-Hardware.
- **Wuselfaktor-Rendering:** Instanziertes Crowd-Rendering (ein Mesh, viele Instanzen), LOD-Imposter in der Ferne → Haltestellen wirken belebt ohne Perf-Einbruch.
- **Multiplayer-Auswirkung:** Agenten-Log wird Teil des Replay-Logs (größer, aber deterministisch); Tick-Hash prüft alle Agenten mit.

### 2.2b Bausystem — Scope-Einordnung (ENTSCHEIDEN: Stufe 1, 2026-08-09)
**Entscheidung Glieder: Stufe 1 — Verkehrs-Infrastruktur-Bau.** Der Spieler baut das komplette Verkehrsnetz; die Stadt wächst automatisch aus der Netzqualität.

**Konkret baut der Spieler (Stufe 1):**
- **Straßen** (für Busse, Grundlage des Straßennetzes)
- **Schienen** (Tram oberirdisch, U-Bahn als Tunnel/Untergrund)
- **Haltestellen** (Bushaltestellen, Tram-/U-Bahn-Stationen)
- **Depots** (Abstell- und Wartungsstandorte für Fahrzeuge)
- **Tunnel/Brücken** (Verbindungen, topografische Lösungen)
- **Signale/Infrastruktur-Details** (Phasen 2+)

**Stadt-Wachstum entlang Transportwegen (2026-08-09, Anforderung Glieder):** Die Stadt wächst nicht nur abstrakt aus der Netzqualität, sondern **sichtbar und direkt entlang der gebauten Wege**: Baut der Spieler Straßen, Schienen und Gehwege, entstehen an diesen Transportwegen automatisch Wohn- und Gewerbegebäude — dynamisches Wachstum entlang der gebauten Infrastruktur, keine manuelle Gebäude-Platzierung.

**NICHT im Scope (Stufe 2 bewusst abgelehnt):** Zonen-Ausweisung, Gebäude-Platzierung, Stadt-Dienstleistungen. Stadtwachstum reagiert automatisch auf Netzqualität (Wohn/Gewerbe entstehen, Bewohner ziehen zu).

### 2.3 Spielmodi
- **Solo:** Klassisches Einzelspieler-Erlebnis
- **Kooperativ (Empfehlung):** Alle Spieler, EIN gemeinsames Stadtbudget — zusammen aufbauen
- **Kompetitiv:** Getrennte Budgets, ein Verkehrsmarkt, Konkurrenz um Linien/Fahrgäste

---

## 3. Multiplayer-Architektur (Kern-USP, NDD-Kurzfassung)

### 3.1 Problem
CIM2-Multiplayer litt unter Desyncs: Jeder Client rechnete die Simulation selbst, Abweichungen führten zu auseinanderlaufenden Welten.

### 3.2 Lösung: Deterministic Lockstep (Industrie-Standard für RTS/Sim)
- **Ein einziger Simulationskern** läuft auf jedem Client **bit-identisch** (Fixed-Point-Mathematik, kein float)
- Übertragen werden **nur Spielereingaben** („Linie X angelegt, Fahrzeug Y gekauft"), NICHT der Weltzustand
- Alle Clients rechnen denselben deterministischen Tick (z.B. 20 Ticks/s) → **keine Abweichung möglich**
- **Replay-System:** Jede Partie ist ein Eingabe-Log → Desyncs werden automatisch erkannt (Hash der Sim pro Tick) und sind debugbar
- **Host-Migration:** Fällt der Host aus, übernimmt ein anderer Client nahtlos
- **Netz:** Steamworks P2P (Steam Datagram Relay als Fallback), kein Dedicated Server im MVP nötig → **0 € Serverkosten**

### 3.3 Warum das die CIM2-Probleme löst
| CIM2-Problem | OpenMotion-Lösung |
|--------------|-------------------|
| Desync durch float-Abweichung | Fixed-Point-Math, bit-identische Ticks |
| Welt divergiert unbemerkt | Tick-Hash-Vergleich, sofortige Erkennung |
| Kein Wiederanlauf nach Desync | Replay + Resync aus Eingabe-Log |
| Host-Ausfall = Partieende | Host-Migration |

---

## 4. Art-Konzept (Kurzfassung — Details: [[Art-Konzept]])

**ENTSCHEIDEN (Glieder, 2026-08-09): Richtung C — „Semi-realistisch, eigene Farbwelt"**
- Realistische 3D-Formen, aber **eigene warme, pastellige Farbwelt** (deutlich heller/wärmer als Referenz)
- Eigene Modelle/Assets, keine CIM2-Assets; Linienfarben = leuchtende Spielerfarben
- Konsequenz: höherer Asset-Aufwand, mittlere Performance → MVP-Assets low-poly, LOD von Anfang an (Lead-Gegenmaßnahme)

---

## 5. Logo (Kurzfassung)

4 Design-Familien generiert („The Route", „The Tram", „The Node", „The Streak") — Auswahl durch Glieder. Dateien in `assets/logo/`.

---

## 6. Technologie (Empfehlung — ADR-006 wird separat vorgelegt)

| Schicht | Empfehlung | Begründung |
|---------|-----------|------------|
| Engine | **Godot 4** (Open Source, MIT) | 0 € Lizenz, Linux-Export nativ, starke 2D/3D-Pipeline, C#/GDScript, Headless-Modus für Server/CI |
| Sprache | GDScript + C# (Sim-Kern in C#) | Performance + Typsicherheit im kritischen Lockstep-Kern |
| Netzwerk | Godot Steamworks (GDExtension) + Steam Datagram Relay | Direkte Steam-Integration, kostenlos, P2P |
| Daten | JSON/binary save + Workshop-UGC | Einfach, Steam-konform |
| CI/CD | GitHub Actions (Windows + Linux Build) | Kostenlos, reproduzierbare Builds |

---

## 7. Steam-Integration
- **Auth:** Steamworks Login (Ein-Klick)
- **Multiplayer:** Steam Lobbies + P2P
- **Workshop (Phase 2):** Maps + Mods via Steam UGC
- **Achievements:** Basis-Set im MVP (Phase 2 komplett)
- **Vertrieb:** Early Access, Einmalkauf, Steam Direct 100 $ (nur mit Freigabe)

---

## 8. Wirtschaftsmodell / Monetarisierung
- Einmalkauf (Early Access mit vergünstigtem Preis, steigt Richtung 1.0)
- Keine Mikrotransaktionen, kein Pay-to-Win, keine Lootboxen
- Workshop-Inhalte können (optional, Phase 3) Paid-DLC via Steam-Pipeline sein — **Entscheidung später, mit Freigabe**

---

## 9. Qualität & Nicht-Ziele (MVP)
**Qualitätsziele:** 60 FPS @ 1080p auf Mid-Hardware, 8-Spieler-Session 60+ min desync-frei, i18n DE/EN vollständig, keine Platzhalter (ADR-004).

**Nicht-Ziele MVP:** kein Workshop, kein Mapgenerator, kein Tageszyklus, kein Modding-API, kein Dedicated Server, keine Konsolen-Ports.

---

## 10. Erfolgskriterien (was „gut" bedeutet)
1. 8-Spieler-Partie über 60+ min ohne Desync (Replay-verifiziert)
2. „CIM2-Moment" vorhanden: Linie bauen → Bus fährt → Fahrgäste steigen ein → Geld fließt
3. Spieler verstehen das Netz in 5 Minuten (UI/Art-Ziel)
4. EA-Release auf Steam, positive Reviews zur Multiplayer-Stabilität
5. Workshop-Community liefert Karten (Phase 2/3)

---

## 11. Risiken & Gegenmaßnahmen
| Risiko | Bewertung | Gegenmaßnahme |
|--------|-----------|---------------|
| Desync trotz Lockstep | Mittel | Replay-Hash-Checks, deterministische Math-Disziplin (kein Random ohne Seed, keine Zeitabhängigkeit) |
| Scope-Explosion | Hoch | Strikter MVP-Scope, Backlog-Disziplin, keine Feature-Creep ohne Freigabe |
| Recht (Paradox-IP) | Mittel | Eigenes Art-Konzept, keine CIM2-Namen/Assets/Sounds |
| Hobby-Budget/Zeit | Mittel | MVP-first, on-the-go Budget, Open-Source-Stack |
| Alleiniger Macher (1 Lead + Agents) | Mittel | Subagent-Parallelisierung, CI-gestützte Qualität, TDD |

---

## 12. Roadmap (Überblick)
```
M0 Konzeption   ▸ Konzept+Plan (DIESES DOKUMENT), ADR-006, GDD, NDD
M1 Boilerplate  ▸ Repo, CI, i18n-Gerüst, Headless-Build
M2 Lockstep     ▸ Simulationskern, Replay, Desync-Detection
M3 Simulation   ▸ Wirtschaft, Linien, Passagiere
M4 Vehicles     ▸ Bus, Tram, U-Bahn
M5 Steam MP     ▸ Auth, Lobby, P2P, 2–8 Spieler
M6 City         ▸ Referenzkarte, UI, i18n DE/EN
M7 Stabilisation ▸ Lasttests, Reconnect, Host-Migration
M8 Release      ▸ EA, Linux-Build, Store, Workshop-Vorbereitung
```

**Phase 2 — Mapgenerator (2026-08-09, Anforderung Glieder):** Generiert prozedural nicht nur die Karte, sondern auch **eine Stadt zum Spielen**; die Stadt wächst dynamisch entlang der gebauten Transportwege (Straßen/Schienen/Gehwege) — Gebäude entstehen automatisch an der gebauten Infrastruktur.

---

## 13. Freigabe-Liste (manuell durch Glieder)
- [x] **Gesamtkonzept freigegeben** (2026-08-09) — inkl. Bausystem Stufe 1 + SIM-Bewohner/Wuselfaktor
- [x] **Projektplan freigegeben** (2026-08-09)
- [x] **D1 Art-Richtung:** **C — Semi-realistisch, eigene Farbwelt** (2026-08-09)
- [x] **D2 Logo:** ✅ **FREIGEGEBEN (2026-08-09)** — `logo_simple_fixed.svg` (16 Pfade, farbkorrekt: Rot 5,5 %, Steam-tauglich) + Skalierungen in `assets/logo/preview/`

Nach Logo-Freigabe: ADR-006 (Tech-Stack) + GDD (detailliert) + NDD (detailliert) — jeweils erneut zur Freigabe.

---

## 14. Bausystem-Scope (ENTSCHEIDEN, 2026-08-09)

**Entscheidung: Stufe 1 — Verkehrs-Infrastruktur-Bau.** Der Spieler baut Straßen, Schienen, Haltestellen, Depots, Tunnel/Brücken. Die Stadt wächst automatisch aus der Netzqualität. Stufe 2 (kompletter Stadtbau) ist abgelehnt — kein Zonen-/Gebäude-/Dienstleistungsbau.

---

## Verlinkungen
- [[README|Projekt-README]]
- [[Projektplan|Projektplan]]
- [[Art-Konzept|Art-Konzept]]
- [[Backlog|Backlog]]
- [[60-Decisions/ADR-005_OpenMotion|ADR-005 — Projektgründung]]
