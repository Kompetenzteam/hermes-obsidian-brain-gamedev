---
tags: [index, openmotion]
created: 2026-08-09
updated: 2026-08-09
last_scan: 2026-08-09T15:10:08+02:00
project: OpenMotion
---

# OpenMotion — Code-Index

> Dieser Index wird vom **stündlichen Projekt-Index-Cronjob** (ADR-007) befüllt und laufend aktualisiert. Struktur laut Skill `project-indexing`.

## Projektüberblick

Nahverkehrs-Simulator (Godot 4.7.1 .NET/C#, desync-freier Lockstep-Multiplayer, 2–8 Spieler, Steamworks in Phase 2). Deterministischer Sim-Kern `OpenMotion.Core` (net8.0) mit eigener Fix32-Fixed-Point-Arithmetik, SplitMix64-PRNG, Lockstep-Session mit Replay-Log und FNV-1a-64-Ganzzustands-Hash; M3-Subsysteme Economy, Citizens, Transit, CityGrowth; M5: Steam-freier Netz-Transport (ITransport/InMemory/Netcode/P2PSession) + Multiplayer-Session (Host/Client, Seed-Verteilung, Desync-Erkennung) + Steamworks.NET (App-ID 480); M6: deterministische Referenzkarte (MapGenerator/MapData/MapSerializer), MapRenderer/CityView, i18n-Integration (LocalizationManager, HUD DE/EN); M6.5: Orbit-Kamera (CameraController), Demo-Linie + Fahrzeug-Visualisierung (VehicleVisualizer); M6.6: Stadt-Quadranten-Karte (10 Road/2 Path/3 Rail-Segmente, 17 Stops), Gebäude-Rendering (BuildingVisualizer, CityGrowth-Konsum), sichtbare Umgebung (EnvironmentBuilder: Boden/Himmel/Ambient/Sonne). **Stand 2026-08-09 (M6.7, Performance-Welle):** CityGrowth-Kern auf Spatial-Hash umgestellt (`IsOccupied` O(1)-Nachbarschaft statt O(N) linear — AdvanceTick 309→3020 ms → **~44 ms/Tick Release**, determinismus-bit-identisch), Gebäude-Rendering auf GPU-Instancing (EIN MultiMesh, Draw Calls ~1 statt 1200+), Refresh-Throttling (Vehicles 15 Hz / Buildings 2 Hz), PerfMonitor-Logging (NEU), project.godot-Perf-Einstellungen (MSAA aus, Scale 1.0, Physik 60 Hz dokumentiert; `run/max_fps=0` trotz Kommentar „60" — Diskrepanz im Projekt, siehe [[dependencies]]). **219 Tests grün** (217 + 2 neue Spatial-Hash-Tests). Details siehe [[10-Projects/OpenMotion/README|README]] und [[10-Projects/OpenMotion/GDD|GDD]].

## Scan-Statistik

- **Scan-Zeitpunkt:** 2026-08-09T15:10:08+02:00
- **Scan-Typ:** Inkrementeller Scan (letzter Scan: 2026-08-09T14:07:05+02:00, Hybrid-Strategie)
- **Dateien gesamt (`files_total`):** 123 (find nach Exclusions)
- **Neue Dateien (`files_new`):** 1 (scripts/PerfMonitor.cs — M6.7)
- **Geänderte Dateien (`files_changed`):** 8 (CHANGELOG.md, KNOWN_ISSUES.md, project.godot, scripts/BuildingVisualizer.cs, scripts/SimulationRunner.cs, scripts/VehicleVisualizer.cs, src/OpenMotion.Core/City/CityGrowthSystem.cs, src/OpenMotion.Core.Tests/CityGrowthTests.cs)
- **Entfernte Dateien (`files_removed`):** 0 (logo_clean.ico war bereits im letzten Scan als entfernt markiert; Commit 2908d89 löschte nur nicht-indexierte Temp-Artefakte)
- **Indexierte Funktionen/Klassen/Methoden (`functions_indexed`):** 490 (vorher 473; +17 durch M6.7: PerfMonitor +4, VehicleVisualizer +4, CityGrowthSystem +4, SimulationRunner +2, CityGrowthTests +3)
- **Abhängigkeiten (`dependencies_indexed`):** 106 Tabellenzeilen (Methode: alle `| `-Zeilen inkl. 2 Header + 16 Kernmodule; vorher 100 nach letzter Methode; +1 neue Zeile PerfMonitor.cs, 6 Zeilen aktualisiert)
- **Scan-Dauer:** ca. 3 Minuten (Dateiliste, Git-Status + mtime-Vergleich, vollständige Analyse aller 9 geänderten/neuen Dateien inkl. 3 großer Skripte, 4 Index-Dateien aktualisiert)

## Letzte Änderungen

*Letzter Scan: 2026-08-09 15:10. Git-Arbeitsbaum sauber — M6.6/M6.7-Arbeit ist committet (3 neue Commits seit letztem Scan).*

| Zeitstempel (Git) | Datei |
|-------------------|-------|
| 2026-08-09 15:07 (Commit 7a2ab5c) | perf(M6.7): CityGrowth Spatial-Hash (309→3020 ms → ~44 ms/Tick), GPU-Instancing, Throttling, PerfMonitor — 219 Tests grün (CHANGELOG.md, KNOWN_ISSUES.md, project.godot, BuildingVisualizer.cs, PerfMonitor.cs NEU, SimulationRunner.cs, VehicleVisualizer.cs, CityGrowthSystem.cs, CityGrowthTests.cs) |
| 2026-08-09 (Commit 3977d9f) | docs: KNOWN_ISSUES — Performance-Problem + GPU-Testlage (RTX only, ADR-007) |
| 2026-08-09 (Commit 2908d89, HEAD) | chore: Temp-Artefakte aufgeräumt (.hermes/tmp_bv_verify.sh, perf_start.txt — nie indexiert) |
| 2026-08-09 (Commit f15a68c) | feat(M6.6): Prototyp V2 — Umgebung, Gebäude-Rendering, dichtere Stadtkarte (im letzten Scan als untracked erfasst, jetzt committet) |

Git-Log (Stand Scan): `2908d89 chore: Temp-Artefakte aufgeräumt`; `7a2ab5c perf(M6.7): CityGrowth Spatial-Hash (309→3020ms → ~44ms/Tick), GPU-Instancing, Throttling, PerfMonitor — 219 Tests gruen`; `3977d9f docs: KNOWN_ISSUES — Performance-Problem + GPU-Testlage (RTX only, ADR-007)`; `f15a68c feat(M6.6): Prototyp V2 — Umgebung (Boden/Himmel/Ambient), Gebäude-Rendering (BuildingVisualizer), dichtere Stadtkarte (10 Strassen/17 Stops), Fix: CityGrowth waechst auf Referenzkarte (217 Tests gruen)`.

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
