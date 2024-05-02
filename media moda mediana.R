############################################
# Mediana, moda y distribución de datos                                 
############################################

# Acciones a realizar en el Script ----------------------------------------
# 1. Generar media, mediana y moda de columna de interés
# 2. Generar conteo de casos por periodo de interés




#################################
# 2.1.3 INSTALAR Y CARGAR LIBRERIAS

## Instalar librerías
# Quitar el signo de gato y correr, sólo la primera vez que se utilice el paquete en la computadora
#install.packages("readr")
#install.packages("tidyverse")
#install.packages("janitor")
#install.packages("modeest")


## Activar librerías
library(readr)
library(tidyverse)
library(janitor)
library(modeest)

# Desde archivos separados por delimitador (como CSV)
delitos <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/carpetas_2023.csv") # Al nombrar el archivo es necesario colocar toda la ruta o de lo contrario su nombre siempre y cuando este almacenado en la misma carpeta/directorio donde estoy trabajando
clean_names(delitos)
View(delitos) # Me muestra mi base de datos


# Generar media, mediana y moda de columna de interés ---------------------
#elegimos una columna que contenga valores numéricos

#revisamos que la columna edad tenga datos numéricos o integros
class(delitos$edad)

#Calcular la media redondeada a cero decimales
media <- round(mean(delitos$edad, na.rm = T), 0)
media #se muestra el resultado

#Calcular la mediana
mediana <- median(delitos$edad, na.rm = T)
mediana #se muestra el resultado

#Calcular la moda
moda <- mlv(delitos$edad, na.rm = T)
moda #se muestra el resultado

#Mostramos los tres datos:

print(paste0("Las medidas de tendencia central son: ", 
                    "media ", media, ", mediana ", mediana, ", moda ", moda))


#Contamos cuántos casos hay por categoría
#En este ejemplo por edad
frequency <- delitos %>%
  count(edad)
frequency



