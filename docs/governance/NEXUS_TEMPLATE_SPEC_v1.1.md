# NEXUS_TEMPLATE_SPEC v1.1
# Especificación de Plantilla Canónica para Archivos .sh
# Proyecto: NEXUS-KALI APEX
# Fecha: 2026-03-17
# Estado: NORMATIVO — Todo archivo .sh generado DEBE cumplir esta plantilla

---

## §1. Propósito

Este documento define la **estructura física exacta** que debe tener todo archivo
`.sh` del proyecto NEXUS-KALI APEX. Es el contrato entre los agentes generadores
de código (humanos o IA) y el sistema de validación (`nexus-quality-gate`).

Ningún otro documento define la estructura de archivo. Si hay conflicto entre
este documento y cualquier otro, **este documento gana**.

### §1.1 Relación con otros documentos de governance

| Documento | Define | Relación con este |
|-----------|--------|-------------------|
| `SPEC_Nexus_Kali_v1.0.md` | Arquitectura, contratos de datos, matemáticas | Define QUÉ hace cada componente; este define CÓMO se estructura el archivo |
| `NEXUS_PREFIX_REGISTRY_v1.0.csv` | Nombres canónicos de 342 funciones | Este spec define dónde van esas funciones dentro del archivo |
| `Nx-prefix-spec-v1.0.md` | Reglas de naming (prefijos, variables) | Complementario — naming rules se aplican DENTRO de esta plantilla |
| `NEXUS_WAVE_PLAN_v1.0.md` | Qué archivos van en cada Wave | Define QUÉ generar; este define CÓMO generarlo |
| `NEXUS_EXECUTION_PROTOCOL_v1.0.md` | Orden de generación (25 batches) | Define CUÁNDO generar; este define la FORMA |


## §2. Plantilla Canónica — Orden Obligatorio de Secciones

Todo archivo `.sh` sigue esta estructura exacta, en este orden:

```
┌─────────────────────────────────────────────────────────┐
│  LÍNEA 1    Shebang                                     │
│  LÍNEA 2    Meta descriptor (#@meta JSON)               │
│  LÍNEAS 3+  Header delimitado                           │
│             Guard anti-doble-carga + Template Version   │
│             Security Block delimitado                   │
│             Constants & Configuration                   │
│             Private helper functions (_nexus_*)          │
│             Public API functions (nexus_*)               │
│             Self-test function (__selftest_*)            │
│             Trap block (si aplica)                       │
│             Export block                                 │
│             Entry point guard                           │
└─────────────────────────────────────────────────────────┘
```


## §3. Secciones — Especificación Detallada

### §3.1 Shebang (LÍNEA 1, obligatorio)

```bash
#!/usr/bin/env bash
```

- SIEMPRE `env bash` para portabilidad Termux.
- NUNCA `#!/bin/bash` ni `#!/bin/sh`.
- Sin opciones en shebang (`-e`, `-x` van en Security Block).


### §3.2 Meta Descriptor (LÍNEA 2, obligatorio)

```bash
#@meta {"module":"<nombre>","version":"<semver>","category":"<cat>","template":"nexus_plantilla_1.1"}
```

| Campo | Tipo | Valores permitidos |
|-------|------|--------------------|
| `module` | string | Nombre del archivo sin extensión. Ej: `nexus_paths` |
| `version` | semver | `1.0.0`, `2.1.3`, etc. |
| `category` | enum | `foundation`, `detector`, `risk`, `trend`, `vortex`, `prediction`, `enforcement`, `registry`, `gate`, `cli`, `tool`, `test` |
| `template` | const | Siempre `nexus_plantilla_1.1` |

**Propósito**: Permite a agentes futuros y herramientas CI identificar el módulo
sin parsear el cuerpo. Un simple `grep '#@meta' lib/*.sh | jq` cataloga todo el proyecto.


### §3.3 Header Delimitado (obligatorio)

```bash
### === [HEADER] ===
# ==============================================================================
# NOMBRE:        <module_name>.sh
# VERSIÓN:       <semver>
# FECHA:         <YYYY-MM-DD>
# PROYECTO:      Nexus-Kali APEX/<LAYER>
# DESCRIPCIÓN:   <una línea en español>
# LICENCIA:      MIT
# SPEC REF:      §<sección del SPEC>
# DEPENDENCIES:  <módulos requeridos, comma-separated>
# CHANGES:
#   - [v1.0.0] (<fecha>): Initial release
# ==============================================================================
### === [END HEADER] ===
```

**Campos obligatorios**: NOMBRE, VERSIÓN, FECHA, PROYECTO, DESCRIPCIÓN, LICENCIA,
SPEC REF, DEPENDENCIES, CHANGES.

- Los delimitadores `### === [HEADER] ===` y `### === [END HEADER] ===` son
  **obligatorios** y deben ser las líneas exactas (no variaciones).
- `SPEC REF` vincula al archivo con su sección del SPEC (ej: `§3.1` para detectors).
- `DEPENDENCIES` lista módulos que deben cargarse antes (orden de source en loader).


### §3.4 Guard Anti-Doble-Carga + Template Version (obligatorio para librerías)

```bash
if [[ -n "${__NEXUS_<MODULE>_LOADED:-}" ]]; then return 0; fi
declare -gr __NEXUS_<MODULE>_LOADED="<semver>"
declare -gr NEXUS_TEMPLATE_VERSION="1.1.0"
```

| Elemento | Especificación |
|----------|----------------|
| Prefijo del guard | Doble underscore: `__NEXUS_` (no simple `_NEXUS_`) |
| Declaración | `declare -gr` (global + readonly). No `declare -g` solo. |
| Valor del guard | Semver del módulo (`"1.0.0"`). No `1`, no `true`, no vacío. |
| `<MODULE>` | Nombre en MAYÚSCULAS: `PATHS`, `LOG`, `RISK_ENGINE`, `VORTEX`, etc. |
| `NEXUS_TEMPLATE_VERSION` | Siempre `"1.1.0"` hasta que se publique una nueva versión de este spec. |

**Excepciones documentadas**:
- `bin/nexusctl` — es entry point ejecutable, no se sourcea. No requiere guard.
- `tools/*.sh` — scripts de CI, se ejecutan, no se sourcean. Guard opcional.
- `tests/*.bats` — tests, no se sourcean. Sin guard.


### §3.5 Security Block Delimitado (obligatorio)

```bash
### === [SECURITY BLOCK] ===
set -Eeuo pipefail
set -o errtrace
IFS=$' \t\n'
### === [END SECURITY BLOCK] ===
```

| Flag | Propósito |
|------|-----------|
| `-E` | Hereda ERR trap en funciones |
| `-e` | Exit on error |
| `-u` | Error en variable no definida |
| `-o pipefail` | Fallo en cualquier comando del pipe = fallo del pipe |
| `errtrace` | Propaga ERR trap a funciones y subshells |
| `IFS` | Reset al default POSIX (espacio + tab + newline) |

- Los delimitadores `=== [SECURITY BLOCK] ===` son obligatorios.
- Estas 3 líneas van juntas, sin código entre ellas.


### §3.6 Constants & Configuration (opcional, posición fija)

```bash
# ─── Constants ─────────────────────────────────────────────
readonly NEXUS_<MOD>_VERSION="<semver>"
readonly NEXUS_<MOD>_<CONSTANT>="<valor>"
declare -A NEXUS_<MOD>_<MAP>=( [key]="value" )
```

- Todas las constantes usan `readonly` o `declare -gr`.
- Variables públicas: `NEXUS_<MOD>_*`
- Variables privadas: `_NEXUS_<MOD>_*`


### §3.7 Private Helper Functions (posición fija)

```bash
# ─── Private Helpers ───────────────────────────────────────
_nexus_<mod>_<helper>() {
    # Implementación interna — NO exportar
}
```

- Prefijo: `_nexus_<mod>_` (un underscore)
- NUNCA exportar con `export -f`
- NUNCA llamar desde fuera del módulo
- Variables internas con `local`


### §3.8 Public API Functions (posición fija)

```bash
# ─── Public API ────────────────────────────────────────────
nexus_<mod>_<action>() {
    local param1="${1:?ERROR: nexus_<mod>_<action> requiere param1}"
    local param2="${2:-default}"
    # Validación + lógica
}
```

- Prefijo: `nexus_<mod>_` (sin underscore)
- TODA función pública valida parámetros (`${1:?...}` o `[[ -z ]]`)
- Return codes: `0` éxito, `1` error de ejecución, `2` input inválido
- Errores con `nexus_log_error`, NUNCA `echo`
- Nombres DEBEN coincidir con `PREFIX_REGISTRY` CSV


### §3.9 Self-Test Function (obligatorio para librerías)

```bash
# ─── Self-Test ─────────────────────────────────────────────
__selftest_nexus_<module>() {
    local tests_passed=0 tests_failed=0

    # Test 1: Módulo cargado
    [[ -n "${__NEXUS_<MODULE>_LOADED:-}" ]] \
        && (( tests_passed += 1 )) || (( tests_failed += 1 ))

    # Test 2..N: Tests contra API pública con datos reales
    # ...

    printf "SELFTEST [%s]: %d passed, %d failed\n" \
        "<module>" "${tests_passed}" "${tests_failed}"
    return $(( tests_failed > 0 ? 1 : 0 ))
}
```

- Prefijo: `__selftest_` (doble underscore) — interna, NUNCA exportar
- Debe contener tests **reales** contra la API pública (no vacía, no solo `return 0`)
- Usar `(( var += 1 ))` en vez de `(( var++ ))` para evitar exit code 1 con `set -e`


### §3.10 Trap Block (condicional)

```bash
# ─── Traps ─────────────────────────────────────────────────
trap '_nexus_<mod>_cleanup "SIGINT"'  INT
trap '_nexus_<mod>_cleanup "SIGTERM"' TERM
trap '_nexus_<mod>_on_exit'           EXIT
```

- **Obligatorio** en: `bin/nexusctl`, `tools/*.sh`, cualquier entry point ejecutable.
- **Opcional** en: librerías puras que solo se sourcean.
- La función cleanup referenciada DEBE existir en el archivo.


### §3.11 Export Block (obligatorio para librerías)

```bash
# ─── Exports ───────────────────────────────────────────────
export -f nexus_<mod>_action1
export -f nexus_<mod>_action2
# NO exportar: _nexus_* ni __selftest_*
```

- SOLO funciones públicas (`nexus_<mod>_*`)
- Agrupadas AL FINAL del archivo, después del self-test
- JAMÁS exportar `_nexus_*` (privadas) ni `__selftest_*`
- Si se detecta `export -f _nexus_` → ERROR CRÍTICO


### §3.12 Entry Point Guard (obligatorio)

```bash
# ─── Entry Point ───────────────────────────────────────────
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    __selftest_nexus_<module> "$@"
fi
```

- Última sección del archivo
- Permite ejecutar `bash lib/nexus_<module>.sh` para auto-validar
- En entry points (`bin/nexusctl`), aquí va `main "$@"` en vez de selftest


## §4. Ejemplo Completo Mínimo

```bash
#!/usr/bin/env bash
#@meta {"module":"nexus_example","version":"1.0.0","category":"foundation","template":"nexus_plantilla_1.1"}
### === [HEADER] ===
# ==============================================================================
# NOMBRE:        nexus_example.sh
# VERSIÓN:       1.0.0
# FECHA:         2026-03-17
# PROYECTO:      Nexus-Kali APEX/L0-Foundation
# DESCRIPCIÓN:   Módulo ejemplo para validar estructura de plantilla
# LICENCIA:      MIT
# SPEC REF:      §2.1
# DEPENDENCIES:  nexus_log
# CHANGES:
#   - [v1.0.0] (2026-03-17): Initial release
# ==============================================================================
### === [END HEADER] ===

if [[ -n "${__NEXUS_EXAMPLE_LOADED:-}" ]]; then return 0; fi
declare -gr __NEXUS_EXAMPLE_LOADED="1.0.0"
declare -gr NEXUS_TEMPLATE_VERSION="1.1.0"

### === [SECURITY BLOCK] ===
set -Eeuo pipefail
set -o errtrace
IFS=$' \t\n'
### === [END SECURITY BLOCK] ===

# ─── Constants ─────────────────────────────────────────────
readonly NEXUS_EXAMPLE_VERSION="1.0.0"

# ─── Private Helpers ───────────────────────────────────────
_nexus_example_validate_input() {
    local input="${1:-}"
    [[ -n "${input}" ]] && [[ "${input}" =~ ^[a-zA-Z0-9_-]+$ ]]
}

# ─── Public API ────────────────────────────────────────────
nexus_example_greet() {
    local name="${1:?ERROR: nexus_example_greet requiere name}"
    if ! _nexus_example_validate_input "${name}"; then
        nexus_log_error "nexus_example_greet: name inválido '${name}'"
        return 2
    fi
    printf "Hello, %s\n" "${name}"
    return 0
}

# ─── Self-Test ─────────────────────────────────────────────
__selftest_nexus_example() {
    local tests_passed=0 tests_failed=0

    # Test 1: Módulo cargado
    [[ -n "${__NEXUS_EXAMPLE_LOADED:-}" ]] \
        && (( tests_passed += 1 )) || (( tests_failed += 1 ))

    # Test 2: greet con input válido
    local result
    result="$(nexus_example_greet "world" 2>/dev/null)" \
        && [[ "${result}" == "Hello, world" ]] \
        && (( tests_passed += 1 )) || (( tests_failed += 1 ))

    # Test 3: greet con input inválido retorna 2
    nexus_example_greet '"; rm -rf /' >/dev/null 2>&1
    [[ $? -eq 2 ]] \
        && (( tests_passed += 1 )) || (( tests_failed += 1 ))

    printf "SELFTEST [example]: %d passed, %d failed\n" \
        "${tests_passed}" "${tests_failed}"
    return $(( tests_failed > 0 ? 1 : 0 ))
}

# ─── Exports ───────────────────────────────────────────────
export -f nexus_example_greet

# ─── Entry Point ───────────────────────────────────────────
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    __selftest_nexus_example "$@"
fi
```


## §5. Validación Automatizada

### §5.1 CI Check (para `tools/run_all_tests.sh`)

```bash
_check_template_compliance() {
    local file="${1:?file required}"
    local errors=0

    grep -q '^#!/usr/bin/env bash$'             "${file}" || (( errors += 1 ))
    sed -n '2p' "${file}" | grep -q '^#@meta '  || (( errors += 1 ))
    grep -q '### === \[HEADER\] ==='            "${file}" || (( errors += 1 ))
    grep -q '### === \[END HEADER\] ==='        "${file}" || (( errors += 1 ))
    grep -q 'declare -gr __NEXUS_.*_LOADED='    "${file}" || (( errors += 1 ))
    grep -q 'NEXUS_TEMPLATE_VERSION="1.1.0"'    "${file}" || (( errors += 1 ))
    grep -q '### === \[SECURITY BLOCK\] ==='    "${file}" || (( errors += 1 ))
    grep -q '### === \[END SECURITY BLOCK\] ===' "${file}" || (( errors += 1 ))
    grep -q 'set -Eeuo pipefail'                "${file}" || (( errors += 1 ))
    grep -q 'set -o errtrace'                   "${file}" || (( errors += 1 ))
    grep -q '__selftest_nexus_'                  "${file}" || (( errors += 1 ))
    grep -q 'BASH_SOURCE\[0\]'                  "${file}" || (( errors += 1 ))

    return "${errors}"
}
```

### §5.2 Grep rápido de compliance

```bash
# Verificar todos los lib/*.sh de un golpe
for f in lib/*.sh lib/**/*.sh; do
    echo -n "$f: "
    _check_template_compliance "$f" && echo "✅ PASS" || echo "❌ FAIL ($? issues)"
done
```


## §6. Versionado de esta Especificación

| Versión | Fecha | Cambios |
|---------|-------|---------|
| 1.0.0 | 2026-03-14 | Versión inicial (implícita en el prompt v1) |
| 1.1.0 | 2026-03-17 | Formalización: meta descriptor, delimitadores, security block, entry point guard. Alineado con skills v2.0 y prompt v2. |

Cuando se publique una nueva versión de este spec:
1. Incrementar `NEXUS_TEMPLATE_VERSION` en §3.4
2. Actualizar la tabla §6
3. Actualizar el campo `template` en §3.2 (`nexus_plantilla_<version>`)
4. Notificar a los skills (`nexus-bash-generator`, `nexus-quality-gate`) para sincronizar
