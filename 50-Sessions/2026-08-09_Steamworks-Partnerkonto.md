---
tags: [session, recht, steam, steamworks]
date: 2026-08-09
project: OpenMotion
summary: Steamworks-Partnerkonto angelegt, NDA + Distribution Agreement signiert; Steam-Direct-Gebühr bewusst nicht bezahlt (Kosten-Gate) — verschoben auf M8; Update: Gebühr = Pflichtschritt der Registrierung selbst, Strategie: komplett ohne Steam bis M7, Steam erst bei M8
---

# Session: 2026-08-09 — Steamworks-Partnerkonto

## Teilnehmer
- Glieder (User)
- Hermes Agent (AI)

## Ziele / Aufgaben
- Steamworks-Partner-Account für OpenMotion anlegen
- Prüfen, wie weit das Anmeldeformular kostenlos durchlaufen werden kann

## Ergebnisse
- **Steamworks-Partner-Account angelegt** — NDA + Steam Distribution Agreement elektronisch signiert (kostenlos).
- **Formular bis zur Produkteinreichungsgebühr durchgeführt** (Steam Direct, 100 USD ≈ 100 EUR) — dort bewusst gestoppt, nichts bezahlt.
- **Entscheidung (Glieder, 2026-08-09, gemäß Kosten-Gate/Freigabe-Regel): NICHT zahlen.** Formular an diesem Punkt bewusst abgebrochen/offen gelassen — kein Schaden, Fortschritt bleibt gespeichert.
- **Zahlung der Steam-Direct-Gebühr verschoben auf Meilenstein M8 (Early Access Release)** — zusammen mit Bankdaten und US-Steuerformular W-8BEN (Valve verlangt beides vor Auszahlungen).
- **Bis dahin Entwicklung mit Valve-Test-App Spacewar (App-ID 480);** echte App-ID für OpenMotion wird erst Richtung M8 angelegt.

## Update (2026-08-09, nachmittags): Faktenlage konkretisiert + Strategie-Entscheidung

**Verifiziert (offizielle Steamworks-Doku, „Anwendungen verwalten“ → FAQ):**
- Die **Steam-Direct-Gebühr (100 USD ≈ 100 EUR) ist ein PFLICHTSCHRITT der Steamworks-Registrierung selbst** (Onboarding-Schritt „Pay the app deposit fee“) — **nicht** erst bei der App-Erstellung. Ohne Zahlung: **kein vollwertiges Partnerkonto** (App-Auswahl/Suchfeld, Spacewar-Freischaltung, SDK-Download bleiben gesperrt).
- **Eingeschränkter Steamworks-Account** (nur NDA + Kontaktdaten, kostenlos) existiert, aber Valve warnt ausdrücklich: **nicht** wählen, wenn Bank-/Steuerinfos für Auszahlungen angegeben werden sollen → für OpenMotion **ungeeignet** (Sackgasse, kein Upgrade).

**Strategie-Entscheidung (Glieder, 2026-08-09):**
- Spiel **komplett ohne Steam bis M7 fertig entwickeln**, Steam erst bei **M8** einbauen — alles dafür nur vorbereiten.
- **Partnerkonto bleibt unvollständig liegen — kein Schaden.**
- **100-USD-Gebühr + vollständige Registrierung erst bei M8**: Identitätsprüfung (2–7 Werktage), Bankdaten, W-8BEN; **Valve-Prüfzeiten in M8-Planung einplanen**.

**Projektstatus Steam (Fakt):** Steamworks.NET 2024.8.0 (SDK 1.60) via NuGet, `steam_api64.dll` unter `libs/win-x64/`, Steam-P2P hinter ITransport-Abstraktion (`P2PSession.cs`, `NetworkingTransportAdapter.cs`) → läuft ohne Steam (InMemory-Transport, 206 Tests grün); `steam_appid.txt` (App-ID 480) vorhanden; echter 2-Rechner-P2P-Test erst nach vollständiger Registrierung (M8).

→ Doku & M8-Tasks: [[10-Projects/OpenMotion/Recht-Gruendung|Recht & Gründung]], [[10-Projects/OpenMotion/Backlog|Backlog]]

## Offene Punkte
- Steam-Direct-Gebühr (100 USD) zahlen — erst bei M8, mit Freigabe durch Glieder
- Bankdaten + W-8BEN eintragen — erst bei M8
- Echte App-ID für OpenMotion anlegen — erst Richtung M8

## Nächste Schritte
- Entwicklung mit Spacewar (App-ID 480) testen
- Vollständige Dokumentation: [[10-Projects/OpenMotion/Recht-Gruendung|Recht & Gründung]]

## Verlinkungen
- [[10-Projects/OpenMotion/Recht-Gruendung|Recht & Gründung — Checkliste]]
- [[30-Resources/Steamworks-Setup-Anleitung|Steamworks-Setup-Anleitung]]
- [[10-Projects/OpenMotion/Projektplan|OpenMotion Projektplan]]
- [[60-Decisions/ADR-008_Rechtsform-Einzelunternehmen|ADR-008 — Rechtsform Einzelunternehmen]]
- [[Index|🏠 Brain Index]]
