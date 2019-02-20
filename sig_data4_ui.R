
sig_data4 <- conditionalPanel(condition = "input.data4",
                              radioButtons("sel_upload_data4", NULL, c("Close data input" = "1", "Upload input data" = "2"), "1"),
                              conditionalPanel(condition = "input.sel_upload_data4 == '2'",
                                               fileInput("uploaddata4", 
                                                         h5("Upload data4:",
                                                            bsButton("bsb4", label = "", icon = icon("question"), style = "info", size = "small")
                                                         ), multiple = FALSE),
                                               bsPopover("bsb100", 'Click "Browse" to upload the track data.', trigger = "focus"),
                                               
                                               actionButton("tabBut5", "View example data"),
                                               tags$script('$( "#uploaddata4" ).on( "click", function() { this.value = null; });'),
                                               downloadButton("example_data4.txt", "Example data"),
                                               
                                               br(),
                                               
                                               selectInput("layer_index4", h5("Track index:",
                                                                              bsButton("bsb101", label="", icon=icon("question"), style="info", size="small")),
                                                           choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
                                               
                                               bsPopover("bsb101",
                                                         'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.',
                                                         trigger = "focus"
                                               ),
                                               
                                               selectInput("plot_type4", "Plot type:", 
                                                           choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", 
                                                                       "text", "segment", "vertical_line", "horizontal_line", "ideogram"), selected = "point"),
                                               
                                               conditionalPanel(condition = "input.plot_type4!='ideogram'",
                                                                ADVANCED_OPTIONS_PANEL_4(
                                                                  list(
                                                                    checkboxInput("color_opt4", HTML("<font color='red'>Color</font>"), FALSE),
                                                                    conditionalPanel(condition = "input.color_opt4",
                                                                                     conditionalPanel(condition="input.plot_type4 == 'point' | input.plot_type4 == 'line' | input.plot_type4 == 'bar' | input.plot_type4 == 'segment'",
                                                                                                      selectInput("col_type4", h5("Data color",
                                                                                                                                  bsButton("bsb102", label="", icon=icon("question"), style="info", size="small")), 
                                                                                                                  c("Random" = "1", "One custom color" = "2", "Custom for data with multi-group" = "3"), selected="1"
                                                                                                      ),
                                                                                                      bsPopover("bsb102",
                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.',
                                                                                                                trigger = "focus"
                                                                                                      ),
                                                                                                      conditionalPanel(condition = "input.col_type4=='2'",
                                                                                                                       fluidRow(column(12, jscolorInput("color_cus4", label = NULL, value = "#FF0000"))),
                                                                                                                       br()
                                                                                                      ),
                                                                                                      conditionalPanel(condition = "input.col_type4=='3'",
                                                                                                                       textInput("color_mulgp4", NULL, value = "a:red;b:blue;c:cyan"))
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type4=='rect_discrete'",
                                                                                                      selectInput("rect_col4", h5("Data color",
                                                                                                                                  bsButton("bsb103", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected = "1"),
                                                                                                      bsPopover("bsb103",
                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.',
                                                                                                                trigger = "focus"
                                                                                                      ),
                                                                                                      conditionalPanel(condition = "input.rect_col4=='2'",
                                                                                                                       fluidRow(column(12, jscolorInput("rect_col_dis4", label = NULL, value = "#FF0000"))),
                                                                                                                       br()
                                                                                                      ),
                                                                                                      conditionalPanel(condition = "input.rect_col4=='3'",
                                                                                                                       textInput("rect_col_dis_cus4", NULL, value = "a:red;b:blue;c:cyan"))
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type4=='rect_gradual'",
                                                                                                      selectInput("rect_grad_col4", h5("Colors",
                                                                                                                                       bsButton("bsb104", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("Typical" = "1", "Low_high_color" = "2", "Low_middle_high_color" = "3"), selected = "1"),
                                                                                                      bsPopover("bsb104", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.rect_grad_col4=='1'",
                                                                                                                       selectInput("col_rect4", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
                                                                                                                                                                  "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
                                                                                                                                                                  "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
                                                                                                                                                                  "navy.cyan", "blue.red", "green.red"))
                                                                                                      ),
                                                                                                      conditionalPanel(condition="input.rect_grad_col4=='2'",
                                                                                                                       fluidRow(			                                                         
                                                                                                                         column(6, jscolorInput("rect_2cols_low4", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
                                                                                                                         column(6, jscolorInput("rect_2cols_high4", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))), 
                                                                                                                       br()
                                                                                                      ),
                                                                                                      conditionalPanel(condition="input.rect_grad_col4=='3'",
                                                                                                                       fluidRow(			                                                         
                                                                                                                         column(4, jscolorInput("rect_3cols_low4", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
                                                                                                                         column(4, jscolorInput("rect_3cols_mid4", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
                                                                                                                         column(4, jscolorInput("rect_3cols_high4", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))), 
                                                                                                                       br()
                                                                                                      )		
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type4=='heatmap_gradual'",
                                                                                                      selectInput("sel_heatmap_col4", h5("Colors",
                                                                                                                                         bsButton("bsb105", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("Typical" = "1", "Low_high_color" = "2", "Low_middle_high_color" = "3"), selected = "1"),
                                                                                                      bsPopover("bsb105", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col4=='1'",
                                                                                                                       selectInput("hmap_col4", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
                                                                                                                                                                  "purple.yellow.red", "blue.green.red", "blue.yellow.green",
                                                                                                                                                                  "cyan.white.deeppink1"), selected="blue.white.red")
                                                                                                      ),
                                                                                                      conditionalPanel(condition="input.sel_heatmap_col4=='2'",
                                                                                                                       fluidRow(			                                        
                                                                                                                         column(6, jscolorInput("hmap_2cols_low4", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
                                                                                                                         column(6, jscolorInput("hmap_2cols_high4", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
                                                                                                                       br()
                                                                                                      ),																											  
                                                                                                      conditionalPanel(condition="input.sel_heatmap_col4=='3'",
                                                                                                                       fluidRow(			                                        
                                                                                                                         column(4, jscolorInput("hmap_3cols_low4", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
                                                                                                                         column(4, jscolorInput("hmap_3cols_mid4", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
                                                                                                                         column(4, jscolorInput("hmap_3cols_high4", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
                                                                                                                       br()
                                                                                                      )			
                                                                                     ),
                                                                                     conditionalPanel(condition = "input.plot_type4=='heatmap_discrete'",
                                                                                                      selectInput("hmap_col_dis4", h5("Data color",
                                                                                                                                      bsButton("bsb106", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("Random" = "1", "Custom" = "2"), selected = "1"),
                                                                                                      bsPopover("bsb106",
                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.',
                                                                                                                trigger = "focus"
                                                                                                      ),
                                                                                                      conditionalPanel(condition = "input.hmap_col_dis4=='2'",
                                                                                                                       textInput("hmap_col_dis_cus4", NULL, value="a:red;b:blue;c:cyan")
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type4=='vertical_line' | input.plot_type4=='horizontal_line'",
                                                                                                      fluidRow(column(12, jscolorInput("line_color4", label = h5('Line color:',
                                                                                                                                                                 bsButton("bsb107", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), value = "#FF0000"))),
                                                                                                      bsPopover("bsb107", 'The color to be used to plot the data.', trigger = "focus"),
                                                                                                      br()
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type4=='line'",
                                                                                                      selectInput("fill_area4", h5("Fill area",
                                                                                                                                   bsButton("bsb108", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("Yes" = "1", "No" = "2"), selected = "2"),
                                                                                                      bsPopover("bsb108", "Fill the area below the lines.", trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.fill_area4=='1'",
                                                                                                                       radioButtons("sel_area_type4", h5("Area color",
                                                                                                                                                         bsButton("bsb109", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), c("Identical with lines" = "1", "Specific" = "2"), selected = "1"),
                                                                                                                       bsPopover("bsb109",
                                                                                                                                 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".',
                                                                                                                                 trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.sel_area_type4=='2'",
                                                                                                                                        fluidRow(column(12, jscolorInput("border_area4", label = NULL, value = "#0000FF"))),
                                                                                                                                        br()
                                                                                                                       )
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type4=='point' | input.plot_type4=='line' | input.plot_type4=='bar' | input.plot_type4=='rect_gradual' | input.plot_type4=='rect_discrete' | input.plot_type4=='heatmap_gradual' | input.plot_type4=='heatmap_discrete' | input.plot_type4=='vertical_line' | input.plot_type4=='horizontal_line' | input.plot_type4=='text' | input.plot_type4 == 'segment'",
                                                                                                      conditionalPanel(condition="input.plot_type4=='text'",
                                                                                                                       fluidRow(column(12, jscolorInput("text_col4", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
                                                                                                                       br()
                                                                                                      ),
                                                                                                      selectInput("col_lgd4", h5("Color legend",
                                                                                                                                 bsButton("bsb110", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
                                                                                                      bsPopover("bsb110", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.col_lgd4=='1'",
                                                                                                                       textInput("col_lgd_name4", h5("Legend title:",
                                                                                                                                                     bsButton("bsb111", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), value = "color"),
                                                                                                                       bsPopover("bsb111", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
                                                                                                                       
                                                                                                                       conditionalPanel(condition = "input.plot_type4!='rect_gradual' & input.plot_type4!='heatmap_gradual'",
                                                                                                                                        selectInput("col_lgd_mdy_label4", h5("Modify legend labels",
                                                                                                                                                                             bsButton("bsb112", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                        ), c("Yes" = "1", "No" = "2"), "2"),
                                                                                                                                        bsPopover("bsb112", 'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
                                                                                                                                        
                                                                                                                                        conditionalPanel(condition = "input.col_lgd_mdy_label4=='1'",
                                                                                                                                                         textInput("col_lgd_label4", NULL, value="a,b,c")
                                                                                                                                        )
                                                                                                                       )
                                                                                                      )
                                                                                     ),
                                                                                     
                                                                                     conditionalPanel(condition = "input.plot_type4!='rect_gradual' & input.plot_type4!='heatmap_gradual' & input.plot_type4!='text' & input.plot_type4!='ideogram'",
                                                                                                      sliderInput("col_transpt4", h5("Color transparency:",
                                                                                                                                     bsButton("bsb113", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), min = 0, max = 1, value = 1, step = 0.1),
                                                                                                      bsPopover("bsb113", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")
                                                                                     )
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition = "input.plot_type4=='line' | input.plot_type4=='vertical_line' | input.plot_type4=='horizontal_line' | input.plot_type4 == 'segment'",
                                                                                     checkboxInput("linetype_opt4", HTML("<font color='red'>Linetype</font>"), FALSE),
                                                                                     conditionalPanel(condition = "input.linetype_opt4",
                                                                                                      sliderInput("line_size4", "Line width:", min=0, max=3, value=0.2, step=0.05),
                                                                                                      selectInput("linetype4", h5("Line type",
                                                                                                                                  bsButton("bsb114", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("solid", "dashed", "dotted", "dotdash", "longdash", "twodash"), selected = "solid"),
                                                                                                      bsPopover("bsb114", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus"),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.plot_type4=='vertical_line' | input.plot_type4=='horizontal_line'",
                                                                                                                       selectInput("line_type_lgd4", h5("Line type legend",
                                                                                                                                                        bsButton("bsb115", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), c("Show" = "1", "Hide" = "2"), "2"),
                                                                                                                       bsPopover("bsb115", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.line_type_lgd4=='1'",
                                                                                                                                        textInput("line_type_lgd_name4", h5("Legend title:",
                                                                                                                                                                            bsButton("bsb116", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                        ), value = "linetype"),
                                                                                                                                        bsPopover("bsb116", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
                                                                                                                                        selectInput("line_type_lgd_mdy_label4",
                                                                                                                                                    h5("Modify legend labels",
                                                                                                                                                       bsButton("bsb117", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                                    ), c("Yes" = "1", "No" = "2"), "2"),
                                                                                                                                        bsPopover("bsb117",
                                                                                                                                                  'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".',
                                                                                                                                                  trigger = "focus"),
                                                                                                                                        conditionalPanel(condition = "input.line_type_lgd_mdy_label4=='1'",
                                                                                                                                                         textInput("line_type_lgd_label4", NULL, value="a")
                                                                                                                                        )
                                                                                                                       )
                                                                                                      ),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.plot_type4 == 'segment'",
                                                                                                                       selectInput("add_arrow4", h5("Add arrow head",
                                                                                                                                                    bsButton("bsb118", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), c("Yes" = "1", "No" = "2"), selected = "2"),
                                                                                                                       bsPopover("bsb118", "Add arrow head for the segment.", trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.add_arrow4 == '1'",
                                                                                                                                        selectInput("arrow_pos4", h5("Arrow position",
                                                                                                                                                                     bsButton("bsb119", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                        ), c("Line end" = "1", "Line beginning" = "2"), selected = "1"),
                                                                                                                                        bsPopover("bsb119", 'The position of arrow head.',trigger = "focus"),
                                                                                                                                        sliderInput("arrow_size4", h5("Arrow size:",
                                                                                                                                                                      bsButton("bsb120", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                        ), min = 0, max = 2, value = 0.1, step = 0.01),
                                                                                                                                        bsPopover("bsb120", 'The size of arrow head.',trigger = "focus")
                                                                                                                       )
                                                                                                      )
                                                                                     )
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition = "input.plot_type4=='point'",
                                                                                     checkboxInput("symbol_opt4", HTML("<font color='red'>Symbol</font>"), FALSE),
                                                                                     conditionalPanel(condition = "input.symbol_opt4",
                                                                                                      selectInput("sel_symbol_point4", h5("Symbol type",
                                                                                                                                          bsButton("bsb121", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("One custom symbol" = "1", 'Custom for data with a "shape" column' = "2"), selected = "1"),
                                                                                                      bsPopover("bsb121",
                                                                                                                'Symbol used for different points. Applicable values are integers in [0-25]. Check http://www.endmemo.com/program/R/pchsymbols.php for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.',
                                                                                                                trigger = "focus"),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.sel_symbol_point4=='1'",
                                                                                                                       sliderInput("symbol_point4", NULL, min=0, max=25, value=16, step=1)
                                                                                                      ),
                                                                                                      selectInput("shape_lgd4", h5("Symbol legend",
                                                                                                                                   bsButton("bsb122", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
                                                                                                      bsPopover("bsb122", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.shape_lgd4=='1'",
                                                                                                                       textInput("shape_lgd_name4", h5("Legend title:",
                                                                                                                                                       bsButton("bsb123", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), value = "symbol"),
                                                                                                                       bsPopover("bsb123", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
                                                                                                                       selectInput("shape_lgd_mdy_label4",
                                                                                                                                   h5("Modify legend labels",
                                                                                                                                      bsButton("bsb124", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                   ), c("Yes" = "1", "No" = "2"), "2"),
                                                                                                                       bsPopover("bsb124",
                                                                                                                                 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".',
                                                                                                                                 trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.shape_lgd_mdy_label4=='1'",
                                                                                                                                        textInput("shape_lgd_label4", NULL, value="a,b,c")
                                                                                                                       )
                                                                                                      )
                                                                                     ),
                                                                                     checkboxInput("size_opt4", HTML("<font color='red'>Size</font>"), FALSE),
                                                                                     conditionalPanel(condition="input.size_opt4",
                                                                                                      selectInput("sel_point_size4", h5("Point size",
                                                                                                                                        bsButton("bsb125", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected = "1"),
                                                                                                      bsPopover("bsb125",
                                                                                                                'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.',
                                                                                                                trigger = "focus"),
                                                                                                      conditionalPanel(condition = "input.sel_point_size4=='1'",
                                                                                                                       sliderInput("point_size4", NULL, min=0, max=5, value=0.8, step=0.1)
                                                                                                      ),
                                                                                                      selectInput("size_lgd4", h5("Size legend",
                                                                                                                                  bsButton("bsb126", label="", icon=icon("question"), style="info", size="small")
                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
                                                                                                      bsPopover("bsb126", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
                                                                                                      
                                                                                                      conditionalPanel(condition = "input.size_lgd4=='1'",
                                                                                                                       textInput("size_lgd_name4", h5("Legend title:",
                                                                                                                                                      bsButton("bsb127", label="", icon=icon("question"), style="info", size="small")
                                                                                                                       ), value = "size"),
                                                                                                                       bsPopover("bsb127", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
                                                                                                                       selectInput("size_lgd_mdy_label4",
                                                                                                                                   h5("Modify legend labels",
                                                                                                                                      bsButton("bsb128", label="", icon=icon("question"), style="info", size="small")
                                                                                                                                   ), c("Yes" = "1", "No" = "2"), "2"),
                                                                                                                       bsPopover("bsb128", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
                                                                                                                       conditionalPanel(condition = "input.size_lgd_mdy_label4=='1'",
                                                                                                                                        textInput("size_lgd_label4", NULL, value="a,b,c")
                                                                                                                       )
                                                                                                      )
                                                                                     )
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition = "input.plot_type4=='heatmap_gradual' | input.plot_type4=='heatmap_discrete' | input.plot_type4=='rect_gradual' | input.plot_type4=='rect_discrete' | input.plot_type4=='bar'",
                                                                                     selectInput("add_border4", h5("Add cell borders",
                                                                                                                   bsButton("bsb129", label="", icon=icon("question"), style="info", size="small")
                                                                                     ), c("Yes" = "1", "No" = "2"), selected = "2"),
                                                                                     bsPopover("bsb129", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
                                                                                     conditionalPanel(condition = "input.add_border4=='1'",
                                                                                                      fluidRow(column(12, jscolorInput("border_col4", label = h5('Borders color:'), value = "#000000"))),
                                                                                                      br()
                                                                                     )
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition = "input.plot_type4=='line' | input.plot_type4=='point' | input.plot_type4=='bar'",
                                                                                     selectInput("ylabel4", h5("Y axis label",
                                                                                                               bsButton("bsb131", label="", icon=icon("question"), style="info", size="small")
                                                                                     ), choices = c("Show" = "1", "Hide" = "2"), selected = "1"),
                                                                                     bsPopover("bsb131", "Add tick labels on the Y-axis.", trigger = "focus")
                                                                    ),
                                                                    
                                                                    conditionalPanel(condition="input.plot_type4=='text'",
                                                                                     checkboxInput("font_opt4", HTML("<font color='red'>Font</font>"), FALSE),
                                                                                     conditionalPanel(condition="input.font_opt4",
                                                                                                      sliderInput("text_size4", "Font size:", min=0, max=10, value=2, step=0.1),
                                                                                                      selectInput("font_face4", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
                                                                                                      sliderInput("text_angle4", "Font angle:", min=0, max=360, value=60, step=1)
                                                                                     )
                                                                    )
                                                                  )
                                                                )
                                               )
                              )
)

