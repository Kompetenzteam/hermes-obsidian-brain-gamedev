---
tags: [decision, rechtsform, steuern]
date: 2026-08-09
project: OpenMotion
status: accepted
deciders: [Glieder]
---

# ADR-008: Rechtsform — Einzelunternehmen

## Status
**Accepted** (Freigabe Glieder, 2026-08-09)

## Kontext
Glieder arbeitet allein an OpenMotion (Nahverkehrs-Simulator, Steam-Veröffentlichung geplant). Es wurde die Frage nach einer GbR-Gründung gestellt. Eine GbR erfordert jedoch **mindestens zwei Gesellschafter** — für eine Ein-Personen-Gründung ist sie daher nicht geeignet. Da Glieder allein arbeitet und kein weiterer Gesellschafter beteiligt ist, entfällt die GbR als Option.

## Entscheidung
**OpenMotion wird als Einzelunternehmen geführt** (Freigabe Glieder, 2026-08-09):

- **Rechtsform:** Einzelunternehmen (keine GbR — mind. 2 Gesellschafter erforderlich, nicht gegeben)
- **Gewerbeanmeldung:** Beim Gewerbeamt der Stadt (Tätigkeit: „Entwicklung von Computerspielen“), Kosten 20–60 €
- **Steuer:** Kleinunternehmerregelung anstreben (unter 25.000 € Umsatz → keine Umsatzsteuer-Pflicht)
- **Upgrade-Pfad:** Jederzeit Wechsel auf eine UG (haftungsbeschränkt, ab 1 € Stammkapital) möglich, wenn die Geschäfte wachsen

## Alternativen
| Option | Pro | Contra |
|--------|-----|--------|
| **Einzelunternehmen** (gewählt) | Einfachste Gründung, keine Gesellschafter nötig, geringe Kosten, passt zum Allein-Entwickler | Volle persönliche Haftung, Gewinn wird als Einkommensteuer versteuert |
| GbR | Geteilte Haftung/Arbeit | **Braucht mind. 2 Gesellschafter** — nicht möglich, da Glieder allein arbeitet |
| UG (haftungsbeschränkt) | Haftungsbeschränkung | Höherer Gründungsaufwand, Stammkapital nötig — später als Upgrade möglich |

## Konsequenzen
- **Volle persönliche Haftung** mit dem Privatvermögen (keine Haftungsbeschränkung wie bei UG/GmbH)
- **Gewinn = Einkommensteuer:** Der Gewinn wird über die Einkommensteuererklärung versteuert, keine Körperschaftsteuer
- **Keine Mindestbuchführung:** Einnahmen-Überschuss-Rechnung (EÜR) jährlich ans Finanzamt genügt
- **Jederzeit Upgrade auf UG** (haftungsbeschränkt, ab 1 €) möglich, sobald das Projekt wächst oder ein Risiko-Schutz sinnvoll wird
- Alle Gründungs-Schritte im Detail: siehe Gründungs-Checkliste

## Verlinkungen
- [[Index|🏠 Brain Index]]
- [[10-Projects/OpenMotion/README|OpenMotion Projekt]]
- [[10-Projects/OpenMotion/Recht-Gruendung|Recht & Gründung — Checkliste Steam-Veröffentlichung]]
- [[50-Sessions/2026-08-09_Rechtsform-Gruendung|Session: Rechtsform & Gründung]]
