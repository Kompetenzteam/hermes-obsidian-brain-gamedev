# Steamworks-Einrichtung für OpenMotion — Schritt-für-Schritt (ohne Technik-Wissen)

Diese Anleitung führt Sie als Geschäftsführer einmal durch die Anmeldung bei **Steamworks** (der Entwickler-Seite von Steam). Danach haben wir:

- ein aktives Steamworks-Partnerkonto,
- die **App-ID** für OpenMotion,
- das **SDK** (Werkzeugkasten) auf dem Rechner,
- die **Spacewar-Testapp** freigeschaltet, damit unser Dev-Team sofort lokal testen kann.

Zeitaufwand: **ca. 60 Minuten**. Kosten jetzt: **0 €** (mehr dazu in der Kosten-Tabelle unten).

---

## Was ist Steamworks überhaupt?

Der Steam-Shop (store.steampowered.com) ist das **Schaufenster**, in dem Kunden Spiele kaufen. **Steamworks** (partner.steamgames.com) ist der **Hintereingang**: Dort registriert man sein Spiel, verwaltet es und lädt es hoch, bevor es im Schaufenster erscheint. Es ist das offizielle Verwaltungsportal von Valve für alle, die Spiele auf Steam anbieten möchten. Die Nutzung für die Entwicklung ist **kostenlos** — bezahlt wird erst, wenn wir tatsächlich veröffentlichen.

---

## Was brauche ich vorbereiten? (Checkliste)

Bitte vor dem Start bereitlegen:

- [ ] **Steam-Konto** (kostenlos). Falls keins vorhanden: auf `store.steampowered.com` → „Anmelden" → „Konto erstellen". Login-Daten merken.
- [ ] **Handy** mit der Steam-App bzw. Zugang zu E-Mails — Steam schickt beim Anmelden einen Sicherheitscode (**Steam Guard** / 2FA).
- [ ] **Rechtsgültiger Vor- und Nachname** (kein Spitzname, kein Künstlername — Valve verlangt den echten Namen).
- [ ] **Firmenname und Anschrift**, genau wie in Bank- und Steuerunterlagen.
- [ ] **E-Mail-Adresse**, die regelmäßig geprüft wird (auch Spam-Ordner).
- [ ] **Computer mit Internet** und ca. 2–3 GB freiem Speicherplatz (für das SDK).
- [ ] **Keine Kreditkarte, keine Bankdaten, keine Steuerdaten** — die werden jetzt NICHT benötigt (siehe Kosten-Tabelle).

---

## Schritt 1: Partnerkonto anlegen

1. Öffnen Sie Ihren Browser (Chrome, Edge, Firefox …) und geben Sie ein: **`partner.steamgames.com`**
2. Klicken Sie oben rechts auf **„Anmelden"** (Sign in).
3. Es öffnet sich die Steam-Anmeldung:
   - **Benutzername** und **Passwort** eingeben (alternativ QR-Code mit der Steam-App auf dem Handy scannen).
   - Den **Steam-Guard-Code** eingeben, den Steam Ihnen aufs Handy (oder per E-Mail) schickt.
4. Nach dem Login startet der Anmelde-Ablauf von Valve („Steamworks beitreten" o. Ä.). Es werden Formulare mit Angaben abgefragt, etwa:
   - Land,
   - Firmenname (bzw. „Einzelunternehmen" mit Ihrem vollen Namen, falls wir keine Firma nutzen),
   - Ihr rechtsgültiger Vor- und Nachname,
   - Anschrift,
   - Kontakt-E-Mail-Adresse.
   Füllen Sie alles sorgfältig aus. Bitte keine Sonderzeichen (z. B. `ä`, `ö`, `ü` umschreiben) — Valve empfiehlt das für die Formulare.
5. **Stopp-Schild:** Sollte die Seite an irgendeinem Punkt **Bankdaten, Steuerdaten oder eine Zahlung** verlangen: **Nichts eintragen, nichts bezahlen, abbrechen und beim Team melden.** Laut Valve-Doku gibt es auch einen eingeschränkten Anmeldeweg, der nur die Geheimhaltungsvereinbarung und Kontaktdaten braucht.
6. Formular absenden. Prüfen Sie anschließend Ihre **E-Mail** (auch den Spam-Ordner) auf eine Bestätigung von Valve.

> Ergebnis: Sie sind jetzt als Partner bei Steamworks registriert und können sich jederzeit unter `partner.steamgames.com` wieder anmelden.

---

## Schritt 2: Lizenzvereinbarung akzeptieren

**Was das ist:** Im Zuge der Anmeldung müssen zwei Standardverträge digital unterschrieben werden:

1. **Geheimhaltungsvereinbarung (NDA):** Sie verpflichten sich, vertrauliche Informationen von Valve (z. B. technische Details) nicht weiterzugeben. Standard bei allen Entwicklern.
2. **Steam-Vertriebsvereinbarung (Distribution Agreement):** Regelt, dass wir Spiele über Steam verkaufen dürfen — Lizenz, Zahlungsabwicklung, Regeln.

**So geht's:** Die Verträge werden auf der Seite angezeigt. Sie lesen sie durch (die wichtigsten Punkte sind kurz zusammengefasst), setzen ein Häkchen bei „Ich habe gelesen und stimme zu" und klicken auf **„Unterzeichnen"** (Sign). Kein Ausdrucken, kein Notar, kein Fax.

**Worauf achten:**

- Es kostet **nichts**. Es werden **keine Zahlungsdaten** abgefragt.
- Es ist ein **echter Vertrag** — es lohnt sich, die zwei Seiten kurz zu überfliegen. Es ist der Standardvertrag, den alle Steam-Entwickler weltweit unterschreiben; unsere Anwälte/Team haben keine Einwände.
- **Tipp:** Den Browser-Tab nicht zwischendurch schließen — der Ablauf dauert nur 5–10 Minuten und sollte in einem Rutsch fertig werden.

---

## Schritt 3: SDK herunterladen

**Was das SDK ist:** Das SDK (Software Development Kit) ist der **kostenlose Werkzeugkasten von Valve**, mit dem unser Spiel später mit Steam redet (Anmeldung, Erfolge, Cloud-Speicher …). Für Sie heißt das nur: **eine ZIP-Datei herunterladen und entpacken.** Es wird nichts installiert.

**Klick-Pfad:**

1. Auf `partner.steamgames.com` angemeldet sein.
2. Oben auf **„Dokumentation"** klicken.
3. In der linken Spalte **„Steamworks-SDK"** anklicken.
4. Im Abschnitt **„Das neueste Steamworks-SDK"** auf den Link **„hier"** klicken. Der Download startet (ZIP-Datei, ca. 1–2 GB, Name etwa `steamworks_sdk.zip`).

**Wohin speichern:**

1. Öffnen Sie den Windows-Explorer und legen Sie auf Laufwerk **C:** einen Ordner **`Steamworks`** an (Rechtsklick → „Neu" → „Ordner" → Namen eingeben: `Steamworks`).
2. Verschieben Sie die heruntergeladene ZIP-Datei in diesen Ordner.
3. **Rechtsklick auf die ZIP-Datei** → **„Alle extrahieren"** → Zielordner `C:\Steamworks` bestätigen.
4. Danach existiert der Ordner **`C:\Steamworks\sdk`** mit vielen Unterordnern. Das ist das Ziel.

> **Wichtig:** Genau diesen Pfad **`C:\Steamworks\sdk`** später dem Team melden (siehe Abschnitt „Was mache ich mit den Ergebnissen?").

---

## Schritt 4: App erstellen → App-ID notieren

**Was eine App ist:** In Steam-Sprache ist unser Spiel eine **„Anwendung"** (App). Jede App bekommt eine Nummer: die **App-ID** — quasi unsere Hausnummer bei Steam. Das Team braucht sie, um OpenMotion technisch anzubinden.

**Klick-Pfad:**

1. Auf `partner.steamgames.com` angemeldet sein (Startseite/Dashboard).
2. Im Bereich **„Eine neue Anwendung erstellen"** den Button **„Neue Anwendung erstellen"** klicken.
3. **Anwendungstyp: „Spiel"** (Game) auswählen — nicht Software, nicht Demo, nicht DLC.
4. Name eingeben: **OpenMotion**.
5. Bestätigen. Steam vergibt nun eine **App-ID** — eine Zahl (z. B. `1234560`). Sie steht auf der Übersichtsseite der Anwendung und später auch in der App-Auswahl oben links.

**Ihre Aufgabe:**

- **App-ID aufschreiben** (Notizbuch, Handy — egal, Hauptsache festgehalten).
- Einen **Screenshot** der Übersichtsseite machen (Taste `Druck` bzw. `Win+Umschalt+S`).

**Stopp-Schild:** Sollte Steam an dieser Stelle eine **Gebühr (100 US-Dollar „Steam Direct")** verlangen: **Nicht bezahlen, abbrechen und beim Team melden.** Laut unserer Planung ist diese Gebühr erst bei der Veröffentlichung (Phase M8, Early Access) fällig.

---

## Schritt 5: Spacewar-Testapp (480) freischalten für lokale Tests

**Kurz erklärt:** **Spacewar** ist ein kostenloses Übungsspiel von Valve mit der App-ID **480**. Solange unser eigenes Spiel noch nicht vollständig bei Steam eingerichtet ist, testet unser Dev-Team damit lokal. Dafür muss Spacewar in **Ihrem** Steam-Konto freigeschaltet sein. Es gibt zwei Wege:

### Variante A — offizieller Weg über die Steamworks-Partnerseite (empfohlen)

1. Auf `partner.steamgames.com` anmelden.
2. **Oben links** in das Suchfeld der App-Auswahl („Nach Name/App-ID suchen") klicken.
3. **`Spacewar`** (oder die Zahl **`480`**) eingeben und den Eintrag **„Spacewar"** auswählen.
4. Auf der Spacewar-Seite einen Button bzw. Link suchen, der das Spiel **zum eigenen Steam-Konto hinzufügt** — die Beschriftung lautet sinngemäß **„Add Spacewar to my account"** / „Spacewar zu meinem Konto hinzufügen". Darauf klicken und bestätigen.
5. Nun den normalen **Steam-Client** (das Steam-Programm auf dem Rechner) starten: In der **Bibliothek** erscheint jetzt **„Spacewar"**.
6. Spacewar einmal kurz **starten**, um zu prüfen, dass es läuft (es öffnet sich ein einfaches Weltraum-Spiel). Fertig — das Team kann jetzt mit App-ID 480 testen.

### Variante B — über den Steam-Client mit einem Produktschlüssel

1. **Steam-Client** öffnen.
2. Unten links auf **„+ Spiel hinzufügen"** klicken → **„Produkt auf Steam aktivieren…"** → **„Weiter"**.
3. Den **Produktschlüssel** eingeben → **„Weiter"** → das Spiel erscheint in der Bibliothek.

**Wichtig zu Variante B:** Sie funktioniert nur mit einem **gültigen Produktschlüssel**. Für Spacewar gibt es keinen öffentlichen Schlüssel — der offizielle Weg ist **Variante A** über die Partnerseite. Variante B wird später nützlich, wenn das Team eigene **Test-Schlüssel für OpenMotion** aktivieren möchte.

> Danach genügt eine kurze Meldung an das Team: **„Spacewar ist freigeschaltet"** — die technische Einrichtung übernimmt das Dev-Team.

---

## Was mache ich mit den Ergebnissen?

Bitte einmal kurz bei **Hermes / dem Team melden** — eine Nachricht reicht:

- **App-ID:** (die Zahl aus Schritt 4)
- **SDK-Pfad:** `C:\Steamworks\sdk`
- **Konto aktiv:** ja (Steam-Benutzername: …)
- **Spacewar freigeschaltet:** ja / nein
- Optional: **Screenshot** der App-Übersichtsseite anhängen.

**Hinweis:** Die App-ID **nicht** öffentlich posten (Foren, Social Media) — sie ist wie ein Hausschlüssel, den nur wir kennen sollten.

---

## Kosten-Tabelle (was jetzt 0 €, was erst bei Release 100 $)

| Punkt | Jetzt (Entwicklungsphase) | Bei Veröffentlichung (Phase M8, Early Access) |
|---|---|---|
| Steam-Konto | 0 € | 0 € |
| Steamworks-Partnerkonto | 0 € | 0 € |
| Lizenzvereinbarungen (NDA + Vertriebsvereinbarung) | 0 € | 0 € |
| SDK-Download | 0 € | 0 € |
| App anlegen / App-ID | 0 € (Stopp-Schild in Schritt 4 beachten) | — |
| **Steam-Direct-Gebühr** | **nicht fällig** | **100 US-$ pro Produkt** (wird mit den ersten Verkaufserlösen bis 100.000 US-$ verrechnet; nach Zahlung gilt eine 30-tägige Wartezeit vor der Veröffentlichung) |
| Bank- & Steuerdaten | erst bei Release eintragen | erforderlich, damit Valve Auszahlungen leisten kann |
| Spacewar-Testapp (App-ID 480) | 0 € | 0 € |

**Fazit:** Für die Entwicklung und das lokale Testen entstehen **keine Kosten**. Die 100 US-$ und die Bank-/Steuerdaten werden erst in Phase M8 (Early-Access-Release) relevant.

---

## Häufige Stolpersteine

1. **Steam-Shop vs. Steamworks verwechseln:** Der Shop (`store.steampowered.com`) ist zum *Einkaufen* von Spielen. Unser Portal ist `partner.steamgames.com` — dort arbeitet man als Entwickler/Publisher. Nicht verwechseln.
2. **Steam Guard / 2FA:** Beim Anmelden kommt ein Sicherheitscode aufs Handy oder per E-Mail. Handy griffbereit halten — der Code ist nur kurz gültig (~30 Sekunden).
3. **Falsche E-Mail:** Valve schickt alle Bestätigungen an die Konto-E-Mail. Diese regelmäßig prüfen, **auch den Spam-Ordner**. Keine Wegwerf-E-Mail verwenden.
4. **Pseudonym statt Klarname:** Valve verlangt den rechtsgültigen Namen. Spitznamen oder Künstlernamen führen zu Rückfragen und Verzögerungen.
5. **Zahlung / Bank- & Steuerdaten angeboten:** Nicht ausfüllen, nicht bezahlen, abbrechen und beim Team melden (Stopp-Schilder in Schritt 1 und 4). Unsere Planung sieht diese Schritte erst bei Release vor.
6. **SDK „installieren" wollen:** Das SDK wird **nicht installiert** — es ist nur ein entpackter Ordner (`C:\Steamworks\sdk`). Einfach ZIP entpacken, fertig.
7. **Falsche App in der App-Auswahl:** Oben links im Steamworks-Portal immer prüfen, welche App ausgewählt ist: für unsere Arbeit „OpenMotion", für den Test „Spacewar" — nicht im falschen Menü herumklicken.
8. **Formular zwischendurch schließen:** Die Anmelde- und Unterschriftsformulare sollten in **einer Sitzung** fertig ausgefüllt werden (5–10 Minuten). Sonst muss man teilweise neu beginnen.
9. **SDK-Ordner löschen oder verschieben:** Das Team braucht später genau `C:\Steamworks\sdk`. Ordner nicht löschen, nicht umbenennen, nicht verschieben.
10. **Unsicher? Einfach stoppen:** Nichts geht kaputt. Ein halb ausgefülltes Formular kann jederzeit erneut geöffnet werden — bei Fragen einfach beim Team melden.

---

## Kleine Begriffskunde (Fachwörter einfach erklärt)

| Begriff | Bedeutung |
|---|---|
| **Steamworks** | Das Verwaltungsportal von Valve für Spieleentwickler (partner.steamgames.com). |
| **SDK** | Werkzeugkasten von Valve für die Anbindung an Steam — eine ZIP-Datei, die man nur entpackt. |
| **App / App-ID** | „Anwendung" = unser Spiel bei Steam; die App-ID ist die zugehörige Nummer. |
| **NDA** | Geheimhaltungsvereinbarung — Vertrag, nichts Vertrauliches weiterzugeben. |
| **Steam Direct** | Das heutige Anmelde- und Gebührenmodell von Valve (100 US-$ pro Produkt bei Veröffentlichung). |
| **2FA / Steam Guard** | Doppelte Sicherheitsabfrage beim Login (Code aufs Handy). |
| **ZIP-Datei** | Ein gepackter Ordner; per Rechtsklick → „Alle extrahieren" entpacken. |
| **Spacewar (480)** | Kostenlose Test-App von Valve, mit der Entwickler Steam-Funktionen testen können. |

---

## Verlinkungen
- [[10-Projects/OpenMotion/Recht-Gruendung|Recht & Gründung — Checkliste & Status]] — Kosten-Gate-Entscheidung (Steam-Direct-Gebühr erst bei M8)
- [[50-Sessions/2026-08-09_Steamworks-Partnerkonto|Session 2026-08-09 — Steamworks-Partnerkonto]] — Protokoll der Durchführung
