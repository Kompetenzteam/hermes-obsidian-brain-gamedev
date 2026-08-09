---
tags: [session, brain, rules, lessons]
date: 2026-08-09
project: Alle
summary: Neue harte Regel von Glieder: Brain-Doku-Pflicht (Jede Änderung/Entscheidung/Projektplanerweiterung sofort im Brain mit Historie, Datum, Entscheidungsgrund) + LessonsLearned-Doku für alle Fehler und Lösungen. ADR-004 erweitert, LessonsLearned.md angelegt und initial befüllt.
---

# Session: 2026-08-09 — Brain-Doku-Pflicht & LessonsLearned

## Teilnehmer
- Glieder (User)
- Hermes Agent (AI)

## Ziele / Aufgaben
- Neue Arbeitsregel von Glieder entgegennehmen und verbindlich verankern

## Neue Regel (Glieder, wörtlich)
> Neue Regel, alle Änderungen, Entscheidungen und Projektplanerweiterungen müssen sofort im Brain dokumentiert werden mit Historie, Datum, Entscheidungsgrund, damit alles nachvollziehbar bleibt. Alle gemachten Fehler und Lösungen müssen ebenfalls in LessonsLearned dokumentiert werden, damit wir diese Fehler nicht nochmal wiederholen.

## Entscheidungsgrund
- Vollständige Nachvollziehbarkeit aller Projektentscheidungen (Wer? Wann? Warum?)
- Fehlervermeidung durch dokumentierte Lösungen (Organisationales Gedächtnis)
- Ergänzt die bestehende Brain-Sync-Regel (2026-08-09) um Historie/Entscheidungsgrund + zentrale LessonsLearned-Notiz

## Umsetzung (verifiziert)
1. **Memory:** Brain-Sync-Regel-Eintrag erweitert (Brain-Doku-Pflicht + LessonsLearned-Regel) ✅
2. **ADR-004** (`60-Decisions/ADR-004_Arbeitsregeln.md`): Bullet „Brain-Doku-Pflicht (2026-08-09)" unter Brain-Protokoll ergänzt ✅
3. **LessonsLearned.md** (`30-Resources/LessonsLearned.md`): neu angelegt, initial mit 6 verifizierten Einträgen (Windows-Tooling, search_files/MSYS, sync-brain untracked, Assets/Bilder, vtracer-Logo, Steam-Gebühr) ✅
4. **Index.md:** Session + Ressource verlinkt ✅
5. **GitHub-Sync:** `sync-brain.sh` ausgeführt ✅
6. **Skill-Update:** `obsidian-brain-protocol` gepatcht — LessonsLearned-Pflicht + Historie/Datum/Entscheidungsgrund als verbindlicher Workflow-Schritt ✅

## Verlinkungen
- [[30-Resources/LessonsLearned|Lessons Learned — Fehler & Lösungen]]
- [[60-Decisions/ADR-004_Arbeitsregeln|ADR-004 — Arbeitsregeln]]
- [[Index|🏠 Brain Index]]
