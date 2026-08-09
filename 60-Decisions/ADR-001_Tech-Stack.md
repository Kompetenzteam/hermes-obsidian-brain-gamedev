---
tags: [decision, architecture]
date: 2026-07-17
project: Glorious-Framework
status: accepted
deciders: [Glieder]
---
# ADR-001: Tech Stack

## Kontext
Glorious-Framework soll eine Enterprise-Desktop-App mit Web-Frontend und REST-API werden. Benötigt wird eine schlanke, performante Lösung ohne externe DB-Abhängigkeiten.

## Entscheidung
**Beschluss:** Go + Tauri + Chi + GORM + SQLite + CoreUI

| Komponente | Begründung |
|------------|------------|
| **Go** | Performant, statisch kompilierbar, einfaches Deployment |
| **Tauri** | Native Desktop-Shell, kleiner als Electron, Rust-basiert |
| **Chi** | Leichtgewichtiger HTTP-Router, idiomatisches Go |
| **GORM** | Vollständiges ORM für Go, einfache Migrationen |
| **SQLite** | Kein externer DB-Server nötig, portable |
| **CoreUI** | Bootstrap-basiertes Admin-Template, responsive |

## Alternativen
| Option | Pro | Contra |
|--------|-----|--------|
| Electron + Express | Größeres Ökosystem | Hoher RAM-Verbrauch, langsamer |
| Wails + Gin | Ähnlich Tauri/Chi | Weniger verbreitet |
| PostgreSQL statt SQLite | Mehr Features | Externer Server nötig |

## Konsequenzen
- Einzelne Binary deploybar (Go + Tauri)
- Keine externe DB-Installation nötig
- CoreUI-Free als Bootstrap-Admin-Dashboard
- rclone als CLI-Wrapper für Backup/Cloud

## Verlinkungen
- [[10-Projects/Glorious-Framework/README|Glorious-Framework]]
- [[50-Sessions/2026-07-17_Hermes-Brain-Setup|Setup-Session]]
