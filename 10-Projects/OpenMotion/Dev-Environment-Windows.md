---
tags: [project, documentation, environment]
project: OpenMotion
date: 2026-08-09
status: active
---

# OpenMotion — Entwicklungsumgebung (Windows, lokal)

> Datum 2026-08-09 | Basis: [[60-Decisions/ADR-006_OpenMotion-Tech-Stack|ADR-006]] (Tech-Stack, freigegeben von Glieder)

Ziel: eine saubere, reproduzierbare Windows-Entwicklungsumgebung für Build + Test von OpenMotion (Godot 4 .NET, C#-Simulationskern, Steamworks.NET, GitHub Actions CI). Alle Verifikations-Befehle laufen im **git-bash** (MSYS, POSIX-Syntax) — nicht in PowerShell/cmd.

## 1. Übersicht

| Werkzeug | Zweck | Status installiert | Version |
|---|---|---|---|
| Git | Versionskontrolle, Repo `D:\Entwicklung\Projekte\OpenMotion` | ✅ installiert | 2.x (git-bash) |
| gh CLI | GitHub-Workflow (PRs, Issues, CI, Releases) | ✅ installiert, eingeloggt | 2.97.0 |
| Python 3.11 | Tooling/Asset-Pipeline (in venv) | ✅ installiert (Hermes-venv) | 3.11.15 |
| Pillow / numpy / resvg-py / vtracer | Bild-/SVG-Verarbeitung für Assets | ✅ installiert | Pillow 12.3, vtracer 0.6.15 |
| GIMP 3 | Bildbearbeitung (Texturen, UI-Skizzen) | ✅ installiert | 3.2.4 |
| .NET SDK 8.x | C#-Build & Tests (Sim-Kern, Godot .NET) | ⏳ wird installiert (2026-08-09) | 8.x |
| Godot 4 .NET (mono) | Engine (Editor + Headless für CI/Lockstep-Tests) | ⏳ wird installiert (2026-08-09) | 4.x |
| Steamworks.NET + GodotSteam | Steam-Integration (Auth, Lobby, SDR) | Phase 2 (via NuGet) | — |
| SQLite | Lokale Speicherstände, Save & Resume | Kein separates Tool nötig (eingebettet via .NET, z. B. `Microsoft.Data.Sqlite`) | — |
| Visual Studio Code | Editor (C#-, Godot-Tools-Plugin) | optional, empfohlen — **nicht verifiziert** | — |
| Obsidian | Brain/Doku (dieses Vault) | ✅ installiert | Desktop |

## 2. Pflicht-Installationen (für Build + Test)

### Git
- **Installationsweg:** `winget install Git.Git` ODER https://git-scm.com/download/win
- **Verifikation:** `git --version` → `git version 2.x.y.windows.1`
- **Konfiguration (IST: gesetzt):**
  ```
  git config --global user.name "Kompetenzteam"
  git config --global user.email "info@kompetenzteam.tv"
  ```

### gh CLI (GitHub CLI)
- **Installationsweg:** `winget install GitHub.cli`
- **Login (IST: erledigt):** `gh auth login` — Scopes benötigt: `gist, read:org, repo, workflow`; SSH-Key: `~/.ssh/id_ed25519`
- **Verifikation:** `gh --version` → `gh version 2.97.0 ...` und `gh auth status` → eingeloggt als `Kompetenzteam`

### .NET SDK 8.x
- **Status: wird installiert (2026-08-09)** — falls nach Abschluss noch offen: installieren.
- **Installationsweg:** `winget install Microsoft.DotNet.SDK.8`
- **Verifikation:** `dotnet --list-sdks` → erwartet `8.0.x`
- **Hinweis:** Godot 4.3+ setzt .NET 8 voraus (Kompatibilität, s. Fallen). Test-Framework: xUnit (`dotnet new xunit`, `dotnet test`).

### Godot 4 .NET (mono-Build!)
- **Status: wird installiert (2026-08-09)** — falls nach Abschluss noch offen: installieren.
- **Installationsweg (Option A, winget):** `winget search GodotEngine` → `winget install GodotEngine.GodotEngine.Mono`
- **Installationsweg (Option B, manuell):** `godot-4.x-stable_mono_win64.zip` von https://github.com/godotengine/godot/releases herunterladen, entpacken nach `D:\Entwicklung\tools\godot_mono`
- **PATH-Eintrag:** `D:\Entwicklung\tools\godot_mono` zu `%PATH%` hinzufügen (User-Umgebungsvariablen). Die ZIP enthält `godot.exe` (Editor) und `godot_console.exe` (Headless/Console — wird für CI/Headless-Checks genutzt).
- **Verifikation:** `godot_console.exe --version` → `4.x.stable.mono.official.<hash>`
- **⚠ Wichtig:** immer den **.NET/mono-Build** nehmen, nicht den Standard-Build — nur der mono-Build unterstützt C#.

### Python 3.11 (Tooling/Assets)
- **IST:** 3.11.15, läuft in einem venv (Hermes-venv) — für Projekt-Tooling eigenes venv anlegen (`python -m venv .venv`).
- **Installationsweg (falls neu):** `winget install Python.Python.3.11` ODER https://www.python.org/downloads/
- **Pakete:**
  ```
  pip install pillow numpy resvg-py vtracer
  ```
- **Verifikation:**
  ```
  python --version          → Python 3.11.15
  python -c "import PIL, numpy, resvg_py; print('ok')"
  ```
- **⚠ Falle:** `cairosvg`/`svglib` sind **nicht** nutzbar — sie benötigen eine native cairo-DLL, die auf Windows standardmäßig fehlt. **Stattdessen `resvg-py` verwenden** (siehe Abschnitt 5).

## 3. Optionale Werkzeuge

### GIMP 3 (Bildbearbeitung)
- **IST:** 3.2.4 installiert unter `C:\Program Files\GIMP 3`
- **Installationsweg (falls neu):** `winget install GIMP.GIMP`
- **Batch-Hinweis (Headless-Skripting):** `"C:\Program Files\GIMP 3\bin\gimp-console-3.2.exe" --batch-interpreter python-fu-eval -b "..."` — für automatisierte Bildverarbeitung in Scripts.

### Visual Studio Code (Editor, empfohlen)
- **Status: nicht verifiziert**
- **Installationsweg:** `winget install Microsoft.VisualStudioCode`
- **Empfohlene Plugins:** C# Dev Kit (`ms-dotnettools.csharp`), Godot Tools (`godot-tools.godot-tools`), GitLens.
- Alternativ reicht für reine Build/Test-Arbeit auch jeder andere Editor — die Toolchain ist CLI-basiert.

### Steamworks SDK / Steamworks.NET
- **Nur ab Phase 2 (Steam-Integration) nötig.** Steamworks.NET kommt via NuGet ins Projekt (MIT-Lizenz, passt zu ADR-006).
- Das Steamworks SDK selbst (kostenlos, Partnerkonto erforderlich) wird erst für den Steam-Build/Workshop benötigt — nicht für die lokale Entwicklung des Simulationskerns.

### Node.js
- **Status: nicht verifiziert.** Nur nötig, falls JS-basiertes Tooling (z. B. bestimmte Asset-Pipelines) gewünscht ist — aktuell **kein Pflichtteil** des Stacks.

## 4. Projekt-Build & Test (Kurzreferenz)

Repo: `D:\Entwicklung\Projekte\OpenMotion` (bereits mit `project.godot`; Lösungsdatei wird mit der Projektstruktur angelegt).

```
# C#-Lösung bauen (Name anpassen, sobald die Solution angelegt ist)
dotnet build src/OpenMotion.sln

# Tests (xUnit — u. a. Lockstep-Determinismus, Fix32-Mathematik)
dotnet test

# Godot-Headless-Check: Ressourcen importieren + Projekt laden, ohne Editor-UI
godot_console.exe --headless --path . --quit

# Git-Status / Workflow (alles in git-bash, POSIX-Syntax)
git status
gh pr create
```

**git-bash-Hinweise:**
- POSIX-Syntax verwenden (`ls`, `grep`, `find`, einzelne Quotes) — PowerShell-Builtins (`Get-ChildItem`, `$env:FOO`) funktionieren nicht.
- MSYS-Pfade wie `/c/Users/...` und `D:\...` werden beide akzeptiert.

## 5. Bekannte Fallen (Windows-spezifisch)

1. **cairosvg/svglib ohne cairo-DLL:** Beide Pakete benötigen eine native cairo-Bibliothek, die auf Windows nicht vorinstalliert ist → Import- oder Laufzeitfehler. **Lösung: `resvg-py` verwenden** (rust-basiert, keine nativen DLL-Abhängigkeiten, im venv verifiziert).
2. **LF/CRLF-Konflikte:** Git-Bash-Skripte (z. B. `sync-brain.sh`) brechen bei CRLF-Zeilenenden. **Lösung:** `.gitattributes` im Repo mit `*.sh text eol=lf` (bzw. `* text=auto` + explizite `eol=lf`-Regeln für Skripte) — sonst Fehler wie `bash: script.sh: /bin/bash^M`.
3. **MSYS-Pfadkonvertierung:** Bei manchen Windows-Tools werden Pfadargumente ungewollt übersetzt (z. B. `/c/...` statt `C:\...`). Bei Tools, die native Windows-Pfade erwarten: `MSYS_NO_PATHCONV=1` voranstellen oder doppelte Slashes (`//`) nutzen.
4. **.NET SDK ↔ Godot-Version kompatibel halten:** Godot 4.3+ benötigt .NET 8; abweichende SDK-Versionen führen zu Build-Fehlern in C#-Scripts. Engine-Version im Repo pinnen (ADR-006-Risiko) und das passende SDK global installieren.
5. **Godot-Headless braucht den mono-Build:** Der Standard-Build von Godot unterstützt kein C# — `--headless`-CI-Checks und Lockstep-Tests schlagen damit fehl. Immer die `_mono_`-ZIP verwenden und `godot_console.exe` aufrufen, nicht `godot.exe` (der Editor startet sonst die GUI).

## 6. Verlinkungen

- [[README|Projekt-README]]
- [[60-Decisions/ADR-006_OpenMotion-Tech-Stack|ADR-006 — Tech-Stack]]
- [[GDD|GDD]] — Game Design Document
- [[NDD|NDD]] — Networking Design Document
- [[Index|🏠 Brain Index]]
