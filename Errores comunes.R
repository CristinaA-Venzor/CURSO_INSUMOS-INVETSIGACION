############################################
# Errores comunes en el registro de información 
############################################


# Acciones a realizar en el Script ----------------------------------------
# 1. Limpiar nombres de columnas a formato estándar
# 2. Identificar número de valores faltantes por columnas
# 3. ELiminar columna con más del 50 % de valores faltantes
# 4. Exportar base de datos con moificaciones

#Instalar librerías
#Quitar el signo de gato y correr, sólo la primera vez que se utilice el paquete en la computadora

#install.packages("tidyverse")
# install.packages("janitor")

## Activar librerías
library(tidyverse)
library(janitor)

# Desde archivos separados por delimitador (como CSV)
# Se lee el archivo sobre incidencias delicitvas en CDMX en 2023
delitos <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/carpetas_2023.csv")
#Veo la base de datos
View(delitos)


# 1. Limpio los nombres de mis columnas (variables) --------------------------

delitos <- clean_names(delitos)
#Veo la base de datos
View(delitos)


# 2. Identificar número de valores faltantes por columnas específicas -----------------

#Contar Número de NAs: número de registros que no tiene información la columna edad
#Edad
sum(is.na(delitos$edad))
#Colonia
sum(is.na(delitos$colonia_datos))

#reemplazo valores faltantes 
delitos <- delitos %>% 
  mutate(colonia_datos = replace_na(colonia_datos, "Desconocido"))

#Confirmo
sum(is.na(delitos$colonia_datos))

#3. Dejar valores únicos ----------------------------------------------------
#vemos las columnas de la base de datos
colnames(delitos)

# Calcular el porcentaje de valores faltantes por columna
proporcion_faltantes <- delitos %>%
  summarise_all(~ mean(is.na(.)))


# Remover la columna que tiene más valores faltantes
delitos <- delitos %>%
  select(-municipio_hechos)

#Vemos las columnas de la base de datos
colnames(delitos)

# Descargar base de datos trabajada a formato excel (.csv, .xslsx)) -------
#descarga base de datos trabajada
write_csv(delitos, "delitos_trabajada")
#ve rla ruta en la que se guardo
getwd()