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

TAXID=284592
NOMBRE="Debaryomyces_hansenii"

echo "Descargando RefSeq para taxID: $TAXID"

datasets download genome taxon $TAXID \
    --assembly-source refseq \
    --filename ${NOMBRE}.zip

# Verificar que ya está descargado
if [ -f "${NOMBRE}.zip" ]; then
    echo "Descarga completada"
else
    echo "Error en la descarga"
    exit 1
fi

# Descomprimir
unzip ${NOMBRE}.zip -d ${NOMBRE}

echo "Datos listos en carpeta: ${NOMBRE}"