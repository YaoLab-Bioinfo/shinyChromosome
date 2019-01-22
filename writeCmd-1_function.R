
cytoband.col <- function(x) {
  x <- as.vector(x)
  col.panel <- c("gpos100" = rgb(0, 0, 0, maxColorValue = 255), 
                 "gpos"    = rgb(0, 0, 0, maxColorValue = 255),
                 "gpos75"  = rgb(130, 130, 130, maxColorValue = 255),
                 "gpos66"  = rgb(160, 160, 160, maxColorValue = 255),
                 "gpos50"  = rgb(200, 200, 200, maxColorValue = 255),
                 "gpos33"  = rgb(210, 210, 210, maxColorValue = 255),
                 "gpos25"  = rgb(200, 200, 200, maxColorValue = 255),
                 "gvar"    = rgb(220, 220, 220, maxColorValue = 255),
                 "gneg"    = rgb(255, 255, 255, maxColorValue = 255),
                 "acen"    = rgb(217, 47, 39, maxColorValue = 255),
                 "stalk"   = rgb(100, 127, 164, maxColorValue = 255) )
  col <- col.panel[x]
  col[is.na(col)] <- "#FFFFFF"
  names(col) <- NULL
  return(col)
}

g_legend <- function(a.gplot) {
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

cytoband.col <- function(x) {
  x <- as.vector(x)
  col.panel <- c(
    "gpos100" = rgb(0, 0, 0, maxColorValue = 255),
    "gpos"    = rgb(0, 0, 0, maxColorValue = 255),
    "gpos75"  = rgb(130, 130, 130, maxColorValue = 255),
    "gpos66"  = rgb(160, 160, 160, maxColorValue = 255),
    "gpos50"  = rgb(200, 200, 200, maxColorValue = 255),
    "gpos33"  = rgb(210, 210, 210, maxColorValue = 255),
    "gpos25"  = rgb(200, 200, 200, maxColorValue = 255),
    "gvar"    = rgb(220, 220, 220, maxColorValue = 255),
    "gneg"    = rgb(255, 255, 255, maxColorValue = 255),
    "acen"    = rgb(217, 47, 39, maxColorValue = 255),
    "stalk"   = rgb(100, 127, 164, maxColorValue = 255)
  )
  col <- col.panel[x]
  col[is.na(col)] <- "#FFFFFF"
  names(col) <- NULL
  return(col)
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

rect_grad_cols <- function(i, rect_grad_col, col_rect, rect_grad_cus_cols) {
  rect_grad_col <- rect_grad_col[i]
  if (rect_grad_col == 1) {
    rectcolor <- col_rect[i]
    all_rect_cols <- list(
      c("#EDEDFD", "#6969F5", "#00008B"), c("#FDEDED", "#F56969", "#8B0000"), 
      c("#EDFBED", "#69E169", "#008B00"), c("#EDFBFB", "#69E1E1", "#008B8B"), 
      c("#F6F0FB", "#B27FE1", "#551A8B"), c("#FBEEF5", "#E172AE", "#8B1076"), 
      c("#FDF5ED", "#F5AE69", "#8B4500"), c("#FDFDED", "#EFEF1A", "#8B8B00"), 
      c("#EDEDF6", "#7272B8", "#000080"), c("#F2FBF6", "#4EEE94", "#2E8B57"), 
      c("#FFF4FB", "#FF69C7", "#8B1C62"), c("#FBFFF4", "#C6FF52", "#698B22"), 
      c("#FFFCF1", "#FFDD28", "#8B7500"), c("#EFF5F7", "#AFCDD7", "#68838B"), 
      c("#000080", "#7B7B41", "#FFFF00"), c("#551A8B", "#548994", "#54FF9F"), 
      c("#000080", "#7B5041", "#FFA500"), c("#000080", "#007BBD", "#00FFFF"), 
      c("#0000FF", "#730083", "#EE0000"), c("#00EE00", "#757800", "#EE0000")
    )
    names(all_rect_cols) <- c("blue", "red", "green", "cyan", "purple", "pink", "orange", "yellow", "navy", 
                              "seagreen", "maroon", "olivedrab", "gold", "lightblue", "navy.yellow", 
                              "purple.seagreen", "navy.orange", "navy.cyan", "blue.red", "green.red")
    rect_cols <<- all_rect_cols[[rectcolor]]
  } else{
    rectgrad_cuscol <- rect_grad_cus_cols[i]
    rect_cols <<- unlist(strsplit(rectgrad_cuscol, "\\."))
  }
  return(rect_cols)
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

dis_type_cols <- function(i, dat, col_dis, plot_type, col_dis_rand, col_dis_cus, rect_col_dis) {
  if (plot_type[i] %in% "rect_discrete") {
    colnames(dat)[4] <- "color"
  }
  if (col_dis[i] == 1) {
    if (plot_type[i] %in% "heatmap_discrete") {
      dat$raw_color <- dat$color
    }
    if (length(unique(dat$color)) <= length(col_dis_rand)) {
      selcol <- sample(col_dis_rand, length(unique(dat$color)))
      dis_col.export <<- paste(selcol, collapse = ".")
      names(selcol) <- unique(dat$color)
      dat$color <- selcol[dat$color]
    } else{
      dat$color <- NA
      dis_col.export <<- NA
    }
    dat$value <- dat$color
    dat <- dat[, c(1:3, 5, 4)]
  } else if ((plot_type[i] %in% "rect_discrete" & col_dis[i] == 3) |
             (plot_type[i] %in% "heatmap_discrete" & col_dis[i] == 2)) {
    dat <- dat_cus_cols(i, col_dis_cus, dat)
    if (plot_type[i] %in% "heatmap_discrete") {
      colnames(dat)[which(colnames(dat) %in% "color")] <- "raw_color"
    } else{
      colnames(dat)[4] <- "value"
    }
    names(dat)[ncol(dat)] <- "color"
    dis_col.export <<- NA
  } else if (plot_type[i] %in% "rect_discrete" && col_dis[i] == 2) {
    dat <- dat_dis_col(i, rect_col_dis, dat)
    dat$value <- dat$color
    dat <- dat[, c(1:3, 5, 4)]
    dis_col.export <<- c(dis_col.export, NA)
  }
  return(dat)
}

dat_val_range <- function(m, dat, plot_type, layer_index) {
  val_range <- list()
  for (n in unique(dat$chr)) {
    dat.tmp1 <- dat[dat$chr %in% n, ]
    if (plot_type[m] %in% "segment") {
      num <- c(dat.tmp1$ypos1, dat.tmp1$ypos2)
    } else{
      num <- dat.tmp1$value
    }
    val_range <- c(val_range, list(c(layer_index[m], n, min(num, na.rm = T), max(num, na.rm = T))))
  }
  return(val_range)
}
		
single_genome_plot <- function(data.chr, data.track, plot_type, layer_index, col_type, color_cus, color_mulgp, col_transpt, add_border, border_col, rect_col, rect_col_dis, rect_col_dis_cus, col_rect, rect_grad_col, rect_grad_cus_cols, sel_heatmap_col, hmap_col, heatmap_col_cus,
                               hmap_col_dis, hmap_col_dis_cus, symbol_point, sel_symbol_point, point_size, sel_point_size, line_color, line_size, fill_area, sel_area_type, border_area, linetype, add_arrow, arrow_pos, arrow_size, text_col, text_size, font_face, text_angle, col_lgd, col_lgd_name,
                               size_lgd, size_lgd_name, shape_lgd, shape_lgd_name, line_type_lgd, line_type_lgd_name, col_lgd_mdy_label, col_lgd_label, size_lgd_mdy_label, size_lgd_label, shape_lgd_mdy_label, shape_lgd_label, line_type_lgd_mdy_label, line_type_lgd_label, ylabel, height_layer,
                               margin_layer, laycolor.export, rect_discol.export, heatmap_discol.export){
							   
  names(data.chr) <- c("chr", "size")
  chr_order <- unique(data.chr$chr)
  data.chr$size <- as.numeric(data.chr$size)
  layernum <- length(unique(layer_index))
  layer_index <- as.numeric(gsub("track", "", layer_index))
  val_range <- list() 
  data.chr$start <- 0
  names(data.chr) <- c("chr", "size", "start")
  data.chr <- data.chr[, c(1, 3, 2)]
  val_range_chr <- melt(data = data.chr, id.vars = "chr")
  val_range_chr$variable <- NULL
  
  chr.cum.len <- chr_cumsum(data.chr, 1)

  ## *** Set colnames for track data ***  
  for (m in 1:length(data.track)) {
    data.track.single <- data.track[[m]]
    if (plot_type[m] %in% c("point", "line")) {
      names(data.track.single)[1:3] <- c("chr", "pos", "value")
    } else if (plot_type[m] %in% "bar") {
      names(data.track.single)[1:4] <- c("chr", "xmin", "xmax", "value")
    } else if (plot_type[m] %in% "horizontal_line") {
      names(data.track.single) <- "value"
      rep_num <- nrow(data.track.single)
      data.track.single <- data.track.single[rep(rownames(data.track.single), length(unique(data.chr$chr))), , drop = F]
      data.track.single$chr <- rep(unique(data.chr$chr), each = rep_num)
    } else if (plot_type[m] %in% "segment") {
      names(data.track.single)[1:5] <- c("chr", "xpos1", "ypos1", "xpos2", "ypos2")
    } else if (plot_type[m] %in% "text") {
      names(data.track.single) <- c("chr", "pos", "value", "symbol")
    }
	  
    ## *** Extract ymin and ymax of each track ***
    if (plot_type[m] %in% "segment") {
      val_range <- dat_val_range(m, data.track.single, plot_type, layer_index)
    } else if (!plot_type[m] %in% c("rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "vertical_line", "ideogram")) {
      val_range <- dat_val_range(m, data.track.single, plot_type, layer_index)
    }
  }
  
  if (length(val_range) > 0) {
    val_range <- as.data.frame(do.call(rbind, val_range), stringsAsFactors = F)
    names(val_range) <- c("layer", "chr", "min_val", "max_val")
    val_range[c("layer", "min_val", "max_val")] <- sapply(val_range[c("layer", "min_val", "max_val")], as.numeric)
    val_range <- val_range[, c(1, 3, 4)]
    val_range <- ddply(val_range, .(layer), function(x) {
      x$min_val <- min(x$min_val, na.rm = T)
      x$max_val <- max(x$max_val, na.rm = T)
      return(x)
    })
    val_range <- unique(val_range)
  }
  
  ## *** Overal layout as height of each track and interval between adjacent tracks ***  
  track_layout <- data.frame(num = sort(layer_index), height = height_layer, gap = margin_layer, stringsAsFactors = F)
  track_layout <- unique(track_layout)
  height_layer <- track_layout$height
  names(height_layer) <- track_layout$num
  track_layout$height <- cumsum(track_layout$height)
  track_layout$gap <- cumsum(track_layout$gap)
  track_layout$ystart <- c(0, track_layout$height)[-(length(track_layout$height) + 1)] + c(0, track_layout$gap)[-(length(track_layout$gap) + 1)]
  track_layout$yend <- track_layout$height + c(0, track_layout$gap)[-length(track_layout$gap)]
  track_layout_chrs <- rep(data.chr$chr, length(unique(layer_index)))
  track_layout_tmp <- track_layout[c("ystart", "yend")][rep(rownames(track_layout), each = length(track_layout_chrs) / length(unique(layer_index))), ]
  track_layout_tmp$chr <- track_layout_chrs
  names(val_range_chr) <- c("chr", "pos")
  val_range_chr <- merge(val_range_chr, track_layout_tmp, by = "chr", all.x = T)
  
  if (chr_plotype == 1) {
    val_range_chr$chr <- factor(val_range_chr$chr, levels = names(chr.cum.len), ordered = T)
    val_range_chr$pos <- val_range_chr$pos + chr.cum.len[val_range_chr$chr]
    val_range_chr$chr <- as.character(val_range_chr$chr)
    val_range_chr <- val_range_chr[c(which(val_range_chr$pos == min(val_range_chr$pos)), which(val_range_chr$pos == max(val_range_chr$pos))), ]
  }
  
  val_range_chr <- melt(data = val_range_chr, id.vars = c("chr", "pos"))
  val_range_chr$variable <- NULL
  col_dis_rand <- c(brewer.pal(11, 'Set3'), brewer.pal(9, 'Set1')[c(-1, -3, -6)], brewer.pal(8, 'Dark2'), 
                    "chartreuse", "aquamarine", "cornflowerblue", "blue", "cyan", "bisque1", "darkorchid2", 
                    "firebrick1", "gold1", "magenta1", "olivedrab1", "navy", "maroon1", "tan", "yellow3", 
                    "black", "bisque4", "seagreen3", "plum2", "yellow1", "springgreen", "slateblue1", 
                    "lightsteelblue1", "lightseagreen", "limegreen")
					  
  ## *** Set ploting panel ***  
  p1 <- ggplot() + geom_point(data = val_range_chr, aes(pos, value), color = NA)
  yaxis_breaks <- list()
  yaxis_labels <- list()
  
  ## *** Set priority level ***
  indx <- lapply(c("heatmap_gradual", "heatmap_discrete", "rect_gradual", "rect_discrete", "bar", "line", 
                   "segment", "point", "vertical_line", "horizontal_line", "text", "ideogram"), function(x) {
      indx <- which(plot_type %in% x)
      return(indx)
    })
  indx <- unlist(indx)
  
  ## *** Cyclic ploting for all tracks ***  
  for (i in indx) {
    data.track.single <- data.track[[i]]
    data.chr.sub <- data.chr
    if (plot_type[i] %in% c("point", "line")) {
      names(data.track.single)[1:3] <- c("chr", "pos", "value")
      data.track.single$pos <- as.numeric(data.track.single$pos)
    } else if (plot_type[i] %in% c("bar", "rect_gradual", "rect_discrete")) {
      names(data.track.single)[1:4] <- c("chr", "xmin", "xmax", "value")
    } else if (plot_type[i] %in% c("heatmap_gradual", "heatmap_discrete")) {
      raw_names <- colnames(data.track.single)[-c(1:3)]
      names(raw_names) <- paste("v", 1:(ncol(data.track.single) - 3), sep = "")
      colnames(data.track.single) <- c(c("chr", "xmin", "xmax"), paste("v", 1:(ncol(data.track.single) - 3), sep = ""))
      data.track.single <- melt(data.track.single, id = c("chr", "xmin", "xmax"))
      data.track.single$variable <- as.character(data.track.single$variable)
      data.track.single$raw_names <- raw_names[data.track.single$variable]
      data.track.single$variable <- as.numeric(gsub("v", "", data.track.single$variable))
      colnames(data.track.single) <- c("chr", "xmin", "xmax", "value", "color", "raw_names")
    } else if (plot_type[i] %in% "vertical_line") {
      names(data.track.single) <- c("chr", "pos")
      data.track.single$ymin <- 1
      data.track.single$ymax <- 10
      data.track.single$pos <- as.numeric(data.track.single$pos)
    } else if (plot_type[i] %in% "horizontal_line") {
      names(data.track.single) <- "value"
      data.track.single$xmin <- 0
      rep_num <- nrow(data.track.single)
      names(data.chr.sub) <- c("chr", "xmin", "xmax")
      data.chr.sub <- data.chr.sub[, c(1, 3)]
      data.track.single <- data.track.single[rep(rownames(data.track.single), length(unique(data.chr.sub$chr))), ]
      data.track.single$chr <- rep(unique(data.chr.sub$chr), each = rep_num)
      data.track.single <- merge(data.track.single, data.chr.sub, by.x = "chr", all.x = T)
    } else if (plot_type[i] %in% "text") {
      names(data.track.single) <- c("chr", "pos", "value", "symbol")
          data.track.single[c("pos", "value", "symbol")] <- sapply(data.track.single[c("pos", "value", "symbol")],as.numeric)
    } else if (plot_type[i] %in% "segment") {
      names(data.track.single)[1:5] <- c("chr", "xpos1", "ypos1", "xpos2", "ypos2")
          data.track.single[c("xpos1", "ypos1", "xpos2","ypos2")] <- sapply(data.track.single[c("xpos1", "ypos1", "xpos2","ypos2")],as.numeric)
    } else if (plot_type[i] %in% "ideogram") {
      names(data.track.single)[1:5] <- c("chr", "xmin", "xmax", "value1", "value2")
    }
		
		if(plot_type[i] %in% c("bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "horizontal_line", "ideogram")){
		  data.track.single[c("xmin", "xmax")] <- sapply(data.track.single[c("xmin", "xmax")], as.numeric)
		}
	
    ## *** Raw value ***
    if (plot_type[i] %in% c("point", "line", "bar")) {
      data.track.single$raw_value <- data.track.single$value
    }
	
    ## *** Color ***
    if (plot_type[i] %in% c("point", "line", "bar", "segment")) {
      col_typep <- col_type[i]
      if (col_typep == 2) {
        data.track.single <- dat_dis_col(i, color_cus, data.track.single)		  
      } else if (col_typep == 3 & ("color" %in% colnames(data.track.single))) {
        data.track.single <- dat_cus_cols(i, color_mulgp, data.track.single)
        laycolor <- unique(data.track.single$cols)
        data.track.single$raw_color <- data.track.single$color
        data.track.single$color <- data.track.single$cols
        data.track.single$cols <- NULL
      } else if (col_typep == 1 & ("color" %in% colnames(data.track.single))) {
        laycolor <- laycolor.export[which(indx == i)]
        laycolor <- unlist(strsplit(laycolor, "\\."))
        laycolor <- data.frame(group = unique(data.track.single$color), cols = laycolor, stringsAsFactors = F)
        colname <- colnames(data.track.single)
        data.track.single <- merge(data.track.single, laycolor, by.x = "color", by.y = "group", all.x = T)
        data.track.single <- data.track.single[c(colname, "cols")]
        laycolor <- unique(data.track.single$cols)
        data.track.single$raw_color <- data.track.single$color
        data.track.single$color <- data.track.single$cols
        data.track.single$cols <- NULL
      } else{
        laycolor <- laycolor.export[which(indx == i)]
        laycolor <- unlist(strsplit(laycolor, "\\."))
        data.track.single$color <- laycolor
      }
    }
	
    ## *** The color for rect_gradual type ***
    if (plot_type[i] %in% "rect_gradual") {
      rect_cols <<- rect_grad_cols(i, rect_grad_col, col_rect, rect_grad_cus_cols)
    }
	
    ## *** The color for rect_discrete type ***
    if (plot_type[i] %in% "rect_discrete") {
      data.track.single <- dis_type_cols(i, data.track.single, rect_col, plot_type, col_dis_rand, rect_col_dis_cus, rect_col_dis)
      names(data.track.single)[4] <- "raw_color"
      dat_val <<- NULL
      dat_col <<- NULL
      data.track.single <- cols_adjust(i, data.track.single, col_transpt, plot_type, 1)
      rectval_1 <- dat_val
      rectcol_1 <- dat_col
    }	 
    
    ## *** The fill color for heatmap_gradual type ***
    if (plot_type[i] %in% "heatmap_gradual") {
      if (sel_heatmap_col[i] == 1) {
        hmapcols <- gsub('\\"', "", hmap_col[i])
      } else{
        hmapcols <- heatmap_col_cus[i]
      }
      hmapcols <- unlist(strsplit(hmapcols, "\\."))
    }
	
    ## *** The fill color for heatmap_discrete type ***	
    if (plot_type[i] %in% "heatmap_discrete") {		
		  data.track.single <- dis_type_cols(i, data.track.single, hmap_col_dis, plot_type, col_dis_rand, hmap_col_dis_cus)
		  dat_val <<- NULL
		  dat_col <<- NULL
		  data.track.single <- cols_adjust(i, data.track.single, col_transpt, plot_type, 1)
		  hmapval_1 <- dat_val
		  hmapcol_1 <- dat_col
    }
    
    ## *** The fill color for heatmap_discrete type ***	
    if (plot_type[i] %in% c("vertical_line", "horizontal_line")) {
      data.track.single <- dat_dis_col(i, line_color, data.track.single)
    }
	
    ## *** Color transparency ***
    if (!plot_type[i] %in% c("heatmap_gradual", "heatmap_discrete", "text", "rect_gradual", "rect_discrete", "ideogram")) {
      dat_val <<- NULL
      dat_col <<- NULL
      data.track.single <- cols_adjust(i, data.track.single, col_transpt, plot_type, 1)
      labelscol <- dat_val
      breakscol <- dat_col
    }
	
    ## *** Text color ***	
    if (plot_type[i] %in% "text") {
      labelscol <- text_col[i]
    }
	
    ## *** Fill area color ***
    if (plot_type[i] %in% "line") {
      if (fill_area[i] == 1) {
        if (sel_area_type[i] == 1) {
          data.track.single$areacol <- data.track.single$color
        } else{
          areacol <- unlist(strsplit(border_area[i], ","))
          if (length(areacol) == 0) {
            areacol <- rep(NA, length(unique(data.track.single$color)))
          } else{
            areacol <- rep(areacol, length(unique(data.track.single$color)))
            areacol <- areacol[1:length(unique(data.track.single$color))]
          }
          areacol[!areColors(areacol)] <- NA
          names(areacol) <- unique(data.track.single$color)
          data.track.single$areacol <- adjustcolor(areacol[data.track.single$color], alpha.f = col_transpt[i])
        }
      }
    }	 
    
    ## *** Point type and size ***
    if (plot_type[i] %in% "point") {
      if (sel_symbol_point[i] == 1) {
        data.track.single$shape <- as.numeric(symbol_point[i])
      } else if (sel_symbol_point[i] == 2 & (!"shape" %in% names(data.track.single))) {
        data.track.single$shape <- 16
      }
      if (sel_point_size[i] == 1) {
        data.track.single$size <- as.numeric(point_size[i])
      } else if (sel_point_size[i] == 2 & (!"size" %in% names(data.track.single))) {
        data.track.single$size <- 0.8
      }
      breakspch <- unique(data.track.single$shape[!is.na(data.track.single$value)])
      labelspch <- breakspch
      breakscex <- unique(data.track.single$size[!is.na(data.track.single$value)])
      labelscex <- breakscex
    }
	
    ## *** Line type ***
    if (plot_type[i] %in% c("line", "segment", "vertical_line", "horizontal_line")) {
      linetypep <- linetype[i]
      labels_line_type <- linetypep
    }
	
    ## *** Bars direction ***
    if (plot_type[i] %in% "bar") {
      if (all(data.track.single$raw_value < 0)) {
        directbarp <- 2
      } else{
        directbarp <- 1
      }
    }
	
    ## *** Borders ***
    add_borderp <- add_border[i]
    if (add_borderp == 1) {
      border_colp <- border_col[i]
    } else{
      border_colp <- NA
    }
    
    ## *** Legends ***
    add_col_lgd <- "none"; add_size_lgd <- "none"; add_shape_lgd <- "none"; add_line_type_lgd <- "none"
    if (col_lgd[i] == 1) {
      add_col_lgd <- "legend"
      if (col_lgd_mdy_label[i] == 1) {
        col_lgd_label_1 <- lgd_mdy_label(i, col_lgd_label)
        if (!plot_type[i] %in% c("heatmap_gradual", "heatmap_discrete", "text", "rect_gradual", "rect_discrete", "ideogram")) {
          col_lgd_label_1 <- rep(col_lgd_label_1, length(breakscol))[1:length(breakscol)]
          names(col_lgd_label_1) <- labelscol
          data.track.single$raw_color <- as.character(data.track.single$raw_color)
          data.track.single$raw_color <- col_lgd_label_1[data.track.single$raw_color]
          labelscol <- unname(col_lgd_label_1)
          data.track.single$raw_color <- factor(data.track.single$raw_color, levels = unique(labelscol), ordered = T)
        } else if (plot_type[i] %in% "rect_discrete") {
          col_lgd_label_1 <- rep(col_lgd_label_1, length(rectcol_1))[1:length(rectcol_1)]
          names(col_lgd_label_1) <- rectval_1
          data.track.single$raw_color <- as.character(data.track.single$raw_color)
          data.track.single$raw_color <- col_lgd_label_1[data.track.single$raw_color]
          rectval_1 <- unname(col_lgd_label_1)
          data.track.single$raw_color <- factor(data.track.single$raw_color, levels = unique(rectval_1), ordered = T)
        } else if (plot_type[i] %in% "heatmap_discrete") {
          col_lgd_label_1 <- rep(col_lgd_label_1, length(hmapcol_1))[1:length(hmapcol_1)]
          names(col_lgd_label_1) <- hmapval_1
          hmapval_1 <- unname(col_lgd_label_1)
        } else if (plot_type[i] %in% "text") {
          labelscol <- col_lgd_label_1[1]
        }
      }
    }
    if (plot_type[i] %in% "point" && size_lgd[i] == 1) {
      add_size_lgd <- "legend"
      if (size_lgd_mdy_label[i] == 1) {
        size_lgd_labelp <- lgd_mdy_label(i, size_lgd_label)
        labelscex <- rep(size_lgd_labelp, length(breakscex))[1:length(breakscex)]
      }
    }
    if (plot_type[i] %in% "point" && shape_lgd[i] == 1) {
      add_shape_lgd <- "legend"
      if (shape_lgd_mdy_label[i] == 1) {
        shape_lgd_labelp <- lgd_mdy_label(i, shape_lgd_label)
        labelspch <- rep(shape_lgd_labelp, length(breakspch))[1:length(breakspch)]
      }
    }
    if (plot_type[i] %in% c("vertical_line", "horizontal_line") && line_type_lgd[i] == 1) {
      add_line_type_lgd <- "legend"
      if (line_type_lgd_mdy_label[i] == 1) {
        line_type_lgd_labelp <- lgd_mdy_label(i, line_type_lgd_label)
        labels_line_type <- rep(line_type_lgd_labelp, length(linetypep))[1:length(linetypep)]
      }
    }
		 
    ## *** Legend of fill area ***
    if (plot_type[i] %in% "line" & fill_area[i] == 1 & add_col_lgd %in% "legend") {
      data.track.single$raw_areacol <- as.character(data.track.single$raw_color)
      raw_areacol_1 <- unique(data.track.single$raw_areacol[!is.na(data.track.single$value)])
      areacol_1 <- data.track.single$areacol[match(raw_areacol_1, data.track.single$raw_areacol)]
      raw_areacol_1 <- raw_areacol_1[!duplicated(areacol_1)]
      areacol_1 <- areacol_1[!duplicated(areacol_1)]
      data.track.single$areacol <- factor(data.track.single$areacol, levels = areacol_1, ordered = T)
      data.track.single$raw_areacol <- factor(data.track.single$raw_areacol, levels = raw_areacol_1, ordered = T)
    }
	
    ## *** Number of chromosomes ***
    data.track.single$layer <- layer_index[i]
    data.track.single <- merge(data.track.single, track_layout, by.x = "layer", by.y = "num", all.x = T)
    if (!plot_type[i] %in% c("rect_gradual", "rect_discrete", "heatmap_gradual", 
                             "heatmap_discrete", "vertical_line", "ideogram")) {
      min_val <- val_range$min_val[val_range$layer == layer_index[i]]
      max_val <- val_range$max_val[val_range$layer == layer_index[i]]            
			
      if (min_val > 0 & plot_type[i] %in% "horizontal_line" & length(which(layer_index == layer_index[i])) == 1) {
        fold_1 <- abs(as.numeric(height_layer[names(height_layer) == layer_index[i]]) / (1.02 * max_val))
      } else{
        if (max_val != min_val) {
          fold_1 <- abs(as.numeric(height_layer[names(height_layer) == layer_index[i]]) / (1.02 * (max_val - min_val)))
        } else if (max_val == min_val & max_val == 0) {
          fold_1 <- abs(as.numeric(height_layer[names(height_layer) == layer_index[i]]) / 1.02)
        } else if (max_val == min_val & max_val != 0) {
          fold_1 <- abs(as.numeric(height_layer[names(height_layer) == layer_index[i]]) / (1.02 * max_val))
        }
      }
			
      if (min_val < 0) {
        minnum_1 <- unique(abs(min_val) * fold_1 + data.track.single$ystart)
      } else{
        minnum_1 <- unique(data.track.single$ystart)
      }
      minnum_p <- minnum_1
			
      if (plot_type[i] %in% "segment") {
        if (min_val < 0) {
          data.track.single$ypos1 <- data.track.single$ypos1 + abs(min_val)
          data.track.single$ypos2 <- data.track.single$ypos2 + abs(min_val)
        }
        data.track.single$ypos1 <- data.track.single$ypos1 * fold_1 + data.track.single$ystart
        data.track.single$ypos2 <- data.track.single$ypos2 * fold_1 + data.track.single$ystart
      } else{
        if (min_val < 0) {
          data.track.single$value <- data.track.single$value + abs(min_val)
        }
        data.track.single$yvalue <- data.track.single$value * fold_1 + data.track.single$ystart
      }
      minnum_p <- minnum_1
    }
		  
    if (plot_type[i] %in% "heatmap_gradual") {
      fold_2 <- as.numeric(height_layer[names(height_layer) == layer_index[i]]) / max(data.track.single$value, na.rm = T)
      data.track.single$yvalue <- fold_2 * data.track.single$value - fold_2 / 2 + data.track.single$ystart[1]
    }
    
    if (plot_type[i] %in% "heatmap_discrete") {
      fold_2 <- as.numeric(height_layer[names(height_layer) == layer_index[i]]) / max(as.numeric(as.character(data.track.single$value)), na.rm = T)
      data.track.single$yvalue1 <- fold_2 * as.numeric(as.character(data.track.single$value)) - fold_2 + data.track.single$ystart[1]
      data.track.single$yvalue2 <- fold_2 * as.numeric(as.character(data.track.single$value)) + data.track.single$ystart[1]
    }
		  
    if (plot_type[i] %in% c("heatmap_gradual", "heatmap_discrete")) {
      data.track.single$xpos <- (data.track.single$xmin + data.track.single$xmax) / 2
      data.track.single$width <- (data.track.single$xmax - data.track.single$xpos) * 2
    }
		if (plot_type[i] %in% c("bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "ideogram")) {
		  data.track.single$xmin <- data.track.single$xmin + chr.cum.len[data.track.single$chr]
		  data.track.single$xmax <- data.track.single$xmax + chr.cum.len[data.track.single$chr]
		}  
		  
    if (plot_type[i] %in% c("heatmap_gradual", "heatmap_discrete")) {
      data.track.single$xpos <- (data.track.single$xmin + data.track.single$xmax) / 2
      data.track.single$width <- (data.track.single$xmax - data.track.single$xpos) * 2
    }		
		
    data.track.single.lgd <- data.track.single
    ## *** Fix the chromosomes order ***
    data.track.single$chr.f <- factor(data.track.single$chr, levels = chr_order, ordered = T)
	
    data.track.single.lgd$chr <- factor(data.track.single.lgd$chr, levels = names(chr.cum.len), ordered = T)
	
    ## *** The position of concatenated chromosomes ***
    if (plot_type[i] %in% c("point", "line", "vertical_line", "text")) {
      data.track.single.lgd$pos <- data.track.single.lgd$pos + chr.cum.len[data.track.single.lgd$chr]
    } else if (plot_type[i] %in% "horizontal_line") {
      data.track.single.lgd$xmax <- data.track.single.lgd$xmax + chr.cum.len[data.track.single.lgd$chr]
      data.track.single.lgd <- data.track.single.lgd[c("chr", "xmin", "xmax", "yvalue", "color")]
      data.track.single.lgd <- data.track.single.lgd[which(data.track.single.lgd$xmax == max(data.track.single.lgd$xmax, na.rm = T)),]
    } else if (plot_type[i] %in% "segment") {
      data.track.single.lgd$xpos1 <- data.track.single.lgd$xpos1 + chr.cum.len[data.track.single.lgd$chr]
      data.track.single.lgd$xpos2 <- data.track.single.lgd$xpos2 + chr.cum.len[data.track.single.lgd$chr]
    } else if (plot_type[i] %in% c("rect_gradual", "rect_discrete", "ideogram")) {
      data.chr.ideo <- data.chr
      data.chr.ideo$start <- data.chr.ideo$start + chr.cum.len[data.chr.ideo$chr]
      data.chr.ideo$size <- data.chr.ideo$size + chr.cum.len[data.chr.ideo$chr]
    }
		
    data.track.single.lgd$chr <- as.character(data.track.single.lgd$chr)
    
    ## *** Concatenated chromosomes or Separated chromosomes ***
    if (chr_plotype == 1) {
      data.track.single <- data.track.single.lgd
    }
	
    ## *** Point ***
    if (plot_type[i] %in% "point") {
      if (any(c(add_col_lgd, add_size_lgd, add_shape_lgd) %in% "legend")) {
        if (is.numeric(labelscex)) {
          labelscex <- sprintf("%.1f", sort(labelscex))
        }
			  if(lgd_pos==1){
		      lg1 <- ggplot() + geom_point(data = data.track.single.lgd, aes(pos, yvalue, color = color, shape = as.character(shape), size = size)) + 
		        scale_color_identity(name = col_lgd_name[i],guide = add_col_lgd,breaks = breakscol,labels = labelscol) + 
		        scale_size_identity(name = size_lgd_name[i], guide = add_size_lgd, breaks = sort(breakscex), labels = labelscex) + 
		        scale_shape_manual(name = shape_lgd_name[i], guide = add_shape_lgd, values = sort(breakspch), labels = sort(labelspch)) + 
		        theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA)) + 
		        guides(color = guide_legend(order = 1), size = guide_legend(order = 2))
			  }else{
		      lg1 <- ggplot() + geom_point(data = data.track.single.lgd, aes(pos, yvalue, color = color, shape = as.character(shape), size = size)) + 
		        scale_color_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = breakscol, labels = labelscol) + 
		        scale_size_identity(name = size_lgd_name[i], guide = add_size_lgd, breaks = sort(breakscex), labels = labelscex) + 
		        scale_shape_manual(name = shape_lgd_name[i], guide = add_shape_lgd, values = sort(breakspch), labels = sort(labelspch)) + 
		        theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA)) + 
		        guides(color = guide_legend(order = 1), size = guide_legend(order = 2))			 
			  }
        assign(paste("legend", i, sep = ""), g_legend(lg1))
      } else{
        assign(paste("legend", i, sep = ""), NA)
      }
      for (f in unique(data.track.single$chr)) {
        dat <- data.track.single[data.track.single$chr %in% f, ]
        p1 <- p1 + geom_point(data = dat, aes(pos, yvalue), color = as.character(dat$color), shape = dat$shape, size = as.numeric(dat$size))
      }
    }
	
    ## *** Line ***
    if (plot_type[i] %in% "line") {
      if (length(unique(data.track.single.lgd$color)) > 1) {
        linetypep <- "solid"
      }
      if (fill_area[i] == 2) {
        if (add_col_lgd %in% "legend") {
          if (lgd_pos == 1) {
		        lg1 <- ggplot() + geom_line(data = data.track.single.lgd, aes(pos, yvalue, color = color), size = line_size[i], linetype = linetypep) + 
		          scale_color_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = breakscol, labels = labelscol) + 
		          theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
          } else{
		        lg1 <- ggplot() + geom_line(data = data.track.single.lgd, aes(pos, yvalue, color = color), size = line_size[i], linetype = linetypep) + 
		          scale_color_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = breakscol, labels = labelscol) + 
		          theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))					 
					}
          assign(paste("legend", i, sep = ""), g_legend(lg1))
        } else{
          assign(paste("legend", i, sep = ""), NA)
        }
        
        for (f in unique(data.track.single$chr)) {
          for (j in unique(data.track.single$color[data.track.single$chr %in% f])) {
            dat <- data.track.single[data.track.single$chr %in% f & data.track.single$color %in% j, ]
            p1 <- p1 + geom_line(data = dat, aes(pos, yvalue), color = as.character(dat$color), size = line_size[i], linetype = linetypep)
          }
        }
      } else{
        if (add_col_lgd %in% "legend") {
          if (lgd_pos == 1) {
					  lg1 <- ggplot() + geom_line(data = data.track.single.lgd, aes(pos, yvalue), color = as.character(data.track.single.lgd$color), size=line_size[i], linetype = linetypep) + 
					    geom_area(data = data.track.single.lgd, aes(x = pos, y = yvalue, fill = areacol)) + 
					    scale_fill_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = areacol_1, labels = raw_areacol_1) + 
					    theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
          } else{
            lg1 <- ggplot() + geom_line(data = data.track.single.lgd, aes(pos, yvalue), color = as.character(data.track.single.lgd$color), size = line_size[i], linetype = linetypep) + 
              geom_area(data = data.track.single.lgd, aes(x = pos, y = yvalue, fill = areacol)) + 
              scale_fill_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = areacol_1, labels = raw_areacol_1) + 
              theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))					 
          }
          assign(paste("legend", i, sep = ""), g_legend(lg1))
        } else{
          assign(paste("legend", i, sep = ""), NA)
        }
        for (f in unique(data.track.single$chr)) {
          for (j in unique(data.track.single$color[data.track.single$chr %in% f])) {
            dat <- data.track.single[data.track.single$chr %in% f & data.track.single$color %in% j, ]
            p1 <- p1 + geom_line(data = dat, aes(pos, yvalue), color = as.character(j), size = line_size[i], linetype = linetypep) + 
              geom_ribbon(data = dat, aes(x = pos), ymin = pmin(dat$yvalue, minnum_p), fill = unique(as.character(dat$areacol)), ymax = minnum_p) + 
              geom_ribbon(data = dat, aes(x = pos), ymax = pmax(dat$yvalue, minnum_p), fill = unique(as.character(dat$areacol)), ymin = minnum_p)
          }
        }
      }
    }
    
    ## *** Bar ***
    if (plot_type[i] %in% "bar") {
      if (max(data.track[[i]][, 4], na.rm = T) <= 0 | min(data.track[[i]][, 4], na.rm = T) >= 0) {
        if (directbarp == 1) {
          if (length(which(layer_index == layer_index[i])) > 1) {
            if (add_col_lgd %in% "legend") {
              if (lgd_pos == 1) {
                lg1 <- ggplot() + geom_rect(data = data.track.single.lgd, aes(xmin = xmin, xmax = xmax, ymax = yvalue, fill = color), ymin = data.track.single.lgd$ystart + minnum_1, color = border_colp) + 
                  scale_fill_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = breakscol, labels = labelscol) + 
                  theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
              } else{
                lg1 <- ggplot() + geom_rect(data = data.track.single.lgd, aes(xmin = xmin, xmax = xmax, ymax = yvalue, fill = color), ymin = data.track.single.lgd$ystart + minnum_1, color = border_colp) + 
                  scale_fill_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = breakscol, labels = labelscol) + 
                  theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))							
              }
              assign(paste("legend", i, sep = ""), g_legend(lg1))
            } else{
              assign(paste("legend", i, sep = ""), NA)
            }
            for (f in unique(data.track.single$chr)) {
              for (j in unique(data.track.single$color[data.track.single$chr %in% f])) {
                dat <- data.track.single[data.track.single$chr %in% f & data.track.single$color %in% j, ]						
                p1 <- p1 + geom_rect(data = dat, aes(xmin = xmin, xmax = xmax, ymax = yvalue), ymin = dat$ystart[1], fill = as.character(dat$color), color = border_colp)
              }
            }
          } else{
            if (add_col_lgd %in% "legend") {
              if (lgd_pos == 1) {
                lg1 <- ggplot() + geom_rect(data = data.track.single.lgd, aes(xmin = xmin, xmax = xmax, ymin = ystart, ymax = yvalue, fill = color), color = border_colp) + 
                  scale_fill_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = breakscol, labels = labelscol) + 
                  theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
              } else{
                lg1 <- ggplot() + geom_rect(data = data.track.single.lgd, aes(xmin = xmin, xmax = xmax, ymin = ystart, ymax = yvalue, fill = color), color = border_colp) + 
                  scale_fill_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = breakscol, labels = labelscol) + 
                  theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))							
              }
              assign(paste("legend", i, sep = ""), g_legend(lg1))
            } else{
              assign(paste("legend", i, sep = ""), NA)
            }
            for (f in unique(data.track.single$chr)) {
              for (j in unique(data.track.single$color[data.track.single$chr %in% f])) {
                dat <- data.track.single[data.track.single$chr %in% f & data.track.single$color %in% j, ]							
						    p1 <- p1 + geom_rect(data = dat, aes(xmin = xmin, xmax = xmax, ymin = ystart, ymax = yvalue), fill = as.character(dat$color), color = border_colp)
              }
            }
          }
        } else if (directbarp == 2) {
          if (add_col_lgd %in% "legend") {
            if (lgd_pos == 1) {
              lg1 <- ggplot() + geom_rect(data = data.track.single.lgd, aes(xmin = xmin, xmax = xmax, ymax = yvalue, fill = color), ymin = minnum_1, color = border_colp) + 
                scale_fill_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = breakscol, labels=labelscol) + 
                theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
            } else{
              lg1 <- ggplot() + geom_rect(data = data.track.single.lgd, aes(xmin = xmin, xmax = xmax, ymax = yvalue, fill = color), ymin = minnum_1, color = border_colp) + 
                scale_fill_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = breakscol, labels = labelscol) + 
                theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))						
            }
            assign(paste("legend", i, sep = ""), g_legend(lg1))
          } else{
            assign(paste("legend", i, sep = ""), NA)
          }
          for (f in unique(data.track.single$chr)) {
            for (j in unique(data.track.single$color[data.track.single$chr %in% f])) {
              dat <- data.track.single[data.track.single$chr %in% f & data.track.single$color %in% j, ]						
              p1 <- p1 + geom_rect(data = dat, aes(xmin = xmin, xmax = xmax, ymax = yvalue), ymin = minnum_p, fill = as.character(dat$color), color = border_colp)
            }
          }
        }
      } else{
        if (min_val < 0) {
          if (add_col_lgd %in% "legend") {
            if (lgd_pos == 1) {
              lg1 <- ggplot() + geom_rect(data = data.track.single.lgd, aes(xmin = xmin, xmax = xmax, ymax = yvalue, fill = color), ymin = minnum_1, color = border_colp) + 
                scale_fill_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = breakscol, labels = labelscol) + 
                theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
            } else{
              lg1 <- ggplot() + geom_rect(data = data.track.single.lgd, aes(xmin = xmin, xmax = xmax, ymax = yvalue, fill = color), ymin = minnum_1, color = border_colp) + 
                scale_fill_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = breakscol, labels = labelscol) + 
                theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size,face = lgd_text_font_face), legend.key = element_rect(fill = NA))						
            }
            assign(paste("legend", i, sep = ""), g_legend(lg1))
          } else{
            assign(paste("legend", i, sep = ""), NA)
          }
          for (f in unique(data.track.single$chr)) {
            for (j in unique(data.track.single$color[data.track.single$chr %in% f])) {
              dat <- data.track.single[data.track.single$chr %in% f & data.track.single$color %in% j, ]						
              p1 <- p1 + geom_rect(data = dat, aes(xmin = xmin, xmax = xmax, ymax = yvalue), ymin = minnum_p, fill = as.character(dat$color), color = border_colp)
            }
          }
        } else{
          if (add_col_lgd %in% "legend") {
            if (lgd_pos == 1) {
              lg1 <- ggplot() + geom_rect(data = data.track.single.lgd, aes(xmin = xmin, xmax = xmax, ymin = ystart, ymax = yvalue, fill = color), color = border_colp) + 
                scale_fill_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = breakscol, labels = labelscol) + 
                theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
            } else{
              lg1 <- ggplot() + geom_rect(data = data.track.single.lgd, aes(xmin = xmin, xmax = xmax, ymin = ystart, ymax = yvalue, fill = color), color = border_colp) + 
                scale_fill_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = breakscol, labels = labelscol) + 
                theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))						
            }
            assign(paste("legend", i, sep = ""), g_legend(lg1))
          } else{
            assign(paste("legend", i, sep = ""), NA)
          }
          for (f in unique(data.track.single$chr)) {
            for (j in unique(data.track.single$color[data.track.single$chr %in% f])) {
              dat <- data.track.single[data.track.single$chr %in% f & data.track.single$color %in% j, ]						
              p1 <- p1 + geom_rect(data = dat, aes(xmin = xmin, xmax = xmax, ymin = ystart, ymax = yvalue), fill = as.character(dat$color), color = border_colp)
            }
          }
        }
      }
    }
    
    ## *** Rect_gradual ***
    if (plot_type[i] %in% "rect_gradual") {
      if (is.numeric(data.track.single.lgd$value)) {
        midpoint <- mean(data.track.single.lgd$value, na.rm = T)
        if (lgd_pos == 1) {
          lg1 <- ggplot() + geom_rect(data = data.track.single.lgd, aes(xmin = xmin, xmax = xmax, ymin = ystart, ymax = yend, fill = value), color = border_colp) + 
            scale_fill_gradient2(name = col_lgd_name[i], low = rect_cols[1], midpoint = midpoint, mid = rect_cols[2], high = rect_cols[3], na.value = "#FFFFFF00") + 
            theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
        } else{
          lg1 <- ggplot() + geom_rect(data = data.track.single.lgd, aes(xmin = xmin, xmax = xmax, ymin = ystart, ymax = yend, fill = value), color = border_colp) + 
            scale_fill_gradient2(name = col_lgd_name[i], low = rect_cols[1], midpoint = midpoint, mid = rect_cols[2], high = rect_cols[3], na.value = "#FFFFFF00") + 
            theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA)) + 
            guides(fill = guide_colourbar(title.vjust = 0.8, title.hjust = 0.4))
        }
        g1 <- ggplot_build(lg1)
        data.track.single$fillcol <- g1$data[[1]][, "fill"]
        if (add_col_lgd %in% "legend") {
          assign(paste("legend", i, sep = ""), g_legend(lg1))
        } else{
          assign(paste("legend", i, sep = ""), NA)
        }				 
			  p1 <- p1 + geom_rect(data = data.track.single, aes(xmin = xmin, xmax = xmax, ymin = ystart, ymax = yend), fill = as.character(data.track.single$fillcol), color = border_colp)		 
      } else{
        assign(paste("legend", i, sep = ""), NA)
      }
    }
	
    ## *** Rect_discrete ***
    if (plot_type[i] %in% "rect_discrete") {
      if (lgd_pos == 1) {
        lg1 <- ggplot() + geom_rect(data = data.track.single.lgd, aes(xmin = xmin, xmax = xmax, ymin = ystart, ymax = yend, fill = color), color = border_colp) + 
          scale_fill_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = rectcol_1, labels = rectval_1) + 
          theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))				 
      } else{
        lg1 <- ggplot() + geom_rect(data = data.track.single.lgd, aes(xmin = xmin, xmax = xmax, ymin = ystart, ymax = yend, fill = color), color = border_colp) + 
          scale_fill_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = rectcol_1, labels = rectval_1) + 
          theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
      }
      if (add_col_lgd %in% "legend") {
        assign(paste("legend", i, sep = ""), g_legend(lg1))
      } else{
        assign(paste("legend", i, sep = ""), NA)
      }
      for (f in unique(data.track.single$chr)) {
        dat <- data.track.single[data.track.single$chr %in% f,]
			  p1 <- p1 + geom_rect(data = dat, aes(xmin = xmin, xmax = xmax, ymin = ystart, ymax = yend), fill = as.character(dat$color), color = border_colp)
      }
    }
	
    ## *** Heatmap_gradual ***
    if (plot_type[i] %in% "heatmap_gradual") {
      midpoint <- mean(data.track.single.lgd$color, na.rm = T)
      if (lgd_pos == 1) {
        lg1 <- ggplot() + geom_tile(data = data.track.single.lgd, aes(x = xpos, y = yvalue, fill = color), width = data.track.single.lgd$width, height = as.numeric(height_layer[names(height_layer) == layer_index[i]]), color=border_colp) + 
          scale_fill_gradient2(name = col_lgd_name[i], low = hmapcols[1], midpoint = midpoint, mid = hmapcols[2], high = hmapcols[3], na.value = "#FFFFFF00") + 
          theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
      } else{
        lg1 <- ggplot() + geom_tile(data = data.track.single.lgd, aes(x = xpos, y = yvalue, fill = color), width = data.track.single.lgd$width, height = as.numeric(height_layer[names(height_layer) == layer_index[i]]), color = border_colp) + 
          scale_fill_gradient2(name = col_lgd_name[i], low = hmapcols[1], midpoint = midpoint, mid = hmapcols[2], high = hmapcols[3], na.value = "#FFFFFF00") + 
          theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA)) + 
          guides(fill = guide_colourbar(title.vjust = 0.8, title.hjust = 0.4))
      }
      g1 <- ggplot_build(lg1)
      data.track.single$fillcol <- g1$data[[1]][, "fill"]
      if (add_col_lgd %in% "legend") {
        assign(paste("legend", i, sep = ""), g_legend(lg1))
      } else{
        assign(paste("legend", i, sep = ""), NA)
      }
      for (f in unique(data.track.single$chr)) {
        dat <- data.track.single[data.track.single$chr %in% f, ]
			  p1 <- p1 + geom_tile(data = dat, aes(x = xpos, y = yvalue), width = dat$width, height = fold_2, fill = dat$fillcol, color = border_colp)			
      }
    }
	
    ## *** Heatmap_discrete ***
    if (plot_type[i] %in% "heatmap_discrete") {
      if (lgd_pos == 1) {
        lg1 <- ggplot() + geom_rect(data = data.track.single.lgd, aes(xmin = xmin, xmax = xmax, ymin = ystart, ymax = yend, fill = color), color = border_colp) + 
          scale_fill_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = hmapcol_1, labels = hmapval_1) + 
          theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))				 
      } else{
        lg1 <- ggplot() + geom_rect(data = data.track.single.lgd, aes(xmin = xmin, xmax = xmax, ymin = ystart, ymax = yend, fill = color), color = border_colp) + 
          scale_fill_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = hmapcol_1, labels = hmapval_1) + 
          theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
      }
      if (add_col_lgd %in% "legend") {
        assign(paste("legend", i, sep = ""), g_legend(lg1))
      } else{
        assign(paste("legend", i, sep = ""), NA)
      }
      for (f in unique(data.track.single$chr)) {
        dat <- data.track.single[data.track.single$chr %in% f, ]
			  p1 <- p1 + geom_rect(data = dat, aes(xmin = xmin, xmax = xmax, ymin = yvalue1, ymax = yvalue2), fill = as.character(dat$color), color = border_colp)
      }
    }
    
    ## *** Vertical line ***	
    if (plot_type[i] %in% "vertical_line") {
      if (any(c(add_col_lgd, add_line_type_lgd) %in% "legend")) {
        if (lgd_pos == 1) {
          lg1 <- ggplot() + geom_segment(data = data.track.single.lgd, aes(x = pos, y = ystart, xend = pos, yend = yend, color = color, linetype = linetypep), size = line_size[i]) + 
            scale_color_identity(name = col_lgd_name[i], guide = add_col_lgd,breaks = breakscol, labels = labelscol) + 
            scale_linetype_identity(name = line_type_lgd_name[i], guide = add_line_type_lgd, breaks = as.character(linetypep), labels = labels_line_type) + 
            theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA)) + 
            guides(color = guide_legend(order = 1), linetype = guide_legend(order = 2))
        } else{
          lg1 <- ggplot() + geom_segment(data = data.track.single.lgd, aes(x = pos, y = ystart, xend = pos, yend = yend, color = color, linetype = linetypep), size = line_size[i]) + 
            scale_color_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = breakscol, labels = labelscol) + 
            scale_linetype_identity(name = line_type_lgd_name[i], guide = add_line_type_lgd, breaks = as.character(linetypep), labels = labels_line_type) + 
            theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA)) + 
            guides(color = guide_legend(order = 1), linetype = guide_legend(order = 2))
        }
        assign(paste("legend", i, sep = ""), g_legend(lg1))
      } else{
        assign(paste("legend", i, sep = ""), NA)
      }			
	  p1 <- p1 + geom_segment(data = data.track.single, aes(x = pos, y = ystart, xend = pos, yend = yend), color = as.character(data.track.single$color), size = line_size[i], linetype = linetypep)			
    }
	
    ## *** Horizontal line ***	
    if (plot_type[i] %in% "horizontal_line") {
      if (any(c(add_col_lgd, add_line_type_lgd) %in% "legend")) {
        if (lgd_pos == 1) {
          lg1 <- ggplot() + geom_segment(data = data.track.single.lgd, aes(x = xmin, y = yvalue, xend = xmax, yend = yvalue, color = color, linetype = linetypep), size = line_size[i]) + 
            scale_color_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = breakscol, labels = labelscol) + 
            scale_linetype_identity(name = line_type_lgd_name[i], guide = add_line_type_lgd, breaks = as.character(linetypep), labels = labels_line_type) + 
            theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA)) + 
            guides(color = guide_legend(order = 1), linetype = guide_legend(order = 2))
        } else{
          lg1 <- ggplot() + geom_segment(data = data.track.single.lgd, aes(x = xmin, y = yvalue, xend = xmax, yend = yvalue, color = color, linetype = linetypep), size = line_size[i]) + 
            scale_color_identity(name = col_lgd_name[i], guide = add_col_lgd,breaks = breakscol,labels = labelscol) + 
            scale_linetype_identity(name = line_type_lgd_name[i], guide = add_line_type_lgd, breaks = as.character(linetypep), labels = labels_line_type) + 
            theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA)) + 
            guides(color = guide_legend(order = 1), linetype = guide_legend(order = 2))		
        }
        assign(paste("legend", i, sep = ""), g_legend(lg1))
      } else{
        assign(paste("legend", i, sep = ""), NA)
      }			
		  p1 <- p1 + geom_segment(data = data.track.single, aes(x = xmin, y = yvalue, xend = xmax, yend = yvalue), color = as.character(data.track.single$color), size = line_size[i], linetype = linetypep)			
    }
	
    ## *** Text ***	
    if (plot_type[i] %in% "text") {
      if (add_col_lgd %in% "legend") {
        data.track.single.lgd$color <- text_col[i]
        if (lgd_pos == 1) {
				  lg1 <- ggplot() + geom_text(data = data.track.single.lgd, aes(x = pos, y = yvalue, label = symbol, color = color), size = text_size[i], hjust = 0, angle = text_angle[i], fontface = font_face[i]) + 
				    scale_color_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = text_col[i], labels = labelscol) + 
				    theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
        } else{
				  lg1 <- ggplot() + geom_text(data = data.track.single.lgd, aes(x = pos, y = yvalue, label = symbol, color = color), size = text_size[i], hjust = 0, angle = text_angle[i], fontface = font_face[i]) + 
				    scale_color_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = text_col[i], labels = labelscol) + 
				    theme(legend.position = "bottom", legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA)) 				
        }
        assign(paste("legend", i, sep = ""), g_legend(lg1))
      } else{
        assign(paste("legend", i, sep = ""), NA)
      }
	    p1 <- p1 + geom_text(data = data.track.single, aes(x = pos, y = yvalue, label = symbol), color = text_col[i], size = text_size[i], hjust = 0, angle = text_angle[i], fontface = font_face[i])
    }
	
    ## *** Segment ***		
    if (plot_type[i] %in% "segment") {
      if (length(unique(data.track.single.lgd$color)) > 1) {
        linetypep <- "solid"
      }
      if (add_col_lgd %in% "legend") {
        if (lgd_pos == 1) {
		      lg1 <- ggplot() + geom_segment(data = data.track.single.lgd, aes(x = xpos1, y = ypos1, xend = xpos2, yend = ypos2, color = color), size = line_size[i], linetype = linetypep) + 
		        scale_color_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = breakscol, labels = labelscol) + 
		        theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
        } else{
				  lg1 <- ggplot() + geom_segment(data = data.track.single.lgd, aes(x = xpos1, y = ypos1, xend = xpos2, yend = ypos2, color = color), size = line_size[i], linetype = linetypep) + 
				    scale_color_identity(name = col_lgd_name[i], guide = add_col_lgd, breaks = breakscol, labels = labelscol) + 
				    theme(legend.title = element_text(size = lgd_title_size, face = lgd_title_font_face), legend.text = element_text(size = lgd_text_size, face = lgd_text_font_face), legend.key = element_rect(fill = NA))
        }
        assign(paste("legend", i, sep = ""), g_legend(lg1))
      } else{
        assign(paste("legend", i, sep = ""), NA)
      }
      for (f in unique(data.track.single$chr)) {
        for (j in unique(data.track.single$color[data.track.single$chr %in% f])) {
          dat <- data.track.single[data.track.single$chr %in% f & data.track.single$color %in% j, ]
          if (add_arrow[i] == 1) {
            if (arrow_pos[i] == 1) {
              p1 <- p1 + geom_segment(data = dat, aes(x = xpos1, y = ypos1, xend = xpos2, yend = ypos2), color = as.character(dat$color), size = line_size[i], linetype = linetypep, arrow = arrow(length = unit(arrow_size[i], "inches")))				 
            } else{
              p1 <- p1 + geom_segment(data = dat, aes(x = xpos2, y = ypos2, xend = xpos1, yend = ypos1), color = as.character(dat$color), size = line_size[i], linetype = linetypep, arrow = arrow(length = unit(arrow_size[i], "inches")))				 
            }
          } else{
            p1 <- p1 + geom_segment(data = dat, aes(x = xpos1, y = ypos1, xend = xpos2, yend = ypos2), color = as.character(dat$color), size = line_size[i], linetype = linetypep)
          }
        }
      }
    }
    
    ## *** Ideogram ***	
    if (plot_type[i] %in% "ideogram") {
      assign(paste("legend", i, sep = ""), NA)
      data.track.single <- data.track.single[data.track.single$chr %in% data.chr$chr, ]
      data.track.single$col <- cytoband.col(data.track.single$value2)
      p1 <- p1 + geom_rect(data=data.track.single, aes(xmin = xmin, xmax = xmax, ymin = ystart, ymax = yend, fill = col, color = col))
      if (chr_plotype == 2) {
        data.chr.ideo <- data.chr
      }
      data.chr.ideo$chr.f <- factor(data.chr.ideo$chr, levels = chr_order, ordered = T)
      p1 <- p1 + geom_rect(data = data.chr.ideo, aes(xmin = start, xmax = size), ymin = unique(data.track.single$ystart), ymax = unique(data.track.single$yend), color = "black", fill = NA)			
			p1 <- p1 + scale_fill_identity() + scale_color_identity()
      p1 <- p1 + scale_y_continuous(breaks = NULL)
    }
    if (plot_type[i] %in% c("point", "line", "bar")) {
      if (ylabel[i] == 1) {
        yaxis_breaks <- c(yaxis_breaks, list(c(layer_index[i], range(data.track.single$yvalue))))
        yaxis_labels <- c(yaxis_labels, list(c(layer_index[i], round(range(data.track.single$raw_value), 2))))
      }
    }
  }
  
  ## *** Plot theme ***
  alltheme_sty <-
    list(
      theme_bw(), theme_classic(), theme_minimal(), theme_few(), theme_grey(), theme_tufte(),
      theme_calc(), theme_void(), theme_base(), theme_linedraw(), theme_economist(), theme_excel(),
      theme_fivethirtyeight(), theme_gdocs(), theme_hc(), theme_pander(), theme_solarized(), theme_wsj()
    )
  p1 <- p1 + alltheme_sty[[as.numeric(gsub("theme", "", theme_sty))]]
  
  ## *** The chromosome axis label ***
  if (chr_plotype == 1 & xlabel == 1) {
    x_text <- data.chr
    x_text$pos <- (x_text$start + x_text$size) / 2
    x_text$chr <- factor(x_text$chr, levels = names(chr.cum.len), ordered = T)
    x_text$pos <- x_text$pos + chr.cum.len[x_text$chr]
    x_text$chr <- as.character(x_text$chr)
    p1 <- p1 + scale_x_continuous(breaks = x_text$pos, labels = x_text$chr)
  } else if (xlabel == 2) {
    if (plot_direct == 1) {
      p1 <- p1 + theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())
    } else{
      p1 <- p1 + theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())		  
    }
  }	  
  
  ## *** Y value axis label ***  
  if (any(plot_type %in% c("point", "line", "bar")) && any(ylabel[plot_type %in% c("point", "line", "bar")] == 1)) {
    yaxis_breaks <- as.data.frame(do.call(rbind, yaxis_breaks), stringsAsFactors = F)
    names(yaxis_breaks) <- c("layer", "min_val", "max_val")
    yaxis_labels <- as.data.frame(do.call(rbind, yaxis_labels), stringsAsFactors = F)
    names(yaxis_labels) <- c("layer", "min_val", "max_val")
    yaxis_breaks <- ddply(yaxis_breaks, .(layer), function(x) {
      xmin <- min(x$min_val, na.rm = T)
      xmax <- max(x$max_val, na.rm = T)
      rs <- c(x$layer[1], xmin, xmax)
      return(rs)
    })
    yaxis_labels <- ddply(yaxis_labels, .(layer), function(x) {
      xmin <- min(x$min_val, na.rm = T)
      xmax <- max(x$max_val, na.rm = T)
      rs <- c(x$layer[1], xmin, xmax)
      return(rs)
    })
    yaxis_breaks <- yaxis_breaks[, -2]
    yaxis_labels <- yaxis_labels[, -2]
    names(yaxis_breaks) <- c("layer", "min_val", "max_val")
    names(yaxis_labels) <- c("layer", "min_val", "max_val")
	  p1 <- p1 + scale_y_continuous(breaks = c(yaxis_breaks$min_val, yaxis_breaks$max_val), labels = c(yaxis_labels$min_val, yaxis_labels$max_val))
  } else{
    if (plot_direct == 1) {
      p1 <- p1 + theme(axis.text.y = element_blank(), axis.ticks.y = element_blank())
    } else{
      p1 <- p1 + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank())		  
    }
  }
  
  ## *** The x and y axis title ***
  p1 <- p1 + xlab(xtitle) + ylab(ytitle)
  
  ## *** Font face ***
  p1 <- p1 + theme(axis.title = element_text(face = title_font_face))
  
  ## *** Font size ***
  p1 <- p1 + theme(text = element_text(size = font_size))
  
  ## *** Orientation ***
  if (plot_direct == 2) {
    p1 <- p1 + coord_flip()
  }
  
  ## *** Lay out panels ***
  if (chr_plotype == 2) {
    if (plot_direct == 2) {
      p1 <- p1 + facet_grid(. ~ chr.f)
    } else{
      p1 <- p1 + facet_grid(chr.f ~ .)
    }
  }
  
  ## *** Legend ***
  legends <- NA
  lgd_width <- 0
  for (g in length(data.track):1) {
    if (!all(is.na(get(paste("legend", g, sep = ""))))) {
      if (all(is.na(legends))) {
        lgd_width <- 0
      } else{
        lgd_width <- lgd_width + lgd_intra_size
      }
      if (lgd_pos == 1) {
        legends <- arrangeGrob(legends, get(paste("legend", g, sep = "")), heights = unit.c(unit(lgd_width, "mm"), unit(lgd_intra_size, "mm")))
        legends <- legends[!is.na(legends$grobs), ]
      } else{
        legends <- arrangeGrob(legends, get(paste("legend", g, sep = "")), widths = unit.c(unit(lgd_width, "mm"), unit(lgd_intra_size, "mm")))
        legends <- legends[, !is.na(legends$grobs)]
      }
    }
  }
  if (all(!is.na(legends)) && !all(is.na(legends$grobs))) {
    if (lgd_pos == 1) {
      p1 <- arrangeGrob(p1, legends, widths = c(1.05 - lgd_space_size, lgd_space_size + 0.05), ncol = 2)
    } else{
      p1 <- arrangeGrob(p1, legends, heights = c(1.05 - lgd_space_size, lgd_space_size + 0.05), nrow = 2)
    }
  }
  return(p1)
}