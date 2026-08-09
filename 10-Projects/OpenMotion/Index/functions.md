---
tags: [index, openmotion, functions]
created: 2026-08-09
updated: 2026-08-09
project: OpenMotion
---

# OpenMotion — Funktions-Index

> Wird vom **stündlichen Projekt-Index-Cronjob** (ADR-007) befüllt: jede Funktion/Klasse/Methode mit Name + Signatur + Beschreibung, gruppiert nach Datei.
>
> Zählregel: jeder Listeneintrag zählt als 1 (Typ oder Mitglied); Operatoren/Overloads einer Gruppe werden gebündelt gezählt.

## Funktionen

### src/OpenMotion.Core/SimState.cs
- **`SimState`** — `public sealed class SimState(int seed)` — Deterministischer Simulationskern (M1, Lockstep-fähig, ADR-006); reine C#-Logik ohne Godot-Abhängigkeit.
- **`Seed`** — `public int Seed { get; }` — Fester Seed — Basis für desync-freies Lockstep.
- **`Tick`** — `public uint Tick { get; private set; }` — Globaler Simulations-Tick (monoton steigend).
- **`NextRandom()`** — `public double NextRandom()` — Nächster deterministischer Zufallswert in [0, 1).
- **`Advance()`** — `public void Advance()` — Tick +1, zieht RNG-Zahl als „Weltpuls" (reproduzierbare Sequenzabhängigkeit).

### src/OpenMotion.Core/DeterministicRandom.cs
- **`DeterministicRandom`** — `public sealed class DeterministicRandom(ulong seed)` — Deterministischer PRNG (SplitMix64, NDD §3.2); ersetzt System.Random (plattformabhängig), bit-identisch auf Windows/Linux.
- **`Seed`** — `public ulong Seed { get; }` — Fester 64-bit-Seed (Teil der Save-/Session-Konfiguration).
- **`NextUInt64()`** — `public ulong NextUInt64()` — Nächster 64-bit-Zufallswert (volle Bitbreite).
- **`Next()`** — `public int Next()` — Ganzzahl in [0, int.MaxValue).
- **`Next(int max)`** — `public int Next(int max)` — Ganzzahl in [0, max) via Lemire-Methode (128-bit-Produkt, deterministisch).
- **`MulHigh(ulong, ulong)`** — `private static ulong MulHigh(ulong a, ulong b)` — Obere 64 Bits des 128-bit-Produkts (32-bit-Dekomposition, exakte Carries).
- **`NextDouble()`** — `public Fix32 NextDouble()` — Fix32-Zufallswert in [0, 1).

### src/OpenMotion.Core/Fix32.cs
- **`Fix32`** — `public readonly struct Fix32 : IEquatable<Fix32>, IComparable<Fix32>` — 32.32-Fixed-Point (long-Basis, 32 Fraktionsbits); rein integer-basiert, Lockstep-deterministisch (NDD §3.1).
- **`FractionBits`** — `public const int FractionBits = 32` — Anzahl Fraktionsbits.
- **`Raw`** — `public long Raw { get; }` — Roher 64-bit-Wert (value = Raw / 2^32); Basis der binären Serialisierung.
- **`FromRaw(long)`** — `public static Fix32 FromRaw(long raw)` — Erzeugt Fix32 aus Rohwert.
- **`FromInt(int)`** — `public static Fix32 FromInt(int value)` — Exakte int-Konvertierung.
- **`FromDouble(double)`** — `public static Fix32 FromDouble(double value)` — double-Konvertierung (NUR Tests/Serialisierung; NaN/Inf → Zero).
- **`FromDecimal(decimal)`** — `public static Fix32 FromDecimal(decimal value)` — decimal-Konvertierung (NUR Tests/Serialisierung, half-away-from-zero).
- **Konstanten `Zero`/`One`/`Half`/`MinValue`/`MaxValue`** — `public static Fix32 ...` — Saturierende Grenzwerte und Basiskonstanten.
- **Operatoren** — `operator +, -, * (unär), *, /` — Exakte, saturierende Arithmetik: Addition/Subtraktion saturierend, Multiplikation via 128-bit (Math.BigMul), Division mit exakter 128/64-Rundung (Div-by-0 → saturierender Ersatzwert, nie Exception).
- **`Div128By64(ulong, ulong, ulong, out ulong)`** — `private static ulong` — Exakte 128/64-Bit-Division (unsigned, bit-seriell).
- **Vergleichs-Operatoren** — `operator ==, !=, <, >, <=, >=` — Raw-Vergleiche.
- **`ToDecimal()`** — `public decimal ToDecimal()` — NUR Tests/Diagnostik: exakte decimal-Darstellung.
- **`ToDouble()`** — `public double ToDouble()` — NUR Tests/Diagnostik (53-Bit-Mantisse, nicht im Sim-Pfad).
- **`CompareTo`/`Equals`/`GetHashCode`/`ToString`** — Standard-Implementierungen; ToString mit InvariantCulture (NDD §3.3).

### src/OpenMotion.Core/Lockstep/InputCommand.cs
- **`CommandType`** — `public enum CommandType : byte` — Eingabearten (BuildRoad…Resume, NDD §2.2); Werte Teil des Netz-/Replay-Formats.
- **`InputCommand`** — `public readonly struct InputCommand : IEquatable<InputCommand>` — Eine einzelne Spielereingabe (X/Y als Fix32-Rohwerte, ParamA/B als IDs).
- **`SerializedSize`** — `public const int SerializedSize = 25` — Feste serielle Größe (1+8+8+4+4 Bytes).
- **`ToByteArray()`** — `public byte[] ToByteArray()` — Binär, Little-Endian.
- **`WriteTo(Span<byte>)`** — `public void WriteTo(Span<byte> dest)` — Schreibt in vorhandenen Buffer.
- **`FromBytes(ReadOnlySpan<byte>)`** — `public static InputCommand FromBytes(...)` — Deserialisierung.
- **`Equals`/`GetHashCode`** — Wertgleichheit über alle Felder.

### src/OpenMotion.Core/Lockstep/InputFrame.cs
- **`InputFrame`** — `public sealed class InputFrame : IEquatable<InputFrame>` — Alle Eingaben eines Spielers in einem Tick (leerer Frame = explizite Absichtserklärung).
- **`MaxCommandsPerFrame`** — `public const int MaxCommandsPerFrame = 64` — Rate-Limit (NDD §9.2).
- **`Empty(uint, byte, ushort)`** — `public static InputFrame Empty(...)` — Explizit leerer Frame.
- **`SerializedSize`** — `public int SerializedSize` — 8-Byte-Header + Kommandos.
- **`ToByteArray()`/`WriteTo(Span<byte>)`/`FromBytes(...)`** — Binäre Serialisierung (Little-Endian, NDD §3.5).
- **`Equals`/`GetHashCode`** — Wertgleichheit (inkl. Kommando-Listen).

### src/OpenMotion.Core/Lockstep/ReplayLog.cs
- **`IReplayStore`** — `public interface IReplayStore` — Persistenz-Schnittstelle (append-only): `Append(InputFrame)`, `ReadAll()`.
- **`InMemoryReplayStore`** — `public sealed class InMemoryReplayStore : IReplayStore` — Funktionierende In-Memory-Implementierung (Tests, CI, Single-Process).
- **`ReplayLog`** — `public sealed class ReplayLog(IReplayStore? store = null)` — Append-only Eingabe-Log (NDD §5.3): Basis für Replay/Resync/Late-Join/Desync-Analyse.
- **`Count`** — `public int Count` — Anzahl geloggter Frames.
- **`Store`** — `public IReplayStore Store` — Zugrundeliegender Store.
- **`Append(InputFrame)`** — `public void Append(InputFrame frame)` — In-memory + Store (aufsteigende Tick-Reihenfolge).
- **`ReadFromTick(uint)`** — `public IReadOnlyList<InputFrame> ReadFromTick(uint tick)` — Frames ab Tick (Resync/Late-Join) als Kopie.
- **`ReadAll()`** — `public IReadOnlyList<InputFrame> ReadAll()` — Alle Frames als Kopie.

### src/OpenMotion.Core/Lockstep/LockstepSession.cs
- **`LockstepSession`** — `public sealed class LockstepSession(int seed, ReplayLog? log = null, IReplayStore? store = null)` — Lockstep-Session: Frames puffern (Jitter, NDD §2.3), Ticks deterministisch verarbeiten, Hash alle 10 Ticks (NDD §5.2).
- **`HashIntervalTicks`** — `public const uint HashIntervalTicks = 10` — Hash-Intervall.
- **`Seed`/`Tick`/`Sim`/`ReplayLog`/`LastStateHash`** — Zugriffs-Eigenschaften auf Session-Zustand.
- **`PendingFrameCount`** — `public int PendingFrameCount` — Anzahl gepufferter Frames.
- **`EnqueueInput(InputFrame)`** — `public void EnqueueInput(InputFrame frame)` — Frame entgegennehmen; Duplikate/zu späte Frames werden abgelehnt (Exceptions).
- **`AdvanceTick()`** — `public void AdvanceTick()` — Konsolidiert Frames (Sortierung: PlayerId, dann FrameSeq), loggt, wendet RNG-Pulse an, inkrementiert Tick, Hash alle 10 Ticks.
- **`ComputeStateHash()`** — `public ulong ComputeStateHash()` — 64-bit-Hash über deterministische Serialisierung (Seed, Session-Tick, Sim-Tick, RNG-Pulse, Frames).
- **`ConsumeFramesForTick(uint)`** — `private List<InputFrame>` — Holt + sortiert Frames des Ticks.
- **`CompareFrames(InputFrame, InputFrame)`** — `private static int` — Deterministische Frame-Sortierung.
- **`SerializeStateForHash()`** — `private byte[]` — Deterministische Zustands-Serialisierung (Little-Endian).

### src/OpenMotion.Core/Lockstep/TickHash.cs
- **`TickHash`** — `public static class TickHash` — FNV-1a 64, nicht-kryptografisch, deterministisch (NDD §5.1, keine NuGet-Abhängigkeit).
- **`Hash(ReadOnlySpan<byte>)`** — `public static ulong Hash(ReadOnlySpan<byte> data)` — Kern-Hash-Funktion.
- **`Hash(byte[])`** — `public static ulong Hash(byte[] data)` — Convenience-Overload.

### src/OpenMotion.Core/Serialization/ISimSerializer.cs
- **`ISimSerializer`** — `public interface ISimSerializer` — Deterministische Serialisierung (NDD §3.5): kein float im Format, Invariant-Culture, Versionierung durch Aufrufer.
- **`Serialize(object)`** — `byte[] Serialize(object state)`.
- **`Deserialize<T>(byte[])`** — `T Deserialize<T>(byte[] bytes)`.

### src/OpenMotion.Core/Serialization/BinarySimSerializer.cs
- **`BinarySimSerializer`** — `public sealed class BinarySimSerializer : ISimSerializer` — Deterministische JSON-Serialisierung via System.Text.Json (UTF-8, invariant; Fix32 als roher long).
- **`Serialize(object)`** — `public byte[] Serialize(object state)` — Kompakt, byte-stabil.
- **`Deserialize<T>(byte[])`** — `public T Deserialize<T>(byte[] bytes)` — Tolerant (case-insensitive), null → InvalidDataException.
- **`CreateOptions()`** — `private static JsonSerializerOptions` — Konfiguration + Converter-Registrierung.
- **`Fix32JsonConverter`** — `public sealed class Fix32JsonConverter : JsonConverter<Fix32>` — Serialisiert Raw als Ganzzahl.
- **`InputCommandJsonConverter`** — `public sealed class InputCommandJsonConverter : JsonConverter<InputCommand>` — Explizite Felder type/x/y/paramA/paramB (umgeht STJ-Konstruktor-Bindung bei structs).
- **`InputFrameJsonConverter`** — `public sealed class InputFrameJsonConverter : JsonConverter<InputFrame>` — Explizite Felder tick/playerId/frameSeq/commands.

### src/OpenMotion.Core/Serialization/ReplayExporter.cs
- **`ReplayFile`** — `public sealed class ReplayFile` — JSON-DTO: FormatVersion + geordnete Frames.
- **`ReplayExporter`** — `public static class ReplayExporter` — Export/Import von Replays als JSON-Datei (NDD §5.3/§12.3).
- **`CurrentFormatVersion`** — `public const int CurrentFormatVersion = 1`.
- **`Export(ReplayLog, string)`** — `public static void Export(ReplayLog log, string path)` — Deterministischer JSON-Export.
- **`Import(string)`** — `public static ReplayLog Import(string path)` — Import; inkompatible Format-Version → InvalidDataException.

### src/OpenMotion.Core/Simulation/ISimulationSubsystem.cs
- **`ISimulationSubsystem`** — `public interface ISimulationSubsystem` — Deterministische Subsystem-Schnittstelle (M3, NDD §3.4): Tick in fester Reihenfolge, Hash in Ganzzustand.
- **`Name`** — `string Name { get; }` — Stabiler Subsystem-Name (Teil des Hashes).
- **`Tick(SimContext)`** — `void Tick(SimContext context)` — Verarbeitet genau einen Tick.
- **`GetStateHash()`** — `ulong GetStateHash()` — 64-bit-Hash über den vollständigen Zustand.

### src/OpenMotion.Core/Simulation/SimContext.cs
- **`SimContext`** — `public readonly struct SimContext(uint tick, int masterSeed)` — Immutabler Tick-Kontext für alle Subsysteme (keine Echtzeit, NDD §3.3).
- **`SimTickRate`** — `public const int SimTickRate = 30` — Kern-/Netz-Tick 30/s (NDD §2.1, Q4), Build-Zeit-Konstante.
- **`HashIntervalTicks`** — `public const uint HashIntervalTicks = LockstepSession.HashIntervalTicks` — Hash alle 10 Ticks (NDD §5.2, Q5).
- **`TickDuration`** — `public static readonly Fix32 TickDuration` — 1/30 s als Fix32.
- **`MasterSeed`/`Tick`** — Zugriffs-Eigenschaften.
- **`GetSubsystemSeed(uint)`** — `public ulong GetSubsystemSeed(uint subsystemId)` — Deterministische Seed-Ableitung pro Subsystem (NDD §3.2).
- **`DeriveSeed(int, uint)`** — `public static ulong DeriveSeed(int masterSeed, uint subsystemId)` — SplitMix64-Avalanche über (MasterSeed, Id).

### src/OpenMotion.Core/Simulation/SimulationOrchestrator.cs
- **`SimulationOrchestrator`** — `public sealed class SimulationOrchestrator(int seed, IEnumerable<ISimulationSubsystem> subsystems)` — Deterministische Gesamtsimulation (M3): Tick-Loop mit fester Subsystem-Reihenfolge, Ganzzustands-Hash.
- **`DefaultSubsystemOrder`** — `public static readonly IReadOnlyList<string>` — Kanonische Ordnung: Economy → Citizens → Transit → CityGrowth.
- **`Seed`/`Tick`/`Subsystems`/`LastTickHash`/`HashSequence`** — Zustands-/Diagnose-Eigenschaften (Hash-Sequenz als (Tick, Hash)-Report).
- **`AdvanceTick()`** — `public void AdvanceTick()` — Ein Tick: SimContext erzeugen, alle Subsysteme in fester Reihenfolge, Hash alle 10 Ticks.
- **`RunTicks(uint)`** — `public void RunTicks(uint count)` — N Ticks nacheinander.
- **`ComputeCombinedHash()`** — `public ulong ComputeCombinedHash()` — Ganzzustands-Hash (NDD §5.1): Seed + Tick + Name/Subsystem-Hashes, Little-Endian.

### src/OpenMotion.Core/Simulation/DebugReplayValidator.cs
- **`HashDeviation`** — `public readonly record struct HashDeviation(uint Tick, ulong Expected, ulong Actual)` — Eine Hash-Abweichung.
- **`ComparisonResult`** — `public sealed class ComparisonResult(...)` — Ergebnis: IsIdentical, TicksCompared, Deviations, ReportedHashCount; ToString-Report („OK"/„ABWEICHUNG bei Tick …").
- **`Compare(Func<SimulationOrchestrator>, uint)`** — `public ComparisonResult Compare(Func<SimulationOrchestrator> orchestratorFactory, uint ticks)` — Zwei frische Orchestratoren aus einer Fabrik vergleichen.
- **`Compare(SimulationOrchestrator, SimulationOrchestrator, uint)`** — `public ComparisonResult Compare(...)` — Vergleich zweier Läufe (müssen bei Tick 0 starten, unabhängige Subsysteme).

### src/OpenMotion.Core/Map/MapData.cs
- **`MapData`** — `public sealed class MapData(ulong seed, Fix32 width, Fix32 height, Infrastructure infrastructure)` — Deterministische Start-Referenzkarte (M6): Container für Seed, Welt-Dimensionen (Fix32) und Start-Infrastruktur; nur von MapGenerator erzeugt; Validierung width/height > 0.
- **`Seed`** — `public ulong Seed { get; }` — Master-Seed der Karte (NDD §8.2) — gleicher Seed ⇒ identische Karte.
- **`Width`** — `public Fix32 Width { get; }` — Weltbreite in Metern (Standard 2000).
- **`Height`** — `public Fix32 Height { get; }` — Welthöhe in Metern (Standard 2000).
- **`Infrastructure`** — `public Infrastructure Infrastructure { get; }` — Start-Infrastruktur: Segmente + verankerte Haltestellen (GDD 3).
- **`StartStops`** — `public IReadOnlyList<Stop> StartStops => Infrastructure.Stops` — Start-Haltestellen (eine Quelle, keine Duplikate).
- **`RoadSegmentCount`** — `public int RoadSegmentCount` — Anzahl Strassen-Segmente (Wachstums-Grundlage, GDD 4).
- **`RailSegmentCount`** — `public int RailSegmentCount` — Anzahl Schienen-Segmente (Tram/U-Bahn, GDD 3.1).

### src/OpenMotion.Core/Map/MapGenerator.cs
- **`MapGenerator`** — `public static class MapGenerator` — Deterministischer Referenzkarten-Generator (M6/M6.6, GDD MVP: 1 Stadt-Typ): Seed → **Stadt-Quadranten-Muster** — Hauptkreuz (4 Arme, Armlänge 350–600 seed-abhängig) + 2 parallele Strassen (Abstand 200–300) + 2 Querstrassen + aussenliegender Ring ⇒ **10 Road-Segmente**; **2 Gehweg-Segmente** (diagonale Park-Wege durch die Nord-Bloecke); **3 Rail-Segmente** (Ost-West-Korridor + Spur vom südlichen Arm-Ende + neue Nord-Süd-Verbindung durchs Zentrum); **17 Start-Haltestellen** (13 Road + 4 Rail, GDD 3.1 am Netz verankert). Reine Fix32-/Integer-Arithmetik (NDD §3.1/§3.3), feste seed-unabhängige Zieh-Reihenfolge (NDD §3.2) — Lockstep-konform. **Vertrag (unverändert seit M6):** die ersten 5 Road-Stops sind in Einfüge-Reihenfolge 0=Zentrum, 1=West, 2=Ost, 3=Süd, 4=Nord (West auf gleicher Y wie Zentrum) — darauf baut die Demo-Linie in scripts/SimulationRunner.cs (SetupDemoTransitLine) auf.
- **`DefaultWidth`** — `public const int DefaultWidth = 2000` — Standard-Weltbreite.
- **`DefaultHeight`** — `public const int DefaultHeight = 2000` — Standard-Welthöhe.
- **`Generate(ulong)`** — `public static MapData Generate(ulong seed)` — Referenzkarte mit Standard-Dimensionen 2000×2000.
- **`Generate(ulong, Fix32, Fix32)`** — `public static MapData Generate(ulong seed, Fix32 width, Fix32 height)` — Karte mit expliziten Dimensionen; seed-abhängige Geometrie (Blockabstand 200–300, Kreuz-Armlänge 350–600, Korridor-Offset 120–240, Korridor-Länge 350–500, Nord-Verbindung 120–240) via DeterministicRandom in fester, verzweigungsfreier Zieh-Reihenfolge.

### src/OpenMotion.Core/Map/MapSerializer.cs
- **`MapSerializer`** — `public sealed class MapSerializer` — Deterministische MapData-Serialisierung (M6, NDD §3.5): eigene feste JSON-Kodierung (Utf8JsonWriter/JsonDocument), Fix32 als Raw-long, Format-Version 1.
- **`FormatVersion`** — `public const int FormatVersion = 1` — Aktuelle Format-Version (beim Import hart geprüft).
- **`Serialize(MapData)`** — `public byte[] Serialize(MapData map)` — Deterministische Bytes (gleiche Karte ⇒ identische Bytes; Segment-/Stop-IDs, Typen, Fix32-Raw, Seed).
- **`Deserialize(byte[])`** — `public MapData Deserialize(byte[] bytes)` — Striktes Wiederherstellen: Format-Version, Dimensionen > 0, Enum-Validierung, ID-Verifikation gegen neu vergebene IDs (korrupte Daten → InvalidDataException).
- **`ReadSegments(JsonElement, Infrastructure)`** — `private static void` — Segmente einlesen (AddRoadSegment/AddRailSegment/AddPath) + ID-Abgleich.
- **`ReadStops(JsonElement, Infrastructure)`** — `private static void` — Haltestellen einlesen + ID-Abgleich.
- **`GetRequiredProperty`/`GetRequiredArray`/`GetRequiredInt32`/`GetRequiredInt64`/`GetRequiredUInt64`** — `private static …` — Strikte JSON-Feld-Reader (Pflichtfelder, Typ-Validierung, InvalidDataException).

### src/OpenMotion.Core/Networking/ITransport.cs
- **`ITransport`** — `public interface ITransport` — Abstrakter Netz-Transport (M5, NDD §4): Steam-frei und testbar; Peer-IDs 64-bit (SteamID-kompatibel, NDD §4.2).
- **`LocalPeerId`** — `ulong LocalPeerId { get; }` — Eigene, eindeutige Peer-ID.
- **`PeerConnected`** — `event Action<ulong>?` — Feuert bei neu verbundenem Peer (Lobby-Join, P2P-Handshake).
- **`PeerDisconnected`** — `event Action<ulong>?` — Feuert bei Verbindungsverlust (Timeout, Leave, Steam-Disconnect).
- **`Send(ulong, byte[], bool)`** — `void Send(ulong peerId, byte[] payload, bool reliable)` — Senden; Sim-relevante Nachrichten immer reliable (NDD §4.3).
- **`Receive(out ulong, out byte[])`** — `bool Receive(out ulong peerId, out byte[] payload)` — Nächste eingegangene Nachricht (FIFO), false wenn leer.

### src/OpenMotion.Core/Networking/InMemoryTransport.cs
- **`InMemoryTransport`** — `public sealed class InMemoryTransport : ITransport` — Fake-Transport für deterministische Tests (M5, NDD §11.2): tick-basierte Latenz/Jitter statt Wanduhrzeit.
- **`LocalPeerId`** — `public ulong LocalPeerId { get; }` — Eigene Peer-ID (eindeutig innerhalb einer TransportWire).
- **`LatencyTicks`** — `public uint LatencyTicks { get; }` — Feste Latenz in Ticks (empfangbar nach so vielen AdvanceTick-Schritten des Ziels).
- **`MaxJitterTicks`** — `public uint MaxJitterTicks { get; }` — Maximaler Jitter in Ticks (deterministisch aus fest geseedetem RNG).
- **`Tick`** — `public uint Tick { get; private set; }` — Tick-Zähler des Peers (steigt nur via AdvanceTick).
- **`PendingReceiveCount`** — `public int PendingReceiveCount` — Anzahl zugestellter, noch nicht abgeholter Nachrichten.
- **`PeerConnected`/`PeerDisconnected`** — `public event Action<ulong>?` — Verbindungs-Events.
- **`Send(ulong, byte[], bool)`** — `public void Send(...)` — Sendet über die Wire; Latenz 0 ⇒ sofort, sonst nach LatencyTicks + deterministischem Jitter; unbekannte Ziele → InvalidOperationException.
- **`Receive(out ulong, out byte[])`** — `public bool Receive(...)` — FIFO-Entnahme.
- **`AdvanceTick()`** — `public void AdvanceTick()` — Simulierte Zeit +1 Tick, stellt fällige Nachrichten zu (deterministisch, NDD §3).
- **`OnPeerConnected`/`OnPeerDisconnected`/`EnqueueIncoming`** — `internal` — Wire-Kollaboration (Events/Interne Zustellung).
- **`TransportWire`** — `public sealed class TransportWire` — Verbindungs-Hub: verwaltet Teilnehmer + Latenz-Queue pro Ziel; Attach feuert PeerConnected beidseitig.
- **`TransportCount`** — `public int TransportCount` — Anzahl verbundener Transports.
- **`CreateTransport(ulong, uint, uint, int)`** — `public InMemoryTransport CreateTransport(...)` — Erzeugt + verbindet einen Fake-Transport (PeerConnected beidseitig).
- **`Remove(InMemoryTransport)`** — `public void Remove(...)` — Trennt Transport; PeerDisconnected beidseitig; offene Nachrichten verworfen (NDD §10).
- **`CreatePair(ulong, ulong, uint, uint, int)`** — `public static (InMemoryTransport A, InMemoryTransport B) CreatePair(...)` — Bequemlichkeit für Zwei-Peer-Tests.
- **`Route(InMemoryTransport, ulong, byte[], uint)`** — `internal void Route(...)` — Weiterleitung (sofort oder Latenz-Queue mit DueTick relativ zum Ziel-Tick).
- **`DeliverDue(InMemoryTransport)`** — `internal void DeliverDue(...)` — Stellt fällige Nachrichten zu (FIFO, Sendereihenfolge stabil).

### src/OpenMotion.Core/Networking/Netcode.cs
- **`NetMessageType`** — `public enum NetMessageType : byte` — Nachrichtentypen des Drahtformats (NDD §4.3): InputFrame = 0, DesyncReport = 1; ControlFrame = 2 reserviert (Session-Logik).
- **`DesyncReport`** — `public readonly record struct DesyncReport(uint Tick, ulong ExpectedHash, ulong ReportedHash)` — Desync-Meldung (NDD §5.2), 20 Bytes fest: [Tick:4][ExpectedHash:8][ReportedHash:8].
- **`SerializedSize`** — `public const int SerializedSize = 20` — Feste serielle Größe.
- **`ToByteArray()`/`WriteTo(Span<byte>)`/`FromBytes(ReadOnlySpan<byte>)`** — Binäre Little-Endian-Serialisierung (zu kurz → InvalidDataException).
- **`Netcode`** — `public static class Netcode` — Deterministische Draht-Kodierung (NDD §3.5/§4.3): Framing [Length:4 LE][Type:1][Body], 1-MB-Limit.
- **`ProtocolVersion`** — `public const uint ProtocolVersion = 1` — Protokollversion.
- **`MaxMessageLength`** — `public const int MaxMessageLength = 1024 * 1024` — Steam-Limit (NDD §4.3).
- **`LengthPrefixSize`** — `public const int LengthPrefixSize = 4`.
- **`Frame(NetMessageType, ReadOnlySpan<byte>)`** — `public static byte[] Frame(...)` — Rahmt ein (Length = Type + Body).
- **`Unframe(ReadOnlySpan<byte>)`** — `public static (NetMessageType Type, byte[] Body) Unframe(...)` — Striktes Entrahmen: Länge konsistent, 1-MB-Limit, bekannter Typ (Korruption → InvalidDataException).
- **`EncodeInputFrame(InputFrame)`/`DecodeInputFrame(ReadOnlySpan<byte>)`** — InputFrame ↔ gerahmte Draht-Nachricht (Typ strikt geprüft).
- **`EncodeDesyncReport(DesyncReport)`/`DecodeDesyncReport(ReadOnlySpan<byte>)`** — DesyncReport ↔ Draht-Nachricht.

### src/OpenMotion.Core/Networking/P2PSession.cs
- **`P2PSession`** — `public sealed class P2PSession(ulong localPeerId, ITransport transport)` — Logische P2P-Session (M5, NDD §4): Transport + Frame-Verteilung, KEINE Lockstep-Kapselung; Teilnehmerliste via PeerConnected/Disconnected + AddPeer/RemovePeer.
- **`LocalPeerId`** — `public ulong LocalPeerId { get; }` — Eigene Peer-ID (SteamID im Steam-Fall).
- **`Peers`** — `public IReadOnlyCollection<ulong> Peers` — Fremde Teilnehmer (ohne lokale ID).
- **`InputFrameReceived`** — `public event Action<InputFrame>?` — Für jeden empfangenen InputFrame.
- **`DesyncReportReceived`** — `public event Action<DesyncReport>?` — Für jeden empfangenen Desync-Report (NDD §5.2).
- **`AddPeer(ulong)`/`RemovePeer(ulong)`** — Teilnehmerliste explizit steuern (eigene ID nie Teilnehmer).
- **`SendInputFrame(InputFrame, ulong)`** — `public void SendInputFrame(...)` — Gezielter reliable Send (Nicht-Teilnehmer → ArgumentException).
- **`BroadcastInputFrame(InputFrame)`** — `public void BroadcastInputFrame(...)` — An alle Teilnehmer reliable; lokaler Frame bleibt lokal.
- **`SendDesyncReport(DesyncReport, ulong)`** — `public void SendDesyncReport(...)` — Reliable (NDD §5.2).
- **`Poll()`** — `public void Poll()` — Drainiert den Transport (einmal pro Tick, NDD §2.1), dekodiert strikt (Netcode), verteilt Events; korrupte Pakete → InvalidDataException (Fuzzing-Vertrag NDD §11.2).
- **`OnPeerConnected`/`OnPeerDisconnected`** — `private void` — Automatische Teilnehmerliste.

### src/OpenMotion.Core/Multiplayer/IMultiplayerTransport.cs
- **`TransportMessage`** — `public readonly record struct TransportMessage(string SenderPeerId, byte[] Payload)` — Zugestellte Nachricht (Absender + rohe Payload).
- **`IMultiplayerTransport`** — `public interface IMultiplayerTransport` — Transport-Abstraktion der Session (M5): reliable/ordered-Semantik (NDD §4.5); Session hängt NUR an diesem Interface (Dependency Injection).
- **`PeerId`** — `string PeerId { get; }` — Stabile Peer-ID (im MVP z. B. SteamID als String).
- **`Send(string, byte[])`** — `void Send(string targetPeerId, byte[] payload)` — Reliable/ordered an einen Peer.
- **`Broadcast(IReadOnlyList<string>, byte[])`** — `void Broadcast(IReadOnlyList<string> targetPeerIds, byte[] payload)` — An alle angegebenen Peers.
- **`MessageReceived`** — `event Action<TransportMessage>?` — Für jede eingehende Nachricht.

### src/OpenMotion.Core/Multiplayer/SessionConfig.cs
- **`SessionConfig`** — `public sealed class SessionConfig(int seed, int playerCount, int tickRate = SimContext.SimTickRate)` — Session-Konfiguration (M5, NDD §8/§2.1): Master-Seed, Spielerzahl, Tick-Rate.
- **`MinPlayers`** — `public const int MinPlayers = 2` — Minimale Spielerzahl inkl. Host (NDD §7.1).
- **`MaxPlayers`** — `public const int MaxPlayers = 8` — Lobby-Limit (NDD §7.1).
- **`Seed`** — `public int Seed { get; }` — Master-Seed (vom Host verteilt, NDD §8.2).
- **`PlayerCount`** — `public int PlayerCount { get; }` — Spieler inkl. Host (2–8, validiert).
- **`TickRate`** — `public int TickRate { get; }` — 30 Ticks/s als Build-Zeit-Konstante (zur Laufzeit nicht änderbar, validiert).

### src/OpenMotion.Core/Multiplayer/MultiplayerWire.cs
- **`WireMessage`** — `internal readonly record struct WireMessage(byte Type, uint Tick, byte PlayerId, byte[] Payload)` — Decodierte Nachricht.
- **`MultiplayerWire`** — `internal static class MultiplayerWire` — Binäre Nachrichten-Codierung der Session-Schicht (NDD §4.4): Umschlag [Type:1][Tick:4][PlayerId:1][Len:4][Payload], Little-Endian.
- **MessageType-Konstanten** — `MsgJoin = 1`, `MsgWelcome = 2`, `MsgInput = 3`, `MsgTickInput = 4`, `MsgHashReport = 5` — Drahtformat-Werte (einmal vergeben, nie ändern, NDD §4.4).
- **`Encode(byte, uint, byte, ReadOnlySpan<byte>)`** — `public static byte[] Encode(...)` — Gemeinsamer Umschlag.
- **`Decode(byte[])`** — `public static WireMessage Decode(byte[] data)` — Decodierung; korrupte Pakete → InvalidDataException.
- **`EncodeJoin()`** — Join-Nachricht (leerer Payload).
- **`EncodeWelcome(int, byte, byte)`/`DecodeWelcome(byte[], out int, out byte, out byte)`** — Seed-Verteilung [Seed:4][PlayerId:1][PlayerCount:1].
- **`EncodeInput(InputFrame)`** — Client → Host: eigener InputFrame.
- **`EncodeTickInput(uint, IReadOnlyList<InputFrame>)`/`DecodeTickInput(byte[])`** — Konsolidierte Tick-Eingabe [FrameCount:1] + Frames (Anzahl 1..MaxPlayers validiert).
- **`EncodeHashReport(uint, ulong)`/`DecodeHash(byte[])`** — HashReport-Payload (8 Bytes).

### src/OpenMotion.Core/Multiplayer/NetworkingTransportAdapter.cs
- **`NetworkingTransportAdapter`** — `public sealed class NetworkingTransportAdapter : IMultiplayerTransport` — Integrations-Adapter (M5): implementiert IMultiplayerTransport über pull-basiertes ITransport (OpenMotion.Core.Networking); immer reliable (NDD §4.3).
- **`PeerId`** — `public string PeerId { get; }` — Lokale Peer-ID als Invariant-Culture-String.
- **`MessageReceived`** — `public event Action<TransportMessage>?` — Push-Event (aus Pump).
- **`Send(string, byte[])`** — `public void Send(...)` — _transport.Send(peerId, payload, reliable: true).
- **`Broadcast(IReadOnlyList<string>, byte[])`** — `public void Broadcast(...)` — Send je Ziel, reliable.
- **`Pump()`** — `public void Pump()` — Drainiert die Empfangs-Queue (einmal pro Tick aufzurufen, NDD §2.1) → MessageReceived-Events.
- **`ParsePeerId(string)`** — `private static ulong ParsePeerId(...)` — ulong-Parsing (invariant; ungültig → ArgumentException).

### src/OpenMotion.Core/Multiplayer/MultiplayerSession.cs
- **`MultiplayerSessionState`** — `public enum MultiplayerSessionState { Idle, WaitingForPlayers, Connecting, Running }` — Lebenszyklus-Zustände (NDD §8.1 Lobby-Phasen).
- **`DesyncEvent`** — `public readonly record struct DesyncEvent(uint Tick, string PeerId, ulong ExpectedHash, ulong ActualHash)` — Desync-Ereignis (NDD §5.2/§5.3); deterministisch, keine Echtzeit-Felder.
- **`MultiplayerSession`** — `public sealed class MultiplayerSession(SessionConfig config, IMultiplayerTransport transport, Func<int, LockstepSession>? lockstepFactory = null)` — M5-Session in Star-Topologie: Host = Ordnungsgeber + Session-Verwaltung, KEINE Simulations-Autorität; transport-agnostisch.
- **`Config`/`Transport`/`IsHost`/`State`/`HostPeerId`** — Zugriffs-Eigenschaften (Lebenszyklus, NDD §8.1).
- **`LocalPlayerId`** — `public byte LocalPlayerId` — Deterministische PlayerId (Host = 0, Clients 1..n-1, NDD §7.1).
- **`Lockstep`** — `public LockstepSession? Lockstep` — Lockstep-Kern (Host ab StartSession, Client nach Welcome).
- **`TickRate`** — `public int TickRate` — 30/s (NDD §2.1).
- **`Peers`** — `public IReadOnlyList<string> Peers` — Beigetretene Client-PeerIds (Host-Sicht).
- **`VerifiedHashReports`** — `public int VerifiedHashReports` — Anzahl verifizierter (übereinstimmender) HashReports (NDD §5.2).
- **`DesyncDetected`** — `public event Action<DesyncEvent>?` — Bei jedem erkannten Desync.
- **`StartSession(bool host)`** — `public void StartSession(...)` — Host: Seed bestimmen, PlayerId 0, WaitingForPlayers; Client: Connecting.
- **`JoinSession(string peerId)`** — `public void JoinSession(...)` — Host: Client beitreten lassen; Client: Join-Nachricht senden.
- **`SubmitInput(InputFrame)`** — `public void SubmitInput(...)` — Lokale Eingabe einreichen (Host: puffern; Client: an Host senden); PlayerId muss lokal sein.
- **`OnFrameReceived(InputFrame)`** — `public void OnFrameReceived(...)` — Host: Client-Frame puffern; Client: konsolidierten Broadcast in den Lockstep + Barriere.
- **`GetDesyncEvents()`** — `public IReadOnlyList<DesyncEvent> GetDesyncEvents()` — Debug-/Analyse-Eintrag (NDD §5.2/§5.3).
- **`JoinClient(string)`** — `private void` — Späte Joins/Duplikate ignorieren; bei voller Liste Seed-Verteilung.
- **`DistributeSeeds()`** — `private void` — Sitzordnung: sortierte Peer-IDs → PlayerId 1..n-1; Welcome an alle; State = Running.
- **`BufferHostFrame(InputFrame)`** — `private void` — Puffert Host-Frames; Duplikate/zu späte Ticks verworfen (NDD §9.2); Tick-Barriere: konsolidiere sobald alle Spieler-Frames des nächsten Ticks da sind (NDD §2.3).
- **`ConsolidateTick(uint, List<InputFrame>)`** — `private void` — Deterministische Sortierung (PlayerId → FrameSeq → Tick), Host verarbeitet Tick zuerst, Broadcast der geordneten Tick-Eingabe (NDD §2.2).
- **`CompareFrames(InputFrame, InputFrame)`** — `private static int` — Deterministische Frame-Ordnung.
- **`HandleHashReport(string, uint, byte[])`** — `private void` — Nur Session-Mitglieder, Tick muss verarbeitet sein; Abweichung → DesyncEvent + Event (NDD §5.2).
- **`HandleWelcome(string, byte[])`** — `private void` — Nur im Connecting-Zustand + vom gebundenen Host; PlayerCount-Abgleich (Handshake NDD §4.3); Lockstep aus Fabrik.
- **`HandleTickInput(uint, byte[])`** — `private void` — Vollständige Tick-Eingabe (FrameCount == PlayerCount) → OnFrameReceived je Frame.
- **`TryAdvanceClient()`** — `private void` — Client-Barriere: AdvanceTick sobald alle Spieler-Frames des Ticks gepuffert (NDD §2.3).
- **`SendHashReportIfDue()`** — `private void` — Alle 10 Ticks Ganzzustands-Hash an Host (NDD §5.2).
- **`OnTransportMessage(TransportMessage)`** — `private void` — Dispatch nach Typ; korrupte Pakete sauber verworfen (Netz-Fuzzing NDD §11.4); Absender-Mapping geprüft (NDD §9.3).

### scripts/SimulationRunner.cs
- **`SimulationRunner`** — `public partial class SimulationRunner : Node` — Godot-Seite der Gesamtsimulation (M4→M6.6): bindet SimulationOrchestrator in die Engine-Tick-Schleife; M6: CityView/Referenzkarte; M6.5: Demo-Linie + Fahrzeug-Visualisierung; M6.6: Referenzkarte als Wachstums-Infrastruktur + Gebäude-Visualisierung.
- **Konstanten** — `MasterSeed = 20260809`, `DebugReportIntervalTicks = 300`, `MaxCatchUpSeconds = 0.25`, `ReferenceMapSeed = 20260809`.
- **`_Ready()`** — `public override void _Ready()` — Start-Setup: **M6.6:** Referenzkarte EINMAL erzeugen (`MapGenerator.Generate(ReferenceMapSeed)`) — sie ist die Wachstums-Infrastruktur des CityGrowth-Subsystems (keine Mini-Startstrasse 0..60 mehr, Gebäude wachsen im Kartenbereich ~1000,1000) und wird von Rendering + Demo-Linie geteilt; Transit-Netz (2 Stops), 120 Bewohner, Subsysteme in kanonischer Reihenfolge (CityGrowth-Subsystem in Feld `_cityGrowth` gehalten), Orchestrator; danach `SetupCityView()`, M6.5: `SetupDemoTransitLine()` + `SetupVehicleVisualizer()`, M6.6: `SetupBuildingVisualizer()`.
- **`_PhysicsProcess(double)`** — `public override void _PhysicsProcess(double delta)` — Tick-Akkumulator: feste 30-Hz-Sim-Ticks (framerate-unabhängig, Spiral-of-Death-Schutz); nach jedem Sim-Tick M6.6-Hook `_buildingVisualizer?.Refresh()` (CityGrowth ist letztes Subsystem, Gebäudebestand aktuell) und M6.5-Hook `_vehicleVisualizer?.Refresh()`; Hash-Report alle 300 Ticks.
- **`_ExitTree()`** — `public override void _ExitTree()` — Abschlussbericht (Ticks, Hash-Berichte, Fahrzeug-Knoten + PositionAlongRoute je Fahrzeug; M6.6: Gebäude-Knoten + Sim-Gebäude-Anzahl).
- **`SetupCityView()`** — `private void` — Lädt CityView.tscn, instanziiert als Kind von Main, bestückt MapRenderer mit `_referenceMap.Infrastructure`, loggt Segment-/Stop-Zählung.
- **`SetupDemoTransitLine()`** — `private void` — M6.5-Demo: Bus-Linie „Demo-Linie 1" (West→Zentrum→Ost→Süd, taktTicks 120) + 2 Busse (einer bei Zentrums-Distanz); nur aktiv wenn Netz keine Linie hat (Prototyp-Hack, TODO); verlässt sich auf den MapGenerator-Vertrag (erste 5 Road-Stops 0..4).
- **`SetupVehicleVisualizer()`** — `private void` — VehicleVisualizer als Kind der CityView (sonst Main), Initialize(_transitNetwork).
- **`SetupBuildingVisualizer()`** — `private void` (M6.6) — BuildingVisualizer als Kind der CityView (sonst this), Initialisierung mit `_cityGrowth.Growth` (CityGrowth-Kern, nur Lesen); kein Sim-Eingriff.
- **`EconomySubsystem`** — `private sealed class : ISimulationSubsystem` — Adapter: EconomySystem.Tick() (ODF-4), deterministischer Zustands-Hash (Seed, TickCount, Budget, Schulden, Zinsen, Summen).
- **`CitizenSubsystem`** — `private sealed class : ISimulationSubsystem` — Adapter: CitizenSystem.Tick(), Hash über alle Bewohner (aufsteigende IDs, Zustand + Zufriedenheit + Tagesplan).
- **`TransitSubsystem`** — `private sealed class : ISimulationSubsystem` — Adapter: M6.5 treibt je Sim-Tick alle Fahrzeuge deterministisch via `VehicleMovementSystem.AdvanceVehicle(vehicle, line, deltaTicks: 1)` (M4-Kern, Fix32-exakt); Hash über Stops/Lines/Vehicles inkl. PositionAlongRoute, Passagiere, IsActive.
- **`CityGrowthSubsystem`** — `private sealed class : ISimulationSubsystem` — Adapter: CityGrowthSystem.Tick(infra, network), Hash über Gebäude (Id/Typ/Position/Kapazität/Wohlstand); M6.6: exponiert den Kern als `Growth` (nur Lesen, GetBuildings) für die Gebäude-Visualisierung.
- **`Growth`** — `public CityGrowthSystem Growth => _growth` — M6.6: Zugriff auf den Wachstums-Kern (nur Lesen — GetBuildings); Tick-Logik unverändert.
- **`CitizenTransitBridge`** — `private sealed class : ITransitNetwork` — Bridge Citizens ↔ Transit: IsLineAvailableAtStop über geordnete Listen (deterministisch).
- **`HashState(Action<MemoryStream>)`** — `private static ulong` — FNV-1a 64 über deterministische Serialisierung.
- **`WriteI32`/`WriteU32`/`WriteI64`/`WriteU64`/`WriteString`** — private Little-Endian-Schreibhelfer.

### scripts/BuildingVisualizer.cs (M6.6, neu)
- **`BuildingVisualizer`** — `public partial class BuildingVisualizer : Node3D` — Gebäude-Visualisierung (M6.6, GDD 4): rendert die CityGrowth-Gebäude als 3D-Quader (BoxMesh) unter einem Parent-Knoten; sim X/Y → Godot X/Z (Y nach oben, Konvention wie MapRenderer/VehicleVisualizer); Fix32→float ausschliesslich in der Render-Schicht (Sim bleibt Fix32-exakt); reines Lesen, kein Sim-Eingriff.
- **Farb-Konstanten** — `ResidentialBaseColor (0.75,0.60,0.45)`, `CommercialBaseColor (0.60,0.55,0.50)`, `IndustrialBaseColor (0.45,0.40,0.38)`, `WindowBandColor (0.16,0.15,0.14)` — Warme Farbwelt (Art-Richtung C), public static readonly.
- **Höhen-/Abmessungs-Konstanten** — Höhenbereiche (Residential 6–10, Commercial 12–20, Industrial 8–14 m), Grundflächen (8/12/14 m), Fensterband (Dicke 0.14, 55 % Höhe, 72 % Breite), `ColorVariantsPerType = 8`.
- **`BuildingNodeCount`** — `public int BuildingNodeCount { get; private set; }` — Anzahl instanziierter Gebäude-Knoten (Headless-Nachweis).
- **`Initialize(CityGrowthSystem)`** — `public void Initialize(CityGrowthSystem growth)` — Registriert den Wachstums-Kern (nur Lesen, ArgumentNullException-Guard), baut den Container einmalig auf, ruft Refresh().
- **`Refresh()`** — `public void Refresh()` — M6.6-Hook (vom SimulationRunner nach jedem Sim-Tick): hängt NUR neue Gebäude inkrementell an (Gebäude unveränderlich, nie entfernt — Anzahl-Änderung = vollständiges Dirty-Signal; M6.6-Fix gegen O(n²) Voll-Rebuild bei ~100 Gebäuden/Tick; defensiver Voll-Rebuild bei Bestands-Schrumpfung); loggt X/Z-Min/Max (Kartenbereich ~1000,1000, headless prüfbar).
- **`BuildBuildingNode(Building)`** — `private Node3D` — Erzeugt den Quader-Knoten (Body mit Unterkante y=0 + Fensterband auf der +X-Fassade), Name `Building_{Id}_{Type}`.
- **`HeightFor(BuildingType, uint)`** — `private static float` — Höhe je Typ, deterministisch aus Hash (Bits 8..15 → [0,1]) gestreut.
- **`FootprintFor(BuildingType)`** — `private static float` — Grundfläche je Typ (quadratisch).
- **`BaseColorFor(BuildingType)`** — `private static Color` — Basis-Farbe je Typ (Art-Richtung C, warm).
- **`MaterialFor(BuildingType, uint)`** — `private StandardMaterial3D` — Basis-Farbe × deterministische Variante (Faktor 0.90+0.025·Variante), gecacht pro (Typ, Variante) — keine Laufzeit-Allokation nach dem Warmup.
- **`StableHash(int)`** — `private static uint` — 32-bit-FNV-1a über die Building-Id (Little-Endian, reine Integer-Arithmetik) — gleiche Id ⇒ gleicher Hash auf allen Plattformen, kein Zufall zur Laufzeit.
- **`ToWorld(Position)`** — `private static Vector3` — Sim-Position (Fix32 x/y) → Godot-Welt (X/Z-Ebene, Y = 0).
- **`MakeMaterial(Color)`** — `private static StandardMaterial3D` — Albedo + Roughness 0.92.

### scripts/EnvironmentBuilder.cs (M6.6, neu)
- **`EnvironmentBuilder`** — `public partial class EnvironmentBuilder : Node3D` — Sichtbare Umgebung für den Prototyp (M6.6, User-Feedback „nur Strassen-Kreuz auf leerem grauem Raum"): baut beim Start unter CityView Boden, Akzentflächen, WorldEnvironment (falls keins im Baum) und warme Sonne; deterministisch (feste Konstanten, kein Zufall), `Build()` idempotent, reines Rendering (Sim-Kern unberührt).
- **Farb-Konstanten** — `GroundColor (0.55,0.45,0.35)`, `ParkColor (0.42,0.52,0.30)`, `WaterColor (0.35,0.50,0.60)`, `SkyTopColor (0.60,0.70,0.85)`, `SkyHorizonColor (0.90,0.85,0.75)`, `AmbientColor (0.95,0.90,0.82)`, `SunColor (1.00,0.96,0.90)` — public static readonly.
- **Abmessungs-/Positions-Konstanten** — Boden 3000×3000×0.96 m zentriert (1000, -0.5, 1000) (Oberseite y = -0.02, kein Z-Fighting), Park 140×140 bei (1830, 0.005, 1830) (NO-Eck), Teich 220×160 bei (170, 0.005, 170) (SW-Eck), AmbientEnergy 0.6, SunEnergy 1.15.
- **`_Ready()`** — `public override void _Ready()` — Ruft Build().
- **`Build()`** — `public void Build()` — Idempotenter Aufbau: vorherigen Inhalt freigeben, Boden + Park + Wasser als Kind-Knoten, EnsureWorldEnvironment(), EnsureWarmSun(), Start-Log (Boden/Himmel/Ambient/Tonemap/Sonne).
- **`MakeFlatBox(string, Vector3, Vector3, Color, float)`** — `private static MeshInstance3D` — Flache Box mit frischem Material (Albedo + Roughness).
- **`EnsureWorldEnvironment()`** — `private void` — Legt WorldEnvironment nur an, falls im gesamten Baum KEINES existiert (bestehende unangetastet): ProceduralSky pastell, Ambient aus Farbe (0.6), Tonemap Filmic (Godot 4 kennt keinen „Basic"-Modus — dokumentierte Abweichung); Godot.Environment explizit qualifiziert (System.Environment-Mehrdeutigkeit).
- **`EnsureWarmSun()`** — `private void` — Sonne warm justieren (Energie 1.15, warmweiss): bevorzugt „Sun" im CityView-Root (Parent), sonst erste DirectionalLight3D im Baum; fehlt eine, wird eine mit Kamerawinkel der CityView angelegt.
- **`FindWorldEnvironment(Node)`** — `private static WorldEnvironment?` — Tiefensuche nach der ersten WorldEnvironment im Teilbaum.
- **`FindDirectionalLight(Node?)`** — `private static DirectionalLight3D?` — Tiefensuche nach dem ersten DirectionalLight3D.
- **`F(float)`** — `private static string` — Float invariant formatieren (F2, Locale-unabhängige Logs).

### scripts/CameraController.cs
- **`CameraController`** — `public partial class CameraController : Camera3D` — M6.5-Orbit-Kamera (Prototyp): State-basiert (Fokus + Yaw/Pitch/Distanz), Transform jeden Frame via LookAt; keine UI-Texte (i18n-Gate), headless-sicher.
- **Export-Parameter** — `FocusPoint (1000,0,1000)`, `MinDistance 50`, `MaxDistance 6000`, `OrbitSensitivity 0.005 rad/px`, `ZoomStep 0.9`, `PanSpeedFactor 0.15`, `HeightSpeedFactor 0.06`, `PitchMinDegrees 5`, `PitchMaxDegrees 85`.
- **`_Ready()`** — `public override void _Ready()` — Initialzustand aus Szenen-Position rekonstruieren (yaw/pitch/distance aus Offset zum Fokus, Fallback 1200/45°/40°), ClampState, ApplyTransform, InputMap-Verifikation loggen.
- **`_UnhandledInput(InputEvent)`** — `public override void _UnhandledInput(...)` — Maus: Orbit-Drag (camera_orbit) + Mausrad-Zoom (camera_zoom); UI hat Vorrang.
- **`_Process(double)`** — `public override void _Process(...)` — Tastatur: Pan (camera_pan_*, kamera-relativ in XZ) + Höhe (camera_height_*, Q/Shift ↑, E/Ctrl ↓), distanzproportional.
- **`ZoomIn()`/`ZoomOut()`** — `private void` — Distanz *= bzw. /= ZoomStep, geklemmt.
- **`ClampState()`** — `private void` — Pitch/Distanz klemmt (Yaw unbeschränkt).
- **`ApplyTransform()`** — `private void` — Einzige Transform-Schreibstelle: Kugelkoordinaten-Offset + LookAt(Fokus, Up).
- **`LogInputMapStatus()`** — `private void` — Prüft die 8 erwarteten Input-Actions auf Existenz + Event-Anzahl (headless verifizierbar, fehlend → GD.PrintErr).
- **`ExpectedActions`** — `private static readonly (string, int)[]` — Doku der Eingabe-Zuordnung (orbt 2, zoom 2, pan je 2, höhe je 2 Events).

### scripts/HUD.cs
- **`HUD`** — `public partial class HUD : Control` — Erstes übersetztes HUD (M6, ADR-004): 7 Labels via explizitem Tr() (AutoTranslate=false → headless prüfbar), reagiert auf LocalizationManager.LanguageChanged.
- **`_Ready()`** — `public override void _Ready()` — Label-Nodes holen, LanguageChanged abonnieren, RefreshTexts(), Start-Log (Locale, Sprache, Bauen, Speichern).
- **`_ExitTree()`** — `public override void _ExitTree()` — Event abbestellen.
- **`RefreshTexts()`** — `private void` — Alle 7 Label-Texte neu auflösen (Sprache/Bauen/Linien/Pause/Speichern/Tick/Geld).
- **`_UnhandledKeyInput(InputEvent)`** — `public override void _UnhandledKeyInput(...)` — F1: Sprache DE⇄EN toggeln (Optionsmenü folgt später, gleiche API).

### scripts/LocalizationManager.cs
- **`LocalizationManager`** — `public partial class LocalizationManager : Node` — i18n-Integration (M6, ADR-004): Autoload-Singleton für Locale-Steuerung; Deutsch deterministischer Default.
- **`SupportedLanguages`** — `public static readonly string[] SupportedLanguages = { "de", "en" }` — ADR-004.
- **`LanguageChanged`** — `public static event Action?` — Wird nach jeder Sprachumschaltung ausgelöst (TranslationServer-Signal "locale_changed" nicht als statisches Event exponiert, empirisch 4.7.1 mono).
- **`CurrentLanguage`** — `public static string CurrentLanguage` — Aktive Sprache (TranslationServer.GetLocale()).
- **`_Ready()`** — `public override void _Ready()` — Einmalige Initialisierung: EnsureTranslationsLoaded(), SetLanguage("de") (OS-Sprache ignoriert).
- **`SetLanguage(string)`** — `public static void SetLanguage(string code)` — Locale umschalten (validiert; unbekannt → PushWarning), LanguageChanged feuern.
- **`EnsureTranslationsLoaded()`** — `private static void` — .po-Registrierung sicherstellen: GetLoadedLocales-Check, sonst ResourceLoader + AddTranslation (kein Doppel-Registrieren).

### scripts/MapRenderer.cs
- **`MapRenderer`** — `public partial class MapRenderer : Node3D` — M6-Karten-Renderer: visualisiert Infrastructure deterministisch als Godot-3D-Primitive (Strassen/Rail/Path = Boxen, Stops = Scheibe + Mast); reines Lesen, kein Sim-Eingriff.
- **Farb-Konstanten** — `RoadColor`, `RailColor`, `PathColor`, `StopColor`, `StopPostColor` — Warme Farbwelt (Art-Richtung C), feste Konstanten.
- **Abmessungs-Konstanten** — RoadWidth 6.0, RailWidth 2.8, PathWidth 1.6, SegmentThickness 0.14, StopDiscRadius 1.3, StopPostHeight 2.4.
- **`Render(Infrastructure)`** — `public void Render(Infrastructure infrastructure)` — Baut Child-Knoten idempotent neu (Clear + Segmente + Stops in Einfüge-Reihenfolge).
- **`Clear()`** — `public void Clear()` — Entfernt alle gerenderten Knoten.
- **`BuildSegmentNode(...)`** — `private static MeshInstance3D` — Flache Box zwischen Start/Ende (Sim X/Y → Godot X/Z, Yaw = atan2(dx, dz)).
- **`BuildStopNode(Stop, ...)`** — `private static Node3D` — Haltestellen-Knoten: Zylinder-Scheibe + Mast.
- **`ToWorld(Position)`** — `private static Vector3` — Fix32 → float (nur Render-Schicht).
- **`MakeMaterial(Color)`** — `private static StandardMaterial3D` — Albedo + Roughness 0.92.

### scripts/SteamManager.cs
- **`SteamManager`** — `public partial class SteamManager : Node` — Steamworks-Integration (M5): Autoload-Singleton, kapselt Steamworks.NET (NuGet 2024.8.0, SDK 1.60); Sim-Kern bleibt Steam-frei.
- **`AppId`** — `public const uint AppId = 480` — Spacewar-Test-App (Valve Dev-Test, ADR-006).
- **`IsRunning`** — `public static bool IsRunning { get; private set; }` — true sobald Steamworks nutzbar.
- **`PlayerName`** — `public static string? PlayerName` — Lokaler Steam-Nutzer (SteamFriends.GetPersonaName()).
- **`_Ready()`** — `public override void _Ready()` — Einmalig: DllImport-Resolver (steam_api64.dll), SteamAPI.IsSteamRunning(), SteamAPI.Init() (kein SteamClient.Init in 2024.8.0), alles try/catch (crash-sicher, headless-CI-tauglich).
- **`_Process(double)`** — `public override void _Process(...)` — SteamAPI.RunCallbacks() pro Frame, solange aktiv.
- **`_ExitTree()`** — `public override void _ExitTree()` — SteamAPI.Shutdown() (try/catch, ignorierte Fehler).
- **`ResolveSteamNativeLibrary(...)`** — `private static IntPtr` — Findet steam_api64.dll im Assembly-Ausgabe- und Projektverzeichnis (libs/win-x64-Fallback).

### scripts/VehicleVisualizer.cs
- **`VehicleVisualizer`** — `public partial class VehicleVisualizer : Node3D` — M6.5-Fahrzeug-Visualisierung: instanziiert Vehicle-Szenen (Bus/Tram/Metro) je Fahrzeug und interpoliert PositionAlongRoute entlang der Linie; reines Rendering (Fix32 → float nur hier).
- **Szenen-Pfade** — `BusScenePath`, `TramScenePath`, `MetroScenePath` — res://scenes/vehicles/*.tscn.
- **`LinePalette`** — `public static readonly Color[] LinePalette` — Feste 8-Spieler-Palette (GDD 10.1): Verkehrsrot, Ampelgrün, Himmelblau, Sonnengelb, Violett, Türkis, Orange, Rosé.
- **`VehicleNodeCount`** — `public int VehicleNodeCount` — Instanziierte Fahrzeug-Knoten (Headless-Nachweis).
- **`Initialize(TransitNetwork)`** — `public void Initialize(...)` — Baut Knoten einmalig (nur Fahrzeuge mit Linie ≥ 2 Stops) + Refresh.
- **`Refresh()`** — `public void Refresh()` — M6.5-Hook (nach jedem Sim-Tick): neue Fahrzeuge instanziieren, entfernte freigeben, Position + Yaw aktualisieren.
- **`ResolveLine(Vehicle)`** — `private Line?` — Linie des Fahrzeugs (null wenn nicht zugeordnet).
- **`BuildVehicleNode(Vehicle, Line)`** — `private Node3D` — Szene instanziieren, LineColor (Palette) vor add_child setzen (VehicleColor-Export oder Set("LineColor")).
- **`ScenePathFor(VehicleType)`** — `private static string` — Typ → Szenen-Pfad.
- **`LineColorFor(Line)`** — `private Color` — Palette[Linienindex % 8], deterministisch.
- **`RouteToWorld(Line, Fix32)`** — `private static (Vector3 World, float Yaw)` — Polyline-Interpolation + Fahrtrichtung (yaw = atan2(-dx, -dz), -Z-Front).

### scenes/vehicles/VehicleColor.cs
- **`VehicleColor`** — `public partial class VehicleColor : Node3D` — Wurzel-Skript der prozeduralen Fahrzeug-Szenen (M4): färbt Körper-Meshes per Linienfarbe.
- **`BodyGroup`** — `public const string BodyGroup = "vehicle_body"` — Gruppe der Hauptkörper-Meshes.
- **`LineColor`** — `[Export] public Color LineColor { get; set; }` — Linienfarbe (Default: Verkehrsrot 0.85, 0.23, 0.16).
- **`_Ready()`** — `public override void _Ready()` — Färbung beim Start.
- **`SetLineColor(Color)`** — `public void SetLineColor(Color color)` — Laufzeit-Umfärbung.
- **`ApplyLineColor()`** — `private void` — albedo-Farbe setzen (StandardMaterial3D, Material je Instanz dupliziert, IsAncestorOf-Filter).

### src/OpenMotion.Core/Transit/VehicleType.cs
- **`VehicleType`** — `public enum VehicleType { Bus, Tram, Metro }` — Verkehrsmittel-Typen des MVP (GDD Kap. 7).
- **`VehicleTypeParams`** — `public static class VehicleTypeParams` — Balancierte Startwerte (GDD Kap. 7/11), Fix32/int.
- **Kapazitäts-Konstanten** — `BusCapacity = 40`, `TramCapacity = 90`, `MetroCapacity = 240`.
- **Geschwindigkeits-Konstanten** — `BusSpeedMetersPerTick = 2.0`, `TramSpeed = 2.75`, `MetroSpeed = 4.0` (m/Tick).
- **Kosten-Konstanten** — Anschaffung 15k/45k/120k; Betrieb 0.5/1.0/2.0 pro Tick.
- **`Capacity(VehicleType)`** — `public static int Capacity(VehicleType type)`.
- **`SpeedMetersPerTick(VehicleType)`** — `public static Fix32 SpeedMetersPerTick(VehicleType type)`.
- **`PurchaseCost(VehicleType)`** — `public static Fix32 PurchaseCost(VehicleType type)`.
- **`OperatingCostPerTick(VehicleType)`** — `public static Fix32 OperatingCostPerTick(VehicleType type)`.

### src/OpenMotion.Core/Transit/Stop.cs
- **`Stop`** — `public sealed class Stop(int id, Fix32 x, Fix32 y, string name, int zoneIndex = 0)` — Haltestelle am Netz (GDD Kap. 3.1/8.1); Fix32-Position, i18n-Name, ZoneIndex (MVP 0).
- **`ToString()`** — Anzeige `Stop #Id (Name)`.

### src/OpenMotion.Core/Transit/Vehicle.cs
- **`Vehicle`** — `public sealed class Vehicle(int id, VehicleType type)` — Fahrzeug im Linienbetrieb (GDD Kap. 7/8): PositionAlongRoute (Fix32), Passagiere als geordnete Liste.
- **`LineId`** — `public int? LineId { get; internal set; }` — Linien-Zuordnung (nur Line.Assign/Unassign setzt).
- **`Capacity`** — `public int Capacity` — Kapazität aus dem Typ.
- **`IsFull`/`PassengerCount`/`Passengers`** — Fahrgast-Zustand.
- **`TryBoard(int)`** — `public bool TryBoard(int residentId)` — Einsteigen (inaktiv/voll/doppelt → false).
- **`Disembark(int)`** — `public bool Disembark(int residentId)` — Aussteigen.

### src/OpenMotion.Core/Transit/Line.cs
- **`Line`** — `public sealed class Line(int id, string name, VehicleType vehicleType, int taktTicks)` — Linie: geordnete Haltestellenfolge, Takt, Fahrzeuge (GDD 8).
- **`TaktTicks`** — `public int TaktTicks { get; set; }` — Takt in Ticks (> 0 validiert).
- **`Stops`/`Vehicles`/`StopCount`/`VehicleCount`** — Zugriffs-Eigenschaften.
- **`AddStop(Stop)`/`RemoveStop(Stop)`** — Haltestellen-Folge verwalten.
- **`AssignVehicle(Vehicle)`** — `public bool AssignVehicle(Vehicle vehicle)` — Typ-Zwang + Eine-Linie-Regel (GDD 8.1).
- **`UnassignVehicle(Vehicle)`** — `public bool UnassignVehicle(Vehicle vehicle)` — Fahrzeug freigeben.
- **`RouteLength`** — `public Fix32 RouteLength` — Summe euklidischer Segment-Distanzen.
- **`ComputeTravelTime()`** — `public Fix32 ComputeTravelTime()` — Fahrzeit der gesamten Route (RouteLength / Typspeed).
- **`ComputeTravelTime(int, int)`** — `public Fix32 ComputeTravelTime(int fromStopIndex, int toStopIndex)` — Fahrzeit zwischen zwei Haltestellen (inklusive).

### src/OpenMotion.Core/Transit/TransitNetwork.cs
- **`TransitNetwork`** — `public sealed class TransitNetwork` — Zentraler Verwaltungsknoten; deterministische IDs (monotoner Zähler ab 1, global eindeutig).
- **`CreateStop(Fix32, Fix32, string, int)`** — `public Stop CreateStop(...)`.
- **`CreateLine(string, VehicleType, int)`** — `public Line CreateLine(...)`.
- **`CreateVehicle(VehicleType)`** — `public Vehicle CreateVehicle(...)`.
- **`FindStop(int)`/`FindLine(int)`/`FindVehicle(int)`** — Suchen per ID (null bei fehlend).

### src/OpenMotion.Core/Transit/TransitMath.cs
- **`TransitMath`** — `internal static class TransitMath` — Deterministische Rechenhelfer (reine Integer-Arithmetik).
- **`Distance(Stop, Stop)`** — `public static Fix32 Distance(Stop a, Stop b)` — Euklidische Distanz (Fix32).
- **`Sqrt(Fix32)`** — `public static Fix32 Sqrt(Fix32 value)` — 32.32-Fixpunkt-Quadratwurzel (Integer-Newton, Fehler < 2^-16).
- **`ISqrt64(ulong)`** — `private static ulong ISqrt64(ulong n)` — Ganzzahlige Wurzel (floor).

### src/OpenMotion.Core/Transit/PassengerFlow.cs
- **`WaitingPassenger`** — `public readonly record struct WaitingPassenger(int ResidentId, int TargetStopId)` — Wartender Fahrgast (reines Daten-Tupel).
- **`PassengerFlow`** — `public static class PassengerFlow` — Deterministische Fahrgast-Wechsel (GDD Kap. 7).
- **`BoardPassengers(Vehicle, List<WaitingPassenger>, int)`** — `public static IReadOnlyList<int> BoardPassengers(...)` — Einstieg in FIFO-Reihenfolge bis Kapazität (nur exaktes Ziel; Warteliste wird mutiert).
- **`AlightPassengers(Vehicle, Stop, Func<int,int>)`** — `public static IReadOnlyList<int> AlightPassengers(...)` — Ausstieg aller mit Ziel = Stop (Reihenfolge = Fahrzeug-Reihenfolge).

### src/OpenMotion.Core/Transit/VehicleMovementSystem.cs
- **`StopArrival`** — `public readonly record struct StopArrival(Stop Stop, int Boarded, int Alighted)` — Stop-Ankunft mit Fahrgastwechsel-Zählern.
- **`VehicleMovementResult`** — `public readonly record struct VehicleMovementResult(Fix32 DistanceMoved, IReadOnlyList<StopArrival> Arrivals)` — Ergebnis eines AdvanceVehicle-Aufrufs (inkl. TotalBoarded/TotalAlighted).
- **`VehicleMovementSystem`** — `public sealed class VehicleMovementSystem` — Treibt Fahrzeuge deterministisch entlang der Route (M4, GDD Kap. 7/8).
- **`DwellTicks`** — `public const int DwellTicks = 1` — Oeffnen-Tick (Aufenthalt für Fahrgastwechsel).
- **`AddWaitingPassenger(Stop, int, int)`** — `public void AddWaitingPassenger(...)` — Wartenden an Haltestelle einreihen (FIFO).
- **`WaitingCount(Stop)`** — `public int WaitingCount(Stop stop)` — Wartende an Haltestelle (Diagnose).
- **`GetRemainingDwellTicks(Vehicle)`** — `public int GetRemainingDwellTicks(Vehicle vehicle)` — Verbleibende Oeffnen-Ticks (0 = unterwegs).
- **`AdvanceVehicle(Vehicle, Line, int)`** — `public VehicleMovementResult AdvanceVehicle(...)` — Bewegung + Stop-Ankuenfte + Fahrgastwechsel über deltaTicks; Validierung (falsche Linie/negative Ticks → Exceptions), Streckenende-Klemmung.
- **`AlightAt(Vehicle, Stop)`** — `private int` — Ausstieg (Ziel == Stop.Id), Ziel-Zuordnung entfernen.
- **`BoardAt(Vehicle, Line, Stop, int)`** — `private int` — Einstieg in Routen-Reihenfolge der Ziele, FIFO je Ziel, bis Kapazität.
- **`GetDestination(int, int)`** — `private int` — Zielhaltestelle eines Fahrgasts (-1 unbekannt).
- **`ComputeRoutePositions(Line)`** — `private static Fix32[]` — Kumulierte Routen-Positionen der Haltestellen.
- **`FindNextStopIndex(Fix32, Fix32[])`** — `private static int` — Nächste Haltestelle strikt > Position (-1 am Ende).
- **`RemainingDwellTicks`/`SetDwellTicks`** — private Helfer für den Oeffnen-Tick.

### src/OpenMotion.Core/Citizens/Citizen.cs
- **`CitizenState`** — `public enum CitizenState { AtHome, Commuting, AtWork, Leisure, Waiting }` — Lebenszustand (GDD Kap. 5.1).
- **`CitizenSchedule`** — `public sealed record CitizenSchedule(int LeaveForWorkTick, int LeaveForHomeTick, int CommuteDurationTicks, int? LeisureStartTick, int? LeisureEndTick)` — Deterministischer Tagesplan (GDD 5.2; 1 Tick = 1 s, Tag = 86400 Ticks).
- **`Generate(ulong)`** — `public static CitizenSchedule Generate(ulong seed)` — Tagesplan aus Bewohner-Seed (fixierte Zieh-Reihenfolge).
- **`Citizen`** — `public sealed class Citizen(int id, ulong seed, Fix32 homeX, Fix32 homeY, Fix32 workX, Fix32 workY)` — Einzelner SIM-Bewohner (Ziel 10k+).
- **Zufriedenheits-Konstanten** — `InitialSatisfaction ≈ 0.8`, `WaitingSatisfactionDecayPerTick ≈ 1e-5`, `SatisfactionRecoveryPerTick ≈ 2e-6`.
- **Zustands-Eigenschaften** — `State`, `TargetStopId`, `BoardingStopId`, `HomeStopId`, `WorkStopId`, `Satisfaction`, `Schedule`, `IsTravelling`.
- **`AssignStops(int, int)`** — `public void AssignStops(int homeStopId, int workStopId)` — Nächstgelegene Haltestellen zuweisen.
- **`Update(int, bool)`** — `public void Update(int tickOfDay, bool lineAvailableAtBoardingStop)` — Zustandswechsel nach Tagesplan (GDD 5.2), Zufriedenheits-Delta.
- **`StartTrip(bool, bool)`** — `private void` — Reise starten (Waiting/Commuting je Linien-Verfügbarkeit).
- **`Arrive()`** — `private void` — Ankunft: AtWork/AtHome, Endpunkte zurücksetzen.
- **`RecoverSatisfaction()`/`ApplySatisfactionDelta(Fix32)`** — private Helfer (saturierend auf [0,1]).

### src/OpenMotion.Core/Citizens/CitizenSystem.cs
- **`ITransitNetwork`** — `public interface ITransitNetwork` — Integrations-Naht Citizens ↔ Transit: `IsLineAvailableAtStop(int stopId)`.
- **`CitizenSystem`** — `public sealed class CitizenSystem` — Verwaltet alle Bewohner (Dictionary<id, Citizen>), deterministischer Spawn + Tick (GDD Kap. 5).
- **`DayLengthTicks`** — `public const uint DayLengthTicks = 86400` — Simulations-Tag.
- **`SetTransitNetwork(ITransitNetwork?)`** — `public void SetTransitNetwork(ITransitNetwork? transit)` — Transit-Anbindung setzen/entfernen.
- **`Spawn(int, ulong, int, int, int)`** — `public void Spawn(int count, ulong seed, int cityWidth, int cityHeight, int stopCount = 0)` — Deterministische Population (SplitMix64-Seed-Ableitung, feste Zieh-Reihenfolge).
- **`Tick()`** — `public void Tick()` — Alle Bewohner einen Tick voranbringen (Reise-Bedarf/Waiting bei verfügbarer Linie).
- **`DeriveSeed(ulong, int)`** — `private static ulong` — Bewohner-Seed aus Master-Seed (eine SplitMix64-Runde).

### src/OpenMotion.Core/Citizens/RoutingPreference.cs
- **`RouteOption`** — `public readonly struct RouteOption(int lineId, Fix32 travelTime, Fix32 price)` — Reise-Option (Linie + Reisezeit + Preis).
- **`RoutingPreference`** — `public static class RoutingPreference` — Deterministisches Fahrgast-Wahlmodell (ODF-3, GDD 5.3): score = 0.7·Δt + 0.3·Δp.
- **`TravelTimeWeight`/`PriceWeight`** — `public static readonly Fix32` — Gewichte 0.7/0.3 (Fix32-Rohwerte).
- **`ChooseBest(IReadOnlyList<RouteOption>)`** — `public static RouteOption ChooseBest(...)` — Beste Option (niedrigster Score; Tie-Break: erste Option; leer → ArgumentException).
- **`Score(RouteOption, Fix32, Fix32)`** — `private static Fix32` — Gewichtete Bewertung gegen das beste Angebot.

### src/OpenMotion.Core/City/Building.cs
- **`BuildingType`** — `public enum BuildingType { Residential, Commercial, Industrial }` — Gebäudetyp (GDD 4.1; Industrial Phase 2).
- **`Building`** — `public sealed class Building` — Automatisch entstandenes Stadtgebäude (nur CityGrowthSystem erzeugt, internal ctor); Id, Position, Type, Capacity, Wealth.
- **`ToString()`** — Anzeige inkl. Typ/Position/Kapazität/Wohlstand.

### src/OpenMotion.Core/City/Infrastructure.cs
- **`SegmentType`** — `public enum SegmentType { Road, Rail, Path }` — Transport-Segment-Art (GDD 3.1).
- **`Position`** — `public readonly struct Position : IEquatable<Position>` — Deterministische 2D-Position (Fix32).
- **`DistanceSquaredTo(Position)`** — `public Fix32 DistanceSquaredTo(Position other)` — Quadrierte Distanz (ohne Wurzel).
- **`TransportSegment`** — `public readonly struct TransportSegment : IEquatable<TransportSegment>` — Gebautes Segment (Id, Type, Start, End).
- **`Stop` (City)** — `public readonly struct Stop : IEquatable<Stop>` — Haltestellen-Verweis (Id, Position, Serves).
- **`Infrastructure`** — `public sealed class Infrastructure` — Deterministisches Datenmodell der gebauten Verkehrsinfrastruktur (GDD 3, M3).
- **`AddRoadSegment`/`AddRailSegment`/`AddPath`** — `public TransportSegment Add...(Position start, Position end)` — Segmente anlegen.
- **`AddStop(Position, SegmentType)`** — `public Stop AddStop(...)` — Haltestelle verankern.
- **`GetSegmentsNear(Position, Fix32)`** — `public IReadOnlyList<TransportSegment> GetSegmentsNear(...)` — Segmente im Umkreis (quadrierter Punkt-zu-Segment-Abstand).
- **`GetStopsNear(Position, Fix32)`** — `public IReadOnlyList<Stop> GetStopsNear(...)` — Haltestellen im Umkreis.
- **`SquaredDistanceToSegment(Position, TransportSegment)`** — `private static Fix32` — Projektion mit t ∈ [0,1] geklemmt.

### src/OpenMotion.Core/City/CityGrowthSystem.cs
- **`INetworkQuality`** — `public interface INetworkQuality` — Netzqualität als Wachstumstreiber (GDD 4.2): `Fix32 Quality`.
- **`NetworkQuality`** — `public sealed class NetworkQuality : INetworkQuality` — Feste Netzqualität (Defaults/None/Full).
- **`CityGrowthSystem`** — `public sealed class CityGrowthSystem(ulong seed)` — Automatisches Stadt-Wachstum entlang Infrastruktur (GDD 4, M3).
- **Wachstums-Parameter** — Basisrate 1 %, Stop-Bonus x2 (Radius 5), Spacing 1.0, Setback 1.5, MinSpacing 1.0, CheckRadius 2.5.
- **`Tick(Infrastructure, INetworkQuality)`** — `public void Tick(Infrastructure infrastructure, INetworkQuality network)` — Ein Wachstums-Tick (Segment-Abtastung).
- **`GetBuildings()`** — `public IReadOnlyList<Building> GetBuildings()` — Gebäudebestand (Entstehungsreihenfolge).
- **`SampleAlongSegment(Infrastructure, TransportSegment, Fix32)`** — `private void` — Kandidaten exakt BuildingSetback seitlich der Trasse.
- **`TryGrowAt(Infrastructure, Position, Fix32)`** — `private void` — Wachstums-Check (Netz-Nähe, Belegt, Rate mit Stop-Bonus).
- **`IsOccupied(Position)`** — `private bool` — Mindestabstand prüfen.
- **`PlaceBuilding(Position)`** — `private void` — Wohn/Gewerbe-Abfolge, Kapazität/Wohlstand aus RNG.
- **`Ratio(int, int)`** — `private static Fix32` — int-Verhältnis als Fix32.
- **`ISqrt(ulong)`/`Sqrt(Fix32)`** — private Ganzzahl-/Fix32-Wurzel (bit-by-bit).

### src/OpenMotion.Core/Economy/FareSystem.cs
- **`IFarePolicy`** — `public interface IFarePolicy` — Tarif-Policy (ODF-2, GDD 6.6): `ComputeFare(startZoneIndex, destinationZoneIndex)`.
- **`GlobalFarePolicy`** — `public sealed class GlobalFarePolicy : IFarePolicy` — Einheitlicher Flächentarif (ignoriert Zonen).
- **`FareSystem`** — `public sealed class FareSystem(Fix32 globalFare)` — Verwaltet Tarife + Ticket-Erlös (GDD 6.1).
- **`GlobalFare`** — `public Fix32 GlobalFare { get; set; }` — Spieler-Parameter.
- **`Policy`** — `public IFarePolicy Policy` — Aktive Policy (MVP: Globaltarif).
- **`ComputeRevenue(int)`** — `public Fix32 ComputeRevenue(int passengerCount)` — count × fare (Fix32-exakt).

### src/OpenMotion.Core/Economy/LineEconomicStatus.cs
- **`LineEconomicStatus`** — `public sealed class LineEconomicStatus(int activeVehicles = 0)` — Wirtschaftlicher Linien-Zustand für Subventionen (ODF-5, GDD 6.1).
- **`ActiveVehicles`/`TicksSinceLastService`/`TotalSubsidyReceived`** — Subventions-Zustand (NeverServed-Sentinel = int.MaxValue).
- **`RegisterService()`** — `public void RegisterService()` — Bedienung melden (Gap = 0).
- **`AgeServiceGap()`** — `internal void AgeServiceGap()` — Gap altern (+1, saturierend).

### src/OpenMotion.Core/Economy/EconomySystem.cs
- **`EconomySystem`** — `public sealed class EconomySystem(...)` — Deterministisches Wirtschaftssystem (GDD Kap. 6, ODF-2/4/5); alle Werte konfigurierbar.
- **Konfiguration** — OperatingCostPerVehiclePerTick, SubsidyPerLinePerTick, MaxSubsidyPerTick, MaxServiceGapTicks, BaseForcedLoanRate, ForcedLoanRateGrowthPerTick, MaxForcedLoanRate.
- **Zustand** — Budget, TotalDebt, LoanInterestRate, InsolventTicks, TickCount, TotalForcedLoans, TotalEarned, TotalOperatingCosts, TotalConstructionSpent, TotalVehiclePurchases, TotalSubsidiesReceived, TotalInterestAccrued, Seed, IsInsolvent.
- **`EarnTickets(int, Fix32)`** — `public Fix32 EarnTickets(int passengerCount, Fix32 fare)` — Ticket-Erlös (Budget += count × fare).
- **`PayOperatingCosts(int)`** — `public Fix32 PayOperatingCosts(int vehicleCount)` — Betriebskosten (Pflichtkosten, können Budget negativ treiben).
- **`SpendConstruction(Fix32)`** — `public bool SpendConstruction(Fix32 amount)` — Baukosten (Bausperre bei Überschuldung, ODF-4).
- **`BuyVehicle(Fix32)`** — `public bool BuyVehicle(Fix32 cost)` — Fahrzeugkauf (wie Baukosten).
- **`CanBuild(Fix32)`** — `public bool CanBuild(Fix32 cost)` — Bausperre-Prüfung.
- **`TakeForcedLoan()`** — `public Fix32 TakeForcedLoan()` — Zwangsentleihe für aktuelles Defizit (Budget → 0).
- **`TakeForcedLoan(Fix32)`** — `public Fix32 TakeForcedLoan(Fix32 amount)` — Explizite Kreditaufnahme.
- **`TakeForcedLoanInternal(Fix32)`** — `private Fix32` — Kredit-Mechanik (Budget/TotalDebt/TotalForcedLoans).
- **`RepayLoan(Fix32)`** — `public Fix32 RepayLoan(Fix32 amount)` — Rückzahlung (gedeckelt durch Budget + Schuld).
- **`ApplySubsidies(IReadOnlyList<LineEconomicStatus>)`** — `public Fix32 ApplySubsidies(...)` — Bedarfsbasierte Subventionen je Linie (ODF-5: Betrieb + Service-Gap ≤ Max, gedeckelt).
- **`Tick()`** — `public void Tick()` — Tick-Abschluss: Zinsen kapitalisieren, Insolvenzprüfung (wachsende Zinsen, gedeckelt).

### src/OpenMotion.Core.Tests/InMemoryTransport.cs (Test-Double, M5)
- **`InMemoryTransportHub`** — `public sealed class InMemoryTransportHub` — In-Memory-Transport-Netz (NDD §11.2 „Fake-Transport"): registriert Transports unter stabilen Peer-Ids, synchron/geordnet (Send-Reihenfolge = Empfangs-Reihenfolge pro Peer-Paar).
- **`CreateTransport(string)`** — `public InMemoryTransport CreateTransport(string peerId)` — Erzeugt + registriert (Duplikat → ArgumentException).
- **`Deliver(string, string, byte[])`** — `internal void` — Zustellung an Ziel-Peer.
- **`InMemoryTransport`** — `public sealed class InMemoryTransport : IMultiplayerTransport` — Test-Double der Session-Transport-Schnittstelle (Sub-Namespace ...Tests.Multiplayer, kollisionsfrei zum Networking-InMemoryTransport).
- **`PeerId`** — `public string PeerId { get; }`.
- **`MessageReceived`** — `public event Action<TransportMessage>?`.
- **`Send(string, byte[])`/`Broadcast(IReadOnlyList<string>, byte[])`/`Receive(string, byte[])`** — Hub-Zustellung (synchron, geordnet).

### src/OpenMotion.Core.Tests/MapTests.cs (M6/M6.6, 11 Tests)
- **`MapTests`** — xUnit: `Generate_SameSeed_ProducesIdenticalMap`, `Generate_DifferentSeeds_ProduceDifferentMaps`, `Generate_HasStartInfrastructure_AtLeastThreeRoadsAndOneStop` (Kreuz ≥ 3 Road, ≥ 1 Rail, Stops am Netz verankert, Koordinaten in [0,2000]), `Generate_UsesDefaultDimensions_2000x2000`, `Generate_InvalidDimensions_AreRejected`, `Serializer_Roundtrip_ProducesIdenticalMap`, `Serializer_SameMap_ProducesIdenticalBytes`, `Serializer_Roundtrip_WorksForMultipleSeeds` (0/1/42/20260809/MaxValue), `Serializer_RejectsUnknownFormatVersion`, `Serializer_RejectsCorruptInput` — alle grün.
- **`Generate_HasDenseCityLayout_PrototypeDensity`** — `[Fact]` (M6.6, +1): Stadt-Quadranten-Dichte — > 5 Road-Segmente, Rail-Segmente in [2,3], StartStops in [12,20], ≥ 1 Path-Segment, jede Haltestelle am Netz verankert (GetSegmentsNear ≤ 0.5 m) — inkl. der neuen Block-/Rail-Stops.
- **Test-Helfer** — `P(decimal, decimal)` (Fix32-Position), `AssertMapEqual(MapData, MapData)` (Seed/Dimensionen/Segmente/Stops vollständig), `Signature(MapData)` (kanonische Raw-Signatur).

### src/OpenMotion.Core.Tests/MultiplayerSessionTests.cs (M5, 12 Tests)
- **`SessionConfigTests`** — PlayerCount < 2 / > 8 → ArgumentOutOfRangeException; TickRate als Build-Konstante 30 (nicht änderbar).
- **`MultiplayerSessionTests`** — Host+2 Clients: identische Frames/Reihenfolge (Replay-Logs bit-identisch, Ordnung je Tick P0→P1→P2), Determinismus (30 Ticks → identische Tick-Hashes, 6/6 HashReports verifiziert), Desync (manipulierter Client-Seed → DesyncEvent bei Tick 10, Peer „clientB", Expected ≠ Actual), 8-Spieler-Session (24 Frames identisch über alle Clients), PlayerId-Zuweisung deterministisch nach sortierter PeerId (unabhängig von Join-Reihenfolge), Duplicate-Join ignoriert, Tick-Barriere (Tick 1 wartet auf Tick 0 — Jitter-Puffer), SubmitInput mit falscher PlayerId → ArgumentException, JoinSession ohne StartSession → InvalidOperationException.
- **Test-Helfer** — `Frame(uint tick, byte playerId)`, `CreateSession3(Func<int, LockstepSession>? clientBFactory)` (Host + 2 Clients via InMemoryTransportHub).

### src/OpenMotion.Core.Tests/NetworkingIntegrationTests.cs (M5, 1 Test)
- **`MultiplayerNetworkingIntegrationTests`** — `SessionOverNetworkingTransport_HostPlusTwoClients_IdenticalFramesAndHashes_AllReportsVerified`: MultiplayerSession über echten Networking-Stack (TransportWire + InMemoryTransport + NetworkingTransportAdapter), 12 Ticks, identische Ganzzustands-Hashes auf allen 3 Peers, 2/2 HashReports verifiziert, keine Desync-Events, 36 identische Replay-Frames.
- **Test-Helfer** — `Frame(uint, byte)`, `PumpAll(params NetworkingTransportAdapter[])` (Adapter einmal pro Tick drainieren, Host zuerst).

### src/OpenMotion.Core.Tests/NetworkingTests.cs (M5, 20 Tests)
- **`InMemoryTransportTests`** — Send an verlinkten Peer → identischer Payload + Absender, leere Queue → false, Latenz-Semantik (nicht vor Due-Tick empfangbar), unbekannter Peer → InvalidOperationException, PeerConnected/PeerDisconnected-Events, Determinismus (feste Latenz-Schedule → identische Zustellreihenfolge; gleicher Jitter-Seed → identische Ankunftssequenz).
- **`NetcodeTests`** — InputFrame-Roundtrip (alle Felder), Empty-Frame-Roundtrip, DesyncReport-Roundtrip, Framing-Layout [Len|Type|Body], korrupte Länge/Puffergröße/zu kurzer Puffer/unbekannter Typ/falscher Typ → InvalidDataException.
- **`P2PSessionTests`** — Broadcast an 2 Peers (beide empfangen denselben Frame), gezielter Send (nur Ziel), Teilnehmerliste auto via Connect/Disconnect (eigene ID nie Teilnehmer), DesyncReport-Event, Send an Nicht-Teilnehmer → ArgumentException.
- **Test-Helfer** — `Drain(InMemoryTransport)` (Queue leeren).

### src/OpenMotion.Core.Tests/* (xUnit-Testsuiten, unverändert)
- **`CitizensTests`** — Tagesplan-Determinismus, Home→Work→Home, Leisure-Fenster, Warte-Decay, Zufriedenheit in [0,1] über 3 Tage, RoutingPreference (7 Fälle), CitizenSystem-Spawn/Tick (mit/ohne Netz).
- **`CityGrowthTests`** — GetSegmentsNear/GetStopsNear, kein Wachstum ohne Infrastruktur/Qualität, Gebäude NEBEN der Strasse, Determinismus, Residential+Commercial, Stop-Bonus, Qualitäts-Einfluss.
- **`DeterministicRandomTests`** — Seed-Identität, Golden-Sequenz (Referenzwerte verankert), Bereichsgarantien, Reproduzierbarkeit.
- **`EconomySystemTests`** — FareSystem (exakte Erlöse), EarnTickets/PayOperatingCosts, Bausperre, Zwangsentleihe + wachsende Zinsen (exakt), Subventionen (Deckel, Service-Gap), 50-Tick-Determinismus.
- **`Fix32Tests`** — Arithmetik, Saturierung (Add/Mul-Overflow), Div-by-0-Ersatzwert, Roundtrips (decimal/double), InvariantCulture-ToString.
- **`ReplayLogTests`/`TickHashTests`/`InputCommandTests`/`InputFrameTests`/`LockstepSessionTests`** (LockstepTests.cs) — Log-Store, Hash-Pure-Funktion, Binär-Roundtrips, Session-Hashes (gleiche/gleiche vs. gleiche/verschiedene Eingaben), Jitter-Puffer.
- **`BinarySimSerializerTests`/`ReplayExporterTests`** (SerializationTests.cs) — Fix32-as-long („10737418240"), Roundtrips, Byte-Stabilität, Export/Import, Format-Version-Ablehnung.
- **`SimStateTests`** — Seed-Sequenzen, Tick-Zähler.
- **`SimulationIntegrationTests`** — Orchestrator mit Fakes: identische Hash-Sequenz, feste Aufruf-Reihenfolge, Hash alle 10 Ticks, DebugReplayValidator (OK/Abweichung/Throw), Seed-Ableitung, Konstruktor-Absicherung.
- **`TransitTests`** — Parameter-Ordnungen (Speed/Kosten/Kapazität), Linien-Fahrzeiten (3-4-5 exakt), Fahrzeug-Kapazität/Zuweisung, deterministische IDs, Find-Funktionen.
- **`VehicleMovementTests`** — 26 Tests: exakte Bewegung (Speed×Ticks), mehrere Aufrufe == ein Aufruf, Stop-Ankuenfte + Oeffnen-Tick, Kapazitätsgrenze, Ziel-Filter, Determinismus (6 Tick-Schritte), Metro schneller als Bus (100 vs. 200 Ticks), Validierungsfälle, PassengerFlow-Unit-Tests.

### Weitere Dateien ohne Funktionen
- **Konfiguration** (.csproj, .sln, project.godot, .gitignore, environment.json, ci.yml, export_presets.cfg) und **Szenen** (.tscn), **i18n** (.po, check_parity.py), **Doku** (README, CHANGELOG, KNOWN_ISSUES, IDEA, docs/STEAMWORKS_SETUP_ANLEITUNG.md), **Logo-Werkzeuge** (assets/logo/_*.py), **Assets** (SVG/ICO/JSON/TXT, sync-openmotion.sh) — keine Funktionen/Klassen im obigen Sinne; Zweck siehe [[files]].
