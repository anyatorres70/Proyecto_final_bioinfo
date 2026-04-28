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

#para cargar el token y el ID
source ../.env
#para cargar la función de envío a telegram
source telegram.sh

#variables
TAXID=284592
NOMBRE="Debaryomyces_hansenii"
ARCHIVO="${NOMBRE}.zip"

#=============
#inicio
#=============
echo "Descargando RefSeq para taxID: $TAXID"
send_telegram "Iniciando descarga RefSeq (taxID $TAXID)"

#========================================
#Evitar que se descargue varias veces
#======================================

if [ -d "${NOMBRE}" ]; then
    echo "Ya existe la carpeta de datos"
    send_telegram "Ya existían datos: ${NOMBRE}"
    exit 0
fi

# =============
# Descarga
# =============
datasets download genome taxon $TAXID \
    --assembly-source refseq \
    --filename ${ARCHIVO}

#===================================
# Verificar que ya está descargado
#===================================
if [ ! -s "${ARCHIVO}" ]; then
    echo "Error en la descarga"
    send_telegram "Error en descarga RefSeq (taxID $TAXID)"
    exit 1
fi

echo "Descarga completada"
send_telegram "Descarga completada: ${ARCHIVO}"

#===============
# Descomprimir
#================
unzip ${ARCHIVO} -d ${NOMBRE}

echo "Datos listos en carpeta: ${NOMBRE}"
send_telegram "📦 Descompresión lista: ${NOMBRE}"