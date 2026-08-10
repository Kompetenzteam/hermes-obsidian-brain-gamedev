---
tags: [index, openmotion]
created: 2026-08-09
updated: 2026-08-10
last_scan: 2026-08-10T20:06:16+02:00
project: OpenMotion
---

# OpenMotion — Code-Index

> Dieser Index wird vom **stündlichen Projekt-Index-Cronjob** (ADR-007) befüllt und laufend aktualisiert. Struktur laut Skill `project-indexing`.

## Projektüberblick

Nahverkehrs-Simulator (Godot 4.7.1 .NET/C#, desync-freier Lockstep-Multiplayer, 2–8 Spieler, Steamworks in Phase 2). Deterministischer Sim-Kern `OpenMotion.Core` (net8.0) mit eigener Fix32-Fixed-Point-Arithmetik, SplitMix64-PRNG, Lockstep-Session mit Replay-Log und FNV-1a-64-Ganzzustands-Hash; M3-Subsysteme Economy, Citizens, Transit, CityGrowth; M5: Steam-freier Netz-Transport (ITransport/InMemory/Netcode/P2PSession) + Multiplayer-Session (Host/Client, Seed-Verteilung, Desync-Erkennung) + Steamworks.NET (App-ID 480); M6: deterministische Referenzkarte (MapGenerator/MapData/MapSerializer), MapRenderer/CityView, i18n-Integration (LocalizationManager, HUD DE/EN); M6.5: Orbit-Kamera (CameraController), Demo-Linie + Fahrzeug-Visualisierung (VehicleVisualizer); M6.6: Stadt-Quadranten-Karte (10 Road/2 Path/3 Rail-Segmente, 17 Stops), Gebäude-Rendering (BuildingVisualizer, CityGrowth-Konsum), sichtbare Umgebung (EnvironmentBuilder: Boden/Himmel/Ambient/Sonne). **Stand 2026-08-09 (M6.7, Perf-Welle 2 + FIX/BALANCE):** CityGrowth-Kern auf Spatial-Hash umgestellt (`IsOccupied` O(1)-Nachbarschaft — ~44 ms/Tick Release, determinismus-bit-identisch), Gebäude-Rendering auf GPU-Instancing (EIN MultiMesh, Draw Calls ~1) und seit heute **inkrementell** (nur neue Instanzen werden angehängt, Kapazität 4096→Verdopplung, kein Voll-Rebuild je Wachstum — Godot-4.7-Pitfall `multimesh_allocate_data` dokumentiert), Refresh-Throttling (Vehicles 15 Hz / Buildings 2 Hz), PerfMonitor-Logging; **FIX:** BuildingSetback 1.5→10.0 m (Gebäude liegen nicht mehr AUF den 6-m-Strassen, Stop-Exklusivität), GrowthCheckRadius 2.5→10.5, StopBonusRadius 5→12; **BALANCE:** Wachstumsbudget 0-2 Gebäude/Tick (MaxBuildingsPerTick=2, deterministisch, RNG-Verbrauch bit-identisch) + Prototyp-Deckel MaxTotalBuildings=2000 — **12.850 → 293 Gebäude in 300 Ticks**. **221 Tests grün** (219 + 1 Setback-Test + 1 BALANCE-Test). KNOWN_ISSUES: Export braucht vorherige Löschung der alten EXE, Headless-FPS nicht aussagekräftig (Details siehe [[10-Projects/OpenMotion/KNOWN_ISSUES|KNOWN_ISSUES]]).

## Scan-Statistik

- **Scan-Zeitpunkt:** 2026-08-10T20:06:16+02:00
- **Scan-Typ:** Inkrementeller Scan (letzter Scan: 2026-08-10T19:06:41+02:00, Hybrid-Strategie)
- **Dateien gesamt (`files_total`):** 123 (find nach Exclusions; Bestand identisch zum letzten Scan)
- **Neue Dateien (`files_new`):** 0
- **Geänderte Dateien (`files_changed`):** 0 (keine mtime-Änderung > last_scan 2026-08-10T19:06:41+02:00, git status sauber, HEAD unverändert a3d8da5 — kein Dateiinhalt seit dem letzten Scan geändert)
- **Entfernte Dateien (`files_removed`):** 0 (assets/logo/logo_clean.ico bleibt aus früheren Scans als entfernt markiert und ist weiterhin nicht im Arbeitsbaum — keine NEUEN Entfernungen)
- **Indexierte Funktionen/Klassen/Methoden (`functions_indexed`):** 501 (verifiziert per Zählung: 501 Listeneinträge in functions.md; unverändert)
- **Abhängigkeiten (`dependencies_indexed`):** 111 Tabellenzeilen (verifiziert per Zählung: 111 `|`-Zeilen inkl. Tabellen-Header + Kernmodule; unverändert)
- **Scan-Dauer:** ca. 1 Minute (Dateiliste, Git-Status + mtime-Vergleich, Bestands-Abgleich files.md ↔ Arbeitsbaum, index.md aktualisiert)

## Letzte Änderungen

*Letzter Scan: 2026-08-10 20:06. Keine neuen Commits/Änderungen seit dem letzten Scan — HEAD unverändert a3d8da5, Git-Arbeitsbaum sauber.*

| Zeitstempel (Git) | Datei |
|-------------------|-------|
| 2026-08-09 15:39 (Commit a3d8da5, HEAD) | fix(M6.7): Gebäude-Abstand ≥10 m zur Straßenachse (Setback, Stop-Exklusivität), CityGrowth-Drossel (0-2/Tick, Deckel 2000 → 815 statt 12.850), MultiMesh inkrementell (nur neue Instanzen) — 221 Tests grün (CHANGELOG.md, BuildingVisualizer.cs, CityGrowthSystem.cs, CityGrowthTests.cs) |
| 2026-08-09 15:15 (Commit 587a421) | docs: KNOWN_ISSUES — Export-Löschung nötig, Headless-FPS nicht aussagekräftig, CityGrowth-Balancing offen (KNOWN_ISSUES.md) |
| 2026-08-09 (Commit 2908d89) | chore: Temp-Artefakte aufgeräumt (im vorherigen Scan dokumentiert) |
| 2026-08-09 (Commit 7a2ab5c) | perf(M6.7): CityGrowth Spatial-Hash (309→3020 ms → ~44 ms/Tick), GPU-Instancing, Throttling, PerfMonitor — 219 Tests grün (im vorherigen Scan dokumentiert) |

Git-Log (Stand Scan): `a3d8da5 fix(M6.7): Gebaeude-Abstand ≥10m zur Strassenachse (Setback, Stop-Exklusivitaet), CityGrowth-Drossel (0-2/Tick, Deckel 2000 → 815 statt 12.850), MultiMesh inkrementell (nur neue Instanzen) — 221 Tests gruen`; `587a421 docs: KNOWN_ISSUES — Export-Loeschung noetig, Headless-FPS nicht aussagekraeftig, CityGrowth-Balancing offen`; `2908d89 chore: Temp-Artefakte aufgeraeumt`; `7a2ab5c perf(M6.7): CityGrowth Spatial-Hash (309→3020ms → ~44ms/Tick), GPU-Instancing, Throttling, PerfMonitor — 219 Tests gruen`.

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
- [[10-Projects/OpenMotion/Recht-Gruendung|Recht-Gruendung]]
