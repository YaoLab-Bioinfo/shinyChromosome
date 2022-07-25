
sig_data7 <- conditionalPanel(condition = "input.data7",
                              radioButtons("sel_upload_data7", NULL, c("Disable data input" = "1", "Upload input data" = "2"), "1"),
                              conditionalPanel(condition = "input.sel_upload_data7 == '2'",
                                               selectInput("layer_index7", tags$div(HTML('<i class="fa fa-play" aria-hidden="true"></i> <font size="3" color="red"><b>Track index:</b></font>'),
                                                                              bsButton("bsb195", label="", icon=icon("question"), style="info", size="small")),
                                                           choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
                                               
                                               bsPopover("bsb195", 
                                                         'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.', 
                                                         trigger = "focus"
                                               ),
                                               
                                               selectInput("plot_type7", tags$div(HTML('<i class="fa fa-play" aria-hidden="true"></i> <font size="3" color="red"><b>Plot type:</b></font>')),
                                                           choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", 
                                                                       "text", "segment", "vertical_line", "horizontal_line", "ideogram"), selected = "point"),
                                               
											   fileInput("uploaddata7", 
                                                         h5("Upload data7:",
                                                            bsButton("bsb4", label = "", icon = icon("question"), style = "info", size = "small")
                                                         ), multiple = FALSE),
                                               bsPopover("bsb194", 'Click "Browse" to upload the track data.', trigger = "focus"),
                                               
                                               actionButton("tabBut8", "View example data"),
                                               tags$script('$( "#uploaddata7" ).on( "click", function() { this.value = null; });'),
                                               downloadButton("example_data7.txt", "Example data"),
                                               
                                               br(),
                                               br(),
                                               
                                               conditionalPanel(condition = "input.plot_type7!='ideogram'",
                                                                ADVANCED_OPTIONS_PANEL_7(
                                                                  list(
                                                                    checkboxInput("color_opt7", HTML("<font color='red'>Color</font>"), FALSE),
                                                                    conditionalPanel(condition = "input.color_opt7",
                                                                                     conditionalPanel(condition="input.plot_type7 == 'point' | input.plot_type7 == 'line' | input.plot_type7 == 'bar' | input.plot_type7 == 'segment'",
                                                                                                      selectInput("col_type7", h5("Data color:",
                                                                                                                                  bsButton("bsb196", label="", icon=icon("question"), style="info", size="small")), 
                                                                                                                  c("Random" = "1", "One custom color" = "2", "Custom for data with multi-group" = "3"), selected="1"
                                                                                                      ),
                                                                                                      bsPopover("bsb196",
                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. By default, random assigned color would be used. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.',
                                                                                                                trigger = "focus"
                                                                                                      ),
                                                                                                      conditionalPanel(condition = "input.col_type7=='2'",
                                                                                                                       fluidRow(column(12, colourInput("color_cus7", label = NULL, value = "#FF0000", returnName = TRUE, allowTransparent = TRUE))),
                                                                                                                       br()
                                                                                                      ),
                                                                                                      conditionalPanel(condition = "input.col_type7=='3'",
                                                                                                                       textInput("color_mulgp7", NULL, value="a:red;b:blue;c:cyan")
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type7=='rect_discrete'",
                                                                                                      selectInput("rect_col7", h5("Data color:",
                                                                                                                                  bsButton("bsb197", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected = "1"),
                                                                                                      bsPopover("bsb197",
                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. By default, random assigned color would be used. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.',
                                                                                                                trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.rect_col7=='2'",
                                                                                                                       fluidRow(column(12, colourInput("rect_col_dis7", label = NULL, value = "#FF0000", returnName = TRUE, allowTransparent = TRUE))),
                                                                                                                       br()
                                                                                                      ),
                                                                                                      conditionalPanel(condition = "input.rect_col7=='3'",
                                                                                                                       textInput("rect_col_dis_cus7", NULL, value="a:red;b:blue;c:cyan")
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type7=='rect_gradual'",
                                                                                                      selectInput("rect_grad_col7", h5("Colors:",
                                                                                                                                       bsButton("bsb198", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("Typical" = "1", "Low_high_color" = "2", "Low_middle_high_color" = "3"), selected = "1"),
                                                                                                      bsPopover("bsb198", "Colors to be used for the data, which can be assigned by the application or be specified by the users. By default, predefined color would be used.", trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.rect_grad_col7=='1'",
                                                                                                                       selectInput("col_rect7", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
                                                                                                                                                                  "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
                                                                                                                                                                  "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
                                                                                                                                                                  "navy.cyan", "blue.red", "green.red"))
                                                                                                      ),
                                                                                                      conditionalPanel(condition="input.rect_grad_col7=='2'",
                                                                                                                       fluidRow(			                                                         
                                                                                                                         column(6, colourInput("rect_2cols_low7", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB", returnName = TRUE, allowTransparent = TRUE)), 
                                                                                                                         column(6, colourInput("rect_2cols_high7", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00", returnName = TRUE, allowTransparent = TRUE))), 
                                                                                                                       br()
                                                                                                      ),
                                                                                                      conditionalPanel(condition="input.rect_grad_col7=='3'",
                                                                                                                       fluidRow(			                                                         
                                                                                                                         column(4, colourInput("rect_3cols_low7", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB", returnName = TRUE, allowTransparent = TRUE)), 
                                                                                                                         column(4, colourInput("rect_3cols_mid7", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF", returnName = TRUE, allowTransparent = TRUE)), 
                                                                                                                         column(4, colourInput("rect_3cols_high7", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00", returnName = TRUE, allowTransparent = TRUE))), 
                                                                                                                       br()
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type7=='heatmap_gradual'",
                                                                                                      selectInput("sel_heatmap_col7", h5("Colors:",
                                                                                                                                         bsButton("bsb199", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("Typical" = "1", "Low_high_color" = "2", "Low_middle_high_color" = "3"), selected = "1"),
                                                                                                      bsPopover("bsb199", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users. By default, predefined color would be used.", trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col7=='1'",
                                                                                                                       selectInput("hmap_col7", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
                                                                                                                                                                  "purple.yellow.red", "blue.green.red", "blue.yellow.green",
                                                                                                                                                                  "cyan.white.deeppink1"), selected="blue.white.red")
                                                                                                      ),
                                                                                                      conditionalPanel(condition="input.sel_heatmap_col7=='2'",
                                                                                                                       fluidRow(			                                        
                                                                                                                         column(6, colourInput("hmap_2cols_low7", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB", returnName = TRUE, allowTransparent = TRUE)), 
                                                                                                                         column(6, colourInput("hmap_2cols_high7", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00", returnName = TRUE, allowTransparent = TRUE))),
                                                                                                                       br()
                                                                                                      ),																											  
                                                                                                      conditionalPanel(condition="input.sel_heatmap_col7=='3'",
                                                                                                                       fluidRow(			                                        
                                                                                                                         column(4, colourInput("hmap_3cols_low7", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB", returnName = TRUE, allowTransparent = TRUE)), 
                                                                                                                         column(4, colourInput("hmap_3cols_mid7", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF", returnName = TRUE, allowTransparent = TRUE)), 
                                                                                                                         column(4, colourInput("hmap_3cols_high7", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00", returnName = TRUE, allowTransparent = TRUE))),
                                                                                                                       br()
                                                                                                      )		
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type7=='heatmap_discrete'",
                                                                                                      selectInput("hmap_col_dis7", h5("Data color:",
                                                                                                                                      bsButton("bsb200", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("Random" = "1", "Custom" = "2"), selected = "1"),
                                                                                                      bsPopover("bsb200",
                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. By default, random assigned color would be used. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.',
                                                                                                                trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.hmap_col_dis7=='2'",
                                                                                                                       textInput("hmap_col_dis_cus7", NULL, value="a:red;b:blue;c:cyan")
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type7=='vertical_line' | input.plot_type7=='horizontal_line'",
                                                                                                      fluidRow(column(12, colourInput("line_color7", label = h5('Line color:',
                                                                                                                                                                 bsButton("bsb201", label="", icon=icon("question"), style="info", size="small")), value = "#FF0000", returnName = TRUE, allowTransparent = TRUE))),
                                                                                                      bsPopover("bsb201", 'The color to be used to plot the data.', trigger = "focus"),
                                                                                                      br()
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type7=='line'",
                                                                                                      selectInput("fill_area7", h5("Fill area:",
                                                                                                                                   bsButton("bsb202", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("Yes" = "1", "No" = "2"), selected = "2"),
                                                                                                      bsPopover("bsb202", "Fill the area below the lines.", trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.fill_area7=='1'",
                                                                                                                       radioButtons("sel_area_type7", h5("Area color:",
                                                                                                                                                         bsButton("bsb203", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), c("Identical with lines" = "1", "Specific" = "2"), selected = "1"),
                                                                                                                       bsPopover("bsb203", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.sel_area_type7=='2'",
                                                                                                                                        fluidRow(column(12, colourInput("border_area7", label = NULL, value = "#0000FF", returnName = TRUE, allowTransparent = TRUE))),
                                                                                                                                        br()
                                                                                                                       )
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type7=='point' | input.plot_type7=='line' | input.plot_type7=='bar' | input.plot_type7=='rect_gradual' | input.plot_type7=='rect_discrete' | input.plot_type7=='heatmap_gradual' | input.plot_type7=='heatmap_discrete' | input.plot_type7=='vertical_line' | input.plot_type7=='horizontal_line' | input.plot_type7=='text' | input.plot_type7 == 'segment'",
                                                                                                      conditionalPanel(condition="input.plot_type7=='text'",
                                                                                                                       fluidRow(column(12, colourInput("text_col7", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000", returnName = TRUE, allowTransparent = TRUE))),
                                                                                                                       br()
                                                                                                      ),
                                                                                                      selectInput("col_lgd7", h5("Color legend:",
                                                                                                                                 bsButton("bsb204", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
                                                                                                      bsPopover("bsb204", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.col_lgd7=='1'",
                                                                                                                       textInput("col_lgd_name7", h5("Legend title:",
                                                                                                                                                     bsButton("bsb205", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), value = "color"),
                                                                                                                       bsPopover("bsb205", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.plot_type7!='rect_gradual' & input.plot_type7!='heatmap_gradual'",
                                                                                                                                        selectInput("col_lgd_mdy_label7", h5("Modify legend labels:",
                                                                                                                                                                             bsButton("bsb206", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                        ), c("Yes" = "1", "No" = "2"), "2"),
                                                                                                                                        bsPopover("bsb206",
                                                                                                                                                  'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".',
                                                                                                                                                  trigger = "focus"),
                                                                                                                                        conditionalPanel(condition = "input.col_lgd_mdy_label7=='1'",
                                                                                                                                                         textInput("col_lgd_label7", NULL, value="a,b,c")
                                                                                                                                        )
                                                                                                                       )
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type7!='rect_gradual' & input.plot_type7!='heatmap_gradual' & input.plot_type7!='text' & input.plot_type7!='ideogram'",
                                                                                                      sliderInput("col_transpt7", h5("Color transparency:",
                                                                                                                                     bsButton("bsb207", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), min = 0, max = 1, value = 1, step = 0.1),
                                                                                                      bsPopover("bsb207", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")
                                                                                     )
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition = "input.plot_type7=='line' | input.plot_type7=='vertical_line' | input.plot_type7=='horizontal_line' | input.plot_type7 == 'segment'",
                                                                                     checkboxInput("linetype_opt7", HTML("<font color='red'>Linetype</font>"), FALSE),
                                                                                     conditionalPanel(condition = "input.linetype_opt7",
                                                                                                      sliderInput("line_size7", "Line width:", min=0, max=3, value=0.2, step=0.05),
                                                                                                      selectInput("linetype7", h5("Line type:",
                                                                                                                                  bsButton("bsb208", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("solid", "dashed", "dotted", "dotdash", "longdash", "twodash"), selected = "solid"),
                                                                                                      bsPopover("bsb208", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus"),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.plot_type7=='vertical_line' | input.plot_type7=='horizontal_line'",
                                                                                                                       selectInput("line_type_lgd7", h5("Line type legend:",
                                                                                                                                                        bsButton("bsb209", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), c("Show" = "1", "Hide" = "2"), "2"),
                                                                                                                       bsPopover("bsb209", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.line_type_lgd7=='1'",
                                                                                                                                        textInput("line_type_lgd_name7", h5("Legend title:",
                                                                                                                                                                            bsButton("bsb210", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                        ), value = "linetype"),
                                                                                                                                        bsPopover("bsb210", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
                                                                                                                                        selectInput("line_type_lgd_mdy_label7",
                                                                                                                                                    h5("Modify legend labels:",
                                                                                                                                                       bsButton("bsb211", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                                    ), c("Yes" = "1", "No" = "2"), "2"),
                                                                                                                                        bsPopover("bsb211", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
                                                                                                                                        conditionalPanel(condition = "input.line_type_lgd_mdy_label7=='1'",
                                                                                                                                                         textInput("line_type_lgd_label7", NULL, value="a")
                                                                                                                                        )
                                                                                                                       )
                                                                                                      ),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.plot_type7 == 'segment'",
                                                                                                                       selectInput("add_arrow7", h5("Add arrow head:",
                                                                                                                                                    bsButton("bsb212", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), c("Yes" = "1", "No" = "2"), selected = "2"),
                                                                                                                       bsPopover("bsb212", "Add arrow head for the segment.", trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.add_arrow7 == '1'",
                                                                                                                                        selectInput("arrow_pos7", h5("Arrow position:",
                                                                                                                                                                     bsButton("bsb213", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                        ), c("Line end" = "1", "Line beginning" = "2"), selected = "1"),
                                                                                                                                        bsPopover("bsb213", 'The position of arrow head.',trigger = "focus"),
                                                                                                                                        sliderInput("arrow_size7", h5("Arrow size:",
                                                                                                                                                                      bsButton("bsb214", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                        ), min = 0, max = 2, value = 0.1, step = 0.01),
                                                                                                                                        bsPopover("bsb214", 'The size of arrow head.',trigger = "focus")
                                                                                                                       )
                                                                                                      )
                                                                                     )
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition = "input.plot_type7=='point'",
                                                                                     checkboxInput("symbol_opt7", HTML("<font color='red'>Symbol</font>"), FALSE),
                                                                                     conditionalPanel(condition = "input.symbol_opt7",
                                                                                                      selectInput("sel_symbol_point7", h5("Symbol type:",
                                                                                                                                          bsButton("bsb215", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("One custom symbol" = "1",
                                                                                                           'Custom for data with a "shape" column' = "2"), selected = "1"),
                                                                                                      bsPopover("bsb215",
                                                                                                                'Symbol used for different points. Applicable values are integers in [0-25]. Check <a href="http://www.endmemo.com/program/R/pchsymbols.php" target="_blank">R_pchsymbols</a> for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.',
                                                                                                                trigger = "focus"),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.sel_symbol_point7=='1'",
                                                                                                                       sliderInput("symbol_point7", NULL, min=0, max=25, value=16, step=1)
                                                                                                      ),
                                                                                                      selectInput("shape_lgd7", h5("Symbol legend:",
                                                                                                                                   bsButton("bsb216", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
                                                                                                      bsPopover("bsb216", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.shape_lgd7=='1'",
                                                                                                                       textInput("shape_lgd_name7", h5("Legend title:",
                                                                                                                                                       bsButton("bsb217", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), value = "symbol"),
                                                                                                                       bsPopover("bsb217", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
                                                                                                                       selectInput("shape_lgd_mdy_label7",
                                                                                                                                   h5("Modify legend labels:",
                                                                                                                                      bsButton("bsb218", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                   ), c("Yes" = "1", "No" = "2"), "2"),
                                                                                                                       bsPopover("bsb218",
                                                                                                                                 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".',
                                                                                                                                 trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.shape_lgd_mdy_label7=='1'",
                                                                                                                                        textInput("shape_lgd_label7", NULL, value="a,b,c")
                                                                                                                       )
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     checkboxInput("size_opt7", HTML("<font color='red'>Size</font>"), FALSE),
                                                                                     conditionalPanel(condition="input.size_opt7",
                                                                                                      selectInput("sel_point_size7", h5("Point size:",
                                                                                                                                        bsButton("bsb219", label="", icon=icon("question"), style="info", size="small")),
                                                                                                                  c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected = "1"),
                                                                                                      bsPopover("bsb219",
                                                                                                                'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.',
                                                                                                                trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.sel_point_size7=='1'",
                                                                                                                       sliderInput("point_size7", NULL, min=0, max=5, value=0.8, step=0.1)
                                                                                                      ),
                                                                                                      selectInput("size_lgd7", h5("Size legend:",
                                                                                                                                  bsButton("bsb220", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
                                                                                                      bsPopover("bsb220", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.size_lgd7=='1'",
                                                                                                                       textInput("size_lgd_name7", h5("Legend title:",
                                                                                                                                                      bsButton("bsb221", label="", icon=icon("question"), style="info", size="small")), value = "size"),
                                                                                                                       bsPopover("bsb221", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
                                                                                                                       selectInput("size_lgd_mdy_label7",
                                                                                                                                   h5("Modify legend labels:",
                                                                                                                                      bsButton("bsb222", label="", icon=icon("question"), style="info", size="small")), c("Yes" = "1", "No" = "2"), "2"),
                                                                                                                       bsPopover("bsb222",
                                                                                                                                 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".',
                                                                                                                                 trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.size_lgd_mdy_label7=='1'",
                                                                                                                                        textInput("size_lgd_label7", NULL, value="a,b,c")
                                                                                                                       )
                                                                                                      )
                                                                                     )
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition = "input.plot_type7=='heatmap_gradual' | input.plot_type7=='heatmap_discrete' | input.plot_type7=='rect_gradual' | input.plot_type7=='rect_discrete' | input.plot_type7=='bar'",
                                                                                     selectInput("add_border7", h5("Add cell borders:",
                                                                                                                   bsButton("bsb223", label="", icon=icon("question"), style="info", size="small")
                                                                                     ), c("Yes" = "1", "No" = "2"), selected = "2"),
                                                                                     bsPopover("bsb223", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
                                                                                     conditionalPanel(condition = "input.add_border7=='1'",
                                                                                                      fluidRow(column(12, colourInput("border_col7", label = h5('Borders color:'), value = "#000000", returnName = TRUE, allowTransparent = TRUE))),
                                                                                                      br()
                                                                                     )
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition = "input.plot_type7=='line' | input.plot_type7=='point' | input.plot_type7=='bar'",
                                                                                     selectInput("ylabel7", h5("Y axis label:",
                                                                                                               bsButton("bsb225", label="", icon=icon("question"), style="info", size="small")
                                                                                     ), choices = c("Show" = "1", "Hide" = "2"), selected = "1"),
                                                                                     bsPopover("bsb225", "Add tick labels on the Y-axis.", trigger = "focus")
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition="input.plot_type7=='text'",
                                                                                     checkboxInput("font_opt7", HTML("<font color='red'>Font</font>"), FALSE),
                                                                                     conditionalPanel(condition="input.font_opt7",
                                                                                                      sliderInput("text_size7", "Font size:", min=0, max=10, value=2, step=0.1),
                                                                                                      selectInput("font_face7", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
                                                                                                      sliderInput("text_angle7", "Font angle:", min=0, max=360, value=60, step=1)
                                                                                     )
                                                                    )
                                                                  )
                                                                )
                                               )
                              )
)

