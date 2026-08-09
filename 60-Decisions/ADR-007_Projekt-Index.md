---
tags: [decision, architecture, process]
date: 2026-08-09
project: Hermes-Brain-Infrastruktur
status: accepted
deciders: [Glieder]
---

# ADR-007: Projekt-Index-Infrastruktur (stündlicher Index-Cronjob)

## Kontext
Jedes Projekt unter `D:\Entwicklung\Projekte\<Name>` erzeugt laufend neue Quellcode-Dateien, Funktionen und Abhängigkeiten. Ohne einen gepflegten Code-Index bleiben Beziehungen zwischen Dateien und die Auswirkung von Änderungen (Impact) im Brain unsichtbar — Nachschlagen in NDD/GDD und manuelles Durchsuchen des Codes ist teuer und unvollständig. Der Brain soll deshalb pro Projekt einen laufend gepflegten Code-Index führen.

## Entscheidung
**Beschluss (FREIGEGEBEN von Glieder, 2026-08-09):** Stündlicher Projekt-Index-Scan per Cronjob mit folgender Ausgestaltung:

- **Cronjob:** Ein stündlicher Hermes-Cronjob (`project-indexing`-Skill) führt den Scan für alle Projekte aus.
- **Projekterkennung (dynamisch):** Projektliste wird per `ls D:\Entwicklung\Projekte` ermittelt — neue Projekte werden automatisch erfasst, keine statische Liste.
- **Parallele Subagents:** Je Projekt ein paralleler Subagent, maximal 9 gleichzeitig (`delegation.max_concurrent_children=9`); weitere Projekte warten auf einen freien Slot.
- **Index-Struktur:** `10-Projects/<Projekt>/Index/` mit vier Dateien:
  - `index.md` (Projektüberblick, Scan-Statistik, Letzte Änderungen, Links)
  - `files.md` (Datei-Tabelle: Datei, Typ, Status, Zweck, Link)
  - `functions.md` (Funktionen/Klassen/Methoden gruppiert nach Datei)
  - `dependencies.md` (Abhängigkeiten pro Datei + Impact-Map + Kernmodule)
- **Hybrid-Scan-Strategie:** Initial-Vollscan beim ersten Lauf; danach inkrementell — Struktur-Scan (Dateiliste) jede Stunde, Vollanalyse nur für geänderte/neue Dateien (Erkennung via `mtime > last_scan` ODER `git status --porcelain`). Unveränderte Dateien behalten Status „unverändert", verschwundene Dateien werden als „entfernt" markiert.
- **Exclusions:** Binär-, generierte und Secret-Dateien werden nicht indexiert (`.git/`, `.godot/`, `bin/`, `obj/`, `node_modules/`, `.venv/`, `__pycache__/`, `dist/`, `build/`, `*.dll`, `*.exe`, `*.png`, `*.wav`, `*.glb`, `*.import`, `.env*`, `secrets.*`, `*.key`, `*.pem` u. a. — vollständige Liste im `project-indexing`-Skill).
- **Zweck:** Beziehungen/Abhängigkeiten im Projekt sichtbar machen, Impact von Änderungen früh erkennen (Impact-Map bei geänderten Dateien), schneller Einstieg über den Brain statt rohen Code.

## Alternativen
| Option | Pro | Contra |
|--------|-----|--------|
| **Stündlicher Cronjob mit Hybrid-Scan** (gewählt) | Immer aktuelle Struktur, Vollanalyse nur bei Änderung (effizient), Impact früh sichtbar | Einmalige Einrichtung, Cronjob muss überwacht werden |
| Einmaliger manueller Index | Kein Setup | Veraltet sofort, kein Impact-Tracking |
| Vollscan jede Stunde (ohne Hybrid) | Einfach | Teuer bei großen Projekten, unnötige Analyse unveränderter Dateien |

## Konsequenzen
- Der Cronjob schreibt ausschließlich in `10-Projects/<Projekt>/Index/` — Projekt-Dokumente (README, GDD, NDD, Backlog) bleiben unangetastet.
- `last_scan` im Frontmatter von `index.md` dient als Inkremental-Marker (ISO-Zeitstempel).
- Wikilinks zu Projekt-Doku nutzen immer den Pfadanteil (`[[10-Projects/OpenMotion/GDD|GDD]]`) wegen Namenskollisionen (README existiert mehrfach).
- Keine Secrets in den Index übernehmen: Exclusions decken `.env` etc. ab, zusätzlich warnt der Skill.
- Fehlschläge des Cronjobs sind über die Scan-Statistik in `index.md` sichtbar (letzter Scan, Dateizählung).

## Verlinkungen
- [[Index|🏠 Brain Index]]
- [[60-Decisions/ADR-002_Obsidian-Brain|ADR-002 — Obsidian Brain]]
- [[60-Decisions/ADR-004_Arbeitsregeln|ADR-004 — Arbeitsregeln]]
- [[50-Sessions/2026-08-09_Projekt-Index-Cronjob|Session: Projekt-Index-Cronjob]]
- [[10-Projects/OpenMotion/Index/index|OpenMotion-Index]]
