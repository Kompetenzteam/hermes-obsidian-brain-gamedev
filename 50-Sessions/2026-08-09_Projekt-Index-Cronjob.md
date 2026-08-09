---
tags: [session]
date: 2026-08-09
project: Hermes-Brain-Infrastruktur
summary: Projekt-Index-Infrastruktur eingerichtet — stündlicher Index-Cronjob per ADR-007 beschlossen, OpenMotion-Index-Skelett angelegt, Skill project-indexing erstellt
---

# Session: 2026-08-09 — Projekt-Index-Cronjob

## Teilnehmer
- Glieder (Geschäftsführer/Entscheider)
- Hermes Agent (Koordinator)

## Ziele / Aufgaben
- Projekt-Index-Infrastruktur im Brain einrichten (nur Infrastruktur, keine Projekt-Inhalte)
- Regel-Änderung dokumentieren: stündlicher Projekt-Index-Scan
- Skill `project-indexing` anlegen

## Ergebnisse
- **Regel-Änderung (2026-08-09):** Stündlicher Projekt-Index-Scan per Cronjob; je Projekt ein paralleler Subagent (max. 9, `delegation.max_concurrent_children=9`); dynamische Projekterkennung via `ls D:\Entwicklung\Projekte`; dokumentiert in [[60-Decisions/ADR-007_Projekt-Index|ADR-007]]
- **Index-Struktur:** `10-Projects/<Projekt>/Index/` mit `index.md`, `files.md`, `functions.md`, `dependencies.md`
- **Hybrid-Scan:** Initial-Vollscan, danach inkrementell (Struktur-Scan stündlich, Vollanalyse nur geänderter/neuer Dateien via mtime/git status)
- **OpenMotion-Skelett angelegt:** [[10-Projects/OpenMotion/Index/index|OpenMotion-Index]] (4 Dateien mit Frontmatter, Überschriften und Befüll-Hinweis)
- **Skill angelegt:** `project-indexing` (Exclusions, Scan-Schritte, Output-Schema, Pitfalls, Verifikationspflicht)

## Offene Punkte
- Cronjob selbst noch nicht eingerichtet (nächster Schritt: Hermes-Cronjob mit `project-indexing`-Skill konfigurieren)
- Erster Scan-Befüllungslauf für OpenMotion ausstehend (und danach für Glorious-Framework, Glorious-Platform)

## Nächste Schritte
- [ ] Hermes-Cronjob für den stündlichen Index-Scan einrichten
- [ ] Initial-Vollscan für OpenMotion ausführen

## Verlinkungen
- [[60-Decisions/ADR-007_Projekt-Index|ADR-007 — Projekt-Index-Infrastruktur]]
- [[10-Projects/OpenMotion/Index/index|OpenMotion-Index]]
- [[Index|🏠 Brain Index]]
