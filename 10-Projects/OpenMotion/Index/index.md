---
tags: [index, openmotion]
created: 2026-08-09
updated: 2026-08-09
last_scan: 2026-08-09T13:10:55+02:00
project: OpenMotion
---

# OpenMotion — Code-Index

> Dieser Index wird vom **stündlichen Projekt-Index-Cronjob** (ADR-007) befüllt und laufend aktualisiert. Struktur laut Skill `project-indexing`.

## Projektüberblick

Nahverkehrs-Simulator (Godot 4.7.1 .NET/C#, desync-freier Lockstep-Multiplayer, 2–8 Spieler, Steamworks in Phase 2). Deterministischer Sim-Kern `OpenMotion.Core` (net8.0) mit eigener Fix32-Fixed-Point-Arithmetik, SplitMix64-PRNG, Lockstep-Session mit Replay-Log und FNV-1a-64-Ganzzustands-Hash; M3-Subsysteme Economy, Citizens, Transit, CityGrowth; M5: Steam-freier Netz-Transport (ITransport/InMemory/Netcode/P2PSession) + Multiplayer-Session (Host/Client, Seed-Verteilung, Desync-Erkennung) + Steamworks.NET (App-ID 480); M6: deterministische Referenzkarte (MapGenerator/MapData/MapSerializer), MapRenderer/CityView, i18n-Integration (LocalizationManager, HUD DE/EN); M6.5: Orbit-Kamera (CameraController), Demo-Linie + Fahrzeug-Visualisierung (VehicleVisualizer). Stand 2026-08-09: Meilenstein M6.5, 216 Tests grün. Details siehe [[10-Projects/OpenMotion/README|README]] und [[10-Projects/OpenMotion/GDD|GDD]].

## Scan-Statistik

- **Scan-Zeitpunkt:** 2026-08-09T13:10:55+02:00
- **Scan-Typ:** Inkrementeller Scan (letzter Scan: 2026-08-09T12:34:03+02:00, Hybrid-Strategie)
- **Dateien gesamt (`files_total`):** 121
- **Neue Dateien (`files_new`):** 28 (Map/Multiplayer/Networking M5+M6, 6 neue Godot-Skripte, 5 neue Test-Suiten, Szenen, Doku, Export-Preset, ICO)
- **Geänderte Dateien (`files_changed`):** 4 (CHANGELOG.md, OpenMotion.csproj, project.godot, scripts/SimulationRunner.cs)
- **Entfernte Dateien (`files_removed`):** 0
- **Indexierte Funktionen/Klassen/Methoden (`functions_indexed`):** 445 (vorher 252; +193 durch M5/M6/M6.5)
- **Abhängigkeiten (`dependencies_indexed`):** 98 Tabellenzeilen (vorher 53; +45)
- **Scan-Dauer:** ca. 8 Minuten (Dateiliste, Git-Status, vollständige Analyse aller 32 neuen/geänderten Dateien, 4 Index-Dateien aktualisiert)

## Letzte Änderungen

*Letzter Scan: 2026-08-09 13:10. Git-Status: 4 modifizierte + 4 untracked Dateien (CameraController.cs, VehicleVisualizer.cs, export_presets.cfg, logo_clean.ico); Build/untracked dir ausgeschlossen.*

| Zeitstempel (mtime/Git) | Datei |
|-------------------------|-------|
| 2026-08-09 12:45+ (Commits M5/M6) | src/OpenMotion.Core/Map/*, Multiplayer/*, Networking/* (28 neue Dateien) |
| 2026-08-09 (M) | CHANGELOG.md, project.godot, scenes/city/CityView.tscn, scripts/SimulationRunner.cs |
| 2026-08-09 (?? untracked) | assets/logo/logo_clean.ico, export_presets.cfg, scripts/CameraController.cs, scripts/VehicleVisualizer.cs |
| 2026-08-09 (M6) | scripts/MapRenderer.cs, scenes/city/CityView.tscn, scripts/HUD.cs, scenes/ui/HUD.tscn, scripts/LocalizationManager.cs |
| 2026-08-09 (M5) | scripts/SteamManager.cs, docs/STEAMWORKS_SETUP_ANLEITUNG.md, src/OpenMotion.Core.Tests/Networking*.cs, MultiplayerSessionTests.cs, MapTests.cs |

Git-Log (Stand Scan): `17586b1 feat(M6): Deterministische Referenzkarte (MapGenerator/MapData/MapSerializer), Godot-MapRenderer + CityView, i18n-Integration (LocalizationManager, HUD DE/EN) — 216 Tests gruen`; `cc13e36 feat(M5): Steamworks.NET (App-ID 480, SteamManager), Netz-Transport (ITransport/InMemory/P2PSession), MultiplayerSession (Host/Client, Desync-Erkennung)`.

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
