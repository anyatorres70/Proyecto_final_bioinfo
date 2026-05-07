#!/bin/bash

#Anya Miranda 
#script que se separen las secuencias en tripletes, se marquen los codones CTG y se cuenten


# cargar config de rutas
source "$(dirname "${BASH_SOURCE[0]}")/config.sh"
#cargar el token y el ID
source ../.env
#cargar la función de envío a telegram
source telegram.sh

# ===================================
# Buscar archivo CDS automáticamente
# ===================================
INPUT=$(find "$datos_descargados" -type f -name "*cds_from_genomic.fna" | head -n 1)

if [ -z "$INPUT" ]; then
    echo "ERROR: No se encontró cds_from_genomic.fna"
    send_telegram "Error: no se encontró archivo cds"
    exit 1
fi

echo "Archivo encontrado: $INPUT"
send_telegram "Archivo encontrado: $(basename "$INPUT")"

# ===============
# Definir output
# ===============
OUTPUT="$datos_procesados/resultados_ctg.fna"

# ===================
# Inicio de análisis
# ===================
send_telegram "Iniciando análisis CTG..."

# ===============================
# Procesamiento (tripletes + CTG)
# ================================

awk '
# ===========================================
# Encontrar un encabezado FASTA (nuevo gen)
# ============================================
/^>/ {

    # Si ya había una secuencia previa guardada,la procesamos antes de pasar al siguiente gen
    if (seq) {
        procesar(seq)
    }

    # Imprime el encabezado (>gene_id ...)
    print

    # Reinicia la secuencia para el nuevo gen
    seq = ""

    # Pasa a la siguiente línea
    next
}

# =====================
# Líneas de secuencia
# =====================
{
    # Une todas las líneas del gen en una sola secuencia continua, (IMPORTANTE para no romper el marco de lectura)
    seq = seq $0
}

# =====================
# Al final del archivo
# =====================
END {
    # Procesa la última secuencia (el último gen)
    if (seq) {
        procesar(seq)
    }
}

# ================================
# Función para procesar cada gen
# ================================
function procesar(seq,   i, codon, count, out) {

    count = 0
    out = ""

    # recorrer la secuencia en pasos de 3 (frame correcto)
    for (i = 1; i <= length(seq); i += 3) {

        codon = substr(seq, i, 3)

        # si el codón está completo
        if (length(codon) == 3) {

            if (codon == "CTG") {
                out = out "[CTG] "
                count++
            } else {
                out = out codon " "
            }
        }
    }

    # imprimir secuencia procesada
    print out

    # imprimir conteo real
    print "#CTG_conteo="count
}
' "$INPUT" > "$OUTPUT"

# =====================
# Verificar resultado
# =====================
if [ ! -s "$OUTPUT" ]; then
    echo "Error en el procesamiento"
    send_telegram "Error en análisis CTG"
    exit 1
fi

echo "Archivo generado: $OUTPUT"
send_telegram "Análisis terminado. Archivo generado: $(basename "$OUTPUT")"