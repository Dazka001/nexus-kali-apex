#!/usr/bin/env bash
# ══════════════════════════════════════════════════════════════
# cleanup-legacy-docs.sh — Migrar docs históricos a reference/
# NEXUS-KALI APEX — Auditoría de consistencia documental
# Fecha: 2026-03-17  |  Fix: v2 — corrige arithmetic exit code
# ══════════════════════════════════════════════════════════════
set -Eeuo pipefail

readonly REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# ─── Colores ───────────────────────────────────────────────
readonly RED='\033[0;31m'
readonly GREEN='\033[0;32m'
readonly YELLOW='\033[0;33m'
readonly CYAN='\033[0;36m'
readonly NC='\033[0m'

log_info()  { printf "${CYAN}[INFO]${NC}  %s\n" "$1"; }
log_ok()    { printf "${GREEN}[OK]${NC}    %s\n" "$1"; }
log_warn()  { printf "${YELLOW}[WARN]${NC}  %s\n" "$1"; }
log_error() { printf "${RED}[ERROR]${NC} %s\n" "$1" >&2; }

# ─── Verificar que estamos en el repo correcto ─────────────
if [[ ! -d "${REPO_ROOT}/docs/governance" ]]; then
    log_error "No se encontró docs/governance/. ¿Estás en el repo correcto?"
    exit 1
fi

log_info "═══════════════════════════════════════════════════"
log_info "  CLEANUP — NEXUS-KALI APEX"
log_info "  Repo root: ${REPO_ROOT}"
log_info "═══════════════════════════════════════════════════"
log_info ""

# ─── Crear directorios destino ─────────────────────────────
log_info "Creando directorios de destino..."
mkdir -p "${REPO_ROOT}/docs/reference"
mkdir -p "${REPO_ROOT}/docs/prompts"
log_ok "Directorios docs/reference/ y docs/prompts/ creados"

# ─── Mover prompt fuera de governance ──────────────────────
if [[ -f "${REPO_ROOT}/docs/governance/Nexus_Search_Architect_Prompt.md" ]]; then
    log_info "Moviendo Nexus_Search_Architect_Prompt.md → docs/prompts/"
    git -C "${REPO_ROOT}" mv \
        docs/governance/Nexus_Search_Architect_Prompt.md \
        docs/prompts/ 2>/dev/null || \
    mv "${REPO_ROOT}/docs/governance/Nexus_Search_Architect_Prompt.md" \
       "${REPO_ROOT}/docs/prompts/"
    log_ok "Prompt movido a docs/prompts/"
else
    log_warn "Nexus_Search_Architect_Prompt.md no encontrado en governance/ (ya movido o inexistente)"
fi

# ─── Limpiar .gitkeep innecesario en governance ───────────
if [[ -f "${REPO_ROOT}/docs/governance/.gitkeep" ]]; then
    rm -f "${REPO_ROOT}/docs/governance/.gitkeep"
    log_ok "Removido .gitkeep innecesario de docs/governance/"
fi

# ─── Asegurar .gitkeep en detectors ───────────────────────
if [[ -d "${REPO_ROOT}/lib/spec/detectors" ]]; then
    if [[ ! -f "${REPO_ROOT}/lib/spec/detectors/.gitkeep" ]]; then
        touch "${REPO_ROOT}/lib/spec/detectors/.gitkeep"
        log_ok "Añadido .gitkeep a lib/spec/detectors/"
    else
        log_ok "lib/spec/detectors/.gitkeep ya existe"
    fi
fi

# ─── Asegurar .gitkeep en nuevos directorios ──────────────
for dir in docs/reference docs/prompts; do
    if [[ -d "${REPO_ROOT}/${dir}" ]]; then
        local_count=$(find "${REPO_ROOT}/${dir}" -maxdepth 1 -type f ! -name '.gitkeep' 2>/dev/null | wc -l)
        if [[ "${local_count}" -eq 0 ]]; then
            touch "${REPO_ROOT}/${dir}/.gitkeep"
            log_ok "Añadido .gitkeep a ${dir}/"
        fi
    fi
done

# ─── Verificación final ───────────────────────────────────
log_info ""
log_info "═══════════════════════════════════════════════════"
log_info "  VERIFICACIÓN POST-LIMPIEZA"
log_info "═══════════════════════════════════════════════════"

declare -a GOVERNANCE_EXPECTED=(
    "README.md"
    "SPEC_Nexus_Kali_v1.0.md"
    "NEXUS_PREFIX_REGISTRY_v1.0.csv"
    "Nx-prefix-spec-v1.0.md"
    "NEXUS_WAVE_PLAN_v1.0.md"
    "NEXUS_EXECUTION_PROTOCOL_v1.0.md"
)

pass_count=0
fail_count=0

for expected_file in "${GOVERNANCE_EXPECTED[@]}"; do
    if [[ -f "${REPO_ROOT}/docs/governance/${expected_file}" ]]; then
        log_ok "  docs/governance/${expected_file}"
        pass_count=$(( pass_count + 1 ))
    else
        log_error "  FALTA: docs/governance/${expected_file}"
        fail_count=$(( fail_count + 1 ))
    fi
done

log_info ""

# ─── Verificar que NO haya archivos extraños en governance
extra_count=0
while IFS= read -r -d '' gfile; do
    basename_file="$(basename "${gfile}")"
    is_expected=false
    for expected_file in "${GOVERNANCE_EXPECTED[@]}"; do
        if [[ "${basename_file}" == "${expected_file}" ]]; then
            is_expected=true
            break
        fi
    done
    if [[ "${is_expected}" == "false" && "${basename_file}" != ".gitkeep" ]]; then
        log_warn "  Archivo inesperado en governance/: ${basename_file}"
        extra_count=$(( extra_count + 1 ))
    fi
done < <(find "${REPO_ROOT}/docs/governance" -maxdepth 1 -type f -print0 2>/dev/null)

# ─── Resumen ──────────────────────────────────────────────
log_info "═══════════════════════════════════════════════════"
log_info "  RESUMEN"
log_info "═══════════════════════════════════════════════════"
log_info "  Archivos governance esperados : ${pass_count}/6"
log_info "  Archivos governance faltantes : ${fail_count}"
log_info "  Archivos governance extra     : ${extra_count}"
log_info ""

if [[ "${fail_count}" -eq 0 && "${extra_count}" -eq 0 ]]; then
    log_ok "✅ Governance LIMPIA: 6/6 archivos, 0 extra"
    log_info ""
    log_info "Siguiente paso:"
    log_info "  git add ."
    log_info "  git commit -m 'refactor(docs): audit - alinear repo con SPEC v1.0'"
    log_info "  git push"
    exit 0
elif [[ "${fail_count}" -eq 0 && "${extra_count}" -gt 0 ]]; then
    log_warn "⚠️  Governance completa pero con ${extra_count} archivo(s) extra"
    log_info "Revisa los archivos inesperados y muévelos a docs/reference/ o docs/prompts/"
    exit 0
else
    log_error "❌ Governance INCOMPLETA: ${fail_count} archivo(s) faltante(s)"
    log_error "Revisa los errores arriba antes de continuar"
    exit 1
fi
