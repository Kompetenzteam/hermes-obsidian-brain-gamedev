---
tags: [decision, project, game]
date: 2026-08-09
project: OpenMotion
status: accepted
deciders: [Glieder]
---
# ADR-005: OpenMotion — Projektgründung

## Kontext
Glieder (Geschäftsführer/Ideengeber, ohne technische Kenntnisse) möchte ein Nahverkehrs-Simulator-Spiel im Geiste von Cities in Motion 2 (CIM2) entwickeln. CIM2 war spielerisch exzellent, litt aber unter gravierenden Multiplayer-Desyncs. Ziel ist ein ähnliches Spiel mit absolut multiplayer-tauglichem Mehrspielermodus, Mapgenerator und SteamWorkshop. Komplette Steam-Anbindung (Auth, Multiplayer, Workshop, Achievements).

## Entscheidung
**Beschluss:** Projekt **OpenMotion** wird gegründet. Eigenes Art-Konzept, gleiche Bedienung wie das Referenzspiel, keine 1:1-Kopie, unterscheidbarer Stil. Einmalkauf mit Early Access über Steam. Plattform: Windows + Linux (Steam Machine). Hobbyprojekt ohne festen Zeitrahmen, Budget wird on the go entschieden (vor jeder Ausgabe Rückfrage + Kostennennung durch den Lead).

### Rollen
| Rolle | Verantwortung |
|-------|---------------|
| Glieder | Geschäftsführer, Ideengeber, Entscheider |
| Hermes (Lead Gamedesigner) | Art-Konzept, Logo, Spielkonzept, Balance |
| Hermes (Senior Lead Game Developer) | Architektur, Engine, Code-Qualität |
| Hermes (Senior Networking Specialist) | Desync-freie Multiplayer-Architektur (Deterministic Lockstep) |

### Kernfeature (MVP-Pflicht)
- Desync-freier Multiplayer (2–8 Spieler), deterministisches Lockstep
- Kern-Wirtschaftssimulation + Linienplanung
- MVP-Umfang: 1 Stadt-Typ, 3 Verkehrsmittel (Bus, Tram, U-Bahn)

### Phase 2
- Prozeduraler Mapgenerator (seeded, deterministisch für Multiplayer)
- SteamWorkshop (Maps, Mods, Inhalte)
- Weitere Verkehrsmittel (Fähre, Seilbahn, etc.)

### Technische Leitplanken (Lead-Entscheidung, ADR-004 folgend)
- Deterministic Lockstep als Multiplayer-Kern (Eingaben-Übertragung, keine Sim-Berechnung pro Client)
- Secrets niemals im Klartext (ADR-004)
- i18n DE/EN als hartes Gate (ADR-004)
- Erweiterbar auf Windows + Linux

## Alternativen
| Option | Pro | Contra |
|--------|-----|--------|
| Eigene Engine (C++/Vulkan) | Volle Kontrolle | Jahre an Entwicklungszeit, kein Team |
| Unity | Große Asset-Pipeline, C# | Lizenzkosten bei Umsatz, Vendor-Lock |
| Godot 4 | Open Source, Linux-Export nativ, kein Vendor-Lock | Eigenständige Toolchain |
| *Entscheidung folgt in ADR-006 (Tech-Stack)* | | |

## Konsequenzen
- Projekt-Ordner: `D:\Entwicklung\Projekte\OpenMotion` (bestehend, mit IDEA.md)
- Vault-Struktur unter `10-Projects/OpenMotion/` (README, Backlog, Art-Konzept)
- Art-Konzept + Logo sind Lead-Aufgaben (Glieder: eigene Optik, gleiche Bedienung)
- Git-Init im Projektordner, CHANGELOG.md + KNOWN_ISSUES.md nach jedem Task (Workflow-Präferenz)
- Jede Ausgabe (Software, Assets, Steam Direct 100 $) erst nach Freigabe durch Glieder

## Verlinkungen
- [[Index|🏠 Brain Index]]
- [[10-Projects/OpenMotion/README|OpenMotion Projekt]]
- [[50-Sessions/2026-08-09_OpenMotion-Kickoff|Session: Kickoff]]
- [[60-Decisions/ADR-004_Arbeitsregeln|ADR-004 — Arbeitsregeln]]
