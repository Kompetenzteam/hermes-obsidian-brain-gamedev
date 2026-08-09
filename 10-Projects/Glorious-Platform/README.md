---
tags: [project, analysis]
status: planning
started: 2026-07-17
source_doc: "D:\\Entwicklung\\Glorious_Platform_Preliminary_Final_SAD 1\\für ein in go programmierte applikation suche ich nach dem besten security.docx"
project_folder: "d:\\entwicklung\\Glorious Platform\\"
decisions: "[[60-Decisions/ADR-003_Glorious-Platform|ADR-003]]"
---
# Glorious Platform

> **Status:** Eigenständige Neuentwicklung. Kein Zusammenhang mit dem [[10-Projects/Glorious-Framework/README|Glorious-Framework]] (siehe [[60-Decisions/ADR-003_Glorious-Platform|ADR-003]]).

## Quelle
- **Datei:** `D:\Entwicklung\Glorious_Platform_Preliminary_Final_SAD 1\für ein in go programmierte applikation suche ich nach dem besten security.docx`
- **Umfang:** 40.384 Zeilen, ~720 KB
- **Typ:** Copilot-Chat-Verlauf (mehrere Iterationen)
- **Projektordner:** `d:\entwicklung\Glorious Platform\` (aktuell **leer**)

## Zusammenfassung
Das Dokument ist ein ausführlicher Dialog mit Microsoft Copilot zur Architektur einer neuen modularen Go-Plattform namens **"Glorious Platform"**. Es wurde iterativ verfeinert — beginnend bei Security-Frameworks, über Datenbank-Design, DSGVO-Compliance, Lizenzierung bis hin zu einer vollständigen Architektur- und Projektplanung.

## Projektvision
- Modulare Management-, Automatisierungs- und Hostingplattform
- Open-Source-Core (AGPLv3) mit kommerziellen Erweiterungen
- Single-Binary-fähig (Windows, Linux, Docker)
- Plugin-Ökosystem
- Vergleichbare Produkte: Nextcloud, Portainer, Authentik, Plesk

## Kernanforderungen (aus dem Dokument)

### Funktionalität
- Benutzerverwaltung (CRUD, aktivieren/deaktivieren)
- Berechtigungsverwaltung (CRUD, RBAC)
- Webserververwaltung (Caddy primär)
- Plugin-System (Hashicorp go-plugin)
- Sichere Plugin-API (mTLS + JWT)
- Backup & Restore (lokal + rclone Cloud)
- Logging (Kategorien, Suche, Filter)
- Volltextsuche (Bleve)
- Templatesystem (Light/Dark Mode)
- Lizenzsystem (AGPLv3 + kommerziell)
- Update-System (signierte Updates)
- DSGVO-konform (Export, Löschung, Pseudonymisierung)

### Sicherheit
- OIDC/OpenID Connect (Entra ID, Keycloak, Authentik)
- Casbin RBAC
- Passkeys (WebAuthn/FIDO2)
- MFA/TOTP
- Backupcodes
- Automatische Token-Rotation
- mTLS für Plugin-Kommunikation
- Token Vault (AES-256-GCM)
- Rate Limiting
- Security Headers

## Empfohlener Tech-Stack (laut Dokument)

| Schicht | Technologie |
|---------|------------|
| **Backend** | Go 1.25+ |
| **HTTP-Router** | Chi |
| **Datenbank** | SQLite (Default) / PostgreSQL (Enterprise) |
| **Auth** | go-oidc + Casbin + WebAuthn |
| **Plugins** | Hashicorp go-plugin |
| **Suche** | Bleve |
| **Logging** | Zap |
| **API-Doku** | OpenAPI 3.1 / Swaggo |
| **Frontend** | React + TypeScript + Vite |
| **UI** | Tailwind CSS + shadcn/ui |
| **Desktop** | Kein Tauri erwähnt (anders als Glorious-Framework) |
| **Reverse Proxy** | Caddy |
| **Backup** | rclone (gebündelt) |

## Projektphasen (laut Dokument)

| Phase | Inhalt | Dauer |
|-------|--------|-------|
| 1 — Fundament | Repo, CI/CD, DB, Auth, RBAC, API, Frontend | 4-6 Wochen |
| 2 — Benutzerplattform | Profile, MFA, Passkeys, Backupcodes, Logging | 4 Wochen |
| 3 — Pluginframework | Plugin SDK, Manager, Security, Tokenrotation | 4-6 Wochen |
| 4 — Backup & Rclone | Backup Engine, Restore, Cloud, GUI | 4 Wochen |
| 5 — Lizenzierung | Lizenzserver, Dateien, Marketplace-Basis | 2-3 Wochen |
| 6 — Update-System | Versionierung, Signaturen, Rollback | 3 Wochen |
| 7 — Webserver | Caddy-Modul, Sites, TLS | 4 Wochen |

## Planungslücken (laut Dokument)
- Secret Management (Vault)
- Monitoring (Prometheus/Grafana)
- Notifications (E-Mail, Webhook, Discord)
- Job Scheduler
- API Versioning
- Feature Flags

## Vorgeschlagene Projektstruktur
```
/core        — Core-Logik
/api         — API Gateway
/auth        — Authentifizierung
/rbac        — Berechtigungen
/plugins     — Plugin-System
/license     — Lizenzmanager
/update      — Update-Manager
/search      — Volltextsuche
/logging     — Logging
/backup      — Backup-Engine
/storage     — Speicher-Abstraktion
/webserver   — Webserver-Verwaltung
/ui          — React-Frontend
/docs        — Dokumentation
/tests       — Tests
/scripts     — Build-Skripte
/deploy      — Deployment-Konfiguration
```

## Verlinkungen
- [[10-Projects/Glorious-Framework/README|Glorious-Framework]] — Bestehendes Projekt
- [[60-Decisions/ADR-003_Glorious-Platform|ADR-003 — Abgleich Glorious-Platform vs Framework]]
- [[50-Sessions/2026-07-17_Glorious-Platform-Analyse|Session: Analyse]]
