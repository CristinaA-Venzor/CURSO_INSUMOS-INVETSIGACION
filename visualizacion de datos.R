############################################
# Creación de tabla y frecuencias temporales
############################################

############################################
# Mediana, moda y distribución de datos                                 
############################################

# Acciones a realizar en el Script ----------------------------------------
# 1. Filtrar por delito a analizar
# 2. Generar gráfico de frecuencia día hora
# 3. Generar gráfico de frecuncia por mes



#################################
# INSTALAR Y CARGAR LIBRERIAS

# Quitar el signo de gato y correr, sólo la primera vez que se utilice el paquete en la computadora

#install.packages("readr")
#install.packages("tidyverse")
#install.packages("janitor")
#install.packages("magrittr")

## Activar librerías
library(readr)
library(tidyverse)
library(janitor)
library(magrittr)

# Desde archivos separados por delimitador mediante un link (CSV)
delitos <- read.csv("https://raw.githubusercontent.com/CristinaA-Venzor/CURSO_BASE_ANALISIS_CRIMINAL/main/Bases%20de%20datos/carpetas_2023.csv")

delitos <- delitos %>% clean_names() # Limpieza automática de nombre de variables

#ver todos los delitos de la base de datos
incidencias <- unique(delitos$delito)
incidencias


# Filtrar por incidencia a analizar ---------------------------------------


#Establezco el delito a analizar
incidencia <- "EXTORSION"

#flitro por ""
delitos <- delitos %>% 
            filter(delito == incidencia)# Separo el delito a estudiar


#pongo en formato fecha
delitos$fecha_hechos <- as.Date(delitos$fecha_hechos, "%d/%m/%y")

#extraigo día
delitos$dia <- format(delitos$fecha_hechos,"%u")
#extraigo año
delitos$año <- format(delitos$fecha_hechos,"%Y")
#extraigo mes
delitos$mes <- format(delitos$fecha_hechos,"%m")

# GRAFICO DE FRECUENCIA EN HORARIO ----------------------------------------

delitos <- delitos %>%
  mutate(hora_hechos = as.POSIXct(hora_hechos, format = "%H:%M:%S")) # Configuro el formato de hora de los hechos

delitos <- delitos %>% mutate(hora = format(hora_hechos, format = "%H")) # Me quedo solo con la hora de los hechos

delitos$hora <- as.numeric(delitos$hora) # Cambia la hora solita a datos de tipo numerico

#tabla de doble entrada
table <- xtabs(~ hora+dia, data=delitos)

#convierto a matriz
table <- as.matrix(table)

# pongo días a nombre completo
colnames(table) <-  c("lunes", "martes", "miércoles", "jueves", "viernes", "sábado", "domingo")
##Revisar si en nuestra tabla están todos los días, si no lo están borrar los que se omiten.

df_mapa <- as.data.frame(table) # Genero el frame a partir del filtrado previo

# Codigo para el gráfico
ggp <- ggplot(df_mapa, aes(dia, hora)) + # ggplot(data_frame, aes(eje_x, eje_y))
  geom_tile(aes(fill = Freq)) + # Señalizacion del color
  ggtitle(paste0("Frecuencia temporal de ", incidencia )) + # Titulo
  theme(plot.title = element_text(hjust = 0.5, face = "bold")) # Tipo de grafico
ggp + scale_fill_gradient(low = "white", high = "red") # Configuracion de los colores   

# GRAFICO DE FRECUENCIA POR MES ------------------------------------------

mes_1 <- as.data.frame(table(delitos$mes_hechos)) # Frame de las frecuencias
mes_1

mes_1$Var1 <- c("Enero", "Febrero", "Marzo", "Abril")# Ordeno segun el pasar de los meses
#NOTA: aquí sólo hay 4 meses, revisar si es necesario adicionar meses

# Histograma a partir de la funcion barplot
my_bar <- barplot(height=mes_1$Freq, names.arg = mes_1$Var1, # height=frecuencia, names.arg = a_quien_pertenece,
                  col=rgb(0.8,0.1,0.1,0.6), axes = FALSE,
                  xlab="mes", # Titulo en x
                  main="Robo de Objetos por mes", # Titulo
                  las=2,
                  cex.axis=2, cex.names=.9) 

text(my_bar, mes_1$Freq -.6, labels = mes_1$Freq) # Añadir la frecuencia dentro del grafico

# Histograma a partir de la funcion ggplot
ggplot(data = mes_1, aes(x = Var1, y = Freq)) +
  geom_bar(stat = "identity", fill = "red") +
  geom_text(aes(label = Freq), vjust = -0.5, color = "black", size = 4) +
  labs(title = paste0("Frecuencia mensual de ", incidencia ), x = "Mes", y = "Frecuencia") + # Titulos
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 90, vjust = 0.5, size = 10)) # Valores en x


