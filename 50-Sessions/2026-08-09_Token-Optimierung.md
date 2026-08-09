---
tags: [session, token-optimization, config]
date: 2026-08-09
project: Alle
type: session
---
# Session: Token-Optimierung (Recherche → Umsetzung → Verifikation)

**Datum:** 2026-08-09

## Auftrag
Recherchieren, wie der Tokenverbrauch massiv optimiert werden kann (gleiche Qualität/Geschwindigkeit), Vorschläge pitchen, auf Freigabe umsetzen.

## Recherche (Quellen)
- Hermes-Doku: `developer-guide/prompt-assembly`, `context-compression-and-caching`, `guides/tips` (offiziell, Repo `main`)
- DeepSeek API-Docs: `guides/kv_cache` — automatisches Hard-Disk-Prefix-Caching; Cache-Hit = überlappender Prefix wird nur aus Cache geholt; Hit erfordert stabilen Prefix
- Messung: `hermes prompt-size` → Systemprompt 31,4 KB/Turn Fixkosten (Skills-Index 9,2 KB = 29%!)

## Umsetzung (verifiziert)
1. **Memory konsolidiert:** 19 → 15 Einträge (6.833 B → 4.464 B). Entfernt: 2 alte Glorious-Duplikate, 2 englische Duplikat-Fragmente, 2 alte OpenMotion-Einträge (in Master-Eintrag gemerged).
2. **Skills-Pruning:** 55 ungenutzte Skills gelöscht (42 behalten — inkl. projektrelevanter godot-*, Logo/SVG-Pipeline, Brain-Skills, subagent-orchestration). Backup: `D:\Entwicklung\backups\skills-pruned-20260809.zip`. `hermes skills opt-out` gesetzt (kein Re-Seeding bei Updates; Reaktivierung via `opt-in --sync`).
3. **Compression:** `compression.threshold 0.6` (war 0.5), `compression.min_tail_user_messages 2` — via `hermes config set` + `hermes config get` verifiziert.
4. **Modell-Fakten:** deepseek-v4-flash = 1.000.000 Kontext / 384.000 Output (models_dev_cache).

## Ergebnis (gemessen)
| Metrik | Vorher | Nachher | Δ |
|---|---|---|---|
| Systemprompt total | 31.450 B | 24.147 B | **−23%** |
| Skills-Index | 9.176 B | 4.147 B | **−55%** |
| Memory | 6.833 B | 4.464 B | −35% |

Gilt ab der nächsten Session (Prompt wird beim Session-Start gebaut).

## Regeln verankert
- ADR-004: neue Sektion "⚡ Token-Optimierung" (Cache-Schutz-Regel, Skills-Index-Pflege, Memory-Disziplin, Compression-Config, Kontext-Disziplin)

## Verlinkungen
- [[60-Decisions/ADR-004_Arbeitsregeln|ADR-004 — Arbeitsregeln]]
- [[Index|🏠 Brain Index]]
