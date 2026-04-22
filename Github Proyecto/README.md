# README
# Análisis del codón CTG en las secuencias del genoma de la levadura marina *Debaryomyces hansenii* (RefSeq)

*Anya*

## Introducción

La levadura marina *D. hansenii* es un organismo eurohalino, xero- y osmotolerante que ha estado teniendo un mayor foco e importancia dentro de los estudios de diferentes áreas científicas, incluidas la medicina, biotecnología, ciencias del mar e incluso evolución. Esto debido a su caracteristico uso del codón CTG, el cuál, a diferencia de casi todos los demás organismos, suele codificar para el aminoácido polar Serina en luga del aminoácido hidrofóbico Leucina. 

Debido a esto, se clasifica dentro del clado CTG, en el cuál se pueden encontrar otras levaduras con características similares y que son más conocidas, como *Candida albicans*.
Muchos de los estudios que se han hecho con respecto a este uso del codón, se han llevado a cabo en *C. albicans* y se sabe que un 97% de las veces, el codón CTG codifica para Serina y solo un 3% de las veces lo hace para Leucina. Así mismo, que este uso ambiguo ocurre por la  tRNA<sub>CAG</sub><sup>Ser/Leu</sup>, que puede reconocer tanto a la Aminoacil tRNA sintetasa SerRS como a la LeuRS. Este cambio de uso tiene efectos en la levadura como aumento en la adaptación a condiciones de estrés ambiental, adhesión a superficies, formación de filamentos y mayor evasión del sistema inmune, lo que promueve una mayor virulencia en *C. albicans*. 

Ahora bien, estudios recientes han demostrado que la maquinaria del tRNA<sub>CAG</sub> de *D. hansenii* es casi idéntico al de *C. albicans*, por lo que se cree que el funcionamiento y uso ambiguo de este codón es muy parecido y puede tener repercusiones fisiológicas similares en *D. hansenii*.
Por lo tanto, conocer que genes tienen una mayor frecuencia de CTG, así como la posición que ocupa dentro de la secuencia es muy importante para comprender su posible impacto funcional. El que un gen presenta una gran cantidad de codones CTG podría aumentar la posibilidad de que ocurra incorporación ambigua de Ser o Leu durante la traducción, especialmente bajo condiciones de estrés, afectando la estructura y función de sus proteínas, lo que podría llegar a afectar su morfología y fisiología.

Este proyecto busca analizar secuencias genómicas de *D. hansenii* a partir de datos de RefSeq. El flujo de trabajo automatiza la descarga del genoma, la extracción de secuencias génicas individuales y su procesamiento para identificar especificamente codones CTG. 
En particular, se centra en la identificación y cuantificación del codón CTG dentro de cada gen. Se dividen las secuencias en tripletes (codones), cuenta la frecuencia de CTG por gen y permite identificar su posición dentro de las secuencias. Esto facilita el análisis de patrones de uso de codones y puede ser útil para analizar secuencias de otros organismos donde se interese reconocer codones especificos dentro de sus secuencias. 

## Objetivos

Explicar para qué sirve el script/flujo de trabajo

## Descripción del flujo de trabajo

Resumen de los pasos principales del análisis 

## Estructura del repositorio

Explicación breve de carpetas y archivos principales 

## Requisitos de Software 

Lista de programas usados con versiones y los comandos que usamos

## Reproducibilidad 

Indicar como preparar el ambiente para correr el análisis: si hay instalación manual, uso de micromamba, apptainer, etc. 

## Instrucciones de uso

Explicar paso a paso como ejecutar el programa
Ejemplo:

git clone https://github.com/usuario/proyecto_final.git
cd proyecto_final
bash scripts/pipeline.sh

## Entradas y salidas

Describir qué archivos recibe el análisis y qué archivos genera.

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

