---
tags: [project]
status: active
started: 2026-07-13
stack: [Go, Tauri, Chi, GORM, SQLite, CoreUI, rclone]
repo: Y:\projekte\glorious-framework
---
# Glorious-Framework

## Übersicht
- **Ziel:** Enterprise-fähiges, modulares Framework mit Tauri-Desktop-App, REST-API und Web-Frontend
- **Stack:** Go + Tauri + Chi + GORM + SQLite + CoreUI
- **Repo/Ordner:** `Y:\projekte\glorious-framework`
- **Build:** `./bin/glorious-framework.exe` (15.5 MB)

## Architektur-Übersicht
```
Glorious Framework
├── Go Backend (Chi Router)
│   ├── GORM + SQLite
│   ├── i18n (de-de, en-en)
│   └── REST API
├── Tauri Desktop Shell
│   └── WebView mit CoreUI
├── Frontend (CoreUI Bootstrap)
│   └── web/ Verzeichnis
└── CLI-Wrapper (rclone)
```

## Datenbank-Modelle (implementiert)
- User, Role, MFA, Module, Backup, etc.

## HTTP-Router
- Chi mit Static File Serving

## i18n
- Deutsch (de-de)
- Englisch (en-en)

## Offene Tasks
- [ ] Auth-System (Login, MFA)
- [ ] Setup-Assistent
- [ ] rclone-Integration
- [ ] Benachrichtigungen (Mail, Push, Discord, WhatsApp, Windows — gleich priorisiert)
- [ ] Modul: Metriken (Backup-Status, User-Stats, Module-Stats, API-Calls, Speicher, Uptime)
- [ ] Let's Encrypt Zertifikate + Self-Signed

## Session-Log
- [[50-Sessions/2026-07-17_Hermes-Brain-Setup|2026-07-17 — Brain Setup]]

## Entscheidungen
- [[60-Decisions/ADR-001_Tech-Stack|ADR-001 — Tech Stack]]
- [[60-Decisions/ADR-002_Obsidian-Brain|ADR-002 — Obsidian Brain]]

## Abweichungen
- (keine)

