---
tags: [session, rules]
date: 2026-08-09
project: Alle
type: session
---
# Session: Übernahme des Arbeitsregelwerks (Project Lead Modus)

**Datum:** 2026-08-09
**Kontext:** Glieder übergibt verbindliches Regelwerk in mehreren Blöcken (Arbeitsweise, Brain-Protokoll, Code-Standards, Kommunikation).

## Ablauf
1. Anfrage: "Zeige mir, welchen Regeln du aktuell unterliegst" → Darstellung der Systemprompt-Regeln
2. Glieder übergibt Regelwerk-Block 1: Arbeitsweise/Projektleitung + Brain-Protokoll + Code-Standards
3. Glieder übergibt Regelwerk-Block 2: Kommunikation
4. Glieder wiederholt Brain-Protokoll (Bestätigung der Wichtigkeit)
5. Hermes speichert Regelwerk persistent im Memory + dokumentiert als ADR-004
6. **Update:** Glieder ergänzt Rückfrage-Pflicht bei Aufgabenstellung (kritisch hinterfragen, Verbesserungen vorschlagen) → Memory + ADR-004 aktualisiert
7. **Update:** Glieder ergänzt Projektstart-Protokoll (systematisches Abfragen bei neuen Projekten) → Memory + ADR-004 + Template `tpl-kickoff.md` angelegt
8. **Update:** Glieder ergänzt Security-Regeln (niemals Credentials im Klartext im Code) → Memory + ADR-004
9. **Update:** Glieder präzisiert Sprachregel: Denken+Antworten immer Deutsch, Code+Kommentare immer Englisch → Memory + ADR-004
10. **Update:** Glieder entfernt Memory-Eintrag "Projekt: Glorious-Framework (…Pfad Y:\projekte\glorious-framework)" — 2 weitere redundante Glorious-Einträge bleiben vorerst bestehen (Rückfrage offen)
11. **Update:** Glieder ergänzt Skill-Autonomie-Metaregel (Skills selbstständig suchen/installieren/programmieren, kontinuierliches Lernen) → Memory + ADR-004 + neuer Skill `project-lead-workflow`

## Ergebnisse
- **Memory aktualisiert:** Vollständiges Regelwerk persistent gespeichert
- **ADR-004_Arbeitsregeln.md** angelegt (60-Decisions)
- **Offener Punkt:** 🎨 Design-Standards fehlen — bei Lieferung als ADR-Update ergänzen

## Entscheidungen dieser Session
- Rollenwechsel: Senior Enterprise Entwickler → Senior Fullstack Project Lead (kein Selbst-Programmieren)
- Autonomie-Modus: keine Rückfragen, Backlog abarbeiten

## Verlinkungen
- [[60-Decisions/ADR-004_Arbeitsregeln|ADR-004 — Arbeitsregeln]]
- [[Index|🏠 Brain Index]]
