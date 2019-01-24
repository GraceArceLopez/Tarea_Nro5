setwd("~/Tarea_Nro5")
# Usando la libreria rvest

##########################################################
######### Iniciando la extracción de información #########
##########################################################

library('rvest')


# Iniciando la variable archivo con el nombre de mi pagina
archivo <-'Pag_Web.html'

# Leyendo el HTML del archivo
webpage <- read_html(archivo)

##########################################################
############# Extracción del texto noticia ###############
##########################################################

#Extrayendo titulo de la pag web

ContenidoTituloNoticia <- html_nodes(webpage,'h1')

#Pasando la info a texto
TituloNoticia <-html_text(ContenidoTituloNoticia)
print(TituloNoticia)

#Extrayendo contenido en la clase justificado
contenidoWebNoticia <- html_nodes(webpage,'p')

#Pasando la info a texto
textoNoticia <- html_text(contenidoWebNoticia)


#Pregunta: ¿Qué representa el \n?

# Eliminando los \n, comillas("), puntos(.) y comas (,) del texto
textoNoticia <- gsub("\n","",textoNoticia)
textoNoticia <- gsub("\"","",textoNoticia)
textoNoticia <- gsub("[.]","",textoNoticia)
textoNoticia <- gsub(",","",textoNoticia)
textoNoticia <- gsub("&acute;","á",textoNoticia)
textoNoticia <- gsub("&acute;","é",textoNoticia)
textoNoticia <- gsub("&acute;","í",textoNoticia)
textoNoticia <- gsub("&acute;","ó",textoNoticia)


textoNoticia <- gsub("&acute;","ú",textoNoticia)
textoNoticia <- gsub("\r","",textoNoticia)
textoNoticia <- gsub(";","",textoNoticia)


#Viendo a priori la info en la variable textoNoticia
print(textoNoticia)

textoCompleto <- ""
#Separando las palabras por espacio
for(i in 1 : length(textoNoticia)){
  textoCompleto <- paste(textoCompleto," ",textoNoticia[i])
}

splitEspacioNoticia <- strsplit(textoCompleto," ")[[1]]

#Pasando todas las palabras a minúsculas
splitEspacioNoticia <- tolower(splitEspacioNoticia)

#Contando palabras
unlistNoticias <- unlist(splitEspacioNoticia)
tablaPalabras <- table(unlistNoticias)

#Pasando la información a una data frame
dfPalabrasNoticia <-as.data.frame(tablaPalabras)

print(dfPalabraNoticia)

##########################################################
############ Extraccion información tabla ################
##########################################################

#Extrayendo contenido de la tabla a través del tag table
tabla <- html_nodes(webpage,'table')
print(tabla)

#Extrayendo los elementos de la tabla
tablaWeb <- html_table(tabla[[1]])

print (tablaWeb)

#Pasando la información a tabla
tablaWeb <- html_table(tabla)[[1]]
print(tablaWeb)

#Pasando la información a data  frame
dftabla <- as.data.frame(tablaWeb)

#Almacenando la información en csv
write.csv(dftabla, file = 'PalabrasNoticia.csv')

#o en un txt
write.table(dftabla, file = 'PalabrasNoticia.txt')

#Viendo el contenido de la posicióm 1,2 de la tabla
print(tablaWeb[1,2])

#Viendo el contenido de la posicióm 1,3 de la tabla
print(tablaWeb[1,3])

#Pasando informacion a data frame
DataFramePalabras<-as.data.frame(tablaPalabras)


# Limpiando $ comas y cambios de puntos por coma
tablaWeb$'Precios' <- gsub("//$","",tablaWeb$'Precio')
tablaWeb$'Precios' <- gsub("[.]","",tablaWeb$'Precio')
tablaWeb$'Precios' <- as.numeric(gsub(",",".",tablaWeb$'Precio'))

#######################################################################
################Gráficando Precios Tabla###############################
#######################################################################

install.packages('ggplot2')
#Graficando los productos
library('ggplot2')

#Gráfico Barra
tablaWeb %>%
  ggplot() +
  aes(x = Producto, y = 'Precio') +
  geom_bar(stat="identity")

 #Gráfico boxplot
tablaWeb %>%
  ggplot() +
  geom_boxplot(aes(x = Producto, y = 'Precio')) +
  theme_bw()
  

##########################################################
######### Iniciando la extracción de información #########
##########################################################

library('rvest')


# Iniciando la variable archivo con el nombre de mi pagina
archivodeis <-'http://www.deis.cl/estadisticas-laborales/'

# Leyendo el HTML del archivo
webpagedeis <- read_html(archivodeis)

##########################################################
#############  DEIS.CL ###############
##########################################################

#Extrayendo titulo de la pag web

TituloDeis <- html_nodes(webpagedeis,"title")
print(TituloDeis)


#Extrayendo contenido en la clase justificado
contenidoDeis <- html_nodes(webpagedeis,'p')

#Pasando la info a texto
textoNoticiaDeis <- html_text(contenidoDeis)[[2]]

print(textoNoticiaDeis)

# Eliminando los \n,comillas("),puntos(.) y comas(,) del texto
textoNoticiaDeis <- gsub("\n","",textoNoticiaDeis)
textoNoticiaDeis <- gsub("\"","",textoNoticiaDeis)
textoNoticiaDeis <- gsub("[.]","",textoNoticiaDeis)
textoNoticiaDeis <- gsub(",","",textoNoticiaDeis)
textoNoticiaDeis <- gsub("&acute;","ú",textoNoticiaDeis)
textoNoticiaDeis <- gsub("\r","",textoNoticiaDeis)
textoNoticiaDeis <- gsub(";","",textoNoticiaDeis)
textoNoticiaDeis <- gsub("&acute;","ó",textoNoticiaDeis)
textoNoticiaDeis <- gsub("","",textoNoticiaDeis)


# Viendo a priori la info en la variable textoNoticia
print(textoNoticiaDeis)

# Separando las palabras por espacio
splitEspacioNoticiaDeis <- strsplit(textoNoticiaDeis," ")

# Pasando todas las palabras a minúsculas
splitEspacioNoticiaDeis <- tolower(splitEspacioNoticiaDeis)

# Contando palabras
unlistNoticiasDeis<-unlist(splitEspacioNoticiaDeis)
tablaPalabrasDeis<-table(unlistNoticiasDeis)

# Pasando la información a un data frame
dfPalabrasNoticiaDeis <- as.data.frame(tablaPalabrasDeis)

# Almacenando la información en CSV
write.csv(dfPalabrasNoticiaDeis, file="PalabrasNoticiaDeis.csv")

# o en un txt
write.table(dfPalabrasNoticiaDeis, file="PalabrasNoticiaDeis.txt")
 