---
tags: [lessons, knowledge, process, mooc]
date: 2026-08-09
project: Alle
status: active
---

# Lessons Learned — Fehler & Lösungen

> **Regel (2026-08-09, Glieder):** Alle gemachten Fehler und Lösungen werden hier dokumentiert (Symptom → Ursache → Lösung → Validierung → Prävention), damit Fehler nie wiederholt werden.
> Jeder Eintrag erhält: **Datum, Bereich, Historie, Entscheidungsgrund.**

## Historie

| Datum | Bereich | Fehler / Symptom | Ursache | Lösung | Prävention |
|-------|---------|------------------|---------|--------|------------|
| 2026-08-09 | Windows-Tooling | `cairosvg`/`svglib` scheitern beim SVG-Rendering (cairo-DLL-Fehler) | Native cairo-DLL fehlt auf Windows | `resvg_py` (`svg_to_bytes`) als SVG-Renderer verwenden | Vor SVG-Rendering immer resvg_py nutzen, cairosvg/svglib nicht anbieten |
| 2026-08-09 | Brain/Tooling | `search_files` liefert 0 Treffer im Obsidian-Vault | MSYS-Pfade (`/d/...`) werden nicht verarbeitet | Windows-Pfade (`D:\...`) mit `read_file`/`terminal` verwenden | Brain-Dateien immer mit Windows-Pfaden lesen/schreiben |
| 2026-08-09 | Brain-Sync | Neue Notizen blieben nach Sync ungepusht | `git diff --quiet` erkennt untracked Dateien nicht | Änderungs-Erkennung mit `git status --porcelain` (auch in `sync-brain.sh`) | Sync-Skripte ausschließlich mit `--porcelain` bauen |
| 2026-08-09 | Assets | Selbst generierte Bilder (Pillow-Primitive, KI) von Glieder abgelehnt | Qualität entspricht nicht den Anforderungen | Reale Bildquellen (z.B. Wikimedia Commons-SVGs) als Vorlage + GIMP 3.2.4 | Keine selbst erstellten Bilder liefern; nur reale Vorlagen verwenden |
| 2026-08-09 | Assets/Logo | vtracer übermalt Farbpfade mit Weiß (Vektorisierungs-Artefakt) | Vektorisierung nicht ausreichend geprüft | Qualität kritisch prüfen, alternative Pipeline evaluieren (→ DEV-001, Logo zurückgestellt) | Vektor-Ergebnis vor Freigabe immer visuell verifizieren |
| 2026-08-09 | Steam/Planung | Steam-Direct-Gebühr (100 USD) fälschlich als Schritt der App-Erstellung eingeordnet | Unvollständige Faktenlage | Offizielle Steamworks-FAQ verifiziert: Gebühr ist PFLICHTSCHRITT der Registrierung selbst; Strategie: Steam erst bei M8 | Vor Planungs-Entscheidungen offizielle Doku verifizieren, Kosten-Gate einhalten |

## Eintrag hinzufügen (Vorlage)

```markdown
| YYYY-MM-DD | Bereich | Fehler / Symptom | Ursache | Lösung | Prävention |
|------------|---------|------------------|---------|--------|------------|
|            |         |                  |         |        |            |
```

## Verlinkungen
- [[Index|🏠 Brain Index]]
- [[60-Decisions/ADR-004_Arbeitsregeln|ADR-004 — Arbeitsregeln]]
- [[50-Sessions/2026-08-09_Brain-Doku-LessonsLearned|Session: Brain-Doku-Pflicht & LessonsLearned]]
