---
tags: [index, openmotion]
created: 2026-08-09
updated: 2026-08-09
last_scan: 2026-08-09T14:07:05+02:00
project: OpenMotion
---

# OpenMotion — Code-Index

> Dieser Index wird vom **stündlichen Projekt-Index-Cronjob** (ADR-007) befüllt und laufend aktualisiert. Struktur laut Skill `project-indexing`.

## Projektüberblick

Nahverkehrs-Simulator (Godot 4.7.1 .NET/C#, desync-freier Lockstep-Multiplayer, 2–8 Spieler, Steamworks in Phase 2). Deterministischer Sim-Kern `OpenMotion.Core` (net8.0) mit eigener Fix32-Fixed-Point-Arithmetik, SplitMix64-PRNG, Lockstep-Session mit Replay-Log und FNV-1a-64-Ganzzustands-Hash; M3-Subsysteme Economy, Citizens, Transit, CityGrowth; M5: Steam-freier Netz-Transport (ITransport/InMemory/Netcode/P2PSession) + Multiplayer-Session (Host/Client, Seed-Verteilung, Desync-Erkennung) + Steamworks.NET (App-ID 480); M6: deterministische Referenzkarte (MapGenerator/MapData/MapSerializer), MapRenderer/CityView, i18n-Integration (LocalizationManager, HUD DE/EN); M6.5: Orbit-Kamera (CameraController), Demo-Linie + Fahrzeug-Visualisierung (VehicleVisualizer); M6.6: Stadt-Quadranten-Karte (10 Road/2 Path/3 Rail-Segmente, 17 Stops), Gebäude-Rendering (BuildingVisualizer, CityGrowth-Konsum), sichtbare Umgebung (EnvironmentBuilder: Boden/Himmel/Ambient/Sonne). Stand 2026-08-09: Meilenstein M6.6, 217 Tests grün. Details siehe [[10-Projects/OpenMotion/README|README]] und [[10-Projects/OpenMotion/GDD|GDD]].

## Scan-Statistik

- **Scan-Zeitpunkt:** 2026-08-09T14:07:05+02:00
- **Scan-Typ:** Inkrementeller Scan (letzter Scan: 2026-08-09T13:10:55+02:00, Hybrid-Strategie)
- **Dateien gesamt (`files_total`):** 122
- **Neue Dateien (`files_new`):** 2 (scripts/BuildingVisualizer.cs, scripts/EnvironmentBuilder.cs — M6.6)
- **Geänderte Dateien (`files_changed`):** 6 (CHANGELOG.md, .gitignore, scenes/city/CityView.tscn, scripts/SimulationRunner.cs, src/OpenMotion.Core.Tests/MapTests.cs, src/OpenMotion.Core/Map/MapGenerator.cs)
- **Entfernte Dateien (`files_removed`):** 1 (assets/logo/logo_clean.ico — nicht mehr im Arbeitsbaum, war untracked)
- **Indexierte Funktionen/Klassen/Methoden (`functions_indexed`):** 473 (vorher 445; +28 durch M6.6)
- **Abhängigkeiten (`dependencies_indexed`):** 100 Tabellenzeilen (vorher 98; +2)
- **Scan-Dauer:** ca. 3 Minuten (Dateiliste, Git-Status, vollständige Analyse aller 8 neuen/geänderten Dateien, 4 Index-Dateien aktualisiert)

## Letzte Änderungen

*Letzter Scan: 2026-08-09 14:07. Git-Status: 5 modifizierte + 2 untracked Quelldateien (+2 .uid, ausgeschlossen); logo_clean.ico entfernt.*

| Zeitstempel (mtime/Git) | Datei |
|-------------------------|-------|
| 2026-08-09 13:13 (Commit 3f30807) | .gitignore (build/ + data_OpenMotion* ergänzt, GitHub 100MB-Limit) |
| 2026-08-09 13:12 (Commit f747a97) | M6.5-Prototyp (CameraController, VehicleVisualizer, Export) — bereits im letzten Scan erfasst |
| 2026-08-09 ~13:30 (M) | CHANGELOG.md, scenes/city/CityView.tscn, scripts/SimulationRunner.cs, src/OpenMotion.Core.Tests/MapTests.cs, src/OpenMotion.Core/Map/MapGenerator.cs |
| 2026-08-09 (?? untracked) | scripts/BuildingVisualizer.cs, scripts/EnvironmentBuilder.cs |
| 2026-08-09 (entfernt) | assets/logo/logo_clean.ico (nicht mehr im Arbeitsbaum) |

Git-Log (Stand Scan): `3f30807 chore: build/ aus Repo (GitHub 100MB-Limit), .gitignore ergänzt`; `f747a97 feat(M6.5): Spielbarer Prototyp — CameraController (Orbit/Zoom/Pan), VehicleVisualizer (Demo-Linie, 2 Busse), Windows-Export (openmotion_windows.exe, 106MB)`. M6.6-Arbeit (MapGenerator-Stadt-Quadranten, BuildingVisualizer, EnvironmentBuilder, CHANGELOG-Einträge) liegt uncommittet im Arbeitsbaum.

## Index

- [[files]]
- [[functions]]
- [[dependencies]]

## Projekt-Notizen

- [[10-Projects/OpenMotion/README|README]]
- [[10-Projects/OpenMotion/GDD|GDD]]
- [[10-Projects/OpenMotion/NDD|NDD]]
- [[10-Projects/OpenMotion/Backlog|Backlog]]
- [[10-Projects/OpenMotion/Projektplan|Projektplan]]
- [[10-Projects/OpenMotion/Gesamtkonzept|Gesamtkonzept]]
- [[10-Projects/OpenMotion/Art-Konzept|Art-Konzept]]
- [[10-Projects/OpenMotion/Dev-Environment-Windows|Dev-Environment-Windows]]
