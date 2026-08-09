---
tags: [project, gdd, design]
project: OpenMotion
status: draft
date: 2026-08-09
---

# OpenMotion — Game Design Document (GDD)

> Status: **DRAFT — Freigabe durch Glieder ausstehend** (Freigabe-Regel ADR-004: keine Umsetzung vor Freigabe)
> Version: 0.1 | Datum: 2026-08-09
> Autor: Hermes (Lead Gamedesigner, Senior Lead Game Developer, Senior Networking Specialist)
> Basis: [[Gesamtkonzept]] (freigegeben), [[Projektplan]] (freigegeben), [[Backlog]] (aktiv), [[60-Decisions/ADR-005_OpenMotion|ADR-005]] (freigegeben), [[60-Decisions/ADR-006_OpenMotion-Tech-Stack|ADR-006]] (freigegeben), [[Art-Konzept]] (entschieden: Richtung C)
> Qualitäts-Gates (ADR-004): TDD + 2x-Validierung, **keine Platzhalter/Stubs**, i18n DE/EN als hartes Gate.

---

## 1. Spielvision & Kern-Loop

**OpenMotion** ist ein moderner Nahverkehrs-Simulator: Spieler bauen und betreiben das öffentliche Verkehrsnetz einer wachsenden Stadt — Busse, Trams, U-Bahnen, Linien, Fahrpläne, Wirtschaft. Kern-USP: **desync-freier Multiplayer für 2–8 Spieler** in einer gemeinsamen Welt (Deterministic Lockstep), dazu einzeln simulierte SIM-Bewohner (Ziel 10k+) und eine Stadt, die **automatisch entlang der gebauten Transportwege** wächst. Eigenes Art-Konzept (Richtung C), keine 1:1-Kopie des Referenzspiels, gleiche Bedienung.

**Ein Satz:** „CIM2-Spielgefühl, aber Multiplayer, der einfach funktioniert."

### 1.1 Kern-Loop („Was tue ich jede Minute?")
1. **Beobachten:** Stadt und Bedarfe lesen — wo entstehen Wohngebiete, Gewerbe, Pendlerströme? Wo stauen sich Fahrgäste?
2. **Planen:** Haltestellen positionieren, Linien über das Netz ziehen, Verkehrsmittel zuweisen, Takt festlegen.
3. **Bauen:** Verkehrsinfrastruktur errichten (Straßen, Schienen, Haltestellen, Depots, Tunnel/Brücken) — die Stadt reagiert mit Wachstum entlang der Wege.
4. **Betreiben:** Fahrpläne justieren (Takt, Einsatzzahlen), Preise setzen, Wirtschaft im Blick behalten (Budget, Ticketpreise, Subventionen, Kredite).
5. **Optimieren:** Fahrgastzahlen und Auslastung steigern, Zufriedenheit erhöhen, im Multiplayer Konflikte mit Mitspielern lösen (oder provozieren).

### 1.2 Kernmechaniken (MVP)
| Mechanik | Beschreibung |
|----------|--------------|
| Bausystem (integral) | Spieler baut die Verkehrsinfrastruktur aktiv: Straßen, Schienen, Haltestellen, Depots, Tunnel/Brücken — Teil des Kernloops, kein Abziehbild |
| Linienplanung | Haltestellen, Routen über das Netz, Umlaufzeiten, Takt |
| Verkehrsmittel | Bus (Straße), Tram (Schiene oberirdisch), U-Bahn (Tunnel/Untergrund) — je eigene Kosten/Kapazität/Geschwindigkeit |
| Wirtschaft | Ticketpreise, Betriebskosten, Fahrzeugkauf, Kredite, Subventionen |
| SIM-Bewohner (einzeln simuliert) | Jeder Bewohner ist ein eigener Agent mit Ziel, Tagesablauf, Umsteigeverhalten, Zufriedenheit — deterministisch (Lockstep-kompatibel) |
| Wuselfaktor | Bewohner tummeln sich sichtbar an Haltestellen: Warten, Ein-/Aussteigen — die Stadt fühlt sich lebendig an |
| Stadt-Wachstum | Automatisches Wachstum entlang gebauter Transportwege; Nachfrage steigt mit Netzqualität (Wohn/Gewerbe-Balance) |
| Multiplayer (Kern!) | 2–8 Spieler, gemeinsame Stadt, Deterministic Lockstep, Eingaben-only, Replay-Log, Tick-Hash-Desync-Erkennung, Host-Migration |

---

## 2. Spielmodi

| Modus | Budget-Modell | Regeln |
|-------|---------------|--------|
| **Solo** | Ein Spieler, ein Budget | Klassisches Einzelspieler-Erlebnis; keine Netzwerk-Abhängigkeiten, Replay-Log läuft trotzdem (Debug/Balance) |
| **Kooperativ** (Empfehlung) | **EIN gemeinsames Stadtbudget** für alle Spieler | Alle Spieler bauen zusammen am selben Netz; Bau-/Betriebskosten gehen ins gemeinsame Budget; keine Konkurrenz um Fahrgäste |
| **Kompetitiv** | **Getrennte Budgets** pro Spieler | Ein gemeinsamer Verkehrsmarkt: Konkurrenz um Linien, Haltestellen und Fahrgäste; Einnahmen fließen nur in das eigene Budget |

**Gemeinsame Regeln (alle Modi):**
- 2–8 Spieler im Multiplayer; Solo = 1 Spieler.
- Deterministic Lockstep: Übertragen werden nur Spielereingaben, kein Weltzustand; jeder Client rechnet bit-identisch (Fixed-Point, keine floats in der Simulation).
- Replay-Log jeder Partie (Eingabe-Log) → Grundlage für Desync-Erkennung (Tick-Hash), Debugging und Replay-Ansicht.
- Host-Migration: Fällt der Host aus, übernimmt ein anderer Client nahtlos.
- Linienfarben = leuchtende Spielerfarben (Multiplayer-Lesbarkeit); im Solo wählt der Spieler Linienfarben frei aus der Palette.
- Netzwerk: Steam P2P via Steam Datagram Relay (NAT-Relay-Fallback), kein Dedicated Server im MVP (0 € Serverkosten).

**Offene Design-Frage (ODF-3):** Kompetitiver Modus — konkrete Konkurrenz-Regeln (Linien-Exklusivität, Mehrfachbedienung derselben Haltestelle durch mehrere Spieler, Fahrgast-Verteilung bei parallelen Angeboten) — siehe Kapitel 15.

---

## 3. Bausystem (Stufe 1)

**Freigegebener Scope (Glieder, 2026-08-09): Stufe 1 — Verkehrs-Infrastruktur-Bau.** Der Spieler baut das komplette Verkehrsnetz; die Stadt wächst automatisch aus der Netzqualität und entlang der gebauten Wege. **Kein** Zonen-/Gebäude-/Dienstleistungsbau (Stufe 2 bewusst abgelehnt).

### 3.1 Baubare Elemente
| Element | Beschreibung | Anbindung |
|---------|--------------|-----------|
| **Straßen** | Grundlage des Straßennetzes für Busse; erzeugen entlang ihres Verlaufs automatisch Gebäude und Gehwege | Muss ans bestehende Straßennetz anschließen (Stummel ohne Anschluss nicht baubar) |
| **Schienen** | Tram oberirdisch; U-Bahn als Tunnel/Untergrund | Anschluss ans Schienennetz; Tram-Trassen können straßenbegleitend oder eigenständig geführt werden |
| **Haltestellen** | Bushaltestellen (Straße), Tram-/U-Bahn-Stationen (Schiene/Tunnel) | Müssen an das jeweilige Netz (Straße/Schiene) angeschlossen sein; sind Einstiegspunkte für SIM-Bewohner |
| **Depots** | Abstell- und Wartungsstandorte für Fahrzeuge | Müssen an das Straßen-/Schienennetz angebunden sein, damit Fahrzeuge ein- und ausrücken können |
| **Tunnel/Brücken** | Topografische Verbindungen (z. B. U-Bahn-Tunnel, Straßen-/Schienenbrücken über Hindernisse) | Verbinden zwei Netzabschnitte; ermöglichen Wege unabhängig vom Gelände |

**Signale und Infrastruktur-Details** (z. B. Weichensteuerung, Signalanlagen): Phase 2+ — **Offene Design-Frage** zur Detailtiefe (siehe ODF-Liste, wird nach MVP entschieden).

### 3.2 Platzierungsregeln
- Alle Elemente werden als Netzwerk-Elemente platziert; jedes neue Element muss **mindestens einen Anschluss** an das bestehende Netz (oder einen gültigen Startpunkt) haben — keine isolierten Fragmente.
- Haltestellen liegen am Netz (Straße/Schiene) und definieren mögliche Linienhalte.
- Depots sind Voraussetzung für den Fahrzeugeinsatz: Jede Linie benötigt mindestens ein erreichbares Depot.
- Tunnel/Brücken haben höhere Baukosten als ebenerdige Trassen (Ausgleich für topografische Vorteile).
- Baukosten: qualitativ gestaffelt — Straße < Schiene < Tunnel/Brücke; Haltestellen/Depots als Einzelkosten. Konkrete Zahlen: Balancing (siehe Kapitel 11).

### 3.3 Kosten & Anbindung
- Baukosten werden beim Platzieren sofort vom Budget abgezogen (gemeinsames Budget in Koop, eigenes in Kompetitiv).
- Betriebskosten entstehen pro Haltestelle/Linie/Depot über die Zeit (Unterhalt).
- Entfernte oder schlecht angebundene Elemente erzeugen keine Nachfrage — Anbindung an Wohn-/Gewerbegebiete (automatisch entstandene) ist der Treiber (siehe Kapitel 4).

---

## 4. Stadt-Wachstum

**Anforderung Glieder (2026-08-09):** Die Stadt wächst **sichtbar und direkt entlang der gebauten Transportwege** — nicht nur abstrakt aus Netzqualität. Baut der Spieler Straßen, Schienen und Gehwege, entstehen an diesen Wegen automatisch Wohn- und Gewerbegebäude. **Dynamisches Wachstum entlang der gebauten Infrastruktur, keine manuelle Gebäude-Platzierung.**

### 4.1 Wachstumsprinzip
- **Wohn-/Gewerbegebäude entstehen automatisch** an gebauten Transportwegen (Straßen, Schienen, Gehwege), sobald die Anbindungsqualität einen Schwellwert erreicht.
- Gebäude erscheinen dynamisch (kein Platzierungs-UI), verdichten sich über die Zeit und ziehen Bewohner an.
- Die Balance zwischen Wohn- und Gewerbegebäuden bestimmt Pendlerströme: Wohnen → Gewerbe/Industrie am Morgen, retour am Abend (Basis für Nachfrage an Haltestellen).

### 4.2 Wachstums-Trigger & -Formel (qualitativ)
Wachstumsrate je Standort ≈ f(Erreichbarkeit, Netzqualität, Kapazitätsreserve, Zufriedenheit, Zeit seit Anbindung):

- **Erreichbarkeit:** Distanz des Standorts zur nächsten Haltestelle (Gehwegnähe) — kurze Wege wachsen schneller.
- **Netzqualität:** Takt der bedienenden Linien, Anzahl Linien, Reisezeiten ins Gewerbe-/Stadtzentrum.
- **Kapazitätsreserve:** Freie Plätze in Fahrzeugen — überlastete Linien bremsen weiteres Wachstum (oder erzeugen Zufriedenheits-Druck).
- **Zufriedenheit der Bewohner:** Hohe Zufriedenheit verstärkt Zuzug; Unzufriedenheit kann Wegzug auslösen.
- **Zeit:** Wachstum braucht Zeit seit Anbindung (Verzögerung als natürlicher Rhythmus).

Konkrete Parameter/Schwellwerte werden in der Balance-Phase (M3) kalibriert — **keine finalen Zahlen im GDD** (siehe Kapitel 11).

### 4.3 Abgrenzung & Phase 2
- **Kein** Zonen-Ausweisung, **keine** Gebäude-Platzierung durch Spieler, **keine** Stadt-Dienstleistungen (Stufe 2 bewusst abgelehnt).
- **Phase 2 (Mapgenerator):** Der prozedurale Generator (seeded, deterministisch über Clients, Lockstep-konform) erzeugt nicht nur die Karte, sondern **eine Stadt zum Spielen**; danach wächst die Stadt dynamisch entlang der gebauten Transportwege weiter (gleiche Mechanik wie MVP).

---

## 5. SIM-Bewohner

**Jeder Bewohner ist ein eigener Agent** mit festem deterministischem Seed (Lockstep-konform). Ziel: **10.000+ gleichzeitig simulierte Bewohner** auf Mid-Hardware.

### 5.1 Agent-Lebenszyklus
- **Geburt/Zuzug:** Bewohner entstehen durch Stadtwachstum (Zuzug in neue Wohngebäude) — deterministisch über den Agenten-Seed.
- **Wohnen:** Jeder Agent hat eine feste Wohnadresse (Gebäude).
- **Job/Schule:** Jeder Agent hat ein Ziel (Arbeitsplatz/Schule im Gewerbe) — Zuordnung deterministisch, wechselt bei Karriere-/Bedarfssimulation nur regelbasiert.
- **Freizeit:** Zusätzliche Gelegenheitsziele (Einkaufen, Erholung) mit eigenen Zeitfenstern.
- **Wegzug:** Bei anhaltend niedriger Zufriedenheit oder fehlender Erreichbarkeit kann ein Agent wegziehen (regelbasiert, deterministisch).

### 5.2 Tagesablauf
- Agenten folgen einem Tagesrhythmus: morgens zur Arbeit/Schule, mittags/abends Freizeit- oder Einkaufsziele, nachts zu Hause.
- Reisekette: **Wohnung → Gehweg → Haltestelle → Linie → (ggf. Umstieg) → Haltestelle → Gehweg → Ziel** und zurück.
- Jede Reise erzeugt Nachfrage an den genutzten Haltestellen/Linien und trägt zum Wuselfaktor bei.

### 5.3 Reise-Entscheidung (Route & Umsteigen)
- Zielwahl: Nächstgelegenes passendes Ziel oder präferiertes Ziel (regelbasiert, deterministisch).
- Routenwahl qualitativ: Gewichtung von **Reisezeit, Anzahl Umstiege, Wartezeit, Zuverlässigkeit (Verspätungshistorie) und Ticketpreis**.
- Umsteigen: An Haltestellen mit mehreren Linien entscheidet der Agent regelbasiert über die nächste Linie; Wartezeiten entstehen real an der Haltestelle (Wuselfaktor).
- Alle Entscheidungen nutzen ausschließlich den deterministischen Seed — keine zeit- oder plattformabhängigen Werte (Lockstep-Disziplin).

### 5.4 Zufriedenheit
- Beeinflusst durch: Wartezeit, Verspätungen, Überfüllung, Anzahl Umstiege, Gesamtreisezeit im Verhältnis zur Erwartung.
- Wirkung: Zufriedenheit steuert Stadtwachstum (Kapitel 4.2) und Passagieraufkommen; unzufriedene Agenten wechseln Route oder ziehen weg.
- Aggregiert als Stadt-/Linien-Kennzahl im Wirtschafts-/Stadtpanel (siehe Kapitel 9).

### 5.5 Wuselfaktor-Visualisierung
- Bewohner **tummeln sich sichtbar an Haltestellen**: Warten, Ein-/Aussteigen, Wuseln — die Stadt fühlt sich lebendig an.
- Technik: instanziiertes Crowd-Rendering (ein Mesh, viele Instanzen), LOD-Imposter in der Ferne → belebt ohne Perf-Einbruch.
- Stilisierte Figuren (Art-Konzept Richtung C), Linien-/Ziel-unabhängig eingefärbt.

### 5.6 Skalierung & Lockstep
- **Agent-LOD:** Volle Simulation in Spielernähe, entfernte Bereiche abstrahiert — gleiche Ergebnisse durch deterministischen Scheduler, nur weniger Detail-Ticks.
- Sim-Tick der Agenten ~10–20 Hz, Rendering interpoliert dazwischen (Standard in Sim-Spielen).
- Agenten-Log ist Teil des Replay-Logs (größer, aber deterministisch); Tick-Hash prüft alle Agenten mit.
- Performance-Budget: `struct`-Typen, keine Allokationen im Tick (ADR-006).
- **ODF-1:** Finale feste Tick-Rate des Lockstep-Kerns (ADR-006 nennt z. B. 30 Ticks/s; Agenten-Detail 10–20 Hz) — siehe Kapitel 15.

---

## 6. Wirtschaft

### 6.1 Einnahmen
| Quelle | Beschreibung |
|--------|--------------|
| **Ticketpreise** | Vom Spieler je Linie oder global festlegbar; Erlös pro befördertem Fahrgast |
| **Subventionen** | Regelmäßige Zuschüsse (z. B. pro Linie oder pauschal), stabilisieren schwache Netze |
| **Zusätzliche Einnahmen** | Nicht im MVP (z. B. Werbung) — **offen für Phase 2+** |

### 6.2 Ausgaben
| Posten | Beschreibung |
|--------|--------------|
| **Betriebskosten** | Laufende Kosten je Linie, Fahrzeug und Haltestelle (Unterhalt, Energie) |
| **Fahrzeugkauf** | Einmalkosten beim Kauf von Bussen/Trams/U-Bahnen |
| **Baukosten** | Einmalkosten beim Bau von Straßen, Schienen, Haltestellen, Depots, Tunnel/Brücken |
| **Kredite** | Aufnahme mit Zinszahlung; Rückzahlung über die Zeit |

### 6.3 Budget-Modelle
- **Solo/Kooperativ:** Ein gemeinsames Budget — alle Einnahmen/Ausgaben fließen zusammen.
- **Kompetitiv:** Getrennte Budgets; Einnahmen nur aus eigenen Linien, Bau-/Betriebskosten nur für eigene Elemente.

### 6.4 Balance-Ansätze (qualitativ)
- **Kosten-Nutzen je Verkehrsmittel:** U-Bahn hohe Baukosten, hohe Kapazität; Bus niedrige Kosten, flexible Routen — jede Technologie hat ein Einsatzgebiet (siehe Kapitel 7, 11).
- **Subventionen als Stabilisator:** verhindern Frust-Kollaps in der Aufbauphase, koppeln aber an Netznutzung (Anreiz zu bedarfsgerechtem Ausbau).
- **Kredite als Skalierungs-Hebel** mit Zinsdruck; Ziel: profitable Linien finanzieren Ausbau, keine unbegrenzte Verschuldung.
- Konkrete Zahlen (Tarife, Kosten, Zinsen) werden in M3 simuliert und kalibriert — **nicht Teil dieses GDD**.
- **ODF-4:** Verhalten bei negativem Budget/Insolvenz (Zwangsentleihe, Zwangsverkauf von Fahrzeugen, Spieler-Pause?) — siehe Kapitel 15.

---

## 7. Verkehrsmittel MVP

| Parameter | **Bus** | **Tram** | **U-Bahn** |
|-----------|---------|----------|------------|
| Netz | Straße | Schiene (oberirdisch) | Tunnel/Untergrund |
| Kapazität | Gering–mittel | Mittel | Hoch |
| Geschwindigkeit | Mittel (Straßenverkehrs-abhängig) | Mittel–hoch (eigene Trasse) | Hoch (unabhängig vom Verkehr) |
| Anschaffungskosten | Niedrig | Mittel | Hoch |
| Betriebskosten | Niedrig | Mittel | Mittel–hoch |
| Baukosten (Infrastruktur) | Niedrig (Straßen) | Mittel (Schienen) | Hoch (Tunnel) |
| Spezialität | Flexibel, dichtes Netz, kurze/mittlere Distanzen, leicht nachrüstbar | Mittlere Distanzen, hohe Zuverlässigkeit auf eigener Trasse, sichtbar (Stadtbild) | Hohe Kapazität, schnelle Verbindungen über lange Distanzen, entlastet die Oberfläche |

**Einsatzlogik (Design-Intention):** Bus für Grunderschließung und Feeder, Tram für mittlere Korridore, U-Bahn für Hauptachsen mit hohem Fahrgastaufkommen — kein Verkehrsmittel dominiert, jedes hat sein Einsatzgebiet (Balancing-Ziel, Kapitel 11).

**Phase 2:** Fähre (P1, Backlog), Seilbahn + Oberleitungsbus (P2, Backlog).

---

## 8. Linien-/Fahrplanplanung

### 8.1 Linienaufbau
- **Haltestellen:** Linie verbindet eine geordnete Folge von Haltestellen am Netz (Bus: Straße, Tram: Schiene, U-Bahn: Tunnelstationen).
- **Route:** Verlauf über das Netz zwischen den Haltestellen (Straßen-/Schienen-Graph); Umwege beeinflussen Umlaufzeit und Kosten.
- **Fahrzeuge:** Zuweisung je Linie (Typ + Anzahl); Fahrzeugwechsel zwischen Linien möglich.

### 8.2 Takt & Umläufe
- **Takt:** Vom Spieler festgelegt (z. B. alle X Minuten); beeinflusst Wartezeiten, Zufriedenheit und Nachfrage.
- **Umlaufzeit:** Fahrtzeit der Route (hin + zurück) + Wendezeiten an den Endhaltestellen.
- **Fahrzeugbedarf:** Anzahl Fahrzeuge ≈ Umlaufzeit / Takt — wird aus der Umlaufzeit abgeleitet; der Spieler sieht den Bedarf und kauft/weist entsprechend zu.
- **Depot-Anbindung:** Fahrzeuge rücken aus dem zugeordneten Depot ein/aus (Bausystem-Kopplung, Kapitel 3.1).

### 8.3 Fahrplan-Datenmodell (technisch)
- Linien/Routen/Takte als deterministische Sim-Daten (Fixed-Point, keine floats); Teil des Eingabe-Logs und Replay-Formats (ADR-006: JSON für Export/Replays).
- Fahrplan-Änderungen sind Spielereingaben → Lockstep-konform über Tick-Hash prüfbar.

---

## 9. UI/UX

**Grundsatz (ADR-005/Art-Konzept):** Gleiche Bedienung und Interaktionslogik wie das Referenzspiel (CIM2-ähnliche Menü-Struktur), aber eigenes Icon-Set, flache Panels, eigene Farbwelt.

| Bereich | Inhalt |
|---------|--------|
| **Hauptbildschirm** | 3D-Stadtansicht, Kamera frei schwenkbar, leicht erhöht (Genre-Standard); HUD: Budget, Datum/Tick, Multiplayer-Status (Verbindung, Tick-Hash-OK), Schnellzugriff Bau-Menü |
| **Bau-Menüs** | Kategorien: Straße, Schiene, Haltestelle, Depot, Tunnel/Brücke; Vorschau mit Kosten und Anschluss-Validierung (nur gültige Platzierungen freigeschaltet) |
| **Linien-Editor** | Haltestellen-Reihenfolge, Routenführung, Takt, Fahrzeugzuweisung, Umlaufzeit- und Fahrzeugbedarfs-Anzeige |
| **Wirtschaftspanel** | Einnahmen/Ausgaben aufgeschlüsselt (Tickets, Subventionen, Betrieb, Fahrzeuge, Bau, Kredite); Verlauf über Zeit; Kredit-/Subventions-Aktionen |
| **Stadtpanel** | Wachstums-Indikatoren (Dichte, Wohn/Gewerbe-Balance), Zufriedenheit aggregiert, Pendlerströme |
| **Multiplayer-HUD** | Spielerliste mit **Spielerfarben** (konsistent zu Linienfarben), Budget je Modus (gemeinsam/getrennt), Verbindungs-Status, Host-Migrations-Anzeige |
| **Replay/Desync-Diagnose** | (Dev-/Debug-Ansicht, M2) Tick-Hash-Vergleich, Replay-Log-Zugriff — internes Werkzeug, kein Spieler-Feature im MVP |

**i18n:** DE/EN vollständig, hartes Gate (ADR-004) — kein hartkodierter UI-Text, keine Platzhalter/Stubs.

**Ziel (Erfolgskriterium 3):** Spieler verstehen das Netz und die Bedienung in 5 Minuten.

---

## 10. Art-Richtung C

**Freigabe Glieder (2026-08-09): Richtung C — „Semi-realistisch, eigene Farbwelt".** Realistische 3D-Formen und Proportionen, aber eine eigene, unverwechselbare warme Farbwelt statt des gedeckten Referenz-Looks.

### 10.1 Farbwelt
- **Warmes, pastelliges Color Grading:** warme Städte, freundliche Himmel — deutlich heller/wärmer als das Referenzspiel.
- Basistöne: **Beige/Terrakotta** für Gebäude, **kräftiges Grün** für Grünflächen, pastelliger Himmel.
- **Linienfarben = leuchtende Spielerfarben** (Multiplayer-Lesbarkeit): jedes Fahrzeug/ jede Linie trägt die Spielerfarbe mit **weißer Kontur** für Ablesbarkeit.
- Beleuchtung MVP: fixes, warmes „10-Uhr-Licht"; Tageszeit-Zyklus erst Phase 2.

### 10.2 Formensprache
- Eigene Modelle/Assets — **keine CIM2-Assets, -Namen, -Sounds** (rechtliche Distanz, ADR-005).
- Fahrzeuge: erkennbare moderne Silhouetten (Bus/Tram/U-Bahn), Linienfarbe + weiße Kontur.
- Gebäude: eigene Formensprache, semi-realistisch, automatisch entstehend (Kapitel 4).
- Bewohner: stilisierte Figuren (Wuselfaktor, Kapitel 5.5).

### 10.3 Styleguide-Konsequenzen (qualitativ)
- MVP-Assets bewusst **low-poly** halten, **LOD-Pipeline von Anfang an** (Gegenmaßnahme Lead gegen Asset-/Perf-Aufwand).
- Farbwelt ist das stärkste Unterscheidungsmerkmal; Formen bleiben genre-üblich („gleiche Bedienung, unterscheidbarer Stil").
- Detaillierte Farbpalette + UI-Design-Spec folgen als `Design-Spec.md` (nächster Schritt nach Logo-Freigabe, laut Art-Konzept).

---

## 11. Balancing-Ziele

**Prinzip:** Qualitative Zielwerte und Design-Intentionen — finale Zahlen werden in M3 (Wirtschaftssimulation) simuliert und kalibriert, nicht im GDD festgeschrieben.

| Ziel | Beschreibung (qualitativ) |
|------|---------------------------|
| **Fahrtzeiten** | U-Bahn < Tram ≤ Bus bei gleicher Distanz (Investitions-Staffelung rechtfertigt Kosten); Bus gewinnt bei kurzen Distanzen durch Netzdichte |
| **Ticketpreis-Spannen** | Preis so dimensionierbar, dass eine gut ausgelastete Linie profitabel ist und eine schlecht ausgelastete Verluste macht — Preise sind ein echter Stellhebel, keine reine Formalie |
| **Subventionen** | Decken Grundkosten in der Aufbauphase, koppeln aber an Netznutzung (kein passives Einkommen) |
| **Kredite** | Zinsdruck begrenzt unbegrenzte Verschuldung; Kreditfinanzierter Ausbau muss sich über Fahrgäste amortisieren |
| **Zufriedenheit** | Wartezeit/Verspätung/Überfüllung wirken direkt auf Nachfrage und Wachstum — Qualität zahlt sich aus |
| **Verkehrsmittel-Balance** | Kein Verkehrsmittel dominiert; jedes hat ein klares Einsatzgebiet (Kapitel 7) |
| **Wachstums-Tempo** | Stadt wächst spürbar auf gute Anbindung, aber mit Verzögerung — „erst Netz, dann Stadt" als erlebbarer Loop |

**Zielgrößen für Tests (M3/M7):** 8-Spieler-Session 60+ min stabil; 10k+ SIM-Bewohner bei 60 FPS @ 1080p Mid-Hardware (Qualitätsziel Konzept).

---

## 12. Content-Plan

### 12.1 MVP (Phase 1, Release-Blocker)
- **1 Referenzkarte** mit 1 Stadt-Typ (komplett spielbar) — manuell gestaltete Startwelt, Basis für alle Spielmodi.
- 3 Verkehrsmittel: Bus, Tram, U-Bahn.
- Komplette Wirtschafts- und Linienmechanik, SIM-Bewohner (10k+), Wuselfaktor, automatisches Stadtwachstum.
- Steam: Auth + Lobby (P2P); i18n DE/EN.
- Multiplayer 2–8 Spieler, Host-Migration, Replay/Desync-Detection.

### 12.2 Phase 2 (Post-MVP)
- **Prozeduraler Mapgenerator** (seeded, deterministisch über Clients, Lockstep-konform): generiert Karte **+ Stadt zum Spielen**; Stadt wächst danach dynamisch entlang gebauter Transportwege.
- SteamWorkshop (Maps, Mods, Inhalte).
- Verkehrsmittel: **Fähre** (P1), Seilbahn + Oberleitungsbus (P2).
- Tageszeit/Wetter-System, Replay-Zuschauermodus, Achievements komplett.

### 12.3 Phase 3 (Release)
- Early Access Release (Steam Direct 100 $, nur mit Freigabe), Linux-Build validieren, Beta-Testgruppe, Marketing-Material (Store-Seite, Trailer, Screenshots).

---

## 13. Nicht-Ziele (MVP, aus Konzept/Projektplan übernommen)

- **Kein** Zonen-/Gebäude-/Dienstleistungsbau durch Spieler (Bausystem Stufe 1; Stufe 2 bewusst abgelehnt)
- **Kein** SteamWorkshop im MVP (Phase 2)
- **Kein** Mapgenerator im MVP (Phase 2)
- **Kein** Tageszeit-/Wetter-Zyklus im MVP (Phase 2; MVP: fixes warmes „10-Uhr-Licht")
- **Kein** Modding-API im MVP
- **Kein** Dedicated Server im MVP (P2P via SDR)
- **Keine** Konsolen-Ports
- **Kein** Multiplayer-Crossplay außerhalb Steam
- **Keine** Mikrotransaktionen, kein Pay-to-Win, keine Lootboxen (Monetarisierung: Einmalkauf + EA)

---

## 14. Erfolgskriterien (aus Projektplan/Konzept übernommen)

1. 8-Spieler-Session über 60+ min **ohne Desync** (Replay-verifiziert, Tick-Hash)
2. „CIM2-Moment" vorhanden: Linie bauen → Bus fährt → Fahrgäste steigen ein → Geld fließt
3. Spieler verstehen das Netz in 5 Minuten (UI/Art-Ziel)
4. i18n DE/EN vollständig (hartes Gate, ADR-004)
5. Steam Workshop + Mapgenerator (Phase 2) funktional
6. Early-Access-Release auf Steam, positive Reviews zur Multiplayer-Stabilität
7. 60 FPS @ 1080p auf Mid-Hardware, 10k+ SIM-Bewohner (Qualitätsziel)

---

## 15. Offene Design-Fragen (Freigabe-Runde)

Max. 5 konkrete Fragen zur Entscheidung durch Glieder — alle Punkte sind bewusst nicht im GDD festgeschrieben:

1. **ODF-1 — Feste Tick-Rate:** ADR-006 nennt „z. B. 30 Ticks/s" für den Lockstep-Kern, das Gesamtkonzept 10–20 Hz für die Agenten-Simulation. Welche feste Tick-Rate für den Simulationskern (und welcher Agenten-Detail-Tick im LOD) wird verbindlich?
2. **ODF-2 — Ticketpreis-Modell:** Einheitlicher Flächentarif (globaler Preis) vs. differenzierte Preise je Linie/Zone im MVP? (Beeinflusst Wirtschafts-UI und Balancing.)
3. **ODF-3 — Kompetitive Regeln:** Dürfen mehrere Spieler dieselbe Haltestelle bedienen, und wie verteilen sich Fahrgäste bei parallelen Linienangeboten (Reisezeit-Gewichtung vs. Exklusivität)?
4. **ODF-4 — Insolvenz:** Was passiert bei negativem Budget (Zwangsentleihe, Zwangsverkauf von Fahrzeugen, Sperre weiterer Bauaktionen, Spieler-Reset)?
5. **ODF-5 — Subventions-Trigger:** Wann und wie greifen Subventionen (zeitbasiert, bedarfsbasiert je Linie, global) — und wie wird Missbrauch (Absahnen ohne Betrieb) verhindert?

---

## Verlinkungen
- [[README|Projekt-README]]
- [[Gesamtkonzept|Gesamtkonzept]]
- [[Projektplan|Projektplan]]
- [[Backlog|Backlog]]
- [[Art-Konzept|Art-Konzept]]
- [[60-Decisions/ADR-005_OpenMotion|ADR-005 — Projektgründung]]
- [[60-Decisions/ADR-006_OpenMotion-Tech-Stack|ADR-006 — Tech-Stack]]
- [[60-Decisions/ADR-004_Arbeitsregeln|ADR-004 — Arbeitsregeln]]
