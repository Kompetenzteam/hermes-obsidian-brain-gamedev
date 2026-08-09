---
tags: [template, kickoff, project]
type: template
---
# Projekt-Kickoff-Fragekatalog

> Verbindlich bei jedem neuen Projekt (ADR-004). Solange abfragen, bis ein gutes Projektbild vorliegt ODER der User eine umfassende Projektbeschreibung liefert. Rückfragen gebündelt (max. 5 pro Runde), kritisch hinterfragen, Verbesserungen vorschlagen.

## Runde 1 — Fundament
1. **Ziel & Zweck:** Was soll das Projekt erreichen? Welches Problem löst es?
2. **Zielgruppe:** Für wen ist es? (intern/extern, Anzahl Nutzer)
3. **MVP vs. Vollausbau:** Was ist der kleinste funktionierende Umfang, was später?

## Runde 2 — Technik & Integration
4. **Stack:** Technologie-Wünsche vorhanden oder frei wählbar (Empfehlung durch Lead)?
5. **Integrationen:** Bestehende Systeme, APIs, Dienste, Datenquellen?
6. **Deployment:** Wo läuft es (lokal, Server, VM, Cloud, Docker)? Betriebsmodell?

## Runde 3 — Qualität & Betrieb
7. **Sicherheit:** Sensible Daten? Auth-Anforderungen? Compliance?
8. **Performance/Scale:** Erwartete Last, Verfügbarkeitsziele?
9. **Zeit/Budget:** Fristen, Ressourcen, Prioritäten?

## Runde 4 — Erfolg
10. **Erfolgskriterien:** Woran erkennen wir, dass das Projekt gut ist?
11. **Nicht-Ziele:** Was explizit NICHT Teil des Projekts?
12. **Vorbilder:** Gibt es Referenzprojekte/-produkte?

## Abschluss
- Verbleibende Fragen → kritische Einwände + Verbesserungsvorschläge formulieren
- Erst bei klarem Bild: Projekt anlegen (10-Projects/<Name>/, ADR, README, Backlog, Git-Init)
