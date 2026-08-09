---
tags: [project, backlog]
project: OpenMotion
status: active
---
# OpenMotion — Backlog

> Prioritäten: P0 = kritisch (Release-Blocker), P1 = wichtig, P2 = nice-to-have.
> Reihenfolge = Priorität, dann Eingangsreihenfolge.

## Phase 0 — Konzeption
- [x] P0 ~~Art-Konzept definieren~~ ✅ entschieden (Richtung C)
- [x] P0 ~~Logo entwickeln~~ ✅ FREIGEGEBEN (2026-08-09, `logo_simple_fixed.svg`)
- [x] P0 ~~ADR-006 Tech-Stack entscheiden~~ ✅ FREIGEGEBEN (accepted)
- [x] P0 ~~GDD (Game Design Document)~~ ✅ freigegeben (v0.2)
- [x] P0 ~~NDD (Networking Design Document)~~ ✅ freigegeben (v0.2)
- [x] P1 Projekt-Boilerplate ✅ (M1: Godot-Scaffold, CI, i18n) — M2 Lockstep-Kern ✅ (42 Tests)

## Phase 1 — MVP (Release-Blocker)
- [x] M2 Multiplayer-Kern: Lockstep ✅ (Input/Replay/TickHash/Session, 42 Tests)
- [x] M3 Simulation ✅ — Economy (Budget/Subventionen/Kredite), Transit (Bus/Tram/Metro), Citizens (Routing Reisezeit+Preis), City-Growth (entlang Transportwegen), Orchestrator (Hash alle 10 Ticks), Serialization/Replay-Export — **147 Tests grün**
- [x] M4 Vehicles ✅ — VehicleMovementSystem (deterministische Bewegung, Stop-Ankünfte, Fahrgast-Wechsel), Godot-Modelle (Bus/Tram/Metro .tscn), SimulationRunner (30 Hz in Godot, Hash 0x407B0763D2ABA9CB bei Tick 300) — **173 Tests grün**
- [ ] P0 Kern-Wirtschaftssimulation (Budget, Passagierströme, Tarife) — integriert, UI-Anbindung offen
- [ ] P0 Linienplanung (Haltestellen, Routen, Fahrpläne) — Kern fertig, UI offen
- [ ] P0 Verkehrsmittel: Bus / Tram / U-Bahn — Datenmodell fertig, Rendering offen (M4)
- [ ] P0 1 Stadt-Typ (Referenzkarte)
- [ ] P0 Steam-Anbindung: Auth + Lobby (P2P)
- [ ] P1 Multiplayer 2–8 Spieler stabil (Desync-Tests, Replay-Validierung)
- [ ] P1 Host-Migration bei Host-Ausfall
- [ ] P1 Steam Achievements (Basis-Set)
- [ ] P1 i18n DE/EN komplett

## Phase 2 — Post-MVP
- [ ] P1 Prozeduraler Mapgenerator (seeded, deterministisch über Clients) — generiert Karte **+ Stadt zum Spielen**; Stadt wächst dynamisch entlang der gebauten Transportwege (Straßen/Schienen/Gehwege), Gebäude entstehen automatisch an der Infrastruktur (2026-08-09, Anforderung Glieder)
- [ ] P1 SteamWorkshop (Maps, Mods, Inhalte)
- [ ] P1 Verkehrsmittel: Fähre
- [ ] P2 Verkehrsmittel: Seilbahn, Oberleitungsbus
- [ ] P2 Tageszeit-/Wetter-System
- [ ] P2 Modding-API (Workshop-Grundlage)

## Phase 3 — Release
- [ ] P0 Early Access Release (Steam Direct 100 $, Freigabe Glieder)
- [ ] P1 Linux-Build validieren (Steam Machine / Proton-frei)
- [ ] P1 Beta-Phase mit Testgruppe
- [ ] P2 Marketing-Material (Store-Seite, Trailer, Screenshots)

## Ideen / Backlog-Pool
- [ ] Replay-System (Zuschauer-Modus)
- [ ] KI-Verkehr / Fußgänger-Simulation (Detailgrad je nach Leistung)
- [ ] Wirtschafts-Szenarien / Kampagnen
- [ ] Map-Editor (in-game) als Workshop-Pipeline
- [ ] Soundtrack (lizenzfrei oder Eigenproduktion)

## Verlinkungen
- [[README|Projekt-README]]
- [[60-Decisions/ADR-005_OpenMotion|ADR-005 — Projektgründung]]
