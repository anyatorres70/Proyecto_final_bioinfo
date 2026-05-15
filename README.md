# README
# Análisis del codón CTG en las secuencias del genoma de la levadura marina *Debaryomyces hansenii* (RefSeq)

## Introducción

La levadura marina *D. hansenii* es un organismo eurohalino, xero- y osmotolerante que ha estado teniendo un mayor foco e importancia dentro de los estudios de diferentes áreas científicas (1,2), incluidas la medicina, biotecnología, ciencias del mar e incluso evolución. Esto debido a su caracteristico uso del codón CTG, el cuál, a diferencia de casi todos los demás organismos, suele codificar para el aminoácido polar Serina en lugar del aminoácido hidrofóbico Leucina (3). 

Debido a esto, se clasifica dentro del clado CTG, en el cuál se pueden encontrar otras levaduras con características similares y que son más conocidas, como *Candida albicans*.
Muchos de los estudios que se han hecho con respecto a este uso del codón, se han llevado a cabo en *C. albicans* y se sabe que un 97% de las veces, el codón CTG codifica para Serina y solo un 3% de las veces lo hace para Leucina. Este uso ambiguo ocurre por la  tRNA<sub>CAG</sub><sup>Ser/Leu</sup>, que puede reconocer tanto a la Aminoacil tRNA sintetasa SerRS como a la LeuRS. Este cambio de uso tiene efectos en la levadura como aumento en la adaptación a condiciones de estrés ambiental, adhesión a superficies, formación de filamentos y mayor evasión del sistema inmune, lo que promueve una mayor virulencia en *C. albicans* (4). 

Ahora bien, estudios recientes han demostrado que la maquinaria del tRNA<sub>CAG</sub> de *D. hansenii* es casi idéntico al de *C. albicans*, por lo que se cree que el funcionamiento y uso ambiguo de este codón es muy parecido y puede tener repercusiones fisiológicas similares en *D. hansenii* (5).
Por lo tanto, conocer que genes tienen una mayor frecuencia de CTG, así como la posición que ocupa dentro de la secuencia es muy importante para comprender su posible impacto funcional. El que un gen presenta una gran cantidad de codones CTG podría aumentar la posibilidad de que ocurra incorporación ambigua de Ser o Leu durante la traducción, especialmente bajo condiciones de estrés, afectando la estructura y función de sus proteínas, lo que podría llegar a afectar su morfología y fisiología.

Este proyecto busca analizar secuencias genómicas de *D. hansenii* a partir de datos de RefSeq. El flujo de trabajo automatiza la descarga del genoma, la extracción de secuencias génicas individuales y su procesamiento para identificar especificamente codones CTG. 
En particular, se centra en la identificación y cuantificación del codón CTG dentro de cada gen. Se dividen las secuencias en tripletes (codones), cuenta la frecuencia de CTG por gen y permite identificar su posición dentro de las secuencias. Además de señalar el tamaño total de la secuencia y el porcentaje que tiene el codón CTG con respecto a su tamaño. Esto facilita el análisis de patrones de uso de codones y puede ser útil para analizar secuencias de otros organismos donde se interese reconocer codones especificos dentro de sus secuencias. 

Referencias
  1. Prista, C., C. Michán, I.M. Miranda, y J. Ramos. The halotolerant Debaryomyces hansenii, the Cinderella of non-conventional yeasts. Yeast, 2016; 33(10), 523-533. doi:10.1002/yea.3177
  2. Segal-Kischinevzky, C., L. Romero-Aguilar, L.D. Alcaraz, G. López-Ortiz, B. Martínez- Castillo, N. Torres-Ramírez, G. Sandoval and J. González. Yeasts Inhabiting Extreme Environments and Their Biotechnological Applications. Microorganisms, 2022; 10(4), 794.
  3. Breuer, U., y H. Harms. Debaryomyces hansenii — an extremophilic yeast with biotechnological potential. Yeast,2006; 23(6), 415-437. doi:10.1002/yea.1374
  4. Prista C, Michán C, Miranda IM, Ramos J. The halotolerant Debaryomyces hansenii, the Cinderella of non-conventional yeasts. Yeast. 2016;33(10):523-33. doi:10.1002/yea.3177 
  5. Ochoa-Gutiérrez, D., Reyes-Torres, A. M., de la Fuente-Colmenares, I., Escobar-Sánchez, V., González, J., Ortiz-Hernández, R., Torres-Ramírez, N. & Segal-Kischinevzky, C. Alternative CUG Codon Usage in the Halotolerant Yeast Debaryomyces hansenii: Gene Expression Profiles Provide New Insights into Ambiguous Translation. Journal of Fungi, 2022; 8(9), 970. doi:10.3390/jof8090970

## Objetivos

Hacer un script en bash que permita analizar la frecuencia del codón CTG en el genoma de *Debaryomyces hansenii*. 

Se automatizará la descarga del genoma (RefSeq) para después procesar las secuencias génicas dividiéndolas en tripletes (codones), se identificará y contabilizará la frecuencia del codón CTG en cada gen, el tamaño total de cada secuencia y el porcentaje de presencia con respecto a su tamaño. 
Finalmente se generará una salida que muestre, para cada gen, su identificador (ID), el número de codones CTG, la frecuencia relativa de CTG (%). Esto se encontrará ordenado en función de la cantidad de codones CTG (de mayor a menor frecuencia) y así poder seleccionar un grupo de genes con la mayor cantidad de codones CTG para análisis posteriores relacionados con expresión génica y respuesta a condiciones de estrés. 

## Descripción del flujo de trabajo

Se va a automatizar el análisis del codón CTG en el genoma de *D. hansenii* a partir de datos RefSeq. El flujo de trabajo sigue los siguientes pasos principales:

- Descarga de secuencias CDS: 
  
  Se descargan automáticamente las secuencias codificantes (CDS) del genoma de D. hansenii desde la base de datos RefSeq mediante la herramienta datasets de NCBI.

- Extracción y organización de secuencias: 
  
  Las secuencias génicas descargadas se organizan conservando los identificadores originales de cada gen.

- Procesamiento de secuencias: 
  
  Cada secuencia se une y divide en tripletes (codones) respetando el marco de lectura.

- Identificación y conteo de codones CTG: 
  
  Se encuentran todos los codones CTG presentes en cada gen, se calcula el número total de codones por secuencia y se marcan sus posiciones dentro de la secuencia.

- Cálculo de frecuencia relativa: 
  
  Para cada gen se tendrá su tamaño total y calcula el porcentaje de frecuencia del codón CTG con respecto al tamaño de su secuencia. 

- Organización y ordenamiento de resultados: 
  
  Se tendrá una salida con cuatro columnas: 
  - ID, Número de codones CTG, tamaño secuencia, Frecuencia relativa de CTG (%)
  Después se ordenan de acuerdo con la cantidad de codones CTG (de mayor a menor).

- Generación de salidas: 
  
  Se generan archivos de salida con la información procesada para su análisis posterior, incluyendo una lista completa de genes procesados y un archivo con el top 50 de genes con mayor número de codones CTG. 

## Estructura del repositorio

Proyecto_final_bioinfo/
│
Github_Proyecto/
│
├── README.md
├── datos/
│   ├── descargados/      # Archivos descargados desde RefSeq (.zip y CDS)
│   ├── procesados/       # Archivos intermedios generados durante el análisis
│
├── resultados/           # Resultados finales (listas)
│
├── scripts/
    ├── principal.sh       # script principal que ejecuta todo el flujo de trabajo
    ├── telegram.sh        # Script para enviar notificaciones a Telegram 
    ├── refseq.sh          # Descarga automática de secuencias CDS desde RefSeq
    ├── analisis_ctg.sh    # Procesamiento de secuencias, separación en codones y análisis de CTG
    ├── config.sh          # Configuración de rutas y directorios del proyecto
    ├── orden_secuencia.sh # Organización y ordenamiento de genes según frecuencia de CTG


Importante: Para poder usar `telegram.sh` es necesario configurar un archivo `.env` con el token del bot y el chat ID

## Requisitos de Software 

- Bash 3.2.57(1)
- curl
- grep 2.6.0 (para buscar patrones) 
- awk 20200816
- sed
- sort
- head
- find
- unzip
- datasets NCBI 18.24.0
- Homebrew 5.1.8

## Reproducibilidad 

Puede ejecutarse directamente en cualquier sistema Linux (o macOS) que cuente con las herramientas necesarias ya instaladas, no requiere la creación de entornos virtuales o contenedores.

La estructura del proyecto permite reproducir el análisis completo ejecutando solo el script principal (`principal.sh`), el cual automatiza la descarga de datos, el procesamiento de secuencias y la generación de resultados.

## Instrucciones de uso

- Clonar el repositorio
git clone https://github.com/anyatorres70/Proyecto_final_bioinfo.git

- Entrar al directorio del proyecto
cd Proyecto_final_bioinfo

- Ejecutar el pipeline
bash scripts/principal.sh

## Entradas y salidas

- Entradas: 
  
  Archivo FASTA con secuencias codificantes (CDS) de *D. hansenii* descargado desde RefSeq (NCBI Datasets) (cds_from_genomic.fna).
  

- Salidas: 


  datos/procesados/

  - resultados_ctg.fna:
  
      Archivo FASTA con las secuencias separadas por gen y divididas en tripletes, marcando el codón como [CTG]. Conteo del número de codones CTG por gen, cálculo del tamaño total por secuencia y cálculo del porcentaje de frecuencia del codón CTG con respecto al tamaño total.

  - encabezado+conteo.txt:
  
      Archivo .txt con los encabezados completos, el conteo de CTGs, codones totales y frecuencia relativa.

  - ID+conteo+total+porcentaje.txt:
  
      Archivo con el ID, el conteo de CTGs, codones totales y frecuencia relativa.
  
  - ID-codon-total-porcentaje.txt: 
  
      Archivo con lineas unidas de ID, conteo de CTGs, codones totales y frecuencia relativa.
  
  
  resultados/
  - salida_ordenada.txt: 
  
      Lista completa de genes ordenados de mayor a menor según la cantidad de codones CTG.

  - top50_ctg.txt: 
  
      Archivo con el top 50 de genes con mayor número de codones CTG.

    ## Ejemplo de salida

    - DEHA2G00110g,31,1459,2.1247
    - DEHA2A00110g,29,1409,2.0582
    - DEHA2G01276g,28,1409,1.9872

    Columnas (separadas por comas):

    1. ID del gen
    2. Número de codones CTG
    3. Número total de codones
    4. Frecuencia relativa de CTG (%)

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
  tiempo aproximado 2 min (para el genoma de *D. hansenii*)

## Autoría

*Anya Miranda Reyes Torres* 

