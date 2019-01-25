
source("global_ui.R")

shinyUI(
  navbarPage(
    title = "shinyChromosome",
    theme = shinytheme("flatly"),
    windowTitle = "interactive creation of non-circular whole genome diagram",
    
	  tabPanel(
      "Single genome plot", tags$head(
			tags$style("
        input[type='file'] {width:5em;}
        .toggleButton {width:100%;}
        .clearButton {float:right; font-size:12px;}
				.fa-angle-down:before, .fa-angle-up:before {float:right;}
        .popover{text-align:left;width:500px;background-color:#000000;}
        .popover-title{color:#FFFFFF;font-size:16px;background-color:#000000;border-color:#000000;}

        #sidebarPanel_1 {width:25em;}
        #lowColor1, #midColor1, #highColor1 {width:100%}
        #lowColor2, #midColor2, #highColor2 {width:100%}
        #lowColor3, #midColor3, #highColor3 {width:100%}
        #lowColor4, #midColor4, #highColor4 {width:100%}
        #lowColor5, #midColor5, #highColor5 {width:100%}
        #lowColor6, #midColor6, #highColor6 {width:100%}
        #lowColor7, #midColor7, #highColor7 {width:100%}
        #lowColor8, #midColor8, #highColor8 {width:100%}
        #lowColor9, #midColor9, #highColor9 {width:100%}
        #lowColor10, #midColor10, #highColor10 {width:100%}

        #color_cus1, #color_cus2, #color_cus3, #color_cus4, #color_cus5, #color_cus6, #color_cus7, #color_cus8, #color_cus9, #color_cus10 {width:100%}
        #text_col1, #text_col2, #text_col3, #text_col4, #text_col5, #text_col6, #text_col7, #text_col8, #text_col9, #text_col10 {width:100%}
        #line_color1, #line_color2, #line_color3, #line_color4, #line_color5, #line_color6, #line_color7, #line_color8, #line_color9, #line_color10 {width:100%}
        #rect_col_dis1, #rect_col_dis2, #rect_col_dis3, #rect_col_dis4, #rect_col_dis5, #rect_col_dis6, #rect_col_dis7, #rect_col_dis8, #rect_col_dis9, #rect_col_dis10 {width:100%}
        #border_col1, #border_col2, #border_col3, #border_col4, #border_col5, #border_col6, #border_col7, #border_col8, #border_col9, #border_col10 {width:100%}
        #border_area1, #border_area2, #border_area3, #border_area4, #border_area5, #border_area6, #border_area7, #border_area8, #border_area9, #border_area10 {width:100%}

        #rect_lowColor1, #rect_midColor1, #rect_highColor1 {width:100%}
        #rect_lowColor2, #rect_midColor2, #rect_highColor2 {width:100%}
        #rect_lowColor3, #rect_midColor3, #rect_highColor3 {width:100%}
        #rect_lowColor4, #rect_midColor4, #rect_highColor4 {width:100%}
        #rect_lowColor5, #rect_midColor5, #rect_highColor5 {width:100%}
        #rect_lowColor6, #rect_midColor6, #rect_highColor6 {width:100%}
        #rect_lowColor7, #rect_midColor7, #rect_highColor7 {width:100%}
        #rect_lowColor8, #rect_midColor8, #rect_highColor8 {width:100%}
        #rect_lowColor9, #rect_midColor9, #rect_highColor9 {width:100%}
        #rect_lowColor10, #rect_midColor10, #rect_highColor10 {width:100%}
        #mainPanel_1 {left:28em; position:absolute; min-width:27em;}"
      ),
			
			tags$style(HTML(".shiny-output-error-validation {color: red;}")),
			tags$script(HTML('Shiny.addCustomMessageHandler("jsCode",function(message) {eval(message.value);});')),
			includeScript("www/google-analytics.js")				
		),
		
		sidebarPanel(id = "sidebarPanel_1",
		             radioButtons("plotype", 
		                          h4("*Image type", bsButton("bsb1", label="", icon=icon("question"), style="info", size="small")
		                          ), c("Concatenated chromosomes" = "1", "Separated chromosomes" = "2"), "1"),
		             bsPopover("bsb1", "All chromosomes can either be concatenated or separated.",
		                       trigger = "focus"),
		             radioButtons("plot_direct",
		                          h4("*Chromosome orientation",
		                             bsButton("bsb2", label="", icon=icon("question"), style="info", size="small")
		                          ), c("Horizontally aligned" = "1", "Vertically aligned" = "2"), "1"),
		             bsPopover("bsb2",
		                       "Chromosomes could be aligned to the horizontal axis or the vertical axis.",
		                       trigger = "focus"),
		             
		             fileInput("upload_chr_data",
		                       h4("*Upload genome data",
		                          bsButton("bsb3", label="", icon=icon("question"), style="info", size="small")
		                       ), multiple = FALSE, width = "100%"),
		             bsPopover("bsb3",
		                       'Click "Browse" to upload the genome data, which is compulsory and defines the frame of the non-circular plot.',
		                       trigger = "focus"),
    	
		             actionButton("tabBut1", "View example data"),
		             tags$script('$( "#upload_chr_data" ).on( "click", function() { this.value = null; });'),
		             downloadButton("genome_data.txt", "Example data"),
		             
		             br(),
		             
		             checkboxInput("data1", HTML("<font color='red'>Data1</font>"), FALSE),
		             conditionalPanel(condition="input.data1",
		                              radioButtons("sel_upload_data1", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		                              conditionalPanel(condition = "input.sel_upload_data1 == '2'",
		                                               fileInput("uploaddata1", 
		                                                         h5("Upload data1:", 
		                                                            bsButton("bsb4", label="", icon=icon("question"), style="info", size="small")
		                                                         ), multiple = FALSE),
		                                               bsPopover("bsb4", 'Click "Browse" to upload the track data.', trigger = "focus"),
		                                               
		                                               actionButton("tabBut2", "View example data"),
		                                               tags$script('$( "#uploaddata1" ).on( "click", function() { this.value = null; });'),
		                                               downloadButton("example_data1.txt", "Example data"),
		                                               
		                                               br(),
		                                               
		                                               selectInput("layer_index1", h5("Track index:",
		                                                                              bsButton("bsb5", label="", icon=icon("question"), style="info", size="small")
		                                               ), choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected = "track1"),
		                                               bsPopover("bsb5",
		                                                 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.',
		                                                 trigger = "focus"),
			  
		                                               selectInput("plot_type1", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete",
		                                                                                                   "text", "segment", "vertical_line", "horizontal_line", "ideogram"), selected = "point"),
		                                               
		                                               conditionalPanel(condition = "input.plot_type1!='ideogram'",
		                                                                ADVANCED_OPTIONS_PANEL_1(		                                                                  
		                                                                  list(
		                                                                    checkboxInput("color_opt1", HTML("<font color='red'>Color</font>"), FALSE),
		                                                                    conditionalPanel(condition = "input.color_opt1",
		                                                                                     conditionalPanel(condition = "input.plot_type1 == 'point' | input.plot_type1 == 'line' | input.plot_type1 == 'bar' | input.plot_type1 == 'segment'",
		                                                                                                      selectInput("col_type1", h5("Data color",
		                                                                                                                                  bsButton("bsb6", label = "", icon = icon("question"), style = "info", size = "small")), c("Random" = "1", "One custom color" = "2",
			                                                                                                                                                            "Custom for data with multi-group" = "3"), selected = "1"),
		                                                                                                      bsPopover("bsb6",
		                                                                                                        'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups in the uploaded data should be named as "color". Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.',
		                                                                                                        trigger = "focus"),
			                                      
		                                                                                                      conditionalPanel(condition = "input.col_type1=='2'",
		                                                                                                                       fluidRow(column(12, jscolorInput("color_cus1", label = NULL, value = "#FF0000"))),
		                                                                                                                       br()
		                                                                                                      ), 
		                                                                                                      conditionalPanel(condition = "input.col_type1=='3'",
		                                                                                                                       textInput("color_mulgp1", NULL, value = "a:red;b:blue;c:cyan"))
		                                                                                     ),
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type1=='rect_discrete'",
		                                                                                                      selectInput("rect_col1", h5("Data color",
		                                                                                                                                  bsButton("bsb7", label = "", icon = icon("question"), style = "info", size = "small")
		                                                                                                      ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected = "1"),
		                                                                                                      bsPopover("bsb7", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.',
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.rect_col1=='2'",
		                                                                                                                       fluidRow(column(12, jscolorInput("rect_col_dis1", label = NULL, value = "#FF0000"))),
		                                                                                                                       br()
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition = "input.rect_col1=='3'",
		                                                                                                                       textInput("rect_col_dis_cus1", NULL, value = "a:red;b:blue;c:cyan"))
		                                                                                     ),
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type1=='rect_gradual'",
		                                                                                                      selectInput("rect_grad_col1", h5("Colors",
		                                                                                                                                       bsButton("bsb8", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb8", "Colors to be used for the data, which can be assigned by the application or be specified by the users.",
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition="input.rect_grad_col1=='1'",
		                                                                                                                       selectInput("col_rect1", NULL,
		                                                                                                                         choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
		                                                                                                                                     "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
		                                                                                                                                     "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
		                                                                                                                                     "navy.cyan", "blue.red", "green.red"))
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition="input.rect_grad_col1=='2'",
		                                                                                                                       fluidRow(			                                                         
		                                                                                                                         column(4, jscolorInput("rect_lowColor1", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("rect_midColor1", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("rect_highColor1", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))), 
		                                                                                                                       br()
		                                                                                                      )
		                                                                                     ),
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type1=='heatmap_gradual'",
		                                                                                                      selectInput("sel_heatmap_col1",
		                                                                                                        h5("Colors", bsButton("bsb9", label = "", icon = icon("question"), style = "info", size = "small")
		                                                                                                        ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb9",
		                                                                                                        "Colors to be used for the data, which can be assigned by the application or be specified by the users.",
		                                                                                                        trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col1=='1'",
		                                                                                                                       selectInput("hmap_col1", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
		                                                                                                                                                                  "purple.yellow.red", "blue.green.red", "blue.yellow.green",
		                                                                                                                                                                  "cyan.white.deeppink1"), selected="blue.white.red")
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition="input.sel_heatmap_col1=='2'",
		                                                                                                                       fluidRow(			                                        
		                                                                                                                         column(4, jscolorInput("lowColor1", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("midColor1", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("highColor1", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                                                                       br()
		                                                                                                      )
		                                                                                     ),
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type1=='heatmap_discrete'", 
		                                                                                                      selectInput("hmap_col_dis1", h5("Data color", bsButton("bsb10", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb10", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.',
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.hmap_col_dis1=='2'",
		                                                                                                                       textInput("hmap_col_dis_cus1", NULL, value = "a:red;b:blue;c:cyan")
		                                                                                                      )
		                                                                                     ),
		                                                                                     
		                                                                                     conditionalPanel(condition="input.plot_type1=='vertical_line' | input.plot_type1=='horizontal_line'", 
		                                                                                                      fluidRow(column(12, jscolorInput("line_color1", label = h5("Line color:", bsButton("bsb11", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), value = "#FF0000"))),
		                                                                                                      bsPopover("bsb11", 'The color to be used to plot the data.',
		                                                                                                                trigger = "focus"),
		                                                                                                      br()
		                                                                                     ),
		                                                                                     
		                                                                                     conditionalPanel(condition="input.plot_type1=='line'",
		                                                                                                      selectInput("fill_area1", h5("Fill area",
		                                                                                                                                   bsButton("bsb12", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                                      bsPopover("bsb12", "Fill the area below the lines.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.fill_area1=='1'",
		                                                                                                                       radioButtons("sel_area_type1", h5("Area color",
		                                                                                                                                                         bsButton("bsb13", label = "", icon = icon("question"), style = "info", size = "small")
		                                                                                                                       ), c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
		                                                                                                                       bsPopover("bsb13", 'Color to be used to fill the area, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".',
		                                                                                                                         trigger = "focus"
		                                                                                                                       ),
		                                                                                                                       conditionalPanel(condition = "input.sel_area_type1=='2'",
		                                                                                                                                        fluidRow(column(12, jscolorInput("border_area1", label = NULL, value = "#0000FF"))),
		                                                                                                                                        br()
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type1=='point' | input.plot_type1=='line' | input.plot_type1=='bar' | input.plot_type1=='rect_gradual' | input.plot_type1=='rect_discrete' | input.plot_type1=='heatmap_gradual' | input.plot_type1=='heatmap_discrete' | input.plot_type1=='vertical_line' | input.plot_type1=='horizontal_line' | input.plot_type1=='text' | input.plot_type1 == 'segment'",
		                                                                                                      conditionalPanel(condition="input.plot_type1=='text'",
		                                                                                                                       fluidRow(column(12, jscolorInput("text_col1", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
		                                                                                                                       br()
		                                                                                                      ),
		                                                                                                      selectInput("col_lgd1", h5("Color legend", bsButton("bsb14", label = "", icon = icon("question"), style = "info", size = "small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb14", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.col_lgd1=='1'",
		                                                                                                                       textInput("col_lgd_name1", h5("Legend title:",
		                                                                                                                                                     bsButton("bsb15", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), value = "color"),
		                                                                                                                       bsPopover("bsb15", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
 				    
		                                                                                                                       conditionalPanel(condition = "input.plot_type1!='rect_gradual' & input.plot_type1!='heatmap_gradual'",
		                                                                                                                                        selectInput("col_lgd_mdy_label1", h5("Modify legend labels",
		                                                                                                                                                                             bsButton("bsb16", label = "", icon = icon("question"), style = "info", size = "small")
		                                                                                                                                        ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                                        bsPopover("bsb16", 'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					    
		                                                                                                                                        conditionalPanel(condition = "input.col_lgd_mdy_label1=='1'",
		                                                                                                                                                         textInput("col_lgd_label1", NULL, value="a,b,c")
		                                                                                                                                        )
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ),
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type1!='rect_gradual' & input.plot_type1!='heatmap_gradual' & input.plot_type1!='text' & input.plot_type1!='ideogram'",
		                                                                                                      sliderInput("col_transpt1", h5("Color transparency:",
		                                                                                                                                     bsButton("bsb17", label = "", icon = icon("question"), style = "info", size = "small")
		                                                                                                      ), min = 0, max = 1, value = 1, step = 0.1),
		                                                                                                      bsPopover("bsb17", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type1=='line' | input.plot_type1=='vertical_line' | input.plot_type1=='horizontal_line' | input.plot_type1 == 'segment'",
		                                                                                     checkboxInput("linetype_opt1", HTML("<font color='red'>Linetype</font>"), FALSE),
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.linetype_opt1",
		                                                                                                      sliderInput("line_size1", "Line width:", min=0, max=3, value=0.2, step=0.05),
		                                                                                                      selectInput("linetype1", h5("Line type",
		                                                                                                                                  bsButton("bsb18", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("solid", "dashed", "dotted", "dotdash", "longdash", "twodash"), selected = "solid"),
		                                                                                                      bsPopover("bsb18", 'The line type is automatically set as "solid" for line with more than one color.', trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.plot_type1=='vertical_line' | input.plot_type1=='horizontal_line'",
		                                                                                                                       selectInput("line_type_lgd1", h5("Line type legend",
		                                                                                                                                                        bsButton("bsb19", label = "", icon = icon("question"), style = "info", size = "small")
		                                                                                                                       ), c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                                       bsPopover("bsb19", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
		                                                                                                                       
		                                                                                                                       conditionalPanel(condition = "input.line_type_lgd1=='1'",
		                                                                                                                                        textInput("line_type_lgd_name1", h5("Legend title:",
		                                                                                                                                                                            bsButton("bsb20", label = "", icon = icon("question"), style = "info", size = "small")
		                                                                                                                                        ), value = "linetype"),
		                                                                                                                                        bsPopover("bsb20", "Title of line type legend. Null value will result in an empty title.",trigger = "focus"),
			                                  
		                                                                                                                                        selectInput("line_type_lgd_mdy_label1",
		                                                                                                                                                    h5("Modify legend labels",
		                                                                                                                                                       bsButton("bsb21", label = "", icon = icon("question"), style = "info", size = "small")
		                                                                                                                                                    ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                                        bsPopover("bsb21", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".',
		                                                                                                                                                  trigger = "focus"),
		                                                                                                                                        
		                                                                                                                                        conditionalPanel(condition = "input.line_type_lgd_mdy_label1=='1'",
		                                                                                                                                                         textInput("line_type_lgd_label1", NULL, value="a")
		                                                                                                                                        )
		                                                                                                                       )
		                                                                                                      ), 
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.plot_type1 == 'segment'",
		                                                                                                                       selectInput("add_arrow1", h5("Add arrow head",
		                                                                                                                                                    bsButton("bsb22", label = "", icon = icon("question"), style = "info", size = "small")
		                                                                                                                       ), c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                                                       bsPopover("bsb22", "Add arrow head for the segment.", trigger = "focus"),
			                 
		                                                                                                                       conditionalPanel(condition = "input.add_arrow1 == '1'",
		                                                                                                                                        selectInput("arrow_pos1", h5("Arrow position",
		                                                                                                                                                                     bsButton("bsb23", label = "", icon = icon("question"), style = "info", size = "small")
		                                                                                                                                        ), c("Line end" = "1", "Line beginning" = "2"), selected = "1"),
		                                                                                                                                        bsPopover("bsb23", 'The position of arrow head.', trigger = "focus"), 
		                                                                                                                                        sliderInput("arrow_size1", h5("Arrow size:", 
		                                                                                                                                                                      bsButton("bsb24", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), min = 0, max = 2, value = 0.1, step = 0.01),
		                                                                                                                                        bsPopover("bsb24", 'The size of arrow head.', trigger = "focus")
		                                                                                                                       )
		                                                                                                      )
		                                                                                     )
		                                                                    ),
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type1=='point'",
		                                                                                     checkboxInput("symbol_opt1", HTML("<font color='red'>Symbol</font>"), FALSE),  
		                                                                                     conditionalPanel(condition = "input.symbol_opt1",
		                                                                                                      selectInput("sel_symbol_point1", h5("Symbol type",
		                                                                                                                                          bsButton("bsb25", label = "", icon = icon("question"), style = "info", size = "small")
		                                                                                                      ), c("One custom symbol" = "1", 'Custom for data with a "shape" column' = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb25", 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.sel_symbol_point1=='1'",
		                                                                                                                       sliderInput("symbol_point1", NULL, min=0, max=25, value=16, step=1)
		                                                                                                      ),
		                                                                                                      
		                                                                                                      selectInput("shape_lgd1",
		                                                                                                                  h5("Symbol legend", bsButton("bsb26", label = "", icon = icon("question"), style = "info", size = "small")
		                                                                                                                  ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb26", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.shape_lgd1=='1'",
		                                                                                                                       textInput("shape_lgd_name1", h5("Legend title:",
		                                                                                                                                                       bsButton("bsb27", label = "", icon = icon("question"), style = "info", size = "small")
		                                                                                                                       ), value = "symbol"),
		                                                                                                                       bsPopover("bsb27", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"), 
		                                                                                                                       selectInput("shape_lgd_mdy_label1", 
		                                                                                                                                   h5("Modify legend labels", bsButton("bsb28", label="", icon=icon("question"), style="info", size="small")), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                       bsPopover("bsb28", 
		                                                                                                                                 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".',
		                                                                                                                                 trigger = "focus"),
		                                                                                                                       
		                                                                                                                       conditionalPanel(condition = "input.shape_lgd_mdy_label1=='1'", 
		                                                                                                                                        textInput("shape_lgd_label1", NULL, value = "a,b,c")
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     checkboxInput("size_opt1", HTML("<font color='red'>Size</font>"), FALSE),
		                                                                                     conditionalPanel(condition="input.size_opt1", 				
		                                                                                                      selectInput("sel_point_size1", 
		                                                                                                                  h5("Point size", bsButton("bsb29", label = "", icon = icon("question"), style = "info", size = "small")
		                                                                                                                  ), c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb29", 'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.sel_point_size1=='1'",
		                                                                                                                       sliderInput("point_size1", NULL, min=0, max=5, value=0.8, step=0.1)
		                                                                                                      ),
		                                                                                                      
		                                                                                                      selectInput("size_lgd1",
		                                                                                                                  h5("Size legend", bsButton("bsb30", label = "", icon = icon("question"), style = "info", size = "small")),
		                                                                                                                  choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb30",
		                                                                                                                "Control the appearance of the size legend in the plotting region.",
		                                                                                                                trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.size_lgd1=='1'",
		                                                                                                                       textInput("size_lgd_name1", h5("Legend title:",
		                                                                                                                                                      bsButton("bsb31", label = "", icon = icon("question"), style = "info", size = "small")), value = "size"),
		                                                                                                                       bsPopover("bsb31", "Title of size legend. Null value will result in an empty title.", trigger = "focus"), 
		                                                                                                                       selectInput("size_lgd_mdy_label1", 
		                                                                                                                                   h5("Modify legend labels", bsButton("bsb32", label="", icon=icon("question"), style="info", size="small")), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                       bsPopover("bsb32",
		                                                                                                                         'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".',
		                                                                                                                         trigger = "focus"),
				                                  
		                                                                                                                       conditionalPanel(condition = "input.size_lgd_mdy_label1=='1'",
		                                                                                                                                        textInput("size_lgd_label1", NULL, value="a,b,c")
		                                                                                                                       )
		                                                                                                      )
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type1=='heatmap_gradual' | input.plot_type1=='heatmap_discrete' | input.plot_type1=='rect_gradual' | input.plot_type1=='rect_discrete' | input.plot_type1=='bar'",
		                                                                                     selectInput("add_border1", h5("Add cell borders",
		                                                                                                                   bsButton("bsb33", label="", icon=icon("question"), style="info", size="small")
		                                                                                     ), c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                     bsPopover("bsb33",
		                                                                                       "Add borders to the grids, which can be used to separate cells from each other.",
		                                                                                       trigger = "focus"
		                                                                                     ),
		                                                                                     conditionalPanel(condition = "input.add_border1=='1'",
		                                                                                                      fluidRow(column(12, jscolorInput("border_col1", label = h5('Borders color:'), value = "#000000"))),
		                                                                                                      br()
		                                                                                     )
		                                                                    ),
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type1=='line' | input.plot_type1=='point' | input.plot_type1=='bar'",
		                                                                                     selectInput("ylabel1", h5("Y axis label",
		                                                                                                               bsButton("bsb35", label = "", icon = icon("question"), style = "info", size = "small")
		                                                                                     ), choices = c("Show" = "1", "Hide" = "2"), selected="1"),
		                                                                                     bsPopover("bsb35", "Add tick labels on the Y-axis.", trigger = "focus")
		                                                                    ),
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type1=='text'",
		                                                                                     checkboxInput("font_opt1", HTML("<font color='red'>Font</font>"), FALSE),
		                                                                                     conditionalPanel(condition = "input.font_opt1",
		                                                                                                      sliderInput("text_size1", "Font size:", min=0, max=10, value=2, step=0.1),
		                                                                                                      selectInput("font_face1", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected = "plain"),
		                                                                                                      sliderInput("text_angle1", "Font angle:", min=0, max=360, value=60, step=1)				
		                                                                                     )
		                                                                    )
		                                                                  )
		                                                                )
		                                               )
		                              )
		             ), 
		             checkboxInput("data2", HTML("<font color='red'>Data2</font>"), FALSE),
		             conditionalPanel(condition="input.data2",
		                              radioButtons("sel_upload_data2", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		                              conditionalPanel(condition="input.sel_upload_data2 == '2'",
		                                               fileInput("uploaddata2", h5("Upload data2:",
		                                                                           bsButton("bsb36", label="", icon=icon("question"), style="info", size="small")
		                                               ), multiple = FALSE),
		                                               bsPopover("bsb36", 'Click "Browse" to upload the track data.', trigger = "focus"),
		                                               actionButton("tabBut3", "View example data"),
		                                               tags$script('$( "#uploaddata2" ).on( "click", function() { this.value = null; });'),
		                                               downloadButton("example_data2.txt", "Example data"),
		                                               
		                                               br(),
		                                               br(),
		                                               
		                                               selectInput("layer_index2", h5("Track index:",
		                                                                              bsButton("bsb37", label="", icon=icon("question"), style="info", size="small")
		                                               ), choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected = "track1"),
		                                               bsPopover("bsb37",
		                                                 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.',
		                                                 trigger = "focus"
		                                               ),
		                                               
		                                               selectInput("plot_type2", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical_line", "horizontal_line", "ideogram"), selected="point"),
		                                               conditionalPanel(condition = "input.plot_type2!='ideogram'",
		                                                                ADVANCED_OPTIONS_PANEL_2(
		                                                                  list(
		                                                                    checkboxInput("color_opt2", HTML("<font color='red'>Color</font>"), FALSE),  
		                                                                    conditionalPanel(condition = "input.color_opt2",
		                                                                                     conditionalPanel(condition="input.plot_type2 == 'point' | input.plot_type2 == 'line' | input.plot_type2 == 'bar' | input.plot_type2 == 'segment'",
		                                                                                                      selectInput("col_type2", h5("Data color",
		                                                                                                                                  bsButton("bsb38", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "One custom color" = "2", "Custom for data with multi-group" = "3"), selected="1"),
		                                                                                                      bsPopover("bsb38",
		                                                                                                        'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.',
		                                                                                                        trigger = "focus"
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition = "input.col_type2=='2'",
		                                                                                                                       fluidRow(column(12, jscolorInput("color_cus2", label = NULL, value = "#FF0000"))),
		                                                                                                                       br()
		                                                                                                      ), 
		                                                                                                      conditionalPanel(condition = "input.col_type2=='3'",
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
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected="1"),
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
		                                                                                                      conditionalPanel(condition = "input.rect_grad_col2=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("rect_lowColor2", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("rect_midColor2", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("rect_highColor2", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                                                                       br()
		                                                                                                      )
		                                                                                     ),
		                                                                                     
		                                                                                     conditionalPanel(condition="input.plot_type2=='heatmap_gradual'",
		                                                                                                      selectInput("sel_heatmap_col2", h5("Colors",
		                                                                                                                                         bsButton("bsb41", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb41", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col2=='1'",
		                                                                                                                       selectInput("hmap_col2", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
		                                                                                                                                                                  "purple.yellow.red", "blue.green.red", "blue.yellow.green",
		                                                                                                                                                                  "cyan.white.deeppink1"), selected="blue.white.red")
		                                                                                                      ), 
		                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col2=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("lowColor2", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("midColor2", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("highColor2", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))), 
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
		             ), 
		             
		             checkboxInput("data3", HTML("<font color='red'>Data3</font>"), FALSE),
		             conditionalPanel(condition="input.data3",
		                              radioButtons("sel_upload_data3", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		                              conditionalPanel(condition="input.sel_upload_data3 == '2'",
		                                               fileInput("uploaddata3", h5("Upload data3:",
		                                                                           bsButton("bsb68", label="", icon=icon("question"), style="info", size="small")
		                                               ), multiple = FALSE),
		                                               bsPopover("bsb68", 'Click "Browse" to upload the track data.', trigger = "focus"),
			
		                                               actionButton("tabBut4", "View example data"),
		                                               tags$script('$( "#uploaddata3" ).on( "click", function() { this.value = null; });'),
		                                               downloadButton("example_data3.txt", "Example data"),
		                                               br(),
		                                               br(),
		                                               selectInput("layer_index3", h5("Track index:", 
		                                                                              bsButton("bsb69", label="", icon=icon("question"), style="info", size="small")), 
		                                                           choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
		                                               bsPopover("bsb69",
		                                                 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.',
		                                                 trigger = "focus"
		                                               ),
		                                               
		                                               selectInput("plot_type3", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical_line", "horizontal_line", "ideogram"), selected="point"),
		                                               conditionalPanel(condition = "input.plot_type3!='ideogram'",
		                                                                ADVANCED_OPTIONS_PANEL_3(
		                                                                  list(		    	
		                                                                    checkboxInput("color_opt3", HTML("<font color='red'>Color</font>"), FALSE),
		                                                                    conditionalPanel(condition="input.color_opt3",  					
		                                                                                     conditionalPanel(condition = "input.plot_type3 == 'point' | input.plot_type3 == 'line' | input.plot_type3 == 'bar' | input.plot_type3 == 'segment'",
		                                                                                                      selectInput("col_type3", h5("Data color", 
		                                                                                                                                  bsButton("bsb70", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "One custom color" = "2", "Custom for data with multi-group" = "3"), selected="1"), 
		                                                                                                      bsPopover("bsb70", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.col_type3=='2'",
		                                                                                                                       fluidRow(column(12, jscolorInput("color_cus3", label = NULL, value = "#FF0000"))),
		                                                                                                                       br()
		                                                                                                      ), 
		                                                                                                      conditionalPanel(condition = "input.col_type3=='3'",
		                                                                                                                       textInput("color_mulgp3", NULL, value="a:red;b:blue;c:cyan")
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type3=='rect_discrete'",
		                                                                                                      selectInput("rect_col3", h5("Data color", 
		                                                                                                                                  bsButton("bsb71", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected = "1"),
		                                                                                                      bsPopover("bsb71", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.rect_col3=='2'",
		                                                                                                                       fluidRow(column(12, jscolorInput("rect_col_dis3", label = NULL, value = "#FF0000"))),
		                                                                                                                       br()
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition = "input.rect_col3=='3'",
		                                                                                                                       textInput("rect_col_dis_cus3", NULL, value = "a:red;b:blue;c:cyan"))
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type3=='rect_gradual'",
		                                                                                                      selectInput("rect_grad_col3", h5("Colors", 
		                                                                                                                                       bsButton("bsb72", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb72", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.rect_grad_col3=='1'",
		                                                                                                                       selectInput("col_rect3", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
		                                                                                                                                                                  "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
		                                                                                                                                                                  "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
		                                                                                                                                                                  "navy.cyan", "blue.red", "green.red"))
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition = "input.rect_grad_col3=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("rect_lowColor3", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("rect_midColor3", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("rect_highColor3", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                                                                       br()
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type3=='heatmap_gradual'",
		                                                                                                      selectInput("sel_heatmap_col3", h5("Colors", 
		                                                                                                                                         bsButton("bsb73", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb73", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col3=='1'",
		                                                                                                                       selectInput("hmap_col3", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
		                                                                                                                                                                  "purple.yellow.red", "blue.green.red", "blue.yellow.green",
		                                                                                                                                                                  "cyan.white.deeppink1"), selected="blue.white.red")
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition="input.sel_heatmap_col3=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("lowColor3", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("midColor3", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("highColor3", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                                                                       br()
		                                                                                                      )			
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type3=='heatmap_discrete'",
		                                                                                                      selectInput("hmap_col_dis3", h5("Data color", 
		                                                                                                                                      bsButton("bsb74", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb74", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.hmap_col_dis3=='2'",
		                                                                                                                       textInput("hmap_col_dis_cus3", NULL, value="a:red;b:blue;c:cyan")
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type3=='vertical_line' | input.plot_type3=='horizontal_line'",
		                                                                                                      fluidRow(column(12, jscolorInput("line_color3", label = h5('Line color:', 
		                                                                                                                                                                 bsButton("bsb75", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), value = "#FF0000"))),
		                                                                                                      bsPopover("bsb75", 'The color to be used to plot the data. ', trigger = "focus"),
		                                                                                                      br()
		                                                                                     ),
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type3=='line'",
		                                                                                                      selectInput("fill_area3", h5("Fill area", 
		                                                                                                                                   bsButton("bsb76", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                                      bsPopover("bsb76", "Fill the area below the lines.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.fill_area3=='1'",
		                                                                                                                       radioButtons("sel_area_type3", h5("Area color", 
		                                                                                                                                                         bsButton("bsb77", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Identical with lines" = "1", "Specific" = "2"), selected = "1"),
		                                                                                                                       bsPopover("bsb77", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.sel_area_type3=='2'",
		                                                                                                                                        fluidRow(column(12, jscolorInput("border_area3", label = NULL, value = "#0000FF"))),
		                                                                                                                                        br()
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type3=='point' | input.plot_type3=='line' | input.plot_type3=='bar' | input.plot_type3=='rect_gradual' | input.plot_type3=='rect_discrete' | input.plot_type3=='heatmap_gradual' | input.plot_type3=='heatmap_discrete' | input.plot_type3=='vertical_line' | input.plot_type3=='horizontal_line' | input.plot_type3=='text' | input.plot_type3 == 'segment'",
		                                                                                                      conditionalPanel(condition="input.plot_type3=='text'", 
		                                                                                                                       fluidRow(column(12, jscolorInput("text_col3", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
		                                                                                                                       br()
		                                                                                                      ), 
		                                                                                                      selectInput("col_lgd3", h5("Color legend",
		                                                                                                                                 bsButton("bsb78", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb78", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.col_lgd3=='1'",
		                                                                                                                       textInput("col_lgd_name3", h5("Legend title:", 
		                                                                                                                                                     bsButton("bsb79", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), value = "color"),
		                                                                                                                       bsPopover("bsb79", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.plot_type3!='rect_gradual' & input.plot_type3!='heatmap_gradual'",
		                                                                                                                                        selectInput("col_lgd_mdy_label3", h5("Modify legend labels", 
		                                                                                                                                                                             bsButton("bsb80", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                                        bsPopover("bsb80", 'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
		                                                                                                                                        conditionalPanel(condition = "input.col_lgd_mdy_label3=='1'",
		                                                                                                                                                         textInput("col_lgd_label3", NULL, value="a,b,c")
		                                                                                                                                        )
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type3!='rect_gradual' & input.plot_type3!='heatmap_gradual' & input.plot_type3!='text' & input.plot_type3!='ideogram'",
		                                                                                                      sliderInput("col_transpt3", h5("Color transparency:", 
		                                                                                                                                     bsButton("bsb81", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), min = 0, max = 1, value = 1, step = 0.1),
		                                                                                                      bsPopover("bsb81", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")										  
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type3=='line' | input.plot_type3=='vertical_line' | input.plot_type3=='horizontal_line' | input.plot_type3 == 'segment'",
		                                                                                     checkboxInput("linetype_opt3", HTML("<font color='red'>Linetype</font>"), FALSE), 
		                                                                                     conditionalPanel(condition = "input.linetype_opt3",
		                                                                                                      sliderInput("line_size3", "Line width:", min=0, max=3, value=0.2, step=0.05),
		                                                                                                      selectInput("linetype3", h5("Line type",
		                                                                                                                                  bsButton("bsb82", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("solid", "dashed", "dotted", "dotdash", "longdash", "twodash"), selected = "solid"),
		                                                                                                      bsPopover("bsb82", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.plot_type3=='vertical_line' | input.plot_type3=='horizontal_line'",
		                                                                                                                       selectInput("line_type_lgd3", h5("Line type legend", 
		                                                                                                                                                        bsButton("bsb83", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                                       bsPopover("bsb83", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
		                                                                                                                       
		                                                                                                                       conditionalPanel(condition = "input.line_type_lgd3=='1'",
		                                                                                                                                        textInput("line_type_lgd_name3", h5("Legend title:", 
		                                                                                                                                                                            bsButton("bsb84", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), value = "linetype"),
		                                                                                                                                        bsPopover("bsb84", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                                        selectInput("line_type_lgd_mdy_label3",
		                                                                                                                                                    h5("Modify legend labels",
		                                                                                                                                                       bsButton("bsb85", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                                    ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                                        bsPopover("bsb85", 
		                                                                                                                                                  'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', 
		                                                                                                                                                  trigger = "focus"),
		                                                                                                                                        conditionalPanel(condition = "input.line_type_lgd_mdy_label3=='1'",
		                                                                                                                                                         textInput("line_type_lgd_label3", NULL, value="a")
		                                                                                                                                        )
		                                                                                                                       )
		                                                                                                      ), 
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.plot_type3 == 'segment'",
		                                                                                                                       selectInput("add_arrow3", h5("Add arrow head", 
		                                                                                                                                                    bsButton("bsb86", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                                                       bsPopover("bsb86", "Add arrow head for the segment.", trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.add_arrow3 == '1'",
		                                                                                                                                        selectInput("arrow_pos3", h5("Arrow position", 
		                                                                                                                                                                     bsButton("bsb87", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), c("Line end" = "1", "Line beginning" = "2"), selected = "1"),
		                                                                                                                                        bsPopover("bsb87", 'The position of arrow head.',trigger = "focus"),
		                                                                                                                                        sliderInput("arrow_size3", h5("Arrow size:",
		                                                                                                                                                                      bsButton("bsb88", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), min = 0, max = 2, value = 0.1, step = 0.01),
		                                                                                                                                        bsPopover("bsb88", 'The size of arrow head.',trigger = "focus")								
		                                                                                                                       )
		                                                                                                      )
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type3=='point'",
		                                                                                     checkboxInput("symbol_opt3", HTML("<font color='red'>Symbol</font>"), FALSE),  
		                                                                                     conditionalPanel(condition = "input.symbol_opt3",
		                                                                                                      selectInput("sel_symbol_point3", h5("Symbol type", 
		                                                                                                                                          bsButton("bsb89", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("One custom symbol" = "1", 'Custom for data with a "shape" column' = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb89", 
		                                                                                                                'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.sel_symbol_point3=='1'",
		                                                                                                                       sliderInput("symbol_point3", NULL, min=0, max=25, value=16, step=1)
		                                                                                                      ),
		                                                                                                      selectInput("shape_lgd3", h5("Symbol legend",
		                                                                                                                                   bsButton("bsb90", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb90", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.shape_lgd3=='1'",
		                                                                                                                       textInput("shape_lgd_name3", h5("Legend title:", 
		                                                                                                                                                       bsButton("bsb91", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), value = "symbol"),
		                                                                                                                       bsPopover("bsb91", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       selectInput("shape_lgd_mdy_label3",
		                                                                                                                                   h5("Modify legend labels",
		                                                                                                                                      bsButton("bsb92", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                   ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                       bsPopover("bsb92", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', 
		                                                                                                                                 trigger = "focus"),
		                                                                                                                       
		                                                                                                                       conditionalPanel(condition = "input.shape_lgd_mdy_label3=='1'",
		                                                                                                                                        textInput("shape_lgd_label3", NULL, value="a,b,c")
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     checkboxInput("size_opt3", HTML("<font color='red'>Size</font>"), FALSE),
		                                                                                     conditionalPanel(condition="input.size_opt3", 				
		                                                                                                      selectInput("sel_point_size3", h5("Point size",
		                                                                                                                                        bsButton("bsb93", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb93", 'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.sel_point_size3=='1'",
		                                                                                                                       sliderInput("point_size3", NULL, min=0, max=5, value=0.8, step=0.1)
		                                                                                                      ),
		                                                                                                      selectInput("size_lgd3", h5("Size legend", 
		                                                                                                                                  bsButton("bsb94", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb94", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
		                                                                                                     
		                                                                                                      conditionalPanel(condition = "input.size_lgd3=='1'",
		                                                                                                                       textInput("size_lgd_name3", h5("Legend title:", 
		                                                                                                                                                      bsButton("bsb95", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), value = "size"),
		                                                                                                                       bsPopover("bsb95", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       
		                                                                                                                       selectInput("size_lgd_mdy_label3",
		                                                                                                                                   h5("Modify legend labels",
		                                                                                                                                      bsButton("bsb96", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                   ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                       bsPopover("bsb96", 
		                                                                                                                                 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', 
		                                                                                                                                 trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.size_lgd_mdy_label3=='1'",
		                                                                                                                                        textInput("size_lgd_label3", NULL, value="a,b,c")
		                                                                                                                       )
		                                                                                                      )
		                                                                                     )
		                                                                    ),
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type3=='heatmap_gradual' | input.plot_type3=='heatmap_discrete' | input.plot_type3=='rect_gradual' | input.plot_type3=='rect_discrete' | input.plot_type3=='bar'",
		                                                                                     selectInput("add_border3", h5("Add cell borders", 
		                                                                                                                   bsButton("bsb97", label="", icon=icon("question"), style="info", size="small")
		                                                                                     ), c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                     bsPopover("bsb97",
		                                                                                       "Add borders to the grids, which can be used to separate cells from each other.",
		                                                                                       trigger = "focus"
		                                                                                     ),
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.add_border3=='1'",
		                                                                                                      fluidRow(column(12, jscolorInput("border_col3", label = h5('Borders color:'), value = "#000000"))),
		                                                                                                      br()
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type3=='line' | input.plot_type3=='point' | input.plot_type3=='bar'",
		                                                                                     selectInput("ylabel3", h5("Y axis label", 
		                                                                                                               bsButton("bsb99", label="", icon=icon("question"), style="info", size="small")
		                                                                                     ), choices = c("Show" = "1", "Hide" = "2"), selected = "1"),
		                                                                                     bsPopover("bsb99", "Add tick labels on the Y-axis.", trigger = "focus")								
		                                                                    ),
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type3=='text'", 
		                                                                                     checkboxInput("font_opt3", HTML("<font color='red'>Font</font>"), FALSE),
		                                                                                     conditionalPanel(condition="input.font_opt3", 
		                                                                                                      sliderInput("text_size3", "Font size:", min=0, max=10, value=2, step=0.1), 
		                                                                                                      selectInput("font_face3", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"), 
		                                                                                                      sliderInput("text_angle3", "Font angle:", min=0, max=360, value=60, step=1)
		                                                                                     )
		                                                                    )
		                                                                  )
		                                                                )
		                                               )
		                              )
		             ),
		             
		             checkboxInput("data4", HTML("<font color='red'>Data4</font>"), FALSE),
		             conditionalPanel(condition = "input.data4",
		                              radioButtons("sel_upload_data4", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		                              conditionalPanel(condition = "input.sel_upload_data4 == '2'",
		                                               fileInput("uploaddata4", h5("Upload data4:", 
		                                                                           bsButton("bsb100", label="", icon=icon("question"), style="info", size="small")
		                                               ), multiple = FALSE),
		                                               bsPopover("bsb100", 'Click "Browse" to upload the track data.', trigger = "focus"),
		                                               actionButton("tabBut5", "View example data"),
		                                               tags$script('$( "#uploaddata4" ).on( "click", function() { this.value = null; });'),
		                                               downloadButton("example_data4.txt", "Example data"),
		                                               br(),
		                                               br(),
		                                               selectInput("layer_index4", h5("Track index:", 
		                                                                              bsButton("bsb101", label="", icon=icon("question"), style="info", size="small")), 
		                                                           choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
		                                               bsPopover("bsb101",
		                                                 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.',
		                                                 trigger = "focus"
		                                               ),
		                                               selectInput("plot_type4", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical_line", "horizontal_line", "ideogram"), selected="point"),
		                                               
		                                               conditionalPanel(condition = "input.plot_type4!='ideogram'",
		                                                                ADVANCED_OPTIONS_PANEL_4(
		                                                                  list(
		                                                                    checkboxInput("color_opt4", HTML("<font color='red'>Color</font>"), FALSE),
		                                                                    conditionalPanel(condition = "input.color_opt4",
		                                                                                     conditionalPanel(condition="input.plot_type4 == 'point' | input.plot_type4 == 'line' | input.plot_type4 == 'bar' | input.plot_type4 == 'segment'",
		                                                                                                      selectInput("col_type4", h5("Data color",
		                                                                                                                                  bsButton("bsb102", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "One custom color" = "2",
		                                                                                                           "Custom for data with multi-group" = "3"), selected="1"),
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
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb104", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.rect_grad_col4=='1'",
		                                                                                                                       selectInput("col_rect4", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
		                                                                                                                                                                  "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
		                                                                                                                                                                  "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
		                                                                                                                                                                  "navy.cyan", "blue.red", "green.red"))
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition = "input.rect_grad_col4=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("rect_lowColor4", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("rect_midColor4", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("rect_highColor4", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                                                                       br()
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type4=='heatmap_gradual'",
		                                                                                                      selectInput("sel_heatmap_col4", h5("Colors", 
		                                                                                                                                         bsButton("bsb105", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb105", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col4=='1'",
		                                                                                                                       selectInput("hmap_col4", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
		                                                                                                                                                                  "purple.yellow.red", "blue.green.red", "blue.yellow.green",
		                                                                                                                                                                  "cyan.white.deeppink1"), selected="blue.white.red")
		                                                                                                      ), 
		                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col4=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("lowColor4", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("midColor4", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("highColor4", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
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
		                                                                                                                'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', 
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
		             ), 
		             
		             checkboxInput("data5", HTML("<font color='red'>Data5</font>"), FALSE),
		             conditionalPanel(condition="input.data5",
		                              radioButtons("sel_upload_data5", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		                              conditionalPanel(condition="input.sel_upload_data5 == '2'",
		                                               fileInput("uploaddata5", h5("Upload data5:",
		                                                                           bsButton("bsb132", label="", icon=icon("question"), style="info", size="small")
		                                               ), multiple = FALSE),
		                                               bsPopover("bsb132", 'Click "Browse" to upload the track data.', trigger = "focus"),
		                                               actionButton("tabBut6", "View example data"),
		                                               tags$script('$( "#uploaddata5" ).on( "click", function() { this.value = null; });'),
		                                               downloadButton("example_data5.txt", "Example data"),
		                                               
		                                               br(),
		                                               br(),
		                                               
		                                               selectInput("layer_index5", h5("Track index:", 
		                                                                              bsButton("bsb133", label="", icon=icon("question"), style="info", size="small")), 
		                                                           choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
		                                               bsPopover("bsb133",
		                                                 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.',
		                                                 trigger = "focus"
		                                               ),
		                                               selectInput("plot_type5", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical_line", "horizontal_line", "ideogram"), selected="point"),
		                                               
		                                               conditionalPanel(condition = "input.plot_type5!='ideogram'",
		                                                                ADVANCED_OPTIONS_PANEL_5(
		                                                                  list(
		                                                                    checkboxInput("color_opt5", HTML("<font color='red'>Color</font>"), FALSE),  
		                                                                    conditionalPanel(condition = "input.color_opt5",
		                                                                                     conditionalPanel(condition="input.plot_type5 == 'point' | input.plot_type5 == 'line' | input.plot_type5 == 'bar' | input.plot_type5 == 'segment'",
		                                                                                                      selectInput("col_type5", h5("Data color",
		                                                                                                                                  bsButton("bsb134", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "One custom color" = "2",
		                                                                                                           "Custom for data with multi-group" = "3"), selected="1"),
		                                                                                                      bsPopover(		                                                                                                        "bsb134",
		                                                                                                        'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.',
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
		                                                                                                      bsPopover("bsb135", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
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
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb136", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.rect_grad_col5=='1'",
		                                                                                                                       selectInput("col_rect5", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
		                                                                                                                                                                  "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
		                                                                                                                                                                  "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
		                                                                                                                                                                  "navy.cyan", "blue.red", "green.red"))
		                                                                                                      ), 
		                                                                                                      conditionalPanel(condition = "input.rect_grad_col5=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("rect_lowColor5", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("rect_midColor5", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("rect_highColor5", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                                                                       br()
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type5=='heatmap_gradual'",
		                                                                                                      selectInput("sel_heatmap_col5", h5("Colors", 
		                                                                                                                                         bsButton("bsb137", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb137", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col5=='1'",
		                                                                                                                       selectInput("hmap_col5", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
		                                                                                                                                                                  "purple.yellow.red", "blue.green.red", "blue.yellow.green",
		                                                                                                                                                                  "cyan.white.deeppink1"), selected="blue.white.red")
		                                                                                                      ), 
		                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col5=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("lowColor5", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("midColor5", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("highColor5", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                                                                       br()
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type5=='heatmap_discrete'",
		                                                                                                      selectInput("hmap_col_dis5", h5("Data color", 
		                                                                                                                                      bsButton("bsb138", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb138", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
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
		                                                                                                                'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', 
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
		             ), 
		             
		             checkboxInput("data6", HTML("<font color='red'>Data6</font>"), FALSE),
		             conditionalPanel(condition = "input.data6",
		                              radioButtons("sel_upload_data6", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		                              conditionalPanel(condition = "input.sel_upload_data6 == '2'",
		                                               fileInput("uploaddata6", h5("Upload data6:", 
		                                                                           bsButton("bsb162", label="", icon=icon("question"), style="info", size="small")
		                                               ), multiple = FALSE),
		                                               bsPopover("bsb162", 'Click "Browse" to upload the track data.', trigger = "focus"),
		                                               actionButton("tabBut7", "View example data"),
		                                               tags$script('$( "#uploaddata6" ).on( "click", function() { this.value = null; });'),
		                                               downloadButton("example_data6.txt", "Example data"),
		                                               
		                                               br(),
		                                               br(),
		                                               
		                                               selectInput("layer_index6", h5("Track index:", 
		                                                                              bsButton("bsb163", label="", icon=icon("question"), style="info", size="small")), 
		                                                           choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"), 
		                                               bsPopover("bsb163", 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.', trigger = "focus"), 
		                                               selectInput("plot_type6", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical_line", "horizontal_line", "ideogram"), selected="point"),
		                                               
		                                               conditionalPanel(condition = "input.plot_type6!='ideogram'",
		                                                                ADVANCED_OPTIONS_PANEL_6(
		                                                                  list(
		                                                                    checkboxInput("color_opt6", HTML("<font color='red'>Color</font>"), FALSE), 
		                                                                    conditionalPanel(condition = "input.color_opt6",
		                                                                                     conditionalPanel(condition="input.plot_type6 == 'point' | input.plot_type6 == 'line' | input.plot_type6 == 'bar' | input.plot_type6 == 'segment'",
		                                                                                                      selectInput("col_type6", h5("Data color",
		                                                                                                                                  bsButton("bsb164", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "One custom color" = "2",
		                                                                                                           "Custom for data with multi-group" = "3"), selected="1"), 
		                                                                                                      bsPopover("bsb164", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.col_type6=='2'",
		                                                                                                                       fluidRow(column(12, jscolorInput("color_cus6", label = NULL, value = "#FF0000"))),
		                                                                                                                       br()
		                                                                                                      ), 
		                                                                                                      conditionalPanel(condition = "input.col_type6=='3'",
		                                                                                                                       textInput("color_mulgp6", NULL, value="a:red;b:blue;c:cyan")
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type6=='rect_discrete'",
		                                                                                                      selectInput("rect_col6", h5("Data color", 
		                                                                                                                                  bsButton("bsb165", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected = "1"),
		                                                                                                      bsPopover("bsb165", 
		                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.rect_col6=='2'",
		                                                                                                                       fluidRow(column(12, jscolorInput("rect_col_dis6", label = NULL, value = "#FF0000"))),
		                                                                                                                       br()
		                                                                                                      ), 
		                                                                                                      conditionalPanel(condition = "input.rect_col6=='3'",
		                                                                                                                       textInput("rect_col_dis_cus6", NULL, value = "a:red;b:blue;c:cyan"))
		                                                                                     ),
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type6=='rect_gradual'",
		                                                                                                      selectInput("rect_grad_col6", h5("Colors", 
		                                                                                                                                       bsButton("bsb166", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb166", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.rect_grad_col6=='1'",
		                                                                                                                       selectInput("col_rect6", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
		                                                                                                                                                                  "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
		                                                                                                                                                                  "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
		                                                                                                                                                                  "navy.cyan", "blue.red", "green.red"))
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition = "input.rect_grad_col6=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("rect_lowColor6", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("rect_midColor6", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("rect_highColor6", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                                                                       br()
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type6=='heatmap_gradual'",
		                                                                                                      selectInput("sel_heatmap_col6", h5("Colors", 
		                                                                                                                                         bsButton("bsb167", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb167", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col6=='1'",
		                                                                                                                       selectInput("hmap_col6", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
		                                                                                                                                                                  "purple.yellow.red", "blue.green.red", "blue.yellow.green",
		                                                                                                                                                                  "cyan.white.deeppink1"), selected="blue.white.red")
		                                                                                                      ), 
		                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col6=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("lowColor6", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("midColor6", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("highColor6", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                                                                       br()
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type6=='heatmap_discrete'",
		                                                                                                      selectInput("hmap_col_dis6", h5("Data color", 
		                                                                                                                                      bsButton("bsb168", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb168", 
		                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.hmap_col_dis6=='2'",
		                                                                                                                       textInput("hmap_col_dis_cus6", NULL, value="a:red;b:blue;c:cyan")
		                                                                                                      )
		                                                                                     ),
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type6=='vertical_line' | input.plot_type6=='horizontal_line'",
		                                                                                                      fluidRow(column(12, jscolorInput("line_color6", label = h5('Line color:', 
		                                                                                                                                                                 bsButton("bsb169", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), value = "#FF0000"))),
		                                                                                                      bsPopover("bsb169", 'The color to be used to plot the data.', trigger = "focus"),
		                                                                                                      br()
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type6=='line'",
		                                                                                                      selectInput("fill_area6", h5("Fill area", 
		                                                                                                                                   bsButton("bsb170", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                                      bsPopover("bsb170", "Fill the area below the lines.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.fill_area6=='1'",
		                                                                                                                       radioButtons("sel_area_type6", h5("Area color", 
		                                                                                                                                                         bsButton("bsb171", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Identical with lines" = "1", "Specific" = "2"), selected = "1"),
		                                                                                                                       bsPopover("bsb171", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.sel_area_type6=='2'",
		                                                                                                                                        fluidRow(column(12, jscolorInput("border_area6", label = NULL, value = "#0000FF"))),
		                                                                                                                                        br()
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type6=='point' | input.plot_type6=='line' | input.plot_type6=='bar' | input.plot_type6=='rect_gradual' | input.plot_type6=='rect_discrete' | input.plot_type6=='heatmap_gradual' | input.plot_type6=='heatmap_discrete' | input.plot_type6=='vertical_line' | input.plot_type6=='horizontal_line' | input.plot_type6=='text' | input.plot_type6 == 'segment'",
		                                                                                                      conditionalPanel(condition="input.plot_type6=='text'", 
		                                                                                                                       fluidRow(column(12, jscolorInput("text_col6", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
		                                                                                                                       br()
		                                                                                                      ), 
		                                                                                                      selectInput("col_lgd6", h5("Color legend",
		                                                                                                                                 bsButton("bsb172", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb172", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.col_lgd6=='1'",
		                                                                                                                       textInput("col_lgd_name6", h5("Legend title:", 
		                                                                                                                                                     bsButton("bsb173", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), value = "color"),
		                                                                                                                       bsPopover("bsb173", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.plot_type6!='rect_gradual' & input.plot_type6!='heatmap_gradual'",
		                                                                                                                                        selectInput("col_lgd_mdy_label6", h5("Modify legend labels", 
		                                                                                                                                                                             bsButton("bsb174", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                                        bsPopover("bsb174", 
		                                                                                                                                                  'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', 
		                                                                                                                                                  trigger = "focus"),
		                                                                                                                                        conditionalPanel(condition = "input.col_lgd_mdy_label6=='1'",
		                                                                                                                                                         textInput("col_lgd_label6", NULL, value = "a,b,c"))
		                                                                                                                       )
		                                                                                                      )				
		                                                                                     ),
		                                                                                     
		                                                                                     conditionalPanel(condition="input.plot_type6!='rect_gradual' & input.plot_type6!='heatmap_gradual' & input.plot_type6!='text' & input.plot_type6!='ideogram'",
		                                                                                                      sliderInput("col_transpt6",
		                                                                                                                  h5("Color transparency:",
		                                                                                                                     bsButton("bsb175", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                  ), min = 0, max = 1, value = 1, step =
		                                                                                                                    0.1),
		                                                                                                      bsPopover("bsb175", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")										  
		                                                                                     )
		                                                                    ),
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type6=='line' | input.plot_type6=='vertical_line' | input.plot_type6=='horizontal_line' | input.plot_type6 == 'segment'",
		                                                                                     checkboxInput("linetype_opt6", HTML("<font color='red'>Linetype</font>"), FALSE), 
		                                                                                     conditionalPanel(condition = "input.linetype_opt6",
		                                                                                                      sliderInput("line_size6", "Line width:", min=0, max=3, value=0.2, step=0.05),
		                                                                                                      selectInput("linetype6", h5("Line type",
		                                                                                                                                  bsButton("bsb176", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("solid", "dashed", "dotted", "dotdash", "longdash", "twodash"), selected =
		                                                                                                        "solid"),
		                                                                                                      bsPopover("bsb176", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.plot_type6=='vertical_line' | input.plot_type6=='horizontal_line'",
		                                                                                                                       selectInput("line_type_lgd6", h5("Line type legend", 
		                                                                                                                                                        bsButton("bsb177", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                                       bsPopover("bsb177", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
		                                                                                                                       
		                                                                                                                       conditionalPanel(condition = "input.line_type_lgd6=='1'",
		                                                                                                                                        textInput("line_type_lgd_name6", h5("Legend title:", 
		                                                                                                                                                                            bsButton("bsb178", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), value = "linetype"),
		                                                                                                                                        bsPopover("bsb178", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                                        selectInput("line_type_lgd_mdy_label6",
		                                                                                                                                                    h5("Modify legend labels",
		                                                                                                                                                       bsButton("bsb179", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                                    ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                                        bsPopover("bsb179", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
		                                                                                                                                        conditionalPanel(condition = "input.line_type_lgd_mdy_label6=='1'",
		                                                                                                                                                         textInput("line_type_lgd_label6", NULL, value="a")
		                                                                                                                                        )
		                                                                                                                       )
		                                                                                                      ), 
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.plot_type6 == 'segment'",
		                                                                                                                       selectInput("add_arrow6", h5("Add arrow head", 
		                                                                                                                                                    bsButton("bsb180", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Yes" = "1", "No" = "2"), selected =
		                                                                                                                         "2"),
		                                                                                                                       bsPopover("bsb180", "Add arrow head for the segment.", trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.add_arrow6 == '1'",
		                                                                                                                                        selectInput("arrow_pos6", h5("Arrow position", 
		                                                                                                                                                                     bsButton("bsb181", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), c("Line end" = "1", "Line beginning" = "2"), selected =
		                                                                                                                                          "1"),
		                                                                                                                                        bsPopover("bsb181", 'The position of arrow head.',trigger = "focus"),
		                                                                                                                                        sliderInput("arrow_size6", h5("Arrow size:",
		                                                                                                                                                                      bsButton("bsb182", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), min = 0, max = 2, value = 0.1, step = 0.01),
		                                                                                                                                        bsPopover("bsb182", 'The size of arrow head.',trigger = "focus")								
		                                                                                                                       )
		                                                                                                      )
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type6=='point'",
		                                                                                     checkboxInput("symbol_opt6", HTML("<font color='red'>Symbol</font>"), FALSE),
		                                                                                     conditionalPanel(condition = "input.symbol_opt6",
		                                                                                                      selectInput("sel_symbol_point6", h5("Symbol type", 
		                                                                                                                                          bsButton("bsb183", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("One custom symbol" = "1",
		                                                                                                           'Custom for data with a "shape" column' = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb183", 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.sel_symbol_point6=='1'",
		                                                                                                                       sliderInput("symbol_point6", NULL, min=0, max=25, value=16, step=1)
		                                                                                                      ),
		                                                                                                      selectInput("shape_lgd6", h5("Symbol legend",
		                                                                                                                                   bsButton("bsb184", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb184", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.shape_lgd6=='1'",
		                                                                                                                       textInput("shape_lgd_name6", h5("Legend title:", 
		                                                                                                                                                       bsButton("bsb185", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), value = "symbol"),
		                                                                                                                       bsPopover("bsb185", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       selectInput("shape_lgd_mdy_label6",
		                                                                                                                                   h5("Modify legend labels",
		                                                                                                                                      bsButton("bsb186", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                   ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                       bsPopover("bsb186", 
		                                                                                                                                 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', 
		                                                                                                                                 trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.shape_lgd_mdy_label6=='1'",
		                                                                                                                                        textInput("shape_lgd_label6", NULL, value="a,b,c")
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     checkboxInput("size_opt6", HTML("<font color='red'>Size</font>"), FALSE),
		                                                                                     conditionalPanel(condition = "input.size_opt6",
		                                                                                                      selectInput("sel_point_size6", h5("Point size",
		                                                                                                                                        bsButton("bsb187", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("One custom size" = "1",
		                                                                                                           'Custom for data with a "size" column' = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb187", 
		                                                                                                                'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.sel_point_size6=='1'",
		                                                                                                                       sliderInput("point_size6", NULL, min=0, max=5, value=0.8, step=0.1)
		                                                                                                      ),
		                                                                                                      selectInput("size_lgd6", h5("Size legend", 
		                                                                                                                                  bsButton("bsb188", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb188", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.size_lgd6=='1'",
		                                                                                                                       textInput("size_lgd_name6", h5("Legend title:", 
		                                                                                                                                                      bsButton("bsb189", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), value = "size"),
		                                                                                                                       bsPopover("bsb189", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       selectInput("size_lgd_mdy_label6",
		                                                                                                                                   h5("Modify legend labels", 
		                                                                                                                                      bsButton("bsb190", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                   ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                       bsPopover("bsb190", 
		                                                                                                                                 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', 
		                                                                                                                                 trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.size_lgd_mdy_label6=='1'",
		                                                                                                                                        textInput("size_lgd_label6", NULL, value="a,b,c")
		                                                                                                                       )
		                                                                                                      )
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type6=='heatmap_gradual' | input.plot_type6=='heatmap_discrete' | input.plot_type6=='rect_gradual' | input.plot_type6=='rect_discrete' | input.plot_type6=='bar'",
		                                                                                     selectInput("add_border6", h5("Add cell borders", 
		                                                                                                                   bsButton("bsb191", label="", icon=icon("question"), style="info", size="small")
		                                                                                     ), c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                     bsPopover("bsb191", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
		                                                                                     conditionalPanel(condition = "input.add_border6=='1'",
		                                                                                                      fluidRow(column(12, jscolorInput("border_col6", label = h5('Borders color:'), value = "#000000"))),
		                                                                                                      br()
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type6=='line' | input.plot_type6=='point' | input.plot_type6=='bar'",
		                                                                                     selectInput("ylabel6", h5("Y axis label", 
		                                                                                                               bsButton("bsb193", label="", icon=icon("question"), style="info", size="small")
		                                                                                     ), choices = c("Show" = "1", "Hide" = "2"), selected = "1"),
		                                                                                     bsPopover("bsb193", "Add tick labels on the Y-axis.", trigger = "focus")								
		                                                                    ),
		                                                                    
		                                                                    conditionalPanel(condition="input.plot_type6=='text'",
		                                                                                     checkboxInput("font_opt6", HTML("<font color='red'>Font</font>"), FALSE),
		                                                                                     conditionalPanel(condition="input.font_opt6", 
		                                                                                                      sliderInput("text_size6", "Font size:", min=0, max=10, value=2, step=0.1), 
		                                                                                                      selectInput("font_face6", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"), 
		                                                                                                      sliderInput("text_angle6", "Font angle:", min=0, max=360, value=60, step=1)				
		                                                                                     )
		                                                                    )
		                                                                  )
		                                                                )
		                                               )
		                              )
		             ), 
		             
		             checkboxInput("data7", HTML("<font color='red'>Data7</font>"), FALSE),
		             conditionalPanel(condition = "input.data7",
		                              radioButtons("sel_upload_data7", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		                              conditionalPanel(condition = "input.sel_upload_data7 == '2'",
		                                               fileInput("uploaddata7", h5("Upload data7:", 
		                                                                           bsButton("bsb194", label="", icon=icon("question"), style="info", size="small")
		                                               ), multiple = FALSE),
		                                               bsPopover("bsb194", 'Click "Browse" to upload the track data.', trigger = "focus"),
		                                               actionButton("tabBut8", "View example data"),
		                                               tags$script('$( "#uploaddata7" ).on( "click", function() { this.value = null; });'),
		                                               downloadButton("example_data7.txt", "Example data"),
		                                               
		                                               br(),
		                                               br(),
		                                               
		                                               selectInput("layer_index7", h5("Track index:", 
		                                                                              bsButton("bsb195", label="", icon=icon("question"), style="info", size="small")), 
		                                                           choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"), 
		                                               bsPopover("bsb195", 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.', trigger = "focus"), 
		                                               selectInput("plot_type7", "Plot type:", 
		                                                           choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical_line", "horizontal_line", "ideogram"), selected="point"),
		                                               
		                                               conditionalPanel(condition = "input.plot_type7!='ideogram'",
		                                                                ADVANCED_OPTIONS_PANEL_7(
		                                                                  list(
		                                                                    checkboxInput("color_opt7", HTML("<font color='red'>Color</font>"), FALSE), 
		                                                                    conditionalPanel(condition = "input.color_opt7",
		                                                                                     conditionalPanel(condition="input.plot_type7 == 'point' | input.plot_type7 == 'line' | input.plot_type7 == 'bar' | input.plot_type7 == 'segment'",
		                                                                                                      selectInput("col_type7", h5("Data color",
		                                                                                                                                  bsButton("bsb196", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "One custom color" = "2",
		                                                                                                           "Custom for data with multi-group" = "3"), selected="1"), 
		                                                                                                      bsPopover("bsb196", 
		                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.col_type7=='2'",
		                                                                                                                       fluidRow(column(12, jscolorInput("color_cus7", label = NULL, value = "#FF0000"))),
		                                                                                                                       br()
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition = "input.col_type7=='3'",
		                                                                                                                       textInput("color_mulgp7", NULL, value="a:red;b:blue;c:cyan")
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type7=='rect_discrete'",
		                                                                                                      selectInput("rect_col7", h5("Data color", 
		                                                                                                                                  bsButton("bsb197", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected = "1"),
		                                                                                                      bsPopover("bsb197", 
		                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.rect_col7=='2'",
		                                                                                                                       fluidRow(column(12, jscolorInput("rect_col_dis7", label = NULL, value = "#FF0000"))),
		                                                                                                                       br()
		                                                                                                      ), 
		                                                                                                      conditionalPanel(condition = "input.rect_col7=='3'",
		                                                                                                                       textInput("rect_col_dis_cus7", NULL, value="a:red;b:blue;c:cyan")
		                                                                                                      )
		                                                                                     ),
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type7=='rect_gradual'",
		                                                                                                      selectInput("rect_grad_col7", h5("Colors", 
		                                                                                                                                       bsButton("bsb198", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb198", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.rect_grad_col7=='1'",
		                                                                                                                       selectInput("col_rect7", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
		                                                                                                                                                                  "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
		                                                                                                                                                                  "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
		                                                                                                                                                                  "navy.cyan", "blue.red", "green.red"))
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition = "input.rect_grad_col7=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("rect_lowColor7", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("rect_midColor7", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("rect_highColor7", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                                                                       br()
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type7=='heatmap_gradual'",
		                                                                                                      selectInput("sel_heatmap_col7", h5("Colors", 
		                                                                                                                                         bsButton("bsb199", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb199", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col7=='1'",
		                                                                                                                       selectInput("hmap_col7", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
		                                                                                                                                                                  "purple.yellow.red", "blue.green.red", "blue.yellow.green",
		                                                                                                                                                                  "cyan.white.deeppink1"), selected="blue.white.red")
		                                                                                                      ), 
		                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col7=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("lowColor7", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("midColor7", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("highColor7", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                                                                       br()
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type7=='heatmap_discrete'",
		                                                                                                      selectInput("hmap_col_dis7", h5("Data color", 
		                                                                                                                                      bsButton("bsb200", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb200", 
		                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.hmap_col_dis7=='2'",
		                                                                                                                       textInput("hmap_col_dis_cus7", NULL, value="a:red;b:blue;c:cyan")
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type7=='vertical_line' | input.plot_type7=='horizontal_line'",
		                                                                                                      fluidRow(column(12, jscolorInput("line_color7", label = h5('Line color:', 
		                                                                                                                                                                 bsButton("bsb201", label="", icon=icon("question"), style="info", size="small")), value = "#FF0000"))),
		                                                                                                      bsPopover("bsb201", 'The color to be used to plot the data.', trigger = "focus"),
		                                                                                                      br()
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type7=='line'",
		                                                                                                      selectInput("fill_area7", h5("Fill area", 
		                                                                                                                                   bsButton("bsb202", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Yes" = "1", "No" = "2"), selected = "2"), 
		                                                                                                      bsPopover("bsb202", "Fill the area below the lines.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.fill_area7=='1'",
		                                                                                                                       radioButtons("sel_area_type7", h5("Area color", 
		                                                                                                                                                         bsButton("bsb203", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Identical with lines" = "1", "Specific" = "2"), selected = "1"),
		                                                                                                                       bsPopover("bsb203", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.sel_area_type7=='2'",
		                                                                                                                                        fluidRow(column(12, jscolorInput("border_area7", label = NULL, value = "#0000FF"))),
		                                                                                                                                        br()
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type7=='point' | input.plot_type7=='line' | input.plot_type7=='bar' | input.plot_type7=='rect_gradual' | input.plot_type7=='rect_discrete' | input.plot_type7=='heatmap_gradual' | input.plot_type7=='heatmap_discrete' | input.plot_type7=='vertical_line' | input.plot_type7=='horizontal_line' | input.plot_type7=='text' | input.plot_type7 == 'segment'",
		                                                                                                      conditionalPanel(condition="input.plot_type7=='text'", 
		                                                                                                                       fluidRow(column(12, jscolorInput("text_col7", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
		                                                                                                                       br()
		                                                                                                      ),			                
		                                                                                                      selectInput("col_lgd7", h5("Color legend",
		                                                                                                                                 bsButton("bsb204", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb204", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.col_lgd7=='1'",
		                                                                                                                       textInput("col_lgd_name7", h5("Legend title:", 
		                                                                                                                                                     bsButton("bsb205", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), value = "color"),
		                                                                                                                       bsPopover("bsb205", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.plot_type7!='rect_gradual' & input.plot_type7!='heatmap_gradual'",
		                                                                                                                                        selectInput("col_lgd_mdy_label7", h5("Modify legend labels", 
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
		                                                                                                      selectInput("linetype7", h5("Line type",
		                                                                                                                                  bsButton("bsb208", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("solid", "dashed", "dotted", "dotdash", "longdash", "twodash"), selected = "solid"),
		                                                                                                      bsPopover("bsb208", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.plot_type7=='vertical_line' | input.plot_type7=='horizontal_line'",
		                                                                                                                       selectInput("line_type_lgd7", h5("Line type legend", 
		                                                                                                                                                        bsButton("bsb209", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                                       bsPopover("bsb209", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.line_type_lgd7=='1'",
		                                                                                                                                        textInput("line_type_lgd_name7", h5("Legend title:", 
		                                                                                                                                                                            bsButton("bsb210", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), value = "linetype"),
		                                                                                                                                        bsPopover("bsb210", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                                        selectInput("line_type_lgd_mdy_label7",
		                                                                                                                                                    h5("Modify legend labels",
		                                                                                                                                                       bsButton("bsb211", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                                    ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                                        bsPopover("bsb211", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
		                                                                                                                                        conditionalPanel(condition = "input.line_type_lgd_mdy_label7=='1'",
		                                                                                                                                                         textInput("line_type_lgd_label7", NULL, value="a")
		                                                                                                                                        )
		                                                                                                                       )
		                                                                                                      ), 
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.plot_type7 == 'segment'",
		                                                                                                                       selectInput("add_arrow7", h5("Add arrow head", 
		                                                                                                                                                    bsButton("bsb212", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                                                       bsPopover("bsb212", "Add arrow head for the segment.", trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.add_arrow7 == '1'",
		                                                                                                                                        selectInput("arrow_pos7", h5("Arrow position", 
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
		                                                                                                      selectInput("sel_symbol_point7", h5("Symbol type", 
		                                                                                                                                          bsButton("bsb215", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("One custom symbol" = "1",
		                                                                                                           'Custom for data with a "shape" column' = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb215", 
		                                                                                                                'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.sel_symbol_point7=='1'",
		                                                                                                                       sliderInput("symbol_point7", NULL, min=0, max=25, value=16, step=1)
		                                                                                                      ),
		                                                                                                      selectInput("shape_lgd7", h5("Symbol legend", 
		                                                                                                                                   bsButton("bsb216", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb216", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.shape_lgd7=='1'",
		                                                                                                                       textInput("shape_lgd_name7", h5("Legend title:", 
		                                                                                                                                                       bsButton("bsb217", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), value = "symbol"),
		                                                                                                                       bsPopover("bsb217", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       selectInput("shape_lgd_mdy_label7",
		                                                                                                                                   h5("Modify legend labels",
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
		                                                                                                      selectInput("sel_point_size7", h5("Point size",
		                                                                                                                                        bsButton("bsb219", label="", icon=icon("question"), style="info", size="small")), 
		                                                                                                                  c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb219", 
		                                                                                                                'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.sel_point_size7=='1'",
		                                                                                                                       sliderInput("point_size7", NULL, min=0, max=5, value=0.8, step=0.1)
		                                                                                                      ),
		                                                                                                      selectInput("size_lgd7", h5("Size legend", 
		                                                                                                                                  bsButton("bsb220", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb220", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.size_lgd7=='1'",
		                                                                                                                       textInput("size_lgd_name7", h5("Legend title:", 
		                                                                                                                                                      bsButton("bsb221", label="", icon=icon("question"), style="info", size="small")), value = "size"),
		                                                                                                                       bsPopover("bsb221", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       selectInput("size_lgd_mdy_label7",
		                                                                                                                                   h5("Modify legend labels",
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
		                                                                                     selectInput("add_border7", h5("Add cell borders", 
		                                                                                                                   bsButton("bsb223", label="", icon=icon("question"), style="info", size="small")
		                                                                                     ), c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                     bsPopover("bsb223", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
		                                                                                     conditionalPanel(condition = "input.add_border7=='1'",
		                                                                                                      fluidRow(column(12, jscolorInput("border_col7", label = h5('Borders color:'), value = "#000000"))),
		                                                                                                      br()
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type7=='line' | input.plot_type7=='point' | input.plot_type7=='bar'",
		                                                                                     selectInput("ylabel7", h5("Y axis label", 
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
		             ), 
		             
		             checkboxInput("data8", HTML("<font color='red'>Data8</font>"), FALSE),
		             conditionalPanel(condition="input.data8",
		                              radioButtons("sel_upload_data8", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		                              conditionalPanel(condition="input.sel_upload_data8 == '2'",
		                                               fileInput("uploaddata8", h5("Upload data8:",
		                                                                           bsButton("bsb226", label="", icon=icon("question"), style="info", size="small")
		                                               ), multiple = FALSE),
		                                               bsPopover("bsb226", 'Click "Browse" to upload the track data.', trigger = "focus"),
		                                               actionButton("tabBut9", "View example data"),
		                                               tags$script('$( "#uploaddata8" ).on( "click", function() { this.value = null; });'),
		                                               downloadButton("example_data8.txt", "Example data"),
		                                               
		                                               br(),
		                                               br(),
		                                               
		                                               selectInput("layer_index8", h5("Track index:", 
		                                                                              bsButton("bsb227", label="", icon=icon("question"), style="info", size="small")), 
		                                                           choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"), 
		                                               bsPopover("bsb227", 
		                                                         'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.', 
		                                                         trigger = "focus"), 
		                                               selectInput("plot_type8", "Plot type:", 
		                                                           choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical_line", "horizontal_line", "ideogram"), selected="point"),
		                                               
		                                               conditionalPanel(condition = "input.plot_type8!='ideogram'",
		                                                                ADVANCED_OPTIONS_PANEL_8(
		                                                                  list(
		                                                                    checkboxInput("color_opt8", HTML("<font color='red'>Color</font>"), FALSE), 
		                                                                    conditionalPanel(condition = "input.color_opt8",
		                                                                                     conditionalPanel(condition="input.plot_type8 == 'point' | input.plot_type8 == 'line' | input.plot_type8 == 'bar' | input.plot_type8 == 'segment'",
		                                                                                                      selectInput("col_type8", h5("Data color",
		                                                                                                                                  bsButton("bsb228", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "One custom color" = "2",
		                                                                                                           "Custom for data with multi-group" = "3"), selected="1"), 
		                                                                                                      bsPopover("bsb228", 
		                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.col_type8=='2'",
		                                                                                                                       fluidRow(column(12, jscolorInput("color_cus8", label = NULL, value = "#FF0000"))),
		                                                                                                                       br()
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition = "input.col_type8=='3'",
		                                                                                                                       textInput("color_mulgp8", NULL, value="a:red;b:blue;c:cyan")
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type8=='rect_discrete'",
		                                                                                                      selectInput("rect_col8", h5("Data color", 
		                                                                                                                                  bsButton("bsb229", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected = "1"),
		                                                                                                      bsPopover("bsb229", 
		                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.rect_col8=='2'",
		                                                                                                                       fluidRow(column(12, jscolorInput("rect_col_dis8", label = NULL, value = "#FF0000"))),
		                                                                                                                       br()
		                                                                                                      ), 
		                                                                                                      conditionalPanel(condition = "input.rect_col8=='3'",
		                                                                                                                       textInput("rect_col_dis_cus8", NULL, value="a:red;b:blue;c:cyan")
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type8=='rect_gradual'",
		                                                                                                      selectInput("rect_grad_col8", h5("Colors", 
		                                                                                                                                       bsButton("bsb230", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb230", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.rect_grad_col8=='1'",
		                                                                                                                       selectInput("col_rect8", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
		                                                                                                                                                                  "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
		                                                                                                                                                                  "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
		                                                                                                                                                                  "navy.cyan", "blue.red", "green.red"))
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition = "input.rect_grad_col8=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("rect_lowColor8", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("rect_midColor8", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("rect_highColor8", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                                                                       br()
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type8=='heatmap_gradual'",
		                                                                                                      selectInput("sel_heatmap_col8", h5("Colors", 
		                                                                                                                                         bsButton("bsb231", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb231", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col8=='1'",
		                                                                                                                       selectInput("hmap_col8", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
		                                                                                                                                                                  "purple.yellow.red", "blue.green.red", "blue.yellow.green",
		                                                                                                                                                                  "cyan.white.deeppink1"), selected="blue.white.red")
		                                                                                                      ), 
		                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col8=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("lowColor8", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("midColor8", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("highColor8", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                                                                       br()
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type8=='heatmap_discrete'",
		                                                                                                      selectInput("hmap_col_dis8", h5("Data color", 
		                                                                                                                                      bsButton("bsb232", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb232", 
		                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.hmap_col_dis8=='2'",
		                                                                                                                       textInput("hmap_col_dis_cus8", NULL, value="a:red;b:blue;c:cyan")
		                                                                                                      )
		                                                                                     ),
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type8=='vertical_line' | input.plot_type8=='horizontal_line'",
		                                                                                                      fluidRow(column(12, jscolorInput("line_color8", label = h5('Line color:', 
		                                                                                                                                                                 bsButton("bsb233", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), value = "#FF0000"))),
		                                                                                                      bsPopover("bsb233", 'The color to be used to plot the data.', trigger = "focus"),
		                                                                                                      br()
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type8=='line'",
		                                                                                                      selectInput("fill_area8", h5("Fill area", 
		                                                                                                                                   bsButton("bsb234", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                                      bsPopover("bsb234", "Fill the area below the lines.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.fill_area8=='1'",
		                                                                                                                       radioButtons("sel_area_type8", h5("Area color", 
		                                                                                                                                                         bsButton("bsb235", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Identical with lines" = "1", "Specific" = "2"), selected = "1"),
		                                                                                                                       bsPopover("bsb235", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.sel_area_type8=='2'",
		                                                                                                                                        fluidRow(column(12, jscolorInput("border_area8", label = NULL, value = "#0000FF"))),
		                                                                                                                                        br()
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type8=='point' | input.plot_type8=='line' | input.plot_type8=='bar' | input.plot_type8=='rect_gradual' | input.plot_type8=='rect_discrete' | input.plot_type8=='heatmap_gradual' | input.plot_type8=='heatmap_discrete' | input.plot_type8=='vertical_line' | input.plot_type8=='horizontal_line' | input.plot_type8=='text' | input.plot_type8 == 'segment'",
		                                                                                                      conditionalPanel(condition="input.plot_type8=='text'", 
		                                                                                                                       fluidRow(column(12, jscolorInput("text_col8", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
		                                                                                                                       br()
		                                                                                                      ),			                
		                                                                                                      selectInput("col_lgd8", h5("Color legend",
		                                                                                                                                 bsButton("bsb236", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb236", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.col_lgd8=='1'",
		                                                                                                                       textInput("col_lgd_name8", h5("Legend title:", 
		                                                                                                                                                     bsButton("bsb237", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), value = "color"),
		                                                                                                                       bsPopover("bsb237", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.plot_type8!='rect_gradual' & input.plot_type8!='heatmap_gradual'",
		                                                                                                                                        selectInput("col_lgd_mdy_label8", h5("Modify legend labels", 
		                                                                                                                                                                             bsButton("bsb238", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                                        bsPopover("bsb238", 
		                                                                                                                                                  'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', 
		                                                                                                                                                  trigger = "focus"),
		                                                                                                                                        conditionalPanel(condition = "input.col_lgd_mdy_label8=='1'",
		                                                                                                                                                         textInput("col_lgd_label8", NULL, value="a,b,c")
		                                                                                                                                        )
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type8!='rect_gradual' & input.plot_type8!='heatmap_gradual' & input.plot_type8!='text' & input.plot_type8!='ideogram'",
		                                                                                                      sliderInput("col_transpt8", h5("Color transparency:", 
		                                                                                                                                     bsButton("bsb239", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), min = 0, max = 1, value = 1, step = 0.1),
		                                                                                                      bsPopover("bsb239", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")										  
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type8=='line' | input.plot_type8=='vertical_line' | input.plot_type8=='horizontal_line' | input.plot_type8 == 'segment'",
		                                                                                     checkboxInput("linetype_opt8", HTML("<font color='red'>Linetype</font>"), FALSE),  
		                                                                                     conditionalPanel(condition = "input.linetype_opt8",
		                                                                                                      sliderInput("line_size8", "Line width:", min=0, max=3, value=0.2, step=0.05),
		                                                                                                      selectInput("linetype8", h5("Line type",
		                                                                                                                                  bsButton("bsb240", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("solid", "dashed", "dotted", "dotdash", "longdash", "twodash"), selected = "solid"),
		                                                                                                      bsPopover("bsb240", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.plot_type8=='vertical_line' | input.plot_type8=='horizontal_line'",
		                                                                                                                       selectInput("line_type_lgd8", h5("Line type legend", 
		                                                                                                                                                        bsButton("bsb241", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                                       bsPopover("bsb241", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.line_type_lgd8=='1'",
		                                                                                                                                        textInput("line_type_lgd_name8", h5("Legend title:", bsButton("bsb242", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), value = "linetype"),
		                                                                                                                                        bsPopover("bsb242", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                                        selectInput("line_type_lgd_mdy_label8",
		                                                                                                                                                    h5("Modify legend labels",
		                                                                                                                                                       bsButton("bsb243", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                                    ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                                        bsPopover("bsb243", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
		                                                                                                                                        conditionalPanel(condition = "input.line_type_lgd_mdy_label8=='1'",
		                                                                                                                                                         textInput("line_type_lgd_label8", NULL, value="a")
		                                                                                                                                        )
		                                                                                                                       )
		                                                                                                      ), 
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.plot_type8 == 'segment'",
		                                                                                                                       selectInput("add_arrow8", h5("Add arrow head", 
		                                                                                                                                                    bsButton("bsb244", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                                                       bsPopover("bsb244", "Add arrow head for the segment.", trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.add_arrow8 == '1'",
		                                                                                                                                        selectInput("arrow_pos8", h5("Arrow position", 
		                                                                                                                                                                     bsButton("bsb245", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), c("Line end" = "1", "Line beginning" = "2"), selected = "1"),
		                                                                                                                                        bsPopover("bsb245", 'The position of arrow head.',trigger = "focus"),
		                                                                                                                                        sliderInput("arrow_size8", h5("Arrow size:",
		                                                                                                                                                                      bsButton("bsb246", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), min = 0, max = 2, value = 0.1, step = 0.01),
		                                                                                                                                        bsPopover("bsb246", 'The size of arrow head.',trigger = "focus")								
		                                                                                                                       )
		                                                                                                      )
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type8=='point'",
		                                                                                     checkboxInput("symbol_opt8", HTML("<font color='red'>Symbol</font>"), FALSE), 
		                                                                                     conditionalPanel(condition = "input.symbol_opt8",
		                                                                                                      selectInput("sel_symbol_point8", h5("Symbol type", 
		                                                                                                                                          bsButton("bsb247", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("One custom symbol" = "1",
		                                                                                                           'Custom for data with a "shape" column' = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb247", 
		                                                                                                                'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.sel_symbol_point8=='1'",
		                                                                                                                       sliderInput("symbol_point8", NULL, min=0, max=25, value=16, step=1)
		                                                                                                      ),
		                                                                                                      selectInput("shape_lgd8", h5("Symbol legend", 
		                                                                                                                                   bsButton("bsb248", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb248", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.shape_lgd8=='1'",
		                                                                                                                       textInput("shape_lgd_name8", h5("Legend title:", 
		                                                                                                                                                       bsButton("bsb249", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), value = "symbol"),
		                                                                                                                       bsPopover("bsb249", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       selectInput("shape_lgd_mdy_label8",
		                                                                                                                                   h5("Modify legend labels",
		                                                                                                                                      bsButton("bsb250", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                   ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                       bsPopover("bsb250", 
		                                                                                                                                 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', 
		                                                                                                                                 trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.shape_lgd_mdy_label8=='1'",
		                                                                                                                                        textInput("shape_lgd_label8", NULL, value="a,b,c")
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     checkboxInput("size_opt8", HTML("<font color='red'>Size</font>"), FALSE),
		                                                                                     conditionalPanel(condition="input.size_opt8",  				
		                                                                                                      selectInput("sel_point_size8", h5("Point size",
		                                                                                                                                        bsButton("bsb251", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb251", 
		                                                                                                                'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.sel_point_size8=='1'",
		                                                                                                                       sliderInput("point_size8", NULL, min=0, max=5, value=0.8, step=0.1)
		                                                                                                      ), 
		                                                                                                      selectInput("size_lgd8", h5("Size legend",
		                                                                                                                                  bsButton("bsb252", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb252", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.size_lgd8=='1'",
		                                                                                                                       textInput("size_lgd_name8", 
		                                                                                                                                 h5("Legend title:", 
		                                                                                                                                    bsButton("bsb253", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                 ), value = "size"),
		                                                                                                                       bsPopover("bsb253", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       selectInput("size_lgd_mdy_label8",
		                                                                                                                                   h5("Modify legend labels",
		                                                                                                                                      bsButton("bsb254", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                   ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                       bsPopover("bsb254", 
		                                                                                                                                 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', 
		                                                                                                                                 trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.size_lgd_mdy_label8=='1'",
		                                                                                                                                        textInput("size_lgd_label8", NULL, value="a,b,c")
		                                                                                                                       )
		                                                                                                      )
		                                                                                     )
		                                                                    ),
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type8=='heatmap_gradual' | input.plot_type8=='heatmap_discrete' | input.plot_type8=='rect_gradual' | input.plot_type8=='rect_discrete' | input.plot_type8=='bar'",
		                                                                                     selectInput("add_border8", h5("Add cell borders", 
		                                                                                                                   bsButton("bsb255", label="", icon=icon("question"), style="info", size="small")
		                                                                                     ), c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                     bsPopover("bsb255", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
		                                                                                     conditionalPanel(condition = "input.add_border8=='1'",
		                                                                                                      fluidRow(column(12, jscolorInput("border_col8", label = h5('Borders color:'), value = "#000000"))),
		                                                                                                      br()
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type8=='line' | input.plot_type8=='point' | input.plot_type8=='bar'",
		                                                                                     selectInput("ylabel8", h5("Y axis label", 
		                                                                                                               bsButton("bsb257", label="", icon=icon("question"), style="info", size="small")
		                                                                                     ), choices = c("Show" = "1", "Hide" = "2"), selected = "1"),
		                                                                                     bsPopover("bsb257", "Add tick labels on the Y-axis.", trigger = "focus")								
		                                                                    ),
		                                                                    
		                                                                    conditionalPanel(condition="input.plot_type8=='text'",
		                                                                                     checkboxInput("font_opt8", HTML("<font color='red'>Font</font>"), FALSE),
		                                                                                     conditionalPanel(condition="input.font_opt8", 
		                                                                                                      sliderInput("text_size8", "Font size:", min=0, max=10, value=2, step=0.1), 
		                                                                                                      selectInput("font_face8", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"), 
		                                                                                                      sliderInput("text_angle8", "Font angle:", min=0, max=360, value=60, step=1)				
		                                                                                     )
		                                                                    )
		                                                                  )
		                                                                )
		                                               )
		                              )
		             ), 		
		             
		             checkboxInput("data9", HTML("<font color='red'>Data9</font>"), FALSE),
		             conditionalPanel(condition="input.data9",
		                              radioButtons("sel_upload_data9", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		                              conditionalPanel(condition="input.sel_upload_data9 == '2'",
		                                               fileInput("uploaddata9", h5("Upload data9:",
		                                                                           bsButton("bsb258", label="", icon=icon("question"), style="info", size="small")
		                                               ), multiple = FALSE),
		                                               bsPopover("bsb258", 'Click "Browse" to upload the track data.', trigger = "focus"),
		                                               actionButton("tabBut10", "View example data"),
		                                               tags$script('$( "#uploaddata9" ).on( "click", function() { this.value = null; });'),
		                                               downloadButton("example_data9.txt", "Example data"),
		                                               
		                                               br(),
		                                               br(),
		                                               
		                                               selectInput("layer_index9", h5("Track index:", 
		                                                                              bsButton("bsb259", label="", icon=icon("question"), style="info", size="small")), 
		                                                           choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"), 
		                                               bsPopover("bsb259", 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.', trigger = "focus"), 
		                                              
		                                               selectInput("plot_type9", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical_line", "horizontal_line", "ideogram"), selected="point"),
		                                               conditionalPanel(condition = "input.plot_type9!='ideogram'",
		                                                                ADVANCED_OPTIONS_PANEL_9(
		                                                                  list(
		                                                                    checkboxInput("color_opt9", HTML("<font color='red'>Color</font>"), FALSE), 
		                                                                    conditionalPanel(condition = "input.color_opt9",
		                                                                                     conditionalPanel(condition="input.plot_type9 == 'point' | input.plot_type9 == 'line' | input.plot_type9 == 'bar' | input.plot_type9 == 'segment'",
		                                                                                                      selectInput("col_type9", h5("Data color",
		                                                                                                                                  bsButton("bsb260", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "One custom color" = "2", "Custom for data with multi-group" = "3"), selected="1"), 
		                                                                                                      bsPopover("bsb260", 
		                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.col_type9=='2'",
		                                                                                                                       fluidRow(column(12, jscolorInput("color_cus9", label = NULL, value = "#FF0000"))),
		                                                                                                                       br()
		                                                                                                      ), 
		                                                                                                      conditionalPanel(condition = "input.col_type9=='3'",
		                                                                                                                       textInput("color_mulgp9", NULL, value="a:red;b:blue;c:cyan")
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type9=='rect_discrete'",
		                                                                                                      selectInput("rect_col9", h5("Data color", 
		                                                                                                                                  bsButton("bsb261", label="", icon=icon("question"), style="info", size="small")), 
		                                                                                                                  c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"), 
		                                                                                                      bsPopover("bsb261", 
		                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.rect_col9=='2'",
		                                                                                                                       fluidRow(column(12, jscolorInput("rect_col_dis9", label = NULL, value = "#FF0000"))),
		                                                                                                                       br()
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition = "input.rect_col9=='3'",
		                                                                                                                       textInput("rect_col_dis_cus9", NULL, value = "a:red;b:blue;c:cyan"))
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type9=='rect_gradual'",
		                                                                                                      selectInput("rect_grad_col9", h5("Colors", 
		                                                                                                                                       bsButton("bsb262", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb262", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.rect_grad_col9=='1'",
		                                                                                                                       selectInput("col_rect9", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
		                                                                                                                                                                  "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
		                                                                                                                                                                  "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
		                                                                                                                                                                  "navy.cyan", "blue.red", "green.red"))
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition = "input.rect_grad_col9=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("rect_lowColor9", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("rect_midColor9", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("rect_highColor9", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                                                                       br()
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type9=='heatmap_gradual'",
		                                                                                                      selectInput("sel_heatmap_col9", h5("Colors", 
		                                                                                                                                         bsButton("bsb263", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb263", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col9=='1'",
		                                                                                                                       selectInput("hmap_col9", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
		                                                                                                                                                                  "purple.yellow.red", "blue.green.red", "blue.yellow.green",
		                                                                                                                                                                  "cyan.white.deeppink1"), selected="blue.white.red")
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition="input.sel_heatmap_col9=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("lowColor9", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("midColor9", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("highColor9", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                                                                       br()
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type9=='heatmap_discrete'",
		                                                                                                      selectInput("hmap_col_dis9", h5("Data color", 
		                                                                                                                                      bsButton("bsb264", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb264", 
		                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.hmap_col_dis9=='2'",
		                                                                                                                       textInput("hmap_col_dis_cus9", NULL, value="a:red;b:blue;c:cyan")
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type9=='vertical_line' | input.plot_type9=='horizontal_line'",
		                                                                                                      fluidRow(column(12, jscolorInput("line_color9", label = h5('Line color:', 
		                                                                                                                                                                 bsButton("bsb265", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), value = "#FF0000"))),
		                                                                                                      bsPopover("bsb265", 'The color to be used to plot the data.', trigger = "focus"),
		                                                                                                      br()
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type9=='line'",
		                                                                                                      selectInput("fill_area9", h5("Fill area", 
		                                                                                                                                   bsButton("bsb266", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                                      bsPopover("bsb266", "Fill the area below the lines.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.fill_area9=='1'",
		                                                                                                                       radioButtons("sel_area_type9", h5("Area color", 
		                                                                                                                                                         bsButton("bsb267", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Identical with lines" = "1", "Specific" = "2"), selected = "1"),
		                                                                                                                       bsPopover("bsb267", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.sel_area_type9=='2'",
		                                                                                                                                        fluidRow(column(12, jscolorInput("border_area9", label = NULL, value = "#0000FF"))),
		                                                                                                                                        br()
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type9=='point' | input.plot_type9=='line' | input.plot_type9=='bar' | input.plot_type9=='rect_gradual' | input.plot_type9=='rect_discrete' | input.plot_type9=='heatmap_gradual' | input.plot_type9=='heatmap_discrete' | input.plot_type9=='vertical_line' | input.plot_type9=='horizontal_line' | input.plot_type9=='text' | input.plot_type9 == 'segment'",
		                                                                                                      conditionalPanel(condition="input.plot_type9=='text'", 
		                                                                                                                       fluidRow(column(12, jscolorInput("text_col9", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
		                                                                                                                       br()
		                                                                                                      ),			                
		                                                                                                      selectInput("col_lgd9", h5("Color legend",
		                                                                                                                                 bsButton("bsb268", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb268", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.col_lgd9=='1'",
		                                                                                                                       textInput("col_lgd_name9", h5("Legend title:", 
		                                                                                                                                                     bsButton("bsb269", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), value = "color"),
		                                                                                                                       bsPopover("bsb269", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       
		                                                                                                                       conditionalPanel(condition = "input.plot_type9!='rect_gradual' & input.plot_type9!='heatmap_gradual'",
		                                                                                                                                        selectInput("col_lgd_mdy_label9", h5("Modify legend labels", 
		                                                                                                                                                                             bsButton("bsb270", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                                        bsPopover("bsb270", 
		                                                                                                                                                  'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', 
		                                                                                                                                                  trigger = "focus"),
		                                                                                                                                        conditionalPanel(condition = "input.col_lgd_mdy_label9=='1'",
		                                                                                                                                                         textInput("col_lgd_label9", NULL, value="a,b,c")
		                                                                                                                                        )
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type9!='rect_gradual' & input.plot_type9!='heatmap_gradual' & input.plot_type9!='text' & input.plot_type9!='ideogram'",
		                                                                                                      sliderInput("col_transpt9", h5("Color transparency:", 
		                                                                                                                                     bsButton("bsb271", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), min = 0, max = 1, value = 1, step =
		                                                                                                        0.1),
		                                                                                                      bsPopover("bsb271", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")										  
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type9=='line' | input.plot_type9=='vertical_line' | input.plot_type9=='horizontal_line' | input.plot_type9 == 'segment'",
		                                                                                     checkboxInput("linetype_opt9", HTML("<font color='red'>Linetype</font>"), FALSE),  
		                                                                                     conditionalPanel(condition = "input.linetype_opt9",
		                                                                                                      sliderInput("line_size9", "Line width:", min=0, max=3, value=0.2, step=0.05),
		                                                                                                      selectInput("linetype9", h5("Line type",
		                                                                                                                                  bsButton("bsb272", label="", icon=icon("question"), style="info", size="small")), 
		                                                                                                                  choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"), 
		                                                                                                      bsPopover("bsb272", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.plot_type9=='vertical_line' | input.plot_type9=='horizontal_line'",
		                                                                                                                       selectInput("line_type_lgd9", h5("Line type legend", 
		                                                                                                                                                        bsButton("bsb273", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                                       bsPopover("bsb273", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.line_type_lgd9=='1'",
		                                                                                                                                        textInput("line_type_lgd_name9", h5("Legend title:", bsButton("bsb274", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), value = "linetype"),
		                                                                                                                                        bsPopover("bsb274", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                                        selectInput("line_type_lgd_mdy_label9",
		                                                                                                                                                    h5("Modify legend labels",
		                                                                                                                                                       bsButton("bsb275", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                                    ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                                        bsPopover("bsb275", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
		                                                                                                                                        conditionalPanel(condition = "input.line_type_lgd_mdy_label9=='1'",
		                                                                                                                                                         textInput("line_type_lgd_label9", NULL, value="a")
		                                                                                                                                        )
		                                                                                                                       )
		                                                                                                      ), 
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.plot_type9 == 'segment'",
		                                                                                                                       selectInput("add_arrow9", h5("Add arrow head", 
		                                                                                                                                                    bsButton("bsb276", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                                                       bsPopover("bsb276", "Add arrow head for the segment.", trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.add_arrow9 == '1'",
		                                                                                                                                        selectInput("arrow_pos9", h5("Arrow position", 
		                                                                                                                                                                     bsButton("bsb277", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), c("Line end" = "1", "Line beginning" = "2"), selected = "1"),
		                                                                                                                                        bsPopover("bsb277", 'The position of arrow head.',trigger = "focus"),
		                                                                                                                                        sliderInput("arrow_size9", h5("Arrow size:",
		                                                                                                                                                                      bsButton("bsb278", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), min = 0, max = 2, value = 0.1, step = 0.01),
		                                                                                                                                        bsPopover("bsb278", 'The size of arrow head.',trigger = "focus")								
		                                                                                                                       )
		                                                                                                      )
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type9=='point'",
		                                                                                     checkboxInput("symbol_opt9", HTML("<font color='red'>Symbol</font>"), FALSE), 
		                                                                                     conditionalPanel(condition = "input.symbol_opt9",
		                                                                                                      selectInput("sel_symbol_point9", h5("Symbol type", 
		                                                                                                                                          bsButton("bsb279", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("One custom symbol" = "1",
		                                                                                                           'Custom for data with a "shape" column' = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb279", 
		                                                                                                                'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.sel_symbol_point9=='1'",
		                                                                                                                       sliderInput("symbol_point9", NULL, min=0, max=25, value=16, step=1)
		                                                                                                      ),
		                                                                                                      selectInput("shape_lgd9", h5("Symbol legend", 
		                                                                                                                                   bsButton("bsb280", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb280", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.shape_lgd9=='1'",
		                                                                                                                       textInput("shape_lgd_name9", h5("Legend title:", 
		                                                                                                                                                       bsButton("bsb281", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), value = "symbol"),
		                                                                                                                       bsPopover("bsb281", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       selectInput("shape_lgd_mdy_label9",
		                                                                                                                                   h5("Modify legend labels",
		                                                                                                                                      bsButton("bsb282", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                   ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                       bsPopover("bsb282", 
		                                                                                                                                 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', 
		                                                                                                                                 trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.shape_lgd_mdy_label9=='1'",
		                                                                                                                                        textInput("shape_lgd_label9", NULL, value="a,b,c")
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     checkboxInput("size_opt9", HTML("<font color='red'>Size</font>"), FALSE),
		                                                                                     conditionalPanel(condition="input.size_opt9",  				
		                                                                                                      selectInput("sel_point_size9", h5("Point size",
		                                                                                                                                        bsButton("bsb283", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("One custom size" = "1",
		                                                                                                           'Custom for data with a "size" column' = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb283", 
		                                                                                                                'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.sel_point_size9=='1'",
		                                                                                                                       sliderInput("point_size9", NULL, min=0, max=5, value=0.8, step=0.1)
		                                                                                                      ),
		                                                                                                      selectInput("size_lgd9", h5("Size legend", 
		                                                                                                                                  bsButton("bsb284", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb284", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.size_lgd9=='1'",
		                                                                                                                       textInput("size_lgd_name9", h5("Legend title:", 
		                                                                                                                                                      bsButton("bsb285", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), value = "size"),
		                                                                                                                       bsPopover("bsb285", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       selectInput("size_lgd_mdy_label9",
		                                                                                                                                   h5("Modify legend labels",
		                                                                                                                                      bsButton("bsb286", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                   ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                       bsPopover("bsb286", 
		                                                                                                                                 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', 
		                                                                                                                                 trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.size_lgd_mdy_label9=='1'",
		                                                                                                                                        textInput("size_lgd_label9", NULL, value="a,b,c")
		                                                                                                                       )
		                                                                                                      )
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type9=='heatmap_gradual' | input.plot_type9=='heatmap_discrete' | input.plot_type9=='rect_gradual' | input.plot_type9=='rect_discrete' | input.plot_type9=='bar'",
		                                                                                     selectInput("add_border9", h5("Add cell borders", 
		                                                                                                                   bsButton("bsb287", label="", icon=icon("question"), style="info", size="small")
		                                                                                     ), c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                     bsPopover("bsb287", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
		                                                                                     conditionalPanel(condition = "input.add_border9=='1'",
		                                                                                                      fluidRow(column(12, jscolorInput("border_col9", label = h5('Borders color:'), value = "#000000"))),
		                                                                                                      br()
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type9=='line' | input.plot_type9=='point' | input.plot_type9=='bar'",
		                                                                                     selectInput("ylabel9", h5("Y axis label", 
		                                                                                                               bsButton("bsb289", label="", icon=icon("question"), style="info", size="small")
		                                                                                     ), choices = c("Show" = "1", "Hide" = "2"), selected = "1"),
		                                                                                     bsPopover("bsb289", "Add tick labels on the Y-axis.", trigger = "focus")								
		                                                                    ),
		                                                                    
		                                                                    conditionalPanel(condition="input.plot_type9=='text'",
		                                                                                     checkboxInput("font_opt9", HTML("<font color='red'>Font</font>"), FALSE),
		                                                                                     conditionalPanel(condition="input.font_opt9", 
		                                                                                                      sliderInput("text_size9", "Font size:", min=0, max=10, value=2, step=0.1), 
		                                                                                                      selectInput("font_face9", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"), 
		                                                                                                      sliderInput("text_angle9", "Font angle:", min=0, max=360, value=60, step=1)				
		                                                                                     )
		                                                                    )
		                                                                  )
		                                                                )
		                                               )
		                              )
		             ), 
		             
		             checkboxInput("data10", HTML("<font color='red'>Data10</font>"), FALSE),
		             conditionalPanel(condition="input.data10",
		                              radioButtons("sel_upload_data10", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		                              conditionalPanel(condition="input.sel_upload_data10 == '2'",
		                                               fileInput("uploaddata10", h5("Upload data10:",
		                                                                            bsButton("bsb290", label="", icon=icon("question"), style="info", size="small")
		                                               ), multiple = FALSE),
		                                               bsPopover("bsb290", 'Click "Browse" to upload the track data.', trigger = "focus"),
		                                               actionButton("tabBut11", "View example data"),
		                                               tags$script('$( "#uploaddata10" ).on( "click", function() { this.value = null; });'),
		                                               downloadButton("example_data10.txt", "Example data"),
		                                               br(),
		                                               br(),
		                                               selectInput("layer_index10", h5("Track index:", 
		                                                                               bsButton("bsb291", label="", icon=icon("question"), style="info", size="small")), 
		                                                           choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"), 
		                                               bsPopover("bsb291", 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.', trigger = "focus"), 
		                                               selectInput("plot_type10", "Plot type:", 
		                                                           choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical_line", "horizontal_line", "ideogram"), selected="point"),
		                                               
		                                               conditionalPanel(condition = "input.plot_type10!='ideogram'",
		                                                                ADVANCED_OPTIONS_PANEL_10(
		                                                                  list(
		                                                                    checkboxInput("color_opt10", HTML("<font color='red'>Color</font>"), FALSE), 
		                                                                    conditionalPanel(condition = "input.color_opt10",
		                                                                                     conditionalPanel(condition="input.plot_type10 == 'point' | input.plot_type10 == 'line' | input.plot_type10 == 'bar' | input.plot_type10 == 'segment'",
		                                                                                                      selectInput("col_type10", h5("Data color",
		                                                                                                                                   bsButton("bsb292", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "One custom color" = "2",
		                                                                                                           "Custom for data with multi-group" = "3"), selected="1"), 
		                                                                                                      bsPopover("bsb292", 
		                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.col_type10=='2'",
		                                                                                                                       fluidRow(column(12, jscolorInput("color_cus10", label = NULL, value = "#FF0000"))),
		                                                                                                                       br()
		                                                                                                      ), 
		                                                                                                      conditionalPanel(condition = "input.col_type10=='3'",
		                                                                                                                       textInput("color_mulgp10", NULL, value="a:red;b:blue;c:cyan")
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type10=='rect_discrete'",
		                                                                                                      selectInput("rect_col10", h5("Data color", 
		                                                                                                                                   bsButton("bsb293", label="", icon=icon("question"), style="info", size="small")), 
		                                                                                                                  c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"), 
		                                                                                                      bsPopover("bsb293", 
		                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.rect_col10=='2'",
		                                                                                                                       fluidRow(column(12, jscolorInput("rect_col_dis10", label = NULL, value = "#FF0000"))),
		                                                                                                                       br()
		                                                                                                      ), 
		                                                                                                      conditionalPanel(condition = "input.rect_col10=='3'",
		                                                                                                                       textInput("rect_col_dis_cus10", NULL, value="a:red;b:blue;c:cyan")
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type10=='rect_gradual'",
		                                                                                                      selectInput("rect_grad_col10", h5("Colors", 
		                                                                                                                                        bsButton("bsb294", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb294", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.rect_grad_col10=='1'",
		                                                                                                                       selectInput("col_rect10", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
		                                                                                                                                                                   "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
		                                                                                                                                                                   "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
		                                                                                                                                                                   "navy.cyan", "blue.red", "green.red"))
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition = "input.rect_grad_col10=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("rect_lowColor10", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("rect_midColor10", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("rect_highColor10", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                                                                       br()
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type10=='heatmap_gradual'",
		                                                                                                      selectInput("sel_heatmap_col10", h5("Colors", 
		                                                                                                                                          bsButton("bsb295", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Typical" = "1", "Custom" = "2"), selected =
		                                                                                                        "1"),
		                                                                                                      bsPopover("bsb295", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.sel_heatmap_col10=='1'",
		                                                                                                                       selectInput("hmap_col10", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
		                                                                                                                                                                   "purple.yellow.red", "blue.green.red", "blue.yellow.green",
		                                                                                                                                                                   "cyan.white.deeppink1"), selected="blue.white.red")
		                                                                                                      ),
		                                                                                                      conditionalPanel(condition="input.sel_heatmap_col10=='2'",
		                                                                                                                       fluidRow(
		                                                                                                                         column(4, jscolorInput("lowColor10", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                                                                         column(4, jscolorInput("midColor10", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                                                                         column(4, jscolorInput("highColor10", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                                                                       br()
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type10=='heatmap_discrete'",
		                                                                                                      selectInput("hmap_col_dis10", h5("Data color", 
		                                                                                                                                       bsButton("bsb296", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("Random" = "1", "Custom" = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb296", 
		                                                                                                                'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.hmap_col_dis10=='2'",
		                                                                                                                       textInput("hmap_col_dis_cus10", NULL, value="a:red;b:blue;c:cyan")
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type10=='vertical_line' | input.plot_type10=='horizontal_line'",
		                                                                                                      fluidRow(column(12, jscolorInput("line_color10", label = h5('Line color:', 
		                                                                                                                                                                  bsButton("bsb297", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), value = "#FF0000"))),
		                                                                                                      bsPopover("bsb297", 'The color to be used to plot the data.', trigger = "focus"),
		                                                                                                      br()
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type10=='line'",
		                                                                                                      selectInput("fill_area10", h5("Fill area", 
		                                                                                                                                    bsButton("bsb298", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                                      bsPopover("bsb298", "Fill the area below the lines.", trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.fill_area10=='1'",
		                                                                                                                       radioButtons("sel_area_type10", h5("Area color", 
		                                                                                                                                                          bsButton("bsb299", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Identical with lines" = "1", "Specific" = "2"), selected = "1"),
		                                                                                                                       bsPopover("bsb299", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.sel_area_type10=='2'",
		                                                                                                                                        fluidRow(column(12, jscolorInput("border_area10", label = NULL, value = "#0000FF"))),
		                                                                                                                                        br()
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type10=='point' | input.plot_type10=='line' | input.plot_type10=='bar' | input.plot_type10=='rect_gradual' | input.plot_type10=='rect_discrete' | input.plot_type10=='heatmap_gradual' | input.plot_type10=='heatmap_discrete' | input.plot_type10=='vertical_line' | input.plot_type10=='horizontal_line' | input.plot_type10=='text' | input.plot_type10 == 'segment'",
		                                                                                                      conditionalPanel(condition="input.plot_type10=='text'", 
		                                                                                                                       fluidRow(column(12, jscolorInput("text_col10", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
		                                                                                                                       br()
		                                                                                                      ),			                
		                                                                                                      selectInput("col_lgd10", h5("Color legend",
		                                                                                                                                  bsButton("bsb300", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb300", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.col_lgd10=='1'",
		                                                                                                                       textInput("col_lgd_name10", h5("Legend title:", 
		                                                                                                                                                      bsButton("bsb301", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), value = "color"),
		                                                                                                                       bsPopover("bsb301", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       
		                                                                                                                       conditionalPanel(condition = "input.plot_type10!='rect_gradual' & input.plot_type10!='heatmap_gradual'",
		                                                                                                                                        selectInput("col_lgd_mdy_label10", h5("Modify legend labels", 
		                                                                                                                                                                              bsButton("bsb302", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                                        bsPopover("bsb302", 
		                                                                                                                                                  'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', 
		                                                                                                                                                  trigger = "focus"),
		                                                                                                                                        conditionalPanel(condition = "input.col_lgd_mdy_label10=='1'",
		                                                                                                                                                         textInput("col_lgd_label10", NULL, value="a,b,c")
		                                                                                                                                        )
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ), 
		                                                                                     
		                                                                                     conditionalPanel(condition = "input.plot_type10!='rect_gradual' & input.plot_type10!='heatmap_gradual' & input.plot_type10!='text' & input.plot_type10!='ideogram'",
		                                                                                                      sliderInput("col_transpt10", h5("Color transparency:", 
		                                                                                                                                      bsButton("bsb303", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), min = 0, max = 1, value = 1, step = 0.1),
		                                                                                                      bsPopover("bsb303", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")										  
		                                                                                     )
		                                                                    ),    
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type10=='line' | input.plot_type10=='vertical_line' | input.plot_type10=='horizontal_line' | input.plot_type10 == 'segment'",
		                                                                                     checkboxInput("linetype_opt10", HTML("<font color='red'>Linetype</font>"), FALSE),  
		                                                                                     conditionalPanel(condition = "input.linetype_opt10",
		                                                                                                      sliderInput("line_size10", "Line width:", min=0, max=3, value=0.2, step=0.05),
		                                                                                                      selectInput("linetype10", h5("Line type",
		                                                                                                                                   bsButton("bsb304", label="", icon=icon("question"), style="info", size="small")), 
		                                                                                                                  choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"), 
		                                                                                                      bsPopover("bsb304", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.plot_type10=='vertical_line' | input.plot_type10=='horizontal_line'",
		                                                                                                                       selectInput("line_type_lgd10", h5("Line type legend", 
		                                                                                                                                                         bsButton("bsb305", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                                       bsPopover("bsb305", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
		                                                                                                                       
		                                                                                                                       conditionalPanel(condition = "input.line_type_lgd10=='1'",
		                                                                                                                                        textInput("line_type_lgd_name10", h5("Legend title:", 
		                                                                                                                                                                             bsButton("bsb306", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), value = "linetype"),
		                                                                                                                                        bsPopover("bsb306", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                                        selectInput("line_type_lgd_mdy_label10",
		                                                                                                                                                    h5("Modify legend labels",
		                                                                                                                                                       bsButton("bsb307", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                                    ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                                        bsPopover("bsb307", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
		                                                                                                                                        conditionalPanel(condition = "input.line_type_lgd_mdy_label10=='1'",
		                                                                                                                                                         textInput("line_type_lgd_label10", NULL, value="a")
		                                                                                                                                        )
		                                                                                                                       )
		                                                                                                      ), 
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.plot_type10 == 'segment'",
		                                                                                                                       selectInput("add_arrow10", h5("Add arrow head", 
		                                                                                                                                                     bsButton("bsb308", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                                                       bsPopover("bsb308", "Add arrow head for the segment.", trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.add_arrow10 == '1'",
		                                                                                                                                        selectInput("arrow_pos10", h5("Arrow position", 
		                                                                                                                                                                      bsButton("bsb309", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), c("Line end" = "1", "Line beginning" = "2"), selected = "1"),
		                                                                                                                                        bsPopover("bsb309", 'The position of arrow head.',trigger = "focus"),
		                                                                                                                                        sliderInput("arrow_size10", h5("Arrow size:",
		                                                                                                                                                                       bsButton("bsb310", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                        ), min = 0, max = 2, value = 0.1, step = 0.01),
		                                                                                                                                        bsPopover("bsb310", 'The size of arrow head.',trigger = "focus")								
		                                                                                                                       )
		                                                                                                      )
		                                                                                     )
		                                                                    ),
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type10=='point'",
		                                                                                     checkboxInput("symbol_opt10", HTML("<font color='red'>Symbol</font>"), FALSE), 
		                                                                                     conditionalPanel(condition = "input.symbol_opt10",
		                                                                                                      selectInput("sel_symbol_point10", h5("Symbol type", 
		                                                                                                                                           bsButton("bsb311", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("One custom symbol" = "1", 'Custom for data with a "shape" column' = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb311", 
		                                                                                                                'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.sel_symbol_point10=='1'",
		                                                                                                                       sliderInput("symbol_point10", NULL, min=0, max=25, value=16, step=1)
		                                                                                                      ),
		                                                                                                      selectInput("shape_lgd10", h5("Symbol legend", 
		                                                                                                                                    bsButton("bsb312", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb312", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.shape_lgd10=='1'",
		                                                                                                                       textInput("shape_lgd_name10", h5("Legend title:", 
		                                                                                                                                                        bsButton("bsb313", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), value = "symbol"),
		                                                                                                                       bsPopover("bsb313", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       selectInput("shape_lgd_mdy_label10",
		                                                                                                                                   h5("Modify legend labels",
		                                                                                                                                      bsButton("bsb314", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                   ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                       bsPopover("bsb314", 
		                                                                                                                                 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', 
		                                                                                                                                 trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.shape_lgd_mdy_label10=='1'",
		                                                                                                                                        textInput("shape_lgd_label10", NULL, value="a,b,c")
		                                                                                                                       )
		                                                                                                      )
		                                                                                     ), 
		                                                                                     checkboxInput("size_opt10", HTML("<font color='red'>Size</font>"), FALSE),
		                                                                                     conditionalPanel(condition="input.size_opt10",  				
		                                                                                                      selectInput("sel_point_size10", h5("Point size",
		                                                                                                                                         bsButton("bsb315", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected = "1"),
		                                                                                                      bsPopover("bsb315", 
		                                                                                                                'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', 
		                                                                                                                trigger = "focus"),
		                                                                                                      conditionalPanel(condition = "input.sel_point_size10=='1'",
		                                                                                                                       sliderInput("point_size10", NULL, min=0, max=5, value=0.8, step=0.1)
		                                                                                                      ),
		                                                                                                      selectInput("size_lgd10", h5("Size legend", 
		                                                                                                                                   bsButton("bsb316", label="", icon=icon("question"), style="info", size="small")
		                                                                                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		                                                                                                      bsPopover("bsb316", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
		                                                                                                      
		                                                                                                      conditionalPanel(condition = "input.size_lgd10=='1'",
		                                                                                                                       textInput("size_lgd_name10", h5("Legend title:", 
		                                                                                                                                                       bsButton("bsb317", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                       ), value = "size"),
		                                                                                                                       bsPopover("bsb317", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                                                                       selectInput("size_lgd_mdy_label10",
		                                                                                                                                   h5("Modify legend labels",
		                                                                                                                                      bsButton("bsb318", label="", icon=icon("question"), style="info", size="small")
		                                                                                                                                   ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                                                                       bsPopover("bsb318", 
		                                                                                                                                 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', 
		                                                                                                                                 trigger = "focus"),
		                                                                                                                       conditionalPanel(condition = "input.size_lgd_mdy_label10=='1'",
		                                                                                                                                        textInput("size_lgd_label10", NULL, value="a,b,c")
		                                                                                                                       )
		                                                                                                      )
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type10=='heatmap_gradual' | input.plot_type10=='heatmap_discrete' | input.plot_type10=='rect_gradual' | input.plot_type10=='rect_discrete' | input.plot_type10=='bar'",
		                                                                                     selectInput("add_border10", h5("Add cell borders", 
		                                                                                                                    bsButton("bsb319", label="", icon=icon("question"), style="info", size="small")
		                                                                                     ), c("Yes" = "1", "No" = "2"), selected = "2"),
		                                                                                     bsPopover("bsb319", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
		                                                                                     conditionalPanel(condition = "input.add_border10=='1'",
		                                                                                                      fluidRow(column(12, jscolorInput("border_col10", label = h5('Borders color:'), value = "#000000"))),
		                                                                                                      br()
		                                                                                     )
		                                                                    ), 
		                                                                    
		                                                                    conditionalPanel(condition = "input.plot_type10=='line' | input.plot_type10=='point' | input.plot_type10=='bar'",
		                                                                                     selectInput("ylabel10", h5("Y axis label", 
		                                                                                                                bsButton("bsb321", label="", icon=icon("question"), style="info", size="small")
		                                                                                     ), choices = c("Show" = "1", "Hide" = "2"), selected = "1"),
		                                                                                     bsPopover("bsb321", "Add tick labels on the Y-axis.", trigger = "focus")								
		                                                                    ),
		                                                                    
		                                                                    conditionalPanel(condition="input.plot_type10=='text'",
		                                                                                     checkboxInput("font_opt10", HTML("<font color='red'>Font</font>"), FALSE),
		                                                                                     conditionalPanel(condition="input.font_opt10", 
		                                                                                                      sliderInput("text_size10", "Font size:", min=0, max=10, value=2, step=0.1), 
		                                                                                                      selectInput("font_face10", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"), 
		                                                                                                      sliderInput("text_angle10", "Font angle:", min=0, max=360, value=60, step=1)				
		                                                                                     )
		                                                                    )
		                                                                  )
		                                                                )
		                                               )
		                              )
		             ),
		             
		             br(),
		             actionButton("submit1", strong("Go!",
		                                            bsButton("bsb322", label="", icon=icon("question"), style="info", size="small")
		             )), 
		             
		             conditionalPanel(condition="input.submit1 != '0'", busyIndicator(HTML("<div style='color:red;font-size:30px'>Calculation In progress...</div>"), wait = 0)), 
		             bsPopover("bsb322", 'Please click the "Go!" button, if suitable data is uploaded or any options are modified.', trigger = "focus"),
		             br(),
		             
		             h4("Plot options"),
		             ADVANCED_OPTIONS_PANEL(
		               list(
		                 checkboxInput("plotSize", "Adjust plot size", FALSE),
		                 conditionalPanel(condition = "input.plotSize",
		                                  numericInput("Height", "Plot height:", value = 550),
		                                  numericInput("Width", "Plot width:", value = 750)
		                 ),
		                 checkboxInput("plotheme", "Figure theme", FALSE),
		                 conditionalPanel(condition = "input.plotheme",
		                                  selectInput("theme_sty", NULL, choices = c("theme1", "theme2", "theme3",
		                                                                             "theme4", "theme5", "theme6", "theme7",
		                                                                             "theme8","theme9","theme10","theme11",
		                                                                             "theme12", "theme13", "theme14", "theme15",
		                                                                             "theme16","theme17","theme18"), selected="theme1")
		                 ),
		                 
		                 checkboxInput("selfontsize", "Font size", FALSE),
		                 conditionalPanel(condition = "input.selfontsize",
		                                  sliderInput("font_size", NULL, min=0, max=50, value=16, step=0.5)        
		                 ),
		                 
		                 checkboxInput("addtitle", "Axis title", FALSE),
		                 conditionalPanel(
		                   condition = "input.addtitle",
		                   textInput("xtitle", "X axis title:", value = "Genomic position"),
		                   textInput("ytitle", "Y axis title:", value = "Value"), 
		                   selectInput("title_font_face", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain")
		                 ),
		                 
		                 checkboxInput("addlabels", "X axis label", FALSE),
		                 conditionalPanel(condition = "input.addlabels",
		                                  selectInput("xlabel", NULL, choices = c("Show" = "1", "Hide" = "2"), selected="1")
		                 ),
		                 
		                 checkboxInput("legends", "Legend", FALSE),
		                 conditionalPanel(condition = "input.legends",
		                                  selectInput("lgd_pos", h5("Legend position",
		                                                            bsButton("bsb326", label="", icon=icon("question"), style="info", size="small")
		                                  ), c("Right" = "1", "Bottom" = "2"), selected = "1"),
		                                  bsPopover("bsb326", "The position to place the legend.", trigger = "focus"),
		                                  sliderInput("lgd_space_size", h5("Legend region size", 
		                                                                   bsButton("bsb327", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 1, value = 0.04, step = 0.01), 
		                                  bsPopover("bsb327", "Percent of legend size relative to the main plotting region. Applicable values are numbers in [0-1].", trigger = "focus"),
		                                  sliderInput("lgd_intra_size", h5("Intra-spacing",
		                                                                   bsButton("bsb328", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 150, value = 15, step = 0.5), 
		                                  bsPopover("bsb328", "Intra-spacing between different legends.", trigger = "focus"), 
		                                  sliderInput("lgd_title_size", h5("Title font size",
		                                                                   bsButton("bsb329", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 40, value = 12, step = 0.1), 
		                                  bsPopover("bsb329", "The font size of legend title.", trigger = "focus"),
		                                  selectInput("lgd_title_font_face", h5("Title font face:",
		                                                                        bsButton("bsb330", label="", icon=icon("question"), style="info", size="small")
		                                  ), choices = c("plain", "italic", "bold", "bold.italic"), selected = "plain"), 
		                                  bsPopover("bsb330", "The font face of legend title.", trigger = "focus"),
		                                  sliderInput("lgd_text_size", h5("Label font size",
		                                                                  bsButton("bsb331", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 40, value = 10, step = 0.1), 
		                                  bsPopover("bsb331", "The font size of legend tick label.", trigger = "focus"),
		                                  selectInput("lgd_text_font_face", h5("Label font face:",
		                                                                       bsButton("bsb332", label="", icon=icon("question"), style="info", size="small")
		                                  ), choices = c("plain", "italic", "bold", "bold.italic"), selected = "plain"), 
		                                  bsPopover("bsb332", "The font face of legend tick label.", trigger = "focus")
		                 ),
		                 
		                 checkboxInput("layer1", HTML("<font color='red'>Track1</font>"), FALSE),
		                 conditionalPanel(condition="input.layer1",
		                                  sliderInput("height_layer1", h5("Track height:",
		                                                                  bsButton("bsb333", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.06, step = 0.01), 
		                                  bsPopover("bsb333", "Height of the track.", trigger = "focus"),
		                                  sliderInput("margin_layer1", h5("Track margin:", 
		                                                                  bsButton("bsb334", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.01, step = 0.005), 
		                                  bsPopover("bsb334", "Margin size of the track.", trigger = "focus")	
		                 ), 
		                 
		                 checkboxInput("layer2", HTML("<font color='red'>Track2</font>"), FALSE),
		                 conditionalPanel(condition="input.layer2",
		                                  sliderInput("height_layer2", h5("Track height:",
		                                                                  bsButton("bsb335", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.06, step = 0.01), 
		                                  bsPopover("bsb335", "Height of the track.", trigger = "focus"),
		                                  sliderInput("margin_layer2", h5("Track margin:",
		                                                                  bsButton("bsb336", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.01, step = 0.005), 
		                                  bsPopover("bsb336", "Margin size of the track.", trigger = "focus")
		                 ), 
		                 
		                 checkboxInput("layer3", HTML("<font color='red'>Track3</font>"), FALSE),
		                 conditionalPanel(condition="input.layer3",
		                                  sliderInput("height_layer3", h5("Track height:",
		                                                                  bsButton("bsb337", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.06, step = 0.01), 
		                                  bsPopover("bsb337", "Height of the track.", trigger = "focus"),
		                                  sliderInput("margin_layer3", h5("Track margin:",
		                                                                  bsButton("bsb338", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.01, step = 0.005), 
		                                  bsPopover("bsb338", "Margin size of the track.", trigger = "focus")
		                 ),
		                 
		                 checkboxInput("layer4", HTML("<font color='red'>Track4</font>"), FALSE),
		                 conditionalPanel(condition = "input.layer4",
		                                  sliderInput("height_layer4", h5("Track height:", 
		                                                                  bsButton("bsb339", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.06, step = 0.01),
		                                  bsPopover("bsb339", "Height of the track.", trigger = "focus"),
		                                  sliderInput("margin_layer4", h5("Track margin:",
		                                                                  bsButton("bsb340", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.01, step = 0.005),
		                                  bsPopover("bsb340", "Margin size of the track.", trigger = "focus")
		                 ),
		                 
		                 checkboxInput("layer5", HTML("<font color='red'>Track5</font>"), FALSE),
		                 conditionalPanel(condition = "input.layer5",
		                                  sliderInput("height_layer5", h5("Track height:", 
		                                                                  bsButton("bsb341", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.06, step = 0.01), 
		                                  bsPopover("bsb341", "Height of the track.", trigger = "focus"),
		                                  sliderInput("margin_layer5", h5("Track margin:",
		                                                                  bsButton("bsb342", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.01, step = 0.005), 
		                                  bsPopover("bsb342", "Margin size of the track.", trigger = "focus")
		                 ),
		                 
		                 checkboxInput("layer6", HTML("<font color='red'>Track6</font>"), FALSE),
		                 conditionalPanel(condition="input.layer6",
		                                  sliderInput("height_layer6", h5("Track height:",
		                                                                  bsButton("bsb343", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.06, step = 0.01),
		                                  bsPopover("bsb343", "Height of the track.", trigger = "focus"),
		                                  sliderInput("margin_layer6", h5("Track margin:",
		                                                                  bsButton("bsb344", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.01, step = 0.005),
		                                  bsPopover("bsb344", "Margin size of the track.", trigger = "focus")
		                 ),
		                 
		                 checkboxInput("layer7", HTML("<font color='red'>Track7</font>"), FALSE),
		                 conditionalPanel(condition = "input.layer7",
		                                  sliderInput("height_layer7", h5("Track height:",
		                                                                  bsButton("bsb345", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.06, step = 0.01),
		                                  bsPopover("bsb345", "Height of the track.", trigger = "focus"),
		                                  sliderInput("margin_layer7", h5("Track margin:",
		                                                                  bsButton("bsb346", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.01, step = 0.005),
		                                  bsPopover("bsb346", "Margin size of the track.", trigger = "focus")
		                 ),
		                 
		                 checkboxInput("layer8", HTML("<font color='red'>Track8</font>"), FALSE),
		                 conditionalPanel(condition = "input.layer8",
		                                  sliderInput("height_layer8", h5("Track height:", 
		                                                                  bsButton("bsb347", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.06, step = 0.01),
		                                  bsPopover("bsb347", "Height of the track.", trigger = "focus"),
		                                  sliderInput("margin_layer8", h5("Track margin:", 
		                                                                  bsButton("bsb348", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.01, step = 0.005),
		                                  bsPopover("bsb348", "Margin size of the track.", trigger = "focus")
		                 ),
		                 
		                 checkboxInput("layer9", HTML("<font color='red'>Track9</font>"), FALSE),
		                 conditionalPanel(condition = "input.layer9",
		                                  sliderInput("height_layer9", h5("Track height:",
		                                                                  bsButton("bsb349", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.06, step = 0.01),
		                                  bsPopover("bsb349", "Height of the track.", trigger = "focus"),
		                                  sliderInput("margin_layer9", h5("Track margin:",
		                                                                  bsButton("bsb350", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.01, step = 0.005),
		                                  bsPopover("bsb350", "Margin size of the track.", trigger = "focus")
		                 ),
		                 
		                 checkboxInput("layer10", HTML("<font color='red'>Track10</font>"), FALSE),
		                 conditionalPanel(condition = "input.layer10",
		                                  sliderInput("height_layer10", h5("Track height:",
		                                                                   bsButton("bsb351", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.06, step = 0.01),
		                                  bsPopover("bsb351", "Height of the track.", trigger = "focus"),
		                                  sliderInput("margin_layer10", h5("Track margin:",
		                                                                   bsButton("bsb352", label="", icon=icon("question"), style="info", size="small")
		                                  ), min = 0, max = 5, value = 0.01, step = 0.005),
		                                  bsPopover("bsb352", "Margin size of the track.", trigger = "focus")
		                 )
		               )
		             )
		),
		
		mainPanel(id = "mainPanel_1",
		          fluidRow(
		            column(2, uiOutput("downloadpdf1")), 
		            column(2, uiOutput("downloadsvg1")), 
		            column(2, uiOutput("downloadscript1"))
		          ),
		          
		          br(),
		          br(),
		          
		          textOutput("errorinfo1"),
		          textOutput("errorinfo2"),
		          textOutput("errorinfo3"),
		          textOutput("errorinfo4"),
		          textOutput("errorinfo7"),
		          
		          plotOutput("figure_1", height = '100%', width = '100%'), 
		      
		          bsModal("Example1", "Data Table", "tabBut1", size = "large",
		                  dataTableOutput("Table1")),
		      
		          bsModal("Example2", "Data Table", "tabBut2", size = "large",
		                  dataTableOutput("Table2")),
		      
		          bsModal("Example3", "Data Table", "tabBut3", size = "large",
		                  dataTableOutput("Table3")),
		      
		          bsModal("Example4", "Data Table", "tabBut4", size = "large",
		                  dataTableOutput("Table4")),
		      
		          bsModal("Example5", "Data Table", "tabBut5", size = "large",
		                  dataTableOutput("Table5")),
		      
		          bsModal("Example6", "Data Table", "tabBut6", size = "large",
		                  dataTableOutput("Table6")),
		      
		          bsModal("Example7", "Data Table", "tabBut7", size = "large",
		                  dataTableOutput("Table7")),
		      
		          bsModal("Example8", "Data Table", "tabBut8", size = "large",
		                  dataTableOutput("Table8")),
		      
		          bsModal("Example9", "Data Table", "tabBut9", size = "large",
		                  dataTableOutput("Table9")),
		      
		          bsModal("Example10", "Data Table", "tabBut10", size = "large",
		                  dataTableOutput("Table10")),
		      
		          bsModal("Example11", "Data Table", "tabBut11", size = "large",
		                  dataTableOutput("Table11"))
		)
	  ), 
		
		tabPanel(
		  "Two genomes plot", tags$head(
		    tags$style("
          input[type='file'] {width:5em;}
          .toggleButton {width:100%}
          .clearButton {float:right; font-size:12px;}
          .fa-angle-down:before, .fa-angle-up:before {float:right;}
          .popover{text-align:left;width:500px;background-color:#000000;}
          .popover-title{color:#FFFFFF;font-size:16px;background-color:#000000;border-color:#000000;}

          #sidebarPanel_2 {width:25em;}
          #tc_lowColor, #tc_midColor, #tc_highColor, #tc_color_cus, #tc_border_col, #tc_vertical_col, #tc_horizontal_col {width:100%}
          #mainPanel_2 {left:28em; position:absolute; min-width:27em;}"),
		    
		    tags$style(HTML(".shiny-output-error-validation {color: red;}")),
		    tags$script(HTML('Shiny.addCustomMessageHandler("jsCode",function(message) {eval(message.value);});')), includeScript("www/google-analytics.js")				
		  ),
		  sidebarPanel(id = "sidebarPanel_2",
		               fileInput("tc_upload_chr_data_1",
		                         h5("*Upload genome1 data:",
		                            bsButton("bsb353", label="", icon=icon("question"), style="info", size="small")
		                         ), multiple = FALSE),
		               bsPopover("bsb353", 'Click "Browse" to upload the genome data aligned along the X-axis.', trigger = "focus"),
		               
		               actionButton("tabBut12", "View example data"),
		               tags$script('$( "#tc_upload_chr_data_1" ).on( "click", function() { this.value = null; });'),
		               downloadButton("genome1_data.txt", "Example data"),
		               
		               br(),
		               br(),
		               
		               fileInput("tc_upload_chr_data_2",
		                         h5("*Upload genome2 data:",
		                            bsButton("bsb354", label="", icon=icon("question"), style="info", size="small")
		                         ), multiple = FALSE),
		               bsPopover("bsb354", 'Click "Browse" to upload the genome data aligned along the Y-axis.', trigger = "focus"),
		               actionButton("tabBut13", "View example data"),
		               tags$script('$( "#tc_upload_chr_data_2" ).on( "click", function() { this.value = null; });'),
		               downloadButton("genome2_data.txt", "Example data"),
		               
		               br(),
		               br(),
		               
		               fileInput("tc_uploaddata",
		                         h5("*Upload main plot data:",
		                            bsButton("bsb355", label="", icon=icon("question"), style="info", size="small")
		                         ), multiple = FALSE),
		               bsPopover("bsb355", 'Click "Browse" to upload data for the main plot.', trigger = "focus"),
		               actionButton("tabBut14", "View example data"),
		               tags$script('$( "#tc_uploaddata" ).on( "click", function() { this.value = null; });'),
		               downloadButton("example_plot_data.txt", "Example data"),
		               
		               br(),
		               br(), 
		               
		               selectInput("tc_plot_type", "Plot type:", 
		                           choices = c("point_gradual", "point_discrete", "segment" , "rect_gradual", "rect_discrete"), selected="point_gradual"),
		               ADVANCED_OPTIONS_PANEL_tc(
		                 list(
		                   checkboxInput("color_opt_tc", HTML("<font color='red'>Color</font>"), FALSE),
		                   conditionalPanel(condition = "input.color_opt_tc",
		                                    conditionalPanel(condition = "input.tc_plot_type=='point_gradual' | input.tc_plot_type=='rect_gradual'",
		                                                     selectInput("tc_sel_gral_col", h5("Colors",
		                                                                                       bsButton("bsb356", label="", icon=icon("question"), style="info", size="small")
		                                                     ), c("Typical" = "1", "Custom" = "2"), selected = "1"),
		                                                     bsPopover("bsb356", "Colors to be used to plot the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
		                                                     
		                                                     conditionalPanel(condition = "input.tc_sel_gral_col=='1'",
		                                                                      selectInput("tc_gral_col", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
		                                                                                                                   "purple.yellow.red", "blue.green.red", "blue.yellow.green",
		                                                                                                                   "cyan.white.deeppink1"), selected="blue.white.red")
		                                                     ),
		                                                     
		                                                     conditionalPanel(condition="input.tc_sel_gral_col=='2'",
		                                                                      fluidRow(
		                                                                        column(4, jscolorInput("tc_lowColor", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")), 
		                                                                        column(4, jscolorInput("tc_midColor", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")), 
		                                                                        column(4, jscolorInput("tc_highColor", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
		                                                                      br()
		                                                     )
		                                    ), 
		                                    
		                                    conditionalPanel(condition = "input.tc_plot_type=='point_discrete' | input.tc_plot_type=='segment' | input.tc_plot_type=='rect_discrete'",
		                                                     selectInput("tc_col_type", h5("Data color",
		                                                                                   bsButton("bsb357", label="", icon=icon("question"), style="info", size="small")
		                                                     ), c("Random" = "1", "One custom color" = "2",
		                                                          "Custom for data with multi-group" = "3"), selected = "1"),
		                                                     bsPopover("bsb357", 
		                                                               'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', 
		                                                               trigger = "focus"),
		                                                     conditionalPanel(condition = "input.tc_col_type=='2'",
		                                                                      fluidRow(column(12, jscolorInput("tc_color_cus", label = NULL, value = "#FF0000"))),
		                                                                      br()
		                                                     ),
		                                                     conditionalPanel(condition="input.tc_col_type=='3'",
		                                                                      textInput("tc_color_mulgp", NULL, value = "a:red;b:blue;c:cyan")
		                                                     )
		                                    ),
		                                    
		                                    selectInput("tc_col_lgd", h5("Color legend",
		                                                                 bsButton("bsb358", label="", icon=icon("question"), style="info", size="small")
		                                    ), choices = c("Yes" = "1", "No" = "2"), "2"),
		                                    bsPopover("bsb358", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
		                                    
		                                    conditionalPanel(condition = "input.tc_col_lgd=='1'",
		                                                     textInput("tc_col_lgd_name", h5("Legend title:",
		                                                                                     bsButton("bsb359", label="", icon=icon("question"), style="info", size="small")
		                                                     ), value = "color"),
		                                                     bsPopover("bsb359", "Title of color legend. Null value will result in an empty title.", trigger = "focus"),
		                                                     conditionalPanel(condition = "input.tc_plot_type=='point_discrete' | input.tc_plot_type=='segment' | input.tc_plot_type=='rect_discrete'",
		                                                                      selectInput("tc_col_lgd_mdy_label", h5("Modify legend labels",
		                                                                                     bsButton("bsb360", label="", icon=icon("question"), style="info", size="small")
		                                                                      ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                      bsPopover("bsb360", 
		                                                                                'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', 
		                                                                                trigger = "focus"),
		                                                                      conditionalPanel(condition = "input.tc_col_lgd_mdy_label=='1'",
		                                                                                       textInput("tc_col_lgd_label", NULL, value="a,b,c")
		                                                                      )
		                                                     )
		                                    ), 
		                                    
		                                    conditionalPanel(condition = "input.tc_plot_type=='point_discrete' | input.tc_plot_type=='segment' | input.tc_plot_type=='rect_discrete'",
		                                                     sliderInput("tc_col_transpt",
		                                                                 h5("Color transparency:",
		                                                                    bsButton("bsb361", label="", icon=icon("question"), style="info", size="small")
		                                                                 ), min = 0, max = 1, value = 1, step = 0.1),
		                                                     bsPopover("bsb361", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")
		                                    )
		                   ),   
		                   
		                   conditionalPanel(condition = "input.tc_plot_type == 'point_gradual' | input.tc_plot_type == 'point_discrete'",
		                                    checkboxInput("symbol_opt_tc", HTML("<font color='red'>Symbol</font>"), FALSE),  
		                                    conditionalPanel(condition = "input.symbol_opt_tc",
		                                                     selectInput("sel_tc_symbol_point_type", h5("Symbol type",
		                                                                                                bsButton("bsb362", label="", icon=icon("question"), style="info", size="small")
		                                                     ), c("One custom symbol" = "1",
		                                                          'Custom for data with a "shape" column' = "2"), selected = "1"),
		                                                     bsPopover("bsb362", 
		                                                               'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', 
		                                                               trigger = "focus"),
		                                                     
		                                                     conditionalPanel(condition = "input.sel_tc_symbol_point_type=='1'",
		                                                                      sliderInput("tc_symbol_point", NULL, min=0, max=25, value=16, step=1)
		                                                     ),
		                                                     selectInput("tc_shape_lgd", h5("Symbol legend",
		                                                                                    bsButton("bsb363", label="", icon=icon("question"), style="info", size="small")
		                                                     ), choices = c("Yes" = "1", "No" = "2"), "2"),
		                                                     bsPopover("bsb363", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
		                                                     
		                                                     conditionalPanel(condition = "input.tc_shape_lgd=='1'",
		                                                                      textInput("tc_shape_lgd_name", h5("Legend title:",
		                                                                                                        bsButton("bsb364", label="", icon=icon("question"), style="info", size="small")
		                                                                      ), value = "symbol"),
		                                                                      bsPopover("bsb364", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                      selectInput("tc_shape_lgd_mdy_label",
		                                                                                  h5("Modify legend labels",
		                                                                                     bsButton("bsb365", label="", icon=icon("question"), style="info", size="small")
		                                                                                  ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                      bsPopover("bsb365", 
		                                                                                'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', 
		                                                                                trigger = "focus"),
		                                                                      conditionalPanel(condition = "input.tc_shape_lgd_mdy_label=='1'",
		                                                                                       textInput("tc_shape_lgd_label", NULL, value = "a,b,c")
		                                                                      )
		                                                     )
		                                    ), 
		                                    
		                                    checkboxInput("size_opt_tc", HTML("<font color='red'>Size</font>"), FALSE),
		                                    conditionalPanel(condition = "input.size_opt_tc",
		                                                     selectInput("sel_tc_point_size_type", h5("Point size",
		                                                                                              bsButton("bsb366", label="", icon=icon("question"), style="info", size="small")
		                                                     ), c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected = "1"),
		                                                     bsPopover("bsb366", 
		                                                               'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', 
		                                                               trigger = "focus"),
		                                                     
		                                                     conditionalPanel(condition = "input.sel_tc_point_size_type=='1'",
		                                                                      sliderInput("tc_point_size", NULL, min=0, max=5, value=0.8, step=0.1)
		                                                     ),
		                                                     selectInput("tc_size_lgd", h5("Size legend",
		                                                                                   bsButton("bsb367", label="", icon=icon("question"), style="info", size="small")
		                                                     ), choices = c("Yes" = "1", "No" = "2"), "2"),
		                                                     bsPopover("bsb367", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
		                                                     
		                                                     conditionalPanel(condition = "input.tc_size_lgd=='1'",
		                                                                      textInput("tc_size_lgd_name", h5("Legend title:",
		                                                                                                       bsButton("bsb368", label="", icon=icon("question"), style="info", size="small")
		                                                                      ), value = "size"),
		                                                                      bsPopover("bsb368", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
		                                                                      selectInput("tc_size_lgd_mdy_label",
		                                                                                  h5("Modify legend labels",
		                                                                                     bsButton("bsb3680", label="", icon=icon("question"), style="info", size="small")
		                                                                                  ), c("Yes" = "1", "No" = "2"), "2"),
		                                                                      bsPopover("bsb3680", 
		                                                                                'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', 
		                                                                                trigger = "focus"),
		                                                                      
		                                                                      conditionalPanel(condition = "input.tc_size_lgd_mdy_label=='1'",
		                                                                                       textInput("tc_size_lgd_label", NULL, value="a,b,c")
		                                                                      )
		                                                     )
		                                    )
		                   ), 
		                   
		                   conditionalPanel(condition = "input.tc_plot_type=='segment'",
		                                    checkboxInput("linetype_opt_tc", HTML("<font color='red'>Linetype</font>"), FALSE),  
		                                    conditionalPanel(condition = "input.linetype_opt_tc",
		                                                     sliderInput("tc_line_size", "Line width:", min=0, max=20, value=0.2, step=0.05),
		                                                     selectInput("tc_line_type", h5("Line type",
		                                                                                    bsButton("bsb369", label="", icon=icon("question"), style="info", size="small")
		                                                     ), choices = c("solid", "dashed", "dotted", "dotdash", "longdash", "twodash"), selected = "solid"),
		                                                     bsPopover("bsb369", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus")
		                                    )
		                   ),
		                   selectInput("tc_vertical", h5("Vertical line",
		                                                 bsButton("bsb370", label="", icon=icon("question"), style="info", size="small")
		                   ), c("Show" = "1", "Hide" = "2"), selected = "2"),
		                   bsPopover("bsb370", "Create a set of vertical lines across the X-axis to separate different chromosomes.", trigger = "focus"),
		                   
		                   conditionalPanel(condition = "input.tc_vertical=='1'",
		                                    fluidRow(column(12, jscolorInput("tc_vertical_col", label = h5('Vertical line color:', 
		                                                                                                   bsButton("bsb371", label="", icon=icon("question"), style="info", size="small")), value = "#000000"))),
		                                    bsPopover("bsb371", "Color of the vertical lines.", trigger = "focus"),
		                                    br(),
		                                    sliderInput("tc_vertical_size",
		                                                h5("Vertical line width:",
		                                                   bsButton("bsb372", label="", icon=icon("question"), style="info", size="small")
		                                                ), min = 0, max = 3, value = 0.2, step = 0.05),
		                                    bsPopover("bsb372", "Line width of the vertical lines", trigger = "focus"),
		                                    selectInput("tc_vertical_type",
		                                                h5("Vertical line type",
		                                                   bsButton("bsb373", label="", icon=icon("question"), style="info", size="small")
		                                                ), choices = c("solid", "dashed", "dotted", "dotdash", "longdash", "twodash"), selected = "solid"),
		                                    bsPopover("bsb373", "Line type of the vertical lines", trigger = "focus")
		                   ),
		                   selectInput("tc_horizontal", h5("Horizontal line",
		                                                   bsButton("bsb374", label="", icon=icon("question"), style="info", size="small")
		                   ), c("Show" = "1", "Hide" = "2"), selected = "2"),
		                   bsPopover("bsb374", "Create a set of horizontal lines across the Y-axis to separate different chromosomes.", trigger = "focus"),
		                   
		                   conditionalPanel(condition = "input.tc_horizontal=='1'",
		                                    fluidRow(column(12, jscolorInput("tc_horizontal_col", label = h5('Horizontal line color:', 
		                                                                                                     bsButton("bsb375", label="", icon=icon("question"), style="info", size="small")
		                                    ), value = "#000000"))),
		                                    bsPopover("bsb375", "Color of the horizontal lines",trigger = "focus"),
		                                    br(),
		                                    
		                                    sliderInput("tc_horizontal_size",
		                                                h5("Horizontal line width:", 
		                                                   bsButton("bsb376", label="", icon=icon("question"), style="info", size="small")
		                                                ), min = 0, max = 3, value = 0.2, step = 0.05), 
		                                    bsPopover("bsb376", "Line width of the horizontal lines",trigger = "focus"),
		                                    
		                                    selectInput("tc_horizontal_type",
		                                                h5("Horizontal line type", 
		                                                   bsButton("bsb377", label="", icon=icon("question"), style="info", size="small")
		                                                ), choices = c("solid", "dashed", "dotted", "dotdash", "longdash", "twodash"), selected = "solid"),
		                                    bsPopover("bsb377", "Line type of the horizontal lines",trigger = "focus")
		                   ),
		                   
		                   conditionalPanel(condition = "input.tc_plot_type=='rect_gradual' | input.tc_plot_type=='rect_discrete'",
		                                    selectInput("tc_add_border", h5("Add cell borders",
		                                                                    bsButton("bsb378", label="", icon=icon("question"), style="info", size="small")
		                                    ), c("Yes" = "1", "No" = "2"), selected = "2"),
		                                    bsPopover("bsb378", "Add borders to the rect grids, which can be used to separate cells from each other.", trigger = "focus"),
		                                    conditionalPanel(condition = "input.tc_add_border=='1'",
		                                                     fluidRow(column(12, jscolorInput("tc_border_col", label = h5('Borders color:'), value = "#000000")))
		                                    )
		                   )
		                 )
		               ),
		               
		               br(),
		               br(), 
		               
		               actionButton("submit2", strong("Go!",
		                                              bsButton("bsb380", label="", icon=icon("question"), style="info", size="small")
		               )),
		               
		               conditionalPanel(condition="input.submit2 != '0'", busyIndicator(HTML("<div style='color:red;font-size:30px'>Calculation In progress...</div>"), wait = 0)), 
		               bsPopover("bsb380", 'Please click the "Go!" button, if suitable data is uploaded or any options are modified.', trigger = "focus"),
		               
		               br(),
		               h4("Plot options"),
		               
		               checkboxInput("tc_plotSize", "Adjust plot size", FALSE),
		               conditionalPanel(condition = "input.tc_plotSize",
		                                numericInput("tc_Height", "Plot height:", value = 650),
		                                numericInput("tc_Width", "Plot width:", value = 750)
		               ),
		               
		               checkboxInput("tc_plotheme", "Figure theme", FALSE),
		               conditionalPanel(condition = "input.tc_plotheme",
		                                selectInput("tc_theme_sty", NULL, choices = c("theme1", "theme2", "theme3",
		                                                                              "theme4", "theme5", "theme6", "theme7",
		                                                                              "theme8","theme9","theme10","theme11",
		                                                                              "theme12", "theme13", "theme14", "theme15",
		                                                                              "theme16","theme17","theme18"), selected="theme1")
		               ),
		               
		               checkboxInput("tc_sel_font_size", "Font size", FALSE),
		               conditionalPanel(condition = "input.tc_sel_font_size", 
		                                sliderInput("tc_font_size", NULL, min=0, max=50, value=16, step=0.5)
		               ),
		               
		               checkboxInput("tc_addtitle", "Axis title", FALSE),
		               conditionalPanel(condition = "input.tc_addtitle",
		                                textInput("tc_xtitle", "X axis title:", value="Genomic position 1"), 
		                                textInput("tc_ytitle", "Y axis title:", value="Genomic position 2"), 
		                                selectInput("tc_title_font_face", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain")
		               ),
		               
		               checkboxInput("tc_addlabels", "Axis label", FALSE),
		               conditionalPanel(condition = "input.tc_addlabels",
		                                selectInput("tc_xlabel", h5("X axis label",
		                                                            bsButton("bsb384", label="", icon=icon("question"), style="info", size="small")
		                                ), choices = c("Show" = "1", "Hide" = "2"), selected = "1"),
		                                bsPopover("bsb384", "Add tick labels on the X-axis.", trigger = "focus"),
		                                selectInput("tc_ylabel", h5("Y axis label",
		                                                            bsButton("bsb385", label="", icon=icon("question"), style="info", size="small")
		                                ), choices = c("Show" = "1", "Hide" = "2"), selected = "1"),
		                                bsPopover("bsb385", "Add tick labels on the Y-axis.", trigger = "focus")
		               ), 
		               
		               checkboxInput("tc_legends", "Legend", FALSE),
		               conditionalPanel(condition = "input.tc_legends",
		                                selectInput("tc_lgd_pos", h5("Legend position",
		                                                             bsButton("bsb386", label="", icon=icon("question"), style="info", size="small")
		                                ), c("Right" = "1", "Bottom" = "2"), selected = "1"), 
		                                bsPopover("bsb386", "The position to place the legend.", trigger = "focus"),
		                                sliderInput("tc_lgd_title_size", h5("Title font size",
		                                                                    bsButton("bsb387", label="", icon=icon("question"), style="info", size="small")
		                                ), min = 0, max = 40, value = 12, step = 0.1),
		                                bsPopover("bsb387", "The font size of legend title.", trigger = "focus"),
		                                selectInput("tc_lgd_title_font_face",
		                                            h5("Title font face:",
		                                               bsButton("bsb388", label="", icon=icon("question"), style="info", size="small")
		                                            ), choices = c("plain", "italic", "bold", "bold.italic"), selected = "plain"),
		                                bsPopover("bsb388", "The font face of legend title.", trigger = "focus"),
		                                sliderInput("tc_lgd_text_size", h5("Label font size",
		                                                                   bsButton("bsb389", label="", icon=icon("question"), style="info", size="small")
		                                ), min = 0, max = 40, value = 10, step = 0.1), 
		                                bsPopover("bsb389", "The font size of legend tick label.", trigger = "focus"),
		                                selectInput("tc_lgd_text_font_face",
		                                            h5("Label font face:",
		                                               bsButton("bsb390", label="", icon=icon("question"), style="info", size="small")
		                                            ), choices = c("plain", "italic", "bold", "bold.italic"), selected = "plain"), 
		                                bsPopover("bsb390", "The font face of legend tick label.", trigger = "focus")				
		               )
		  ),
		  
		  mainPanel(id = "mainPanel_2", 
		            fluidRow(
		              column(3, uiOutput("downloadpdf2")), 
		              column(3, uiOutput("downloadsvg2")), 
		              column(6, uiOutput("downloadscript2"))
		            ),
		            
		            br(), 
		            br(),
		            
		            textOutput("errorinfo5"),
		            textOutput("errorinfo6"),
		            textOutput("errorinfo8"),
		            
		            plotOutput("figure_2", height = '100%', width = '100%'),
		            
		            bsModal("Example12", "Data Table", "tabBut12", size = "large",
		                    dataTableOutput("Table12")),
		       
		            bsModal("Example13", "Data Table", "tabBut13", size = "large",
		                    dataTableOutput("Table13")),
		       
		            bsModal("Example14", "Data Table", "tabBut14", size = "large",
		                    dataTableOutput("Table14"))
		  )
		), 
		
		tabPanel("Gallery", includeHTML("www/gallery.html")),
		
		navbarMenu("Help",
		           tabPanel("Usage and installation", includeMarkdown("README.md")),
		           tabPanel("Input data format", includeMarkdown("In_Data_Format.md")),
		           tabPanel("User manual", uiOutput("pdfview"))
		), 
	
		tabPanel("About", includeMarkdown("About.md"))
		
  )
)

