---
tags: [index, openmotion, files]
created: 2026-08-09
updated: 2026-08-10
project: OpenMotion
---

# OpenMotion — Datei-Index

> Wird vom **stündlichen Projekt-Index-Cronjob** (ADR-007) befüllt: jede Quelldatei mit Typ, Status, Zweck und Link.

## Dateien

| Datei | Typ | Status | Zweck | Link |
|-------|-----|--------|-------|------|
| .github/workflows/ci.yml | CI/CD | unverändert | GitHub-Actions-Workflow: Build + Lockstep-Tests auf Windows/Linux | — |
| .gitignore | Konfiguration | unverändert | Git-Ignore-Regeln (Godot, .NET, IDE); `build/` + `data_OpenMotion*` ignoriert (GitHub 100MB-Limit) | — |
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
| assets/logo/logo_clean.ico | Asset (ICO) | entfernt | App-Icon (aus logo_clean.svg konvertiert), in export_presets.cfg referenziert — nicht mehr im Arbeitsbaum (war untracked); weiterhin nicht vorhanden (Stand letzter Scan) | — |
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
| CHANGELOG.md | Doku | unverändert | Änderungshistorie (M1–M6.7); zuletzt +3 Einträge (BALANCE/FIX/PERF inkrementell, Commit a3d8da5) — in diesem Scan unverändert | — |
| docs/STEAMWORKS_SETUP_ANLEITUNG.md | Doku | unverändert | Steamworks-Anmeldung Schritt-für-Schritt (Partnerkonto, App-ID, SDK, Spacewar) — für Geschäftsführer ohne Technik-Wissen | — |
| export_presets.cfg | Konfiguration | unverändert | Godot-Export-Preset „Windows Desktop" (build/openmotion_windows.exe, x86_64, App-Icon logo_clean, Version 0.1.0) | — |
| i18n/check_parity.py | Werkzeug | unverändert | i18n-Paritätscheck DE↔EN (msgid-Mengen, leere msgstr) | — |
| i18n/de/LC_MESSAGES/ui.po | i18n | unverändert | Deutsche UI-Texte (msgstr == msgid, Basis-Sprache, ADR-004) | — |
| i18n/en/LC_MESSAGES/ui.po | i18n | unverändert | Englische UI-Übersetzungen | — |
| i18n/README.md | Doku | unverändert | i18n-Konzept: Ladekonzept, Konventionen, Paritäts-Pflicht | — |
| IDEA.md | Doku | unverändert | Kurzkonzept (Cities-in-Motion-2-artiges Spiel, SteamWorks, Multiplayer) | — |
| KNOWN_ISSUES.md | Doku | unverändert | Bekannte Probleme & offene Punkte; zuletzt +3 (Export-Löschung, Headless-FPS, CityGrowth-Balancing, Commit 587a421) — in diesem Scan unverändert | — |
| OpenMotion.csproj | Konfiguration | unverändert | Godot-.NET-Projekt (Godot.NET.Sdk/4.7.1, net8.0, ProjectReference Core, Steamworks.NET 2024.8.0, steam_api64.dll-Kopie) | — |
| OpenMotion.sln | Konfiguration | unverändert | Solution: OpenMotion + OpenMotion.Core + OpenMotion.Core.Tests | — |
| project.godot | Konfiguration | unverändert | Godot-Projekt: Main-Scene, Autoloads (LocalizationManager, SteamManager), 8 Kamera-Input-Actions, i18n DE/EN, GL Compatibility; M6.7-PERF: `run/max_fps=0` (Kommentar dokumentiert 60 — Diskrepanz), `msaa_3d=0`, `scaling_3d/scale=1.0`, `[physics] 60 Hz` (dokumentiert) | — |
| README.md | Doku | unverändert | Projekt-README: Tech-Stack (ADR-006), Build & Test, Struktur | — |
| scenes/Main.tscn | Szene | unverändert | Hauptszene; bindet scripts/SimulationRunner.cs | — |
| scenes/city/CityView.tscn | Szene | unverändert | 3D-Stadtansicht: MapRenderer + Sun (DirectionalLight3D) + Orbit-Camera3D (CameraController) + EnvironmentBuilder-Knoten | — |
| scenes/ui/HUD.tscn | Szene | unverändert | Erstes übersetztes HUD: 7 Labels (Sprache/Bauen/Linien/Pause/Speichern/Tick/Geld), AutoTranslate=false | — |
| scenes/vehicles/Bus.tscn | Szene | unverändert | Prozedurales Bus-Modell (BoxMesh/CylinderMesh, VehicleColor.cs) | — |
| scenes/vehicles/Metro.tscn | Szene | unverändert | Prozedurales Metro-Modell (Stufen-Nase, Scheinwerfer) | — |
| scenes/vehicles/Tram.tscn | Szene | unverändert | Prozedurales Tram-Modell (Niederflur, Pantograph) | — |
| scenes/vehicles/VehicleColor.cs | C# (Godot) | unverändert | Färbt Fahrzeug-Körper per Linienfarbe (Export LineColor, Gruppe vehicle_body) | — |
| scripts/BuildingVisualizer.cs | C# (Godot) | unverändert | M6.6/M6.7-Gebäude-Rendering: EIN MultiMeshInstance3D (GPU-Instancing, Draw Calls ~1); Perf-Welle 2: INKREMENTELLES Update (nur neue Instanzen angehängt, Kapazität 4096→Verdopplung, Voll-Rebuild nur bei Kapazitäts-Wachstum/Schrumpf, Selbstcheck Instanz 0, Headless-Pitfall dokumentiert); Refresh rate-limitiert (max. 2 Updates/s) — in diesem Scan unverändert | — |
| scripts/CameraController.cs | C# (Godot) | unverändert | M6.5-Orbit-Kamera (Camera3D): Orbit/Zoom/Pan/Höhe state-basiert, 8 Input-Actions, headless-prüfbar | — |
| scripts/EnvironmentBuilder.cs | C# (Godot) | unverändert | M6.6-Umgebung: Boden (3000×3000), Park/Teich-Akzente, WorldEnvironment (Himmel pastell, Ambient, Tonemap Filmic), warme Sonnen-Justierung; Build() idempotent | — |
| scripts/HUD.cs | C# (Godot) | unverändert | Erstes übersetztes HUD (M6): bindet 7 Label-Texte via Tr(), F1-Sprachumschaltung DE⇄EN | — |
| scripts/LocalizationManager.cs | C# (Godot) | unverändert | i18n-Autoload (M6, ADR-004): Locale-Steuerung de/en, LanguageChanged-Event, .po-Nachlade-Sicherung | — |
| scripts/MapRenderer.cs | C# (Godot) | unverändert | M6-Karten-Renderer: Infrastruktur (Strassen/Schienen/Gehwege/Haltestellen) als Godot-3D-Primitive | — |
| scripts/PerfMonitor.cs | C# (Godot) | unverändert | M6.7-Performance-Logging: loggt alle 300 Sim-Ticks FPS, Time/Process/Physics/Navigation, Rendering-Objekte/-Primitive/-Draw-Calls + Gebäude-Anzahl (CityGrowth, nur Lesen); reines Logging | — |
| scripts/SimulationRunner.cs | C# (Godot) | unverändert | SimLoop-Integration (M4→M6.7): 30-Hz-Tick-Akkumulator, Subsystem-Adapter, CityView + Demo-Linie + Fahrzeug-Visualisierung; Refresh-Throttling (Vehicles 15 Hz / Buildings 2 Hz), PerfMonitor-Hook | — |
| scripts/SteamManager.cs | C# (Godot) | unverändert | M5-Steamworks-Autoload: SteamAPI.Init (App-ID 480), IsRunning, DllImport-Resolver, crash-sicher | — |
| scripts/VehicleVisualizer.cs | C# (Godot) | unverändert | M6.5/M6.7-Fahrzeug-Visualisierung: instanziiert Vehicle-Szenen je Typ, Linienfarbe aus 8-Spieler-Palette; Transform-only-Refresh, Knoten-Pool, Routen-Distanz-Cache | — |
| src/OpenMotion.Core.Tests/CitizensTests.cs | C# (Test) | unverändert | xUnit: Citizen-Tagesablauf, Zufriedenheit, RoutingPreference, CitizenSystem | — |
| src/OpenMotion.Core.Tests/CityGrowthTests.cs | C# (Test) | unverändert | xUnit: Infrastructure, Stadt-Wachstum; zuletzt (Commit a3d8da5): +2 NEU (Setback, BALANCE-Deckel), 3 angepasst — 221 Tests grün; in diesem Scan unverändert | — |
| src/OpenMotion.Core.Tests/DeterministicRandomTests.cs | C# (Test) | unverändert | xUnit: SplitMix64-Sequenzen, Golden-Values, Bereichsgarantien | — |
| src/OpenMotion.Core.Tests/EconomySystemTests.cs | C# (Test) | unverändert | xUnit: EconomySystem, FareSystem, Subventionen, Zwangsentleihe, Determinismus | — |
| src/OpenMotion.Core.Tests/Fix32Tests.cs | C# (Test) | unverändert | xUnit: Fix32-Arithmetik, Saturierung, Div-by-0, Roundtrips | — |
| src/OpenMotion.Core.Tests/InMemoryTransport.cs | C# (Test) | unverändert | M5-Test-Double: InMemoryTransportHub + InMemoryTransport (IMultiplayerTransport, synchron/geordnet) | — |
| src/OpenMotion.Core.Tests/LockstepTests.cs | C# (Test) | unverändert | xUnit: ReplayLog, TickHash, InputCommand/InputFrame, LockstepSession | — |
| src/OpenMotion.Core.Tests/MapTests.cs | C# (Test) | unverändert | xUnit (M6/M6.6, 11 Tests): MapGenerator-Determinismus/Varianz, Start-Infrastruktur, MapSerializer-Roundtrip + Korruptions-Ablehnung, Stadt-Quadranten-Dichte | — |
| src/OpenMotion.Core.Tests/MultiplayerSessionTests.cs | C# (Test) | unverändert | xUnit (M5, 12 Tests): SessionConfig, Host/Client-Frames, Determinismus, Desync, 8-Spieler, Tick-Barriere | — |
| src/OpenMotion.Core.Tests/NetworkingIntegrationTests.cs | C# (Test) | unverändert | xUnit (M5): MultiplayerSession über echten Networking-Stack (TransportWire + Adapter), identische Hashes | — |
| src/OpenMotion.Core.Tests/NetworkingTests.cs | C# (Test) | unverändert | xUnit (M5, 20 Tests): InMemoryTransport (Latenz/Jitter-Determinismus), Netcode (Framing/Fuzzing), P2PSession | — |
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
| src/OpenMotion.Core/City/CityGrowthSystem.cs | C# (Core) | unverändert | Automatisches Stadt-Wachstum entlang Infrastruktur (GDD 4); M6.7-PERF: Spatial-Hash; zuletzt (Commit a3d8da5): FIX Setback 10.0 m, BALANCE Budget 0-2/Tick + Deckel 2000 — 293 Gebäude in 300 Ticks; in diesem Scan unverändert | — |
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
| src/OpenMotion.Core/Map/MapData.cs | C# (Core) | unverändert | M6-Referenzkarten-Container: Seed, Dimensionen (Fix32), Infrastructure, StartStops, Segment-Zähler | — |
| src/OpenMotion.Core/Map/MapGenerator.cs | C# (Core) | unverändert | M6.6-deterministischer Karten-Generator: Stadt-Quadranten-Muster (10 Road, 2 Path, 3 Rail-Segmente, 17 Start-Haltestellen) aus Seed; Vertrag: erste 5 Road-Stops 0=Zentrum,1=West,2=Ost,3=Süd,4=Nord | — |
| src/OpenMotion.Core/Map/MapSerializer.cs | C# (Core) | unverändert | M6-deterministische Karten-Serialisierung (JSON, Fix32-as-long, Format-Version 1, ID-Verifikation) | — |
| src/OpenMotion.Core/Multiplayer/IMultiplayerTransport.cs | C# (Core) | unverändert | M5-Transport-Abstraktion der Session (reliable/ordered, MessageReceived-Event, TransportMessage) | — |
| src/OpenMotion.Core/Multiplayer/MultiplayerSession.cs | C# (Core) | unverändert | M5-Session (Host/Client): Seed-Verteilung, Tick-Barriere, deterministische Konsolidierung, Desync-Erkennung | — |
| src/OpenMotion.Core/Multiplayer/MultiplayerWire.cs | C# (Core) | unverändert | M5-binäre Nachrichten-Codierung [Type|Tick|PlayerId|Len|Payload] (Join/Welcome/Input/TickInput/HashReport) | — |
| src/OpenMotion.Core/Multiplayer/NetworkingTransportAdapter.cs | C# (Core) | unverändert | M5-Adapter: IMultiplayerTransport über Networking/ITransport (pull→push, ulong→string, Pump) | — |
| src/OpenMotion.Core/Multiplayer/SessionConfig.cs | C# (Core) | unverändert | M5-Session-Konfiguration: Seed, Spielerzahl 2–8 (inkl. Host), TickRate 30 als Build-Konstante | — |
| src/OpenMotion.Core/Networking/InMemoryTransport.cs | C# (Core) | unverändert | M5-Fake-Transport (TransportWire): tick-basierte Latenz/Jitter, deterministische Zustellung | — |
| src/OpenMotion.Core/Networking/ITransport.cs | C# (Core) | unverändert | M5-Transport-Interface (NDD §4): Send/Receive, PeerConnected/Disconnected, LocalPeerId (ulong) | — |
| src/OpenMotion.Core/Networking/Netcode.cs | C# (Core) | unverändert | M5-Draht-Kodierung: Framing [Len|Type|Body], NetMessageType, DesyncReport, defensives Unframing | — |
| src/OpenMotion.Core/Networking/P2PSession.cs | C# (Core) | unverändert | M5-logische P2P-Session: Teilnehmerliste, InputFrame-Broadcast/-Send, DesyncReport, Poll | — |
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

### Geändert (0)

- Keine Dateien seit dem letzten Scan geändert (mtime ≤ last_scan 2026-08-10T19:06:41+02:00, git status sauber, HEAD unverändert a3d8da5). Die zuletzt geänderten Dateien (CHANGELOG.md, KNOWN_ISSUES.md, scripts/BuildingVisualizer.cs, src/OpenMotion.Core/City/CityGrowthSystem.cs, src/OpenMotion.Core.Tests/CityGrowthTests.cs) sind im vorherigen Scan dokumentiert — Details siehe [[index]] (Letzte Änderungen) und [[dependencies]] (Impact-Map).

### Neu (0)

- Keine neuen Dateien seit dem letzten Scan.

### Entfernt (0)

- Keine Dateien seit dem letzten Scan entfernt. (assets/logo/logo_clean.ico war bereits im vorherigen Scan als entfernt markiert und ist weiterhin nicht im Arbeitsbaum.) Stand Scan 2026-08-10T20:06:16+02:00.
