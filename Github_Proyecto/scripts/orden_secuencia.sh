#!/bin/bash
#script para ordenar ID+núm codones y ordenarlos de mayor a menor cantidad para seleccionar los genes con mayor frecuencia de codones CTG

# =====================
# Cargar configuración
# ======================
source "$(dirname "${BASH_SOURCE[0]}")/config.sh"

# ===================
# Archivo de entrada
# ===================
ENTRADA="$resultados/resultados_ctg.fna"

# ========================
# Contar encabezados FASTA
# ========================

echo "Número de secuencias:"
grep -c "^>" "$ENTRADA"

# También podría hacerse así:
# grep "^>" "$ENTRADA" | wc -l

# =========================
# Extraer IDs y conteos
# =========================
# Queremos quedarnos SOLO con:
# >lcl|...
# #CTG_conteo=...

grep -E "(^>.+$|^#.+$)" "$ENTRADA" > "$datos_procesados/salida_1.txt"

echo ""
echo "Archivo salida_1.txt creado"

# =================================
# Extraer nombre del gen + conteo
# =================================
# Aquí obtenemos:
# DEHA2A00110g
# #CTG_conteo=12

grep -oE '(DEHA.+g]|^#.+$)' "$datos_procesados/salida_1.txt" > "$datos_procesados/salida_2.txt"

echo "Archivo salida_2.txt creado"

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

# ==========================
# Ordenar de mayor a menor
# ==========================

sort -t',' -k2,2nr "$datos_procesados/salida_3.txt" > "$datos_procesados/salida_ordenada.txt"

echo "Archivo salida_ordenada.txt creado"

# ==================== 
# Mostrar resultados 
# ====================
echo ""
echo "Top 10 genes con más CTG:"
head "$datos_procesados/salida_ordenada.txt"