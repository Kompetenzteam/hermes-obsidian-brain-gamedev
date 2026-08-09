---
tags: [project]
status: active
started: 2026-08-09
stack: [tbd]
repo: D:\Entwicklung\Projekte\OpenMotion
---
# OpenMotion

> Nahverkehrs-Simulator im Geiste von Cities in Motion 2 — mit desync-freiem Multiplayer, Mapgenerator und SteamWorkshop. Kein 1:1-Klon, eigenes Art-Konzept, gleiche Bedienung.

## Übersicht
- **Ziel:** Multiplayer-tauglicher Nahverkehrs-Simulator mit CIM2-Spielgefühl
- **Stack:** offen (ADR-006 folgt — Empfehlung: Godot 4)
- **Repo/Ordner:** `D:\Entwicklung\Projekte\OpenMotion`
- **Plattform:** Windows + Linux (Steam Machine)
- **Modell:** Einmalkauf, Early Access, Steam (Steam Direct 100 $, vorher Freigabe!)

## Kernfeature
- **Desync-freier Multiplayer (2–8 Spieler)** — Deterministic Lockstep, Kern des Projekts
- Wirtschaftssimulation + Linienplanung (Bus, Tram, U-Bahn im MVP)
- Phase 2: prozeduraler Mapgenerator (seeded, deterministisch), SteamWorkshop

## Architektur
- (folgt mit ADR-006 Tech-Stack)

## Module / Komponenten
- [ ] Multiplayer-Kern (Lockstep, Replay, Host-Migration)
- [ ] Wirtschaftssimulation
- [ ] Linien-/Fahrplanplanung
- [ ] Verkehrsmittel (MVP: Bus, Tram, U-Bahn)
- [ ] Mapgenerator (Phase 2)
- [ ] SteamWorkshop (Phase 2)
- [ ] Steam-Anbindung (Auth, P2P/Relay, Achievements)
- [ ] i18n DE/EN (hartes Gate, ADR-004)

## Abhängigkeiten
- Steamworks SDK (kostenlos, Partnerkonto nötig) — **abgelegt unter `C:\Steamworks\sdk`** (2026-08-09, nicht im Repo)
- Steam Direct 100 $ (vor Release, Freigabe nötig)
- **Strategie (Glieder, 2026-08-09):** Spiel komplett ohne Steam bis M7 fertig entwickeln, Steam erst bei M8 einbauen; Partnerkonto bleibt bewusst unvollständig (kein Schaden), 100-USD-Gebühr + vollständige Registrierung (Identität 2–7 Werktage, Bankdaten, W-8BEN) erst bei M8 — Details: [[10-Projects/OpenMotion/Recht-Gruendung|Recht & Gründung]]

## Offene Tasks
- [ ] **Freigabe Gesamtkonzept + Projektplan durch Glieder** ([[Gesamtkonzept|Gesamtkonzept]], [[Projektplan|Projektplan]])
- [ ] Art-Konzept definieren (Lead Gamedesigner) — **wartet auf Freigabe D1**
- [ ] Logo entwickeln (Lead Gamedesigner)
- [ ] ADR-006 Tech-Stack
- [ ] Backlog: [[Backlog|Backlog]]

## Design-Dokumente
- [[GDD|GDD]] — Game Design Document, **freigegeben** (v0.2, Freigabe Glieder 2026-08-09)
- [[NDD|NDD]] — Networking Design Document, **freigegeben** (v0.2, Netz-Entscheidungen Q1–Q5 inkl. Save & Resume, Glieder 2026-08-09)
- [[Dev-Environment-Windows|Dev-Environment-Windows]] — Windows-Entwicklungsumgebung (Installationen, Verifikationen, Fallen)

## Session-Log
- [[50-Sessions/2026-08-09_OpenMotion-Kickoff|2026-08-09 — Kickoff]]
- [[50-Sessions/2026-08-09_OpenMotion-M1-M3|2026-08-09 — M1–M3 (Boilerplate, Lockstep, Simulation, D2-Logo)]]
- [[50-Sessions/2026-08-09_OpenMotion-M4-M5|2026-08-09 — M4–M5 (Vehicles, Steam Multiplayer)]]
- [[50-Sessions/2026-08-09_OpenMotion-M6|2026-08-09 — M6 (City/UI, Referenzkarte, i18n)]]
- [[50-Sessions/2026-08-09_Steamworks-Partnerkonto|2026-08-09 — Steamworks-Partnerkonto (Strategie: Steam erst bei M8)]]

## Entscheidungen
- [[60-Decisions/ADR-005_OpenMotion|ADR-005 — Projektgründung]]
- [[60-Decisions/ADR-006_OpenMotion-Tech-Stack|ADR-006 — Tech Stack]] (proposed, wartet auf Freigabe)

## Abweichungen
- [[70-Deviations/DEV-001_Logo-zurueckgestellt|DEV-001 — Logo-Entwurf zurückgestellt]]

## Verlinkungen
- [[Index|🏠 Brain Index]]
- [[Art-Konzept|Art-Konzept]]
- [[Backlog|Backlog]]
