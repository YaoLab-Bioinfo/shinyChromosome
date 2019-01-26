
cat('## setwd("absolute path of a directory containing the input data files")', file = "code.R", append = TRUE, sep = "\n")
cat('options(scipen=5)

## copy the R script "writeCmd-1_function.R" to the directory set by the "setwd" function.
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
library(grid)', file = "code.R", append = TRUE, sep = "\n")

cat("", file = "code.R", append = TRUE, sep = "\n")
cat(paste("Height <- ",Height, sep = ""), paste("Width <- ", Width, sep = ""),
    paste("chr_plotype <- ", chr_plotype, sep = ""), paste("plot_direct <- ", plot_direct, sep = ""),
    paste("theme_sty <- ", '"', theme_sty, '"', sep = ""), paste("font_size <- ", font_size, sep = ""),
    paste("xtitle <- ", '"', xtitle, '"', sep = ""), paste("ytitle <- ", '"', ytitle, '"', sep = ""),
    paste("title_font_face <- ", '"', title_font_face, '"', sep = ""), paste("xlabel <- ", xlabel, sep = ""),
    paste("lgd_pos <- ", lgd_pos, sep = ""), paste("lgd_space_size <- ", lgd_space_size, sep = ""),
    paste("lgd_intra_size <- ", lgd_intra_size, sep = ""), paste("lgd_title_size <- ", lgd_title_size, sep = ""),
    paste('lgd_title_font_face <- "', lgd_title_font_face, '"', sep = ""),
    paste("lgd_text_size <- ", lgd_text_size, sep = ""), paste('lgd_text_font_face <- "', lgd_text_font_face, '"', sep = ""),
    paste("chr_data <- ", '"', chr_data$name, '"', sep = ""), file = "code.R", append = TRUE, sep = "\n")

cat('data.chr <- data.frame(fread(chr_data), stringsAsFactors = F)', file = "code.R", append = TRUE, sep = "\n")
cat(paste('data.track.file <- c("', paste(upload_file.export,collapse ='", "'), '")', sep = ""), file = "code.R", append = TRUE, sep = "\n")
cat(paste("sel_upload_data <- c(", paste(sel_upload_data.export,collapse =", "), ")", sep = ""), file = "code.R", append = TRUE, sep = "\n")
cat("data.track <- lapply(1:10,function(x){
    if(sel_upload_data[x] == 2 && data.track.file[x] != 1) {
       data.frame(fread(data.track.file[x]), stringsAsFactors=F)
    }
   })", file = "code.R", append = TRUE, sep = "\n")
cat(paste("track_indx <- c(", paste(track_indx,collapse =","), ")", sep = ""),
    "data.track <- data.track[track_indx]", file = "code.R", append = TRUE, sep = "\n")

if(length(data.track) == 0){
  cat("data.track <- NULL", file = "code.R", append = TRUE, sep = "\n")
}

cat(paste('plot_type <- c("', paste(plot_type, collapse = '", "'), '")', sep = ""),
    paste('layer_index <- c("', paste(layer_index, collapse = '", "'), '")', sep = ""),
    paste("col_type <- c(", paste(col_type, collapse = ', '), ")", sep = ""),
    paste('color_cus <- c("', paste(color_cus, collapse = '", "'), '")', sep = ""),
    paste('color_mulgp <- c("', paste(color_mulgp, collapse = '", "'), '")', sep = ""),
    paste("col_transpt <- c(", paste(col_transpt, collapse = ', '), ")", sep = ""),
    paste("add_border <- c(", paste(add_border, collapse = ', '), ")", sep = ""),
    paste('border_col <- c("', paste(border_col, collapse = '", "'), '")', sep = ""),
    paste("rect_col <- c(", paste(rect_col, collapse = ', '), ")", sep = ""),
    paste('rect_col_dis <- c("', paste(rect_col_dis, collapse = '", "'), '")', sep = ""),
    paste('rect_col_dis_cus <- c("', paste(rect_col_dis_cus, collapse = '", "'), '")', sep = ""),
    paste('col_rect <- c("', paste(col_rect, collapse = '", "'), '")', sep = ""),
    paste("rect_grad_col <- c(", paste(rect_grad_col, collapse = ', '), ")", sep = ""),
    paste('rect_grad_cus_cols <- c("', paste(rect_grad_cus_cols, collapse = '", "'), '")', sep = ""),
    paste("sel_heatmap_col <- c(", paste(sel_heatmap_col, collapse = ', '), ")", sep = ""),
    paste('hmap_col <- c("', paste(hmap_col, collapse = '", "'), '")', sep = ""),
    paste('heatmap_col_cus <- c("', paste(heatmap_col_cus, collapse = '", "'), '")', sep = ""),
    paste("hmap_col_dis <- c(", paste(hmap_col_dis, collapse = ', '), ")", sep = ""),
    paste('hmap_col_dis_cus <- c("', paste(hmap_col_dis_cus, collapse = '", "'), '")', sep = ""),
    paste("symbol_point <- c(", paste(symbol_point, collapse = ', '), ")", sep = ""),
    paste("sel_symbol_point <- c(", paste(sel_symbol_point, collapse = ', '), ")", sep = ""),
    paste("point_size <- c(", paste(point_size, collapse = ', '), ")", sep = ""),
    paste("sel_point_size <- c(", paste(sel_point_size, collapse = ', '), ")", sep = ""),
    paste('line_color <- c("', paste(line_color, collapse = '", "'), '")', sep = ""),
    paste("line_size <- c(", paste(line_size, collapse = ', '), ")", sep = ""),
    paste("fill_area <- c(", paste(fill_area, collapse = ', '), ")", sep = ""),
    paste("sel_area_type <- c(", paste(sel_area_type, collapse = ', '), ")", sep = ""),
    paste('border_area <- c("', paste(border_area, collapse = '", "'), '")', sep = ""),
    paste('linetype <- c("', paste(linetype, collapse = '", "'), '")', sep = ""),
    paste('add_arrow <- c(', paste(add_arrow, collapse = ', '), ')', sep = ""),
    paste('arrow_pos <- c(', paste(arrow_pos, collapse = ', '), ')', sep = ""),
    paste('arrow_size <- c(', paste(arrow_size, collapse = ', '), ')', sep = ""),
    paste('text_col <- c("', paste(text_col, collapse = '", "'), '")', sep = ""),
    paste("text_size <- c(", paste(text_size, collapse = ', '), ")", sep = ""),
    paste('font_face <- c("', paste(font_face, collapse = '", "'), '")', sep = ""),
    paste("text_angle <- c(", paste(text_angle, collapse = ', '), ")", sep = ""),
    paste("col_lgd <- c(", paste(col_lgd, collapse = ', '), ")", sep = ""),
    paste('col_lgd_name <- c("', paste(col_lgd_name, collapse = '", "'), '")', sep = ""),
    paste("size_lgd <- c(", paste(size_lgd, collapse = ', '), ")", sep = ""),
    paste('size_lgd_name <- c("', paste(size_lgd_name, collapse = '", "'), '")', sep = ""),
    paste("shape_lgd <- c(", paste(shape_lgd, collapse = ', '), ")", sep = ""),
    paste('shape_lgd_name <- c("', paste(shape_lgd_name, collapse = '", "'), '")', sep = ""),
    paste("line_type_lgd <- c(", paste(line_type_lgd, collapse = ', '), ")", sep = ""),
    paste('line_type_lgd_name <- c("', paste(line_type_lgd_name, collapse = '", "'), '")', sep = ""),
    paste("col_lgd_mdy_label <- c(", paste(col_lgd_mdy_label, collapse = ', '), ")", sep = ""),
    paste('col_lgd_label <- c("', paste(col_lgd_label, collapse = '", "'), '")', sep = ""),
    paste("size_lgd_mdy_label <- c(", paste(size_lgd_mdy_label, collapse = ', '), ")", sep = ""),
    paste('size_lgd_label <- c("', paste(size_lgd_label, collapse = '", "'), '")', sep = ""),
    paste("shape_lgd_mdy_label <- c(", paste(shape_lgd_mdy_label, collapse = ', '), ")", sep = ""),
    paste('shape_lgd_label <- c("', paste(shape_lgd_label, collapse = '", "'), '")', sep = ""),
    paste("line_type_lgd_mdy_label <- c(", paste(line_type_lgd_mdy_label, collapse = ', '), ")", sep = ""),
    paste('line_type_lgd_label <- c("', paste(line_type_lgd_label, collapse = '", "'), '")', sep = ""),
    paste("ylabel <- c(", paste(ylabel, collapse = ', '), ")", sep = ""),
    paste("height_layer <- c(", paste(height_layer, collapse = ', '), ")", sep = ""),
    paste("margin_layer <- c(", paste(margin_layer, collapse = ', '), ")", sep = ""),
    paste('laycolor.export <- c("', paste(laycolor.export, collapse = '", "'), '")', sep = ""),
    paste('rect_discol.export <- c("', paste(rect_discol.export, collapse = '", "'), '")', sep = ""),
    paste('heatmap_discol.export <- c("', paste(heatmap_discol.export, collapse = '", "'), '")', sep = ""),
    file = "code.R", append = TRUE, sep = "\n")

cat("p1 <- single_genome_plot(data.chr, data.track, plot_type, layer_index, col_type, color_cus,
    color_mulgp, col_transpt, add_border, border_col, rect_col, rect_col_dis, rect_col_dis_cus, col_rect,
    rect_grad_col, rect_grad_cus_cols, sel_heatmap_col, hmap_col, heatmap_col_cus,
    hmap_col_dis, hmap_col_dis_cus, symbol_point, sel_symbol_point, point_size, sel_point_size,
    line_color, line_size, fill_area, sel_area_type, border_area, linetype, add_arrow, arrow_pos,
    arrow_size, text_col, text_size, font_face, text_angle, col_lgd, col_lgd_name,
    size_lgd, size_lgd_name,shape_lgd, shape_lgd_name, line_type_lgd, line_type_lgd_name,
    col_lgd_mdy_label, col_lgd_label, size_lgd_mdy_label, size_lgd_label, shape_lgd_mdy_label,
    shape_lgd_label, line_type_lgd_mdy_label, line_type_lgd_label, ylabel, height_layer,
    margin_layer, laycolor.export, rect_discol.export, heatmap_discol.export)", file = "code.R", append = TRUE, sep = "\n")

cat("", file = "code.R", append = TRUE, sep = "\n")

cat(paste('pdf("Visualization_1.pdf", width = ', Width, "/72,", " height = ", Height, "/72)", sep = ""),
    paste('## svg("Visualization_1.svg", width = ', Width, "/72,", " height = ", Height, "/72)", sep = ""),
    "grid.draw(p1)","dev.off()", file = "code.R", append = TRUE, sep = "\n")

out <<- readLines("code.R")
file.remove("code.R")

