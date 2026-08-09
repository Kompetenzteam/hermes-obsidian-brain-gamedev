---
tags: [index, openmotion]
created: 2026-08-09
updated: 2026-08-09
last_scan: 2026-08-09T12:34:03+02:00
project: OpenMotion
---

# OpenMotion — Code-Index

> Dieser Index wird vom **stündlichen Projekt-Index-Cronjob** (ADR-007) befüllt und laufend aktualisiert. Struktur laut Skill `project-indexing`.

## Projektüberblick

Nahverkehrs-Simulator (Godot 4.7.1 .NET/C#, desync-freier Lockstep-Multiplayer, 2–8 Spieler, Steamworks in Phase 2). Deterministischer Sim-Kern `OpenMotion.Core` (net8.0) mit eigener Fix32-Fixed-Point-Arithmetik, SplitMix64-PRNG, Lockstep-Session mit Replay-Log und FNV-1a-64-Ganzzustands-Hash; M3-Subsysteme Economy, Citizens, Transit, CityGrowth; Godot-Integration über `SimulationRunner` (30-Hz-Tick-Akkumulator). i18n DE (Spielsprache)/EN. Stand 2026-08-09: Meilenstein M4. Details siehe [[10-Projects/OpenMotion/README|README]] und [[10-Projects/OpenMotion/GDD|GDD]].

## Scan-Statistik

- **Scan-Zeitpunkt:** 2026-08-09T12:34:03+02:00
- **Scan-Typ:** Initial-Scan (kein `last_scan` im bisherigen Index-Template vorhanden)
- **Dateien gesamt (`files_total`):** 93
- **Neue Dateien (`files_new`):** 93
- **Geänderte Dateien (`files_changed`):** 0
- **Entfernte Dateien (`files_removed`):** 0
- **Indexierte Funktionen/Klassen/Methoden (`functions_indexed`):** 252
- **Scan-Dauer:** ca. 5 Minuten (Dateiliste, Git-Status, vollständige Analyse aller 93 Dateien, 4 Index-Dateien geschrieben)

## Letzte Änderungen

*Letzter Scan: 2026-08-09 12:34. Projekt-Git-Status: clean (keine modifizierten/untracked Dateien).*

| Zeitstempel (mtime) | Datei |
|---------------------|-------|
| 2026-08-09 12:28 | scenes/vehicles/Metro.tscn, Tram.tscn, Bus.tscn, CHANGELOG.md, scenes/vehicles/VehicleColor.cs |
| 2026-08-09 12:21 | src/OpenMotion.Core.Tests/VehicleMovementTests.cs |
| 2026-08-09 12:20 | src/OpenMotion.Core/Transit/VehicleMovementSystem.cs |
| 2026-08-09 12:19 | src/OpenMotion.Core/Transit/PassengerFlow.cs |
| 2026-08-09 12:17 | scenes/Main.tscn, scripts/SimulationRunner.cs |
| 2026-08-09 12:08 | .hermes/environment.json |
| 2026-08-09 12:05 | src/OpenMotion.Core.Tests/CitizensTests.cs |
| 2026-08-09 12:04 | src/OpenMotion.Core/Serialization/BinarySimSerializer.cs |
| 2026-08-09 12:03 | src/OpenMotion.Core/Economy/EconomySystem.cs |
| 2026-08-09 12:02 | src/OpenMotion.Core/City/CityGrowthSystem.cs, Infrastructure.cs, Citizens/CitizenSystem.cs, RoutingPreference.cs, Economy/FareSystem.cs, LineEconomicStatus.cs, City/Building.cs, Citizens/Citizen.cs, CityGrowthTests.cs |

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
