---
tags: [session]
date: 2026-08-09
project: OpenMotion
summary: M6 abgeschlossen — deterministische Referenzkarte, Godot-Karten-Rendering, i18n-Integration (216 Tests)
---
# Session: 2026-08-09 — OpenMotion M6 (City/UI)

## Teilnehmer
- Glieder (Entscheider)
- Hermes Agent (Koordinator + Lead)

## Ziele / Aufgaben
- M6: Deterministische Referenzkarte, Godot-Visualisierung, i18n-Integration
- Steamworks-Anleitung im Brain dokumentieren (30-Resources)

## Ergebnisse
- **M6 ✅**: `MapGenerator` (Seed-basierte Referenzkarte 2000×2000: Straßen-Kreuz + 2 Schienen-Segmente + 8 Haltestellen, deterministisch via DeterministicRandom), `MapData`, `MapSerializer` (JSON, Fix32-as-long, formatVersion 1); `MapRenderer.cs` (Godot-3D-Primitive: Straßen grau 6 m, Schienen dunkel 2.8 m, Gehwege hell 1.6 m, Stops warmgelbe Zylinder, sim X/Y → Godot XZ); `CityView.tscn` (Node3D + MapRenderer + Sun + Camera3D); `LocalizationManager.cs` (Locale de default, en umschaltbar, Autoload, LanguageChanged-Relay — TranslationServer.LocaleChanged ist in 4.7.1 mono kein C#-Event); `HUD.tscn` + `HUD.cs` (übersetzte Labels, DE/EN-Umschaltung getestet) — **216 Tests grün**
- **Verifiziert (Headless)**: `[LocalizationManager] Locale=de, geladene Locales=[de, en]` · `[MapRenderer] Referenzkarte (Seed 20260809) gerendert: 6 Segmente, 8 Haltestellen` · Langlauf: Tick-Hashes identisch M4-Baseline
- **Steamworks-Anleitung**: nach `30-Resources/Steamworks-Setup-Anleitung.md` kopiert, in Index + Gesamtkonzept verlinkt
- **Sync**: Projekt gepusht (`17586b1`)

## Offene Punkte
- UI-Anbindung der Wirtschaft/Linien-Planung offen (Backlog: "UI-Anbindung offen")
- Steamworks-Partnerkonto durch Glieder (Anleitung bereit)

## Nächste Schritte
- [ ] M7: Stabilisierung (8-Spieler-Tests, Reconnect, Host-Migration, Performance)
- [ ] M8: Release-Vorbereitung (EA, Store-Assets, Linux-Build)

## Verlinkungen
- [[60-Decisions/ADR-005_OpenMotion|ADR-005]]
- [[60-Decisions/ADR-006_OpenMotion-Tech-Stack|ADR-006]]
- [[10-Projects/OpenMotion/GDD|GDD v0.2]]
- [[10-Projects/OpenMotion/NDD|NDD v0.2]]
- [[10-Projects/OpenMotion/Backlog|Backlog]]
- [[30-Resources/Steamworks-Setup-Anleitung|Steamworks-Setup-Anleitung]]
- [[50-Sessions/2026-08-09_OpenMotion-M4-M5|Session M4–M5]]
