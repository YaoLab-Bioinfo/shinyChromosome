
dat_chr_cum <- function(dat, chr.cum.len) {
  dat$start <- 0
  dat$pos <- (dat$start + dat$size) / 2
  dat$chr <- factor(dat$chr, levels = names(chr.cum.len), ordered = T)
  dat$pos <- dat$pos + chr.cum.len[dat$chr]
  dat$chr <- as.character(dat$chr)
  return(dat)
}

# the main function to make two genomes plot
two_genomes_plot <- function(input, output, data.chr1, data.chr2, data.2geno.plot, Height, Width, sel_gral_col, 
                             gral_col_tp, gral_2cols_ct, gral_3cols_ct, col_type, color_cus, color_mulgp, col_transpt, 
                             theme_sty, font_size, xtitle, ytitle, title_font_face, xlabel, ylabel, lgd_pos, lgd_title_size, 
                             lgd_title_font_face, lgd_text_size, lgd_text_font_face, symbol_point, symbol_point_type, 
                             point_size_type, point_size, line_size, vertical, vertical_col, vertical_size, vertical_type, 
                             horizontal, horizontal_col, horizontal_size, horizontal_type, add_border, border_col, linetype, 
                             curvature, col_lgd, col_lgd_name, size_lgd, size_lgd_name, shape_lgd, shape_lgd_name, 
                             col_lgd_mdy_label, col_lgd_label, size_lgd_mdy_label, size_lgd_label, shape_lgd_mdy_label, 
                             shape_lgd_label, plot_type) {
  output$figure_2 <- renderPlot({
    ## *** Modify two genomes data ***
    names(data.chr1) <- c("chr", "size")
    data.chr1$size <- as.numeric(data.chr1$size)
    names(data.chr2) <- c("chr", "size")
    data.chr2$size <- as.numeric(data.chr2$size)
    selcols <- c("blue", "red", "green", "cyan", "purple", "pink", "orange",
                 "yellow", "navy", "seagreen", "maroon", "burlywood3", "magenta2")
    
    tc_p1 <- ggplot()
    ## *** Plot theme ***
    tc_alltheme_sty <-
      list(
        theme_bw(), theme_classic(), theme_minimal(), theme_few(), theme_grey(), theme_tufte(),
        theme_calc(), theme_void(), theme_base(), theme_linedraw(), theme_economist(), theme_excel(),
        theme_fivethirtyeight(), theme_gdocs(), theme_hc(), theme_pander(), theme_solarized(), theme_wsj(),
        theme_prism(),theme_my()
      )
    tc_p1 <- tc_p1 + tc_alltheme_sty[[as.numeric(gsub("theme", "", theme_sty))]]
    
    ## *** Modify main plot data ***
    if (plot_type %in% c("point_gradual", "point_discrete")) {
      names(data.2geno.plot)[1:4] <- c("chr1", "pos1", "chr2", "pos2")
      data.2geno.plot[c("pos1", "pos2")] <- sapply(data.2geno.plot[c("pos1", "pos2")],as.numeric)
      if(plot_type %in% "point_gradual"){
        data.2geno.plot[,5] <- as.numeric(data.2geno.plot[,5])
      }	  
    }
    if (plot_type %in% c("segment", "rect_gradual", "rect_discrete")) {
      names(data.2geno.plot)[1:6] <- c("chr1", "xpos1", "xpos2", "chr2", "ypos1", "ypos2")
      data.2geno.plot[c("xpos1", "xpos2", "ypos1","ypos2")] <- sapply(data.2geno.plot[c("xpos1", "xpos2", "ypos1","ypos2")],as.numeric)
      if(plot_type %in% "rect_gradual"){
        data.2geno.plot[,7] <- as.numeric(data.2geno.plot[,7])
      }
    }
    
    ## *** Color ***
    if (plot_type %in% c("point_gradual", "rect_gradual")) {
      if (sel_gral_col == 1) {
        gralcols <- gsub('\\"', "", gral_col_tp)
      }else if(sel_gral_col == 2){
        gralcols <- gral_2cols_ct
      }else if (sel_gral_col == 3){
        gralcols <- gral_3cols_ct
      }
      gralcols <- unlist(strsplit(gralcols, "\\."))
    }
    laycolor.export <<- c()
    if (plot_type %in% c("point_discrete", "segment", "rect_discrete")) {
      if (col_type == 2) {
        data.2geno.plot <- dat_dis_col(1, color_cus, data.2geno.plot)
      } else if (col_type == 3 & ("color" %in% colnames(data.2geno.plot))) {
        data.2geno.plot <- dat_cus_cols(1, color_mulgp, data.2geno.plot)
        laycolor <- unique(data.2geno.plot$cols)
        data.2geno.plot$raw_color <- data.2geno.plot$color
        data.2geno.plot$color <- data.2geno.plot$cols
        data.2geno.plot$cols <- NULL
      } else if (col_type == 1 & ("color" %in% colnames(data.2geno.plot))) {
        laycolor <- sample(selcols, length(unique(data.2geno.plot$color)))
        laycolor.export <<- paste(laycolor, collapse = ".")
        laycolor <- data.frame(group = unique(data.2geno.plot$color), cols = laycolor, stringsAsFactors = F)
        colname <- colnames(data.2geno.plot)
        data.2geno.plot <- merge(data.2geno.plot, laycolor, by.x = "color", by.y = "group", all.x = T)
        data.2geno.plot <- data.2geno.plot[c(colname, "cols")]
        laycolor <- unique(data.2geno.plot$cols)
        data.2geno.plot$raw_color <- data.2geno.plot$color
        data.2geno.plot$color <- data.2geno.plot$cols
        data.2geno.plot$cols <- NULL
      } else{
        laycolor <- sample(selcols, 1)
        laycolor.export <<- paste(laycolor, collapse = ".")
        data.2geno.plot$color <- laycolor
      }
      jd_col <- data.2geno.plot$color
      output$errorinfo5 <- renderPrint({
        if (plot_type %in% c("point_discrete", "segment", "rect_discrete")) {  
          validate(need(
            all(areColors(jd_col)),
            "Error: Data color error! Please input applicable color name."
          ))
        }
      })
      outputOptions(output, "errorinfo5", suspendWhenHidden = FALSE)
    }
    
    ## *** The color labels ***
    if (!plot_type %in% c("point_gradual", "rect_gradual")) {
      if (!"raw_color" %in% names(data.2geno.plot)) {
        data.2geno.plot$raw_color <- data.2geno.plot$color
      }
      dat_val <<- NULL
      dat_col <<- NULL
      data.2geno.plot <- cols_adjust(1, data.2geno.plot, col_transpt, plot_type, 2)
      labelscol <- dat_val
      breakscol <- dat_col
    }
    
    ## *** Point type and size ***
    if (plot_type %in% c("point_gradual", "point_discrete")) {
      if (symbol_point_type == 1) {
        data.2geno.plot$shape <- as.numeric(symbol_point)
      } else if (symbol_point_type == 2 & (!"shape" %in% names(data.2geno.plot))) {
        data.2geno.plot$shape <- 16
      }
      if (point_size_type == 1) {
        data.2geno.plot$size <- as.numeric(point_size)
      } else if (point_size_type == 2 & (!"size" %in% names(data.2geno.plot))) {
        data.2geno.plot$size <- 0.8
      }
      breakspch <- unique(data.2geno.plot$shape)
      labelspch <- breakspch
      breakscex <- unique(data.2geno.plot$size)
      labelscex <- breakscex
    }
    
    output$errorinfo8 <- renderPrint({
      if (plot_type %in% c("point_gradual", "point_discrete")) {
        validate(
          need(
            breakspch >= 0 & breakspch <= 25,
            "Error: Symbol type error for Data! Please input one applicable integer in [0-25]."
          )
        )
      }
    })
    outputOptions(output, "errorinfo8", suspendWhenHidden = FALSE)
    
    ## *** Borders ***
    if (add_border == 2) {
      border_col <- NA
    }
    
    ## *** Legends ***
    add_col_lgd <- "none"; add_size_lgd <- "none"; add_shape_lgd <- "none"
    if (col_lgd == 1) {
      if (plot_type %in% c("point_gradual", "rect_gradual")) {
        add_col_lgd <- "colourbar"
      } else{
        add_col_lgd <- "legend"
      }
      if (plot_type %in% c("point_discrete", "segment", "rect_discrete")) {
        if (col_lgd_mdy_label == 1) {
          col_lgd_labelp <- lgd_mdy_label(1, col_lgd_label)
          col_lgd_labelp <- rep(col_lgd_labelp, length(breakscol))[1:length(breakscol)]
          names(col_lgd_labelp) <- labelscol
          data.2geno.plot$raw_color <- as.character(data.2geno.plot$raw_color)
          data.2geno.plot$raw_color <- col_lgd_labelp[data.2geno.plot$raw_color]
          labelscol <- unname(col_lgd_labelp)
          data.2geno.plot$raw_color <- factor(data.2geno.plot$raw_color, levels = unique(labelscol), ordered = T)
        }
      }
    }
    
    if (plot_type %in% c("point_gradual", "point_discrete")) {
      if (size_lgd == 1) {
        add_size_lgd <- "legend"
        if (size_lgd_mdy_label == 1) {
          size_lgd_labelp <- lgd_mdy_label(1, size_lgd_label)
          labelscex <- rep(size_lgd_labelp, length(breakscex))[1:length(breakscex)]
        }
      }
      if (shape_lgd == 1) {
        add_shape_lgd <- "legend"
        if (shape_lgd_mdy_label == 1) {
          shape_lgd_labelp <- lgd_mdy_label(1, shape_lgd_label)
          labelspch <- rep(shape_lgd_labelp, length(breakspch))[1:length(breakspch)]
        }
      }
    }
    ## *** The position of concatenated genome1 ***
    chr.cum.len <- chr_cumsum(data.chr1, 2)
    chr.cum.len_1 <- chr.cum.len.tmp
    
    data.chr1 <- dat_chr_cum(data.chr1, chr.cum.len)
    data.2geno.plot$chr1 <- factor(data.2geno.plot$chr1, levels = names(chr.cum.len), ordered = T)
    
    if (plot_type %in% c("segment", "rect_gradual", "rect_discrete")) {
      data.2geno.plot$xpos1 <- data.2geno.plot$xpos1 + chr.cum.len[data.2geno.plot$chr1]
      data.2geno.plot$xpos2 <- data.2geno.plot$xpos2 + chr.cum.len[data.2geno.plot$chr1]
    } else{
      data.2geno.plot$pos1 <- data.2geno.plot$pos1 + chr.cum.len[data.2geno.plot$chr1]
    }
    data.2geno.plot$chr1 <- as.character(data.2geno.plot$chr1)
    
    ## *** The position of concatenated genome2 ***
    chr.cum.len <- chr_cumsum(data.chr2, 2)
    chr.cum.len_2 <- chr.cum.len.tmp
    
    data.chr2 <- dat_chr_cum(data.chr2, chr.cum.len)
    data.2geno.plot$chr2 <- factor(data.2geno.plot$chr2, levels = names(chr.cum.len), ordered = T)
    
    if (plot_type %in% c("segment", "rect_gradual", "rect_discrete")) {
      data.2geno.plot$ypos1 <- data.2geno.plot$ypos1 + chr.cum.len[data.2geno.plot$chr2]
      data.2geno.plot$ypos2 <- data.2geno.plot$ypos2 + chr.cum.len[data.2geno.plot$chr2]
    } else{
      data.2geno.plot$pos2 <- data.2geno.plot$pos2 + chr.cum.len[data.2geno.plot$chr2]
    }
    data.2geno.plot$chr2 <- as.character(data.2geno.plot$chr2)
    
    ## *** Point_gradual ***
    if (plot_type == "point_gradual") {
      midpoint <- mean(data.2geno.plot$color, na.rm = T)
      if (is.numeric(labelscex)) {
        labelscex <- sprintf("%.1f", sort(labelscex))
      }
      if (is.numeric(labelspch)) {
        labelspch <- sort(labelspch)
      }
      if (lgd_pos == 1) {
        tc_p1 <- tc_p1 + geom_point(data = data.2geno.plot, aes(x = pos1, y = pos2, color = color, shape = as.character(shape), size = size))
        
        if(sel_gral_col == 2){
          tc_p1 <- tc_p1 + scale_color_gradient(name = col_lgd_name, guide = add_col_lgd, low = gralcols[1], high = gralcols[2], na.value = "#FFFFFF00")
        }else{
          tc_p1 <- tc_p1 + scale_color_gradient2(name = col_lgd_name, guide = add_col_lgd, low = gralcols[1], midpoint = midpoint, 
                                                 mid = gralcols[2], high = gralcols[3], na.value = "#FFFFFF00")
        }
        
        tc_p1 <- tc_p1 + scale_size_identity(name = size_lgd_name, guide = add_size_lgd, breaks = sort(breakscex), labels = labelscex)
        tc_p1 <- tc_p1 + scale_shape_manual(name = shape_lgd_name, guide = add_shape_lgd, values = sort(breakspch), labels = labelspch)		
        tc_p1 <- tc_p1 + theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), 
                               legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
      } else{
        tc_p1 <- tc_p1 + geom_point(data = data.2geno.plot, aes(x = pos1, y = pos2, color = color, shape = as.character(shape), size = size))
        
        if(sel_gral_col == 2){
          tc_p1 <- tc_p1 + scale_color_gradient(name = col_lgd_name, guide = add_col_lgd, low = gralcols[1], high = gralcols[2], na.value = "#FFFFFF00")
        }else{          
          tc_p1 <- tc_p1 + scale_color_gradient2(name = col_lgd_name, guide = add_col_lgd, low = gralcols[1], midpoint = midpoint, 
                                                 mid = gralcols[2], high = gralcols[3], na.value = "#FFFFFF00")
        }
        
        tc_p1 <- tc_p1 + scale_size_identity(name = size_lgd_name, guide = add_size_lgd, breaks = sort(breakscex), labels = labelscex)
        tc_p1 <- tc_p1 + scale_shape_manual(name = shape_lgd_name, guide = add_shape_lgd, values = sort(breakspch), labels = labelspch)		
        tc_p1 <- tc_p1 + theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), 
                               legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
      }
      if (add_col_lgd == "colourbar") {
        tc_p1 <- tc_p1 + guides(color = guide_colorbar(order = 1, title.vjust = 0.8, title.hjust = 0.4), size = guide_legend(order = 2))
      } else{
        tc_p1 <- tc_p1 + guides(size = guide_legend(order = 1))
      }
    }
    
    ## *** Point_discrete ***
    if (plot_type == "point_discrete") {
      if (is.numeric(labelscex)) {
        labelscex <- sprintf("%.1f", sort(labelscex))
      }
      if (is.numeric(labelspch)) {
        labelspch <- sort(labelspch)
      }
      if (lgd_pos == 1) {
        tc_p1 <- tc_p1 + geom_point(data = data.2geno.plot, aes(pos1, pos2, color = color, shape = as.character(shape), size = size))
        tc_p1 <- tc_p1 + scale_color_identity(name = col_lgd_name, guide = add_col_lgd, breaks = breakscol, labels = labelscol)
        tc_p1 <- tc_p1 + scale_size_identity(name = size_lgd_name, guide = add_size_lgd, breaks = sort(breakscex), labels = labelscex)
        tc_p1 <- tc_p1 + scale_shape_manual(name = shape_lgd_name, guide = add_shape_lgd, values = sort(breakspch), labels = labelspch)		
        tc_p1 <- tc_p1 + theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face),
                               legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
        tc_p1 <- tc_p1 + guides(color = guide_legend(order = 1), size = guide_legend(order = 2))
      } else{
        tc_p1 <- tc_p1 + geom_point(data = data.2geno.plot, aes(pos1, pos2, color = color, shape = as.character(shape), size = size))
        tc_p1 <- tc_p1 + scale_color_identity(name = col_lgd_name, guide = add_col_lgd, breaks = breakscol, labels = labelscol)
        tc_p1 <- tc_p1 + scale_size_identity(name = size_lgd_name, guide = add_size_lgd, breaks = sort(breakscex), labels = labelscex)
        tc_p1 <- tc_p1 + scale_shape_manual(name = shape_lgd_name, guide = add_shape_lgd, values = sort(breakspch), labels = labelspch)		
        tc_p1 <- tc_p1 + theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face),
                               legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
        tc_p1 <- tc_p1 + guides(color = guide_legend(order = 1), size = guide_legend(order = 2))
      }
    }
    
    ## *** Segment ***
    if (plot_type == "segment") {
      if (length(unique(data.2geno.plot$color)) > 1) {
        linetype <- "solid"
      }
      if (lgd_pos == 1) {
        tc_p1 <- tc_p1 + geom_segment(data = data.2geno.plot, aes(x = xpos1, y = ypos1, xend = xpos2, yend = ypos2, color = color),
                                      size = line_size, linetype = linetype)
        tc_p1 <- tc_p1 + scale_color_identity(name = col_lgd_name, guide = add_col_lgd, breaks = breakscol, labels = labelscol)
        tc_p1 <- tc_p1 + theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face),
                               legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
      } else{
        tc_p1 <- tc_p1 + geom_segment(data = data.2geno.plot, aes(x = xpos1, y = ypos1, xend = xpos2, yend = ypos2, color = color),
                                      size = line_size, linetype = linetype)
        tc_p1 <- tc_p1 + scale_color_identity(name = col_lgd_name, guide = add_col_lgd, breaks = breakscol, labels = labelscol)
        tc_p1 <- tc_p1 + theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face),
                               legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
      }
    }
    ## *** Rect_gradual ***
    if (plot_type == "rect_gradual") {
      midpoint <- mean(data.2geno.plot$color, na.rm = T)
      if (lgd_pos == 1) {
        tc_p1 <- tc_p1 + geom_rect(data = data.2geno.plot, aes(xmin = xpos1, xmax = xpos2, ymin = ypos1, ymax = ypos2, 
                                                               fill = color), color = border_col)
        
        if(sel_gral_col == 2){
          tc_p1 <- tc_p1 + scale_fill_gradient(name = col_lgd_name, guide = add_col_lgd, low = gralcols[1], high = gralcols[2], na.value = "#FFFFFF00")
        }else{
          tc_p1 <- tc_p1 + scale_fill_gradient2(name = col_lgd_name, guide = add_col_lgd, low = gralcols[1], midpoint = midpoint, 
                                                mid = gralcols[2], high = gralcols[3], na.value = "#FFFFFF00")
        }
        
        tc_p1 <- tc_p1 + theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), 
                               legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
      } else{
        tc_p1 <- tc_p1 + geom_rect(data = data.2geno.plot, aes(xmin = xpos1, xmax = xpos2, ymin = ypos1, ymax = ypos2, fill = color), color = border_col)
        
        if(sel_gral_col == 2){
          tc_p1 <- tc_p1 + scale_fill_gradient(name = col_lgd_name, guide = add_col_lgd, low = gralcols[1], high = gralcols[2], na.value = "#FFFFFF00")
        }else{		  
          tc_p1 <- tc_p1 + scale_fill_gradient2(name = col_lgd_name, guide = add_col_lgd, low = gralcols[1], midpoint = midpoint, 
                                                mid = gralcols[2], high = gralcols[3], na.value = "#FFFFFF00")
        }
        
        tc_p1 <- tc_p1 + theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), 
                               legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
        if(add_col_lgd != "none"){
          tc_p1 <- tc_p1 + guides(fill = guide_colourbar(title.vjust = 0.8, title.hjust = 0.4))
        }
      }
    }
    
    ## *** Rect_discrete ***
    if (plot_type == "rect_discrete") {
      if (lgd_pos == 1) {
        tc_p1 <- tc_p1 + geom_rect(data = data.2geno.plot, aes(xmin = xpos1, xmax = xpos2, ymin = ypos1, ymax = ypos2,
                                                               fill = color), color = border_col)
        tc_p1 <- tc_p1 + scale_fill_identity(name = col_lgd_name, guide = add_col_lgd, breaks = breakscol, labels = labelscol)
        tc_p1 <- tc_p1 + theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face),
                               legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
      } else{
        tc_p1 <- tc_p1 + geom_rect(data = data.2geno.plot, aes(xmin = xpos1, xmax = xpos2, ymin = ypos1, ymax = ypos2,
                                                               fill = color), color = border_col)
        tc_p1 <- tc_p1 + scale_fill_identity(name = col_lgd_name, guide = add_col_lgd, breaks = breakscol, labels = labelscol)
        tc_p1 <- tc_p1 + theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face),
                               legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
      }
    }
    
    ## *** Vertical line ***
    if (vertical == 1) {
      tc_p1 <- tc_p1 + geom_vline(xintercept = chr.cum.len_1, linetype = vertical_type,
                                  color = vertical_col, size = vertical_size)
    }
    
    ## *** Horizontal line ***
    if (horizontal == 1) {
      tc_p1 <- tc_p1 + geom_hline(yintercept = chr.cum.len_2, linetype = horizontal_type,
                                  color = horizontal_col, size = horizontal_size)
    }
    
    ## *** The axis label ***
    if (xlabel == 1) {
      if (theme_sty == "theme20") {
        tc_p1 <- tc_p1 + scale_x_continuous(breaks = data.chr1$pos, labels = data.chr1$chr, expand = expansion(mult = c(0.001, 0.01)))
      } else {
        tc_p1 <- tc_p1 + scale_x_continuous(breaks = data.chr1$pos, labels = data.chr1$chr)
      }
    } else {
      if (theme_sty == "theme20") {
        tc_p1 <- tc_p1 + scale_x_continuous(expand = expansion(mult = c(0.001, 0.01)))
        tc_p1 <- tc_p1 + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())
      } else {
        tc_p1 <- tc_p1 + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())
      }
    }
    
    if (ylabel == 1) {
      if (theme_sty == "theme20"){
        tc_p1 <- tc_p1 + scale_y_continuous(breaks = data.chr2$pos, labels = data.chr2$chr, expand = expansion(mult = c(0.001, 0.01)))
      } else {
        tc_p1 <- tc_p1 + scale_y_continuous(breaks = data.chr2$pos, labels = data.chr2$chr)
      }
    } else {
      if (theme_sty == "theme20") {
        tc_p1 <- tc_p1 + scale_y_continuous(expand = expansion(mult = c(0.001, 0.01)))
        tc_p1 <- tc_p1 + theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())
      } else {
        tc_p1 <- tc_p1 + theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())}
    }
    
    ## *** The x and y axis title ***
    tc_p1 <- tc_p1 + xlab(xtitle) + ylab(ytitle)
    
    ## *** The font angle of axis title ***
    if (any(theme_sty %in% c("theme8", "theme16"))) {
      tc_p1 <- tc_p1 + theme(axis.title.x = element_text(hjust = 0.5, vjust = 1), axis.title.y = element_text(angle = 90, hjust = 0.5, vjust = 0.1))
    }
    
    ## *** Font face ***
    tc_p1 <- tc_p1 + theme(axis.title = element_text(face = title_font_face))
    
    ## *** Font size ***
    tc_p1 <- tc_p1 + theme(text = element_text(size = font_size))
    
    grid.draw(tc_p1)
    figure_2 <<- recordPlot()
  }, height = Height, width = Width)
}

