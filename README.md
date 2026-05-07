# README
# Análisis del codón CTG en las secuencias del genoma de la levadura marina *Debaryomyces hansenii* (RefSeq)

## Introducción

La levadura marina *D. hansenii* es un organismo eurohalino, xero- y osmotolerante que ha estado teniendo un mayor foco e importancia dentro de los estudios de diferentes áreas científicas, incluidas la medicina, biotecnología, ciencias del mar e incluso evolución. Esto debido a su caracteristico uso del codón CTG, el cuál, a diferencia de casi todos los demás organismos, suele codificar para el aminoácido polar Serina en luga del aminoácido hidrofóbico Leucina. 

Debido a esto, se clasifica dentro del clado CTG, en el cuál se pueden encontrar otras levaduras con características similares y que son más conocidas, como *Candida albicans*.
Muchos de los estudios que se han hecho con respecto a este uso del codón, se han llevado a cabo en *C. albicans* y se sabe que un 97% de las veces, el codón CTG codifica para Serina y solo un 3% de las veces lo hace para Leucina. Así mismo, que este uso ambiguo ocurre por la  tRNA<sub>CAG</sub><sup>Ser/Leu</sup>, que puede reconocer tanto a la Aminoacil tRNA sintetasa SerRS como a la LeuRS. Este cambio de uso tiene efectos en la levadura como aumento en la adaptación a condiciones de estrés ambiental, adhesión a superficies, formación de filamentos y mayor evasión del sistema inmune, lo que promueve una mayor virulencia en *C. albicans*. 

Ahora bien, estudios recientes han demostrado que la maquinaria del tRNA<sub>CAG</sub> de *D. hansenii* es casi idéntico al de *C. albicans*, por lo que se cree que el funcionamiento y uso ambiguo de este codón es muy parecido y puede tener repercusiones fisiológicas similares en *D. hansenii*.
Por lo tanto, conocer que genes tienen una mayor frecuencia de CTG, así como la posición que ocupa dentro de la secuencia es muy importante para comprender su posible impacto funcional. El que un gen presenta una gran cantidad de codones CTG podría aumentar la posibilidad de que ocurra incorporación ambigua de Ser o Leu durante la traducción, especialmente bajo condiciones de estrés, afectando la estructura y función de sus proteínas, lo que podría llegar a afectar su morfología y fisiología.

Este proyecto busca analizar secuencias genómicas de *D. hansenii* a partir de datos de RefSeq. El flujo de trabajo automatiza la descarga del genoma, la extracción de secuencias génicas individuales y su procesamiento para identificar especificamente codones CTG. 
En particular, se centra en la identificación y cuantificación del codón CTG dentro de cada gen. Se dividen las secuencias en tripletes (codones), cuenta la frecuencia de CTG por gen y permite identificar su posición dentro de las secuencias. Esto facilita el análisis de patrones de uso de codones y puede ser útil para analizar secuencias de otros organismos donde se interese reconocer codones especificos dentro de sus secuencias. 

## Objetivos

Hacer un script en bash que permita analizar el uso del codón CTG en el genoma de *Debaryomyces hansenii*. Se automatizará la descarga del genoma (RefSeq) para después procesar las secuencias génicas dividiéndolas en tripletes (codones), se identificará y contabilizará la frecuencia del codón CTG en cada gen, y se generará una salida que muestre, para cada gen, su secuencia, número de codones CTG y localización, para poder ordenar los genes en función de la cantidad de codones CTG (de mayor a menor frecuencia) y así poder seleccionar un grupo de genes con la mayor cantidad de codones CTG y estudiar si hay cambios en la expresión de estos en diferentes condiciones de estrés. 

## Descripción del flujo de trabajo

Se va a automatizar el análisis del codón CTG en el genoma de *D. hansenii* a partir de datos RefSeq. El flujo de trabajo sigue los siguientes pasos principales:

- Descarga del genoma: Se obtiene el archivo del genoma de *D. hansenii* desde la base de datos RefSeq.
- Extracción de genes: Se e procesan los archivos descargados para extraer las secuencias individuales de cada gen, conservando sus identificadores.
- Procesamiento de secuencias: Cada secuencia se divide en tripletes (codones) respetando el marco de lectura.
- Identificación de codones CTG: Se buscan todos los codones CTG dentro de cada secuencia.
- Conteo y localización: Se cuenta el número de codones CTG por gen y se registran sus posiciones dentro de la secuencia.
- Organización de resultados: Los genes se ordenan de acuerdo con la cantidad de codones CTG (de mayor a menor).
- Generación de salidas: Se generan archivos de salida con la información procesada para su análisis posterior.

## Estructura del repositorio

Proyecto_final_bioinfo/
│
├── README.md
├── datos/
│   ├── descargados/      # Datos descargados desde RefSeq y .zip
│
├── resultados/           # Resultados finales (conteos, posiciones, lista)
│
├── scripts/
    ├── principal.sh      # Script principal del flujo de trabajo
    ├── telegram.sh       # Script para recibir mensajes en telegram
    ├── refseq.sh         # Script para descarga de datos desde RefSeq
    ├── analisis_ctg.sh   # Alinear secuencias, separar en codones, marcar y contar codones
    ├── config.sh         # Decir en que carpeta dejar las desacargas/resultados de analisis



## Requisitos de Software 

- Bash 3.2.57(1)
- curl o wget (para descarga de datos)
- grep 2.6.0 (para buscar patrones) 
- awk 20200816
- sed
- datasets NCBI 18.24.0
- Homebrew 5.1.8

## Reproducibilidad 

Puede ejecutarse directamente en cualquier sistema Linux (o macOS) que cuente con las herramientas necesarias ya instaladas, no requiere la creación de entornos virtuales o contenedores.

## Instrucciones de uso

#Clonar el repositorio
git clone https://github.com/anyatorres70/Proyecto_final_bioinfo.git

#Entrar al directorio del proyecto
Proyecto_final_bioinfo

#Dar permisos de ejecución (si es necesario)
chmod +x scripts/principal.sh

#Ejecutar el pipeline
bash scripts/principal.sh

## Entradas y salidas

- Entradas: Archivo del genoma de *D. hansenii* descargado desde RefSeq (FASTA).
- Salidas: Archivos con secuencias separadas por gen, secuencias divididas en tripletes, conteo del número de codones CTG por gen, posiciones de los codones CTG dentro de cada secuencia, lista de genes ordenados por cantidad de codones CTG (de mayor a menor), reportes finales en formato de texto para análisis posterior.

## Información del sistema

- #### Tipo de equipo:
  Laptop, Apple Macbook Air M1

- #### Sistema operativo:
  macOS Tahoe 26.2

- #### CPU:
  MacBook Air
  8 CPU (4 de rendimiento y 4 de eficiencia) + 1 hilo por núcleo.

- #### Memoria RAM:
  8 GB
  LPDDR4

- #### GPU:
  Integrado, Apple M1

- #### Almacenamiento:
  SSD, 256 GB

- #### Tiempo de ejecución: 

## Autoría

*Anya Miranda Reyes Torres* 

