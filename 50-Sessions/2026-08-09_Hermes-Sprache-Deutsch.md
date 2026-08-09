# Session: Hermes auf Deutsch umgestellt

**Datum:** 2026-08-09
**Status:** Abgeschlossen, verifiziert

## Kontext
Der Benutzer möchte die Hermes-Agent-Oberfläche vollständig auf Deutsch umstellen.

## Durchgeführte Änderung
- Konfiguration: `display.language = de` gesetzt via `hermes config set display.language de`
- Konfigdatei: `C:\Users\Kompetenzteam\AppData\Local\hermes\config.yaml`

## Verifikation
- `hermes config get display.language` → `de`
- i18n-Resolver lädt `de` aus `locales/de.yaml` (440 Zeilen, vollständiger Katalog)
- Stichproben: `approval.choose_long`, `gateway.model.switched`, `approval.timeout` liefern deutsche Strings
- Keine `HERMES_LANGUAGE`-Env-Variable vorhanden, die überschreiben würde

## Details / Hinweise
- Sprache wird pro Prozess gecacht (`agent/i18n.py` `_config_language_cached`) — laufende Prozesse brauchen Neustart
- Supported Languages laut `agent/i18n.py`: en, zh, zh-hant, ja, de, es, fr, tr, uk, af, ko, it, ga + weitere; Alias `de-de`, `deutsch`, `german` → `de`
- Statische UI-Meldungen (Approvals, Gateway, Slash-Commands) werden übersetzt; LLM-Antworten folgen weiterhin der Benutzerpräferenz (Deutsch)

## Verknüpfungen
- [[ADR-002-Obsidian-Brain]]
- [[2026-07-17_Hermes-Brain-Setup]]

## Offen
- Neustart des Gateway/Desktop-App falls gerade aktiv, damit der Sprach-Cache neu geladen wird
