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
| .gitignore | Konfiguration | geändert | Git-Ignore-Regeln (Godot, .NET, IDE); M6.6: `build/` + `data_OpenMotion*` ergänzt (Commit 3f30807, GitHub 100MB-Limit) | — |
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
| assets/logo/logo_clean.ico | Asset (ICO) | entfernt | App-Icon (aus logo_clean.svg konvertiert), in export_presets.cfg referenziert — nicht mehr im Arbeitsbaum (war untracked) | — |
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
| CHANGELOG.md | Doku | geändert | Änderungshistorie (M1–M6.6): M6.6-Einträge ergänzt (Stadt-Quadranten-Karte, BuildingVisualizer, EnvironmentBuilder, 217 Tests) | — |
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
| scenes/city/CityView.tscn | Szene | geändert | 3D-Stadtansicht: MapRenderer + Sun (DirectionalLight3D) + Orbit-Camera3D (CameraController); M6.6: + EnvironmentBuilder-Knoten (Skript-Bindung), Sun deklarativ warm (light_energy 1.15, warmweiss) | — |
| scenes/ui/HUD.tscn | Szene | neu | Erstes übersetztes HUD: 7 Labels (Sprache/Bauen/Linien/Pause/Speichern/Tick/Geld), AutoTranslate=false | — |
| scenes/vehicles/Bus.tscn | Szene | unverändert | Prozedurales Bus-Modell (BoxMesh/CylinderMesh, VehicleColor.cs) | — |
| scenes/vehicles/Metro.tscn | Szene | unverändert | Prozedurales Metro-Modell (Stufen-Nase, Scheinwerfer) | — |
| scenes/vehicles/Tram.tscn | Szene | unverändert | Prozedurales Tram-Modell (Niederflur, Pantograph) | — |
| scenes/vehicles/VehicleColor.cs | C# (Godot) | unverändert | Färbt Fahrzeug-Körper per Linienfarbe (Export LineColor, Gruppe vehicle_body) | — |
| scripts/BuildingVisualizer.cs | C# (Godot) | neu | M6.6-Gebäude-Rendering: CityGrowth-Gebäude als 3D-Quader (Höhe/Farbe/Fensterband deterministisch aus Building-Id-Hash), inkrementeller Refresh nach jedem Sim-Tick | — |
| scripts/CameraController.cs | C# (Godot) | unverändert | M6.5-Orbit-Kamera (Camera3D): Orbit/Zoom/Pan/Höhe state-basiert, 8 Input-Actions, headless-prüfbar | — |
| scripts/EnvironmentBuilder.cs | C# (Godot) | neu | M6.6-Umgebung: Boden (3000×3000), Park/Teich-Akzente, WorldEnvironment (Himmel pastell, Ambient, Tonemap Filmic), warme Sonnen-Justierung; Build() idempotent | — |
| scripts/HUD.cs | C# (Godot) | neu | Erstes übersetztes HUD (M6): bindet 7 Label-Texte via Tr(), F1-Sprachumschaltung DE⇄EN | — |
| scripts/LocalizationManager.cs | C# (Godot) | neu | i18n-Autoload (M6, ADR-004): Locale-Steuerung de/en, LanguageChanged-Event, .po-Nachlade-Sicherung | — |
| scripts/MapRenderer.cs | C# (Godot) | neu | M6-Karten-Renderer: Infrastruktur (Strassen/Schienen/Gehwege/Haltestellen) als Godot-3D-Primitive | — |
| scripts/SimulationRunner.cs | C# (Godot) | geändert | SimLoop-Integration (M4→M6.6): 30-Hz-Tick-Akkumulator, Subsystem-Adapter, CityView + Demo-Linie + Fahrzeug-Visualisierung; M6.6: Referenzkarte einmal im Start-Setup (Wachstums-Infrastruktur), SetupBuildingVisualizer + Refresh-Hook, CityGrowthSubsystem.Growth-Exposé | — |
| scripts/SteamManager.cs | C# (Godot) | neu | M5-Steamworks-Autoload: SteamAPI.Init (App-ID 480), IsRunning, DllImport-Resolver, crash-sicher | — |
| scripts/VehicleVisualizer.cs | C# (Godot) | neu | M6.5-Fahrzeug-Visualisierung: instanziiert Vehicle-Szenen je Typ, Linienfarbe aus 8-Spieler-Palette, Refresh nach Sim-Tick | — |
| src/OpenMotion.Core.Tests/CitizensTests.cs | C# (Test) | unverändert | xUnit: Citizen-Tagesablauf, Zufriedenheit, RoutingPreference, CitizenSystem | — |
| src/OpenMotion.Core.Tests/CityGrowthTests.cs | C# (Test) | unverändert | xUnit: Infrastructure, Stadt-Wachstum (Determinismus, Netz-Nähe) | — |
| src/OpenMotion.Core.Tests/DeterministicRandomTests.cs | C# (Test) | unverändert | xUnit: SplitMix64-Sequenzen, Golden-Values, Bereichsgarantien | — |
| src/OpenMotion.Core.Tests/EconomySystemTests.cs | C# (Test) | unverändert | xUnit: EconomySystem, FareSystem, Subventionen, Zwangsentleihe, Determinismus | — |
| src/OpenMotion.Core.Tests/Fix32Tests.cs | C# (Test) | unverändert | xUnit: Fix32-Arithmetik, Saturierung, Div-by-0, Roundtrips | — |
| src/OpenMotion.Core.Tests/InMemoryTransport.cs | C# (Test) | neu | M5-Test-Double: InMemoryTransportHub + InMemoryTransport (IMultiplayerTransport, synchron/geordnet) | — |
| src/OpenMotion.Core.Tests/LockstepTests.cs | C# (Test) | unverändert | xUnit: ReplayLog, TickHash, InputCommand/InputFrame, LockstepSession | — |
| src/OpenMotion.Core.Tests/MapTests.cs | C# (Test) | geändert | xUnit (M6/M6.6, 11 Tests): MapGenerator-Determinismus/Varianz, Start-Infrastruktur, MapSerializer-Roundtrip + Korruptions-Ablehnung; M6.6: + Generate_HasDenseCityLayout_PrototypeDensity (Stadt-Quadranten-Dichte) | — |
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
| src/OpenMotion.Core/Map/MapGenerator.cs | C# (Core) | geändert | M6.6-deterministischer Karten-Generator: Stadt-Quadranten-Muster (10 Road, 2 Path, 3 Rail-Segmente, 17 Start-Haltestellen) aus Seed; Vertrag: erste 5 Road-Stops 0=Zentrum,1=West,2=Ost,3=Süd,4=Nord | — |
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

### Geändert (6)

- **CHANGELOG.md** — Drei neue M6.6-Einträge: (1) Stadt-Quadranten-Karte (MapGenerator: 10 Road/2 Path/3 Rail, 17 Stops, Determinismus unverändert, Vertrag erste 5 Road-Stops erhalten; +1 Map-Test, 217/217 grün, keine Commits), (2) BuildingVisualizer (Gebäude-Rendering, Höhen/Farben/Fensterband, inkrementeller Refresh, 27 bzw. 62 Gebäude-Node(s) in Headless-Läufen, Determinismus-Hashes bit-identisch), (3) EnvironmentBuilder (Boden/Park/Teich/WorldEnvironment/Sonne, Tonemap-Filmic-Hinweis als dokumentierte Abweichung, .tscn-Color-4-Argumente-Pitfall, 2 bit-identische Headless-Läufe). Siehe [[functions]] und [[dependencies]].
- **.gitignore** — Commit 3f30807 (nach letztem Scan): `build/` + `data_OpenMotion*` ergänzt (GitHub 100MB-Limit, build/ aus Repo entfernt).
- **scenes/city/CityView.tscn** — Neuer `EnvironmentBuilder`-Knoten (Skript res://scripts/EnvironmentBuilder.cs, load_steps 3→4); `Sun` deklarativ warm voreingestellt (light_energy 1.15, light_color warmweiss `Color(1, 0.96, 0.9, 1)` — Pitfall: 4 Argumente im Textformat, 3-Argument-Form ist Parse-Fehler in 4.7.1).
- **scripts/SimulationRunner.cs** — M6.6: Referenzkarte wird jetzt EINMAL im Start-Setup erzeugt (`_referenceMap = MapGenerator.Generate(ReferenceMapSeed)`) und ist zugleich die Wachstums-Infrastruktur des CityGrowth-Subsystems (keine Mini-Startstrasse 0..60 am Weltursprung mehr — Gebäude wachsen im sichtbaren Kartenbereich ~1000,1000); `SetupBuildingVisualizer()` (BuildingVisualizer als Kind der CityView, Initialisierung mit `_cityGrowth.Growth`); M6.6-Hook in `_PhysicsProcess` (`_buildingVisualizer?.Refresh()` direkt nach `AdvanceTick()`); `_ExitTree`-Endbericht um Gebäude-Knoten + Sim-Gebäude erweitert; neues Feld `_cityGrowth` + `CityGrowthSubsystem.Growth`-Property (nur Lesen, GetBuildings).
- **src/OpenMotion.Core.Tests/MapTests.cs** — +1 Test (M6.6): `Generate_HasDenseCityLayout_PrototypeDensity` — > 5 Road-Segmente, 2–3 Rail-Segmente, 12–20 Stops, ≥ 1 Path-Segment, alle Stops am Netz verankert (GetSegmentsNear).
- **src/OpenMotion.Core/Map/MapGenerator.cs** — M6.6 (Parallel-Agent Karte): Stadt-Quadranten-Muster statt Kreuz — Hauptkreuz (Armlänge 350..600 seed-abhängig) + 2 parallele Strassen (Abstand 200..300) + 2 Querstrassen + Ring ⇒ 10 Road-Segmente; 2 diagonale Gehweg-Segmente (Park-Wege Nord); 3 Rail-Segmente (Ost-West-Korridor + Süd-Spur + neue Nord-Süd-Verbindung); 17 Start-Stops (13 Road: Zentrum/4 Arme/4 Block-Ecken/4 Block-Kanten + 4 Rail: Korridor-Enden/-Knoten/Nord-Ende). Determinismus: feste, seed-unabhängige Zieh-Reihenfolge (Blockabstand, Armlänge, Korridor-Offset/-Länge, Nord-Verbindung). Vertrag: erste 5 Road-Stops 0=Zentrum,1=West,2=Ost,3=Süd,4=Nord (Demo-Linie unverändert lauffähig).

### Neu (2)

- **scripts/BuildingVisualizer.cs** (M6.6, Parallel-Agent Gebäude) — Rendert CityGrowth-Gebäude (GDD 4) als 3D-Quader unter der CityView: ein BoxMesh-Knoten je Building, sim X/Y → Godot X/Z (Y nach oben, Konvention wie MapRenderer/VehicleVisualizer); Höhe je Typ deterministisch aus 32-bit-FNV-1a-Hash der Building-Id (Residential 6–10, Commercial 12–20, Industrial 8–14 m), Farbe warm (Art-Richtung C: Beige/Terrakotta, Warmgrau, dunkles Warmgrau) mit 8 Helligkeits-Varianten (Faktor 0.90+0.025·Variante, Material-Cache pro (Typ, Variante)); Fensterband auf der +X-Fassade (0.14 m dick, 55 % Höhe, 72 % Breite). `Initialize(CityGrowthSystem)` registriert den Kern (nur Lesen); `Refresh()` (M6.6-Hook vom SimulationRunner nach jedem Sim-Tick) hängt NUR neue Gebäude inkrementell an (M6.6-Fix gegen O(n²) Voll-Rebuild, Gebäude unveränderlich — Anzahl-Änderung = Dirty-Signal), `BuildingNodeCount` als Headless-Nachweis.
- **scripts/EnvironmentBuilder.cs** (M6.6, Parallel-Agent Umgebung) — Sichtbare Welt unter CityView (User-Feedback „nur Strassen-Kreuz auf leerem grauem Raum"): Boden 3000×3000 m in warmer Erdfarbe (Oberseite y = -0.02, kein Z-Fighting), Park (NO-Eck) + Teich (SW-Eck) als dezent-dokumentierte Akzente (kollisionsfrei gegen Karten-Geometrie X/Z ∈ [400,1600]); WorldEnvironment nur falls KEINES im Baum existiert (ProceduralSky pastell, Ambient aus Farbe 0.6, Tonemap Filmic — Godot 4 kennt keinen „Basic"-Modus); Sonne: vorhandene „Sun" warm justieren (Energie 1.15, warmweiss) oder anlegen. Deterministisch (feste Konstanten), `Build()` idempotent, reines Rendering.

### Entfernt (1)

- **assets/logo/logo_clean.ico** — App-Icon (aus logo_clean.svg konvertiert, M6.5); nicht mehr im Arbeitsbaum (war untracked, keine Git-Deletion sichtbar). export_presets.cfg referenziert weiterhin `res://assets/logo/logo_clean.png` (png bleibt im Repo).

