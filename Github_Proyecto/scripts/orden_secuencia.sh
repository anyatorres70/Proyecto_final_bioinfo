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
INPUT="$resultados/resultados_ctg.fna"

#=========
#inicio
#==========
echo "Ordenando IDs y cantidad de codones por tamaños"
send_telegram "Ordenando IDs y cantidad de codones por tamaños"

# ========================
# Contar encabezados FASTA
# ========================

echo "Número de secuencias:"
conteo=$(grep -c "^>" "$INPUT")
echo "$conteo"
send_telegram "Número de secuencias encontradas: $conteo"

# También podría hacerse así:
# grep "^>" "$ENTRADA" | wc -l

# =========================
# Extraer IDs y conteos
# =========================
# Queremos quedarnos SOLO con:
# >lcl|...
# #CTG_conteo=...

grep -E "(^>.+$|^#.+$)" "$INPUT" > "$datos_procesados/salida_1.txt"

echo "Archivo salida_1.txt creado"
send_telegram "salida_1.txt generado correctamente"

# =================================
# Extraer nombre del gen + conteo
# =================================
# Aquí obtenemos:
# DEHA2A00110g
# #CTG_conteo=12

grep -oE '(DEHA.+g]|^#.+$)' "$datos_procesados/salida_1.txt" > "$datos_procesados/salida_2.txt"

echo "Archivo salida_2.txt creado"
send_telegram "salida_2.txt generado correctamente"

# =======================================
# Unir nombre gen + conteo en una línea
# =======================================
# Convierte:
#
# DEHA2A00110g]
# #CTG_conteo=12
# en:
# DEHA2A00110g,12

sed 'N;s/]\n#CTG_conteo=/,/' "$datos_procesados/salida_2.txt" > "$datos_procesados/salida_3.txt"

echo "Archivo salida_3.txt creado"
send_telegram "salida_3.txt generado correctamente"

# ==========================
# Ordenar de mayor a menor
# ==========================

sort -t',' -k2,2nr "$datos_procesados/salida_3.txt" > "$datos_procesados/salida_ordenada.txt"

echo "Archivo salida_ordenada.txt creado"
send_telegram "salida_ordenada.txt generado correctamente"

# ========================= 
# Mostrar una lista de 50 
# =========================
head -n 50 "$datos_procesados/salida_ordenada.txt" > "$resultados/top50_ctg.txt"

echo "Archivo top50_ctg.txt creado en resultados"
send_telegram "Archivo top50_ctg.txt creado en resultados"