# Nexus-Kali APEX

> **Secure Pipeline Evaluation Core** — Framework Bash enterprise-grade para análisis dinámico de riesgo en scripts y automatización de seguridad.

## Requisitos

| Plataforma       | Versión mínima |
|------------------|----------------|
| Bash             | 5.0+           |
| Termux (Android) | 0.118+         |
| Kali Linux       | 2024.x+        |
| Ubuntu/Debian    | 22.04+/11+     |

## Estructura

```
nexus-kali-apex/
├── lib/           # Módulos del framework (L0-L6 + Pipeline)
├── bin/           # Ejecutables (nexusctl)
├── plugins/       # Sistema de plugins
├── schemas/       # JSON Schemas de contratos
├── scripts/       # Utilidades de build/deploy
├── tests/         # Tests (BATS + corpus)
├── config/        # Configuración por defecto
├── locale/        # i18n (en/es)
└── docs/          # Governance + ADR + API docs
```

## Governance

Los documentos en `docs/governance/` son la fuente de verdad:

| Documento | Propósito |
|-----------|-----------|
| `NEXUS_PREFIX_REGISTRY_v1.0.csv` | 342 funciones con nombre definitivo |
| `Nx-prefix-spec-v1.0.md` | Reglas de naming y convenciones |
| `NEXUS_WAVE_PLAN_v1.0.md` | Plan por Waves + criterios de aceptación |
| `NEXUS_EXECUTION_PROTOCOL_v1.0.md` | 25 batches en secuencia |
| `SPEC_Nexus_Kali_v1.0.md` | Contratos JSON, matemáticas, pipeline |

## Licencia

MIT © 2026
=======
# nexus-kali-apex
Created to store the nexus-kali project
