
options(scipen = 5)

shinyServer(function(input, output, session) {
  observe({
    if (input$submit1 > 0) {
      isolate({
        Height <<- input$Height; Width <<- input$Width; chr_plotype <<- input$plotype
        plot_direct <<- input$plot_direct; theme_sty <<- input$theme_sty;font_size <<- input$font_size
        xtitle <<- input$xtitle; ytitle <<- input$ytitle; title_font_face <<- input$title_font_face
        xlabel <<- input$xlabel; lgd_pos <<- input$lgd_pos; lgd_space_size <<- input$lgd_space_size
        lgd_intra_size <<- input$lgd_intra_size; lgd_title_size <<- input$lgd_title_size
        lgd_title_font_face <<- input$lgd_title_font_face; lgd_text_font_face <<- input$lgd_text_font_face
        lgd_text_size <<- input$lgd_text_size; chr_data <<- input$upload_chr_data

        if (!is.null(input$upload_chr_data)) {
          data.chr <<- data.frame(fread(chr_data$datapath), stringsAsFactors = F)
        } else{
          data.chr <<- NULL
        }

        sel_upload_data.export <<- c()
        upload_file.export <<- c()

        data.track <<- lapply(1:10, function(x) {
          assign(paste("sel_upload_data", x, sep = ""), input[[paste("sel_upload_data", x, sep = "")]])
          sel_upload_data.export <<- c(sel_upload_data.export, get(paste("sel_upload_data", x, sep = "")))
          trackfil <- input[[paste("uploaddata", x, sep = "")]]
          if (get(paste("sel_upload_data", x, sep = "")) == 2 & !is.null(trackfil)) {
            upload_file.export <<- c(upload_file.export, trackfil$name)
            data.frame(fread(trackfil$datapath), stringsAsFactors = F)
          }
        })

        upload_file.export_1 <<- sel_upload_data.export
        upload_file.export_1[upload_file.export_1 == 2] <<- upload_file.export
        upload_file.export <<- upload_file.export_1
        track_indx <<- which(!unlist(lapply(data.track, is.null)))
        data.track <<- data.track[track_indx]

        if (length(data.track) == 0) {
          data.track <<- NULL
        }

        if (!is.null(data.track)) {
          plot_type <<- c(); col_type <<- c(); color_cus <<- c(); color_mulgp <<- c(); col_transpt <<- c()
          height_layer <<- c(); margin_layer <<- c(); add_border <<- c(); border_col <<- c(); rect_col <<- c()
          rect_col_dis <<- c(); rect_col_dis_cus <<- c(); rect_grad_col <<- c(); col_rect <<- c(); ylabel <<- c()
          sel_heatmap_col <<- c(); hmap_col <<- c(); heatmap_col_cus <<- c(); rect_grad_cus_cols <<- c()
          hmap_col_dis <<- c(); hmap_col_dis_cus <<- c(); symbol_point <<- c(); sel_symbol_point <<- c()
          point_size <<- c(); sel_point_size <<- c(); line_color <<- c(); line_size <<- c(); fill_area <<- c()
          sel_area_type <<- c(); border_area <<- c(); linetype <<- c(); add_arrow <<- c(); arrow_pos <<- c()
          arrow_size <<- c(); text_col <<- c(); text_size <<- c(); font_face <<- c(); text_angle <<- c()
          col_lgd <<- c(); col_lgd_name <<- c(); size_lgd <<- c(); size_lgd_name <<- c(); shape_lgd <<- c()
          shape_lgd_name <<- c(); line_type_lgd <<- c(); line_type_lgd_name <<- c(); col_lgd_mdy_label <<- c()
          col_lgd_label <<- c(); size_lgd_mdy_label <<- c(); size_lgd_label <<- c(); shape_lgd_mdy_label <<- c()
          shape_lgd_label <<- c(); line_type_lgd_mdy_label <<- c(); line_type_lgd_label <<- c(); layer_index <<- c()

          for (k in 1:length(data.track)) {
            plot_type <<- c(plot_type, input[[paste("plot_type", track_indx[k], sep = "")]])
            layer_index <<- c(layer_index, input[[paste("layer_index", track_indx[k], sep = "")]])
            col_type <<- c(col_type, input[[paste("col_type", track_indx[k], sep = "")]])
            color_cus <<- c(color_cus, input[[paste("color_cus", track_indx[k], sep = "")]])
            color_mulgp <<- c(color_mulgp, input[[paste("color_mulgp", track_indx[k], sep = "")]])
            col_transpt <<- c(col_transpt, input[[paste("col_transpt", track_indx[k], sep = "")]])
            add_border <<- c(add_border, input[[paste("add_border", track_indx[k], sep = "")]])
            border_col <<- c(border_col, input[[paste("border_col", track_indx[k], sep = "")]])
            rect_col <<- c(rect_col, input[[paste("rect_col", track_indx[k], sep = "")]])
            rect_col_dis <<- c(rect_col_dis, input[[paste("rect_col_dis", track_indx[k], sep = "")]])
            rect_col_dis_cus <<- c(rect_col_dis_cus, input[[paste("rect_col_dis_cus", track_indx[k], sep = "")]])
            rect_grad_col <<- c(rect_grad_col, input[[paste("rect_grad_col", track_indx[k], sep = "")]])
            col_rect <<- c(col_rect, input[[paste("col_rect", track_indx[k], sep = "")]])
            sel_heatmap_col <<- c(sel_heatmap_col, input[[paste("sel_heatmap_col", track_indx[k], sep = "")]])
            hmap_col <<- c(hmap_col, input[[paste("hmap_col", track_indx[k], sep = "")]])
            heatmap_col_cus <<- c(heatmap_col_cus, paste(input[[paste("lowColor", track_indx[k], sep = "")]],
                                                 input[[paste("midColor", track_indx[k], sep = "")]],
                                                 input[[paste("highColor", track_indx[k], sep = "")]], sep = "."))
            rect_grad_cus_cols <<- c(rect_grad_cus_cols, paste(input[[paste("rect_lowColor", track_indx[k], sep = "")]],
                                                           input[[paste("rect_midColor", track_indx[k], sep = "")]],
                                                           input[[paste("rect_highColor", track_indx[k], sep = "")]], sep = "."))
            hmap_col_dis <<- c(hmap_col_dis, input[[paste("hmap_col_dis", track_indx[k], sep = "")]])
            hmap_col_dis_cus <<- c(hmap_col_dis_cus, input[[paste("hmap_col_dis_cus", track_indx[k], sep = "")]])
            symbol_point <<- c(symbol_point, input[[paste("symbol_point", track_indx[k], sep = "")]])
            sel_symbol_point <<- c(sel_symbol_point, input[[paste("sel_symbol_point", track_indx[k], sep = "")]])
            point_size <<- c(point_size, input[[paste("point_size", track_indx[k], sep = "")]])
            sel_point_size <<- c(sel_point_size, input[[paste("sel_point_size", track_indx[k], sep = "")]])
            line_color <<- c(line_color, input[[paste("line_color", track_indx[k], sep = "")]])
            line_size <<- c(line_size, input[[paste("line_size", track_indx[k], sep = "")]])
            fill_area <<- c(fill_area, input[[paste("fill_area", track_indx[k], sep = "")]])
            sel_area_type <<- c(sel_area_type, input[[paste("sel_area_type", track_indx[k], sep = "")]])
            border_area <<- c(border_area, input[[paste("border_area", track_indx[k], sep = "")]])
            linetype <<- c(linetype, input[[paste("linetype", track_indx[k], sep = "")]])
            add_arrow <<- c(add_arrow, input[[paste("add_arrow", track_indx[k], sep = "")]])
            arrow_pos <<- c(arrow_pos, input[[paste("arrow_pos", track_indx[k], sep = "")]])
            arrow_size <<- c(arrow_size, input[[paste("arrow_size", track_indx[k], sep = "")]])
            text_col <<- c(text_col, input[[paste("text_col", track_indx[k], sep = "")]])
            text_size <<- c(text_size, input[[paste("text_size", track_indx[k], sep = "")]])
            font_face <<- c(font_face, input[[paste("font_face", track_indx[k], sep = "")]])
            text_angle <<- c(text_angle, input[[paste("text_angle", track_indx[k], sep = "")]])
            col_lgd <<- c(col_lgd, input[[paste("col_lgd", track_indx[k], sep = "")]])
            col_lgd_name <<- c(col_lgd_name, input[[paste("col_lgd_name", track_indx[k], sep = "")]])
            size_lgd <<- c(size_lgd, input[[paste("size_lgd", track_indx[k], sep = "")]])
            size_lgd_name <<- c(size_lgd_name, input[[paste("size_lgd_name", track_indx[k], sep = "")]])
            shape_lgd <<- c(shape_lgd, input[[paste("shape_lgd", track_indx[k], sep = "")]])
            shape_lgd_name <<- c(shape_lgd_name, input[[paste("shape_lgd_name", track_indx[k], sep = "")]])
            line_type_lgd <<- c(line_type_lgd, input[[paste("line_type_lgd", track_indx[k], sep = "")]])
            line_type_lgd_name <<- c(line_type_lgd_name, input[[paste("line_type_lgd_name", track_indx[k], sep = "")]])
            col_lgd_mdy_label <<- c(col_lgd_mdy_label, input[[paste("col_lgd_mdy_label", track_indx[k], sep = "")]])
            col_lgd_label <<- c(col_lgd_label, input[[paste("col_lgd_label", track_indx[k], sep = "")]])
            size_lgd_mdy_label <<- c(size_lgd_mdy_label, input[[paste("size_lgd_mdy_label", track_indx[k], sep = "")]])
            size_lgd_label <<- c(size_lgd_label, input[[paste("size_lgd_label", track_indx[k], sep = "")]])
            shape_lgd_mdy_label <<- c(shape_lgd_mdy_label, input[[paste("shape_lgd_mdy_label", track_indx[k], sep = "")]])
            shape_lgd_label <<- c(shape_lgd_label, input[[paste("shape_lgd_label", track_indx[k], sep = "")]])
            line_type_lgd_mdy_label <<- c(line_type_lgd_mdy_label, input[[paste("line_type_lgd_mdy_label", track_indx[k], sep = "")]])
            line_type_lgd_label <<- c(line_type_lgd_label, input[[paste("line_type_lgd_label", track_indx[k], sep = "")]])
            ylabel <<- c(ylabel, input[[paste("ylabel", track_indx[k], sep = "")]])
          }

          for (i in sort(as.numeric(gsub("track", "", layer_index)))) {
            height_layer <<- c(height_layer, input[[paste("height_layer", i, sep = "")]])
            margin_layer <<- c(margin_layer, input[[paste("margin_layer", i, sep = "")]])
          }

          output$errorinfo1 <- renderPrint({
            validate(need(!is.null(data.chr), "Please upload genome data!"))
            validate(need(!is.null(data.track), "Please upload track data!"))
            if (!is.null(data.track)) {
              for (m in 1:length(data.track)) {
                dt.TT <- data.track[[m]]
                if (plot_type[m] %in% c("point", "line", "bar", "rect_gradual", "rect_discrete",
                                        "heatmap_gradual", "heatmap_discrete", "text", "segment")) {
                  validate(need(
                    ncol(dt.TT) >= 3,
                    paste(
                      "Error: Data formatting error for Data", track_indx[m], "!",
                      " Please upload applicable data.", sep = ""
                    )
                  ))
                  if (plot_type[m] %in% c("point", "line", "bar") && col_type[m] == 2) {
                    validate(need(
                      areColors(color_cus[m]),
                      paste(
                        "Error: Data color error for Data", track_indx[m], "!",
                        " Please input applicable color name.", sep = ""
                      )
                    ))
                  }
                }
                if (plot_type[m] %in% "rect_gradual") {
                  validate(need(
                    is.numeric(dt.TT[, 4]),
                    paste(
                      "Error: Data formatting error for Data", track_indx[m], "!",
                      " For gradual data, the 4th column should be a numeric vector.",
                      " Please upload applicable data.", sep = ""
                    )
                  ))
                }
                if (plot_type[m] %in% "rect_discrete") {
                  validate(need(
                    length(unique(dt.TT[, 4])) <= 50,
                    paste(
                      "Error: Data formatting error for Data", track_indx[m], "!",
                      " For discrete data, the 4th column should be a categorical character vector with no more than 50 groups.",
                      " Please upload applicable data.", sep = ""
                    )
                  ))
                }
                if (plot_type[m] %in% "segment") {
                  validate(need(
                    ncol(dt.TT) == 5 | (ncol(dt.TT) == 6 && names(dt.TT)[6] == "color"),
                    paste(
                      "Error: Data formatting error for Data", track_indx[m], "!",
                      " Please upload applicable data.", sep = ""
                    )
                  ))
                }
                if (plot_type[m] %in% "vertical_line") {
                  validate(need(
                    ncol(dt.TT) == 2,
                    paste(
                      "Error: Data formatting error for Data", track_indx[m], "!",
                      " Please upload applicable data.", sep = ""
                    )
                  ))
                  validate(need(
                    areColors(line_color[m]),
                    paste(
                      "Error: Line color error for Data", track_indx[m], "!",
                      " Please input applicable color name.", sep = ""
                    )
                  ))
                }
                if (plot_type[m] %in% "horizontal_line") {
                  validate(need(
                    ncol(dt.TT) == 1,
                    paste(
                      "Error: Data formatting error for Data", track_indx[m], "!",
                      " Please upload applicable data.", sep = ""
                    )
                  ))
                  validate(need(
                    areColors(line_color[m]),
                    paste(
                      "Error: Line color error for Data", track_indx[m], "!",
                      " Please input applicable color name.", sep = ""
                    )
                  ))
                }
              }
            }
          })
          outputOptions(output, "errorinfo1", suspendWhenHidden = FALSE)

          single_genome_plot(
            input = input, output = output, data.chr = data.chr, data.track = data.track, track_indx = track_indx,
            chr_plotype = chr_plotype, plot_type = plot_type, plot_direct = plot_direct, layer_index = layer_index,
            Height = Height, Width = Width, col_type = col_type, color_cus = color_cus, color_mulgp = color_mulgp,
            col_transpt = col_transpt, height_layer = height_layer, margin_layer = margin_layer, theme_sty = theme_sty,
            font_size = font_size, xtitle = xtitle, ytitle = ytitle, title_font_face = title_font_face, xlabel = xlabel,
            ylabel = ylabel, lgd_pos = lgd_pos, lgd_space_size = lgd_space_size, lgd_intra_size = lgd_intra_size,
            lgd_title_size = lgd_title_size, lgd_title_font_face = lgd_title_font_face, lgd_text_font_face = lgd_text_font_face,
            lgd_text_size = lgd_text_size, add_border = add_border, border_col = border_col, rect_col = rect_col,
            rect_col_dis = rect_col_dis, rect_col_dis_cus = rect_col_dis_cus, rect_grad_col = rect_grad_col, col_rect = col_rect,
            sel_heatmap_col = sel_heatmap_col, hmap_col = hmap_col, heatmap_col_cus = heatmap_col_cus,
            rect_grad_cus_cols = rect_grad_cus_cols, hmap_col_dis = hmap_col_dis, hmap_col_dis_cus = hmap_col_dis_cus,
            symbol_point = symbol_point, sel_symbol_point = sel_symbol_point, point_size = point_size,
            sel_point_size = sel_point_size, line_color = line_color, line_size = line_size, fill_area = fill_area,
            sel_area_type = sel_area_type, border_area = border_area, linetype = linetype, add_arrow = add_arrow,
            arrow_pos = arrow_pos, arrow_size = arrow_size, text_col = text_col, text_size = text_size, font_face = font_face,
            text_angle = text_angle, col_lgd = col_lgd, col_lgd_name = col_lgd_name, size_lgd = size_lgd, size_lgd_name = size_lgd_name,
            shape_lgd = shape_lgd, shape_lgd_name = shape_lgd_name, line_type_lgd = line_type_lgd, line_type_lgd_name = line_type_lgd_name,
            col_lgd_mdy_label = col_lgd_mdy_label, col_lgd_label = col_lgd_label, size_lgd_mdy_label = size_lgd_mdy_label,
            size_lgd_label = size_lgd_label, shape_lgd_mdy_label = shape_lgd_mdy_label, shape_lgd_label = shape_lgd_label,
            line_type_lgd_mdy_label = line_type_lgd_mdy_label, line_type_lgd_label = line_type_lgd_label
          )
        }
      })
    } else {
      NULL
    }
  })

  observe({
    if (input$submit2 > 0) {
      isolate({
        tc_Height <<- input$tc_Height; tc_Width <<- input$tc_Width; tc_theme_sty <<- input$tc_theme_sty
        tc_font_size <<- input$tc_font_size; tc_xtitle <<- input$tc_xtitle; tc_ytitle <<- input$tc_ytitle
        tc_title_font_face <<- input$tc_title_font_face; tc_xlabel <<- input$tc_xlabel; tc_ylabel <<- input$tc_ylabel
        tc_lgd_pos <<- input$tc_lgd_pos; tc_lgd_title_size <<- input$tc_lgd_title_size
        tc_lgd_title_font_face <<- input$tc_lgd_title_font_face; tc_lgd_text_font_face <<- input$tc_lgd_text_font_face
        tc_lgd_text_size <<- input$tc_lgd_text_size; tc_chr_data1 <<- input$tc_upload_chr_data_1
        tc_chr_data2 <<- input$tc_upload_chr_data_2

        if (!is.null(tc_chr_data1)) {
          data.chr1 <<- data.frame(fread(tc_chr_data1$datapath), stringsAsFactors = F)
        } else{
          data.chr1 <<- NULL
        }

        if (!is.null(tc_chr_data2)) {
          data.chr2 <<- data.frame(fread(tc_chr_data2$datapath), stringsAsFactors = F)
        } else{
          data.chr2 <<- NULL
        }

        trackfil <<- input$tc_uploaddata
        if (!is.null(trackfil)) {
          data.2geno.plot <<- data.frame(fread(trackfil$datapath), stringsAsFactors = F)
        } else{
          data.2geno.plot <<- NULL
        }

        if (!is.null(data.2geno.plot)) {
          tc_plot_type <<- input$tc_plot_type; tc_sel_gral_col <<- input$tc_sel_gral_col; tc_gral_col_tp <<- input$tc_gral_col
          tc_gral_col_ct <<- c(input$tc_lowColor, input$tc_midColor, input$tc_highColor); tc_col_type <<- input$tc_col_type
          tc_color_cus <<- input$tc_color_cus; tc_color_mulgp <<- input$tc_color_mulgp; tc_col_transpt <<- input$tc_col_transpt
          tc_symbol_point <<- input$tc_symbol_point; sel_tc_symbol_point_type <<- input$sel_tc_symbol_point_type
          tc_point_size <<- input$tc_point_size; sel_tc_point_size_type <<- input$sel_tc_point_size_type
          tc_line_size <<- input$tc_line_size; tc_vertical <<- input$tc_vertical; tc_vertical_col <<- input$tc_vertical_col
          tc_vertical_size <<- input$tc_vertical_size; tc_vertical_type <<- input$tc_vertical_type
          tc_horizontal <<- input$tc_horizontal; tc_horizontal_col <<- input$tc_horizontal_col
          tc_horizontal_size <<- input$tc_horizontal_size; tc_horizontal_type <<- input$tc_horizontal_type
          tc_add_border <<- input$tc_add_border; tc_border_col <<- input$tc_border_col; tc_line_type <<- input$tc_line_type
          tc_col_lgd <<- input$tc_col_lgd; tc_col_lgd_name <<- input$tc_col_lgd_name; tc_size_lgd <<- input$tc_size_lgd
          tc_size_lgd_name <<- input$tc_size_lgd_name; tc_shape_lgd <<- input$tc_shape_lgd
          tc_shape_lgd_name <<- input$tc_shape_lgd_name; tc_col_lgd_mdy_label <<- input$tc_col_lgd_mdy_label
          tc_col_lgd_label <<- input$tc_col_lgd_label; tc_size_lgd_mdy_label <<- input$tc_size_lgd_mdy_label
          tc_size_lgd_label <<- input$tc_size_lgd_label; tc_shape_lgd_mdy_label <<- input$tc_shape_lgd_mdy_label
          tc_shape_lgd_label <<- input$tc_shape_lgd_label

          output$errorinfo6 <- renderPrint({
            validate(need(!is.null(data.chr1), "Please upload genome1 data!"))
            validate(need(!is.null(data.chr2), "Please upload genome2 data!"))
            if (input$tc_plot_type %in% c("point_gradual", "point_discrete")) {
              validate(
                need(
                  ncol(data.2geno.plot) == 4 | (ncol(data.2geno.plot) > 4 && all(names(data.2geno.plot)[5:ncol(data.2geno.plot)] %in% c("color", "shape", "size"))),
                  "Error: Data formatting error! Please upload applicable plot data."
                )
              )
            }
            if (input$tc_plot_type %in% "segment") {
              validate(
                need(
                  ncol(data.2geno.plot) == 6 | (ncol(data.2geno.plot) == 7 && names(data.2geno.plot)[7] == "color"),
                  "Error: Data formatting error! Please upload applicable plot data."
                )
              )
            }
            if (input$tc_plot_type %in% "point_gradual") {
              validate(
                need(
                  is.numeric(data.2geno.plot[, "color"]),
                  'Error: Data formatting error! For gradual data, the "color" column should be a numeric vector. Please upload applicable plot data.'
                )
              )
            }
            if (input$tc_plot_type %in% "point_discrete") {
              validate(
                need((
                  "color" %in% names(data.2geno.plot) && length(unique(data.2geno.plot[, "color"])) <= 50) | !"color" %in% names(data.2geno.plot),
                'Error: Data formatting error! For discrete data, the "color" column should be a categorical character vector with no more than 50 groups. Please upload applicable plot data.'
                )
              )
            }
            if (input$tc_plot_type %in% "rect_gradual") {
              validate(
                need(
                  ncol(data.2geno.plot) == 7 && is.numeric(data.2geno.plot[, "color"]),
                  'Error: Data formatting error! Data should contain 7 columns. For gradual data, the "color" column should be a numeric vector. Please upload applicable plot data.'
                )
              )
            }
            if (input$tc_plot_type %in% "rect_discrete") {
              validate(
                need(
                  ncol(data.2geno.plot) == 6 | (ncol(data.2geno.plot) == 7 && names(data.2geno.plot)[7] == "color" && length(unique(data.2geno.plot[, "color"])) <= 50),
                  'Error: Data formatting error! Data should contain 6 columns or 7 columns. For discrete data with 7 columns, the "color" column should be a categorical character vector with no more than 50 groups. Please upload applicable plot data.'
                )
              )
            }
          })
          outputOptions(output, "errorinfo6", suspendWhenHidden = FALSE)

          two_genomes_plot(
            input = input, output = output, data.chr1 = data.chr1, data.chr2 = data.chr2, data.2geno.plot = data.2geno.plot,
            Height = tc_Height, Width = tc_Width, sel_gral_col = tc_sel_gral_col, gral_col_tp = tc_gral_col_tp,
            gral_col_ct = tc_gral_col_ct, col_type = tc_col_type, color_cus = tc_color_cus, color_mulgp = tc_color_mulgp,
            col_transpt = tc_col_transpt, theme_sty = tc_theme_sty, font_size = tc_font_size, xtitle = tc_xtitle,
            ytitle = tc_ytitle, title_font_face = tc_title_font_face, xlabel = tc_xlabel, ylabel = tc_ylabel,
            lgd_pos = tc_lgd_pos,lgd_title_size = tc_lgd_title_size, lgd_title_font_face = tc_lgd_title_font_face,
            lgd_text_font_face = tc_lgd_text_font_face, lgd_text_size = tc_lgd_text_size, symbol_point = tc_symbol_point,
            symbol_point_type = sel_tc_symbol_point_type, point_size = tc_point_size, point_size_type = sel_tc_point_size_type,
            line_size = tc_line_size, vertical = tc_vertical, vertical_col = tc_vertical_col, vertical_size = tc_vertical_size,
            vertical_type = tc_vertical_type, horizontal = tc_horizontal, horizontal_col = tc_horizontal_col, plot_type = tc_plot_type,
            horizontal_size = tc_horizontal_size, horizontal_type = tc_horizontal_type, border_col = tc_border_col,
            add_border = tc_add_border, linetype = tc_line_type, col_lgd = tc_col_lgd, col_lgd_name = tc_col_lgd_name,
            size_lgd = tc_size_lgd, size_lgd_name = tc_size_lgd_name, shape_lgd = tc_shape_lgd, shape_lgd_name = tc_shape_lgd_name,
            col_lgd_mdy_label = tc_col_lgd_mdy_label, col_lgd_label = tc_col_lgd_label, size_lgd_mdy_label = tc_size_lgd_mdy_label,
            size_lgd_label = tc_size_lgd_label, shape_lgd_mdy_label = tc_shape_lgd_mdy_label, shape_lgd_label = tc_shape_lgd_label
          )
        }
      })
    } else {
      NULL
    }
  })

  ## *** Download PDF file ***
  output$downloadpdf1 <- renderUI({
    req(input$submit1)
    downloadButton("Visualization_1.pdf", "Download pdf-file")
  })

  output$Visualization_1.pdf <- downloadHandler(
    filename <- function() {
      paste('Visualization_1.pdf')
    },
    content <- function(file) {
      pdf(file, width = input$Width / 72, height = input$Height / 72)
      print(figure_1)
      dev.off()
    }, contentType = 'application/pdf')

  output$downloadpdf2 <- renderUI({
    req(input$submit2)
    downloadButton("Visualization_2.pdf", "Download pdf-file")
  })

  output$Visualization_2.pdf <- downloadHandler(
    filename <- function() {
      paste('Visualization_2.pdf')
    },
    content <- function(file) {
      pdf(file, width = input$tc_Width / 72, height = input$tc_Height / 72)
      print(figure_2)
      dev.off()
    }, contentType = 'application/pdf')

  ## *** Download SVG file ***
  output$downloadsvg1 <- renderUI({
    req(input$submit1)
    downloadButton("Visualization_1.svg", "Download svg-file")
  })

  output$Visualization_1.svg <- downloadHandler(
    filename <- function() {
      paste('Visualization_1.svg')
    },
    content <- function(file) {
      svg(file, width = input$Width / 72, height = input$Height / 72)
      print(figure_1)
      dev.off()
    }, contentType = 'image/svg')

  output$downloadsvg2 <- renderUI({
    req(input$submit2)
    downloadButton("Visualization_2.svg", "Download svg-file")
  })

  output$Visualization_2.svg <- downloadHandler(
    filename <- function() {
      paste('Visualization_2.svg')
    },
    content <- function(file) {
      svg(file, width = input$tc_Width / 72, height = input$tc_Height / 72)
      print(figure_2)
      dev.off()
    }, contentType = 'image/svg')

  ## *** Download Source code file ***
  output$downloadscript1 <- renderUI({
    req(input$submit1)
    downloadButton("Script_1.R", "Download the R scripts to reproduce the plot")
  })

  output$Script_1.R <- downloadHandler(
    filename <- function() {
    paste('Script_1.R')
  },
  content <- function(file) {
    source("writeCmd-1.R")
    writeLines(out, con = file)
  }, contentType = NULL)

  output$downloadscript2 <- renderUI({
    req(input$submit2)
    downloadButton("Script_2.R", "Download the R scripts to reproduce the plot")
  })

  output$Script_2.R <- downloadHandler(
    filename <- function() {
    paste('Script_2.R')
  },
  content <- function(file) {
    source("writeCmd-2.R")
    writeLines(out, con = file)
  }, contentType = NULL)

  ## *** Download data file ***
  output$data.zip <- downloadHandler(
    filename <- function() {
    paste("data.zip")
  },
  content <- function(file) {
    file.copy("www/data.zip", file)
  }, contentType = "application/zip")

  ## *** Download example data ***
  output$genome_data.txt <- downloadHandler(
    filename <- function() {
    paste('genome_data.txt')
  },
  content <- function(file) {
    input_file <- "www/data/download_example_data/single_genome/genome_data.txt"
    example_dat <- read.table(input_file, head = T, as.is = T, sep = "\t", quote = "")
    write.table(example_dat, file = file, row.names = F, quote = F, sep = "\t")
  }, contentType = 'text/csv')

  output$genome1_data.txt <- downloadHandler(
    filename <- function() {
    paste('genome1_data.txt')
  },
  content <- function(file) {
    input_file <- "www/data/download_example_data/two_genome/genome1_data.txt"
    example_dat <- read.table(input_file, head = T, as.is = T, sep = "\t", quote = "")
    write.table(example_dat, file = file, row.names = F, quote = F, sep = "\t")
  }, contentType = 'text/csv')

  output$genome2_data.txt <- downloadHandler(
    filename <- function() {
    paste('genome2_data.txt')
  },
  content <- function(file) {
    input_file <- "www/data/download_example_data/two_genome/genome2_data.txt"
    example_dat <- read.table(input_file, head = T, as.is = T, sep = "\t", quote = "")
    write.table(example_dat, file = file, row.names = F, quote = F, sep = "\t")
  }, contentType = 'text/csv')

  output$example_data1.txt <- downloadHandler(
    filename <- function() {
      paste('example_data1.txt')
    },
    content <- function(file) {
      input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type1, ".txt")
      example_dat <- read.table(input_file, head = T, as.is = T, sep = "\t", quote = "")
      write.table(example_dat, file = file, row.names = F, quote = F, sep = "\t")
    }, contentType = 'text/csv')

  output$example_data2.txt <- downloadHandler(
    filename <- function() {
      paste('example_data2.txt')
    },
    content <- function(file) {
      input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type2, ".txt")
      example_dat <- read.table(input_file, head = T, as.is = T, sep = "\t", quote = "")
      write.table(example_dat, file = file, row.names = F, quote = F, sep = "\t")
    }, contentType = 'text/csv')

  output$example_data3.txt <- downloadHandler(
    filename <- function() {
      paste('example_data3.txt')
    },
    content <- function(file) {
      input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type3, ".txt")
      example_dat <- read.table(input_file, head = T, as.is = T, sep = "\t", quote = "")
      write.table(example_dat, file = file, row.names = F, quote = F, sep = "\t")
    }, contentType = 'text/csv')

  output$example_data4.txt <- downloadHandler(
    filename <- function() {
      paste('example_data4.txt')
    },
    content <- function(file) {
      input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type4, ".txt")
      example_dat <- read.table(input_file, head = T, as.is = T, sep = "\t", quote = "")
      write.table(example_dat, file = file, row.names = F, quote = F, sep = "\t")
    }, contentType = 'text/csv')

  output$example_data5.txt <- downloadHandler(
    filename <- function() {
      paste('example_data5.txt')
    },
    content <- function(file) {
      input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type5, ".txt")
      example_dat <- read.table(input_file, head = T, as.is = T, sep = "\t", quote = "")
      write.table(example_dat, file = file, row.names = F, quote = F, sep = "\t")
    }, contentType = 'text/csv')

  output$example_data6.txt <- downloadHandler(
    filename <- function() {
      paste('example_data6.txt')
    },
    content <- function(file) {
      input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type6, ".txt")
      example_dat <- read.table(input_file, head = T, as.is = T, sep = "\t", quote = "")
      write.table(example_dat, file = file, row.names = F, quote = F, sep = "\t")
    }, contentType = 'text/csv')

  output$example_data7.txt <- downloadHandler(
    filename <- function() {
      paste('example_data7.txt')
    },
    content <- function(file) {
      input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type7, ".txt")
      example_dat <- read.table(input_file, head = T, as.is = T, sep = "\t", quote = "")
      write.table(example_dat, file = file, row.names = F, quote = F, sep = "\t")
    }, contentType = 'text/csv')

  output$example_data8.txt <- downloadHandler(
    filename <- function() {
      paste('example_data8.txt')
    },
    content <- function(file) {
      input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type8, ".txt")
      example_dat <- read.table(input_file, head = T, as.is = T, sep = "\t", quote = "")
      write.table(example_dat, file = file, row.names = F, quote = F, sep = "\t")
    }, contentType = 'text/csv')

  output$example_data9.txt <- downloadHandler(
    filename <- function() {
      paste('example_data9.txt')
    },
    content <- function(file) {
      input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type9, ".txt")
      example_dat <- read.table(input_file, head = T, as.is = T, sep = "\t", quote = "")
      write.table(example_dat, file = file, row.names = F, quote = F, sep = "\t")
    }, contentType = 'text/csv')

  output$example_data10.txt <- downloadHandler(
    filename <- function() {
      paste('example_data10.txt')
    },
    content <- function(file) {
      input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type10, ".txt")
      example_dat <- read.table(input_file, head = T, as.is = T, sep = "\t", quote = "")
      write.table(example_dat, file = file, row.names = F, quote = F, sep = "\t")
    }, contentType = 'text/csv')

  output$example_plot_data.txt <- downloadHandler(
    filename <- function() {
      paste('example_plot_data.txt')
    },
    content <- function(file) {
      input_file <- paste0("www/data/download_example_data/two_genome/", input$tc_plot_type, ".txt")
      example_dat <- read.table(input_file, head = T, as.is = T, sep = "\t", quote = "")
      write.table(example_dat, file = file, row.names = F, quote = F, sep = "\t")
    }, contentType = 'text/csv')
  
  ## *** Manual ***
  output$pdfview <- renderUI({
    tags$iframe(style = "height:1500px; width:100%; scrolling=yes", src = "shinyChromosome_Help_Manual.pdf")
  })

  ## *** View example data ***
  output$Table1 <- renderDataTable({
    x <- fread("www/data/download_example_data/single_genome/genome_data.txt")
    return(x)
  }, options = list(pageLength = 10))

  output$Table2 <- renderDataTable({
    input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type1, ".txt")
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength = 10))

  output$Table3 <- renderDataTable({
    input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type2, ".txt")
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength = 10))

  output$Table4 <- renderDataTable({
    input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type3, ".txt")
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength = 10))

  output$Table5 <- renderDataTable({
    input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type4, ".txt")
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength = 10))

  output$Table6 <- renderDataTable({
    input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type5, ".txt")
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength = 10))

  output$Table7 <- renderDataTable({
    input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type6, ".txt")
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength = 10))

  output$Table8 <- renderDataTable({
    input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type7, ".txt")
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength = 10))

  output$Table9 <- renderDataTable({
    input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type8, ".txt")
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength = 10))

  output$Table10 <- renderDataTable({
    input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type9, ".txt")
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength = 10))

  output$Table11 <- renderDataTable({
    input_file <- paste0("www/data/download_example_data/single_genome/", input$plot_type10, ".txt")
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength = 10))

  output$Table12 <- renderDataTable({
    input_file <- "www/data/download_example_data/two_genome/genome1_data.txt"
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength = 10))

  output$Table13 <- renderDataTable({
    input_file <- "www/data/download_example_data/two_genome/genome2_data.txt"
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength = 10))

  output$Table14 <- renderDataTable({
    input_file <- paste0("www/data/download_example_data/two_genome/", input$tc_plot_type, ".txt")
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength = 10))

})

