
options(shiny.maxRequestSize=30*1024^2)

library(gplots)
library(ggplot2)
library(plyr)
library(ggthemes)
library(RLumShiny)
library(RColorBrewer)
library(gridExtra)
library(reshape2)
library(data.table)
library(grid)

source("single_genome_plot.R")
source("two_genomes_plot.R")

g_legend <- function(a.gplot){
    tmp <- ggplot_gtable(ggplot_build(a.gplot))
    leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
    legend <- tmp$grobs[[leg]]
    return(legend)
}

areColors <- function(x){
     sapply(x, function(y){
         tryCatch(is.matrix(col2rgb(y)), 
                  error = function(e) FALSE)
     })
}
