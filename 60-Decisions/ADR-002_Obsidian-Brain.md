---
tags: [decision, methodology]
date: 2026-07-17
project: Glorious-Framework
status: accepted
deciders: [Glieder]
---
# ADR-002: Obsidian Brain für Langzeit-Wissen

## Kontext
Hermes Agent hat begrenzten persistenten Speicher (Memory: ~2.200 Zeichen, Session Search: reaktiv). Für strukturiertes Langzeit-Wissen über Projekte, Architektur und Entscheidungen reicht das nicht.

## Entscheidung
**Beschluss:** Obsidian Vault unter `D:\Entwicklung\obsidian_brain` als zentrales Knowledge Base System.

**Struktur:**
| Ordner | Zweck |
|--------|-------|
| `00-Inbox` | Quick Capture, unverarbeitete Notizen |
| `10-Projects` | Aktive Projekte mit Sub-Ordnern |
| `20-Areas` | Laufende Verantwortlichkeiten |
| `30-Resources` | Referenzmaterial, Docs |
| `40-Archive` | Abgeschlossene/inaktive Elemente |
| `50-Sessions` | Session-Logs chronologisch |
| `60-Decisions` | ADRs (Architecture Decision Records) |
| `70-Deviations` | Abweichungen vom Plan |
| `Templates` | Notiz-Vorlagen |

## Alternativen
| Option | Pro | Contra |
|--------|-----|--------|
| Nur Hermes Memory | Einfach, immer verfügbar | Zu klein (~2.200 Zeichen) |
| Externe Wiki (GitHub) | Kollaborativ | Overkill, kein Offline-Zugriff |
| Notion | Rich Text, DBs | Cloud-Abhängig, kein lokaler Zugriff |

## Konsequenzen
- Hermes Agent schreibt jede Session, Entscheidung und Abweichung ins Vault
- Hermes Memory bleibt für harte Fakten (Stack, Pfade, Preferences)
- Vollständige Offline-Verfügbarkeit
- Markdown-basiert, Git-kompatibel

## Verlinkungen
- [[Index|🏠 Brain Index]]
- [[50-Sessions/2026-07-17_Hermes-Brain-Setup|Setup-Session]]
