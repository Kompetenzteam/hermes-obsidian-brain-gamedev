---
tags: [decision, architecture, critical]
date: 2026-07-17
projects: [Glorious-Framework, Glorious-Platform]
status: accepted
deciders: [Glieder, Hermes]
---

# ADR-003: Abgleich Glorious-Platform vs. Glorious-Framework

## Kontext
Es existieren zwei Projekte:
1. **[[10-Projects/Glorious-Framework/README|Glorious-Framework]]** (`Y:\projekte\glorious-framework`) — Bestehendes Projekt, aktiv entwickelt, Tech-Stack: Go + Tauri + Chi + GORM + SQLite + CoreUI
2. **[[10-Projects/Glorious-Platform/README|Glorious-Platform]]** (`d:\entwicklung\Glorious Platform\`) — Neues Projekt (Ordner leer), Architektur aus Copilot-Dokument abgeleitet

## Vergleich der Tech-Stacks

| Aspekt | Glorious-Framework (IST) | Glorious-Platform (SOLL laut Doku) |
|--------|--------------------------|-------------------------------------|
| Frontend | CoreUI Bootstrap + Tauri | React + TypeScript + Tailwind/shadcn |
| Desktop-Shell | Tauri (Rust) | Nicht spezifiziert |
| HTTP-Router | Chi | Chi |
| ORM/DB | GORM + SQLite | Repository Pattern + SQLite/PostgreSQL |
| Auth | (geplant: eigenes System) | OIDC + Casbin + Passkeys |
| Plugin-System | Go-Module (intern) | Hashicorp go-plugin (Prozess-Isolation) |
| Suche | Keine | Bleve (embedded) |
| Logging | (via zap indirekt) | Zap |
| Lizenz | Keine definiert | AGPLv3 + Commercial License |
| rclone | CLI-Wrapper vorhanden | Gebündelt + GUI |

## Entscheidung

**Beschluss:** Glorious-Platform und Glorious-Framework sind **getrennte, unabhängige Projekte**. Sie teilen ähnliche Konzepte (Go, Chi, SQLite) aber stehen auf unterschiedlichen Füßen.

## Schlüsselfragen

1. **Ist Glorious-Platform ein Ersatz für Glorious-Framework?**
   - **Nein.** Getrennte Projekte mit unterschiedlichen Zielen.

## Empfohlene nächste Schritte

## Verlinkungen
- [[10-Projects/Glorious-Framework/README|Glorious-Framework]]
- [[10-Projects/Glorious-Platform/README|Glorious-Platform]]
- [[50-Sessions/2026-07-17_Glorious-Platform-Analyse|Session]]
