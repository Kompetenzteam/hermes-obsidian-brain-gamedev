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
| .github/workflows/ci.yml | CI/CD | unverändert | GitHub-Actions-Workflow: Build + Lockstep-Tests auf Windows/Linux | — |
| .gitignore | Konfiguration | unverändert | Git-Ignore-Regeln (Godot, .NET, IDE) | — |
| .hermes/environment.json | Konfiguration | unverändert | Hermes-Build-/Test-Recipe (dotnet build/test OpenMotion.sln) | — |
| assets/logo/_analyze3.py | Werkzeug | unverändert | Logo-Analyse: Connected Components + Farbstatistik | — |
| assets/logo/_analyze4.py | Werkzeug | unverändert | Logo-Analyse: Eckfarben + Top-8-Farben | — |
| assets/logo/_analyze5.py | Werkzeug | unverändert | Logo-Analyse: exakte Farbzählung im Vordergrund | — |
| assets/logo/_analyze6.py | Werkzeug | unverändert | Logo-Analyse: modale Farben pro 40×40-Raster | — |
| assets/logo/_analyze7.py | Werkzeug | unverändert | Logo-Analyse: 'other'-Regionen (nicht weiß/dunkel/blau/grün) | — |
| assets/logo/_ascii.py | Werkzeug | unverändert | Logo-Klassifikation als ASCII-Farbkarte | — |
| assets/logo/_clean_test.py | Werkzeug | unverändert | Logo-Cleanup-Experiment (Masken + Komponenten) | — |
| assets/logo/_clean_viz.py | Werkzeug | unverändert | Logo-Cleanup-Visualisierung | — |
| assets/logo/_colors.py | Werkzeug | unverändert | Logo-Farbanalyse (ohne Feather) | — |
| assets/logo/_final.py | Werkzeug | unverändert | Finale Logo-Pipeline: Feather + Vektorisierung (vtracer) + resvg-Verify | — |
| assets/logo/_pipeline.py | Werkzeug | unverändert | Logo-Pipeline: Hintergrund-/Rausch-Entfernung + SVG via vtracer | — |
| assets/logo/_render_check.py | Werkzeug | unverändert | Feather-Sweep + SVG-Render-ASCII-Check | — |
| assets/logo/_vectorize.py | Werkzeug | unverändert | Optimierte Vektorisierung: Farbquantisierung + vtracer | — |
| assets/logo/_verify_gray.py | Werkzeug | unverändert | Grau-Reste-Verifikation des bereinigten Logos | — |
| assets/logo/logo_clean.ico | Asset (ICO) | neu | App-Icon (aus logo_clean.svg konvertiert), in export_presets.cfg referenziert | — |
| assets/logo/logo_clean.svg | Asset (SVG) | unverändert | Bereinigtes Logo (vtracer, 443×224) | — |
| assets/logo/logo_nobg.svg | Asset (SVG) | unverändert | Logo ohne Hintergrund (vtracer, 443×224, roh) | — |
| assets/logo/logo_simple.svg | Asset (SVG) | unverändert | Vereinfachtes Logo (vtracer, 443×224) | — |
| assets/logo/logo_simple_fixed.svg | Asset (SVG) | unverändert | Finales vereinfachtes Logo (443×224) | — |
| assets/src/bus.svg | Asset (SVG) | unverändert | Referenz-Silhouette Bus (Wikimedia, Inkscape) | — |
| assets/src/bus2.svg | Asset (SVG) | unverändert | Referenz-Silhouette Bus 2 (Illustrator) | — |
| assets/src/bus3.svg | Asset (SVG) | unverändert | Referenz-Silhouette Bus 3 (Inkscape) | — |
| assets/src/bus_search.json | Asset (Daten) | unverändert | Wikimedia-Commons-Suchergebnis für Bus-Silhouetten | — |
| assets/src/conecto_url.txt | Asset (Text) | unverändert | Quell-URL: Mercedes Conecto-Silhouette (Wikimedia) | — |
| assets/src/ice_url.txt | Asset (Text) | unverändert | Quell-URL: ICE-T-Front (Wikimedia) | — |
| assets/src/icefront.svg | Asset (SVG) | unverändert | Referenz-Silhouette ICE-Front (Inkscape) | — |
| assets/src/train.svg | Asset (SVG) | unverändert | Referenz-Silhouette Zug (Inkscape) | — |
| assets/src/tram.svg | Asset (SVG) | unverändert | Referenz-Silhouette Tram (Illustrator) | — |
| CHANGELOG.md | Doku | geändert | Änderungshistorie (M1–M6.5): M5/M6/M6.5-Einträge ergänzt (Multiplayer, Steamworks, Map, i18n, Kamera) | — |
| docs/STEAMWORKS_SETUP_ANLEITUNG.md | Doku | neu | Steamworks-Anmeldung Schritt-für-Schritt (Partnerkonto, App-ID, SDK, Spacewar) — für Geschäftsführer ohne Technik-Wissen | — |
| export_presets.cfg | Konfiguration | neu | Godot-Export-Preset „Windows Desktop" (build/openmotion_windows.exe, x86_64, App-Icon logo_clean, Version 0.1.0) | — |
| i18n/check_parity.py | Werkzeug | unverändert | i18n-Paritätscheck DE↔EN (msgid-Mengen, leere msgstr) | — |
| i18n/de/LC_MESSAGES/ui.po | i18n | unverändert | Deutsche UI-Texte (msgstr == msgid, Basis-Sprache, ADR-004) | — |
| i18n/en/LC_MESSAGES/ui.po | i18n | unverändert | Englische UI-Übersetzungen | — |
| i18n/README.md | Doku | unverändert | i18n-Konzept: Ladekonzept, Konventionen, Paritäts-Pflicht | — |
| IDEA.md | Doku | unverändert | Kurzkonzept (Cities-in-Motion-2-artiges Spiel, SteamWorks, Multiplayer) | — |
| KNOWN_ISSUES.md | Doku | unverändert | Bekannte Probleme (M1: Godot 4.7.1, winget, Root-Layout) | — |
| OpenMotion.csproj | Konfiguration | geändert | Godot-.NET-Projekt (Godot.NET.Sdk/4.7.1, net8.0, ProjectReference Core, Steamworks.NET 2024.8.0, steam_api64.dll-Kopie) | — |
| OpenMotion.sln | Konfiguration | unverändert | Solution: OpenMotion + OpenMotion.Core + OpenMotion.Core.Tests | — |
| project.godot | Konfiguration | geändert | Godot-Projekt: Main-Scene, Autoloads (LocalizationManager, SteamManager), 8 Kamera-Input-Actions, i18n DE/EN, GL Compatibility | — |
| README.md | Doku | unverändert | Projekt-README: Tech-Stack (ADR-006), Build & Test, Struktur | — |
| scenes/Main.tscn | Szene | unverändert | Hauptszene; bindet scripts/SimulationRunner.cs | — |
| scenes/city/CityView.tscn | Szene | neu | 3D-Stadtansicht: MapRenderer + Sun (DirectionalLight3D) + Orbit-Camera3D (CameraController) | — |
| scenes/ui/HUD.tscn | Szene | neu | Erstes übersetztes HUD: 7 Labels (Sprache/Bauen/Linien/Pause/Speichern/Tick/Geld), AutoTranslate=false | — |
| scenes/vehicles/Bus.tscn | Szene | unverändert | Prozedurales Bus-Modell (BoxMesh/CylinderMesh, VehicleColor.cs) | — |
| scenes/vehicles/Metro.tscn | Szene | unverändert | Prozedurales Metro-Modell (Stufen-Nase, Scheinwerfer) | — |
| scenes/vehicles/Tram.tscn | Szene | unverändert | Prozedurales Tram-Modell (Niederflur, Pantograph) | — |
| scenes/vehicles/VehicleColor.cs | C# (Godot) | unverändert | Färbt Fahrzeug-Körper per Linienfarbe (Export LineColor, Gruppe vehicle_body) | — |
| scripts/CameraController.cs | C# (Godot) | neu | M6.5-Orbit-Kamera (Camera3D): Orbit/Zoom/Pan/Höhe state-basiert, 8 Input-Actions, headless-prüfbar | — |
| scripts/HUD.cs | C# (Godot) | neu | Erstes übersetztes HUD (M6): bindet 7 Label-Texte via Tr(), F1-Sprachumschaltung DE⇄EN | — |
| scripts/LocalizationManager.cs | C# (Godot) | neu | i18n-Autoload (M6, ADR-004): Locale-Steuerung de/en, LanguageChanged-Event, .po-Nachlade-Sicherung | — |
| scripts/MapRenderer.cs | C# (Godot) | neu | M6-Karten-Renderer: Infrastruktur (Strassen/Schienen/Gehwege/Haltestellen) als Godot-3D-Primitive | — |
| scripts/SimulationRunner.cs | C# (Godot) | geändert | SimLoop-Integration (M4→M6.5): 30-Hz-Tick-Akkumulator, Subsystem-Adapter, CityView + Demo-Linie + Fahrzeug-Visualisierung | — |
| scripts/SteamManager.cs | C# (Godot) | neu | M5-Steamworks-Autoload: SteamAPI.Init (App-ID 480), IsRunning, DllImport-Resolver, crash-sicher | — |
| scripts/VehicleVisualizer.cs | C# (Godot) | neu | M6.5-Fahrzeug-Visualisierung: instanziiert Vehicle-Szenen je Typ, Linienfarbe aus 8-Spieler-Palette, Refresh nach Sim-Tick | — |
| src/OpenMotion.Core.Tests/CitizensTests.cs | C# (Test) | unverändert | xUnit: Citizen-Tagesablauf, Zufriedenheit, RoutingPreference, CitizenSystem | — |
| src/OpenMotion.Core.Tests/CityGrowthTests.cs | C# (Test) | unverändert | xUnit: Infrastructure, Stadt-Wachstum (Determinismus, Netz-Nähe) | — |
| src/OpenMotion.Core.Tests/DeterministicRandomTests.cs | C# (Test) | unverändert | xUnit: SplitMix64-Sequenzen, Golden-Values, Bereichsgarantien | — |
| src/OpenMotion.Core.Tests/EconomySystemTests.cs | C# (Test) | unverändert | xUnit: EconomySystem, FareSystem, Subventionen, Zwangsentleihe, Determinismus | — |
| src/OpenMotion.Core.Tests/Fix32Tests.cs | C# (Test) | unverändert | xUnit: Fix32-Arithmetik, Saturierung, Div-by-0, Roundtrips | — |
| src/OpenMotion.Core.Tests/InMemoryTransport.cs | C# (Test) | neu | M5-Test-Double: InMemoryTransportHub + InMemoryTransport (IMultiplayerTransport, synchron/geordnet) | — |
| src/OpenMotion.Core.Tests/LockstepTests.cs | C# (Test) | unverändert | xUnit: ReplayLog, TickHash, InputCommand/InputFrame, LockstepSession | — |
| src/OpenMotion.Core.Tests/MapTests.cs | C# (Test) | neu | xUnit (M6, 10 Tests): MapGenerator-Determinismus/Varianz, Start-Infrastruktur, MapSerializer-Roundtrip + Korruptions-Ablehnung | — |
| src/OpenMotion.Core.Tests/MultiplayerSessionTests.cs | C# (Test) | neu | xUnit (M5, 12 Tests): SessionConfig, Host/Client-Frames, Determinismus, Desync, 8-Spieler, Tick-Barriere | — |
| src/OpenMotion.Core.Tests/NetworkingIntegrationTests.cs | C# (Test) | neu | xUnit (M5): MultiplayerSession über echten Networking-Stack (TransportWire + Adapter), identische Hashes | — |
| src/OpenMotion.Core.Tests/NetworkingTests.cs | C# (Test) | neu | xUnit (M5, 20 Tests): InMemoryTransport (Latenz/Jitter-Determinismus), Netcode (Framing/Fuzzing), P2PSession | — |
| src/OpenMotion.Core.Tests/OpenMotion.Core.Tests.csproj | Konfiguration | unverändert | Testprojekt: xUnit 2.9.2, Microsoft.NET.Test.Sdk 17.11.1, net8.0 | — |
| src/OpenMotion.Core.Tests/SerializationTests.cs | C# (Test) | unverändert | xUnit: BinarySimSerializer (Fix32-as-long), ReplayExporter (Format-Version) | — |
| src/OpenMotion.Core.Tests/SimStateTests.cs | C# (Test) | unverändert | xUnit: SimState-Seeds und Tick-Zähler | — |
| src/OpenMotion.Core.Tests/SimulationIntegrationTests.cs | C# (Test) | unverändert | xUnit: Orchestrator (Fakes), Hash-Sequenz, Reihenfolge, DebugReplayValidator | — |
| src/OpenMotion.Core.Tests/TransitTests.cs | C# (Test) | unverändert | xUnit: VehicleTypeParams, Line, Vehicle, TransitNetwork (IDs, Find) | — |
| src/OpenMotion.Core.Tests/VehicleMovementTests.cs | C# (Test) | unverändert | xUnit: VehicleMovementSystem, PassengerFlow (26 Tests, M4) | — |
| src/OpenMotion.Core/Citizens/Citizen.cs | C# (Core) | unverändert | SIM-Bewohner: Zustandsmaschine, Tagesplan (CitizenSchedule), Zufriedenheit | — |
| src/OpenMotion.Core/Citizens/CitizenSystem.cs | C# (Core) | unverändert | Bewohner-Verwaltung: deterministischer Spawn, Tick-Advance, ITransitNetwork | — |
| src/OpenMotion.Core/Citizens/RoutingPreference.cs | C# (Core) | unverändert | Fahrgast-Wahlmodell (ODF-3): Reisezeit dominant, Preis sekundär | — |
| src/OpenMotion.Core/City/Building.cs | C# (Core) | unverändert | Stadtgebäude: Typ, Position, Kapazität, Wohlstand (nur CityGrowth erzeugt) | — |
| src/OpenMotion.Core/City/CityGrowthSystem.cs | C# (Core) | unverändert | Automatisches Stadt-Wachstum entlang Infrastruktur (GDD 4) | — |
| src/OpenMotion.Core/City/Infrastructure.cs | C# (Core) | unverändert | Datenmodell: Segmente (Road/Rail/Path), Haltestellen, Position, Nähe-Abfragen | — |
| src/OpenMotion.Core/DeterministicRandom.cs | C# (Core) | unverändert | Deterministischer PRNG (SplitMix64) für Lockstep (NDD §3.2) | — |
| src/OpenMotion.Core/Economy/EconomySystem.cs | C# (Core) | unverändert | Wirtschaft: Budget, Erträge/Kosten, Zwangsentleihe, Subventionen (ODF-4/5) | — |
| src/OpenMotion.Core/Economy/FareSystem.cs | C# (Core) | unverändert | Tarife: Globaltarif-Policy (ODF-2), IFarePolicy-Erweiterungspunkt | — |
| src/OpenMotion.Core/Economy/LineEconomicStatus.cs | C# (Core) | unverändert | Linien-Wirtschaftsstatus für Subventionsberechnung (ODF-5) | — |
| src/OpenMotion.Core/Fix32.cs | C# (Core) | unverändert | 32.32-Fixed-Point-Arithmetik (saturierend, Lockstep-Basis, NDD §3.1) | — |
| src/OpenMotion.Core/Lockstep/InputCommand.cs | C# (Core) | unverändert | Einzelne Spielereingabe (25-Byte-Binärformat, CommandType-Enum) | — |
| src/OpenMotion.Core/Lockstep/InputFrame.cs | C# (Core) | unverändert | Alle Eingaben eines Spielers pro Tick (Header + Kommandos) | — |
| src/OpenMotion.Core/Lockstep/LockstepSession.cs | C# (Core) | unverändert | Lockstep-Session: Frames puffern, Ticks verarbeiten, Hash alle 10 Ticks | — |
| src/OpenMotion.Core/Lockstep/ReplayLog.cs | C# (Core) | unverändert | Append-only Eingabe-Log (IReplayStore/InMemoryReplayStore) | — |
| src/OpenMotion.Core/Lockstep/TickHash.cs | C# (Core) | unverändert | FNV-1a 64-Hash (Desync-Erkennung, NDD §5.1) | — |
| src/OpenMotion.Core/Map/MapData.cs | C# (Core) | neu | M6-Referenzkarten-Container: Seed, Dimensionen (Fix32), Infrastructure, StartStops, Segment-Zähler | — |
| src/OpenMotion.Core/Map/MapGenerator.cs | C# (Core) | neu | M6-deterministischer Karten-Generator: Straßenkreuz + Schienenkorridor + 8 Start-Haltestellen aus Seed | — |
| src/OpenMotion.Core/Map/MapSerializer.cs | C# (Core) | neu | M6-deterministische Karten-Serialisierung (JSON, Fix32-as-long, Format-Version 1, ID-Verifikation) | — |
| src/OpenMotion.Core/Multiplayer/IMultiplayerTransport.cs | C# (Core) | neu | M5-Transport-Abstraktion der Session (reliable/ordered, MessageReceived-Event, TransportMessage) | — |
| src/OpenMotion.Core/Multiplayer/MultiplayerSession.cs | C# (Core) | neu | M5-Session (Host/Client): Seed-Verteilung, Tick-Barriere, deterministische Konsolidierung, Desync-Erkennung | — |
| src/OpenMotion.Core/Multiplayer/MultiplayerWire.cs | C# (Core) | neu | M5-binäre Nachrichten-Codierung [Type|Tick|PlayerId|Len|Payload] (Join/Welcome/Input/TickInput/HashReport) | — |
| src/OpenMotion.Core/Multiplayer/NetworkingTransportAdapter.cs | C# (Core) | neu | M5-Adapter: IMultiplayerTransport über Networking/ITransport (pull→push, ulong→string, Pump) | — |
| src/OpenMotion.Core/Multiplayer/SessionConfig.cs | C# (Core) | neu | M5-Session-Konfiguration: Seed, Spielerzahl 2–8 (inkl. Host), TickRate 30 als Build-Konstante | — |
| src/OpenMotion.Core/Networking/InMemoryTransport.cs | C# (Core) | neu | M5-Fake-Transport (TransportWire): tick-basierte Latenz/Jitter, deterministische Zustellung | — |
| src/OpenMotion.Core/Networking/ITransport.cs | C# (Core) | neu | M5-Transport-Interface (NDD §4): Send/Receive, PeerConnected/Disconnected, LocalPeerId (ulong) | — |
| src/OpenMotion.Core/Networking/Netcode.cs | C# (Core) | neu | M5-Draht-Kodierung: Framing [Len|Type|Body], NetMessageType, DesyncReport, defensives Unframing | — |
| src/OpenMotion.Core/Networking/P2PSession.cs | C# (Core) | neu | M5-logische P2P-Session: Teilnehmerliste, InputFrame-Broadcast/-Send, DesyncReport, Poll | — |
| src/OpenMotion.Core/OpenMotion.Core.csproj | Konfiguration | unverändert | Core-Bibliothek (net8.0, nullable, implicit usings) | — |
| src/OpenMotion.Core/Serialization/BinarySimSerializer.cs | C# (Core) | unverändert | Deterministische JSON-Serialisierung (System.Text.Json, Fix32-as-long) + Converter | — |
| src/OpenMotion.Core/Serialization/ISimSerializer.cs | C# (Core) | unverändert | Serialisierungs-Schnittstelle (NDD §3.5) | — |
| src/OpenMotion.Core/Serialization/ReplayExporter.cs | C# (Core) | unverändert | Replay-Export/Import als JSON (Format-Version 1, hart geprüft) | — |
| src/OpenMotion.Core/SimState.cs | C# (Core) | unverändert | Deterministischer Sim-Kern (M1): Seed, Tick, RNG (System.Random, M2-Basis) | — |
| src/OpenMotion.Core/Simulation/DebugReplayValidator.cs | C# (Core) | unverändert | Vergleich zweier Orchestrator-Läufe (Hash-Abweichungen, NDD §5.2) | — |
| src/OpenMotion.Core/Simulation/ISimulationSubsystem.cs | C# (Core) | unverändert | Subsystem-Schnittstelle: Name, Tick(SimContext), GetStateHash | — |
| src/OpenMotion.Core/Simulation/SimContext.cs | C# (Core) | unverändert | Tick-Kontext: Master-Seed, Seed-Ableitung, Fix32-Tick-Konstanten | — |
| src/OpenMotion.Core/Simulation/SimulationOrchestrator.cs | C# (Core) | unverändert | Tick-Loop: Subsysteme in fester Reihenfolge, Ganzzustands-Hash | — |
| src/OpenMotion.Core/Transit/Line.cs | C# (Core) | unverändert | Linie: Haltestellenfolge, Takt, Fahrzeuge, Fahrzeit (GDD 8) | — |
| src/OpenMotion.Core/Transit/PassengerFlow.cs | C# (Core) | unverändert | Deterministischer Fahrgast-Wechsel: Ein-/Ausstieg (Kapazität, FIFO) | — |
| src/OpenMotion.Core/Transit/Stop.cs | C# (Core) | unverändert | Haltestelle: Fix32-Position, i18n-Name, ZoneIndex | — |
| src/OpenMotion.Core/Transit/TransitMath.cs | C# (Core) | unverändert | Deterministische Distanz + Fix32-Quadratwurzel (Integer-Newton) | — |
| src/OpenMotion.Core/Transit/TransitNetwork.cs | C# (Core) | unverändert | Netz-Verwaltung: Stops/Lines/Vehicles, deterministische IDs | — |
| src/OpenMotion.Core/Transit/Vehicle.cs | C# (Core) | unverändert | Fahrzeug: Typ, Linien-Zuordnung, Passagiere, Kapazität, Position | — |
| src/OpenMotion.Core/Transit/VehicleMovementSystem.cs | C# (Core) | unverändert | Fahrzeug-Bewegung + Fahrgastwechsel entlang der Route (M4) | — |
| src/OpenMotion.Core/Transit/VehicleType.cs | C# (Core) | unverändert | VehicleType-Enum + VehicleTypeParams (Kapazität/Speed/Kosten) | — |
| sync-openmotion.sh | Werkzeug | unverändert | Auto-Sync OpenMotion → GitHub (git add -A && commit && push) | — |

## Detail-Sektionen (nur geänderte/neue Dateien)

### Geändert (4)

- **CHANGELOG.md** — M5/M6/M6.5-Einträge ergänzt: Netz-Transport (ITransport/InMemory/Netcode/P2PSession), Steamworks.NET (App-ID 480), Multiplayer-Session (Host/Client, Desync), Referenzkarte (MapGenerator/MapData/MapSerializer), MapRenderer/CityView, i18n (LocalizationManager/HUD), Kamera-Steuerung (CameraController). Siehe [[functions]] und [[dependencies]].
- **OpenMotion.csproj** — `PackageReference Steamworks.NET 2024.8.0` (SDK 1.60) ergänzt; `None Include="libs\win-x64\steam_api64.dll"` CopyToOutputDirectory (native DLL ohne NuGet-Inhalt); Compile-Remove `src/**/*.cs` unverändert.
- **project.godot** — `[autoload]` LocalizationManager + SteamManager ergänzt; `[input]` mit 8 Kamera-Actions (camera_orbit/zoom/pan_*/height_*, je 2 Events); `[internationalization]` DE/EN unverändert; Renderer gl_compatibility.
- **scripts/SimulationRunner.cs** — M6: `SetupCityView()` lädt CityView.tscn + rendert Referenzkarte (`MapGenerator.Generate(20260809)`, Seed-Konstante `ReferenceMapSeed`); M6.5: `SetupDemoTransitLine()` (Demo-Bus-Linie mit 2 Fahrzeugen entlang der Karten-Stops), `SetupVehicleVisualizer()` (VehicleVisualizer-Child der CityView), `TransitSubsystem.Tick` treibt Fahrzeuge per `VehicleMovementSystem.AdvanceVehicle(…, deltaTicks: 1)`; `_PhysicsProcess` ruft nach jedem Sim-Tick `_vehicleVisualizer?.Refresh()`.

### Neu (28)

- **src/OpenMotion.Core/Map/*** (M6, Parallel-Agent Map) — `MapData` (Container), `MapGenerator` (Seed → Straßenkreuz + Schienenkorridor + 8 Stops, 2000×2000), `MapSerializer` (Utf8JsonWriter, Fix32-as-long, FormatVersion 1, ID-Verifikation beim Import). Details in [[functions]].
- **src/OpenMotion.Core/Multiplayer/*** (M5, Parallel-Agent Multiplayer) — `MultiplayerSession` (Host-Ordnungsgeber, Tick-Barriere, Hash-Vergleich alle 10 Ticks), `SessionConfig`, `MultiplayerWire` (Binär-Umschlag), `IMultiplayerTransport`, `NetworkingTransportAdapter` (Bridge zum Networking-Stack).
- **src/OpenMotion.Core/Networking/*** (M5, Parallel-Agent Networking) — `ITransport`, `InMemoryTransport`+`TransportWire` (tick-basierte Latenz/Jitter, deterministisch), `Netcode` (Framing + DesyncReport), `P2PSession` (Transport + Frame-Verteilung).
- **scripts/CameraController.cs** (M6.5) — Orbit-Kamera: Fokuspunkt + Yaw/Pitch/Distanz als einziger Zustand, Transform via LookAt; Orbit (rechte/mittlere Maustaste), Zoom (Rad), Pan (WASD/Pfeile, distanzproportional), Höhe (Q/E, Shift/Ctrl); 8 Input-Actions headless-prüfbar.
- **scripts/HUD.cs + scenes/ui/HUD.tscn** (M6) — 7 Labels via Tr() aufgelöst (AutoTranslate=false), Refresh über `LocalizationManager.LanguageChanged`, F1-Toggle DE⇄EN.
- **scripts/LocalizationManager.cs** (M6) — Autoload: deterministischer Default „de", `SetLanguage`/`CurrentLanguage`/`LanguageChanged`, .po-Nachladen als Fallback zur project.godot-Registrierung.
- **scripts/MapRenderer.cs** (M6) — Rendert `Infrastructure` als BoxMesh-Primitive (Road/Rail/Path) + Haltestellen-Knoten (Scheibe + Mast); `Render()` idempotent, `Clear()`.
- **scripts/SteamManager.cs** (M5) — SteamAPI.Init (App-ID 480), IsRunning/PlayerName statisch, DllImport-Resolver für steam_api64.dll, RunCallbacks pro Frame, Shutdown, alles try/catch (crash-sicher, headless-CI-tauglich).
- **scripts/VehicleVisualizer.cs** (M6.5) — Instanziiert Bus/Tram/Metro-Szenen je `Vehicle.Type`, Linienfarbe aus `LinePalette` (8 Farben, GDD 10.1), `Refresh()` nach jedem Sim-Tick (Position + Yaw aus PositionAlongRoute interpoliert).
- **docs/STEAMWORKS_SETUP_ANLEITUNG.md** (M5) — Laienverständliche Steamworks-Anmeldung (Partnerkonto, App-ID, SDK, Spacewar) mit Checkliste, Zeitaufwand, Kosten-Tabelle.
- **export_presets.cfg** (M6.5) — Windows-Desktop-Preset: `build/openmotion_windows.exe`, x86_64, embed_pck, App-Icon `res://assets/logo/logo_clean.png`, Version 0.1.0.
- **assets/logo/logo_clean.ico** (M6.5) — App-Icon (aus logo_clean.svg), für Windows-Export.
- **src/OpenMotion.Core.Tests/MapTests.cs** (10 Tests), **MultiplayerSessionTests.cs** (12 Tests), **NetworkingTests.cs** (20 Tests), **NetworkingIntegrationTests.cs** (1 Test), **InMemoryTransport.cs** (Test-Double Hub/Transport) — siehe [[functions]].
