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