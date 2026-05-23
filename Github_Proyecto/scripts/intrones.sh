#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/telegram.sh"

# ==========================
# Buscar archivo GFF
# ==========================

GFF=$(find "$datos_descargados" -type f -name "*.gff" | head -n 1)

if [ -z "$GFF" ]; then
    echo "ERROR: No se encontró archivo GFF"
    enviar_telegram "Error: no se encontró archivo GFF"
    exit 1
fi

echo "Archivo GFF encontrado: $GFF"
enviar_telegram "Archivo GFF encontrado: $(basename "$GFF")"

# ==========================
# Verificar patrón del organismo
# ==========================

if [ -z "$GEN_PATRON" ]; then
    echo "ERROR: No está definida GEN_PATRON en organismo.sh"
    enviar_telegram "Error: falta GEN_PATRON en organismo.sh"
    exit 1
fi

# ==========================
# Definir salida
# ==========================

OUTPUT="$resultados/intrones_genes.tsv"

# ==========================
# Detectar intrones
# ==========================

awk -F'\t' -v pattern="$GEN_PATRON" 'BEGIN{OFS="\t"; print "ID","Intrones"} $3=="exon"{id=""; split($9,a,";"); for(i in a){if(match(a[i],pattern)){id=substr(a[i],RSTART,RLENGTH)}} if(id!="") exon_count[id]++} END{for(id in exon_count){intrones=exon_count[id]-1; print id,intrones}}' "$GFF" > "$OUTPUT"

# ==========================
# Verificar resultado
# ==========================

if [ ! -s "$OUTPUT" ]; then
    echo "Error al generar archivo de intrones"
    enviar_telegram "Error al generar archivo de intrones"
    exit 1
fi

echo "Archivo generado: $OUTPUT"
enviar_telegram "Análisis de intrones terminado: $(basename "$OUTPUT")"