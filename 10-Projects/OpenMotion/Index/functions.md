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

### scripts/SimulationRunner.cs
- **`SimulationRunner`** — `public partial class SimulationRunner : Node` — Godot-Seite der Gesamtsimulation (M4, SimLoop-Integration): bindet SimulationOrchestrator in die Engine-Tick-Schleife.
- **Konstanten** — `MasterSeed = 20260809`, `DebugReportIntervalTicks = 300`, `MaxCatchUpSeconds = 0.25`.
- **`_Ready()`** — `public override void _Ready()` — Start-Setup: Infrastruktur (1 Strasse + 2 Stops), Transit-Netz, 120 Bewohner, Subsysteme in kanonischer Reihenfolge, Orchestrator.
- **`_PhysicsProcess(double)`** — `public override void _PhysicsProcess(double delta)` — Tick-Akkumulator: feste 30-Hz-Sim-Ticks (framerate-unabhängig, Spiral-of-Death-Schutz), Hash-Report alle 300 Ticks.
- **`_ExitTree()`** — `public override void _ExitTree()` — Abschlussbericht (Ticks, Hash-Berichte).
- **`EconomySubsystem`** — `private sealed class : ISimulationSubsystem` — Adapter: EconomySystem.Tick() (ODF-4), deterministischer Zustands-Hash.
- **`CitizenSubsystem`** — `private sealed class : ISimulationSubsystem` — Adapter: CitizenSystem.Tick(), Hash über alle Bewohner (aufsteigende IDs).
- **`TransitSubsystem`** — `private sealed class : ISimulationSubsystem` — Adapter: passives Netz in M4, Hash über Stops/Lines/Vehicles inkl. Positionen.
- **`CityGrowthSubsystem`** — `private sealed class : ISimulationSubsystem` — Adapter: CityGrowthSystem.Tick(infra, network), Hash über Gebäude.
- **`CitizenTransitBridge`** — `private sealed class : ITransitNetwork` — Bridge Citizens ↔ Transit: Linien-Verfügbarkeit an Haltestelle (deterministisch).
- **`HashState(Action<MemoryStream>)`** — `private static ulong` — FNV-1a 64 über deterministische Serialisierung.
- **`WriteI32`/`WriteU32`/`WriteI64`/`WriteU64`/`WriteString`** — private Little-Endian-Schreibhelfer.

### scenes/vehicles/VehicleColor.cs
- **`VehicleColor`** — `public partial class VehicleColor : Node3D` — Wurzel-Skript der prozeduralen Fahrzeug-Szenen (M4): färbt Körper-Meshes per Linienfarbe.
- **`BodyGroup`** — `public const string BodyGroup = "vehicle_body"` — Gruppe der Hauptkörper-Meshes.
- **`LineColor`** — `[Export] public Color LineColor { get; set; }` — Linienfarbe (Default: Verkehrsrot 0.85, 0.23, 0.16).
- **`_Ready()`** — `public override void _Ready()` — Färbung beim Start.
- **`SetLineColor(Color)`** — `public void SetLineColor(Color color)` — Laufzeit-Umfärbung.
- **`ApplyLineColor()`** — `private void` — albedo-Farbe setzen (StandardMaterial3D, Material je Instanz dupliziert, IsAncestorOf-Filter).

### src/OpenMotion.Core.Tests/* (xUnit-Testsuiten)
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
- **Konfiguration** (.csproj, .sln, project.godot, .gitignore, environment.json, ci.yml) und **Szenen** (.tscn), **i18n** (.po, check_parity.py), **Doku** (README, CHANGELOG, KNOWN_ISSUES, IDEA), **Logo-Werkzeuge** (assets/logo/_*.py), **Assets** (SVG/JSON/TXT, sync-openmotion.sh) — keine Funktionen/Klassen im obigen Sinne; Zweck siehe [[files]].
