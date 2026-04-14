zip_file <- "2025-26 Tractament de les dades Gr.A-T (36423)-Tarea Intermediate R(Datacamp)-3281647.zip"
destino <- "datos_extraidos"

unzip(zip_file, exdir = destino)

files_puntos <- list.files(
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
  
  partes <- strsplit(file, "/")[[1]]
  alumno <- partes[length(partes) - 1]
  
  lineas <- readLines(file, warn = FALSE)
  puntuacion <- as.numeric(lineas[1])
  
  apellidos <- c(apellidos, alumno)
  puntos <- c(puntos, puntuacion)
  nomFile <- c(nomFile, basename(file))
  contenido <- c(contenido, lineas[1])
}

evalua_df <- data.frame(
  Apellidos = apellidos,
  puntos = puntos,
  NomFile = nomFile,
  Puntos = contenido,
  stringsAsFactors = FALSE
)

evalua_df <- evalua_df[order(evalua_df$Apellidos), ]

library(writexl)

write_xlsx(evalua_df, "NotasRIntermedio.xlsx")