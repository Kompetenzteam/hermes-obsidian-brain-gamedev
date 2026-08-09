---
tags: [index, openmotion, files]
created: 2026-08-09
updated: 2026-08-09
project: OpenMotion
---

# OpenMotion — Datei-Index

> Wird vom **stündlichen Projekt-Index-Cronjob** (ADR-007) befüllt: jede Quelldatei mit Typ, Status, Zweck und Link.

## Dateien

| Datei | Typ | Status | Zweck | Link |
|-------|-----|--------|-------|------|
| .github/workflows/ci.yml | CI/CD | neu | GitHub-Actions-Workflow: Build + Lockstep-Tests auf Windows/Linux | — |
| .gitignore | Konfiguration | neu | Git-Ignore-Regeln (Godot, .NET, IDE) | — |
| .hermes/environment.json | Konfiguration | neu | Hermes-Build-/Test-Recipe (dotnet build/test OpenMotion.sln) | — |
| assets/logo/_analyze3.py | Werkzeug | neu | Logo-Analyse: Connected Components + Farbstatistik | — |
| assets/logo/_analyze4.py | Werkzeug | neu | Logo-Analyse: Eckfarben + Top-8-Farben | — |
| assets/logo/_analyze5.py | Werkzeug | neu | Logo-Analyse: exakte Farbzählung im Vordergrund | — |
| assets/logo/_analyze6.py | Werkzeug | neu | Logo-Analyse: modale Farben pro 40×40-Raster | — |
| assets/logo/_analyze7.py | Werkzeug | neu | Logo-Analyse: 'other'-Regionen (nicht weiß/dunkel/blau/grün) | — |
| assets/logo/_ascii.py | Werkzeug | neu | Logo-Klassifikation als ASCII-Farbkarte | — |
| assets/logo/_clean_test.py | Werkzeug | neu | Logo-Cleanup-Experiment (Masken + Komponenten) | — |
| assets/logo/_clean_viz.py | Werkzeug | neu | Logo-Cleanup-Visualisierung | — |
| assets/logo/_colors.py | Werkzeug | neu | Logo-Farbanalyse (ohne Feather) | — |
| assets/logo/_final.py | Werkzeug | neu | Finale Logo-Pipeline: Feather + Vektorisierung (vtracer) + resvg-Verify | — |
| assets/logo/_pipeline.py | Werkzeug | neu | Logo-Pipeline: Hintergrund-/Rausch-Entfernung + SVG via vtracer | — |
| assets/logo/_render_check.py | Werkzeug | neu | Feather-Sweep + SVG-Render-ASCII-Check | — |
| assets/logo/_vectorize.py | Werkzeug | neu | Optimierte Vektorisierung: Farbquantisierung + vtracer | — |
| assets/logo/_verify_gray.py | Werkzeug | neu | Grau-Reste-Verifikation des bereinigten Logos | — |
| assets/logo/logo_clean.svg | Asset (SVG) | neu | Bereinigtes Logo (vtracer, 443×224) | — |
| assets/logo/logo_nobg.svg | Asset (SVG) | neu | Logo ohne Hintergrund (vtracer, 443×224, roh) | — |
| assets/logo/logo_simple.svg | Asset (SVG) | neu | Vereinfachtes Logo (vtracer, 443×224) | — |
| assets/logo/logo_simple_fixed.svg | Asset (SVG) | neu | Finales vereinfachtes Logo (443×224) | — |
| assets/src/bus.svg | Asset (SVG) | neu | Referenz-Silhouette Bus (Wikimedia, Inkscape) | — |
| assets/src/bus2.svg | Asset (SVG) | neu | Referenz-Silhouette Bus 2 (Illustrator) | — |
| assets/src/bus3.svg | Asset (SVG) | neu | Referenz-Silhouette Bus 3 (Inkscape) | — |
| assets/src/bus_search.json | Asset (Daten) | neu | Wikimedia-Commons-Suchergebnis für Bus-Silhouetten | — |
| assets/src/conecto_url.txt | Asset (Text) | neu | Quell-URL: Mercedes Conecto-Silhouette (Wikimedia) | — |
| assets/src/ice_url.txt | Asset (Text) | neu | Quell-URL: ICE-T-Front (Wikimedia) | — |
| assets/src/icefront.svg | Asset (SVG) | neu | Referenz-Silhouette ICE-Front (Inkscape) | — |
| assets/src/train.svg | Asset (SVG) | neu | Referenz-Silhouette Zug (Inkscape) | — |
| assets/src/tram.svg | Asset (SVG) | neu | Referenz-Silhouette Tram (Illustrator) | — |
| CHANGELOG.md | Doku | neu | Änderungshistorie (M1–M4) | — |
| i18n/check_parity.py | Werkzeug | neu | i18n-Paritätscheck DE↔EN (msgid-Mengen, leere msgstr) | — |
| i18n/de/LC_MESSAGES/ui.po | i18n | neu | Deutsche UI-Texte (msgstr == msgid, Basis-Sprache, ADR-004) | — |
| i18n/en/LC_MESSAGES/ui.po | i18n | neu | Englische UI-Übersetzungen | — |
| i18n/README.md | Doku | neu | i18n-Konzept: Ladekonzept, Konventionen, Paritäts-Pflicht | — |
| IDEA.md | Doku | neu | Kurzkonzept (Cities-in-Motion-2-artiges Spiel, SteamWorks, Multiplayer) | — |
| KNOWN_ISSUES.md | Doku | neu | Bekannte Probleme (M1: Godot 4.7.1, winget, Root-Layout) | — |
| OpenMotion.csproj | Konfiguration | neu | Godot-.NET-Projekt (Godot.NET.Sdk/4.7.1, net8.0, ProjectReference auf Core) | — |
| OpenMotion.sln | Konfiguration | neu | Solution: OpenMotion + OpenMotion.Core + OpenMotion.Core.Tests | — |
| project.godot | Konfiguration | neu | Godot-Projekt: Main-Scene, Assembly, i18n-Registrierung, GL Compatibility | — |
| README.md | Doku | neu | Projekt-README: Tech-Stack (ADR-006), Build & Test, Struktur | — |
| scenes/Main.tscn | Szene | neu | Hauptszene; bindet scripts/SimulationRunner.cs | — |
| scenes/vehicles/Bus.tscn | Szene | neu | Prozedurales Bus-Modell (BoxMesh/CylinderMesh, VehicleColor.cs) | — |
| scenes/vehicles/Metro.tscn | Szene | neu | Prozedurales Metro-Modell (Stufen-Nase, Scheinwerfer) | — |
| scenes/vehicles/Tram.tscn | Szene | neu | Prozedurales Tram-Modell (Niederflur, Pantograph) | — |
| scenes/vehicles/VehicleColor.cs | C# (Godot) | neu | Färbt Fahrzeug-Körper per Linienfarbe (Export LineColor, Gruppe vehicle_body) | — |
| scripts/SimulationRunner.cs | C# (Godot) | neu | SimLoop-Integration: 30-Hz-Tick-Akkumulator, Subsystem-Adapter, Hash-Report | — |
| src/OpenMotion.Core.Tests/CitizensTests.cs | C# (Test) | neu | xUnit: Citizen-Tagesablauf, Zufriedenheit, RoutingPreference, CitizenSystem | — |
| src/OpenMotion.Core.Tests/CityGrowthTests.cs | C# (Test) | neu | xUnit: Infrastructure, Stadt-Wachstum (Determinismus, Netz-Nähe) | — |
| src/OpenMotion.Core.Tests/DeterministicRandomTests.cs | C# (Test) | neu | xUnit: SplitMix64-Sequenzen, Golden-Values, Bereichsgarantien | — |
| src/OpenMotion.Core.Tests/EconomySystemTests.cs | C# (Test) | neu | xUnit: EconomySystem, FareSystem, Subventionen, Zwangsentleihe, Determinismus | — |
| src/OpenMotion.Core.Tests/Fix32Tests.cs | C# (Test) | neu | xUnit: Fix32-Arithmetik, Saturierung, Div-by-0, Roundtrips | — |
| src/OpenMotion.Core.Tests/LockstepTests.cs | C# (Test) | neu | xUnit: ReplayLog, TickHash, InputCommand/InputFrame, LockstepSession | — |
| src/OpenMotion.Core.Tests/OpenMotion.Core.Tests.csproj | Konfiguration | neu | Testprojekt: xUnit 2.9.2, Microsoft.NET.Test.Sdk 17.11.1, net8.0 | — |
| src/OpenMotion.Core.Tests/SerializationTests.cs | C# (Test) | neu | xUnit: BinarySimSerializer (Fix32-as-long), ReplayExporter (Format-Version) | — |
| src/OpenMotion.Core.Tests/SimStateTests.cs | C# (Test) | neu | xUnit: SimState-Seeds und Tick-Zähler | — |
| src/OpenMotion.Core.Tests/SimulationIntegrationTests.cs | C# (Test) | neu | xUnit: Orchestrator (Fakes), Hash-Sequenz, Reihenfolge, DebugReplayValidator | — |
| src/OpenMotion.Core.Tests/TransitTests.cs | C# (Test) | neu | xUnit: VehicleTypeParams, Line, Vehicle, TransitNetwork (IDs, Find) | — |
| src/OpenMotion.Core.Tests/VehicleMovementTests.cs | C# (Test) | neu | xUnit: VehicleMovementSystem, PassengerFlow (26 Tests, M4) | — |
| src/OpenMotion.Core/Citizens/Citizen.cs | C# (Core) | neu | SIM-Bewohner: Zustandsmaschine, Tagesplan (CitizenSchedule), Zufriedenheit | — |
| src/OpenMotion.Core/Citizens/CitizenSystem.cs | C# (Core) | neu | Bewohner-Verwaltung: deterministischer Spawn, Tick-Advance, ITransitNetwork | — |
| src/OpenMotion.Core/Citizens/RoutingPreference.cs | C# (Core) | neu | Fahrgast-Wahlmodell (ODF-3): Reisezeit dominant, Preis sekundär | — |
| src/OpenMotion.Core/City/Building.cs | C# (Core) | neu | Stadtgebäude: Typ, Position, Kapazität, Wohlstand (nur CityGrowth erzeugt) | — |
| src/OpenMotion.Core/City/CityGrowthSystem.cs | C# (Core) | neu | Automatisches Stadt-Wachstum entlang Infrastruktur (GDD 4) | — |
| src/OpenMotion.Core/City/Infrastructure.cs | C# (Core) | neu | Datenmodell: Segmente (Road/Rail/Path), Haltestellen, Position, Nähe-Abfragen | — |
| src/OpenMotion.Core/DeterministicRandom.cs | C# (Core) | neu | Deterministischer PRNG (SplitMix64) für Lockstep (NDD §3.2) | — |
| src/OpenMotion.Core/Economy/EconomySystem.cs | C# (Core) | neu | Wirtschaft: Budget, Erträge/Kosten, Zwangsentleihe, Subventionen (ODF-4/5) | — |
| src/OpenMotion.Core/Economy/FareSystem.cs | C# (Core) | neu | Tarife: Globaltarif-Policy (ODF-2), IFarePolicy-Erweiterungspunkt | — |
| src/OpenMotion.Core/Economy/LineEconomicStatus.cs | C# (Core) | neu | Linien-Wirtschaftsstatus für Subventionsberechnung (ODF-5) | — |
| src/OpenMotion.Core/Fix32.cs | C# (Core) | neu | 32.32-Fixed-Point-Arithmetik (saturierend, Lockstep-Basis, NDD §3.1) | — |
| src/OpenMotion.Core/Lockstep/InputCommand.cs | C# (Core) | neu | Einzelne Spielereingabe (25-Byte-Binärformat, CommandType-Enum) | — |
| src/OpenMotion.Core/Lockstep/InputFrame.cs | C# (Core) | neu | Alle Eingaben eines Spielers pro Tick (Header + Kommandos) | — |
| src/OpenMotion.Core/Lockstep/LockstepSession.cs | C# (Core) | neu | Lockstep-Session: Frames puffern, Ticks verarbeiten, Hash alle 10 Ticks | — |
| src/OpenMotion.Core/Lockstep/ReplayLog.cs | C# (Core) | neu | Append-only Eingabe-Log (IReplayStore/InMemoryReplayStore) | — |
| src/OpenMotion.Core/Lockstep/TickHash.cs | C# (Core) | neu | FNV-1a 64-Hash (Desync-Erkennung, NDD §5.1) | — |
| src/OpenMotion.Core/OpenMotion.Core.csproj | Konfiguration | neu | Core-Bibliothek (net8.0, nullable, implicit usings) | — |
| src/OpenMotion.Core/Serialization/BinarySimSerializer.cs | C# (Core) | neu | Deterministische JSON-Serialisierung (System.Text.Json, Fix32-as-long) + Converter | — |
| src/OpenMotion.Core/Serialization/ISimSerializer.cs | C# (Core) | neu | Serialisierungs-Schnittstelle (NDD §3.5) | — |
| src/OpenMotion.Core/Serialization/ReplayExporter.cs | C# (Core) | neu | Replay-Export/Import als JSON (Format-Version 1, hart geprüft) | — |
| src/OpenMotion.Core/SimState.cs | C# (Core) | neu | Deterministischer Sim-Kern (M1): Seed, Tick, RNG (System.Random, M2-Basis) | — |
| src/OpenMotion.Core/Simulation/DebugReplayValidator.cs | C# (Core) | neu | Vergleich zweier Orchestrator-Läufe (Hash-Abweichungen, NDD §5.2) | — |
| src/OpenMotion.Core/Simulation/ISimulationSubsystem.cs | C# (Core) | neu | Subsystem-Schnittstelle: Name, Tick(SimContext), GetStateHash | — |
| src/OpenMotion.Core/Simulation/SimContext.cs | C# (Core) | neu | Tick-Kontext: Master-Seed, Seed-Ableitung, Fix32-Tick-Konstanten | — |
| src/OpenMotion.Core/Simulation/SimulationOrchestrator.cs | C# (Core) | neu | Tick-Loop: Subsysteme in fester Reihenfolge, Ganzzustands-Hash | — |
| src/OpenMotion.Core/Transit/Line.cs | C# (Core) | neu | Linie: Haltestellenfolge, Takt, Fahrzeuge, Fahrzeit (GDD 8) | — |
| src/OpenMotion.Core/Transit/PassengerFlow.cs | C# (Core) | neu | Deterministischer Fahrgast-Wechsel: Ein-/Ausstieg (Kapazität, FIFO) | — |
| src/OpenMotion.Core/Transit/Stop.cs | C# (Core) | neu | Haltestelle: Fix32-Position, i18n-Name, ZoneIndex | — |
| src/OpenMotion.Core/Transit/TransitMath.cs | C# (Core) | neu | Deterministische Distanz + Fix32-Quadratwurzel (Integer-Newton) | — |
| src/OpenMotion.Core/Transit/TransitNetwork.cs | C# (Core) | neu | Netz-Verwaltung: Stops/Lines/Vehicles, deterministische IDs | — |
| src/OpenMotion.Core/Transit/Vehicle.cs | C# (Core) | neu | Fahrzeug: Typ, Linien-Zuordnung, Passagiere, Kapazität, Position | — |
| src/OpenMotion.Core/Transit/VehicleMovementSystem.cs | C# (Core) | neu | Fahrzeug-Bewegung + Fahrgastwechsel entlang der Route (M4) | — |
| src/OpenMotion.Core/Transit/VehicleType.cs | C# (Core) | neu | VehicleType-Enum + VehicleTypeParams (Kapazität/Speed/Kosten) | — |
| sync-openmotion.sh | Werkzeug | neu | Auto-Sync OpenMotion → GitHub (git add -A && commit && push) | — |

## Detail-Sektionen (nur geänderte/neue Dateien)

*Initial-Scan (2026-08-09T12:34:03+02:00): alle 93 Dateien neu — vollständige Analyse in [[functions]] und [[dependencies]].*
