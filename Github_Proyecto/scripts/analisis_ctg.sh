#!/bin/bash

#Anya Miranda 
#script que se separen las secuencias en tripletes, se marquen los codones CTG y se cuenten, además de tamaño de secuencia y porcentaje de codones en secuencia


# cargar config de rutas
source "$(dirname "${BASH_SOURCE[0]}")/config.sh"
#cargar la función de envío a telegram
source telegram.sh

# ==================
# Buscar archivo CDS 
# ===================
INPUT=$(find "$datos_descargados" -type f -name "*cds_from_genomic.fna" | head -n 1)

if [ -z "$INPUT" ]; then
    echo "ERROR: No se encontró cds_from_genomic.fna"
    enviar_telegram "Error: no se encontró archivo cds"
    exit 1
fi

echo "Archivo encontrado: $INPUT"
enviar_telegram "Archivo encontrado: $(basename "$INPUT")"

# ===============
# Definir output
# ===============
OUTPUT="$datos_procesados/resultados_ctg.fna"

# ===================
# Inicio de análisis
# ===================
enviar_telegram "Iniciando análisis CTG..."

# ===============================
# Procesamiento (tripletes + CTG)
# ================================

awk '
#para encontrar un encabezado FASTA/si ya había una secuencia analizar antes de pasar a la sig/print imprime encabezado/seq= reinicia secuencia para nuevo gen/next pasa a sig linea
/^>/ { if (seq) procesar(seq); print; seq=""; next }

#une todas las lineas en una sola secuencia para no romper marco de lectura
{ seq = seq $0 }

#al final del archivo procesa la última seq
END { if (seq) procesar(seq) }

#funcion para procesar cada gen/posicion/guarda triplete/cuenta/salida
function procesar(seq, i, codon, count, total, porcentaje, out) {

    count=0
    total=0
    out=""

#recorrer seq 3 en 3
    for (i=1; i<=length(seq); i+=3) {

        codon=substr(seq,i,3)

        #si codon completo
        if (length(codon)==3) {

            total++

            if (codon=="CTG") {
                out=out "[CTG] "
                count++
            } else {
                out=out codon " "
            }
        }
    }

 if (total > 0) {
        porcentaje = (count / total) * 100
    } else {
        porcentaje = 0
    }

#imprimir seq procesada
    print out
    print "#CTG_conteo=" count
    print "#Codones_totales=" total
    printf "#Frecuencia_CTG=%.4f%%\n", porcentaje
}
' "$INPUT" > "$OUTPUT"

# =====================
# Verificar resultado
# =====================
if [ ! -s "$OUTPUT" ]; then
    echo "Error en el procesamiento"
    enviar_telegram "Error en análisis CTG"
    exit 1
fi

echo "Archivo generado: $OUTPUT"
enviar_telegram "Análisis terminado. Archivo generado: $(basename "$OUTPUT")"