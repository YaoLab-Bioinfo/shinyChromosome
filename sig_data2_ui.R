
sig_data2 <- conditionalPanel(condition = "input.data2",
                              radioButtons("sel_upload_data2", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
                              conditionalPanel(condition = "input.sel_upload_data2 == '2'",
                                               fileInput("uploaddata2", 
                                                         h5("Upload data2:", 
                                                            bsButton("bsb36", label = "", icon = icon("question"), style = "info", size = "small")
                                                         ), multiple = FALSE),
                                               bsPopover("bsb36", 'Click "Browse" to upload the track data.', trigger = "focus"),
                                               
                                               actionButton("tabBut3", "View example data"),
                                               tags$script('$( "#uploaddata2" ).on( "click", function() { this.value = null; });'),
                                               downloadButton("example_data2.txt", "Example data"),
                                               
                                               br(),
                                               
                                               selectInput("layer_index2", h5("Track index:",
                                                                              bsButton("bsb37", label = "", icon = icon("question"), style = "info", size = "small")), 
                                                           choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected = "track1"),
                                               
                                               bsPopover("bsb37",
                                                         'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.',
                                                         trigger = "focus"
                                               ),
                                               
                                               selectInput("plot_type2", "Plot type:", 
                                                           choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", 
                                                                       "text", "segment", "vertical_line", "horizontal_line", "ideogram"), selected = "point"),
                                               
                                               conditionalPanel(condition = "input.plot_type2 != 'ideogram'",
                                                                ADVANCED_OPTIONS_PANEL_2(
                                                                  list(
                                                                    checkboxInput("color_opt2", HTML("<font color='red'>Color</font>"), FALSE),
                                                                    conditionalPanel(condition = "input.color_opt2",
                                                                                     conditionalPanel(condition = "input.plot_type2 == 'point' | input.plot_type2 == 'line' | input.plot_type2 == 'bar' | input.plot_type2 == 'segment'",
                                                                                                      selectInput("col_type2", h5("Data color",
                                                                                                                                  bsButton("bsb38", label = "", icon = icon("question"), style = "info", size = "small")), 
                                                                                                                  c("Random" = "1", "One custom color" = "2", "Custom for data with multi-group" = "3"), selected = "1"
                                                                                                      ),
                                                                                                      bsPopover("bsb38",
                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.',
                                                                                                                trigger = "focus"
                                                                                                      ),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.col_type2 == '2'",
                                                                                                                       fluidRow(column(12, jscolorInput("color_cus2", label = NULL, value = "#FF0000"))),
                                                                                                                       br()
                                                                                                      ),
                                                                                                      conditionalPanel(condition = "input.col_type2 == '3'",
                                                                                                                       textInput("color_mulgp2", NULL, value="a:red;b:blue;c:cyan")
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type2=='rect_discrete'",
                                                                                                      selectInput("rect_col2", h5("Data color",
                                                                                                                                  bsButton("bsb39", label = "", icon = icon("question"), style = "info", size = "small")
                                                                                                      ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
                                                                                                      bsPopover("bsb39",
                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.',
                                                                                                                trigger = "focus"
                                                                                                      ),
                                                                                                      conditionalPanel(condition = "input.rect_col2=='2'",
                                                                                                                       fluidRow(column(12, jscolorInput("rect_col_dis2", label = NULL, value = "#FF0000"))),
                                                                                                                       br()
                                                                                                      ),
                                                                                                      conditionalPanel(condition = "input.rect_col2=='3'",
                                                                                                                       textInput("rect_col_dis_cus2", NULL, value="a:red;b:blue;c:cyan")
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type2=='rect_gradual'",
                                                                                                      selectInput("rect_grad_col2", h5("Colors",
                                                                                                                                       bsButton("bsb40", label = "", icon = icon("question"), style = "info", size = "small")
                                                                                                      ), c("Typical" = "1", "Low_high_color" = "2", "Low_middle_high_color" = "3"), selected = "1"),
                                                                                                      bsPopover("bsb40",
                                                                                                                "Colors to be used for the data, which can be assigned by the application or be specified by the users.",
                                                                                                                trigger = "focus"
                                                                                                      ),
                                                                                                      conditionalPanel(condition = "input.rect_grad_col2=='1'",
                                                                                                                       selectInput("col_rect2", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
                                                                                                                                                                  "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
                                                                                                                                                                  "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
                                                                                                                                                                  "navy.cyan", "blue.red", "green.red"))
                                                                                                      ),
                                                                                                      conditionalPanel(condition="input.rect_grad_col2=='2'",
                                                                                                                       fluidRow(			                                                         
                                                                                                                         column(6, jscolorInput("rect_2cols_low2", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
                                                                                                                         column(6, jscolorInput("rect_2cols_high2", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))), 
                                                                                                                       br()
                                                                                                      ),
                                                                                                      conditionalPanel(condition="input.rect_grad_col2=='3'",
                                                                                                                       fluidRow(			                                                         
                                                                                                                         column(4, jscolorInput("rect_3cols_low2", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
                                                                                                                         column(4, jscolorInput("rect_3cols_mid2", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
                                                                                                                         column(4, jscolorInput("rect_3cols_high2", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))), 
                                                                                                                       br()
                                                                                                      )		
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition="input.plot_type2=='heatmap_gradual'",
                                                                                                      selectInput("sel_heatmap_col2", h5("Colors",
                                                                                                                                         bsButton("bsb41", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("Typical" = "1", "Low_high_color" = "2", "Low_middle_high_color" = "3"), selected = "1"),
                                                                                                      bsPopover("bsb41", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col2=='1'",
                                                                                                                       selectInput("hmap_col2", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
                                                                                                                                                                  "purple.yellow.red", "blue.green.red", "blue.yellow.green",
                                                                                                                                                                  "cyan.white.deeppink1"), selected="blue.white.red")
                                                                                                      ),
                                                                                                      conditionalPanel(condition="input.sel_heatmap_col2=='2'",
                                                                                                                       fluidRow(			                                        
                                                                                                                         column(6, jscolorInput("hmap_2cols_low2", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
                                                                                                                         column(6, jscolorInput("hmap_2cols_high2", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
                                                                                                                       br()
                                                                                                      ),																											  
                                                                                                      conditionalPanel(condition="input.sel_heatmap_col2=='3'",
                                                                                                                       fluidRow(			                                        
                                                                                                                         column(4, jscolorInput("hmap_3cols_low2", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
                                                                                                                         column(4, jscolorInput("hmap_3cols_mid2", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
                                                                                                                         column(4, jscolorInput("hmap_3cols_high2", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
                                                                                                                       br()
                                                                                                      )	
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type2=='heatmap_discrete'",
                                                                                                      selectInput("hmap_col_dis2", h5("Data color",
                                                                                                                                      bsButton("bsb42", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("Random" = "1", "Custom" = "2"), selected = "1"),
                                                                                                      bsPopover("bsb42",
                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.',
                                                                                                                trigger = "focus"
                                                                                                      ),
                                                                                                      conditionalPanel(condition = "input.hmap_col_dis2=='2'",
                                                                                                                       textInput("hmap_col_dis_cus2", NULL, value="a:red;b:blue;c:cyan")
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type2=='vertical_line' | input.plot_type2=='horizontal_line'",
                                                                                                      fluidRow(column(12, jscolorInput("line_color2", label = h5('Line color:',
                                                                                                                                                                 bsButton("bsb43", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), value = "#FF0000"))),
                                                                                                      bsPopover("bsb43", 'The color to be used to plot the data. ', trigger = "focus"),
                                                                                                      br()
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type2=='line'",
                                                                                                      selectInput("fill_area2", h5("Fill area",
                                                                                                                                   bsButton("bsb44", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("Yes" = "1", "No" = "2"), selected = "2"),
                                                                                                      bsPopover("bsb44", "Fill the area below the lines.", trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.fill_area2=='1'",
                                                                                                                       radioButtons("sel_area_type2", h5("Area color",
                                                                                                                                                         bsButton("bsb45", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), c("Identical with lines" = "1", "Specific" = "2"), selected = "1"),
                                                                                                                       bsPopover("bsb45", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.sel_area_type2=='2'",
                                                                                                                                        fluidRow(column(12, jscolorInput("border_area2", label = NULL, value = "#0000FF"))),
                                                                                                                                        br()
                                                                                                                       )
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type2=='point' | input.plot_type2=='line' | input.plot_type2=='bar' | input.plot_type2=='rect_gradual' | input.plot_type2=='rect_discrete' | input.plot_type2=='heatmap_gradual' | input.plot_type2=='heatmap_discrete' | input.plot_type2=='vertical_line' | input.plot_type2=='horizontal_line' | input.plot_type2=='text' | input.plot_type2 == 'segment'",
                                                                                                      conditionalPanel(condition="input.plot_type2=='text'",
                                                                                                                       fluidRow(column(12, jscolorInput("text_col2", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
                                                                                                                       br()
                                                                                                      ),
                                                                                                      selectInput("col_lgd2", h5("Color legend",
                                                                                                                                 bsButton("bsb46", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
                                                                                                      bsPopover("bsb46", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.col_lgd2=='1'",
                                                                                                                       textInput("col_lgd_name2", h5("Legend title:",
                                                                                                                                                     bsButton("bsb47", label = "", icon = icon("question"), style = "info", size = "small")
                                                                                                                       ), value = "color"),
                                                                                                                       bsPopover("bsb47", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.plot_type2!='rect_gradual' & input.plot_type2!='heatmap_gradual'",
                                                                                                                                        selectInput("col_lgd_mdy_label2", h5("Modify legend labels",
                                                                                                                                                                             bsButton("bsb48", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                        ), c("Yes" = "1", "No" = "2"), "2"),
                                                                                                                                        bsPopover("bsb48", 'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
                                                                                                                                        conditionalPanel(condition = "input.col_lgd_mdy_label2=='1'",
                                                                                                                                                         textInput("col_lgd_label2", NULL, value="a,b,c")
                                                                                                                                        )
                                                                                                                       )
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type2!='rect_gradual' & input.plot_type2!='heatmap_gradual' & input.plot_type2!='text' & input.plot_type2!='ideogram'",
                                                                                                      sliderInput("col_transpt2", h5("Color transparency:",
                                                                                                                                     bsButton("bsb49", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), min = 0, max = 1, value = 1, step = 0.1),
                                                                                                      bsPopover("bsb49", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")
                                                                                     )
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition = "input.plot_type2=='line' | input.plot_type2=='vertical_line' | input.plot_type2=='horizontal_line' | input.plot_type2 == 'segment'",
                                                                                     checkboxInput("linetype_opt2", HTML("<font color='red'>Linetype</font>"), FALSE),
                                                                                     conditionalPanel(condition = "input.linetype_opt2",
                                                                                                      sliderInput("line_size2", "Line width:", min=0, max=3, value=0.2, step=0.05),
                                                                                                      selectInput("linetype2", h5("Line type",
                                                                                                                                  bsButton("bsb50", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("solid", "dashed", "dotted", "dotdash", "longdash", "twodash"), selected = "solid"),
                                                                                                      bsPopover("bsb50", 'The line type is automatically set as "solid" for line with more than one color.', trigger = "focus"),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.plot_type2=='vertical_line' | input.plot_type2=='horizontal_line'",
                                                                                                                       selectInput("line_type_lgd2", h5("Line type legend",
                                                                                                                                                        bsButton("bsb51", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), c("Show" = "1", "Hide" = "2"), "2"),
                                                                                                                       bsPopover("bsb51", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.line_type_lgd2=='1'",
                                                                                                                                        textInput("line_type_lgd_name2", h5("Legend title:",
                                                                                                                                                                            bsButton("bsb52", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                        ), value = "linetype"),
                                                                                                                                        bsPopover("bsb52", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
                                                                                                                                        selectInput("line_type_lgd_mdy_label2",
                                                                                                                                                    h5("Modify legend labels",
                                                                                                                                                       bsButton("bsb53", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                                    ), c("Yes" = "1", "No" = "2"), "2"),
                                                                                                                                        bsPopover("bsb53", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
                                                                                                                                        conditionalPanel(condition = "input.line_type_lgd_mdy_label2=='1'",
                                                                                                                                                         textInput("line_type_lgd_label2", NULL, value="a")
                                                                                                                                        )
                                                                                                                       )
                                                                                                      ),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.plot_type2 == 'segment'",
                                                                                                                       selectInput("add_arrow2", h5("Add arrow head",
                                                                                                                                                    bsButton("bsb54", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), c("Yes" = "1", "No" = "2"), selected = "2"),
                                                                                                                       bsPopover("bsb54", "Add arrow head for the segment.", trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.add_arrow2 == '1'",
                                                                                                                                        selectInput("arrow_pos2", h5("Arrow position",
                                                                                                                                                                     bsButton("bsb55", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                        ), c("Line end" = "1", "Line beginning" = "2"), selected = "1"),
                                                                                                                                        bsPopover("bsb55", 'The position of arrow head.',trigger = "focus"),
                                                                                                                                        sliderInput("arrow_size2", h5("Arrow size:",
                                                                                                                                                                      bsButton("bsb56", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                        ), min = 0, max = 2, value = 0.1, step = 0.01),
                                                                                                                                        bsPopover("bsb56", 'The size of arrow head.',trigger = "focus")
                                                                                                                       )
                                                                                                      )
                                                                                     )
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition = "input.plot_type2=='point'",
                                                                                     checkboxInput("symbol_opt2", HTML("<font color='red'>Symbol</font>"), FALSE),
                                                                                     conditionalPanel(condition = "input.symbol_opt2",
                                                                                                      selectInput("sel_symbol_point2", h5("Symbol type",
                                                                                                                                          bsButton("bsb57", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("One custom symbol" = "1",
                                                                                                           'Custom for data with a "shape" column' = "2"), selected = "1"),
                                                                                                      bsPopover("bsb57", 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.sel_symbol_point2=='1'",
                                                                                                                       sliderInput("symbol_point2", NULL, min=0, max=25, value=16, step=1)
                                                                                                      ),
                                                                                                      selectInput("shape_lgd2", h5("Symbol legend",
                                                                                                                                   bsButton("bsb58", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
                                                                                                      bsPopover("bsb58", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.shape_lgd2=='1'",
                                                                                                                       textInput("shape_lgd_name2", h5("Legend title:",
                                                                                                                                                       bsButton("bsb59", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), value = "symbol"),
                                                                                                                       bsPopover("bsb59", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
                                                                                                                       selectInput("shape_lgd_mdy_label2",
                                                                                                                                   h5("Modify legend labels",
                                                                                                                                      bsButton("bsb60", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                   ), c("Yes" = "1", "No" = "2"), "2"),
                                                                                                                       bsPopover("bsb60", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.shape_lgd_mdy_label2=='1'",
                                                                                                                                        textInput("shape_lgd_label2", NULL, value="a,b,c")
                                                                                                                       )
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     checkboxInput("size_opt2", HTML("<font color='red'>Size</font>"), FALSE),
                                                                                     conditionalPanel(condition="input.size_opt2",
                                                                                                      selectInput("sel_point_size2", h5("Point size",
                                                                                                                                        bsButton("bsb61", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("One custom size" = "1",
                                                                                                           'Custom for data with a "size" column' = "2"), selected = "1"),
                                                                                                      bsPopover("bsb61", 'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', trigger = "focus"),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.sel_point_size2=='1'",
                                                                                                                       sliderInput("point_size2", NULL, min=0, max=5, value=0.8, step=0.1)
                                                                                                      ),
                                                                                                      selectInput("size_lgd2", h5("Size legend",
                                                                                                                                  bsButton("bsb62", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
                                                                                                      bsPopover("bsb62", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.size_lgd2=='1'",
                                                                                                                       textInput("size_lgd_name2", h5("Legend title:",
                                                                                                                                                      bsButton("bsb63", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), value = "size"),
                                                                                                                       bsPopover("bsb63", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
                                                                                                                       selectInput("size_lgd_mdy_label2",
                                                                                                                                   h5("Modify legend labels",
                                                                                                                                      bsButton("bsb64", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                   ), c("Yes" = "1", "No" = "2"), "2"),
                                                                                                                       bsPopover("bsb64", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.size_lgd_mdy_label2=='1'",
                                                                                                                                        textInput("size_lgd_label2", NULL, value="a,b,c")
                                                                                                                       )
                                                                                                      )
                                                                                     )
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition = "input.plot_type2=='heatmap_gradual' | input.plot_type2=='heatmap_discrete' | input.plot_type2=='rect_gradual' | input.plot_type2=='rect_discrete' | input.plot_type2=='bar'",
                                                                                     selectInput("add_border2", h5("Add cell borders",
                                                                                                                   bsButton("bsb65", label="", icon=icon("question"), style="info", size="small")
                                                                                     ), c("Yes" = "1", "No" = "2"), selected = "2"),
                                                                                     bsPopover("bsb65", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
                                                                                     conditionalPanel(condition = "input.add_border2=='1'",
                                                                                                      fluidRow(column(12, jscolorInput("border_col2", label = h5('Borders color:'), value = "#000000"))),
                                                                                                      br()
                                                                                     )
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition="input.plot_type2=='line' | input.plot_type2=='point' | input.plot_type2=='bar'",
                                                                                     selectInput("ylabel2", h5("Y axis label",
                                                                                                               bsButton("bsb67", label="", icon=icon("question"), style="info", size="small")
                                                                                     ), choices = c("Show" = "1", "Hide" = "2"), selected = "1"),
                                                                                     bsPopover("bsb67", "Add tick labels on the Y-axis.", trigger = "focus")
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition="input.plot_type2=='text'",
                                                                                     checkboxInput("font_opt2", HTML("<font color='red'>Font</font>"), FALSE),
                                                                                     conditionalPanel(condition="input.font_opt2",
                                                                                                      sliderInput("text_size2", "Font size:", min=0, max=10, value=2, step=0.1),
                                                                                                      selectInput("font_face2", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
                                                                                                      sliderInput("text_angle2", "Font angle:", min=0, max=360, value=60, step=1)
                                                                                     )
                                                                    )
                                                                  )
                                                                )
                                               )
                              )
)

