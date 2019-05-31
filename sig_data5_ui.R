
sig_data5 <- conditionalPanel(condition="input.data5",
                              radioButtons("sel_upload_data5", NULL, c("Disable data input" = "1", "Upload input data" = "2"), "1"),
                              conditionalPanel(condition="input.sel_upload_data5 == '2'",
                                               selectInput("layer_index5", h5("Track index:",
                                                                              bsButton("bsb133", label="", icon=icon("question"), style="info", size="small")),
                                                           choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
                                               
                                               bsPopover("bsb133",
                                                         'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.',
                                                         trigger = "focus"
                                               ),
                                               
                                               selectInput("plot_type5", "Plot type:", 
                                                           choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", 
                                                                       "text", "segment", "vertical_line", "horizontal_line", "ideogram"), selected = "point"),
                                               
											   fileInput("uploaddata5", 
                                                         h5("Upload data5:",
                                                            bsButton("bsb4", label = "", icon = icon("question"), style = "info", size = "small")
                                                         ), multiple = FALSE),
                                               bsPopover("bsb132", 'Click "Browse" to upload the track data.', trigger = "focus"),
                                               
                                               actionButton("tabBut6", "View example data"),
                                               tags$script('$( "#uploaddata5" ).on( "click", function() { this.value = null; });'),
                                               downloadButton("example_data5.txt", "Example data"),
                                               
                                               br(),
                                               br(),
                                               
                                               conditionalPanel(condition = "input.plot_type5!='ideogram'",
                                                                ADVANCED_OPTIONS_PANEL_5(
                                                                  list(
                                                                    checkboxInput("color_opt5", HTML("<font color='red'>Color</font>"), FALSE),
                                                                    conditionalPanel(condition = "input.color_opt5",
                                                                                     conditionalPanel(condition="input.plot_type5 == 'point' | input.plot_type5 == 'line' | input.plot_type5 == 'bar' | input.plot_type5 == 'segment'",
                                                                                                      selectInput("col_type5", h5("Data color",
                                                                                                                                  bsButton("bsb134", label="", icon=icon("question"), style="info", size="small")), 
                                                                                                                  c("Random" = "1", "One custom color" = "2", "Custom for data with multi-group" = "3"), selected="1"
                                                                                                      ),
                                                                                                      bsPopover("bsb134", 
                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. By default, random assigned color would be used. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', 
                                                                                                                trigger = "focus"
                                                                                                      ),
                                                                                                      conditionalPanel(condition="input.col_type5=='2'",
                                                                                                                       fluidRow(column(12, jscolorInput("color_cus5", label = NULL, value = "#FF0000"))),
                                                                                                                       br()
                                                                                                      ),
                                                                                                      conditionalPanel(condition = "input.col_type5=='3'",
                                                                                                                       textInput("color_mulgp5", NULL, value="a:red;b:blue;c:cyan")
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type5=='rect_discrete'",
                                                                                                      selectInput("rect_col5", h5("Data color",
                                                                                                                                  bsButton("bsb135", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected = "1"),
                                                                                                      bsPopover("bsb135", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. By default, random assigned color would be used. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.rect_col5=='2'",
                                                                                                                       fluidRow(column(12, jscolorInput("rect_col_dis5", label = NULL, value = "#FF0000"))),
                                                                                                                       br()
                                                                                                      ),
                                                                                                      conditionalPanel(condition = "input.rect_col5=='3'",
                                                                                                                       textInput("rect_col_dis_cus5", NULL, value = "a:red;b:blue;c:cyan"))
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type5=='rect_gradual'",
                                                                                                      selectInput("rect_grad_col5", h5("Colors",
                                                                                                                                       bsButton("bsb136", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("Typical" = "1", "Low_high_color" = "2", "Low_middle_high_color" = "3"), selected = "1"),
                                                                                                      bsPopover("bsb136", "Colors to be used for the data, which can be assigned by the application or be specified by the users. By default, predefined color would be used.", trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.rect_grad_col5=='1'",
                                                                                                                       selectInput("col_rect5", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
                                                                                                                                                                  "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
                                                                                                                                                                  "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
                                                                                                                                                                  "navy.cyan", "blue.red", "green.red"))
                                                                                                      ),
                                                                                                      conditionalPanel(condition="input.rect_grad_col5=='2'",
                                                                                                                       fluidRow(			                                                         
                                                                                                                         column(6, jscolorInput("rect_2cols_low5", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
                                                                                                                         column(6, jscolorInput("rect_2cols_high5", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))), 
                                                                                                                       br()
                                                                                                      ),
                                                                                                      conditionalPanel(condition="input.rect_grad_col5=='3'",
                                                                                                                       fluidRow(			                                                         
                                                                                                                         column(4, jscolorInput("rect_3cols_low5", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
                                                                                                                         column(4, jscolorInput("rect_3cols_mid5", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
                                                                                                                         column(4, jscolorInput("rect_3cols_high5", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))), 
                                                                                                                       br()
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type5=='heatmap_gradual'",
                                                                                                      selectInput("sel_heatmap_col5", h5("Colors",
                                                                                                                                         bsButton("bsb137", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("Typical" = "1", "Low_high_color" = "2", "Low_middle_high_color" = "3"), selected = "1"),
                                                                                                      bsPopover("bsb137", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users. By default, predefined color would be used.", trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col5=='1'",
                                                                                                                       selectInput("hmap_col5", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
                                                                                                                                                                  "purple.yellow.red", "blue.green.red", "blue.yellow.green",
                                                                                                                                                                  "cyan.white.deeppink1"), selected="blue.white.red")
                                                                                                      ),
                                                                                                      conditionalPanel(condition="input.sel_heatmap_col5=='2'",
                                                                                                                       fluidRow(			                                        
                                                                                                                         column(6, jscolorInput("hmap_2cols_low5", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
                                                                                                                         column(6, jscolorInput("hmap_2cols_high5", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
                                                                                                                       br()
                                                                                                      ),																											  
                                                                                                      conditionalPanel(condition="input.sel_heatmap_col5=='3'",
                                                                                                                       fluidRow(			                                        
                                                                                                                         column(4, jscolorInput("hmap_3cols_low5", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
                                                                                                                         column(4, jscolorInput("hmap_3cols_mid5", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
                                                                                                                         column(4, jscolorInput("hmap_3cols_high5", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
                                                                                                                       br()
                                                                                                      )	
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type5=='heatmap_discrete'",
                                                                                                      selectInput("hmap_col_dis5", h5("Data color",
                                                                                                                                      bsButton("bsb138", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("Random" = "1", "Custom" = "2"), selected = "1"),
                                                                                                      bsPopover("bsb138", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. By default, random assigned color would be used. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.hmap_col_dis5=='2'",
                                                                                                                       textInput("hmap_col_dis_cus5", NULL, value="a:red;b:blue;c:cyan")
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type5=='vertical_line' | input.plot_type5=='horizontal_line'",
                                                                                                      fluidRow(column(12, jscolorInput("line_color5", label = h5('Line color:',
                                                                                                                                                                 bsButton("bsb139", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), value = "#FF0000"))),
                                                                                                      bsPopover("bsb139", 'The color to be used to plot the data.', trigger = "focus"),
                                                                                                      br()
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type5=='line'",
                                                                                                      selectInput("fill_area5", h5("Fill area",
                                                                                                                                   bsButton("bsb140", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("Yes" = "1", "No" = "2"), selected = "2"),
                                                                                                      bsPopover("bsb140", "Fill the area below the lines.", trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.fill_area5=='1'",
                                                                                                                       radioButtons("sel_area_type5", h5("Area color",
                                                                                                                                                         bsButton("bsb1400", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), c("Identical with lines" = "1", "Specific" = "2"), selected = "1"),
                                                                                                                       bsPopover("bsb1400", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.sel_area_type5=='2'",
                                                                                                                                        fluidRow(column(12, jscolorInput("border_area5", label = NULL, value = "#0000FF"))),
                                                                                                                                        br()
                                                                                                                       )
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type5=='point' | input.plot_type5=='line' | input.plot_type5=='bar' | input.plot_type5=='rect_gradual' | input.plot_type5=='rect_discrete' | input.plot_type5=='heatmap_gradual' | input.plot_type5=='heatmap_discrete' | input.plot_type5=='vertical_line' | input.plot_type5=='horizontal_line' | input.plot_type5=='text' | input.plot_type5 == 'segment'",
                                                                                                      conditionalPanel(condition="input.plot_type5=='text'",
                                                                                                                       fluidRow(column(12, jscolorInput("text_col5", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
                                                                                                                       br()
                                                                                                      ),
                                                                                                      selectInput("col_lgd5", h5("Color legend",
                                                                                                                                 bsButton("bsb141", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
                                                                                                      bsPopover("bsb141", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.col_lgd5=='1'",
                                                                                                                       textInput("col_lgd_name5", h5("Legend title:",
                                                                                                                                                     bsButton("bsb142", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), value = "color"),
                                                                                                                       bsPopover("bsb142", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.plot_type5!='rect_gradual' & input.plot_type5!='heatmap_gradual'",
                                                                                                                                        selectInput("col_lgd_mdy_label5", h5("Modify legend labels",
                                                                                                                                                                             bsButton("bsb143", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                        ), c("Yes" = "1", "No" = "2"), "2"),
                                                                                                                                        bsPopover("bsb143",
                                                                                                                                                  'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".',
                                                                                                                                                  trigger = "focus"),
                                                                                                                                        conditionalPanel(condition = "input.col_lgd_mdy_label5=='1'",
                                                                                                                                                         textInput("col_lgd_label5", NULL, value="a,b,c")
                                                                                                                                        )
                                                                                                                       )
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type5!='rect_gradual' & input.plot_type5!='heatmap_gradual' & input.plot_type5!='text' & input.plot_type5!='ideogram'",
                                                                                                      sliderInput("col_transpt5", h5("Color transparency:",
                                                                                                                                     bsButton("bsb144", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), min = 0, max = 1, value = 1, step = 0.1),
                                                                                                      bsPopover("bsb144", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")
                                                                                     )
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition = "input.plot_type5=='line' | input.plot_type5=='vertical_line' | input.plot_type5=='horizontal_line' | input.plot_type5 == 'segment'",
                                                                                     checkboxInput("linetype_opt5", HTML("<font color='red'>Linetype</font>"), FALSE),
                                                                                     conditionalPanel(condition = "input.linetype_opt5",
                                                                                                      sliderInput("line_size5", "Line width:", min=0, max=3, value=0.2, step=0.05),
                                                                                                      selectInput("linetype5", h5("Line type",
                                                                                                                                  bsButton("bsb145", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("solid", "dashed", "dotted", "dotdash", "longdash", "twodash"), selected =
                                                                                                        "solid"),
                                                                                                      bsPopover("bsb145", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus"),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.plot_type5=='vertical_line' | input.plot_type5=='horizontal_line'",
                                                                                                                       selectInput("line_type_lgd5", h5("Line type legend",
                                                                                                                                                        bsButton("bsb146", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), c("Show" = "1", "Hide" = "2"), "2"),
                                                                                                                       bsPopover("bsb146", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
                                                                                                                       
                                                                                                                       conditionalPanel(condition = "input.line_type_lgd5=='1'",
                                                                                                                                        textInput("line_type_lgd_name5", h5("Legend title:",
                                                                                                                                                                            bsButton("bsb147", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                        ), value = "linetype"),
                                                                                                                                        bsPopover("bsb147", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
                                                                                                                                        selectInput("line_type_lgd_mdy_label5",
                                                                                                                                                    h5("Modify legend labels",
                                                                                                                                                       bsButton("bsb148", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                                    ), c("Yes" = "1", "No" = "2"), "2"),
                                                                                                                                        bsPopover("bsb148", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
                                                                                                                                        
                                                                                                                                        conditionalPanel(condition = "input.line_type_lgd_mdy_label5=='1'",
                                                                                                                                                         textInput("line_type_lgd_label5", NULL, value="a")
                                                                                                                                        )
                                                                                                                       )
                                                                                                      ),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.plot_type5 == 'segment'",
                                                                                                                       selectInput("add_arrow5", h5("Add arrow head",
                                                                                                                                                    bsButton("bsb149", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), c("Yes" = "1", "No" = "2"), selected = "2"),
                                                                                                                       bsPopover("bsb149", "Add arrow head for the segment.", trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.add_arrow5 == '1'",
                                                                                                                                        selectInput("arrow_pos5", h5("Arrow position",
                                                                                                                                                                     bsButton("bsb150", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                        ), c("Line end" = "1", "Line beginning" = "2"), selected = "1"),
                                                                                                                                        bsPopover("bsb150", 'The position of arrow head.',trigger = "focus"),
                                                                                                                                        sliderInput("arrow_size5", h5("Arrow size:",
                                                                                                                                                                      bsButton("bsb151", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                        ), min = 0, max = 2, value = 0.1, step = 0.01),
                                                                                                                                        bsPopover("bsb151", 'The size of arrow head.',trigger = "focus")
                                                                                                                       )
                                                                                                      )
                                                                                     )
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition = "input.plot_type5=='point'",
                                                                                     checkboxInput("symbol_opt5", HTML("<font color='red'>Symbol</font>"), FALSE),
                                                                                     conditionalPanel(condition = "input.symbol_opt5",
                                                                                                      selectInput("sel_symbol_point5", h5("Symbol type",
                                                                                                                                          bsButton("bsb152", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("One custom symbol" = "1",
                                                                                                           'Custom for data with a "shape" column' = "2"), selected = "1"),
                                                                                                      bsPopover("bsb152",
                                                                                                                'Symbol used for different points. Applicable values are integers in [0-25]. Check <a href="http://www.endmemo.com/program/R/pchsymbols.php" target="_blank">R_pchsymbols</a> for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.',
                                                                                                                trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.sel_symbol_point5=='1'",
                                                                                                                       sliderInput("symbol_point5", NULL, min=0, max=25, value=16, step=1)
                                                                                                      ),
                                                                                                      selectInput("shape_lgd5", h5("Symbol legend",
                                                                                                                                   bsButton("bsb153", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
                                                                                                      bsPopover("bsb153", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.shape_lgd5=='1'",
                                                                                                                       textInput("shape_lgd_name5", h5("Legend title:",
                                                                                                                                                       bsButton("bsb154", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), value = "symbol"),
                                                                                                                       bsPopover("bsb154", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
                                                                                                                       selectInput("shape_lgd_mdy_label5",
                                                                                                                                   h5("Modify legend labels",
                                                                                                                                      bsButton("bsb155", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                   ), c("Yes" = "1", "No" = "2"), "2"),
                                                                                                                       bsPopover("bsb155",
                                                                                                                                 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".',
                                                                                                                                 trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.shape_lgd_mdy_label5=='1'",
                                                                                                                                        textInput("shape_lgd_label5", NULL, value="a,b,c")
                                                                                                                       )
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     checkboxInput("size_opt5", HTML("<font color='red'>Size</font>"), FALSE),
                                                                                     conditionalPanel(condition="input.size_opt5",
                                                                                                      selectInput("sel_point_size5", h5("Point size",
                                                                                                                                        bsButton("bsb156", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("One custom size" = "1",
                                                                                                           'Custom for data with a "size" column' = "2"), selected = "1"),
                                                                                                      bsPopover("bsb156",
                                                                                                                'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.',
                                                                                                                trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.sel_point_size5=='1'",
                                                                                                                       sliderInput("point_size5", NULL, min=0, max=5, value=0.8, step=0.1)
                                                                                                      ),
                                                                                                      selectInput("size_lgd5", h5("Size legend",
                                                                                                                                  bsButton("bsb157", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
                                                                                                      bsPopover("bsb157", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.size_lgd5=='1'",
                                                                                                                       textInput("size_lgd_name5", h5("Legend title:",
                                                                                                                                                      bsButton("bsb1570", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), value = "size"),
                                                                                                                       bsPopover("bsb1570", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
                                                                                                                       selectInput("size_lgd_mdy_label5",
                                                                                                                                   h5("Modify legend labels",
                                                                                                                                      bsButton("bsb158", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                   ), c("Yes" = "1", "No" = "2"), "2"),
                                                                                                                       bsPopover("bsb158",
                                                                                                                                 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".',
                                                                                                                                 trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.size_lgd_mdy_label5=='1'",
                                                                                                                                        textInput("size_lgd_label5", NULL, value="a,b,c")
                                                                                                                       )
                                                                                                      )
                                                                                     )
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition = "input.plot_type5=='heatmap_gradual' | input.plot_type5=='heatmap_discrete' | input.plot_type5=='rect_gradual' | input.plot_type5=='rect_discrete' | input.plot_type5=='bar'",
                                                                                     selectInput("add_border5", h5("Add cell borders",
                                                                                                                   bsButton("bsb159", label="", icon=icon("question"), style="info", size="small")
                                                                                     ), c("Yes" = "1", "No" = "2"), selected =
                                                                                       "2"),
                                                                                     bsPopover("bsb159", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
                                                                                     conditionalPanel(condition = "input.add_border5=='1'",
                                                                                                      fluidRow(column(12, jscolorInput("border_col5", label = h5('Borders color:'), value = "#000000"))),
                                                                                                      br()
                                                                                     )
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition = "input.plot_type5=='line' | input.plot_type5=='point' | input.plot_type5=='bar'",
                                                                                     selectInput("ylabel5", h5("Y axis label",
                                                                                                               bsButton("bsb161", label="", icon=icon("question"), style="info", size="small")
                                                                                     ), choices = c("Show" = "1", "Hide" = "2"), selected = "1"),
                                                                                     bsPopover("bsb161", "Add tick labels on the Y-axis.", trigger = "focus")
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition = "input.plot_type5=='text'",
                                                                                     checkboxInput("font_opt5", HTML("<font color='red'>Font</font>"), FALSE),
                                                                                     conditionalPanel(condition="input.font_opt5",
                                                                                                      sliderInput("text_size5", "Font size:", min=0, max=10, value=2, step=0.1),
                                                                                                      selectInput("font_face5", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
                                                                                                      sliderInput("text_angle5", "Font angle:", min=0, max=360, value=60, step=1)
                                                                                     )
                                                                    )
                                                                  )
                                                                )
                                               )
                              )
)

