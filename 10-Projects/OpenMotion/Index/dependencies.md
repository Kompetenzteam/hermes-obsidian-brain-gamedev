---
tags: [index, openmotion, dependencies]
created: 2026-08-09
updated: 2026-08-09
project: OpenMotion
---

# OpenMotion — Abhängigkeiten

> Wird vom **stündlichen Projekt-Index-Cronjob** (ADR-007) befüllt: Abhängigkeiten pro Datei (using/import/extends/implements/include) sowie Kernmodule.

## Abhängigkeiten

### OpenMotion.Core (Sim-Kern, net8.0, keine externen Pakete)

| Datei | Abhängigkeiten (using/extends/implements) |
|-------|-------------------------------------------|
| Fix32.cs | System.Globalization (InvariantCulture) |
| DeterministicRandom.cs | Fix32 (Rückgabetyp NextDouble) |
| SimState.cs | System.Random (M1-Basis; laut Kommentar Ersatz durch DeterministicRandom geplant) |
| Lockstep/InputCommand.cs | System.Buffers.Binary; definiert CommandType |
| Lockstep/InputFrame.cs | System.Buffers.Binary; InputCommand |
| Lockstep/ReplayLog.cs | InputFrame; definiert IReplayStore, InMemoryReplayStore |
| Lockstep/LockstepSession.cs | System.Buffers.Binary; SimState, ReplayLog, InputFrame, TickHash, IReplayStore |
| Lockstep/TickHash.cs | — (reine Funktion) |
| Simulation/ISimulationSubsystem.cs | — (definiert die Schnittstelle) |
| Simulation/SimContext.cs | OpenMotion.Core.Lockstep (LockstepSession.HashIntervalTicks); Fix32 |
| Simulation/SimulationOrchestrator.cs | System.Buffers.Binary, System.Text; Lockstep (TickHash); SimContext, ISimulationSubsystem |
| Simulation/DebugReplayValidator.cs | SimulationOrchestrator |
| Serialization/ISimSerializer.cs | — |
| Serialization/BinarySimSerializer.cs | System.Text.Json; Fix32, InputCommand, InputFrame (Converter) |
| Serialization/ReplayExporter.cs | System.Text.Json; Lockstep (ReplayLog, InputFrame), BinarySimSerializer |
| Transit/VehicleType.cs | Fix32 |
| Transit/Stop.cs | Fix32 |
| Transit/Vehicle.cs | VehicleType (VehicleTypeParams), Fix32 |
| Transit/Line.cs | Stop, Vehicle, VehicleType (VehicleTypeParams), TransitMath, Fix32 |
| Transit/TransitNetwork.cs | Stop, Line, Vehicle |
| Transit/TransitMath.cs | Stop, Fix32 |
| Transit/PassengerFlow.cs | Vehicle, Stop (WaitingPassenger-Definition) |
| Transit/VehicleMovementSystem.cs | Line, Stop, Vehicle, VehicleTypeParams, PassengerFlow, WaitingPassenger, TransitMath, Fix32 |
| Citizens/Citizen.cs | Fix32, DeterministicRandom (CitizenSchedule.Generate); definiert CitizenState, CitizenSchedule |
| Citizens/CitizenSystem.cs | Citizen, ITransitNetwork, DeterministicRandom, Fix32 |
| Citizens/RoutingPreference.cs | Fix32; definiert RouteOption |
| City/Building.cs | Position, Fix32; definiert BuildingType |
| City/Infrastructure.cs | Position, TransportSegment, Stop, SegmentType, Fix32 |
| City/CityGrowthSystem.cs | Infrastructure, TransportSegment, Position, INetworkQuality, Building, BuildingType, DeterministicRandom, Fix32 |
| Economy/FareSystem.cs | Fix32; definiert IFarePolicy, GlobalFarePolicy |
| Economy/LineEconomicStatus.cs | Fix32 |
| Economy/EconomySystem.cs | Fix32, LineEconomicStatus |

### Godot-Seite (Engine)

| Datei | Abhängigkeiten |
|-------|----------------|
| OpenMotion.csproj | Godot.NET.Sdk/4.7.1; ProjectReference → OpenMotion.Core.csproj; Compile-Remove `src/**/*.cs` |
| OpenMotion.sln | Enthält OpenMotion, OpenMotion.Core, OpenMotion.Core.Tests |
| project.godot | main_scene = scenes/Main.tscn; Assembly OpenMotion; i18n: de/en ui.po; GL Compatibility |
| scenes/Main.tscn | ext_resource → scripts/SimulationRunner.cs |
| scenes/vehicles/Bus.tscn / Tram.tscn / Metro.tscn | ext_resource → scenes/vehicles/VehicleColor.cs |
| scripts/SimulationRunner.cs | Godot; OpenMotion.Core, .Citizens, .City, .Economy, .Lockstep, .Simulation, .Transit; : Node; implementiert ISimulationSubsystem (Adapter), ITransitNetwork (Bridge) |
| scenes/vehicles/VehicleColor.cs | Godot; : Node3D |

### Tests (xUnit, net8.0)

| Datei | Abhängigkeiten |
|-------|----------------|
| OpenMotion.Core.Tests.csproj | ProjectReference → OpenMotion.Core; xunit 2.9.2, Microsoft.NET.Test.Sdk 17.11.1, xunit.runner.visualstudio 2.8.2 |
| CitizensTests.cs | OpenMotion.Core.Citizens, Xunit; ITransitNetwork (Test-Double AlwaysAvailableNetwork) |
| CityGrowthTests.cs | OpenMotion.Core.City, Xunit |
| DeterministicRandomTests.cs | OpenMotion.Core, Xunit |
| EconomySystemTests.cs | OpenMotion.Core.Economy, Xunit; DeterministicRandom (Test-Befehlsquelle) |
| Fix32Tests.cs | OpenMotion.Core, Xunit |
| LockstepTests.cs | OpenMotion.Core.Lockstep, Xunit; InMemoryReplayStore |
| SerializationTests.cs | OpenMotion.Core.Serialization + .Lockstep, System.Text.Json, Xunit |
| SimStateTests.cs | OpenMotion.Core, Xunit |
| SimulationIntegrationTests.cs | OpenMotion.Core.Simulation + .Lockstep, System.Buffers.Binary, Xunit; ISimulationSubsystem (Fake) |
| TransitTests.cs | OpenMotion.Core + .Transit, Xunit |
| VehicleMovementTests.cs | OpenMotion.Core + .Transit, Xunit; PassengerFlow, WaitingPassenger |

### CI / Werkzeuge

| Datei | Abhängigkeiten |
|-------|----------------|
| .github/workflows/ci.yml | actions/checkout@v4, actions/setup-dotnet@v4 (8.x), chickensoft-games/setup-godot@v2 (4.7.1); godot headless --import/--build-solutions, dotnet build/test |
| i18n/check_parity.py | Python 3, re/os/sys (keine externen Pakete) |
| assets/logo/_*.py | PIL, numpy, vtracer, resvg_py (Werkzeug-Pipeline, nicht im Build) |
| sync-openmotion.sh | git, bash |

## Impact-Map (Initial-Scan: alle 93 Dateien neu)

*Bei Änderungen an Kernmodulen sind folgende Dateien potenziell betroffen (aus den Abhängigkeiten abgeleitet):*

- **Fix32.cs** → DeterministicRandom, SimContext, alle Transit-/Citizens-/City-/Economy-Dateien, SimulationOrchestrator (Hash), BinarySimSerializer (Converter), VehicleColor (indirekt über Szenen nicht), Tests (Fix32Tests, TransitTests, VehicleMovementTests, EconomySystemTests, CitizensTests, CityGrowthTests, DeterministicRandomTests, SerializationTests, SimulationIntegrationTests)
- **DeterministicRandom.cs** → Citizen.cs (Schedule.Generate), CitizenSystem, CityGrowthSystem, EconomySystemTests (Testquelle)
- **TickHash.cs** → LockstepSession, SimulationOrchestrator, SimulationRunner (Adapter-Hash), SimulationIntegrationTests, LockstepTests
- **InputCommand.cs / InputFrame.cs** → LockstepSession, ReplayLog, BinarySimSerializer (Converter), ReplayExporter, alle Lockstep-/Serialization-Tests
- **ISimulationSubsystem / SimContext** → SimulationOrchestrator, SimulationRunner (4 Adapter), SimulationIntegrationTests
- **SimulationOrchestrator** → DebugReplayValidator, SimulationRunner, SimulationIntegrationTests
- **VehicleType.cs (VehicleTypeParams)** → Line, Vehicle, VehicleMovementSystem, TransitTests, VehicleMovementTests
- **PassengerFlow.cs / VehicleMovementSystem.cs** → SimulationRunner (Transit-Hash via Adapter), VehicleMovementTests, TransitTests
- **ITransitNetwork** → CitizenSystem, SimulationRunner (CitizenTransitBridge), CitizensTests
- **LineEconomicStatus.cs** → EconomySystem.ApplySubsidies, EconomySystemTests
- **ISimSerializer / BinarySimSerializer** → ReplayExporter, SerializationTests
- **Godot-Szenen (Bus/Tram/Metro.tscn)** → VehicleColor.cs (Skript-Bindung), CHANGELOG

## Kernmodule

| Modul | Dateien | Rolle |
|-------|---------|-------|
| **Fixed-Point-Arithmetik** | Fix32.cs, DeterministicRandom.cs | Basis aller Sim-Rechnung: bit-identisch auf allen Plattformen (NDD §3.1/§3.2); kein float/double im Sim-Pfad |
| **Lockstep-Kern (M2)** | LockstepSession.cs, InputCommand.cs, InputFrame.cs, ReplayLog.cs, TickHash.cs, SimState.cs | Eingabe-Frames, Jitter-Puffer, Replay-Log, FNV-1a-64-Hash, Tick-Loop — Grundlage für Desync-freies Multiplayer (NDD §2/§5) |
| **Simulation-Orchestrierung (M3)** | SimulationOrchestrator.cs, SimContext.cs, ISimulationSubsystem.cs, DebugReplayValidator.cs | Tick-Loop mit fester Subsystem-Reihenfolge, Ganzzustands-Hash alle 10 Ticks, Replay-Verifikation (NDD §3.4/§5) |
| **Serialisierung** | ISimSerializer.cs, BinarySimSerializer.cs, ReplayExporter.cs | Deterministisches JSON (Fix32-as-long), Replay-Export/Import mit Format-Version (NDD §3.5/§5.3) |
| **Wirtschaft (M3)** | EconomySystem.cs, FareSystem.cs, LineEconomicStatus.cs | Budget, Tarife (ODF-2), Zwangsentleihe mit wachsenden Zinsen (ODF-4), bedarfsbasierte Subventionen (ODF-5) |
| **Bewohner (M3)** | Citizen.cs, CitizenSystem.cs, RoutingPreference.cs | SIM-Agenten (10k+ Ziel), deterministische Tagespläne, Fahrgast-Wahlmodell (ODF-3), Integrations-Naht ITransitNetwork |
| **Transit (M3/M4)** | TransitNetwork.cs, Line.cs, Stop.cs, Vehicle.cs, VehicleType.cs, TransitMath.cs, PassengerFlow.cs, VehicleMovementSystem.cs | Netz-Datenmodell mit deterministischen IDs, Linien/Fahrzeuge, Fahrgast-Wechsel, Bewegung entlang der Route |
| **Stadt (M3)** | Infrastructure.cs, Building.cs, CityGrowthSystem.cs | Gebaute Infrastruktur (Segmente/Haltestellen), automatisches Wachstum entlang der Wege (GDD 4) |
| **Godot-Integration (M4)** | scripts/SimulationRunner.cs, scenes/vehicles/VehicleColor.cs, scenes/*.tscn | 30-Hz-Tick-Akkumulator in der Engine, deterministische Subsystem-Adapter, prozedurale Fahrzeugmodelle |
| **Tests** | src/OpenMotion.Core.Tests/*.cs (11 Suiten) | xUnit: Determinismus-, Roundtrip- und Validierungsabdeckung (ADR-004/006); CI auf Windows+Linux |
| **i18n** | i18n/de|en/LC_MESSAGES/ui.po, i18n/check_parity.py | DE = Spielsprache (ADR-004), EN zweite Sprache; Paritäts-Gate |
| **CI/CD** | .github/workflows/ci.yml | Headless-Import + Build + Lockstep-Tests auf windows-latest/ubuntu-latest |
