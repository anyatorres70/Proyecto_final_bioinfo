#!/bin/bash

#Anya Miranda 
#script que descarga Refseq de NCBI

#Descargar primero datasets 
#curl -o datasets https://ftp.ncbi.nlm.nih.gov/pub/datasets/command-line/LATEST/mac/datasets
#chmod +x datasets
#sudo mv datasets /usr/local/bin/

# ==========================================
# Descargar RefSeq por taxID del organismo
# ===========================================

#para que los archivos se descarguen en datos/descargados
source "$(dirname "${BASH_SOURCE[0]}")/config.sh"
#para cargar la función de envío a telegram
source telegram.sh


#=========
#inicio
#==========
echo "Descargando RefSeq para taxID: $TAXID"
enviar_telegram "Iniciando descarga RefSeq (tax ID $TAXID)"

#========================================
#Evitar que se descargue varias veces
#======================================

if [ -d "${CARPETA}" ]; then
    echo "Ya existe la carpeta de datos"
    enviar_telegram "Ya existían datos: ${NOMBRE}"
    exit 0
fi

# =============
# Descarga
# =============
datasets download genome taxon "$TAXID" \
    --assembly-source refseq \
    --include cds,gff3 \
    --filename "$ARCHIVO"

#===================================
# Verificar que ya está descargado
#===================================
if [ ! -s "${ARCHIVO}" ]; then
    echo "Error en la descarga"
    enviar_telegram "Error en descarga RefSeq (taxID $TAXID)"
    exit 1
fi

echo "Descarga completada"
enviar_telegram "Descarga de datos completada"

#===============
# Descomprimir
#================
unzip "$ARCHIVO" -d "$CARPETA"

echo "Datos listos en carpeta: ${CARPETA}"
enviar_telegram "Archivo descomprimido en ${CARPETA}"