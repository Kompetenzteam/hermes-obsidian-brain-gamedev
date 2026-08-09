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
| Map/MapData.cs | OpenMotion.Core.City (Infrastructure, Stop, Position, SegmentType); Fix32 |
| Map/MapGenerator.cs | OpenMotion.Core.City (Infrastructure, Position, SegmentType); DeterministicRandom, Fix32; definiert MapData |
| Map/MapSerializer.cs | System.Text.Json (Utf8JsonWriter/JsonDocument); MapData, Infrastructure, SegmentType, Position, Fix32 |
| Networking/ITransport.cs | — (definiert die Schnittstelle) |
| Networking/InMemoryTransport.cs | ITransport; DeterministicRandom (Jitter); definiert TransportWire |
| Networking/Netcode.cs | System.Buffers.Binary; Lockstep (InputFrame); definiert NetMessageType, DesyncReport |
| Networking/P2PSession.cs | Networking (Netcode, DesyncReport, NetMessageType, ITransport); Lockstep (InputFrame) |
| Multiplayer/IMultiplayerTransport.cs | — (definiert TransportMessage + Schnittstelle) |
| Multiplayer/SessionConfig.cs | Simulation (SimContext.SimTickRate) |
| Multiplayer/MultiplayerWire.cs | System.Buffers.Binary; Lockstep (InputFrame); SessionConfig.MaxPlayers (DecodeTickInput); definiert WireMessage |
| Multiplayer/NetworkingTransportAdapter.cs | System.Globalization; Networking (ITransport); implementiert IMultiplayerTransport |
| Multiplayer/MultiplayerSession.cs | Lockstep (LockstepSession, InputFrame, HashIntervalTicks); Multiplayer (SessionConfig, IMultiplayerTransport, MultiplayerWire); definiert MultiplayerSessionState, DesyncEvent |
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
| OpenMotion.csproj | Godot.NET.Sdk/4.7.1; ProjectReference → OpenMotion.Core.csproj; PackageReference Steamworks.NET 2024.8.0 (SDK 1.60); None libs/win-x64/steam_api64.dll → Output; Compile-Remove `src/**/*.cs` |
| OpenMotion.sln | Enthält OpenMotion, OpenMotion.Core, OpenMotion.Core.Tests |
| project.godot | main_scene = scenes/Main.tscn; Assembly OpenMotion; Autoload: LocalizationManager + SteamManager; [input] 8 Kamera-Actions; i18n: de/en ui.po; GL Compatibility |
| scenes/Main.tscn | ext_resource → scripts/SimulationRunner.cs |
| scenes/city/CityView.tscn | ext_resource → scripts/MapRenderer.cs, scripts/CameraController.cs, scripts/EnvironmentBuilder.cs (M6.6); Sun-Knoten deklarativ warm (light_energy 1.15, light_color) |
| scenes/ui/HUD.tscn | ext_resource → scripts/HUD.cs |
| scenes/vehicles/Bus.tscn / Tram.tscn / Metro.tscn | ext_resource → scenes/vehicles/VehicleColor.cs |
| scripts/SimulationRunner.cs | Godot; OpenMotion.Core (.Map, .Citizens, .City, .Economy, .Lockstep, .Simulation, .Transit); : Node; implementiert ISimulationSubsystem (Adapter), ITransitNetwork (Bridge); M6.6: Referenzkarte aus MapGenerator.Generate (Wachstums-Infrastruktur + Rendering + Demo-Linie geteilt), instanziiert VehicleVisualizer + BuildingVisualizer (SetupBuildingVisualizer, `_cityGrowth.Growth`) via CityView.tscn |
| scripts/BuildingVisualizer.cs | Godot; OpenMotion.Core.City (CityGrowthSystem, Building, BuildingType, Position); Fix32 (Position.ToDouble in ToWorld); : Node3D; Kind der CityView (vom SimulationRunner instanziiert) |
| scripts/CameraController.cs | Godot; : Camera3D; Input-Actions aus project.godot [input] (camera_orbit/zoom/pan_*/height_*) |
| scripts/EnvironmentBuilder.cs | Godot (Node3D, MeshInstance3D, BoxMesh, WorldEnvironment, ProceduralSkyMaterial, DirectionalLight3D, StandardMaterial3D); System.Globalization (CultureInfo.InvariantCulture); Knoten in scenes/city/CityView.tscn |
| scripts/HUD.cs | Godot; LocalizationManager (LanguageChanged-Event); Tr() i18n |
| scripts/LocalizationManager.cs | Godot (TranslationServer, ResourceLoader, Translation); i18n/de+en/LC_MESSAGES/ui.po |
| scripts/MapRenderer.cs | Godot; OpenMotion.Core.City (Infrastructure, TransportSegment, Stop, Position, SegmentType); Fix32 (ToWorld) |
| scripts/SteamManager.cs | Godot; Steamworks.NET (SteamAPI, SteamFriends); System.Runtime.InteropServices (NativeLibrary) |
| scripts/VehicleVisualizer.cs | Godot; OpenMotion.Core (Fix32), OpenMotion.Core.Transit (TransitNetwork, Vehicle, Line, VehicleType); VehicleColor (LineColor-Export); Szenen res://scenes/vehicles/*.tscn |
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
| InMemoryTransport.cs (Tests) | OpenMotion.Core.Multiplayer (IMultiplayerTransport, TransportMessage); definiert InMemoryTransportHub + InMemoryTransport (Test-Double) |
| LockstepTests.cs | OpenMotion.Core.Lockstep, Xunit; InMemoryReplayStore |
| MapTests.cs | OpenMotion.Core.City + .Map (MapGenerator, MapData, MapSerializer), System.Text/Text.Json, Xunit |
| MultiplayerSessionTests.cs | OpenMotion.Core.Lockstep + .Multiplayer + .Simulation, OpenMotion.Core.Tests.Multiplayer (Test-Double), Xunit |
| NetworkingIntegrationTests.cs | OpenMotion.Core.Lockstep + .Multiplayer + .Networking (TransportWire, InMemoryTransport, NetworkingTransportAdapter), Xunit |
| NetworkingTests.cs | System.Buffers.Binary; OpenMotion.Core.Lockstep + .Networking (TransportWire, InMemoryTransport, Netcode, P2PSession), Xunit |
| SerializationTests.cs | OpenMotion.Core.Serialization + .Lockstep, System.Text.Json, Xunit |
| SimStateTests.cs | OpenMotion.Core, Xunit |
| SimulationIntegrationTests.cs | OpenMotion.Core.Simulation + .Lockstep, System.Buffers.Binary, Xunit; ISimulationSubsystem (Fake) |
| TransitTests.cs | OpenMotion.Core + .Transit, Xunit |
| VehicleMovementTests.cs | OpenMotion.Core + .Transit, Xunit; PassengerFlow, WaitingPassenger |

### CI / Werkzeuge / Export

| Datei | Abhängigkeiten |
|-------|----------------|
| .github/workflows/ci.yml | actions/checkout@v4, actions/setup-dotnet@v4 (8.x), chickensoft-games/setup-godot@v2 (4.7.1); godot headless --import/--build-solutions, dotnet build/test |
| i18n/check_parity.py | Python 3, re/os/sys (keine externen Pakete) |
| assets/logo/_*.py | PIL, numpy, vtracer, resvg_py (Werkzeug-Pipeline, nicht im Build) |
| sync-openmotion.sh | git, bash |
| export_presets.cfg | Godot-Export: Windows Desktop, x86_64, embed_pck; Icon res://assets/logo/logo_clean.png; Ziel build/openmotion_windows.exe |
| docs/STEAMWORKS_SETUP_ANLEITUNG.md | Steamworks-Partnerkonto, App-ID, SDK, Spacewar-Testapp (Doku, keine Code-Abhängigkeit) |

## Impact-Map (Stand 2026-08-09, nach M6.6)

*Bei Änderungen an Kernmodulen sind folgende Dateien potenziell betroffen (aus den Abhängigkeiten abgeleitet):*

- **Fix32.cs** → DeterministicRandom, SimContext, alle Transit-/Citizens-/City-/Economy-/Map-Dateien (Koordinaten), SimulationOrchestrator (Hash), BinarySimSerializer (Converter), MapSerializer (Raw), MapRenderer/VehicleVisualizer (ToDouble), Tests (Fix32Tests, TransitTests, VehicleMovementTests, EconomySystemTests, CitizensTests, CityGrowthTests, DeterministicRandomTests, SerializationTests, SimulationIntegrationTests, MapTests)
- **DeterministicRandom.cs** → Citizen.cs (Schedule.Generate), CitizenSystem, CityGrowthSystem, MapGenerator (Geometrie), InMemoryTransport (Jitter), EconomySystemTests (Testquelle), NetworkingTests
- **TickHash.cs** → LockstepSession, SimulationOrchestrator, SimulationRunner (Adapter-Hash), SimulationIntegrationTests, LockstepTests
- **InputCommand.cs / InputFrame.cs** → LockstepSession, ReplayLog, BinarySimSerializer (Converter), ReplayExporter, MultiplayerWire (Encode/Decode), Netcode (EncodeInputFrame), P2PSession, MultiplayerSession, alle Lockstep-/Serialization-/Networking-/Multiplayer-Tests
- **ISimulationSubsystem / SimContext** → SimulationOrchestrator, SimulationRunner (4 Adapter), SessionConfig (SimTickRate), SimulationIntegrationTests
- **SimulationOrchestrator** → DebugReplayValidator, SimulationRunner, SimulationIntegrationTests
- **VehicleType.cs (VehicleTypeParams)** → Line, Vehicle, VehicleMovementSystem, VehicleVisualizer (ScenePathFor), TransitTests, VehicleMovementTests
- **PassengerFlow.cs / VehicleMovementSystem.cs** → SimulationRunner (TransitSubsystem-Tick, M6.5), VehicleMovementTests, TransitTests
- **ITransitNetwork** → CitizenSystem, SimulationRunner (CitizenTransitBridge), CitizensTests
- **LineEconomicStatus.cs** → EconomySystem.ApplySubsidies, EconomySystemTests
- **ISimSerializer / BinarySimSerializer** → ReplayExporter, SerializationTests
- **Infrastructure.cs (City)** → CityGrowthSystem, MapData, MapGenerator, MapSerializer, MapRenderer (Render), SimulationRunner (Start-Setup), CityGrowthTests, MapTests
- **MapData.cs / MapGenerator.cs / MapSerializer.cs** → SimulationRunner (SetupCityView, _referenceMap, ReferenceMapSeed, Demo-Linie), MapRenderer (Infrastructure-Konsum), BuildingVisualizer (Wachstums-Infrastruktur), MapTests (M6.6: Dichte-Test-Erwartungen), CHANGELOG; MapSerializer unabhängig von Godot. **M6.6-Folge:** längere Demo-Route (1737,8 m statt 1297,4 m) ändert Transit-Hashes — Determinismus bleibt bit-identisch, Baselines verschieben sich (dokumentiert im CHANGELOG)
- **CityGrowthSystem.cs** → BuildingVisualizer (GetBuildings, nur Lesen), SimulationRunner (CityGrowthSubsystem.Growth-Exposé, M6.6), CityGrowthTests, SimulationIntegrationTests
- **ITransport.cs** → InMemoryTransport, P2PSession, NetworkingTransportAdapter, NetworkingTests, NetworkingIntegrationTests; später SteamTransport (Parallel-Agent)
- **InMemoryTransport.cs / TransportWire** → P2PSession, NetworkingTests, NetworkingIntegrationTests (Test-Stacks)
- **Netcode.cs** → P2PSession, NetworkingTests; Drahtformat-Änderung bricht alle Peers (NDD §4.3)
- **IMultiplayerTransport.cs** → MultiplayerSession, NetworkingTransportAdapter, Tests-InMemoryTransport (Test-Double)
- **MultiplayerSession.cs / MultiplayerWire.cs / SessionConfig.cs** → MultiplayerSessionTests, NetworkingIntegrationTests; MultiplayerWire-Format einmal vergeben, nie ändern (NDD §4.4)
- **MapRenderer.cs / CityView.tscn** → SimulationRunner (SetupCityView); EnvironmentBuilder (Knoten in CityView, Sun-Justierung); CHANGELOG
- **BuildingVisualizer.cs** (M6.6, neu) → SimulationRunner (SetupBuildingVisualizer, M6.6-Hook in _PhysicsProcess, _ExitTree-Bericht), CityGrowthSystem (GetBuildings, nur Lesen), CityView.tscn (Parent-Knoten), CHANGELOG
- **EnvironmentBuilder.cs** (M6.6, neu) → CityView.tscn (Knoten + Skript-Bindung, load_steps 4), Sun-Knoten der CityView (warme Voreinstellung + Laufzeit-Justierung), CHANGELOG
- **MapTests.cs** (M6.6, +1) → MapGenerator-Erwartungen (Stadt-Quadranten-Dichte, 12–20 Stops); Test-Anpassungen nötig, falls der Generator die Geometrie-Verträge ändert
- **CameraController.cs** → CityView.tscn (Skript-Bindung); project.godot [input] (Actions)
- **LocalizationManager.cs** → HUD.cs (LanguageChanged), project.godot (Autoload); i18n/de+en/ui.po
- **SteamManager.cs** → OpenMotion.csproj (Steamworks.NET), libs/win-x64/steam_api64.dll, project.godot (Autoload)
- **VehicleVisualizer.cs** → SimulationRunner (M6.5-Hook), VehicleColor.cs, scenes/vehicles/*.tscn
- **Godot-Szenen (Bus/Tram/Metro.tscn)** → VehicleColor.cs (Skript-Bindung), VehicleVisualizer (Instanziierung), CHANGELOG
- **project.godot** → SimulationRunner (Autoload-Kette), CameraController (Input-Actions), LocalizationManager/SteamManager (Autoload), Main.tscn
- **OpenMotion.csproj** → SteamManager (Steamworks.NET), alle Godot-Skripte (Kompilierung), steam_api64.dll

## Kernmodule

| Modul | Dateien | Rolle |
|-------|---------|-------|
| **Fixed-Point-Arithmetik** | Fix32.cs, DeterministicRandom.cs | Basis aller Sim-Rechnung: bit-identisch auf allen Plattformen (NDD §3.1/§3.2); kein float/double im Sim-Pfad |
| **Lockstep-Kern (M2)** | LockstepSession.cs, InputCommand.cs, InputFrame.cs, ReplayLog.cs, TickHash.cs, SimState.cs | Eingabe-Frames, Jitter-Puffer, Replay-Log, FNV-1a-64-Hash, Tick-Loop — Grundlage für Desync-freies Multiplayer (NDD §2/§5) |
| **Simulation-Orchestrierung (M3)** | SimulationOrchestrator.cs, SimContext.cs, ISimulationSubsystem.cs, DebugReplayValidator.cs | Tick-Loop mit fester Subsystem-Reihenfolge, Ganzzustands-Hash alle 10 Ticks, Replay-Verifikation (NDD §3.4/§5) |
| **Serialisierung** | ISimSerializer.cs, BinarySimSerializer.cs, ReplayExporter.cs | Deterministisches JSON (Fix32-as-long), Replay-Export/Import mit Format-Version (NDD §3.5/§5.3) |
| **Referenzkarte (M6)** | Map/MapData.cs, Map/MapGenerator.cs, Map/MapSerializer.cs | Seed → deterministische Start-Karte (Straßenkreuz + Schienenkorridor + 8 Stops), JSON mit Format-Version 1 (NDD §3.2/§3.5) |
| **Netz-Transport (M5)** | Networking/ITransport.cs, InMemoryTransport.cs (TransportWire), Netcode.cs, P2PSession.cs | Steam-freies Transport-Interface, tick-basierte deterministische Fake-Latenz, Draht-Framing, P2P-Frame-Verteilung (NDD §4) |
| **Multiplayer-Session (M5)** | Multiplayer/MultiplayerSession.cs, SessionConfig.cs, MultiplayerWire.cs, IMultiplayerTransport.cs, NetworkingTransportAdapter.cs | Star-Topologie Host/Client: Seed-Verteilung, Tick-Barriere, deterministische Konsolidierung, Hash-Vergleich/Desync-Erkennung (NDD §1.3/§2.2/§5.2/§7.1) |
| **Wirtschaft (M3)** | EconomySystem.cs, FareSystem.cs, LineEconomicStatus.cs | Budget, Tarife (ODF-2), Zwangsentleihe mit wachsenden Zinsen (ODF-4), bedarfsbasierte Subventionen (ODF-5) |
| **Bewohner (M3)** | Citizen.cs, CitizenSystem.cs, RoutingPreference.cs | SIM-Agenten (10k+ Ziel), deterministische Tagespläne, Fahrgast-Wahlmodell (ODF-3), Integrations-Naht ITransitNetwork |
| **Transit (M3/M4)** | TransitNetwork.cs, Line.cs, Stop.cs, Vehicle.cs, VehicleType.cs, TransitMath.cs, PassengerFlow.cs, VehicleMovementSystem.cs | Netz-Datenmodell mit deterministischen IDs, Linien/Fahrzeuge, Fahrgast-Wechsel, Bewegung entlang der Route |
| **Stadt (M3)** | Infrastructure.cs, Building.cs, CityGrowthSystem.cs | Gebaute Infrastruktur (Segmente/Haltestellen), automatisches Wachstum entlang der Wege (GDD 4) |
| **Godot-Integration (M4→M6.6)** | scripts/SimulationRunner.cs, CameraController.cs, MapRenderer.cs, VehicleVisualizer.cs, BuildingVisualizer.cs, EnvironmentBuilder.cs, scenes/*.tscn, VehicleColor.cs | 30-Hz-Tick-Akkumulator, deterministische Subsystem-Adapter, Referenzkarten-Rendering, Orbit-Kamera, Fahrzeug-Visualisierung, Gebäude-Visualisierung (M6.6), Umgebung (Boden/Himmel/Sonne, M6.6), prozedurale Fahrzeugmodelle |
| **i18n (M6)** | scripts/LocalizationManager.cs, scripts/HUD.cs, scenes/ui/HUD.tscn, i18n/de|en/LC_MESSAGES/ui.po | DE = Spielsprache (ADR-004), EN zweite Sprache, LanguageChanged-Event, Paritäts-Gate |
| **Steamworks (M5)** | scripts/SteamManager.cs, OpenMotion.csproj (Steamworks.NET), libs/win-x64/steam_api64.dll, docs/STEAMWORKS_SETUP_ANLEITUNG.md | SteamAPI-Init/Shutdown (App-ID 480), crash-sicher, headless-CI-tauglich; Sim-Kern bleibt Steam-frei |
| **Tests** | src/OpenMotion.Core.Tests/*.cs (16 Suiten inkl. M5/M6-Neu) | xUnit: Determinismus-, Roundtrip-, Netz- und Validierungsabdeckung (ADR-004/006); CI auf Windows+Linux |
| **CI/CD + Export** | .github/workflows/ci.yml, export_presets.cfg | Headless-Import + Build + Tests auf windows-latest/ubuntu-latest; Windows-Desktop-Export (build/openmotion_windows.exe) |
