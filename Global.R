
options(shiny.maxRequestSize=30*1024^2)

library(ggplot2)
library(plyr)
library(ggthemes)
library(RLumShiny)
library(RColorBrewer)
library(gridExtra)
library(reshape2)
library(data.table)
library(grid)
library(shinysky)
library(zip)

source("single_genome_plot.R")
source("two_genomes_plot.R")

g_legend <- function(a.gplot){
  tmp <- ggplot_gtable(ggplot_build(a.gplot))
  leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
  legend <- tmp$grobs[[leg]]
  return(legend)
}

areColors <- function(x) {
  sapply(x, function(y) {
    tryCatch(is.matrix(col2rgb(y)), error = function(e) FALSE)
  })
}

dat_dis_col <- function(i, dis_cols, dat) {
  dis_col <- dis_cols[i]
  dis_col <- gsub("\\s", "", strsplit(dis_col, ",")[[1]])
  dis_col <- gsub('\\"', "", dis_col)
  dis_col <- gsub("0x", "#", dis_col)
  if (length(dis_col) == 0) {
    dis_col <- NA
  }
  dat$color <- dis_col
  return(dat)
}

lgd_mdy_label <- function(i, lgd_labels) {
  lgd_label <- gsub("\\s", "", strsplit(lgd_labels[i], ",")[[1]])
  lgd_label <- gsub('\\"', "", lgd_label)
  if (length(lgd_label) == 0) {
    lgd_label <- "NA"
  }
  return(lgd_label)
}

dat_cus_cols <- function(i, cus_cols, dat) {
  laycolor <- cus_cols[i]
  laycolor <- unlist(strsplit(laycolor, ";"))
  laycolor <- data.frame(id = laycolor, stringsAsFactors = F)
  laycolor$group <- gsub("\\:.*", "", laycolor$id)
  laycolor$cols <- gsub(".*\\:", "", laycolor$id)
  laycolor$group <- gsub(" ", "", laycolor$group)
  laycolor$cols <- gsub(" ", "", laycolor$cols)
  colname <- colnames(dat)
  dat <- merge(dat, laycolor, by.x = "color", by.y = "group", all.x = T)
  dat <- dat[c(colname, "cols")]
  return(dat)
}

chr_cumsum <- function(dat, i) {
  chr.len <- dat$size
  names(chr.len) <- dat$chr
  if (i == 2) {
    chr.cum.len.tmp <<- c(0, cumsum(chr.len))
  }
  chr.cum.len <- c(0, cumsum(chr.len)[-length(chr.len)])
  names(chr.cum.len) <- names(chr.len)
  return(chr.cum.len)
}

cols_adjust <- function(i, dat, col_transpt, plot_type, type) {
  if ((type == 1 && (plot_type[i] %in% c("rect_discrete", "heatmap_discrete"))) |
      (type == 2 && (!plot_type[i] %in% c("point_gradual", "rect_gradual")))) {
    dat$color[!areColors(dat$color)] <- NA
    dat$color <- adjustcolor(dat$color, alpha.f = col_transpt[i])
    if (!all(is.na(dat$color))) {
      dat_val <- unique(dat$raw_color[!is.na(dat$raw_color)])
      dat_col <- dat$color[match(dat_val, dat$raw_color)]
    } else{
      dat_val <- unique(dat$raw_color[!is.na(dat$raw_color)])[1]
      dat_col <- "#FFFFFF00"
    }
  } else if (!plot_type[i] %in% c("heatmap_gradual", "heatmap_discrete", "text",
                                  "rect_gradual", "rect_discrete", "ideogram")){
    if (!"raw_color" %in% names(dat)) {
      dat$raw_color <- dat$color
    }
    if (!plot_type[i] %in% "segment") {
      dat_val <- unique(dat$raw_color[!is.na(dat$value)])
    } else{
      dat_val <- unique(dat$raw_color)
    }
    if (plot_type[i] %in% "vertical_line") {
      dat_val <- unique(dat$raw_color)
    }
    dat$color[!areColors(dat$color)] <- NA
    dat$color <- adjustcolor(dat$color, alpha.f = col_transpt[i])
    dat_col <- dat$color[match(dat_val, dat$raw_color)]
  }
  dat_val <- dat_val[!duplicated(dat_col)]
  dat_col <- dat_col[!duplicated(dat_col)]
  dat$raw_color <- factor(dat$raw_color, levels = dat_val, ordered = T)
  dat$color <- factor(dat$color, levels = dat_col, ordered = T)
  dat_val <<- dat_val[which(!dat_col %in% "#FFFFFF00")]
  dat_col <<- dat_col[!dat_col %in% "#FFFFFF00"]
  return(dat)
}

col_lgd_mdy_labels <- function(dat, col_lgd_labels, breakscol, labelscol) {
  col_lgd_labels <- rep(col_lgd_labels, length(breakscol))[1:length(breakscol)]
  names(col_lgd_labels) <- labelscol
  labels_1 <<- unname(col_lgd_labels)
  dat$raw_color <- as.character(dat$raw_color)
  dat$raw_color <- col_lgd_labels[dat$raw_color]
  dat$raw_color <- factor(dat$raw_color, levels = unique(labels_1), ordered = T)
  return(dat)
}

