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

#==============

#Extrayendo contenido de la tabla a través del tag table
tablaProductos <- html_nodes(webpage,'table')

#Extrayendo los elementos de la tabla
tablaProductosExtraidos <- html_table(tablaProductos[[1]])

#Pasando la información a data  frame
dfPalabraNoticia <- as.data.frame(tablaPalabras)

#Almacenando la información en csv
write.csv(dfPalabraNoticia, file = 'PalabrasNoticia.csv')

#o en un txt

#Viendo el contenido de la posicióm 1,2 de la tabla
print(tablaProductosExtraidos[1,2])

install.packages('ggplot2')
#Graficando los productos
library('ggplot2')

tablaProductosExtraidos <- gsub("[.]","",textoNoticia)
#Gráfico Barra
tablaProductosExtraidos %>%
  ggplot() +
  aes(x = Producto, y= Precio) +
  geom_bar(stat="identify")

 #Gráfico boxplot
tablaProductosExtraidos %>%
  ggplot() +
  geom_boxplot(aes(x = Producto, y = Precio)) +
  
 

