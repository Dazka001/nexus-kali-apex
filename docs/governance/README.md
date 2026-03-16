# Governance Docs — NEXUS-KALI APEX

Este directorio contiene la documentación **autoritativa** para la generación, validación y evolución del proyecto.

## Propósito

Los archivos en esta carpeta gobiernan:

- cómo debe generarse el código;
- cómo deben nombrarse funciones, variables y módulos;
- en qué orden debe implementarse el proyecto;
- qué contratos del pipeline deben respetarse;
- qué documento tiene prioridad cuando existe conflicto.

## Fuente de verdad

### 1. SPEC del pipeline
- `SPEC_Nexus_Kali_v1.0.md`
- Define qué debe hacer el sistema.
- Gobierna contratos JSON, matemáticas del Risk Engine, Vortex, Predictor, Enforcer, Registry y CLI.

### 2. Convenciones de código
- `NEXUS_PREFIX_REGISTRY_v1.0.csv`
- `Nx-prefix-spec-v1.0.md`
- Definen cómo se llaman las funciones, cómo deben nombrarse variables, guards, constantes y patrones de implementación.

### 3. Plan de ejecución
- `NEXUS_WAVE_PLAN_v1.0.md`
- `NEXUS_EXECUTION_PROTOCOL_v1.0.md`
- Definen en qué orden se construye el sistema y cómo se divide en batches.

## Orden de precedencia

Si existe conflicto entre documentos, aplicar este orden:

1. `SPEC_Nexus_Kali_v1.0.md`
2. `NEXUS_PREFIX_REGISTRY_v1.0.csv`
3. `Nx-prefix-spec-v1.0.md`
4. `NEXUS_WAVE_PLAN_v1.0.md`
5. `NEXUS_EXECUTION_PROTOCOL_v1.0.md`

## Contenido mínimo esperado

Para considerar esta carpeta completa, deben existir al menos estos archivos:

- `README.md`
- `SPEC_Nexus_Kali_v1.0.md`
- `NEXUS_PREFIX_REGISTRY_v1.0.csv`
- `Nx-prefix-spec-v1.0.md`
- `NEXUS_WAVE_PLAN_v1.0.md`
- `NEXUS_EXECUTION_PROTOCOL_v1.0.md`

## Reglas operativas

- No inventar nombres de funciones fuera del registry.
- No cambiar contratos del SPEC sin registrar el cambio.
- No generar archivos fuera del batch actual.
- No tratar documentos externos o históricos como autoridad.
- Si un archivo contradice esta carpeta, esta carpeta manda.

## Relación con Perplexity Computer

Las skills y sesiones de generación deben consultar primero esta carpeta antes de crear o modificar código.

### Skills esperadas
- `nexus-bash-generator`
- `nexus-spec-pipeline`
- `nexus-quality-gate`

### Regla de uso
Antes de generar cualquier archivo:
1. consultar el SPEC si aplica al pipeline;
2. consultar el PREFIX_REGISTRY para nombres exactos;
3. consultar el PREFIX_SPEC para convenciones;
4. consultar el WAVE_PLAN y el EXECUTION_PROTOCOL para scope y orden.

## Documentos de referencia

Los documentos históricos, reportes de migración, prompts o análisis previos deben vivir fuera de esta carpeta, por ejemplo en:

- `docs/reference/`
- `docs/prompts/`
- `docs/reports/`

Esos archivos sirven como contexto, pero **no** gobiernan la generación del código.

## Política de cambios

Cualquier modificación a estos documentos debe:

1. quedar versionada en Git;
2. reflejarse en los batches afectados;
3. revisarse antes de generar nuevo código;
4. mantener consistencia con el resto de la carpeta.

## Objetivo de esta carpeta

Esta carpeta existe para asegurar que el proyecto tenga una única fuente de verdad operativa, reduzca ambigüedad y permita que herramientas automatizadas generen código de manera consistente y trazable.
