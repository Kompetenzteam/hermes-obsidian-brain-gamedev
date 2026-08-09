---
tags: [session, recht, gruendung]
date: 2026-08-09
project: OpenMotion
summary: Rechtsform-Entscheidung — Einzelunternehmen statt GbR, Gründungs-Checkliste erstellt
---

# Session: 2026-08-09 — Rechtsform & Gründung

## Datum
2026-08-09

## Thema
Rechtsform für die Steam-Veröffentlichung von OpenMotion — GbR-Gründung oder Alternative?

## Ablauf
- Glieder fragte nach einer GbR-Gründung für OpenMotion
- Analyse: Eine GbR benötigt **mindestens zwei Gesellschafter** — für ein Ein-Personen-Projekt nicht geeignet
- Empfehlung: Einzelunternehmen (einfachste Gründung, passt zum Allein-Entwickler)
- Glieder bestätigte: arbeitet allein → Einzelunternehmen ist die richtige Wahl
- Entscheidung dokumentiert (ADR-008), Gründungs-Checkliste angelegt

## Ergebnis
- **ADR-008 accepted:** Rechtsform = Einzelunternehmen (Freigabe Glieder)
- **Gründungs-Checkliste** erstellt: `10-Projects/OpenMotion/Recht-Gruendung.md` (Schritte 1–7, Kostenübersicht, Zeitplan)

## Entscheidungen
- Rechtsform: **Einzelunternehmen** (keine GbR — mind. 2 Gesellschafter erforderlich)
- Kleinunternehmerregelung anstreben (keine Umsatzsteuer-Pflicht unter 25.000 € Umsatz)
- Upgrade-Pfad: später UG (haftungsbeschränkt, ab 1 €) möglich
- Kosten-Gate: Steam App-Fee 100 $ nur nach Freigabe durch Glieder

## Erinnerungs-Infrastruktur
- **Cron-Job:** "OpenMotion Gruendungs-Reminder" (Job-ID `7317723c7c70`), täglich um 9:00 Uhr, Modus `no_agent`
- **Skript:** `C:\Users\Kompetenzteam\AppData\Local\hermes\scripts\openmotion_gruendung_reminder.py`
- **Funktionsweise:** Das Skript prüft den Backlog (`10-Projects/OpenMotion/Backlog.md`). Sobald Meilenstein **M5 „Steam-Anbindung: Auth + Lobby"** oder **M8 „Early Access Release"** als `[x]` abgehakt ist, wird **genau einmal** eine Erinnerung gesendet (Marker-Dateien `.openmotion_reminder_m5_sent` / `.openmotion_reminder_ea_sent` im Skript-Verzeichnis verhindern Doppel-Sendungen).
- **Trigger M5:** Erinnerung an Steamworks-Account + 100 $-App-Fee (mit Freigabe-Pflicht durch Glieder)
- **Trigger M8:** Erinnerung an Gewerbeanmeldung, Geschäftskonto und W-8BEN

## Verlinkungen
- [[60-Decisions/ADR-008_Rechtsform-Einzelunternehmen|ADR-008 — Rechtsform Einzelunternehmen]]
- [[10-Projects/OpenMotion/Recht-Gruendung|Recht & Gründung — Checkliste]]
- [[10-Projects/OpenMotion/Backlog|OpenMotion Backlog]]
- [[10-Projects/OpenMotion/README|OpenMotion Projekt]]
- [[Index|🏠 Brain Index]]
