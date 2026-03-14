# ═══════════════════════════════════════════════════════════════════════════════
# NEXUS-KALI APEX — Protocolo Maestro de Ejecución
# De documentos → código real, archivo por archivo
# ═══════════════════════════════════════════════════════════════════════════════
# Fecha: 2026-03-14
# Versión: 1.0
# Autoridad: Nx-prefix-spec v1.0 + NEXUS_PREFIX_REGISTRY_v1.0.csv
#            + SPEC_Nexus_Kali_v1.0 + WAVE_PLAN v1.0
# ═══════════════════════════════════════════════════════════════════════════════


# ┌─────────────────────────────────────────────────────────────────────────────┐
# │              DOCUMENTOS DE GOBIERNO (ya generados)                         │
# └─────────────────────────────────────────────────────────────────────────────┘
#
# Estos 4 documentos son los CONTRATOS que gobiernan toda la generación:
#
#   📋 NEXUS_PREFIX_REGISTRY_v1.0.csv   → 342 funciones con nombre definitivo
#   📋 Nx-prefix-spec-v1.0.md           → Reglas de naming + variables + guards
#   📋 NEXUS_WAVE_PLAN_v1.0.md          → Qué hacer en cada Wave
#   📋 SPEC_Nexus_Kali_v1.0.docx        → Contratos de datos + matemáticas
#
# Workflow: Antes de generar CUALQUIER archivo .sh, consultar estos 4 docs.
# ═══════════════════════════════════════════════════════════════════════════════


# ┌─────────────────────────────────────────────────────────────────────────────┐
# │            FASE 0: SETUP — Estructura de directorios                       │
# │            Duración: 1 sesión                                              │
# └─────────────────────────────────────────────────────────────────────────────┘

## 0.1 Crear el árbol de directorios definitivo
## ─────────────────────────────────────────────
## Este es el scaffold vacío sobre el cual se construye todo.

nexus-kali-apex/
├── launcher.sh                          # L0 — Entry point
├── bin/
│   └── nexusctl                         # W5 — CLI wrapper
├── lib/
│   ├── core/                            # L0-L1
│   │   ├── init.sh
│   │   ├── metadata.json
│   │   ├── base_dependencies.sh
│   │   ├── xdg_paths.sh
│   │   ├── bootstrap.sh
│   │   ├── error_handler.sh
│   │   ├── loader.sh
│   │   ├── core_utils.sh
│   │   ├── arch_detector.sh
│   │   └── arch_utils.sh
│   ├── logging/                         # L1
│   │   ├── init.sh
│   │   ├── metadata.json
│   │   ├── logger.sh
│   │   └── logrotation.sh
│   ├── config/                          # L1
│   │   ├── init.sh
│   │   ├── metadata.json
│   │   └── config_manager.sh
│   ├── security/                        # L2
│   │   ├── init.sh
│   │   ├── metadata.json
│   │   ├── security_core.sh
│   │   └── security_owasp.sh
│   ├── validation/                      # L2
│   │   ├── init.sh
│   │   ├── metadata.json
│   │   ├── validator.sh
│   │   └── input_validator.sh
│   ├── utils/                           # L2
│   │   ├── init.sh
│   │   ├── metadata.json
│   │   ├── system_checks.sh
│   │   ├── system_utils.sh
│   │   ├── validation_utils.sh
│   │   ├── deps_utils.sh
│   │   ├── lang_utils.sh
│   │   ├── file_operations.sh
│   │   ├── session_utils.sh
│   │   └── i18n.sh
│   ├── db/                              # L2
│   │   ├── init.sh
│   │   ├── metadata.json
│   │   └── cache_utils.sh
│   ├── network/                         # L3
│   │   ├── init.sh
│   │   ├── metadata.json
│   │   ├── network_utils.sh
│   │   └── download_manager.sh
│   ├── deps/                            # L3
│   │   ├── init.sh
│   │   ├── metadata.json
│   │   ├── dependency_manager.sh
│   │   └── package_manager.sh
│   ├── hooks/                           # L3
│   │   ├── init.sh
│   │   ├── metadata.json
│   │   └── hooks_manager.sh
│   ├── process/                         # L3
│   │   ├── init.sh
│   │   ├── metadata.json
│   │   ├── process_utils.sh
│   │   ├── automation_utils.sh
│   │   ├── build_utils.sh
│   │   ├── backup_utils.sh
│   │   └── job_queue.sh
│   ├── advanced/                        # L4
│   │   ├── init.sh
│   │   ├── metadata.json
│   │   ├── auto_optimization.sh
│   │   ├── auto_healing.sh
│   │   ├── self_healing_utils.sh
│   │   ├── metrics_system.sh
│   │   ├── metrics_kpi.sh
│   │   ├── predictive_engine.sh
│   │   ├── predictive_analyzer.sh
│   │   ├── telemetry.sh
│   │   ├── monitoring_utils.sh
│   │   ├── api_gateway.sh
│   │   ├── plugin_system.sh
│   │   └── plugin_management.sh
│   ├── enterprise/                      # L4
│   │   ├── init.sh
│   │   ├── metadata.json
│   │   └── cache_manager_ml_v2.sh
│   ├── ui/                              # L5
│   │   ├── init.sh
│   │   ├── metadata.json
│   │   ├── ui_utils.sh
│   │   └── ui_banner.sh
│   ├── spec/                            # PIPELINE (Waves 0B-6)
│   │   ├── nexus_paths.sh              # W0B
│   │   ├── nexus_atomic_ops.sh         # W0B
│   │   ├── nexus_json_extract.sh       # W0B
│   │   ├── detectors/                  # W1
│   │   │   ├── nexus_detector_runner.sh
│   │   │   ├── nexus_detector_syntax.sh
│   │   │   ├── nexus_detector_security.sh
│   │   │   ├── nexus_detector_convention.sh
│   │   │   ├── nexus_detector_portability.sh
│   │   │   └── nexus_detector_dependency.sh
│   │   ├── nexus_risk_engine.sh        # W2
│   │   ├── nexus_assert_schema.sh      # W2
│   │   ├── nexus_gate.sh              # W2
│   │   ├── nexus_trend_analyzer.sh     # W3
│   │   ├── nexus_vortex.sh            # W3
│   │   ├── nexus_phase_classifier.sh   # W3
│   │   ├── nexus_event_emitter.sh      # W3
│   │   ├── nexus_predictor.sh          # W4
│   │   ├── nexus_enforcer.sh           # W4
│   │   ├── nexus_gate_v2.sh           # W4
│   │   ├── nexus_registry.sh           # W5
│   │   ├── nexus_history.sh            # W5
│   │   └── nexus_observatory.sh        # W6
│   └── compat/                          # Shim de compatibilidad
│       └── nexus_compat_shim.sh
├── plugins/
│   ├── 01_install_custom.sh
│   ├── 02_install_official.sh
│   ├── 03_manage_instances.sh
│   ├── 04_advanced_config.sh
│   ├── 05_feedback.sh
│   ├── 06_playbooks.sh
│   ├── 07_kali_tools.sh
│   ├── 08_desktop_suite.sh
│   └── 09_security_hardening.sh
├── schemas/                             # JSON Schemas (Waves 1-5)
│   ├── detector_output.schema.json
│   ├── risk_engine_report.schema.json
│   ├── trend_report.schema.json
│   ├── vortex_state.schema.json
│   ├── prediction.schema.json
│   ├── security_state_report.schema.json
│   └── index.schema.json
├── scripts/
│   ├── migrate_prefixes_v2.sh          # W0A — Migration engine
│   └── diagnose_and_repair.sh
├── tests/
│   ├── test_prefix_compliance.bats     # W0A
│   ├── test_nexus_paths.bats           # W0B
│   ├── test_nexus_atomic_ops.bats      # W0B
│   ├── test_nexus_json_extract.bats    # W0B
│   ├── test_detectors.bats             # W1
│   ├── test_risk_engine.bats           # W2
│   ├── test_gate.bats                  # W2
│   ├── test_vortex_math.bats           # W3
│   ├── test_predictor.bats             # W4
│   ├── test_enforcer.bats              # W4
│   ├── test_gate_v2.bats              # W4
│   ├── test_registry.bats              # W5
│   ├── test_nexusctl.bats              # W5
│   ├── test_observatory.bats           # W6
│   ├── corpus/                         # Test scripts (W1)
│   │   ├── clean_01.sh
│   │   ├── clean_02.sh
│   │   ├── dirty_syntax_01.sh
│   │   ├── dirty_security_01.sh
│   │   └── dirty_convention_01.sh
│   └── fixtures/
│       └── vortex_scenarios.json       # W3
├── config/
│   └── checksums.sha256
├── locale/
│   ├── en/messages.sh
│   └── es/messages.sh
└── docs/
    ├── ARCHITECTURE.md
    ├── CHANGELOG.md
    ├── SECURITY.md
    └── adr/                            # Architecture Decision Records


# ═══════════════════════════════════════════════════════════════════════════════
# FASE 1: GENERACIÓN DE CÓDIGO — Protocolo por sesión de chat
# ═══════════════════════════════════════════════════════════════════════════════
#
# Cada sesión sigue este loop:
#
#   1. Tú dices: "Genera [archivo(s)]" o "Siguiente batch"
#   2. Yo consulto los 4 docs de gobierno
#   3. Genero el archivo COMPLETO (no stubs, no placeholders)
#   4. Al final de cada archivo: bash -n mental check + checklist
#   5. Tú copias a tu repo local
#
# REGLA: Máximo 2-3 archivos por petición para mantener calidad.
#        Archivos grandes (>300 LOC): 1 por petición.
#
# ═══════════════════════════════════════════════════════════════════════════════


# ┌─────────────────────────────────────────────────────────────────────────────┐
# │       ORDEN DE GENERACIÓN — Secuencia obligatoria de archivos              │
# └─────────────────────────────────────────────────────────────────────────────┘

# ╔═══════════════════════════════════════════════════════════════════╗
# ║ WAVE 0A — PREFIX MIGRATION + FRAMEWORK EXISTENTE                ║
# ║ Batches: 14  |  Archivos: 62  |  Sesiones estimadas: ~20       ║
# ╚═══════════════════════════════════════════════════════════════════╝

BATCH_01="Infraestructura de migración"
# ├── scripts/migrate_prefixes_v2.sh     (lee CSV, ejecuta renames)
# ├── lib/compat/nexus_compat_shim.sh    (aliases old→new)
# └── tests/test_prefix_compliance.bats  (gate: 0 violaciones)

BATCH_02="L0 Bootstrap — Cimientos"
# ├── lib/core/base_dependencies.sh      (constantes, UUID, timestamps, modes)
# └── lib/core/xdg_paths.sh             (XDG resolution, rootless enforcement)

BATCH_03="L0 Bootstrap — Entry point"
# ├── lib/core/bootstrap.sh              (init del sistema)
# └── launcher.sh                        (entry point principal)

BATCH_04="L1 Core — Error + Logging"
# ├── lib/core/error_handler.sh          (trap ERR/EXIT/SIGINT/SIGTERM)
# ├── lib/logging/logger.sh              (JSON estructurado, ANSI, flock)
# └── lib/logging/logrotation.sh         (compresión, archivado, cleanup)

BATCH_05="L1 Core — Loader + Config"
# ├── lib/core/loader.sh                 (POD loading, locks, checksums)
# └── lib/config/config_manager.sh       (capas, merge, persistencia)

BATCH_06="L1 Core — Arquitectura"
# ├── lib/core/core_utils.sh             (utilidades fundamentales)
# ├── lib/core/arch_detector.sh          (detección avanzada v3.0.0)
# └── lib/core/arch_utils.sh             (normalización, tiers, telemetría)

BATCH_07="L2 Security + Validation"
# ├── lib/security/security_core.sh      (OWASP audit, HMAC, encryption)
# ├── lib/security/security_owasp.sh     (A01-A10 patterns)
# ├── lib/validation/validator.sh        (framework de validación)
# └── lib/validation/input_validator.sh  (anti-injection, sanitización)

BATCH_08="L2 Utils — Parte 1"
# ├── lib/utils/system_checks.sh         (health, deps, resources)
# ├── lib/utils/system_utils.sh          (system info)
# └── lib/utils/deps_utils.sh            (package detection, resolution)

BATCH_09="L2 Utils — Parte 2"
# ├── lib/utils/lang_utils.sh            (string processing)
# ├── lib/utils/i18n.sh                  (internacionalización)
# ├── lib/utils/file_operations.sh       (atomic write, transactions)
# └── lib/utils/session_utils.sh         (persistencia de sesión)

BATCH_10="L2-L3 Cache + Network"
# ├── lib/db/cache_utils.sh              (TTL, atomic ops, LRU)
# ├── lib/network/network_utils.sh       (HTTP get/post, backends)
# └── lib/network/download_manager.sh    (retries, SHA256, resumible)

BATCH_11="L3 Services"
# ├── lib/deps/dependency_manager.sh     (resolución automática)
# ├── lib/deps/package_manager.sh        (5 gestores soportados)
# ├── lib/hooks/hooks_manager.sh         (20 puntos de extensión)
# └── lib/process/process_utils.sh       (process management)

BATCH_12="L3 Process + Build"
# ├── lib/process/automation_utils.sh    (task scheduling)
# ├── lib/process/build_utils.sh         (version management)
# ├── lib/process/backup_utils.sh        (retention, compression)
# └── lib/process/job_queue.sh           (job queue)

BATCH_13="L4 Enterprise — Core"
# ├── lib/advanced/auto_optimization.sh  (circuit breaker, rate limiter)
# ├── lib/advanced/auto_healing.sh       (Z-score anomaly detection)
# ├── lib/advanced/self_healing_utils.sh (repair + rollback)
# ├── lib/advanced/metrics_system.sh     (counters, gauges, histograms)
# └── lib/advanced/metrics_kpi.sh        (KPI scoring 0-100)

BATCH_14="L4 Enterprise — Advanced"
# ├── lib/advanced/predictive_engine.sh  (anomaly detection, exhaustion)
# ├── lib/advanced/predictive_analyzer.sh (ML pattern matching)
# ├── lib/advanced/telemetry.sh          (OpenTelemetry spans, export)
# ├── lib/advanced/monitoring_utils.sh   (system health monitoring)
# ├── lib/advanced/api_gateway.sh        (IPC, Unix sockets)
# ├── lib/advanced/plugin_system.sh      (hot-reload, sandbox)
# ├── lib/advanced/plugin_management.sh  (registry, validation)
# └── lib/enterprise/cache_manager_ml_v2.sh (ML prefetching)

BATCH_15="L5 UI + Init files"
# ├── lib/ui/ui_utils.sh                 (dialog/whiptail/zenity/ANSI)
# ├── lib/ui/ui_banner.sh               (ASCII art, sysinfo, help)
# ├── lib/*/init.sh                      (12 init files para módulos)
# └── lib/*/metadata.json                (12 metadata files)

BATCH_16="Plugins"
# ├── plugins/01_install_custom.sh       (instalación custom)
# ├── plugins/02_install_official.sh     (instalación oficial)
# ├── plugins/03_manage_instances.sh     (gestión de instancias)
# ├── plugins/04_advanced_config.sh      (configuración avanzada)
# ├── plugins/05_feedback.sh             (feedback)
# ├── plugins/06_playbooks.sh            (playbooks)
# ├── plugins/07_kali_tools.sh           (herramientas Kali)
# ├── plugins/08_desktop_suite.sh        (suite de escritorio)
# └── plugins/09_security_hardening.sh   (hardening)


# ╔═══════════════════════════════════════════════════════════════════╗
# ║ WAVE 0B — FOUNDATION LIBRARIES (Pipeline)                       ║
# ║ Batches: 1  |  Archivos: 6  |  Sesiones estimadas: ~2          ║
# ╚═══════════════════════════════════════════════════════════════════╝

BATCH_17="Foundation Pipeline"
# ├── lib/spec/nexus_paths.sh            (XDG para pipeline)
# ├── lib/spec/nexus_atomic_ops.sh       (write-then-move)
# ├── lib/spec/nexus_json_extract.sh     (JSON sin jq)
# ├── tests/test_nexus_paths.bats
# ├── tests/test_nexus_atomic_ops.bats
# └── tests/test_nexus_json_extract.bats


# ╔═══════════════════════════════════════════════════════════════════╗
# ║ WAVE 1 — DETECTORS                                              ║
# ║ Batches: 2  |  Archivos: 8  |  Sesiones estimadas: ~3          ║
# ╚═══════════════════════════════════════════════════════════════════╝

BATCH_18="Detectors — Parte 1"
# ├── schemas/detector_output.schema.json
# ├── lib/spec/detectors/nexus_detector_runner.sh
# ├── lib/spec/detectors/nexus_detector_syntax.sh
# └── lib/spec/detectors/nexus_detector_security.sh

BATCH_19="Detectors — Parte 2"
# ├── lib/spec/detectors/nexus_detector_convention.sh  (NX-CONV-001..008)
# ├── lib/spec/detectors/nexus_detector_portability.sh
# ├── lib/spec/detectors/nexus_detector_dependency.sh
# ├── tests/test_detectors.bats
# └── tests/corpus/*.sh                               (5+ test scripts)


# ╔═══════════════════════════════════════════════════════════════════╗
# ║ WAVE 2 — RISK ENGINE                                            ║
# ║ Batches: 1  |  Archivos: 5  |  Sesiones estimadas: ~2          ║
# ╚═══════════════════════════════════════════════════════════════════╝

BATCH_20="Risk Engine + Gate v1"
# ├── schemas/risk_engine_report.schema.json
# ├── lib/spec/nexus_risk_engine.sh
# ├── lib/spec/nexus_assert_schema.sh
# ├── lib/spec/nexus_gate.sh
# └── tests/test_risk_engine.bats + tests/test_gate.bats


# ╔═══════════════════════════════════════════════════════════════════╗
# ║ WAVE 3 — VORTEX ENGINE                                          ║
# ║ Batches: 2  |  Archivos: 8  |  Sesiones estimadas: ~3          ║
# ╚═══════════════════════════════════════════════════════════════════╝

BATCH_21="Vortex Core"
# ├── schemas/trend_report.schema.json
# ├── schemas/vortex_state.schema.json
# ├── lib/spec/nexus_trend_analyzer.sh
# └── lib/spec/nexus_vortex.sh

BATCH_22="Vortex Phase + Events"
# ├── lib/spec/nexus_phase_classifier.sh
# ├── lib/spec/nexus_event_emitter.sh
# ├── tests/test_vortex_math.bats
# └── tests/fixtures/vortex_scenarios.json


# ╔═══════════════════════════════════════════════════════════════════╗
# ║ WAVE 4 — PREDICTOR + ENFORCER                                   ║
# ║ Batches: 1  |  Archivos: 6  |  Sesiones estimadas: ~2          ║
# ╚═══════════════════════════════════════════════════════════════════╝

BATCH_23="Predictor + Enforcer + Gate v2"
# ├── schemas/prediction.schema.json
# ├── schemas/security_state_report.schema.json
# ├── lib/spec/nexus_predictor.sh
# ├── lib/spec/nexus_enforcer.sh
# ├── lib/spec/nexus_gate_v2.sh
# └── tests/test_predictor.bats + test_enforcer.bats + test_gate_v2.bats


# ╔═══════════════════════════════════════════════════════════════════╗
# ║ WAVE 5 — REGISTRY + CLI                                         ║
# ║ Batches: 1  |  Archivos: 5  |  Sesiones estimadas: ~2          ║
# ╚═══════════════════════════════════════════════════════════════════╝

BATCH_24="Registry + CLI"
# ├── schemas/index.schema.json
# ├── lib/spec/nexus_registry.sh
# ├── lib/spec/nexus_history.sh
# ├── bin/nexusctl
# └── tests/test_registry.bats + test_nexusctl.bats


# ╔═══════════════════════════════════════════════════════════════════╗
# ║ WAVE 6 — OBSERVATORY                                            ║
# ║ Batches: 1  |  Archivos: 2  |  Sesiones estimadas: ~1          ║
# ╚═══════════════════════════════════════════════════════════════════╝

BATCH_25="Observatory Dashboard"
# ├── lib/spec/nexus_observatory.sh
# └── tests/test_observatory.bats


# ═══════════════════════════════════════════════════════════════════════════════
# CHECKLIST POR ARCHIVO (validar antes de entregar cada archivo)
# ═══════════════════════════════════════════════════════════════════════════════
#
# [ ] #!/usr/bin/env bash + set -Eeuo pipefail
# [ ] Guard: [[ -n "${_NEXUS_<MOD>_LOADED:-}" ]] && return 0
# [ ] Header: Module name, version, description, dependencies, layer
# [ ] Funciones public: nexus_<mod>_<action>() per REGISTRY
# [ ] Funciones private: __nexus_<mod>_<helper>() per REGISTRY
# [ ] Variables: NEXUS_* / _NEXUS_* per Nx-prefix-spec
# [ ] Validación de parámetros en TODA función pública
# [ ] Manejo de errores con mensajes descriptivos
# [ ] Return codes consistentes (0=ok, 1=error, 2=invalid input)
# [ ] NO export -f en funciones __nexus_*
# [ ] Comentarios en español, código en inglés
# [ ] Selftest function: nexus_<mod>_selftest()
# [ ] Sin rutas hardcodeadas (/var, /etc, /opt)
# [ ] Compatible Termux (sin sudo, sin root)
#
# ═══════════════════════════════════════════════════════════════════════════════


# ═══════════════════════════════════════════════════════════════════════════════
# ESTIMACIÓN TOTAL
# ═══════════════════════════════════════════════════════════════════════════════
#
#   Batches totales:    25
#   Archivos totales:   ~120 (.sh + .json + .bats + .md)
#   LOC estimado:       ~13,500
#   Sesiones estimadas: ~30-35 sesiones de chat
#
#   Ritmo recomendado:  2-3 batches por día = proyecto completo en ~12 días
#   Ritmo intensivo:    4-5 batches por día = proyecto completo en ~6 días
#
# ═══════════════════════════════════════════════════════════════════════════════
