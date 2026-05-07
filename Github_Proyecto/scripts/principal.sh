#!/bin/bash

#Anya Miranda 
#script que junta diferentes source para poder descargar una secuencia genomica por genes, separar cada secuencia en codones, marcar codones especificos (como CTG), contar la cantidad de codones que tiene cada uno y ordenarlos de mayor a menor cantidad de codones

# ================
# Ruta del script
# ================
script_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ==========================
# Cargar config y telegram
# ==========================
source "$script_DIR/config.sh"
source "$script_DIR/../.env"
source "$script_DIR/telegram.sh"

# =================
# Inicio analisis
# =================
echo "Iniciando analisis completo"
send_telegram "Iniciando analisis completo"

# ==================
# Paso 1: Descarga
# ==================
echo "Paso 1: Descarga RefSeq"
bash "$script_DIR/refseq.sh"

if [ $? -ne 0 ]; then
    echo "Error en descarga"
    send_telegram "Error en descarga RefSeq"
    exit 1
fi

# ======================
# Paso 2: Análisis CTG
# ======================
echo "Paso 2: Análisis CTG"
bash "$script_DIR/analisis_ctg.sh"

if [ $? -ne 0 ]; then
    echo "Error en análisis"
    send_telegram "Error en análisis CTG"
    exit 1
fi

# ==============
# Fin analisis
# ==============
echo "Analisis completado correctamente"
send_telegram "Analisis completado con éxito"
