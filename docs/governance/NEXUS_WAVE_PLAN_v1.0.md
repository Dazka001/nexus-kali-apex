# ═══════════════════════════════════════════════════════════════════════════════
# NEXUS-KALI APEX — Plan de Ejecución Wave-by-Wave v1.0
# ═══════════════════════════════════════════════════════════════════════════════
# Autoridad de naming: Nx-prefix-spec v1.0 + NEXUS_PREFIX_REGISTRY_v1.0.csv
# Autoridad técnica:   SPEC_Nexus_Kali_v1.0 (Pipeline)
# Fusión:              Camino A (estabilizar framework) + Camino B (pipeline SPEC)
# Principio:           Cada Wave produce un artefacto testeable e independiente.
#                      Wave N NO depende de Wave N+1.
# ═══════════════════════════════════════════════════════════════════════════════


# ┌─────────────────────────────────────────────────────────────────────────────┐
# │                    WAVE 0 — FOUNDATION + PREFIX MIGRATION                  │
# │                    ══════════════════════════════════════                   │
# │  Meta: Cimentar el proyecto entero. Migrar prefijos. Sin esto, nada más   │
# │  funciona. Es el Wave más pesado pero también el más crítico.              │
# └─────────────────────────────────────────────────────────────────────────────┘

## Wave 0A — Prefix Migration Engine (Framework existente)
## ────────────────────────────────────────────────────────

Objetivo: Renombrar las 240 funciones existentes + 57 variables al esquema
           nexus_<mod>_<action> / __nexus_<mod>_<helper> de Nx-prefix-spec v1.0.

Prerequisitos: Ninguno (es el punto de partida).

### Archivos a CREAR:
```
scripts/migrate_prefixes_v2.sh     — Migration engine (basado en REGISTRY CSV)
lib/compat/nexus_compat_shim.sh    — Aliases old→new con deprecation warnings
tests/test_prefix_compliance.bats  — Valida que 0 funciones usen naming viejo
```


### Archivos a MODIFICAR — LISTA COMPLETA VERIFICADA (59 archivos):

**L0 Bootstrap (4):**
```
base_dependencies.sh    xdg_paths.sh    launcher.sh    bootstrap.sh
```

**L1 Core (8):**
```
loader.sh               error_handler.sh     logger.sh
logrotation.sh          core_utils.sh        config_manager.sh
arch_detector.sh        arch_utils.sh
```

**L2 Utils (14):**
```
system_checks.sh        system_utils.sh      validator.sh
input_validator.sh      security_core.sh     security_owasp.sh
cache_utils.sh          file_operations.sh   deps_utils.sh
lang_utils.sh           validation_utils.sh  session_utils.sh
network_utils.sh        i18n.sh
```

**L3 Services (11):**
```
download_manager.sh     backup_utils.sh      automation_utils.sh
build_utils.sh          process_utils.sh     dependency_manager.sh
package_manager.sh      job_queue.sh         hooks_manager.sh
plugin_system.sh        plugin_management.sh
```

**L4 Enterprise (11):**
```
auto_optimization.sh    auto_healing.sh      self_healing_utils.sh
metrics_system.sh       metrics_kpi.sh       predictive_engine.sh
predictive_analyzer.sh  telemetry.sh         monitoring_utils.sh
api_gateway.sh          cache_manager_ml_v2.sh
```

**L5 UI (2):**
```
ui_utils.sh             ui_banner.sh
```

**Plugins (9):**
```
01_install_custom.sh    02_install_official.sh   03_manage_instances.sh
04_advanced_config.sh   05_feedback.sh           06_playbooks.sh
07_kali_tools.sh        08_desktop_suite.sh      09_security_hardening.sh
```

**TOTAL: 59 archivos**


### Protocolo de ejecución:
1. `migrate_prefixes_v2.sh` lee NEXUS_PREFIX_REGISTRY_v1.0.csv
2. Para cada archivo: backup → sed rename → actualizar guards → eliminar export -f de __nexus_*
3. Genera `nexus_compat_shim.sh` automáticamente
4. Ejecuta `test_prefix_compliance.bats` como gate

### Criterios de aceptación:
- [ ] `grep -rn 'function [a-z]' lib/ | grep -v 'nexus_\|__nexus_'` → 0 resultados
- [ ] `grep -rn 'export -f __nexus_' lib/` → 0 resultados
- [ ] `grep -rn 'NK_' lib/ | grep -v '#'` → 0 resultados (excepto comentarios)
- [ ] `bash -n` pasa en todos los archivos
- [ ] Cada módulo tiene guard `_NEXUS_<MOD>_LOADED`
- [ ] `test_prefix_compliance.bats` → ALL PASS

### Funciones afectadas: 240 renames en 59 archivos
### LOC estimado nuevo: ~400 (scripts) | ~8,000+ LOC modificados


## Wave 0B — Foundation Libraries (Código nuevo del SPEC)
## ──────────────────────────────────────────────────────

Objetivo: Crear las 3 bibliotecas fundacionales que el Pipeline necesita
           y que el framework existente también consume (beneficio dual).

Prerequisitos: Wave 0A (naming correcto para depender de nexus_* APIs).

### Archivos a CREAR:
```
lib/spec/nexus_paths.sh           — XDG path resolution para pipeline
lib/spec/nexus_atomic_ops.sh      — Operaciones atómicas write-then-move
lib/spec/nexus_json_extract.sh    — JSON parsing sin dependencia de jq
tests/test_nexus_paths.bats
tests/test_nexus_atomic_ops.bats
tests/test_nexus_json_extract.bats
```

### Funciones (del PREFIX_REGISTRY):
```
PUBLIC:
  nexus_paths_resolve        nexus_paths_get
  nexus_atomic_write         nexus_atomic_rename
  nexus_json_get             nexus_json_set            nexus_json_validate

PRIVATE:
  __nexus_paths_detect_env
  __nexus_atomic_mktemp      __nexus_atomic_fsync
  __nexus_json_parse_path    __nexus_json_tokenize     __nexus_json_type_check
```

### Archivos existentes a MODIFICAR:
```
xdg_paths.sh     → delegar a nexus_paths.sh (evitar duplicación)
file_operations.sh → delegar atomic ops a nexus_atomic_ops.sh
```

### Wave 0B también incluye:
- Shell flags enforcer: `set -Eeuo pipefail` en TODOS los lib/ files (H-06)
- Schema path migration: estandarizar todas las refs de schema (H-10)

### Criterios de aceptación:
- [ ] `nexus_json_get` parsea todos los schemas del SPEC sin jq
- [ ] `nexus_atomic_write` sobrevive kill -9 mid-write (test con trap)
- [ ] `nexus_paths_resolve` retorna paths correctos en Termux + Linux
- [ ] `bash -n` + `shellcheck --severity=error` en los 3 archivos
- [ ] Tests: 100% pass

### Funciones nuevas: 13
### LOC estimado: ~800


# ┌─────────────────────────────────────────────────────────────────────────────┐
# │                       WAVE 1 — DETECTOR LAYER                              │
# │                       ═══════════════════════                               │
# │  Meta: 5 detectores independientes + 1 detector de convenciones que        │
# │  enforce el Nx-prefix-spec. Cada detector produce detector_output.json.    │
# └─────────────────────────────────────────────────────────────────────────────┘

Objetivo: 6 detectores ejecutables independientemente, schema-compliant.

Prerequisitos: Wave 0B (nexus_json_extract.sh para emitir JSON).

### Archivos a CREAR:
```
lib/spec/detectors/nexus_detector_runner.sh      — Orchestrator
lib/spec/detectors/nexus_detector_syntax.sh      — bash -n + shellcheck
lib/spec/detectors/nexus_detector_security.sh    — OWASP-Bash, CWE mapping
lib/spec/detectors/nexus_detector_convention.sh  — Nx-prefix-spec enforcement
lib/spec/detectors/nexus_detector_portability.sh — POSIX/Termux compat
lib/spec/detectors/nexus_detector_dependency.sh  — Missing commands/versions
schemas/detector_output.schema.json              — Schema v1.0 (SPEC §3.1)
tests/test_detectors.bats
tests/corpus/                                    — Test scripts (clean + dirty)
```

### Funciones (del PREFIX_REGISTRY):
```
PUBLIC (7):
  nexus_detector_run_all       nexus_detector_run_single
  nexus_detector_syntax_scan   nexus_detector_security_scan
  nexus_detector_convention_scan
  nexus_detector_portability_scan
  nexus_detector_dependency_scan

PRIVATE (13):
  __nexus_detector_emit_finding   __nexus_detector_map_cwe
  __nexus_detector_merge_outputs
  __nexus_detector_syntax_init    __nexus_detector_syntax_parse
  __nexus_detector_security_init  __nexus_detector_security_parse
  __nexus_detector_convention_init  __nexus_detector_convention_parse
  __nexus_detector_portability_init __nexus_detector_portability_parse
  __nexus_detector_dependency_init  __nexus_detector_dependency_parse
```

### Killer feature de este Wave:
`nexus_detector_convention.sh` implementa las 8 reglas NX-CONV-001..008
del Nx-prefix-spec. A partir de este Wave, el proyecto SE AUTO-VALIDA.

### Criterios de aceptación:
- [ ] Cada detector produce JSON válido contra detector_output.schema.json
- [ ] `nexus_detector_convention_scan` detecta violaciones de __nexus_* cross-module
- [ ] Detectores ejecutables en paralelo sin race conditions
- [ ] Todos pasan `bash -n` + `shellcheck --severity=error`
- [ ] Test corpus: ≥5 scripts limpios + ≥5 con findings conocidos

### Funciones nuevas: 20
### LOC estimado: ~1,500 (6 detectores × ~250 LOC)


# ┌─────────────────────────────────────────────────────────────────────────────┐
# │                        WAVE 2 — RISK ENGINE                                │
# │                        ════════════════════                                 │
# │  Meta: Scoring determinista + schema validation + Integration Gate v1.     │
# └─────────────────────────────────────────────────────────────────────────────┘

Objetivo: R(t) reproducible. Mismo input → mismo score en 100 ejecuciones.

Prerequisitos: Wave 1 (detector_output.json como input).

### Archivos a CREAR:
```
lib/spec/nexus_risk_engine.sh      — Weighted aggregation (SPEC §4)
lib/spec/nexus_assert_schema.sh    — Schema validator universal
lib/spec/nexus_gate.sh             — Integration Gate v1 (per-worker)
schemas/risk_engine_report.schema.json
tests/test_risk_engine.bats        — Determinism: 100 runs, same output
tests/test_gate.bats
```

### Funciones (del PREFIX_REGISTRY):
```
PUBLIC (7):
  nexus_risk_compute       nexus_risk_get_density
  nexus_risk_get_distribution
  nexus_schema_validate    nexus_schema_version_check
  nexus_gate_evaluate      nexus_gate_status

PRIVATE (7):
  __nexus_risk_apply_weights       __nexus_risk_density_correction
  __nexus_risk_entropy_correction
  __nexus_schema_load_def          __nexus_schema_check_field
  __nexus_gate_check_regression    __nexus_gate_validate_bashn
```

### Matemáticas implementadas (SPEC §4):
```
R(t) = [Σ w_sev × count_sev] / max_possible × D(t)
D(t) = k_d × (findings_t / LoC_t)     # k_d = 0.15
density(t) = (findings_t × 100) / LoC_t
```

### Criterios de aceptación:
- [ ] 100 ejecuciones con mismo input → mismo R(t) (test determinism)
- [ ] density > 8.0 → emite HIGH_DENSITY event
- [ ] Gate bloquea si schema inválido (hard stop, no silent fallthrough)
- [ ] `nexus_assert_schema.sh` valida los 5 schemas del SPEC

### Funciones nuevas: 14
### LOC estimado: ~900


# ┌─────────────────────────────────────────────────────────────────────────────┐
# │                      WAVE 3 — VORTEX ENGINE                                │
# │                      ══════════════════════                                 │
# │  Meta: El corazón matemático. v(t), a(t), H_n(t), σ(t), phase, attractor. │
# └─────────────────────────────────────────────────────────────────────────────┘

Objetivo: Producir VortexState completo — el artefacto más denso del pipeline.

Prerequisitos: Wave 2 (risk_engine_report.json como input).

### Archivos a CREAR:
```
lib/spec/nexus_vortex.sh               — Core: v, a, H, σ (SPEC §5.2-5.5)
lib/spec/nexus_phase_classifier.sh     — Phase + attractor (SPEC §5.6-5.7)
lib/spec/nexus_event_emitter.sh        — 13 events catalog (SPEC §5.8)
lib/spec/nexus_trend_analyzer.sh       — Historical window analysis (SPEC §3.3)
schemas/vortex_state.schema.json
schemas/trend_report.schema.json
tests/test_vortex_math.bats           — Known-input mathematical tests
tests/fixtures/vortex_scenarios.json   — Pre-computed expected outputs
```

### Funciones (del PREFIX_REGISTRY):
```
PUBLIC (6):
  nexus_vortex_compute       nexus_vortex_get_state
  nexus_phase_classify       nexus_phase_get_attractor
  nexus_event_check_all      nexus_event_emit

PRIVATE (9):
  __nexus_vortex_calc_velocity       — v(t,n) = [R(t) - R(t-n)] / n
  __nexus_vortex_calc_acceleration   — a(t) = v(t) - v(t-1)
  __nexus_vortex_calc_entropy        — H_n(t) = H(t) / log(k)
  __nexus_vortex_calc_volatility     — σ(t,n) = stddev(window)
  __nexus_vortex_calc_window_mean    — R̄(t,n)
  __nexus_phase_calc_confidence
  __nexus_phase_detect_transition
  __nexus_event_build_payload
  __nexus_event_check_runaway
```

### Wire al framework existente (Fusión A+B):
```
# predictive_engine.sh (L4) SE CONECTA a Vortex:
# nexus_predict_run() ahora puede consumir VortexState
# en lugar de hacer su propio cálculo de anomalías redundante.
#
# metrics_system.sh (L4) ALIMENTA a Vortex:
# nexus_metrics_counter_inc("nexus_vortex_computations_total")
# nexus_metrics_histogram_observe("nexus_vortex_compute_ms", elapsed)
```

### Criterios de aceptación:
- [ ] Scenarios con inputs conocidos → outputs verificados a mano
- [ ] Phase transitions detectadas correctamente en todos los escenarios
- [ ] 13 eventos emitidos correctamente según umbrales del SPEC §5.8
- [ ] Aritmética con `bc -l` o fallback entero — funcional en Termux
- [ ] VortexState JSON válido contra schema

### Funciones nuevas: 15
### LOC estimado: ~1,200 (Vortex ~500 + Phase ~350 + Events ~350)


# ┌─────────────────────────────────────────────────────────────────────────────┐
# │                    WAVE 4 — PREDICTOR + ENFORCER                           │
# │                    ═════════════════════════════                            │
# │  Meta: Predicción probabilística + gobernanza GREEN→BLACK.                 │
# └─────────────────────────────────────────────────────────────────────────────┘

Objetivo: Cerrar el pipeline — de VortexState a decisión de governance.

Prerequisitos: Wave 3 (vortex_state.json como input).

### Archivos a CREAR:
```
lib/spec/nexus_predictor.sh        — Trajectory projection (SPEC §3.4)
lib/spec/nexus_enforcer.sh         — Color model (SPEC §8.1)
lib/spec/nexus_gate_v2.sh          — Full pipeline gate (SPEC §2.3)
schemas/prediction.schema.json
schemas/security_state_report.schema.json
tests/test_predictor.bats
tests/test_enforcer.bats
tests/test_gate_v2.bats
```

### Funciones (del PREFIX_REGISTRY):
```
PUBLIC (4):
  nexus_predictor_project
  nexus_enforcer_classify    nexus_enforcer_dispatch
  nexus_gate_v2_full_pipeline

PRIVATE (6):
  __nexus_predictor_calc_horizon
  __nexus_predictor_confidence_interval
  __nexus_predictor_extrapolate
  __nexus_enforcer_check_governance
  __nexus_enforcer_emit_report
  __nexus_gate_v2_composition_check
```

### Wire al framework existente (Fusión A+B):
```
# auto_optimization.sh (L4) Circuit Breaker protege al pipeline:
# nexus_cb_init "vortex_pipeline"
# if nexus_cb_allow "vortex_pipeline"; then
#     nexus_gate_v2_full_pipeline "$script"
# fi
#
# Enforcer usa nexus_log_* para audit trail:
# nexus_log_emit "CRITICAL" "Status RED: blocking merge" "$report_json"
```

### Criterios de aceptación:
- [ ] Predictor emite confidence intervals (no certeza falsa — SPEC §1.2)
- [ ] Enforcer: 5 colores correctamente clasificados por umbrales
- [ ] Gate v2 es hard stop — NO hay silent fallthrough
- [ ] security_state_report.json incluye VortexState embebido

### Funciones nuevas: 10
### LOC estimado: ~800


# ┌─────────────────────────────────────────────────────────────────────────────┐
# │                      WAVE 5 — REGISTRY + CLI                               │
# │                      ═══════════════════════                                │
# │  Meta: Persistencia XDG + interfaz de usuario (nexusctl).                  │
# └─────────────────────────────────────────────────────────────────────────────┘

Objetivo: El usuario puede ejecutar `nexusctl scan --script x.sh` end-to-end.

Prerequisitos: Wave 4 (pipeline completo para persistir resultados).

### Archivos a CREAR:
```
lib/spec/nexus_registry.sh       — XDG storage, URI spec:// (SPEC §6)
lib/spec/nexus_history.sh        — Terminal trajectory visualization
bin/nexusctl                     — CLI wrapper (SPEC §7)
schemas/index.schema.json
tests/test_registry.bats
tests/test_nexusctl.bats
```

### Funciones (del PREFIX_REGISTRY):
```
PUBLIC (14):
  nexus_registry_init       nexus_registry_publish
  nexus_registry_query      nexus_registry_list
  nexus_ctl_main            nexus_ctl_init          nexus_ctl_scan
  nexus_ctl_gate            nexus_ctl_vortex        nexus_ctl_publish
  nexus_ctl_history         nexus_ctl_diff          nexus_ctl_doctor
  nexus_history_display

PRIVATE (7):
  __nexus_registry_resolve_uri    __nexus_registry_update_index
  __nexus_registry_archive
  __nexus_ctl_parse_args          __nexus_ctl_dispatch
  __nexus_history_render_trajectory
  __nexus_history_format_table
```

### Wire al framework existente (Fusión A+B):
```
# nexus_ctl_doctor usa el framework completo:
# - nexus_system_selftest()      ← L2 system_checks
# - nexus_xdg_validate_rootless() ← L0 xdg_paths
# - nexus_schema_validate()       ← W2 assert_schema
# - nexus_deps_check_all()        ← L2 deps_utils
# - nexus_security_verify_checksum() ← L2 security_core
#
# nexus_ctl_scan ejecuta el pipeline completo:
# Detectors → Risk Engine → Trend → Vortex → Predictor → Gate → Enforcer → Registry
```

### Wire de plugins al pipeline:
```
# Los 9 plugins ahora se BENEFICIAN del pipeline:
# Antes de install_custom, nexusctl gate evalúa el script del plugin.
# Después de install, nexus_registry_publish archiva el estado.
# nexus_monitor_check_health() monitorea las instancias.
# nexus_heal_check() detecta instalaciones corruptas.
```

### Criterios de aceptación:
- [ ] `nexusctl scan --script tests/corpus/sample.sh` produce SSR completo
- [ ] `nexusctl history` muestra trajectory ASCII en terminal
- [ ] `nexusctl doctor` valida 100% del entorno
- [ ] Registry persiste en $NEXUS_DATA_DIR/registry/ (XDG compliant)
- [ ] URI spec://org/repo/commit resuelve correctamente

### Funciones nuevas: 21
### LOC estimado: ~1,400


# ┌─────────────────────────────────────────────────────────────────────────────┐
# │                    WAVE 6 — OBSERVATORY DASHBOARD                          │
# │                    ══════════════════════════════                           │
# │  Meta: Visualización terminal del Risk Phase Space.                        │
# └─────────────────────────────────────────────────────────────────────────────┘

Objetivo: Dashboard ASCII/ANSI que muestre la trayectoria de riesgo.

Prerequisitos: Wave 5 (Registry con datos históricos).

### Archivos a CREAR:
```
lib/spec/nexus_observatory.sh    — Dashboard renderer
tests/test_observatory.bats
```

### Funciones (del PREFIX_REGISTRY):
```
PUBLIC (3):
  nexus_observatory_render      nexus_observatory_phase_plot
  nexus_observatory_diff_view

PRIVATE (2):
  __nexus_observatory_fetch_data
  __nexus_observatory_render_ansi
```

### Criterios de aceptación:
- [ ] Render funcional en terminal 80×24 mínimo
- [ ] Phase plot (R, v) con attractor zones coloreados
- [ ] Diff view muestra cambios entre 2 SSRs
- [ ] Funciona en Termux (sin dependencias gráficas)

### Funciones nuevas: 5
### LOC estimado: ~500

