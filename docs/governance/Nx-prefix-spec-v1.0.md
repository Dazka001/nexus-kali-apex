# ═══════════════════════════════════════════════════════════════════════════════
# Nx-prefix-spec v1.0 — NEXUS-KALI APEX Definitive Prefix Specification
# ═══════════════════════════════════════════════════════════════════════════════
# Status:    RATIFIED (pending implementation)
# Date:      2026-03-14
# Scope:     ALL code in the project — no exceptions
# Authority: This document is the SINGLE SOURCE OF TRUTH for naming.
#            Any function/variable not listed here is non-compliant.
# ═══════════════════════════════════════════════════════════════════════════════

## §1. NAMING CONVENTION — RULES

### §1.1 Functions

```
PUBLIC:   nexus_<module>_<action>()     — Callable from any module
PRIVATE:  __nexus_<module>_<helper>()   — Module-internal ONLY
```

Rules:
1. ALL public functions MUST start with `nexus_`
2. ALL private functions MUST start with `__nexus_`
3. `<module>` is a SHORT tag (2-8 chars): base, xdg, log, config, cache, ui, cb, etc.
4. `<action>` is a verb_noun: init, get_path, emit, validate, compute
5. PROHIBITED: Calling __nexus_* from outside its declaring module
6. EXCEPTION: Tests marked `# @whitebox` may call __nexus_* for internal testing
7. Plugin private functions use `__nexus_p<NN>_<action>` where NN is plugin number

### §1.2 Variables

```
CONSTANTS:      NEXUS_<MODULE>_<NAME>          — readonly -gr
PATH (XDG):     NEXUS_<TYPE>_DIR               — declare -gr, export
GUARDS:         _NEXUS_<MODULE>_LOADED         — declare -gr (1 underscore)
INTERNAL STATE: _NEXUS_<MODULE>_<STORE>        — declare -gA/-ga (1 underscore)
LOCAL TEMP:     local __<name>                 — function-scoped only
```

Rules:
1. NO variable without NEXUS_ or _NEXUS_ prefix in global scope
2. XDG paths always end in _DIR
3. Guards use SINGLE underscore prefix (not double)
4. Associative arrays for internal state use SINGLE underscore prefix
5. ELIMINATED prefixes: NK_*, OPT_*, CB_STATE_*, METRICS_*, PRED_*

### §1.3 Files

```
LIBRARY:  nexus_<module>.sh           — In lib/<layer>/
PLUGIN:   <NN>_<name>.sh              — In plugins/
SPEC:     nexus_<component>.sh        — In lib/spec/ (Pipeline Wave code)
CLI:      nexusctl                    — In bin/
TEST:     test_nexus_<module>.bats    — In tests/
```

### §1.4 Export Policy

```
PUBLIC functions:   export -f nexus_<module>_<action>
PRIVATE functions:  NEVER export. No export -f __nexus_*
Guards:             export (needed for subshell detection)
Path variables:     export (needed for subprocesses)
Internal arrays:    NEVER export
```

## §2. GUARD PATTERN — STANDARD

Every module MUST implement this exact pattern:

```bash
# Guard anti-doble-carga
[[ -n "${_NEXUS_<MODULE>_LOADED:-}" ]] && return 0
declare -gr _NEXUS_<MODULE>_LOADED=1
```

## §3. GUARDS REGISTRY

| Current | Definitive | File |
|---|---|---|
| `NEXUS_BASE_LOADED` | `_NEXUS_BASE_LOADED` | `base_dependencies.sh` |
| `NEXUS_LOADER_LOADED` | `_NEXUS_LOADER_LOADED` | `loader.sh` |
| `NEXUS_LOGGER_LOADED` | `_NEXUS_LOGGER_LOADED` | `logger.sh` |
| `NEXUS_CONFIG_LOADED` | `_NEXUS_CONFIG_LOADED` | `config_manager.sh` |
| `NEXUS_XDG_LOADED` | `_NEXUS_XDG_LOADED` | `xdg_paths.sh` |
| `NEXUS_SYSTEM_LOADED` | `_NEXUS_SYSTEM_LOADED` | `system_checks.sh` |
| `NEXUS_CACHE_LOADED` | `_NEXUS_CACHE_LOADED` | `cache_utils.sh` |
| `NEXUS_FILE_LOADED` | `_NEXUS_FILE_LOADED` | `file_operations.sh` |
| `NEXUS_VALIDATE_LOADED` | `_NEXUS_VALIDATE_LOADED` | `validator.sh` |
| `NEXUS_INPUT_LOADED` | `_NEXUS_INPUT_LOADED` | `input_validator.sh` |
| `NEXUS_SECURITY_LOADED` | `_NEXUS_SECURITY_LOADED` | `security_core.sh` |
| `NEXUS_NET_LOADED` | `_NEXUS_NET_LOADED` | `network_utils.sh` |
| `NEXUS_I18N_LOADED` | `_NEXUS_I18N_LOADED` | `lang_utils.sh` |
| `NEXUS_DOWNLOAD_LOADED` | `_NEXUS_DOWNLOAD_LOADED` | `download_manager.sh` |
| `NEXUS_BACKUP_LOADED` | `_NEXUS_BACKUP_LOADED` | `backup_utils.sh` |
| `NEXUS_PLUGIN_LOADED` | `_NEXUS_PLUGIN_LOADED` | `plugin_system.sh` |
| `NEXUS_AUTO_OPT_LOADED` | `_NEXUS_OPT_LOADED` | `auto_optimization.sh` |
| `NEXUS_METRICS_LOADED` | `_NEXUS_METRICS_LOADED` | `metrics_system.sh` |
| `NEXUS_PREDICT_LOADED` | `_NEXUS_PREDICT_LOADED` | `predictive_engine.sh` |
| `NEXUS_HEAL_LOADED` | `_NEXUS_HEAL_LOADED` | `auto_healing.sh` |
| `NEXUS_TELEMETRY_LOADED` | `_NEXUS_TELEMETRY_LOADED` | `telemetry.sh` |
| `NEXUS_MONITOR_LOADED` | `_NEXUS_MONITOR_LOADED` | `monitoring_utils.sh` |
| `NEXUS_UI_LOADED` | `_NEXUS_UI_LOADED` | `ui_utils.sh` |

## §4. PATH VARIABLES REGISTRY

| Current (conflicting) | Definitive | Resolution |
|---|---|---|
| `NEXUS_HOME (Gen1: /opt/nexus-kali)` | `NEXUS_INSTALL_DIR` | Dir de instalación del proyecto |
| `NEXUS_HOME (Gen2: $PREFIX/share/...)` | `NEXUS_INSTALL_DIR` | Mismo, consolidado |
| `NK_CONFIG_DIR / NEXUS_CONFIG` | `NEXUS_CONFIG_DIR` | $XDG_CONFIG_HOME/nexus-kali |
| `NK_DATA_DIR / NEXUS_DATA` | `NEXUS_DATA_DIR` | $XDG_DATA_HOME/nexus-kali |
| `NK_STATE_DIR` | `NEXUS_STATE_DIR` | $XDG_STATE_HOME/nexus-kali |
| `NEXUS_LOGS / NK_LOG_DIR` | `NEXUS_LOG_DIR` | $NEXUS_STATE_DIR/logs |
| `NEXUS_CACHE / NK_CACHE_DIR` | `NEXUS_CACHE_DIR` | $XDG_CACHE_HOME/nexus-kali |
| `NEXUS_TMP / NK_RUNTIME_DIR` | `NEXUS_RUNTIME_DIR` | $XDG_RUNTIME_DIR/nexus-kali |
| `NEXUS_CORE` | `NEXUS_CORE_DIR` | $NEXUS_INSTALL_DIR/core |
| `NEXUS_LIBS / $LIB_DIR` | `NEXUS_LIB_DIR` | $NEXUS_INSTALL_DIR/lib |
| `(new)` | `NEXUS_PLUGIN_DIR` | $NEXUS_DATA_DIR/plugins |
| `(new)` | `NEXUS_REGISTRY_DIR` | $NEXUS_DATA_DIR/registry (SPEC Pipeline) |
| `(new)` | `NEXUS_BACKUP_DIR` | $NEXUS_DATA_DIR/backups |

## §5. ENTERPRISE CONSTANTS REGISTRY

| Current | Definitive | Default |
|---|---|---|
| `OPT_MEMORY_THRESHOLD_WARN` | `NEXUS_OPT_MEM_WARN` | `75` |
| `OPT_MEMORY_THRESHOLD_CRIT` | `NEXUS_OPT_MEM_CRIT` | `90` |
| `OPT_CPU_THRESHOLD_WARN` | `NEXUS_OPT_CPU_WARN` | `70` |
| `OPT_CPU_THRESHOLD_CRIT` | `NEXUS_OPT_CPU_CRIT` | `90` |
| `OPT_DISK_THRESHOLD_WARN` | `NEXUS_OPT_DISK_WARN` | `80` |
| `OPT_DISK_THRESHOLD_CRIT` | `NEXUS_OPT_DISK_CRIT` | `95` |
| `OPT_BACKOFF_BASE` | `NEXUS_RETRY_BACKOFF_BASE` | `1` |
| `OPT_BACKOFF_MAX` | `NEXUS_RETRY_BACKOFF_MAX` | `60` |
| `OPT_MAX_RETRIES` | `NEXUS_RETRY_MAX_ATTEMPTS` | `5` |
| `CB_STATE_CLOSED` | `NEXUS_CB_STATE_CLOSED` | `'CLOSED'` |
| `CB_STATE_OPEN` | `NEXUS_CB_STATE_OPEN` | `'OPEN'` |
| `CB_STATE_HALF_OPEN` | `NEXUS_CB_STATE_HALF_OPEN` | `'HALF_OPEN'` |
| `METRICS_RETENTION_DAYS` | `NEXUS_METRICS_RETENTION_DAYS` | `30` |
| `METRIC_TYPE_COUNTER` | `NEXUS_METRIC_TYPE_COUNTER` | `'counter'` |
| `METRIC_TYPE_GAUGE` | `NEXUS_METRIC_TYPE_GAUGE` | `'gauge'` |
| `METRIC_TYPE_HISTOGRAM` | `NEXUS_METRIC_TYPE_HISTOGRAM` | `'histogram'` |

## §6. SPEC PIPELINE CONSTANTS (NEW)

| Variable | Default | SPEC Section |
|---|---|---|
| `NEXUS_RISK_WEIGHT_CRITICAL` | `1.000` | §4-§5 |
| `NEXUS_RISK_WEIGHT_HIGH` | `0.600` | §4-§5 |
| `NEXUS_RISK_WEIGHT_MEDIUM` | `0.250` | §4-§5 |
| `NEXUS_RISK_WEIGHT_LOW` | `0.075` | §4-§5 |
| `NEXUS_RISK_WEIGHT_INFO` | `0.010` | §4-§5 |
| `NEXUS_RISK_DENSITY_KD` | `0.15` | §4-§5 |
| `NEXUS_VORTEX_WINDOW_DEFAULT` | `5` | §4-§5 |
| `NEXUS_PHASE_STABLE_R_MAX` | `0.35` | §4-§5 |
| `NEXUS_PHASE_CRITICAL_R_MIN` | `0.70` | §4-§5 |
| `NEXUS_PHASE_STABLE_V_MAX` | `0.01` | §4-§5 |
| `NEXUS_PHASE_STABLE_VOL_MAX` | `0.05` | §4-§5 |
| `NEXUS_EVENT_VELOCITY_SPIKE` | `0.03` | §4-§5 |
| `NEXUS_EVENT_ACCEL_SPIKE` | `0.01` | §4-§5 |
| `NEXUS_EVENT_ENTROPY_HIGH` | `0.80` | §4-§5 |
| `NEXUS_EVENT_VOLATILITY_HIGH` | `0.10` | §4-§5 |
| `NEXUS_EVENT_HIGH_DENSITY` | `8.0` | §4-§5 |
| `NEXUS_ENFORCER_GREEN_MAX` | `0.30` | §4-§5 |
| `NEXUS_ENFORCER_YELLOW_MAX` | `0.50` | §4-§5 |
| `NEXUS_ENFORCER_RED_MIN` | `0.70` | §4-§5 |
| `NEXUS_ENFORCER_BLACK_MIN` | `0.90` | §4-§5 |

## §7. INTERNAL STATE ARRAYS

| Current | Definitive | Type | Purpose |
|---|---|---|---|
| `NEXUS_FEATURE_FLAGS` | `_NEXUS_BASE_FEATURE_FLAGS` | `-gA` | Feature flags |
| `NEXUS_METRICS_CACHE` | `_NEXUS_METRICS_CACHE` | `-gA` | Metric metadata |
| `NEXUS_CONTEXT_CACHE` | `_NEXUS_PREDICT_CTX_CACHE` | `-gA` | Prediction context |
| `NEXUS_CIRCUIT_BREAKERS` | `_NEXUS_CB_STATE` | `-gA` | CB state per name |
| `NEXUS_RATE_LIMITERS` | `_NEXUS_RL_STATE` | `-gA` | RL state per name |
| `NEXUS_HOOKS` | `_NEXUS_PLUGIN_HOOKS` | `-gA` | Plugin hooks |
| `NEXUS_CLEANUP_HANDLERS` | `_NEXUS_ERROR_CLEANUP_HANDLERS` | `-ga` | Cleanup stack |
| `NEXUS_SHUTDOWN_HANDLERS` | `_NEXUS_ERROR_SHUTDOWN_HANDLERS` | `-ga` | Shutdown stack |
| `NEXUS_ERROR_HISTORY` | `_NEXUS_ERROR_HISTORY` | `-ga` | Error log |
| `NEXUS_LOAD_ORDER` | `_NEXUS_LOADER_ORDER` | `-ga` | Module load order |
| `NEXUS_MODULE_REGISTRY` | `_NEXUS_LOADER_MODULE_REGISTRY` | `-gA` | Module → file map |
| `NEXUS_LOADED_MODULES` | `_NEXUS_LOADER_LOADED_MODULES` | `-gA` | Loaded status |
| `NEXUS_CHECKSUMS` | `_NEXUS_LOADER_CHECKSUMS` | `-gA` | SHA256 checksums |
| `METRICS_COUNTERS` | `_NEXUS_METRICS_COUNTERS` | `-gA` | Counter values |
| `METRICS_GAUGES` | `_NEXUS_METRICS_GAUGES` | `-gA` | Gauge values |
| `METRICS_HISTOGRAMS` | `_NEXUS_METRICS_HISTOGRAMS` | `-gA` | Histogram buckets |
| `METRICS_BUFFER` | `_NEXUS_METRICS_BUFFER` | `-ga` | Flush buffer |
| `OPTIMIZATION_STRATEGIES` | `_NEXUS_OPT_STRATEGIES` | `-gA` | Strategy map |

## §8. ENFORCEMENT MECHANISM

### §8.1 Static Linter (nexus_detector_convention.sh — Wave 1)

The convention detector MUST check:

```
NX-CONV-001  Private function called from outside declaring module     HIGH
NX-CONV-002  Function without nexus_ or __nexus_ prefix               HIGH
NX-CONV-003  Global variable without NEXUS_ or _NEXUS_ prefix         MEDIUM
NX-CONV-004  export -f on __nexus_* function                           CRITICAL
NX-CONV-005  Missing guard clause at module top                        HIGH
NX-CONV-006  Guard uses wrong prefix (NK_, old NEXUS_*_LOADED)        MEDIUM
NX-CONV-007  Path variable not ending in _DIR                          LOW
NX-CONV-008  Plugin helper not using __nexus_p<NN>_ prefix            MEDIUM
```

### §8.2 CI Gate Rule

```bash
# In nexusctl gate --strict:
# Fail if ANY NX-CONV-001 or NX-CONV-004 finding exists
# Warn on NX-CONV-002..008
```

### §8.3 Whitebox Test Exception

```bash
# Tests that need private access MUST declare:
# @whitebox nexus_vortex
# This allows calling __nexus_vortex_* in that test file ONLY
```

## §9. MIGRATION SHIM (Backward Compatibility)

During migration, a compatibility shim provides old→new aliases:

```bash
# lib/compat/nexus_compat_shim.sh
# AUTO-GENERATED — DO NOT EDIT
# Provides backward-compatible aliases during migration period
# Remove after all consumers are updated

generate_uuid()       { nexus_base_uuid "$@"; }
get_timestamp_ms()    { nexus_base_timestamp_ms "$@"; }
log_message()         { nexus_log_emit "$@"; }
circuit_breaker_init(){ nexus_cb_init "$@"; }
# ... (full list in migration script)

# Emit deprecation warning on first use
_nexus_compat_warn() {
    local old="$1" new="$2"
    [[ -z "${_NEXUS_COMPAT_WARNED[$old]:-}" ]] || return 0
    nexus_log_warn "DEPRECATED: $old() → use $new() instead"
    _NEXUS_COMPAT_WARNED[$old]=1
}
```

The shim is loaded ONLY if NEXUS_COMPAT_MODE=1 is set.
Default: OFF. This forces clean migration.
