
#!/bin/bash

# Anya Miranda
# Conteo de codones de serina en Debaryomyces hansenii

set -euo pipefail

# ==========================
# Cargar configuración
# ==========================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

source "$SCRIPT_DIR/config.sh"
source "$SCRIPT_DIR/telegram.sh"

# ==========================
# Archivos de entrada y salida
# ==========================

ENTRADA="${1:-$datos_procesados/resultados_ctg.fna}"

FASTA_SERINAS="$datos_procesados/resultados_serinas.fna"
TABLA="$datos_procesados/ID-codones-serina-total.tsv"
TABLA_ORDENADA="$resultados/ID-codones-serina-total-ordenado.tsv"

# ==========================
# Verificar entrada
# ==========================

if [[ ! -f "$ENTRADA" ]]; then
    echo "ERROR: no se encontró el archivo $ENTRADA" >&2
    enviar_telegram "ERROR: no se encontró resultados_ctg.fna" || true
    exit 1
fi

mkdir -p "$datos_procesados" "$resultados"

enviar_telegram "Iniciando el conteo de codones de serina." || true

# ==========================
# Conteo de codones
# ==========================

awk \
    -v fasta_out="$FASTA_SERINAS" \
    -v tabla_out="$TABLA" '
BEGIN {
    OFS = "\t"

    print "gene_id", \
          "TCT", "TCC", "TCA", "TCG", "AGT", "AGC", "CTG", \
          "total_serina_estandar", "total_mas_CTG" > tabla_out

    close(tabla_out)
}

# Obtener el ID del gen desde la cabecera
function obtener_id(header,    id) {
    if (match(header, /\[locus_tag=[^]]+\]/)) {
        id = substr(header, RSTART, RLENGTH)
        sub(/^\[locus_tag=/, "", id)
        sub(/\]$/, "", id)
        return id
    }

    # Respaldo si no existe locus_tag
    sub(/^>/, "", header)
    split(header, campos, /[[:space:]]+/)
    return campos[1]
}

# Procesar una secuencia completa
function procesar(    sec, i, codon, id, total, total_ctg, longitud) {

    if (header == "")
        return

    # Eliminar espacios y los corchetes que marcan CTG.
    # Los tripletes originales se conservan en el archivo FASTA.
    sec = toupper(secuencia)
    gsub(/[[:space:]]/, "", sec)
    gsub(/\[|\]/, "", sec)
    gsub(/U/, "T", sec)

    longitud = length(sec)

    if (longitud == 0)
        return

    # Inicializar contadores
    for (i = 1; i <= 7; i++)
        cuenta[i] = 0

    # Contar tripletes desde el inicio de la CDS
    for (i = 1; i + 2 <= longitud; i += 3) {
        codon = substr(sec, i, 3)

        if      (codon == "TCT") cuenta[1]++
        else if (codon == "TCC") cuenta[2]++
        else if (codon == "TCA") cuenta[3]++
        else if (codon == "TCG") cuenta[4]++
        else if (codon == "AGT") cuenta[5]++
        else if (codon == "AGC") cuenta[6]++
        else if (codon == "CTG") cuenta[7]++
    }

    total = cuenta[1] + cuenta[2] + cuenta[3] + \
            cuenta[4] + cuenta[5] + cuenta[6]

    total_ctg = total + cuenta[7]
    id = obtener_id(header)

    # --------------------------
    # Archivo FASTA con conteos
    # --------------------------

    print ">" header > fasta_out

    # Mantener las líneas originales de la secuencia,
    # incluidos los CTG entre corchetes.
    n = split(lineas, partes, "\n")
    for (j = 1; j <= n; j++) {
        if (partes[j] != "")
            print partes[j] > fasta_out
    }

    print "#TCT_conteo=" cuenta[1] > fasta_out
    print "#TCC_conteo=" cuenta[2] > fasta_out
    print "#TCA_conteo=" cuenta[3] > fasta_out
    print "#TCG_conteo=" cuenta[4] > fasta_out
    print "#AGT_conteo=" cuenta[5] > fasta_out
    print "#AGC_conteo=" cuenta[6] > fasta_out
    print "#CTG_conteo=" cuenta[7] > fasta_out
    print "#Total_serina_estandar=" total > fasta_out
    print "#Total_mas_CTG=" total_ctg > fasta_out
    print "#Codones_completos=" int(longitud / 3) > fasta_out
    print "" > fasta_out

    close(fasta_out)

    # --------------------------
    # Tabla de resultados
    # --------------------------

    print id, \
          cuenta[1], cuenta[2], cuenta[3], cuenta[4], \
          cuenta[5], cuenta[6], cuenta[7], \
          total, total_ctg >> tabla_out

    close(tabla_out)

    registros++

    if (longitud % 3 != 0)
        longitudes_irregulares++

    header = ""
    secuencia = ""
    lineas = ""
}

# Nueva cabecera: procesar el registro anterior
/^>/ {
    procesar()
    header = substr($0, 2)
    secuencia = ""
    lineas = ""
    next
}

# Ignorar comentarios del archivo original, como:
#CTG_conteo=29
#Codones_totales=1408
#Frecuencia_CTG=2.0597%
/^#/ {
    next
}

# Acumular las líneas de secuencia
{
    if (header != "") {
        if (lineas == "")
            lineas = $0
        else
            lineas = lineas "\n" $0

        secuencia = secuencia $0
    }
}

END {
    procesar()

    print "Secuencias procesadas: " registros
    print "Secuencias con longitud no múltiplo de 3: " \
          longitudes_irregulares
}
' "$ENTRADA"

# ==========================
# Ordenar de mayor a menor
# ==========================

{
    head -n 1 "$TABLA"
    tail -n +2 "$TABLA" | sort -t $'\t' -k8,8nr
} > "$TABLA_ORDENADA"

# ==========================
# Notificaciones y resumen
# ==========================

echo "Análisis terminado."
echo "FASTA con conteos: $FASTA_SERINAS"
echo "Tabla de conteos: $TABLA"
echo "Tabla ordenada: $TABLA_ORDENADA"

enviar_telegram "Análisis de serinas terminado. Archivos guardados en datos/procesados: resultados_serinas.fna, ID-codones-serina-total.tsv e ID-codones-serina-total-ordenado.tsv." || true