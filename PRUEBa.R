zip_file <- "entregas.zip"
destino <- "entregas"

unzip(zip_file, exdir = destino)files_puntos <- list.files(
  path = destino,
  pattern = "puntos.*\\.txt$",
  recursive = TRUE,
  full.names = TRUE
)
files_justificante <- list.files(
  path = destino,
  pattern = "\\.(pdf|png|jpg)$",
  recursive = TRUE,
  full.names = TRUE
)
apellidos <- c()
puntos <- c()
nomFile <- c()
contenido <- c()
for (file in files_puntos) {
  
  # Extraer apellidos desde la ruta
  partes <- strsplit(file, "/")[[1]]
  alumno <- partes[length(partes) - 1]  # carpeta del alumno
  
  # Leer contenido
  lineas <- readLines(file, warn = FALSE)
  puntuacion <- as.numeric(lineas[1])
  
  # Guardar datos
  apellidos <- c(apellidos, alumno)
  puntos <- c(puntos, puntuacion)
  nomFile <- c(nomFile, basename(file))
  contenido <- c(contenido, lineas[1])
}
unique(nomFile)
length(unique(nomFile))
# alumnos con puntos
alumnos_puntos <- basename(dirname(files_puntos))

# alumnos con justificante
alumnos_just <- basename(dirname(files_justificante))

setdiff(alumnos_puntos, alumnos_just)   # sin justificante
setdiff(alumnos_just, alumnos_puntos)   # sin puntos

evalua_df <- data.frame(
  Apellidos = apellidos,
  puntos = puntos,
  NomFile = nomFile,
  Puntos = contenido,
  stringsAsFactors = FALSE
)
evalua_df <- evalua_df[order(evalua_df$Apellidos), ]

install.packages("writexl")
library(writexl)

write_xlsx(evalua_df, "NotasRIntermedio.xlsx")
library(readxl)

alumnos_df <- read_excel("AlumnosTD25_26.xlsx")

final_df <- merge(
  alumnos_df,
  evalua_df,
  by.x = "Apellidos",
  by.y = "Apellidos",
  all.x = TRUE
)

write_xlsx(final_df, "AlumnosNotas.xlsx")
cat("Total entregas:", length(files_puntos), "\n")
cat("Variantes nombre fichero:", unique(nomFile), "\n")

evalua_df <- data.frame(
  Apellidos = apellidos,
  puntos = puntos,
  NomFile = nomFile,
  Puntos = contenido,
  stringsAsFactors = FALSE
)

evalua_df <- evalua_df[order(evalua_df$Apellidos), ]