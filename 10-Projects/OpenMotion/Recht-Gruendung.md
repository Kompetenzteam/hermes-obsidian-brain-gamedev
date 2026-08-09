---
tags: [projekt, recht, steuern, checkliste]
date: 2026-08-09
project: OpenMotion
---

# Recht & Gründung — OpenMotion

Entscheidung: Einzelunternehmen (Glieder arbeitet allein, 2026-08-09, siehe [[60-Decisions/ADR-008_Rechtsform-Einzelunternehmen]]). Keine GbR nötig (mind. 2 Gesellschafter). Upgrade-Pfad: später UG (haftungsbeschränkt, ab 1 €) möglich.

## Status: Steamworks-Partnerkonto angelegt (2026-08-09)

- **Steamworks-Partner-Account angelegt** — NDA + Steam Distribution Agreement elektronisch signiert (kostenlos).
- **Formular durchgeführt bis zur Produkteinreichungsgebühr** (Steam Direct, 100 USD ≈ 100 EUR).
- **Entscheidung (Glieder, 2026-08-09, gemäß Kosten-Gate/Freigabe-Regel): NICHT zahlen.** Formular an diesem Punkt bewusst abgebrochen/offen gelassen — kein Schaden, Fortschritt bleibt gespeichert.
- **Zahlung der Steam-Direct-Gebühr verschoben auf Meilenstein M8 (Early Access Release)** — zusammen mit Bankdaten und US-Steuerformular W-8BEN (Valve verlangt beides vor Auszahlungen).
- **Bis dahin Entwicklung mit Valve-Test-App Spacewar (App-ID 480);** echte App-ID für OpenMotion wird erst Richtung M8 angelegt.

Details zur Durchführung: [[30-Resources/Steamworks-Setup-Anleitung|Steamworks-Setup-Anleitung]]. Session-Protokoll: [[50-Sessions/2026-08-09_Steamworks-Partnerkonto|Session 2026-08-09 — Steamworks-Partnerkonto]].

## Schritt 1 — Gewerbeanmeldung
- Beim Gewerbeamt der Stadt (online oder vor Ort), Tätigkeit: "Entwicklung von Computerspielen"
- Kosten: 20–60 €, Dauer: wenige Tage bis 2 Wochen → Gewerbeschein
- Wichtig: Spieleentwicklung ist gewerblich, kein freier Beruf

## Schritt 2 — Fragebogen zur steuerlichen Erfassung
- Kommt automatisch vom Finanzamt nach Gewerbeanmeldung (online via ELSTER), Frist: 1 Monat
- Kleinunternehmerregelung ankreuzen (unter 25.000 € Umsatz → keine Umsatzsteuer-Pflicht)
- Ergebnis: Steuernummer

## Schritt 3 — Geschäftskonto
- Eigenes Konto für die Firma, Trennung von privat Pflicht
- Empfehlung: Direktbank (N26, bunq), 0–15 €/Monat

## Schritt 4 — Steamworks-Account (Steam-spezifisch)
- Steam-Account → Steamworks-Zugang beantragen (Identitätsverifikation: Ausweis, Handy)
- App-Fee: 100 $ pro Spiel (wird nach 100 $ Verkäufen erstattet) — Kosten-Gate: vor Zahlung Freigabe durch Glieder einholen
- Steuerformular W-8BEN: Freistellungsbescheinigung für USA → 0 % Quellensteuer dank DBA DE/USA (sonst 30 % Abzug)

## Schritt 5 — Spiel anbinden & veröffentlichen
- Steamworks SDK / SteamPipe: Upload, Builds, Achievements
- Store-Seite: Trailer, Screenshots, Beschreibung, Tags
- Steam Review: 1–2 Wochen, Mindestqualität Pflicht
- Early Access möglich (passt zum EA-Modell von OpenMotion)

## Schritt 6 — Buchhaltung
- Einnahmen-Überschuss-Rechnung (EÜR) jährlich ans Finanzamt
- Belege sammeln (Rechnungen, Steam-Abrechnungen)
- Gewerbesteuer: Freibetrag 24.500 € → bis dahin keine
- Gewinn wird als Einkommensteuer versteuert
- Optional Steuerberater (100–300 €/Jahr, lohnt ab ~10.000 € Umsatz)

## Schritt 7 — Nach dem Launch
- Steam zahlt monatlich Tantiemen (30 % Steam, 70 % Entwickler) ab Mindestsumme ~100 $
- Umsatzsteuer auf digitale Leistungen: Steam wickelt ab (Marketplace-Modell seit 2021)
- Steam-Abrechnungen fließen in die EÜR

## Kostenübersicht
| Posten | Kosten |
|---|---|
| Gewerbeanmeldung | 20–60 € |
| Finanzamt | 0 € |
| Geschäftskonto | 0–15 €/Monat |
| Steam App-Fee | 100 $ (einmalig, erstattbar) |
| Steuerberater (optional) | 100–300 €/Jahr |
| **Gesamt Start** | **~120–170 € + 100 $ Steam** |

## Zeitplan-Empfehlung
- Jetzt: nichts unternehmen
- Nach abgeschlossener Demo (M2/M3): Gewerbeanmeldung + Geschäftskonto
- Vor EA-Start: Steamworks-Account + App-Fee (mit Freigabe), Steuerformular W-8BEN
- Verlinkungen: [[60-Decisions/ADR-008_Rechtsform-Einzelunternehmen]], [[10-Projects/OpenMotion/README]], [[10-Projects/OpenMotion/Projektplan]], [[30-Resources/Steamworks-Setup-Anleitung]], [[50-Sessions/2026-08-09_Steamworks-Partnerkonto]]
