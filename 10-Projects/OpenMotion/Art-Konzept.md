---
tags: [project, art, design]
project: OpenMotion
status: decided
date: 2026-08-09
---
# OpenMotion — Art-Konzept

> Status: **ENTSCHEIDEN: Richtung C — Semi-realistisch, eigene Farbwelt** (Freigabe Glieder, 2026-08-09)
> Autor: Hermes (Lead Gamedesigner)

## 1. Vorgaben (aus ADR-005)
- Eigenes Art-Konzept, **keine 1:1-Kopie** von CIM2
- **Gleiche Bedienung/Spielgefühl**, unterscheidbarer Stil
- Performance-relevant: viele Fahrzeuge + SIM-Bewohner + Multiplayer (Lockstep) → Rendering-Kosten im Blick behalten
- Windows + Linux (Steam)

## 2. Stil-Analyse Referenz (CIM2)
| Aspekt | CIM2 |
|--------|------|
| Look | Realistisch-europäisch, gedeckte Farben, Tageszeit-Zyklus |
| Kamera | 3D, frei schwenkbar, leicht erhöht |
| Vibe | Ernst, städtisch, dokumentarisch |

## 3. Entscheidung: Richtung C — „Semi-realistisch, eigene Farbwelt"

**Konzept:** Realistische 3D-Formen und Proportionen (Nähe zum Genre-Erlebnis CIM2), aber mit einer **eigenen, unverwechselbaren Farbwelt** statt des gedeckten CIM2-Looks:
- **Warmes, pastelliges Color Grading** (warme Städte, freundliche Himmel) — deutlich heller und wärmer als CIM2s gedämpfte Palette
- **Eigene Formensprache** bei Gebäuden/Fahrzeugen (eigene Modelle, keine CIM2-Assets)
- **Linienfarben = leuchtende Spielerfarben** (Multiplayer-Lesbarkeit, konsistent zum Gesamtkonzept)
- Tageszeit-Zyklus: Phase 2 (MVP: fixes, warmes „10-Uhr-Licht")

## 4. Konsequenzen Richtung C (bewusst gewählt)
| Aspekt | Einordnung |
|--------|-----------|
| Rechtliche Distanz zu CIM2 | Mittel — Basis-Look ähnelt dem Genre, aber eigene Farbwelt/Assets/Namen → ausreichend getrennt, kein Klon |
| Asset-Aufwand | **Höher als Richtung A** — realistischere Modelle, Texturen, Beleuchtung |
| Performance | Mittel — mehr Polygone/Texturen; SIM-Bewohner-Crowd braucht Instancing + LOD (siehe Gesamtkonzept 2.2a) |
| Multiplayer-Lesbarkeit | Mittel — Linienfarben kompensieren |
| Gegenmaßnahme Lead | MVP-Assets bewusst low-poly halten, Farbwelt als stärkstes Unterscheidungsmerkmal einsetzen, LOD-Pipeline von Anfang an |

## 5. Definierende Elemente
- **Kamera:** Frei schwenkbar, leicht erhöht (Genre-Standard, gleiche Bedienung wie Referenz)
- **Farbwelt:** Warme Basistöne (Beige/Terrakotta für Gebäude, kräftiges Grün für Grünflächen), pastelliger Himmel, leuchtende Linienfarben
- **Fahrzeuge:** Eigene Modelle (Bus/Tram/U-Bahn), erkennbare moderne Silhouetten, Linienfarbe + weiße Kontur
- **Bewohner:** Stilisierte Figuren (Wuselfaktor an Haltestellen), instanziertes Crowd-Rendering
- **UI:** Flache Panels, CIM2-ähnliche Interaktionslogik (Menü-Struktur), eigenes Icon-Set

## 6. Nächste Schritte nach Logo-Freigabe
1. Logo-Finalisierung (6 Silhouetten-Varianten in Arbeit)
2. Farbpalette + UI-Design-Spec (`Design-Spec.md`)
3. Erste Asset-Prototypen (Fahrzeug, Gebäude, Straße) zur Freigabe

## Verlinkungen
- [[README|Projekt-README]]
- [[Gesamtkonzept|Gesamtkonzept]]
- [[60-Decisions/ADR-005_OpenMotion|ADR-005 — Projektgründung]]
- [[Backlog|Backlog]]
