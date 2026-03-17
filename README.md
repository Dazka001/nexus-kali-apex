# NEXUS-KALI APEX

## Framework de Seguridad Enterprise para Kali NetHunter

<p align="center">
  <img src="https://img.shields.io/badge/Versión-12.3%20%28Enterprise%20Grand%29-blue?style=for-the-badge&logo=bash" alt="Versión">
  <img src="https://img.shields.io/badge/Licencia-MIT-green?style=for-the-badge" alt="Licencia">
  <img src="https://img.shields.io/badge/Plataforma-Kali%20NetHunter-orange?style=for-the-badge" alt="Plataforma">
  <img src="https://img.shields.io/badge/Arquitectura-amd64%20%7C%20arm64%20%7C%20i386%20%7C%20armhf%20%7C%20riscv64-purple?style=for-the-badge" alt="Arquitectura">
</p>

---

## Tabla de Contenidos

1. [Descripción General](#1-descripción-general)
2. [Características Principales](#2-características-principales)
3. [Arquitectura del Sistema](#3-arquitectura-del-sistema)
4. [Estructura de Directorios](#4-estructura-de-directorios)
5. [Sistema de Credenciales](#5-sistema-de-credenciales)
6. [Componentes UI](#6-componentes-ui)
7. [Guía de Instalación](#7-guía-de-instalación)
8. [Guía de Uso](#8-guía-de-uso)
9. [Configuración](#9-configuración)
10. [Desarrollo y Contribución](#10-desarrollo-y-contribución)
11. [Estado del Proyecto](#11-estado-del-proyecto)
12. [Licencia y Soporte](#12-licencia-y-soporte)

---

## 1. Descripción General

### 1.1 Acerca del Proyecto

**NEXUS-KALI APEX** es un framework de seguridad enterprise de última generación diseñado específicamente para Kali NetHunter, con un enfoque en arquitecturas **100% Rootless** y cumplimiento **XDG-Compliant**.

El proyecto implementa un sistema modular de bibliotecas bash con gestión de dependencias mediante credenciales, permitiendo una carga ordenada y controlada de componentes del sistema.

### 1.2 Objetivo Principal

Proporcionar un framework extensible y mantenible para herramientas de seguridad que sea:

- **Compatible con rootless**: Funciona sin privilegios de root
- **Portable**: Multiple arquitectura soportada
- **Modular**: Sistema de carga por credenciales
- **Extensible**: Fácil incorporación de nuevos módulos

### 1.3 Versión Actual

```
Versión: 12.3 (Enterprise Grand)
Fecha de Lanzamiento: 2026
Código: Enterprise Grand v10.1+ Compliance
```

---

## 2. Características Principales

### 2.1 Características Core

| Característica | Descripción |
|---------------|-------------|
| **Sistema de Credenciales** | Carga de bibliotecas por capas NNN_*.sh con validación de criticidad |
| **Carga Diferida (Lazy Loading)** | Los componentes UI se cargan bajo demanda para optimizar rendimiento |
| **Shim Layer** | Compatibilidad hacia atrás con funciones legacy del sistema |
| **Detección de Arquitectura** | Identificación automática de la arquitectura del sistema |
| **XDG Compliance** | Cumplimiento total con XDG Base Directory Specification |

### 2.2 Módulos Integrados

El framework incluye múltiples módulos organizados por funcionalidad:

- **Core**: Funciones base, detección de arquitectura, manejo de errores
- **UI**: Sistema de colores, banners, diálogos, menús, progreso
- **Advanced**: Auto-audit, auto-healing, métricas, telemetría
- **Logging**: Sistema de logging avanzado con rotación
- **Network**: Utilidades de red y descargas
- **Database**: Utilidades de caché y base de datos
- **Process**: Automatización, backup, build, cola de trabajos
- **Utils**: Utilidades generales del sistema

### 2.3 Plataformas Soportadas

```
✓ amd64     (x86_64)
✓ arm64     (aarch64)
✓ i386      (x86)
✓ armhf     (ARM Hard Float)
✓ riscv64   (RISC-V 64-bit)
```

---

## 3. Arquitectura del Sistema

### 3.1 Diagrama de Componentes

```
┌─────────────────────────────────────────────────────────────────┐
│                        NEXUS-KALI APEX                          │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌──────────────┐     ┌──────────────┐     ┌──────────────┐  │
│  │   LAUNCHER   │────►│  MAIN        │────►│   MÓDULOS    │  │
│  │   (v12.3)    │     │  CONTROLLER  │     │   (lib/)     │  │
│  └──────────────┘     └──────────────┘     └──────────────┘  │
│         │                     │                    │          │
│         │              ┌──────┴──────┐           │          │
│         │              │             │           │          │
│         ▼              ▼             ▼           ▼          │
│  ┌────────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐  │
│  │ CREDENTIALS │  │  MENÚ    │  │   UI     │  │  CORE    │  │
│  │  LOADING   │  │ PRINCIPAL│  │SUBSYSTEM │  │ MODULES  │  │
│  └────────────┘  └──────────┘  └──────────┘  └──────────┘  │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

### 3.2 Flujo de Ejecución

```
┌────────────────────────────────────────────────────────────────┐
│                      launcher's.sh Flow                        │
├────────────────────────────────────────────────────────────────┤
│                                                                │
│  main()                                                       │
│    │                                                          │
│    ├─► load_libraries()                                       │
│    │       ├─► find lib/[0-9][0-9][0-9]_*.sh                │
│    │       ├─► sort by credential (ascending)                 │
│    │       └─► source each library                             │
│    │               ├─► Layer 0-1: Critical (abort on error)  │
│    │               └─► Layer 5+: Optional (warn + continue)   │
│    │               └─► Skip UI libs (lazy loading)           │
│    │                                                          │
│    ├─► initialize_subsystems()                                 │
│    │       └─► UI Subsystem (deferred)                        │
│    │       └─► Architecture Detection                           │
│    │                                                          │
│    └─► delegate_to_controller()                                │
│            └─► exec main_controller.sh                         │
│                    ├─► Verify dependencies                    │
│                    ├─► Parse CLI arguments                    │
│                    └─► Show main menu (interactive)           │
│                                                                │
└────────────────────────────────────────────────────────────────┘
```

### 3.3 Sistema de Dependencias (POD)

El sistema POD (Point of Dependencies) valida que cada biblioteca cumpla con sus dependencias antes de cargar:

```
Biblioteca A (requires: B, C)
    │
    ├─► Check: B loaded? ─► YES/NO
    └─► Check: C loaded? ─► YES/NO

    If NO ─► ERROR: Missing dependency
    If YES ─► Continue loading
```

---

## 4. Estructura de Directorios

### 4.1 Vista General

```
nx_050226_v2/
├── launcher.sh                 # Launcher principal v12.3
├── main_controller.sh         # Controlador principal con menús
├── README.md                  # Este archivo
├── DOCUMENTACION_CREDENCIALES.md  # Documentación técnica
│
├── lib/                       # Bibliotecas del sistema
│   ├── 000_logger.sh         # Logger stub (Capa 0 - CRÍTICO)
│   │
│   ├── ui/                   # Componentes UI (Capa 5)
│   │   ├── 500_colors.sh     # Sistema de colores ANSI
│   │   ├── 501_init.sh       # Orquestador UI + Shim Layer
│   │   ├── 505_banners.sh   # Banners ASCII art
│   │   ├── 510_dialogs.sh   # Componentes de diálogos
│   │   ├── 515_menus.sh     # Sistema de menús
│   │   └── 520_progress.sh  # Barras de progreso
│   │
│   ├── core/                 # Módulos core (10 archivos)
│   │   ├── arch_detector.sh  # Detección de arquitectura
│   │   ├── bootstrap.sh      # Inicialización
│   │   ├── error_handler.sh # Manejo de errores
│   │   ├── module_loader.sh # Loader de módulos
│   │   ├── security_core.sh  # Funciones de seguridad
│   │   ├── validator.sh     # Validador de entradas
│   │   ├── xdg_paths.sh     # Rutas XDG
│   │   └── ...
│   │
│   ├── advanced/             # Módulos advanced (16 archivos)
│   │   ├── api_gateway.sh
│   │   ├── auto_audit.sh
│   │   ├── auto_healing.sh
│   │   ├── metrics_kpi.sh
│   │   ├── plugin_system.sh
│   │   └── ...
│   │
│   ├── config/               # Módulos de configuración
│   ├── db/                  # Módulos de base de datos
│   ├── deps/                # Gestión de dependencias
│   ├── enterprise/           # Funciones enterprise
│   ├── logging/              # Sistema de logging
│   ├── net/                 # Utilidades de red
│   ├── plugins/              # Sistema de plugins
│   ├── process/              # Utilidades de procesos
│   ├── utils/                # Utilidades generales
│   └── validation/           # Validación de entradas
│
├── scripts/                  # Scripts de utilidad (29 archivos)
│   ├── nexus_diagnostics.sh
│   ├── integrity_check.sh
│   └── ...
│
└── test/                     # Tests (2 archivos)
    ├── test_utils.sh
    └── run_benchmarks.sh
```

### 4.2 Descripción de Archivos Principales

| Archivo | Descripción |
|---------|-------------|
| `launcher.sh` | Launcher minimalista que carga bibliotecas por credenciales |
| `main_controller.sh` | Controlador principal que maneja el flujo del menú |
| `lib/000_logger.sh` | Logger stub para dependencias de componentes UI |
| `lib/ui/501_init.sh` | Orquestador UI con sistema de carga dinámica |
| `lib/core/arch_detector.sh` | Detección automática de arquitectura |

---

## 5. Sistema de Credenciales

### 5.1 Concepto de Credenciales

El sistema de credenciales utiliza un esquema de nomenclatura `NNN_nombre.sh` donde:

- **NNN** = Número de 3 dígitos que representa la capa
- **nombre** = Nombre descriptivo de la biblioteca

### 5.2 Niveles de Criticidad

| Rango | Nivel | Comportamiento |
|-------|-------|----------------|
| 000-099 | CRÍTICO | Aborta ejecución si falla |
| 100-499 | ALTA | Advertencia pero continúa |
| 500-999 | OPCIONAL | Carga diferida / skip |

### 5.3 Ejemplo de Carga

```bash
# Bibliotecas cargadas actualmente
[000] ✓ 000_logger.sh       # Capa 0 - CRÍTICO
[500] ✓ 500_colors.sh       # Capa 5 - Colores
[501] ✓ 501_init.sh         # Capa 5 - Orquestador
[505] ✓ 505_banners.sh     # Capa 5 - Banners
[510] ⊘ 510_dialogs.sh     # Capa 5 - DIFERIDO
[515] ⊘ 515_menus.sh       # Capa 5 - DIFERIDO
[520] ⊘ 520_progress.sh    # Capa 5 - DIFERIDO

Bibliotecas cargadas: 4
```

### 5.4 Variables de Entorno de Control

```bash
# Variables de Guard (previenen unbound variable errors)
export _COLORS_LOADED_=""
export _BANNERS_LOADED_=""
export _DIALOGS_LOADED_=""
export _MENUS_LOADED_=""
export _PROGRESS_LOADED_=""

# Variables de Configuración
export NK_COLORS_NO_AUTOINIT="1"  # Deshabilita auto-inicialización
export NEXUS_SKIP_UI="0"          # Control de UI
export NEXUS_SKIP_SELFTEST="1"   # Omite self-test
export NO_COLOR=""                # Compatibilidad estándar

# Variables de Estado
export NEXUS_BASE_DEPENDENCIES_LOADED="true"
export NEXUS_LIBS="/path/to/lib"
export NEXUS_UI_BACKEND="terminal"
```

---

## 6. Componentes UI

### 6.1 Sistema de Colores (500_colors.sh)

Provee gestión completa de colores ANSI:

- 16 colores básicos + 256 colores extendidos
- Paletas predefinidas
- Temas (default, dark, high_contrast)
- Funciones principales:
  - `nk_colors_get_code()`
  - `nk_colors_apply()`
  - `nk_colors_set_theme()`

### 6.2 Orquestador UI (501_init.sh)

Carga dinámica de componentes y Shim Layer:

- Detección automática de backend (dialog, whiptail, fzf, terminal)
- Funciones principales:
  - `nexus_ui_load_component()`
  - `init_ui_system()`

### 6.3 Banners (505_banners.sh)

Sistema de presentación visual:

- Banners ASCII art predefinidos
- Diseño enterprise profesional

### 6.4 Diálogos, Menús y Progreso

**Estado: DIFERIDO** (problemas de compatibilidad con `set -u`)

Estos componentes se cargan bajo demanda cuando el sistema los requiere.

---

## 7. Guía de Instalación

### 7.1 Requisitos Previos

```
✓ Bash 4.0+
✓ Unix/Linux (Kali NetHunter, Termux, etc.)
✓ Permisos de ejecución
```

### 7.2 Pasos de Instalación

```bash
# 1. Clonar o copiar el proyecto
cd /path/to/nx_050226_v2

# 2. Dar permisos de ejecución
chmod +x launcher.sh

# 3. Ejecutar el launcher
./launcher.sh
```

### 7.3 Verificación de Instalación

```bash
# Ejecutar con opción de información
./launcher.sh --info

# Verificar bibliotecas cargadas
./launcher.sh --show-libraries

# Ejecutar auto-diagnóstico
./launcher.sh --selftest
```

---

## 8. Guía de Uso

### 8.1 Ejecución Básica

```bash
# Menú interactivo (por defecto)
./launcher.sh

# Mostrar ayuda
./launcher.sh --help

# Información del sistema
./launcher.sh --info

# Auto-diagnóstico
./launcher.sh --selftest

# Modo debug
./launcher.sh --debug
```

### 8.2 Menú Principal

```
╔═══════════════════════════════════════════════════════════════╗
║              NEXUS-KALI APEX - Menú Principal             ║
╚═══════════════════════════════════════════════════════════════╝
  1. Herramientas de Reconocimiento
  2. Herramientas de Explotación
  3. Herramientas de Post-Explotación
  4. Configuración del Sistema
  5. Información del Sistema
  6. Auto-Diagnóstico
  0. Salir
```

### 8.3 Opciones CLI Disponibles

| Opción | Descripción |
|--------|-------------|
| `-h, --help` | Mostrar ayuda |
| `-v, --version` | Mostrar versión |
| `-i, --info` | Información del sistema |
| `--menu` | Mostrar menú principal |
| `--selftest` | Ejecutar auto-diagnóstico |
| `--verify-xdg` | Verificar XDG compliance |
| `--verify-load-order` | Verificar orden de carga |
| `--show-libraries` | Mostrar bibliotecas cargadas |
| `--debug` | Modo debug |

---

## 9. Configuración

### 9.1 Variables de Entorno

El sistema puede configurarse mediante variables de entorno:

```bash
# Nivel de logging
export NEXUS_LOG_LEVEL="DEBUG|INFO|WARN|ERROR"

# Archivo de log
export NEXUS_LOG_FILE="/path/to/logfile"

# Forzar modo sin colores
export NO_COLOR="1"

# Saltar verificación de XDG
export NEXUS_SKIP_XDG_CHECK="1"
```

### 9.2 Configuración de Rutas XDG

El framework cumple con XDG Base Directory Specification:

```
$XDG_CONFIG_HOME  (default: ~/.config)
$XDG_DATA_HOME    (default: ~/.local/share)
$XDG_CACHE_HOME   (default: ~/.cache)
```

### 9.3 Personalización de UI

```bash
# Backend de diálogo preferido
export NEXUS_UI_BACKEND="dialog|whiptail|fzf|terminal"

# Tema de colores
export NK_COLOR_THEME="default|dark|high_contrast"
```

---

## 10. Desarrollo y Contribución

### 10.1 Estructura de Bibliotecas

Para agregar una nueva biblioteca al sistema:

```bash
# Nombre del archivo: NNN_nombre.sh
# NNN = número de credencial (001-999)

# Ejemplo: lib/utils/100_mi_utilidad.sh
#!/usr/bin/env bash
# Mi Utilidad v1.0.0

# Guard para evitar carga múltiple
[[ -n "${__MI_UTILIDAD_LOADED:-}" ]] && return 0
readonly __MI_UTILIDAD_LOADED=1

# Tu código aquí...
mi_funcion() {
    echo "Hola desde mi utilidad"
}
```

### 10.2 Agregar al Menú

Para agregar una nueva opción al menú principal, editar `main_controller.sh`:

```bash
# Agregar en la función del menú
"7) Mi Nueva Herramienta")
    mi_nueva_funcion
    ;;
```

### 10.3 Testing

```bash
# Ejecutar todos los tests
./test/run_benchmarks.sh

# Ejecutar test de loader
./scripts/test_module_loader.sh
```

---

## 11. Estado del Proyecto

### 11.1 Estado de Implementación

| Componente | Estado | Notas |
|------------|--------|-------|
| Launcher minimalista | ✅ Completado | Funciona correctamente |
| Sistema de credenciales | ⚠️ Parcial | Solo carga básica |
| Componentes UI | ⚠️ Parcial | 4/7 funcionando |
| Carga diferida | ✅ Completado | 3 bibliotecas diferidas |
| Shim Layer | ✅ Completado | Funciones legacy mapeadas |

### 11.2 Problemas Conocidos

| Problema | Severidad | Estado |
|---------|-----------|--------|
| UI libraries (510/515/520) tienen errores de readonly | MEDIA | Pendiente |
| Detección de arquitectura no funcional | BAJA | Pendiente |
| Menú timeout en entrada interactiva | MEDIA | Pendiente |

### 11.3 Trabajo Pendiente

1. Corregir carga de bibliotecas UI (510/515/520)
2. Integrar detección de arquitectura completa
3. Completar sistema de credenciales con metadata.json
4. Implementar verificación de checksums
5. Agregar tests unitarios completos

---

## 12. Licencia y Soporte

### 12.1 Licencia

```
MIT License

Copyright (c) 2026 NEXUS-KALI APEX
```

### 12.2 Autores

- **NEXUS-KALI APEX Team** - Equipo de desarrollo principal
- **Enterprise Software Architecture Team** - Arquitectura enterprise

### 12.3 Recursos Adicionales

| Recurso | Enlace |
|----------|--------|
| Documentación Técnica | `DOCUMENTACION_CREDENCIALES.md` |
| Diagnósticos | `./scripts/nexus_diagnostics.sh` |
| Verificación de Integridad | `./scripts/integrity_check.sh` |

### 12.4 Contacto y Contribuciones

Para reportar bugs o contribuir al proyecto:

1. Fork del repositorio
2. Crear branch feature (`git checkout -b feature/AmazingFeature`)
3. Commit cambios (`git commit -m 'Add AmazingFeature'`)
4. Push al branch (`git push origin feature/AmazingFeature`)
5. Abrir Pull Request

---

## Anexo: Glosario

| Término | Definición |
|---------|------------|
| **Credential** | Número de 3 dígitos (NNN) que identifica la capa de una biblioteca |
| **Shim Layer** | Capa de compatibilidad que mapea funciones legacy a funciones actuales |
| **Lazy Loading** | Patrón de diseño que carga recursos bajo demanda |
| **POD** | Point of Dependencies - Punto de validación de dependencias |
| **XDG** | XDG Base Directory Specification - Estándar de rutas de archivos |
| **Rootless** | Sistema que funciona sin privilegios de root |
| **Enterprise Grand** | Nivel de calidad enterprise del framework |

---

<p align="center">
  <strong>NEXUS-KALI APEX v12.3 (Enterprise Grand)</strong><br>
  100% Rootless | XDG-Compliant | Sistema de Credenciales
</p>

*Documento generado automáticamente para NEXUS-KALI APEX Enterprise Grand Framework v12.3+*
![101902](https://github.com/user-attachments/assets/6e2034dd-6d8f-4ade-8791-c641171cc450)
