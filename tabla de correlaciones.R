############################################
# Mediana, moda y distribución de datos                                 
############################################

# Acciones a realizar en el Script ----------------------------------------
# 1. Juntar bases de datos de delitos y otras variables
# 2. Generar tabla de correlaciones


#################################
# 2.1.3 INSTALAR Y CARGAR LIBRERIAS

## Instalar librerías
# Quitar el signo de gato y correr, sólo la primera vez que se utilice el paquete en la computadora

#install.packages("tidyverse")
#install.packages("janitor")


## Activar librerías
library(readr)
library(tidyverse)
library(janitor)


#Leo base de variables socioeconómicas
demograficas <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_INSUMOS-INVETSIGACION/main/demograficas_alcaldia.csv") # cargo la base de caracteríticas

# Desde archivos separados por delimitador mediante un link (CSV)
delitos <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/carpetas_2023.csv")

delitos <- delitos %>% clean_names() # Limpieza automática de nombre de variables

#Establezco el delito a analizar
incidencia <- "EXTORSION"

#flitro por "delitos de interes"
delitos <- delitos %>% 
  filter(delito == incidencia) # Separo el delito a estudiar

#Agrupo por alcaldía y cuento el número de incidencias por alcaldía
delitos <- delitos %>%
  group_by(alcaldia_hechos) %>%
  count() %>% 
  rename(extorsion = n)

#junto las dos bases

delitos_demograficas <- merge(delitos, demograficas, by.x = "alcaldia_hechos", by.y = "alcaldia", all = FALSE)


# Creación de tabla de correlaciones --------------------------------------


ggcorr(delitos_demograficas, palette = "RdBu", label = TRUE)
