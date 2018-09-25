cat('## setwd("absolute path of a directory containing the input data files")',file="code.R",append=TRUE,sep="\n")
cat('## copy the R script "writeCmd-2_function.R" to the directory set by the "setwd" function  
source("writeCmd-2_function.R")
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
cat(paste("Height <- ",tc_Height,sep=""),paste("Width <- ",tc_Width,sep=""),paste('themestyle <- "',tc_themestyle,'"',sep=""),paste("fontSize <- ",tc_fontSize,sep=""),
paste("xtitle <- ",'"',tc_xtitle,'"',sep=""),paste('ytitle <- "',tc_ytitle,'"',sep=""),paste("titlefontface <- ",'"',tc_titlefontface,'"',sep=""),paste("xlabel <- ",tc_xlabel,sep=""),paste("ylabel <- ",tc_ylabel,sep=""),
paste("legendpos <- ",tc_legendpos,sep=""),paste("lgdtitlesize <- ",tc_lgdtitlesize,sep=""),paste('lgdtitlefontface <- "',tc_lgdtitlefontface,'"',sep=""),paste("lgdtextsize <- ",tc_lgdtextsize,sep=""),paste('lgdtextfontface <- "',tc_lgdtextfontface,'"',sep=""),
paste('tc_chrdata1 <- "',tc_chrdata1$name,'"',sep=""),paste('tc_chrdata2 <- "',tc_chrdata2$name,'"',sep=""),"data.C1 <- data.frame(fread(tc_chrdata1), stringsAsFactors = F)","data.C2 <- data.frame(fread(tc_chrdata2), stringsAsFactors = F)",
paste('trackfil <- "',trackfil$name,'"',sep=""),"data.TC <- data.frame(fread(trackfil),stringsAsFactors = F)",file="code.R",append=TRUE,sep="\n")

cat(paste('plottype <- "',tc_plottype,'"',sep=""),paste("selgralcol <- ",tc_selgralcol,sep=""),paste('gralcol_tp <- "',tc_gralcol_tp,'"',sep=""),
paste('gralcol_ct <- c("',paste(tc_gralcol_ct,collapse='","'),'")',sep=""),paste("coltype <- ",tc_coltype,sep=""),paste('colorcus <- "',tc_colorcus,'"',sep=""),
paste('colormulgp <- "',tc_colormulgp,'"',sep=""),paste("coltransparency <- ",tc_coltransparency,sep=""),paste("symbolpoint <- ",tc_symbolpoint,sep=""),paste("symbolpointype <- ",sel_tc_symbolpointype,sep=""),paste("pointsize <- ",tc_pointsize,sep=""),paste("pointsizetype <- ",sel_tc_pointsizetype,sep=""),
paste("linesize <- ",tc_linesize,sep=""),paste('vertical <- ',tc_vertical,sep=""),paste('verticalcol <- "',tc_verticalcol,'"',sep=""),paste('verticalsize <- ',tc_verticalsize,sep=""),
paste('verticaltype <- "',tc_verticaltype,'"',sep=""),paste('horizontal <- ',tc_horizontal,sep=""),paste('horizontalcol <- "',tc_horizontalcol,'"',sep=""),paste('horizontalsize <- ',tc_horizontalsize,sep=""),
paste('horizontaltype <- "',tc_horizontaltype,'"',sep=""),paste('addborder <- ',tc_addborder,sep=""),paste('bordercols <- "',tc_bordercols,'"',sep=""),paste('linetype <- "',tc_linetype,'"',sep=""),paste("collgd <- ",tc_collgd,sep=""),
paste('collgdname <- "',tc_collgdname,'"',sep=""),paste("sizelgd <- ",tc_sizelgd,sep=""),paste('sizelgdname <- "',tc_sizelgdname,'"',sep=""),paste("shapelgd <- ",tc_shapelgd,sep=""),
paste('shapelgdname <- "',tc_shapelgdname,'"',sep=""),paste("collgdmdylabel <- ",tc_collgdmdylabel,sep=""),paste('collgdlabel <- "',tc_collgdlabel,'"',sep=""),paste("sizelgdmdylabel <- ",tc_sizelgdmdylabel,sep=""),
paste('sizelgdlabel <- "',tc_sizelgdlabel,'"',sep=""),paste("shapelgdmdylabel <- ",tc_shapelgdmdylabel,sep=""),paste('shapelgdlabel <- "',tc_shapelgdlabel,'"',sep=""),
paste('laycolor.export <- "',laycolor.export,'"',sep=""),file="code.R",append=TRUE,sep="\n")
	
cat("tc_p1 <- two_genomes_plot(data.C1,data.C2,data.TC,Height,Width,themestyle,fontSize,xtitle,ytitle,titlefontface,xlabel,ylabel,legendpos,lgdtitlesize,lgdtitlefontface,lgdtextsize,lgdtextfontface,tc_chrdata1,
tc_chrdata2,trackfil,plottype,selgralcol,gralcol_tp,gralcol_ct,coltype,colorcus,colormulgp,coltransparency,symbolpoint,symbolpointype,pointsize,pointsizetype,linesize,vertical,verticalcol,verticalsize,verticaltype,
horizontal,horizontalcol,horizontalsize,horizontaltype,addborder,bordercols,linetype,collgd,collgdname,sizelgd,sizelgdname,shapelgd,shapelgdname,collgdmdylabel,collgdlabel,sizelgdmdylabel,sizelgdlabel,shapelgdmdylabel,
shapelgdlabel,laycolor.export)",file="code.R",append=TRUE,sep="\n")

cat("",file="code.R",append=TRUE,sep="\n")

cat(paste('pdf("Visualization_2.pdf", width=',tc_Width,"/72,"," height=",tc_Height,"/72)",sep=""),paste('## svg("Visualization_2.svg", width=',tc_Width,"/72,"," height=",tc_Height,"/72)",sep=""),
"grid.draw(tc_p1)","dev.off()",file="code.R",append=TRUE,sep="\n")		 

out <<- readLines("code.R")
file.remove("code.R")