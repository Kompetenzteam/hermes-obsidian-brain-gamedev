---
tags: [decision, architecture, techstack]
date: 2026-08-09
project: OpenMotion
status: accepted
deciders: [Glieder]
---
# ADR-006: OpenMotion — Tech-Stack

## Kontext
Der Kern des Projekts ist ein **desync-freier Multiplayer (Deterministic Lockstep, 2–8 Spieler)** — die Simulation muss auf allen Clients bitidentisch laufen. Dazu kommen Steam-Anbindung (Auth, Lobby, Workshop Phase 2), Plattform Windows + Linux (Steam Machine), eine einzeln simulierte Bevölkerung (10k+ SIM-Bewohner), ein Bausystem Stufe 1 (nur Verkehrsinfrastruktur, Stadt wächst automatisch entlang gebauter Transportwege) und i18n DE/EN als hartes Gate. Als Hobbyprojekt ohne festes Budget gelten: 0 Euro Lizenzkosten, kein Vendor-Lock, reproduzierbare Builds. ADR-005 hat die technischen Leitplanken gesetzt (Lockstep-Kern, ADR-004-Regeln); dieser ADR wählt die konkreten Technologien.

## Entscheidung
**Beschluss (FREIGEGEBEN von Glieder, 2026-08-09):** Tech-Stack wie folgt — Godot 4 (C#/.NET) mit Fixed-Point-Simulationskern, Steamworks + Steam Datagram Relay für Netzwerk, GitHub Actions für CI/CD.

| Schicht | Technologie | Begründung |
|---------|-------------|------------|
| Engine | **Godot 4** (.NET-Version, C#) | MIT-Lizenz (0 Euro, kein Vendor-Lock), Linux-Export nativ, Headless-Modus für CI- und Lockstep-Tests, aktive Community, godotengine.org |
| Sim-Kern | **C# mit Fixed-Point-Arithmetik** | Deterministisch über Plattformen/Compilern hinweg (kein float-Fallout → Lockstep-tauglich), Typen als `struct` für Performance bei 10k+ SIM-Bewohnern, eigene kleine Math-Bibliothek (Fix32) + deterministischer RNG (seeded) |
| Netzwerk | **Steamworks + Steam Datagram Relay** | Komplette Steam-Anbindung ohnehin Pflicht (Auth, Lobby); SDR bietet P2P mit NAT-Relay-Fallback, 0 Euro Serverkosten (keine eigene Server-Infrastruktur nötig) |
| CI/CD | **GitHub Actions** | Kostenlos für Public Repos, Windows- und Linux-Runner für reproduzierbare Builds, Godot-Headless-Action für Tests, deterministische Lockstep-Testläufe pro Commit |
| Daten | **SQLite (eingebettet)** | Lokale Speicherstände, 0 Euro, cross-platform, kein Server nötig; JSON für Export/Replays (Lockstep-Replay-Format) |

### Ergänzende Festlegungen
- **Lockstep-Disziplin:** Keine floats in der Simulation; feste Tick-Rate (z. B. 30 Ticks/s), nur Eingaben werden übertragen, deterministische Reihenfolge aller Sammlungen
- **Steamworks-Binding:** Steamworks.NET (MIT-Lizenz, C#)
- **Mapgenerator (Phase 2):** seeded + deterministisch, läuft als Teil der Simulation (Lockstep-konform)
- **Replays:** Eingabe-Log als Basis für Replays und Debugging von Desyncs

## Alternativen
| Option | Pro | Contra |
|--------|-----|--------|
| **Godot 4** (gewählt) | MIT-Lizenz (0 Euro), Linux-Export nativ, Headless-Modus, kein Vendor-Lock | Eigenständige Toolchain, C#-Unterstützung (offiziell, aber jünger als C++-Seite) |
| Unity | Große Asset-Pipeline, ausgereiftes C#, riesiges Ökosystem | Lizenzkosten ab Umsatzschwelle, Vendor-Lock, Publisher-Pflicht ab 2025 (ToS), kein nativer Linux-Headless-CI-Fokus |
| Unreal Engine | Top-Grafik, starke Toolchain | Lizenz (5 % Royalty ab Umsatz), C++-lastig, für 2D-/Sim-Projekt überdimensioniert |
| Eigene Engine (C++/Vulkan) | Volle Kontrolle über Determinismus | Jahre an Entwicklungszeit, kein Team — ADR-005 verworfen |

## Konsequenzen
- **Kosten:** 0 Euro Lizenzkosten (Godot MIT, .NET MIT, Steamworks SDK kostenlos); einzige geplante Ausgabe bleibt Steam Direct 100 $ (Freigabe nötig, ADR-004/005)
- **Lizenz-Check:** MIT (Godot, Steamworks.NET), Apache-2.0/.NET (C#-Runtime) — alles mit Hobbyprojekt kompatibel; Steamworks SDK unterliegt der Steamworks-Lizenz (kostenlos, kein Royalty)
- **Fixed-Point-Disziplin:** Floats nur außerhalb der Simulation (Rendering, UI); eigene Fix32-Bibliothek + deterministischer RNG; Code-Reviews achten auf Lockstep-Verstöße (ADR-004)
- **C# in Godot:** Einsatz der offiziellen .NET-Version von Godot 4; NuGet-Pakete erlaubt, solange sie die Lockstep-Regeln nicht verletzen
- **Linux-Export:** Export-Templates für Linux werden Teil der CI-Builds; Plattform-Targets Win + Linux ab Tag 1 (Steam Machine)
- **Headless-Tests:** Godot `--headless` in GitHub Actions; Lockstep-Tests vergleichen Simulations-Hashes über N Ticks auf Windows- und Linux-Runner
- **Risiken:** 10k+ SIM-Bewohner brauchen Performance-Budget (Structs, keine Allokationen im Tick); Godot .NET-Updates können Breaking Changes bringen → Engine-Version im Repo pinnen
- **Offene Punkte (Phase 2):** SteamWorkshop-Support (Lizenz/ToS prüfen), Achievements, dedizierte Server falls SDR nicht reicht

## Verlinkungen
- [[Index|🏠 Brain Index]]
- [[60-Decisions/ADR-005_OpenMotion|ADR-005 — Projektgründung]]
- [[10-Projects/OpenMotion/Gesamtkonzept|Gesamtkonzept]]
- [[10-Projects/OpenMotion/Projektplan|Projektplan]]
