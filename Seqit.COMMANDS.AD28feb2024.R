# Script R para generar los ficheros tabulados de entrada SeqIt. Realizado por Antonio Diaz-Perez (12mayo2021).
# Version: R version 4.0.3 (2020-10-10); WINDOWS
# SE DEBEN INSTALAR PREVIAMENTE LOS PAQUETE DE R "ape" (version: ape_5.4-1) y "stringr" (version: stringr_1.4.0)
# (NOTA: no incluyo tildes para evitar incompatibilidad)

# Pasos para ejecutar el script:

# 1) Fijar directorio de trabajo de R en la carpeta donde se ubican los ficheros de entrada (Windows: Archivo -> Cambiar dir...)
# 2) En dicha carpeta debe estar presentes los ficheros:
#       a) fichero de entrada fasta: Los nombres de las secuencias deben ser "Seq_XXXX", donde "XXXX" debe coincidir con Modifier "Bio_material": "JBCVC:DNABANK:XXXX"
#       b) fichero de entrada con los datos: Se obtiene de excel. Los campos deben estar separados por tabulaciones. Incluye las columnas en el siguiente orden de izquierda a derecha:
#          "locus", "especie", "colector(es)","fecha de colección", "código del Voucher", "localidad". ELIMINAR LA PRIMERA FILA CON LOS ENCABEZADOS DE COLUMNAS.
#          NO INCLUIR COMILLAS (") NI APOSTROFES (') DENTRO DE LOS CAMPOS. Los campos SI pueden incluir tilde; sin embargo, se debe guardar el archivo en formato "UTF-8".
#          Para tal fin: abra el fichero en "Block de Notas" y seleccione "guardar como", luego, en la parte de abajo cambie la codificación "ANSI" por "UTF-8". 
#       c) fichero con las funciones del script "Seqit.FUNCTIONS.AD28feb2024.txt" (NO MODIFICAR)
#       d) Este fichero.
# 3) En las filas de abajo, colocar los nombres de los ficheros de entrada, entre comillas:

#Fasta: (@@@@@@@@@@@@  INPUT)
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

fasta.file <- "fasta.txt"

#Datos: (@@@@@@@@@@@@  INPUT)
#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

data.file <- "data.txt"


# 4) Una vez colocados los nombres de los ficheros de entrada en las lineas de arriba, guardar las modificaciones y escribir o copiar y pegar la siguiente linea
#    en la ventana "R console" (o ventana principal donde se ejecutan los comandos). NOTA: no incluir la almohadilla de principio de linea.


# source("Seqit.COMMANDS.AD28feb2024.R")


# 5) El script genera tres ficheros:
#        a) "Seqit.fasta.OUT"
#        b) "Seqit.features.OUT"
#        c) "Seqit.modifiers.OUT"




###########################################################################################################################
# NO MODIFICAR LAS SIGUIENTES LINEAS
####################################

library(ape)
library(stringr)
source("Seqit.FUNCTIONS.AD28feb2024.R")
OUTPUT <- seqit.AD(data.file,fasta.file)




