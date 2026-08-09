---
tags: [projekt, recht, steuern, checkliste]
date: 2026-08-09
project: OpenMotion
---

# Recht & Gründung — OpenMotion

Entscheidung: Einzelunternehmen (Glieder arbeitet allein, 2026-08-09, siehe [[60-Decisions/ADR-008_Rechtsform-Einzelunternehmen]]). Keine GbR nötig (mind. 2 Gesellschafter). Upgrade-Pfad: später UG (haftungsbeschränkt, ab 1 €) möglich.

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
- Verlinkungen: [[60-Decisions/ADR-008_Rechtsform-Einzelunternehmen]], [[10-Projects/OpenMotion/README]], [[10-Projects/OpenMotion/Projektplan]]
