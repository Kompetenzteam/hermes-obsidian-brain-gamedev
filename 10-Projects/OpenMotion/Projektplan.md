---
tags: [project, plan]
project: OpenMotion
status: draft
date: 2026-08-09
---
# OpenMotion — Projektplan

> Status: **DRAFT — wartet auf manuelle Freigabe durch Glieder**
> Freigabe-Regel (ADR-004): Keine Umsetzung vor Freigabe.

## 1. Projektziel
OpenMotion ist ein Nahverkehrs-Simulator im Spielgefühl von Cities in Motion 2 (Linienplanung, Wirtschaft, Verkehrsmittel), mit **desync-freiem Multiplayer** als Kern-USP. Eigenes Art-Konzept, eigene Engine-Entscheidung, keine 1:1-Kopie. Komplette Steam-Anbindung (Auth, Lobby, Workshop, Achievements). Modell: Einmalkauf mit Early Access. Plattform: Windows + Linux (Steam Machine).

## 2. Umfang (Scope)
### MVP (Release-Blocker, Phase 1)
- Desync-freier Multiplayer 2–8 Spieler (Deterministic Lockstep)
- Kern-Wirtschaftssimulation + Linien-/Fahrplanplanung
- 3 Verkehrsmittel: Bus, Tram, U-Bahn
- 1 Stadt-Typ (Referenzkarte)
- Steam: Auth + Lobby (P2P)
- i18n DE/EN (hartes Gate)

### Phase 2 (Post-MVP)
- Prozeduraler Mapgenerator (seeded, deterministisch über Clients)
- SteamWorkshop (Maps, Mods)
- Weitere Verkehrsmittel (Fähre, Seilbahn), Tageszeit/Wetter, Replay, Host-Migration-Absicherung

### Phase 3 (Release)
- Early Access Release, Linux-Build, Store-Seite, Beta-Testgruppe

### Nicht-Ziele (Phase 1)
- Kein Workshop, kein Mapgenerator im MVP (kommen in Phase 2)
- Kein Tageszeit/Wetter im MVP
- Kein Modding-API im MVP
- Kein Multiplayer-Crossplay außerhalb Steam

## 3. Meilensteine (M0–M8)
| MS | Inhalt | Ausstiegskriterium |
|----|--------|--------------------|
| M0 | Konzeption | Projektplan freigegeben, ADR-006 Tech-Stack, GDD + NDD freigegeben, Art-Konzept + Logo freigegeben |
| M1 | Boilerplate | Repo-Struktur, CI, Linter, i18n-Gerüst, Headless-Build lauffähig |
| M2 | Lockstep-Kern | Deterministic Lockstep Framework inkl. Replay + Desync-Detection, 2 Clients synchron |
| M3 | Simulation | Wirtschaftskern + Linienplanung, deterministisch über Tick |
| M4 | Vehicles | Bus, Tram, U-Bahn (Modell, Bewegung, Fahrgast-Be-/-Entstieg) |
| M5 | Steam Multiplayer | Steam Auth + Lobby + P2P, 2–8 Spieler, Desync-Tests grün |
| M6 | City | Referenzkarte, 1 Stadt-Typ spielbar, UI komplett, i18n DE/EN |
| M7 | Stabilisierung | 8-Spieler-Tests, Reconnect, Host-Migration, Performance |
| M8 | Release-Vorbereitung | Early-Access-Entscheidung, Store-Assets, Linux-Build |

## 4. Rollen & Arbeitsweise
| Rolle | Person |
|-------|--------|
| Geschäftsführer / Entscheider | Glieder |
| Lead Gamedesigner | Hermes |
| Senior Lead Game Developer | Hermes |
| Senior Networking Specialist | Hermes |
| Umsetzung (Code) | Hermes-Subagents (Project Lead programmiert nie selbst, ADR-004) |

Ablauf je Welle: Aufgabe → Subagent → Auto-Review → Fehler-Doku → Git-Commit → Build-Verifikation → Freigabe-Fenster für Glieder bei Designentscheidungen.

## 5. Designentscheidungen (Freigabe-Pflicht!)
| # | Entscheidung | Status |
|---|--------------|--------|
| D1 | Art-Richtung (A: Flat Iso / B: Low-Poly / C: Semi-realistisch) | **OFFEN — wartet auf Freigabe** |
| D2 | Logo-Familie (1–4) | **OFFEN — wartet auf Freigabe** |
| D3 | Tech-Stack / Engine (ADR-006) | **OFFEN — wird nach D1/D2 vorgelegt** |
| D4 | Multiplayer-Architektur (Lockstep-Details) | ✅ **FREIGEGEBEN** (2026-08-09, im [[10-Projects/OpenMotion/NDD|NDD v0.2]] fixiert) |
| D5 | Monetarisierungs-Details (EA-Preis, DLC-Politik) | OFFEN — vor Phase 3 |

## 6. Risiken & Gegenmaßnahmen
| Risiko | Bewertung | Gegenmaßnahme |
|--------|-----------|---------------|
| Desyncs (Kernrisiko des Genres) | Hoch | Deterministic Lockstep von Tag 1, Replay-System, deterministische Math (Fixed-Point) |
| Scope-Explosion (CIM2-Umfang) | Hoch | Strikter MVP-Scope, Backlog-Disziplin |
| Recht (Paradox-IP) | Mittel | Eigenes Art-Konzept, keine Namen/Assets aus CIM2 |
| Hobby-Budget / Zeit | Mittel | MVP-first, on-the-go Budget, keine Fixkosten |
| Steam Direct 100 $ | Gering | Erst bei M8, mit Freigabe |

## 7. Kostenpunkte (nur mit Freigabe durch Glieder)
| Posten | Kosten | Fällig |
|--------|--------|--------|
| Steam Direct (App-Eintrag) | 100 $ einmalig | Phase 3 / M8 |
| Engine/Assets | 0 € (Open Source + selbst erzeugt) | – |
| Sonstige Tools | vorher anfragen + Kostennennung | – |

## 8. Abnahmekriterien Projekt (Erfolg)
1. 8-Spieler-Session über 60+ min ohne Desync (Replay-verifiziert)
2. CIM2-typisches Spielgefühl vorhanden (Linie planen → fährt → Geld verdient)
3. i18n DE/EN vollständig
4. Steam Workshop + Mapgenerator (Phase 2) funktional
5. Early-Access-Verkauf über Steam

## 9. Freigabe
- [ ] **Projektplan freigegeben** (Glieder, manuell)
- [ ] D1 Art-Richtung freigegeben
- [ ] D2 Logo-Familie freigegeben

---
## Verlinkungen
- [[README|Projekt-README]]
- [[Backlog|Backlog]]
- [[Art-Konzept|Art-Konzept]]
- [[60-Decisions/ADR-005_OpenMotion|ADR-005 — Projektgründung]]
- [[60-Decisions/ADR-004_Arbeitsregeln|ADR-004 — Arbeitsregeln]]
