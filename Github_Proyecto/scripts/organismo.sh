#!/bin/bash

# ==========================
# Organismo
# ==========================

TAXID=284592
NOMBRE="Debaryomyces_hansenii"

# ==========================
# Patrón de IDs génicos
# ==========================

GEN_PATRON='DEHA[^]]+g'

# ==========================
# Codón de interés
# ==========================

CODON="CTG"

# Nombre corto para archivos/salidas
CODON_NOMBRE="CTG"

# ==========================
# Archivos
# ==========================

ARCHIVO="$datos_descargados/${NOMBRE}.zip"
CARPETA="$datos_descargados/${NOMBRE}"