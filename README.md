<p align="center">
  <img src="https://img.shields.io/badge/Version-1.0.0--rc1-blue?style=for-the-badge&logo=bash" alt="Versión">
  <img src="https://img.shields.io/badge/Licencia-MIT-green?style=for-the-badge" alt="Licencia">
  <img src="https://img.shields.io/badge/Plataforma-Kali%20NetHunter-orange?style=for-the-badge" alt="Plataforma">
  <img src="https://img.shields.io/badge/Pipeline-SPEC%20v1.0-purple?style=for-the-badge" alt="Pipeline">
</p>

---

# NEXUS-KALI APEX

**Secure Pipeline Evaluation Core** — Framework enterprise-grade en Bash para evaluación dinámica de riesgo en proyectos de scripting de seguridad.

## Qué es

NEXUS-KALI APEX implementa un pipeline de análisis de seguridad que transforma scripts Bash en reportes de riesgo dinámico. A diferencia de herramientas que solo responden "¿cuál es el riesgo ahora?", NEXUS-KALI APEX responde:

- ¿El riesgo está creciendo o disminuyendo?
- ¿A qué velocidad?
- ¿El sistema ha cruzado un umbral estructural?
- ¿Estamos dirigiéndonos hacia una cascada?

## Pipeline

```
Script Input
    ↓
┌─────────────────────────────────────┐
│  DETECTORS (5 paralelos)            │
│  syntax · security · convention     │
│  portability · dependency           │
└──────────────┬──────────────────────┘
               ↓
         RISK ENGINE        → risk_engine_report.json
               ↓
        TREND ANALYZER      → trend_report.json
               ↓
        VORTEX ENGINE       → vortex_state.json
               ↓
          PREDICTOR         → prediction.json
               ↓
       INTEGRATION GATE     → pass/fail
               ↓
          ENFORCER          → security_state_report.json
               ↓
          REGISTRY          → spec://org/repo/commit
```

## Principios de diseño

- **Contratos primero, código después.** Toda comunicación entre componentes se gobierna por schemas JSON versionados.
- **Dinámico sobre estático.** Cada medición incluye su tasa de cambio. Un score de riesgo sin velocidad es incompleto.
- **Composable por defecto.** Cada componente es independientemente testable y reemplazable.
- **Rootless everywhere.** Funcionalidad completa en Termux/Android sin privilegios elevados. Cumplimiento XDG obligatorio.
- **Incertidumbre honesta.** Las predicciones llevan intervalos de confianza explícitos.
- **Fallo ruidoso, fallo rápido.** Los gates de integración bloquean el pipeline explícitamente.

## Estructura del repositorio

```
nexus-kali-apex/
├── bin/                    # Ejecutables (nexusctl)
├── config/                 # Configuración del sistema
├── docs/
│   ├── governance/         # ← Fuente de verdad (5 docs + README)
│   ├── adr/                # Architecture Decision Records
│   ├── api/                # Documentación de API
│   └── architecture/       # Diagramas y diseño
├── lib/
│   ├── core/               # Bootstrap, XDG, flags, error handling
│   ├── spec/
│   │   └── detectors/      # 5 detectores del pipeline
│   ├── logging/            # Logger JSON estructurado
│   ├── security/           # Validaciones OWASP-Bash
│   ├── validation/         # Validación de schemas y entradas
│   ├── config/             # Gestión de configuración
│   ├── utils/              # Utilidades generales
│   ├── db/                 # Persistencia y Registry
│   ├── network/            # Operaciones de red
│   ├── deps/               # Gestión de dependencias
│   ├── hooks/              # Hooks de pipeline
│   ├── process/            # Gestión de procesos
│   ├── advanced/           # Vortex, Predictor, Enforcer
│   ├── enterprise/         # Funciones enterprise
│   ├── ui/                 # Interfaz de terminal
│   └── compat/             # Compatibilidad legacy
├── locale/                 # i18n (en, es)
├── plugins/                # Sistema de plugins
├── schemas/                # JSON schemas versionados
├── scripts/                # Scripts auxiliares
└── tests/
    ├── unit/               # Tests unitarios
    ├── integration/        # Tests de integración
    ├── corpus/             # Scripts de prueba
    └── fixtures/           # Datos de prueba
```

## CLI

```bash
nexusctl init --org ORG --repo REPO       # Inicializar registry
nexusctl scan --script PATH --window N    # Pipeline completo
nexusctl gate --strict --threshold SCORE  # Integration gate (CI/CD)
nexusctl vortex --script PATH --window N  # Análisis Vortex
nexusctl publish --commit SHA             # Publicar a registry
nexusctl history --limit N                # Historial de reportes
nexusctl diff --from SHA --to SHA         # Comparar estados
nexusctl doctor                           # Validar entorno
```

## Modelo de riesgo dinámico (Vortex)

El motor Vortex modela el software como un sistema dinámico en un espacio de fases de riesgo:

| Dimensión | Significado |
|-----------|-------------|
| `risk_level` | Score compuesto de riesgo actual (0.0–1.0) |
| `velocity` | Tasa de cambio del riesgo por commit |
| `acceleration` | Tasa de cambio de la velocidad (segunda derivada) |
| `entropy` | Distribución de hallazgos entre categorías (Shannon normalizado) |
| `volatility` | Desviación estándar del riesgo en la ventana |
| `phase` | `stable` · `oscillating` · `unstable` · `critical` |
| `attractor_zone` | `safe` · `watch` · `unstable` · `critical` |

## Governance

Toda la documentación autoritativa vive en `docs/governance/`. Orden de precedencia:

1. `SPEC_Nexus_Kali_v1.0.md` — Arquitectura de referencia
2. `NEXUS_PREFIX_REGISTRY_v1.0.csv` — 342 funciones con nombres definitivos
3. `Nx-prefix-spec-v1.0.md` — Convenciones de código
4. `NEXUS_WAVE_PLAN_v1.0.md` — Plan por waves
5. `NEXUS_EXECUTION_PROTOCOL_v1.0.md` — Protocolo de ejecución por batches

Cualquier desviación del SPEC debe documentarse como ADR en `docs/adr/`.

## Roadmap

| Wave | Entregable | Estado |
|------|-----------|--------|
| Wave 0 | Foundation (XDG, atomic ops, JSON, shell flags) | 🔨 En progreso |
| Wave 1 | Detector Layer (5 detectores) | ⏳ Pendiente |
| Wave 2 | Risk Engine + Integration Gate v1 | ⏳ Pendiente |
| Wave 3 | Vortex Engine (modelo dinámico completo) | ⏳ Pendiente |
| Wave 4 | Predictor + Enforcer | ⏳ Pendiente |
| Wave 5 | Registry + CLI (`nexusctl`) | ⏳ Pendiente |
| Wave 6 | Observatory Dashboard | ⏳ Pendiente |

## Entornos soportados

| Plataforma | Estado |
|-----------|--------|
| Linux (Ubuntu, Debian, CentOS, Alpine, Arch, Fedora) | ✅ |
| macOS (Intel + Apple Silicon) | ✅ |
| Windows (WSL 1/2) | ✅ |
| Termux (Android, sin root) | ✅ |
| Docker / Kubernetes | ✅ |
| CI/CD (GitHub Actions, GitLab CI, Jenkins) | ✅ |

## Requisitos

- Bash ≥ 4.0 (4.3+ recomendado)
- `curl` o `wget` (opcional, para operaciones de red)
- Sin dependencias externas obligatorias

## Licencia

MIT License — Copyright © 2026 NEXUS-KALI APEX

---

<p align="center">
  <strong>NEXUS-KALI APEX v1.0.0-rc1</strong><br>
  Secure Pipeline Evaluation Core<br>
  100% Rootless · XDG-Compliant · Contract-First
</p>
