#!/bin/bash
#script para ordenar ID+núm codones y ordenarlos de mayor a menor cantidad para seleccionar los genes con mayor frecuencia de codones CTG

# =====================
# Cargar configuración
# ======================
source "$(dirname "${BASH_SOURCE[0]}")/config.sh"
#cargar la función de envío a telegram
source telegram.sh

# ===================
# Archivo de entrada
# ===================
INPUT="$datos_procesados/resultados_ctg.fna"

#=========
#inicio
#==========
echo "Ordenando IDs y cantidad de codones por tamaños"
enviar_telegram "Ordenando IDs y cantidad de codones por tamaños"

# ========================
# Contar encabezados FASTA
# ========================

echo "Número de secuencias:"
conteo=$(grep -c "^>" "$INPUT")
echo "$conteo"
enviar_telegram "Número de secuencias encontradas: $conteo"

# También podría hacerse así:
# grep "^>" "$ENTRADA" | wc -l

# =========================
# Extraer IDs y conteos
# =========================
# Queremos quedarnos solo con:
# >lcl|...
# #CTG_conteo=...

grep -E "(^>.+$|^#.+$)" "$INPUT" > "$datos_procesados/encabezado+conteo.txt"

echo "Archivo encabezado/conteo.txt creado"
enviar_telegram "encabezado/conteo.txt creado correctamente"

# =================================
# Extraer nombre del gen + conteo
# =================================
# Aquí obtenemos:
# DEHA2A00110g
# #CTG_conteo=12
# #Codones_totales=1409
# #Frecuencia_CTG=2.0582%

grep -oE '(DEHA[^]]+g\]|^#CTG_conteo=.*$|^#Codones_totales=.*$|^#Frecuencia_CTG=.*$)' \
"$datos_procesados/encabezado+conteo.txt" \
> "$datos_procesados/ID+conteo+total+porcentaje.txt"

echo "Archivo ID/conteo/total/porcentaje.txt creado"
enviar_telegram "ID/conteo/total/porcentajeo.txt creado correctamente"

# =======================================
# Unir nombre gen + conteo en una línea + archivo tsv
# =======================================
# Convierte:
#
# DEHA2A00110g]
# #CTG_conteo=12
# #Codones_totales=1409
# #Frecuencia_CTG=2.0582%
# en:
# DEHA2A00110g,12,1409,2.0582

{ echo -e "ID\tCodón_CTG\tTamaño\tFrecuencia%"; sed -n '/^DEHA/{N;N;N;s/]\n#CTG_conteo=/\t/;s/\n#Codones_totales=/\t/;s/\n#Frecuencia_CTG=/\t/;p;}' "$datos_procesados/ID+conteo+total+porcentaje.txt"; } > "$datos_procesados/ID-codon-total-porcentaje.tsv"

echo "Archivo ID-codon-total-porcentaje.txt creado"
enviar_telegram "ID-codon-total-porcentaje.txt creado correctamente"

# =======================================
# Agregar columna de intrones
# =======================================

if [ ! -s "$resultados/intrones_genes.tsv" ]; then
    echo "ERROR: No se encontró intrones_genes.tsv"
    enviar_telegram "Error: no se encontró intrones_genes.tsv"
    exit 1
fi

awk -F'\t' 'BEGIN{OFS="\t"} NR==FNR{if(FNR>1) intrones[$1]=$2; next} FNR==1{print $0,"Intrones"; next} {if($1 in intrones) print $0,intrones[$1]; else print $0,0}' "$resultados/intrones_genes.tsv" "$datos_procesados/ID-codon-total-porcentaje.tsv" > "$datos_procesados/ID-codon-total-porcentaje-intrones.tsv"

echo "Archivo ID-codon-total-porcentaje-intrones.tsv creado"
enviar_telegram "Archivo con intrones agregado correctamente"

# ==========================
# Ordenar de mayor a menor
# ==========================

{ head -n 1 "$datos_procesados/ID-codon-total-porcentaje-intrones.tsv"; tail -n +2 "$datos_procesados/ID-codon-total-porcentaje-intrones.tsv" | sort -t$'\t' -k2,2nr; } > "$resultados/salida_ordenada.tsv"

echo "Archivo salida_ordenada.txt creado"
enviar_telegram "salida_ordenada.txt creado correctamente"

# ========================= 
# Mostrar una lista de 50 
# =========================
{ head -n 1 "$resultados/salida_ordenada.tsv"; tail -n +2 "$resultados/salida_ordenada.tsv" | head -n 50; } > "$resultados/top50_ctg.tsv"

echo "Archivo top50_ctg.txt creado en resultados"
enviar_telegram "Top 50 creado en resultados"

# ==================================
# Crear tabla alineada
# ==================================

awk -F'\t' '{printf "%-14s %-10s %-8s %-12s %-8s\n", $1, $2, $3, $4, $5}' "$resultados/top50_ctg.tsv" > "$resultados/top50_ctg_tabla.txt"

echo "Archivo top50_ctg_tabla.txt creado"
enviar_telegram "Tabla alineada creada correctamente"