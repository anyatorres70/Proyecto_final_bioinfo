#!/bin/bash

#Anya Miranda 
#script que junta diferentes source para poder descargar una secuencia genomica por genes, separar cada secuencia en codones, marcar codones especificos (como CTG), contar la cantidad de codones que tiene cada uno y ordenarlos de mayor a menor cantidad de codones

# ===================
# Configuración rutas
# ====================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/telegram.sh"

# ==================
# Mensaje de inicio
# ==================
echo "Iniciando el análisis completo"
enviar_telegram "Iniciando el análisis completo"

# ==================
# Descargar RefSeq
# ==================
bash "$SCRIPT_DIR/refseq.sh"

if [ $? -ne 0 ]; then
    echo "Error en la descarga de RefSeq"
    enviar_telegram "Error en la descarga de RefSeq"
    exit 1

fi

# ==============
# Análisis CTG
# ==============
bash "$SCRIPT_DIR/analisis_ctg.sh"

if [ $? -ne 0 ]; then
    echo "Error en el análisis del codon CTG"
    enviar_telegram "Error en el análisis del codon CTG"
    exit 1

fi

# ==================
# Analisis intrones
# ==================
bash "$SCRIPT_DIR/intrones.sh"

if [ $? -ne 0 ]; then
    echo "Error en el análisis de intrones"
    enviar_telegram "Error en el análisis de intrones"
    exit 1
fi

# =====================
# Ordenar resultados
# =====================
bash "$SCRIPT_DIR/orden_secuencia.sh"

if [ $? -ne 0 ]; then
    echo "Error al ordenar las secuencias"
    enviar_telegram "Error al ordenar las secuencias"
    exit 1

fi

# ======
# Final
# ======
echo "Analisis terminado correctamente"
enviar_telegram "Analisis terminado correctamente"