
cat('## setwd("absolute path of current directory containing the download scripts and data files")', file = "code.R", append = TRUE, sep = "\n")
cat('source("writeCmd-2_function.R")

library(ggplot2)
library(plyr)
library(ggthemes)
library(RColorBrewer)
library(gridExtra)
library(reshape2)
library(data.table)
library(grid)', file = "code.R", append = TRUE, sep = "\n")

cat("", file = "code.R", append = TRUE, sep = "\n")
cat(paste("Height <- ", tc_Height, sep = ""), paste("Width <- ", tc_Width, sep = ""),
    paste('theme_sty <- "', tc_theme_sty, '"', sep = ""), paste("font_size <- ", tc_font_size, sep = ""),
    paste("xtitle <- ", '"', tc_xtitle, '"', sep = ""), paste('ytitle <- "',tc_ytitle, '"', sep = ""),
    paste("title_font_face <- ", '"', tc_title_font_face, '"', sep = ""),
    paste("xlabel <- ", tc_xlabel, sep = ""), paste("ylabel <- ",tc_ylabel, sep = ""),
    paste("lgd_pos <- ", tc_lgd_pos, sep = ""), paste("lgd_title_size <- ", tc_lgd_title_size, sep = ""),
    paste('lgd_title_font_face <- "', tc_lgd_title_font_face, '"', sep = ""),
    paste("lgd_text_size <- ", tc_lgd_text_size, sep = ""), paste('lgd_text_font_face <- "', tc_lgd_text_font_face, '"', sep = ""),
    paste('tc_chr_data1 <- "', tc_chr_data1$name, '"', sep = ""),
    paste('tc_chr_data2 <- "', tc_chr_data2$name, '"', sep = ""), 'data.chr1 <- data.frame(fread(tc_chr_data1, quote=""), stringsAsFactors = F)',
    'data.chr2 <- data.frame(fread(tc_chr_data2, quote=""), stringsAsFactors = F)',
    paste('trackfil <- "', trackfil$name, '"', sep = ""), 'data.2geno.plot <- data.frame(fread(trackfil, quote=""), stringsAsFactors = F)', 
    file = "code.R", append = TRUE, sep = "\n")

cat(paste('plot_type <- "', tc_plot_type, '"', sep = ""), paste("sel_gral_col <- ", tc_sel_gral_col, sep = ""),
    paste('gral_col_tp <- "', tc_gral_col_tp, '"', sep = ""),	
    paste('gral_2cols_ct <- c("', paste(tc_gral_2cols_ct, collapse = '", "'), '")', sep = ""),
    paste('gral_3cols_ct <- c("', paste(tc_gral_3cols_ct, collapse = '", "'), '")', sep = ""),
    paste("col_type <- ", tc_col_type, sep = ""), paste('color_cus <- "', tc_color_cus, '"', sep = ""),
    paste('color_mulgp <- "', tc_color_mulgp, '"', sep = ""), paste("col_transpt <- ", tc_col_transpt, sep = ""),
    paste("symbol_point <- ", tc_symbol_point, sep = ""),
    paste("symbol_point_type <- ", sel_tc_symbol_point_type, sep = ""),
    paste("point_size <- ", tc_point_size, sep = ""), paste("point_size_type <- ", sel_tc_point_size_type, sep = ""),
    paste("line_size <- ", tc_line_size, sep = ""), paste('vertical <- ', tc_vertical, sep = ""),
    paste('vertical_col <- "', tc_vertical_col, '"', sep = ""), paste('vertical_size <- ', tc_vertical_size, sep = ""),
    paste('vertical_type <- "', tc_vertical_type, '"', sep = ""), paste('horizontal <- ', tc_horizontal, sep = ""),
    paste('horizontal_col <- "', tc_horizontal_col, '"', sep = ""),
    paste('horizontal_size <- ', tc_horizontal_size, sep = ""), paste('horizontal_type <- "', tc_horizontal_type, '"', sep = ""),
    paste('add_border <- ', tc_add_border, sep = ""), paste('border_col <- "', tc_border_col, '"', sep = ""),
    paste('linetype <- "', tc_line_type, '"', sep = ""), paste("col_lgd <- ", tc_col_lgd, sep = ""),
    paste('col_lgd_name <- "', tc_col_lgd_name, '"', sep = ""), paste("size_lgd <- ", tc_size_lgd, sep = ""),
    paste('size_lgd_name <- "',tc_size_lgd_name, '"', sep = ""), paste("shape_lgd <- ", tc_shape_lgd, sep = ""),
    paste('shape_lgd_name <- "', tc_shape_lgd_name, '"', sep = ""),
    paste("col_lgd_mdy_label <- ", tc_col_lgd_mdy_label, sep = ""), paste('col_lgd_label <- "', tc_col_lgd_label, '"', sep = ""),
    paste("size_lgd_mdy_label <- ", tc_size_lgd_mdy_label, sep = ""),
    paste('size_lgd_label <- "', tc_size_lgd_label, '"', sep = ""), paste("shape_lgd_mdy_label <- ", tc_shape_lgd_mdy_label, sep = ""),
    paste('shape_lgd_label <- "', tc_shape_lgd_label, '"', sep = ""),
    paste('laycolor.export <- "', laycolor.export, '"', sep = ""), file = "code.R", append = TRUE, sep = "\n")

cat("p1 <- two_genomes_plot(data.chr1, data.chr2, data.2geno.plot, Height, Width, theme_sty, font_size, xtitle, ytitle, 
     title_font_face, xlabel, ylabel, lgd_pos, lgd_title_size, lgd_title_font_face, lgd_text_size, lgd_text_font_face, 
     tc_chr_data1, tc_chr_data2, trackfil, plot_type, sel_gral_col, gral_col_tp, gral_2cols_ct, gral_3cols_ct, col_type, 
     color_cus, color_mulgp, col_transpt, symbol_point, symbol_point_type, point_size, point_size_type, line_size, vertical, 
     vertical_col, vertical_size, vertical_type, horizontal, horizontal_col, horizontal_size, horizontal_type, add_border, 
     border_col, linetype, col_lgd, col_lgd_name, size_lgd, size_lgd_name, shape_lgd, shape_lgd_name, col_lgd_mdy_label, 
     col_lgd_label, size_lgd_mdy_label, size_lgd_label, shape_lgd_mdy_label, shape_lgd_label, laycolor.export)", 
    file = "code.R", append = TRUE, sep = "\n")

cat("", file = "code.R", append = TRUE, sep = "\n")

cat(paste('pdf("Visualization_2.pdf", width = ', tc_Width, "/72, ", " height = ", tc_Height, "/72)", sep = ""),
    paste('## svg("Visualization_2.svg", width = ', tc_Width, "/72, ", " height = ", tc_Height, "/72)", sep = ""),
    "grid.draw(p1)", "dev.off()", file = "code.R", append = TRUE, sep = "\n")

out <<- readLines("code.R")
file.remove("code.R")

