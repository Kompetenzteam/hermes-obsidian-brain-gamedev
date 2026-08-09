---
tags: [decision, architecture, performance, gpu]
date: 2026-08-09
project: OpenMotion
status: accepted
deciders: [Glieder]
---
# ADR-007: GPU-Strategie — GeForce RTX + AMD von Anfang an

## Kontext
Der Prototyp (M6.6) ruckelt extrem (User-Feedback). Als Gegenmaßnahme wird Performance zur Kern-Anforderung. Dazu kommt die verbindliche Vorgabe von Glieder: **Optimierung von Anfang an für GeForce RTX UND AMD-Grafikkarten** — kein NVIDIA-exklusiver Pfad, keine Vendor-Bindung.

## Entscheidung
**Beschluss (FREIGEGEBEN von Glieder, 2026-08-09):**

### Renderer & API
| Thema | Entscheidung | Begründung |
|---|---|---|
| Rendering-API | **Vulkan** (Godot 4 Forward+) | Vulkan ist der gemeinsame Standard von RTX und AMD — nativ von beiden Treibern unterstützt |
| Upscaling | **AMD FSR** als primärer Upscaler (Open-Source, GPU-agnostisch) | FSR läuft auf RTX UND AMD; DLSS ist NVIDIA-exklusiv |
| DLSS | Nur **optional** (falls NVIDIA-Benutzer es explizit wollen), nie Pflicht | Kein Vendor-Lock |
| Shader | GPU-agnostisch (keine vendor-spezifischen Extensions im Shader-Code) | Läuft identisch auf beiden |

### Performance-Basics (GPU)
- **GPU-Instancing (MultiMesh)** für alle wiederholten Geometrien (Gebäude, Bäume, spätere Bewohner-Crowds) — Hersteller-unabhängig
- **Mesh-LOD** (3 Stufen) für Gebäude/Fahrzeuge ab Phase 2
- **MSAA/TAA**: TAA als Standard (auf beiden Herstellern gut unterstützt); MSAA deaktiviert im Prototyp
- **Statische Geometrie** (Boden, Straßen) in einem Batched-Mesh, nicht als Einzel-Meshes
- **V-Sync/Frame-Target**: max_fps 60 (Prototyp), später konfigurierbar

### Verboten (Vendor-Lock)
- ❌ CUDA im Spiel-Pfad (nur optional in Offline-Tools, nie im Spiel)
- ❌ NVIDIA-only Extensions als Voraussetzung
- ❌ DLSS als Pflicht-Feature

## Alternativen
| Option | Pro | Contra |
|---|---|---|
| NVIDIA-first (DLSS/CUDA) | Beste NVIDIA-Performance | AMD-Nutzer benachteiligt, Vendor-Lock, gegen Vorgabe |
| AMD-only | FSR offen | RTX-Nutzer benachteiligt |
| **GPU-agnostisch (gewählt)** | Funktioniert auf beiden, FSR offen | Kein Hersteller-Exklusiv-Boost |

## Konsequenzen
- Performance-Welle (M6.7) priorisiert GPU-Instancing + Throttling + Threading
- GPU-Optimierungs-Welle (M6.8, geplant) validiert auf RTX + AMD: FSR-Integration, TAA, LOD
- Dev-Environment-Doku wird um GPU-Testkriterien ergänzt

## Verlinkungen
- [[Index|🏠 Brain Index]]
- [[60-Decisions/ADR-006_OpenMotion-Tech-Stack|ADR-006 — Tech-Stack]]
- [[10-Projects/OpenMotion/Gesamtkonzept|Gesamtkonzept]]
- [[10-Projects/OpenMotion/Projektplan|Projektplan]]
