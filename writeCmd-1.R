cat('## setwd("absolute path of a directory containing the input data files")',file="code.R",append=TRUE,sep="\n")
cat('options(scipen=5)
## copy the R script "writeCmd-1_function.R" to the directory set by the "setwd" function  
source("writeCmd-1_function.R")
library(gplots)
library(ggplot2)
library(plotly)
library(plyr)
library(shinyBS)
library(ggthemes)
library(RLumShiny)
library(RColorBrewer)
library(gridExtra)
library(reshape2)
library(data.table)
library(grid)',file="code.R",append=TRUE,sep="\n")

cat("",file="code.R",append=TRUE,sep="\n")
cat(paste("Height <- ",Height,sep=""),paste("Width <- ",Width,sep=""),paste("chrplotype <- ",chrplotype,sep=""),paste("plotdirection <- ",plotdirection,sep=""),
paste("themestyle <- ",'"',themestyle,'"',sep=""),paste("fontSize <- ",fontSize,sep=""),paste("xtitle <- ",'"',xtitle,'"',sep=""),paste("ytitle <- ",'"',ytitle,'"',sep=""),paste("titlefontface <- ",'"',titlefontface,'"',sep=""),
paste("xlabel <- ",xlabel,sep=""),paste("legendpos <- ",legendpos,sep=""),paste("lgdspacesize <- ",lgdspacesize,sep=""),paste("lgdintrasize <- ",lgdintrasize,sep=""),
paste("lgdtitlesize <- ",lgdtitlesize,sep=""),paste('lgdtitlefontface <- "',lgdtitlefontface,'"',sep=""),paste("lgdtextsize <- ",lgdtextsize,sep=""),paste('lgdtextfontface <- "',lgdtextfontface,'"',sep=""),paste("chrdata <- ",'"',chrdata$name,'"',sep=""),file="code.R",append=TRUE,sep="\n")

cat('data.C <- data.frame(fread(chrdata), stringsAsFactors = F)',file="code.R",append=TRUE,sep="\n")
cat(paste('data.T.file <- c("',paste(uploadfile.export,collapse ='","'),'")',sep=""),file="code.R",append=TRUE,sep="\n")
  cat(paste("seluploaddata <- c(",paste(seluploaddata.export,collapse =","),")",sep=""),file="code.R",append=TRUE,sep="\n")		                 
  cat("data.T <- lapply(1:10,function(x){
			 if(seluploaddata[x] == 2 && data.T.file[x]!=1){	  
		     data.frame(fread(data.T.file[x]),stringsAsFactors=F)
			 }
			 })",file="code.R",append=TRUE,sep="\n")		  			  
cat(paste("trackindx <- c(",paste(trackindx,collapse =","),")",sep=""),"data.T <- data.T[trackindx]",file="code.R",append=TRUE,sep="\n")
if(length(data.T) == 0){
  cat("data.T <- NULL",file="code.R",append=TRUE,sep="\n")
}

cat(paste('plottype <- c("',paste(plottype,collapse='","'),'")',sep=""),paste('layerindex <- c("',paste(layerindex,collapse='","'),'")',sep=""),
paste("coltype <- c(",paste(coltype,collapse=','),")",sep=""),paste('colorcus <- c("',paste(colorcus,collapse='","'),'")',sep=""),paste('colormulgp <- c("',paste(colormulgp,collapse='","'),'")',sep=""),
paste("coltransparency <- c(",paste(coltransparency,collapse=','),")",sep=""),paste("addborder <- c(",paste(addborder,collapse=','),")",sep=""),paste('bordercols <- c("',paste(bordercols,collapse='","'),'")',sep=""),
paste("rectcol <- c(",paste(rectcol,collapse=','),")",sep=""),paste('rectcoldis <- c("',paste(rectcoldis,collapse='","'),'")',sep=""),paste('rectcoldiscus <- c("',paste(rectcoldiscus,collapse='","'),'")',sep=""),
paste('colrect <- c("',paste(colrect,collapse='","'),'")',sep=""),paste("rectgrad_col <- c(",paste(rectgrad_col,collapse=','),")",sep=""),paste('rectgrad_cuscols <- c("',paste(rectgrad_cuscols,collapse='","'),'")',sep=""),paste("heatmapcol <- c(",paste(heatmapcol,collapse=','),")",sep=""),paste('colhmap <- c("',paste(colhmap,collapse='","'),'")',sep=""),
paste('heatmapcols <- c("',paste(heatmapcols,collapse='","'),'")',sep=""),paste("colhmapdis <- c(",paste(colhmapdis,collapse=','),")",sep=""),paste('colhmapdiscus <- c("',paste(colhmapdiscus,collapse='","'),'")',sep=""),
paste("symbolpoint <- c(",paste(symbolpoint,collapse=','),")",sep=""),paste("sel_symbolpoint <- c(",paste(sel_symbolpoint,collapse=','),")",sep=""),paste("pointsize <- c(",paste(pointsize,collapse=','),")",sep=""),paste("sel_pointsize <- c(",paste(sel_pointsize,collapse=','),")",sep=""),paste('linecolor <- c("',paste(linecolor,collapse='","'),'")',sep=""),
paste("linesize <- c(",paste(linesize,collapse=','),")",sep=""),paste("fillarea <- c(",paste(fillarea,collapse=','),")",sep=""),paste("selareatype <- c(",paste(selareatype,collapse=','),")",sep=""),
paste('borderarea <- c("',paste(borderarea,collapse='","'),'")',sep=""),paste('linetype <- c("',paste(linetype,collapse='","'),'")',sep=""),paste('addarrow <- c(',paste(addarrow,collapse=','),')',sep=""),
paste('arrowpos <- c(',paste(arrowpos,collapse=','),')',sep=""),paste('arrowsize <- c(',paste(arrowsize,collapse=','),')',sep=""),paste('textcol <- c("',paste(textcol,collapse='","'),'")',sep=""),
paste("textsize <- c(",paste(textsize,collapse=','),")",sep=""),paste('fontface <- c("',paste(fontface,collapse='","'),'")',sep=""),paste("textangle <- c(",paste(textangle,collapse=','),")",sep=""),
paste("collgd <- c(",paste(collgd,collapse=','),")",sep=""),paste('collgdname <- c("',paste(collgdname,collapse='","'),'")',sep=""),
paste("sizelgd <- c(",paste(sizelgd,collapse=','),")",sep=""),paste('sizelgdname <- c("',paste(sizelgdname,collapse='","'),'")',sep=""),paste("shapelgd <- c(",paste(shapelgd,collapse=','),")",sep=""),
paste('shapelgdname <- c("',paste(shapelgdname,collapse='","'),'")',sep=""),paste("linetypelgd <- c(",paste(linetypelgd,collapse=','),")",sep=""),paste('linetypelgdname <- c("',paste(linetypelgdname,collapse='","'),'")',sep=""),
paste("collgdmdylabel <- c(",paste(collgdmdylabel,collapse=','),")",sep=""),paste('collgdlabel <- c("',paste(collgdlabel,collapse='","'),'")',sep=""),paste("sizelgdmdylabel <- c(",paste(sizelgdmdylabel,collapse=','),")",sep=""),
paste('sizelgdlabel <- c("',paste(sizelgdlabel,collapse='","'),'")',sep=""),paste("shapelgdmdylabel <- c(",paste(shapelgdmdylabel,collapse=','),")",sep=""),paste('shapelgdlabel <- c("',paste(shapelgdlabel,collapse='","'),'")',sep=""),
paste("linetypelgdmdylabel <- c(",paste(linetypelgdmdylabel,collapse=','),")",sep=""),paste('linetypelgdlabel <- c("',paste(linetypelgdlabel,collapse='","'),'")',sep=""),paste("ylabel <- c(",paste(ylabel,collapse=','),")",sep=""),
paste("heightlayer <- c(",paste(heightlayer,collapse=','),")",sep=""),paste("marginlayer <- c(",paste(marginlayer,collapse=','),")",sep=""),paste('laycolor.export <- c("',paste(laycolor.export,collapse='","'),'")',sep=""),
paste('rect_discol.export <- c("',paste(rect_discol.export,collapse='","'),'")',sep=""),paste('heatmap_discol.export <- c("',paste(heatmap_discol.export,collapse='","'),'")',sep=""),file="code.R",append=TRUE,sep="\n")

cat("p1 <- single_genome_plot(data.C,data.T,plottype,layerindex,coltype,colorcus,colormulgp,coltransparency,addborder,bordercols,rectcol,rectcoldis,rectcoldiscus,colrect,rectgrad_col,rectgrad_cuscols,heatmapcol,colhmap,heatmapcols,
	colhmapdis,colhmapdiscus,symbolpoint,sel_symbolpoint,pointsize,sel_pointsize,linecolor,linesize,fillarea,selareatype,borderarea,linetype,addarrow,arrowpos,arrowsize,textcol,textsize,fontface,textangle,collgd,collgdname,
	sizelgd,sizelgdname,shapelgd,shapelgdname,linetypelgd,linetypelgdname,collgdmdylabel,collgdlabel,sizelgdmdylabel,sizelgdlabel,shapelgdmdylabel,shapelgdlabel,linetypelgdmdylabel,linetypelgdlabel,ylabel,heightlayer,
	marginlayer,laycolor.export,rect_discol.export,heatmap_discol.export)",file="code.R",append=TRUE,sep="\n")

cat("",file="code.R",append=TRUE,sep="\n")

cat(paste('pdf("Visualization_1.pdf", width=',Width,"/72,"," height=",Height,"/72)",sep=""),paste('## svg("Visualization_1.svg", width=',Width,"/72,"," height=",Height,"/72)",sep=""),
"grid.draw(p1)","dev.off()",file="code.R",append=TRUE,sep="\n")

out <<- readLines("code.R")
file.remove("code.R")
