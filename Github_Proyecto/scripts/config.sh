#!/bin/bash

#Anya Miranda 
#script de configuración de las rutas


# ==================
# Raíz del proyecto
# ==================
proyecto_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
#stack overflow

# ==========================================================================
# Directorios de las carpetas a donde quiero que se descarguen los archivos
# ===========================================================================
datos_descargados="$proyecto_DIR/datos/descargados"
datos_procesados="$proyecto_DIR/datos/procesados"
resultados="$proyecto_DIR/resultados"

# ================================
# Crear directorios si no existen
# =================================
mkdir -p "$datos_descargados"
mkdir -p "$resultados"