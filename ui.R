
source("global_ui.R")

shinyUI(
  navbarPage(
    title = "shinyChromosome", theme = shinytheme("flatly"),
    windowTitle = "interactive creation of non-circular whole genome diagram",
    
    tabPanel("About", includeMarkdown("About.md")),
    
    tabPanel("Input data format", includeMarkdown("In_Data_Format.md")),
    
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
				#colorcus1, #colorcus2, #colorcus3, #colorcus4, #colorcus5, #colorcus6, #colorcus7, #colorcus8, #colorcus9, #colorcus10 {width:100%} 
				#textcol1, #textcol2, #textcol3, #textcol4, #textcol5, #textcol6, #textcol7, #textcol8, #textcol9, #textcol10 {width:100%}
                #linecolor1, #linecolor2, #linecolor3, #linecolor4, #linecolor5, #linecolor6, #linecolor7, #linecolor8, #linecolor9, #linecolor10 {width:100%}				
				#rectcoldis1, #rectcoldis2, #rectcoldis3, #rectcoldis4, #rectcoldis5, #rectcoldis6, #rectcoldis7, #rectcoldis8, #rectcoldis9, #rectcoldis10 {width:100%}
				#bordercols1, #bordercols2, #bordercols3, #bordercols4, #bordercols5, #bordercols6, #bordercols7, #bordercols8, #bordercols9, #bordercols10 {width:100%}
				#borderarea1, #borderarea2, #borderarea3, #borderarea4, #borderarea5, #borderarea6, #borderarea7, #borderarea8, #borderarea9, #borderarea10 {width:100%}
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
				#mainPanel_1 {left:28em; position:absolute; min-width:27em;}"),
			 tags$style(HTML(".shiny-output-error-validation {color: red;}")),
       tags$script(HTML('Shiny.addCustomMessageHandler("jsCode",function(message) {eval(message.value);});')),
			 includeScript("www/google-analytics.js")				
		),
		
      sidebarPanel(id="sidebarPanel_1",
    	radioButtons("plotype", h4("*Image type",
    	                           bsButton("bsb1", label="", icon=icon("question"), style="info", size="small")
    	                           ), c("Concatenated chromosomes" = "1", "Separated chromosomes" = "2"), "1"),
    	bsPopover("bsb1", "All chromosomes can either be concatenated or separated.",
    	          trigger = "focus"),
    	
    	radioButtons("plotdirection", h4("*Chromosome orientation",
    	                                 bsButton("bsb2", label="", icon=icon("question"), style="info", size="small")
    	                                 ), c("Horizontally aligned" = "1", "Vertically aligned" = "2"), "1"),
    	bsPopover("bsb2", "Chromosomes could be aligned to the horizontal axis or the vertical axis.",
    	          trigger = "focus"),
    	
	    fileInput("uploadchrdata", h4("*Upload genome data",
	                                  bsButton("bsb3", label="", icon=icon("question"), style="info", size="small")
	                                  ), multiple = FALSE, width = "100%"),
    	bsPopover("bsb3", 'Click "Browse" to upload the genome data, which is compulsory and defines the frame of the non-circular plot.',
    	          trigger = "focus"),
    	
			actionButton("tabBut1", "View example data"),
		  tags$script('$( "#uploadchrdata" ).on( "click", function() { this.value = null; });'),
      downloadButton("genome_data.txt", "Example data"),
	
		br(),
		
		checkboxInput("data1", HTML("<font color='red'>Data1</font>"), FALSE),
		conditionalPanel(condition="input.data1",
		  radioButtons("seluploaddata1", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		  conditionalPanel(condition="input.seluploaddata1 == '2'",
		    fileInput("uploaddata1", h5("Upload data1:",
		                                bsButton("bsb4", label="", icon=icon("question"), style="info", size="small")
		                                ), multiple = FALSE),
		    bsPopover("bsb4", 'Click "Browse" to upload the track data.',
		              trigger = "focus"),
		    
		    actionButton("tabBut2", "View example data"),
			  tags$script('$( "#uploaddata1" ).on( "click", function() { this.value = null; });'),
            downloadButton("example_data1.txt", "Example data"),
	
			br(),
			
			selectInput("layerindex1", h5("Track index:",
			                              bsButton("bsb5", label="", icon=icon("question"), style="info", size="small")
			                              ), choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			bsPopover("bsb5", 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.',
			          trigger = "focus"),
			
			selectInput("plottype1", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),
			
    	ADVANCED_OPTIONS_PANEL_1(
		    list(
		    	checkboxInput("color_opt1", HTML("<font color='red'>Color</font>"), FALSE),  
			    conditionalPanel(condition="input.color_opt1",  
			    conditionalPanel(condition="input.plottype1 == 'point' | input.plottype1 == 'line' | input.plottype1 == 'bar' | input.plottype1 == 'segment'",
				                 selectInput("coltype1", h5("Data color",
			                                    bsButton("bsb6", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
			        bsPopover("bsb6", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups in the uploaded data should be named as "color". Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.',
                    trigger = "focus"),
			        
					conditionalPanel(condition="input.coltype1=='2'",
			            fluidRow(column(12, jscolorInput("colorcus1", label = NULL, value = "#FF0000"))),
                        br()			            
			         ),
                    conditionalPanel(condition="input.coltype1=='3'",
			            textInput("colormulgp1", NULL, value="a:red;b:blue;c:cyan")
	                )
				),
			conditionalPanel(condition="input.plottype1=='rect_discrete'",
			                 selectInput("rectcol1", h5("Data color",
			                                bsButton("bsb7", label="", icon=icon("question"), style="info", size="small")
			                                ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    bsPopover("bsb7", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.',
			              trigger = "focus"),
			conditionalPanel(condition="input.rectcol1=='2'",
			    fluidRow(column(12, jscolorInput("rectcoldis1", label = NULL, value = "#FF0000"))),
                br()
			),
			conditionalPanel(condition="input.rectcol1=='3'",
			    textInput("rectcoldiscus1", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype1=='rect_gradual'",
			                 selectInput("rectgrad_col1", h5("Colors",
			                                     bsButton("bsb8", label="", icon=icon("question"), style="info", size="small")
			                                     ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb8", "Colors to be used for the data, which can be assigned by the application or be specified by the users.",
			              trigger = "focus"),
			    conditionalPanel(condition="input.rectgrad_col1=='1'",
			        selectInput("colrect1", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
			                                               "navy.cyan", "blue.red", "green.red"))
			    ),
			    conditionalPanel(condition="input.rectgrad_col1=='2'",
			        fluidRow(
			            column(4, jscolorInput("rect_lowColor1", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			            column(4, jscolorInput("rect_midColor1", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			            column(4, jscolorInput("rect_highColor1", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			            br()
			    )
			),
			conditionalPanel(condition="input.plottype1=='heatmap_gradual'",
			                 selectInput("heatmapcol1", h5("Colors",
			                                   bsButton("bsb9", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb9", "Colors to be used for the data, which can be assigned by the application or be specified by the users.",
			              trigger = "focus"),
			conditionalPanel(condition="input.heatmapcol1=='1'",
			    selectInput("colhmap1", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
	                                                      "purple.yellow.red", "blue.green.red", "blue.yellow.green",
	                                                      "cyan.white.deeppink1"), selected="blue.white.red")
			),
			conditionalPanel(condition="input.heatmapcol1=='2'",
			    fluidRow(
			        column(4, jscolorInput("lowColor1", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			        column(4, jscolorInput("midColor1", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			        column(4, jscolorInput("highColor1", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			        br()
			)			
			),
			conditionalPanel(condition="input.plottype1=='heatmap_discrete'",
			                 selectInput("colhmapdis1", h5("Data color",
			                                   bsButton("bsb10", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Random" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb10", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.',
			              trigger = "focus"),
			conditionalPanel(condition="input.colhmapdis1=='2'",
			    textInput("colhmapdiscus1", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype1=='vertical line' | input.plottype1=='horizontal line'",
			    fluidRow(column(12, jscolorInput("linecolor1", label = h5("Line color:",
			                                                              bsButton("bsb11", label="", icon=icon("question"), style="info", size="small")
			                                                              ), value = "#FF0000"))),
			    bsPopover("bsb11", 'The color to be used to plot the data.',
			              trigger = "focus"),
                br()
			),
			conditionalPanel(condition="input.plottype1=='line'",
			                 selectInput("fillarea1", h5("Fill area",
			                                 bsButton("bsb12", label="", icon=icon("question"), style="info", size="small")
			                                 ), choices = c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb12", "Fill the area below the lines.", trigger = "focus"),
			
                conditionalPanel(condition="input.fillarea1=='1'",
			    radioButtons("selareatype1", h5("Area color",
			                                    bsButton("bsb13", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			    bsPopover("bsb13", 'Color to be used to fill the area, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
			
				conditionalPanel(condition="input.selareatype1=='2'",
			        fluidRow(column(12, jscolorInput("borderarea1", label = NULL, value = "#0000FF"))),
                    br()			        
			)
			)
			),
			conditionalPanel(condition="input.plottype1=='point' | input.plottype1=='line' | input.plottype1=='bar' | input.plottype1=='rect_gradual' | input.plottype1=='rect_discrete' | input.plottype1=='heatmap_gradual' | input.plottype1=='heatmap_discrete' | input.plottype1=='vertical line' | input.plottype1=='horizontal line' | input.plottype1=='text' | input.plottype1 == 'segment'",
			                conditionalPanel(condition="input.plottype1=='text'",
			                    fluidRow(column(12, jscolorInput("textcol1", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
			                    br()
			                ),			                 
			                selectInput("collgd1", h5("Color legend",
		                                   bsButton("bsb14", label="", icon=icon("question"), style="info", size="small")
		                                   ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb14", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
				
			    conditionalPanel(condition="input.collgd1=='1'",
 				    textInput("collgdname1", h5("Legend title:",
 				                                bsButton("bsb15", label="", icon=icon("question"), style="info", size="small")
 				                                ), value="color"),
 				    bsPopover("bsb15", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
 				    
				    conditionalPanel(condition="input.plottype1!='rect_gradual' & input.plottype1!='heatmap_gradual'",
				                     selectInput("collgdmdylabel1", h5("Modify legend labels",
					                                       bsButton("bsb16", label="", icon=icon("question"), style="info", size="small")
					                                       ), c("Yes" = "1", "No" = "2"), "2"),
					    bsPopover("bsb16", 'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					    
					    conditionalPanel(condition="input.collgdmdylabel1=='1'",
					        textInput("collgdlabel1", NULL, value="a,b,c")
					    )
				    )
                )				
			),
			conditionalPanel(condition="input.plottype1!='rect_gradual' & input.plottype1!='heatmap_gradual' & input.plottype1!='text'",
			    sliderInput("coltransparency1", h5("Color transparency:",
			                                       bsButton("bsb17", label="", icon=icon("question"), style="info", size="small")
			                                       ), min=0, max=1, value=1, step=0.1),
			    bsPopover("bsb17", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")
            )          
            ),
			conditionalPanel(condition="input.plottype1=='line' | input.plottype1=='vertical line' | input.plottype1=='horizontal line' | input.plottype1 == 'segment'",
		    checkboxInput("linetype_opt1", HTML("<font color='red'>Linetype</font>"), FALSE),
			conditionalPanel(condition="input.linetype_opt1",
			sliderInput("linesize1", "Line width:", min=0, max=3, value=0.2, step=0.05),
			selectInput("linetype1", h5("Line type",
			                            bsButton("bsb18", label="", icon=icon("question"), style="info", size="small")
			                            ), choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			bsPopover("bsb18", 'The line type is automatically set as "solid" for line with more than one color.', trigger = "focus"),
			
			conditionalPanel(condition="input.plottype1=='vertical line' | input.plottype1=='horizontal line'",
			                 selectInput("linetypelgd1", h5("Line type legend",
		                                        bsButton("bsb19", label="", icon=icon("question"), style="info", size="small")
		                                        ), c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb19", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
				
			    conditionalPanel(condition="input.linetypelgd1=='1'",
 				    textInput("linetypelgdname1", h5("Legend title:",
 				                                     bsButton("bsb20", label="", icon=icon("question"), style="info", size="small")
 				                                     ), value="linetype"),
 				    bsPopover("bsb20", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
 				    
 				    selectInput("linetypelgdmdylabel1", h5("Modify legend labels",
					                                        bsButton("bsb21", label="", icon=icon("question"), style="info", size="small")
					                                        ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb21", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
					
					conditionalPanel(condition="input.linetypelgdmdylabel1=='1'",
						textInput("linetypelgdlabel1", NULL, value="a")
	                )
				)
			),
			conditionalPanel(condition="input.plottype1 == 'segment'",
			                 selectInput("addarrow1", h5("Add arrow head",
			                                 bsButton("bsb22", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb22", "Add arrow head for the segment.", trigger = "focus"),
				
			conditionalPanel(condition="input.addarrow1 == '1'",
			                 selectInput("arrowpos1", h5("Arrow position",
			                                 bsButton("bsb23", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Line end" = "1", "Line beginning" = "2"),selected="1"),
			    bsPopover("bsb23", 'The position of arrow head.', trigger = "focus"),
				
				sliderInput("arrowsize1", h5("Arrow size:",
				                             bsButton("bsb24", label="", icon=icon("question"), style="info", size="small")
				                             ), min=0, max=2, value=0.1, step=0.01),
				bsPopover("bsb24", 'The size of arrow head.', trigger = "focus")								
            )
			)
			)
			),			
			conditionalPanel(condition="input.plottype1=='point'",
				checkboxInput("symbol_opt1", HTML("<font color='red'>Symbol</font>"), FALSE),  
			    conditionalPanel(condition="input.symbol_opt1",  
			                selectInput("sel_symbolpoint1", h5("Symbol type",
                                                    bsButton("bsb25", label="", icon=icon("question"), style="info", size="small")
                                                    ), c("One custom symbol" = "1", 'Custom for data with a "shape" column' = "2"), selected="1"),
                bsPopover("bsb25", 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', trigger = "focus"),
                
                conditionalPanel(condition="input.sel_symbolpoint1=='1'",
                    sliderInput("symbolpoint1", NULL, min=0, max=25, value=16, step=1)
                ),
                
                selectInput("shapelgd1", h5("Symbol legend",
		                                     bsButton("bsb26", label="", icon=icon("question"), style="info", size="small")
		                                     ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb26", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
				
			    conditionalPanel(condition="input.shapelgd1=='1'",
 				    textInput("shapelgdname1", h5("Legend title:",
 				                                  bsButton("bsb27", label="", icon=icon("question"), style="info", size="small")
 				                                  ), value="symbol"),
 				    bsPopover("bsb27", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
 				    
 				    selectInput("shapelgdmdylabel1", h5("Modify legend labels",
					                                     bsButton("bsb28", label="", icon=icon("question"), style="info", size="small")
					                                     ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb28", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					
					conditionalPanel(condition="input.shapelgdmdylabel1=='1'",
						textInput("shapelgdlabel1", NULL, value="a,b,c")
	                )
				)
				),
				checkboxInput("size_opt1", HTML("<font color='red'>Size</font>"), FALSE),
			    conditionalPanel(condition="input.size_opt1", 				
				selectInput("sel_pointsize1", h5("Point size",
                                                  bsButton("bsb29", label="", icon=icon("question"), style="info", size="small")
                                                  ), c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected="1"),
				bsPopover("bsb29", 'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_pointsize1=='1'",
                    sliderInput("pointsize1", NULL, min=0, max=5, value=0.8, step=0.1)
                ),
				
				selectInput("sizelgd1", h5("Size legend",
		                                    bsButton("bsb30", label="", icon=icon("question"), style="info", size="small")
		                                    ), choices = c("Show" = "1", "Hide" = "2"), "2"),
				bsPopover("bsb30", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
				
			    conditionalPanel(condition="input.sizelgd1=='1'",
 				    textInput("sizelgdname1", h5("Legend title:",
 				                                 bsButton("bsb31", label="", icon=icon("question"), style="info", size="small")
 				                                 ), value="size"),
 				    bsPopover("bsb31", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
 				    
 				    selectInput("sizelgdmdylabel1", h5("Modify legend labels",
				                                        bsButton("bsb32", label="", icon=icon("question"), style="info", size="small")
				                                        ), c("Yes" = "1", "No" = "2"), "2"),
				    bsPopover("bsb32", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
				    
					conditionalPanel(condition="input.sizelgdmdylabel1=='1'",
						    textInput("sizelgdlabel1", NULL, value="a,b,c")
	                )
				)
				)	
            ),
			conditionalPanel(condition="input.plottype1=='heatmap_gradual' | input.plottype1=='heatmap_discrete' | input.plottype1=='rect_gradual' | input.plottype1=='rect_discrete' | input.plottype1=='bar'",
			                 selectInput("addborder1", h5("Add cell borders",
			                                  bsButton("bsb33", label="", icon=icon("question"), style="info", size="small")
			                                  ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb33", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
				
			    conditionalPanel(condition="input.addborder1=='1'",
                    fluidRow(column(12, jscolorInput("bordercols1", label = h5('Borders color:'), value = "#000000"))),
					br()
			    )
            ),
			conditionalPanel(condition="input.plottype1=='line' | input.plottype1=='point' | input.plottype1=='bar'",
			                 selectInput("ylabel1", h5("Y axis label",
	                                       bsButton("bsb35", label="", icon=icon("question"), style="info", size="small")
	                                       ), choices = c("Show" = "1", "Hide" = "2"), selected="1"),
	            bsPopover("bsb35", "Add tick labels on the Y-axis.", trigger = "focus")				
			),
			conditionalPanel(condition="input.plottype1=='text'",
		    	checkboxInput("font_opt1", HTML("<font color='red'>Font</font>"), FALSE),
			    conditionalPanel(condition="input.font_opt1",					
				    sliderInput("textsize1", "Font size:", min=0, max=10, value=2, step=0.1),
			        selectInput("fontface1", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
				    sliderInput("textangle1", "Font angle:", min=0, max=360, value=60, step=1)				
				)
			)
			)
			)
		   )
		),
		checkboxInput("data2", HTML("<font color='red'>Data2</font>"), FALSE),
		conditionalPanel(condition="input.data2",
		  radioButtons("seluploaddata2", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		  conditionalPanel(condition="input.seluploaddata2 == '2'",
		    fileInput("uploaddata2", h5("Upload data2:",
		                                bsButton("bsb36", label="", icon=icon("question"), style="info", size="small")
		                                ), multiple = FALSE),
		    bsPopover("bsb36", 'Click "Browse" to upload the track data.', trigger = "focus"),
			
		    actionButton("tabBut3", "View example data"),
			tags$script('$( "#uploaddata2" ).on( "click", function() { this.value = null; });'),
			downloadButton("example_data2.txt", "Example data"),
            br(),
			br(),
						
			selectInput("layerindex2", h5("Track index:",
			                              bsButton("bsb37", label="", icon=icon("question"), style="info", size="small")
			                              ), choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			bsPopover("bsb37", 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.', trigger = "focus"),
			selectInput("plottype2", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),
			
    	ADVANCED_OPTIONS_PANEL_2(
				list(
		    	checkboxInput("color_opt2", HTML("<font color='red'>Color</font>"), FALSE),  
			    conditionalPanel(condition="input.color_opt2",  					
				conditionalPanel(condition="input.plottype2 == 'point' | input.plottype2 == 'line' | input.plottype2 == 'bar' | input.plottype2 == 'segment'",
				                 selectInput("coltype2", h5("Data color",
			                                    bsButton("bsb38", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
			        bsPopover("bsb38", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', trigger = "focus"),
					conditionalPanel(condition="input.coltype2=='2'",
			            fluidRow(column(12, jscolorInput("colorcus2", label = NULL, value = "#FF0000"))),
                        br()			            						
			         ),
                    conditionalPanel(condition="input.coltype2=='3'",
			            textInput("colormulgp2", NULL, value="a:red;b:blue;c:cyan")
	                )
				),
			conditionalPanel(condition="input.plottype2=='rect_discrete'",
			                 selectInput("rectcol2", h5("Data color",
			                                bsButton("bsb39", label="", icon=icon("question"), style="info", size="small")
			                                ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    bsPopover("bsb39", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.rectcol2=='2'",
			    fluidRow(column(12, jscolorInput("rectcoldis2", label = NULL, value = "#FF0000"))),
                br()
			),
			conditionalPanel(condition="input.rectcol2=='3'",
			    textInput("rectcoldiscus2", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype2=='rect_gradual'",
			                 selectInput("rectgrad_col2", h5("Colors",
			                                     bsButton("bsb40", label="", icon=icon("question"), style="info", size="small")
			                                     ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb40", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			    conditionalPanel(condition="input.rectgrad_col2=='1'",
			        selectInput("colrect2", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
			                                               "navy.cyan", "blue.red", "green.red"))
			    ),
			    conditionalPanel(condition="input.rectgrad_col2=='2'",
			        fluidRow(
			            column(4, jscolorInput("rect_lowColor2", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			            column(4, jscolorInput("rect_midColor2", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			            column(4, jscolorInput("rect_highColor2", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			            br()
			    )
			),
			conditionalPanel(condition="input.plottype2=='heatmap_gradual'",
			                 selectInput("heatmapcol2", h5("Colors",
			                                   bsButton("bsb41", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb41", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			
			conditionalPanel(condition="input.heatmapcol2=='1'",
			    selectInput("colhmap2", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
	                                                      "purple.yellow.red", "blue.green.red", "blue.yellow.green",
	                                                      "cyan.white.deeppink1"), selected="blue.white.red")
			),
			conditionalPanel(condition="input.heatmapcol2=='2'",
			    fluidRow(
			        column(4, jscolorInput("lowColor2", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			        column(4, jscolorInput("midColor2", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			        column(4, jscolorInput("highColor2", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			        br()
			)			
			),
			conditionalPanel(condition="input.plottype2=='heatmap_discrete'",
			                 selectInput("colhmapdis2", h5("Data color",
			                                   bsButton("bsb42", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Random" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb42", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.colhmapdis2=='2'",
			    textInput("colhmapdiscus2", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype2=='vertical line' | input.plottype2=='horizontal line'",
			    fluidRow(column(12, jscolorInput("linecolor2", label = h5('Line color:',
			                                                              bsButton("bsb43", label="", icon=icon("question"), style="info", size="small")
			                                                              ), value = "#FF0000"))),
			    bsPopover("bsb43", 'The color to be used to plot the data. ', trigger = "focus"),
                br()
			),
			conditionalPanel(condition="input.plottype2=='line'",
			                 selectInput("fillarea2", h5("Fill area",
			                                 bsButton("bsb44", label="", icon=icon("question"), style="info", size="small")
			                                 ), choices = c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb44", "Fill the area below the lines.", trigger = "focus"),
			    
                conditionalPanel(condition="input.fillarea2=='1'",
			    radioButtons("selareatype2", h5("Area color",
			                                    bsButton("bsb45", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			    bsPopover("bsb45", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
				
			conditionalPanel(condition="input.selareatype2=='2'",
			        fluidRow(column(12, jscolorInput("borderarea2", label = NULL, value = "#0000FF"))),
                    br()
			)
			)
			),
			conditionalPanel(condition="input.plottype2=='point' | input.plottype2=='line' | input.plottype2=='bar' | input.plottype2=='rect_gradual' | input.plottype2=='rect_discrete' | input.plottype2=='heatmap_gradual' | input.plottype2=='heatmap_discrete' | input.plottype2=='vertical line' | input.plottype2=='horizontal line' | input.plottype2=='text' | input.plottype2 == 'segment'",
			                conditionalPanel(condition="input.plottype2=='text'",
			                    fluidRow(column(12, jscolorInput("textcol2", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
			                    br()
			                ), 
			                selectInput("collgd2", h5("Color legend",
		                                   bsButton("bsb46", label="", icon=icon("question"), style="info", size="small")
		                                   ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb46", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
				
			    conditionalPanel(condition="input.collgd2=='1'",
 				    textInput("collgdname2", h5("Legend title:",
 				                                bsButton("bsb47", label="", icon=icon("question"), style="info", size="small")
 				                                ), value="color"),
 				    bsPopover("bsb47", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
 				    
				    conditionalPanel(condition="input.plottype2!='rect_gradual' & input.plottype2!='heatmap_gradual'",
				                     selectInput("collgdmdylabel2", h5("Modify legend labels",
					                                       bsButton("bsb48", label="", icon=icon("question"), style="info", size="small")
					                                       ), c("Yes" = "1", "No" = "2"), "2"),
					    bsPopover("bsb48", 'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					    
					    conditionalPanel(condition="input.collgdmdylabel2=='1'",
					        textInput("collgdlabel2", NULL, value="a,b,c")
					    )
				    )
                )				
			),
			
			conditionalPanel(condition="input.plottype2!='rect_gradual' & input.plottype2!='heatmap_gradual' & input.plottype2!='text'",
			    sliderInput("coltransparency2", h5("Color transparency:",
			                                       bsButton("bsb49", label="", icon=icon("question"), style="info", size="small")
			                                       ), min=0, max=1, value=1, step=0.1),
			    bsPopover("bsb49", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")
            )           
            ),  
            conditionalPanel(condition="input.plottype2=='line' | input.plottype2=='vertical line' | input.plottype2=='horizontal line' | input.plottype2 == 'segment'",
		    checkboxInput("linetype_opt2", HTML("<font color='red'>Linetype</font>"), FALSE), 
			conditionalPanel(condition="input.linetype_opt2", 
            sliderInput("linesize2", "Line width:", min=0, max=3, value=0.2, step=0.05),
			selectInput("linetype2", h5("Line type",
			                            bsButton("bsb50", label="", icon=icon("question"), style="info", size="small")
			                            ), choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			bsPopover("bsb50", 'The line type is automatically set as "solid" for line with more than one color.', trigger = "focus"),
			
			conditionalPanel(condition="input.plottype2=='vertical line' | input.plottype2=='horizontal line'",
			                 selectInput("linetypelgd2", h5("Line type legend",
		                                        bsButton("bsb51", label="", icon=icon("question"), style="info", size="small")
		                                        ), c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb51", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
				
			    conditionalPanel(condition="input.linetypelgd2=='1'",
 				    textInput("linetypelgdname2", h5("Legend title:",
 				                                     bsButton("bsb52", label="", icon=icon("question"), style="info", size="small")
 				                                     ), value="linetype"),
 				    bsPopover("bsb52", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
 				    
 				    selectInput("linetypelgdmdylabel2", h5("Modify legend labels",
					                                        bsButton("bsb53", label="", icon=icon("question"), style="info", size="small")
					                                        ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb53", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
					conditionalPanel(condition="input.linetypelgdmdylabel2=='1'",
						textInput("linetypelgdlabel2", NULL, value="a")
	                )
				)
			),
			conditionalPanel(condition="input.plottype2 == 'segment'",
			                 selectInput("addarrow2", h5("Add arrow head",
			                                 bsButton("bsb54", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb54", "Add arrow head for the segment.", trigger = "focus"),
			conditionalPanel(condition="input.addarrow2 == '1'",
			                 selectInput("arrowpos2", h5("Arrow position",
			                                 bsButton("bsb55", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Line end" = "1", "Line beginning" = "2"),selected="1"),
			    bsPopover("bsb55", 'The position of arrow head.',trigger = "focus"),
				sliderInput("arrowsize2", h5("Arrow size:",
				                             bsButton("bsb56", label="", icon=icon("question"), style="info", size="small")
				                             ), min=0, max=2, value=0.1, step=0.01),
				bsPopover("bsb56", 'The size of arrow head.',trigger = "focus")								
            )
            )
			)
			),
			conditionalPanel(condition="input.plottype2=='point'",
				checkboxInput("symbol_opt2", HTML("<font color='red'>Symbol</font>"), FALSE),  
			    conditionalPanel(condition="input.symbol_opt2",  				
			                 selectInput("sel_symbolpoint2", h5("Symbol type",
                                                    bsButton("bsb57", label="", icon=icon("question"), style="info", size="small")
                                                    ), c("One custom symbol" = "1", 'Custom for data with a "shape" column' = "2"), selected="1"),
                bsPopover("bsb57", 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_symbolpoint2=='1'",
                    sliderInput("symbolpoint2", NULL, min=0, max=25, value=16, step=1)
                ),
		        
                selectInput("shapelgd2", h5("Symbol legend",
                                             bsButton("bsb58", label="", icon=icon("question"), style="info", size="small")
                                             ), choices = c("Show" = "1", "Hide" = "2"), "2"),
                bsPopover("bsb58", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.shapelgd2=='1'",
 				    textInput("shapelgdname2", h5("Legend title:",
 				                                  bsButton("bsb59", label="", icon=icon("question"), style="info", size="small")
 				                                  ), value="symbol"),
 				    bsPopover("bsb59", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("shapelgdmdylabel2", h5("Modify legend labels",
					                                     bsButton("bsb60", label="", icon=icon("question"), style="info", size="small")
					                                     ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb60", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					conditionalPanel(condition="input.shapelgdmdylabel2=='1'",
						textInput("shapelgdlabel2", NULL, value="a,b,c")
	                )
	            )
				),
				checkboxInput("size_opt2", HTML("<font color='red'>Size</font>"), FALSE),  
			    conditionalPanel(condition="input.size_opt2",  				
				selectInput("sel_pointsize2", h5("Point size",
                                                  bsButton("bsb61", label="", icon=icon("question"), style="info", size="small")
                                                  ), c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected="1"),
				bsPopover("bsb61", 'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_pointsize2=='1'",
                    sliderInput("pointsize2", NULL, min=0, max=5, value=0.8, step=0.1)
                ),
				selectInput("sizelgd2", h5("Size legend",
		                                    bsButton("bsb62", label="", icon=icon("question"), style="info", size="small")
		                                    ), choices = c("Show" = "1", "Hide" = "2"), "2"),
				bsPopover("bsb62", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.sizelgd2=='1'",
 				    textInput("sizelgdname2", h5("Legend title:",
 				                                 bsButton("bsb63", label="", icon=icon("question"), style="info", size="small")
 				                                 ), value="size"),
 				    bsPopover("bsb63", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
 				    
 				    selectInput("sizelgdmdylabel2", h5("Modify legend labels",
				                                        bsButton("bsb64", label="", icon=icon("question"), style="info", size="small")
				                                        ), c("Yes" = "1", "No" = "2"), "2"),
				    bsPopover("bsb64", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					conditionalPanel(condition="input.sizelgdmdylabel2=='1'",
						    textInput("sizelgdlabel2", NULL, value="a,b,c")
	                )
				)
				)				
            ),
			conditionalPanel(condition="input.plottype2=='heatmap_gradual' | input.plottype2=='heatmap_discrete' | input.plottype2=='rect_gradual' | input.plottype2=='rect_discrete' | input.plottype2=='bar'",
			                 selectInput("addborder2", h5("Add cell borders",
			                                  bsButton("bsb65", label="", icon=icon("question"), style="info", size="small")
			                                  ), c("Yes" = "1", "No" = "2"), selected="2"),
			    bsPopover("bsb65", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
			    conditionalPanel(condition="input.addborder2=='1'",
                    fluidRow(column(12, jscolorInput("bordercols2", label = h5('Borders color:'), value = "#000000"))),
                    br()
					)
            ),
			conditionalPanel(condition="input.plottype2=='line' | input.plottype2=='point' | input.plottype2=='bar'",
			                 selectInput("ylabel2", h5("Y axis label",
	                                       bsButton("bsb67", label="", icon=icon("question"), style="info", size="small")
	                                       ), choices = c("Show" = "1", "Hide" = "2"), selected="1"),
	            bsPopover("bsb67", "Add tick labels on the Y-axis.", trigger = "focus")								
			),
			conditionalPanel(condition="input.plottype2=='text'",
		    	checkboxInput("font_opt2", HTML("<font color='red'>Font</font>"), FALSE),
			    conditionalPanel(condition="input.font_opt2",					
				    sliderInput("textsize2", "Font size:", min=0, max=10, value=2, step=0.1),
			        selectInput("fontface2", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
				    sliderInput("textangle2", "Font angle:", min=0, max=360, value=60, step=1)				
				)
			)
			)
			)
		   )
		),
		checkboxInput("data3", HTML("<font color='red'>Data3</font>"), FALSE),
		conditionalPanel(condition="input.data3",
		  radioButtons("seluploaddata3", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		  conditionalPanel(condition="input.seluploaddata3 == '2'",
		    fileInput("uploaddata3", h5("Upload data3:",
		                                bsButton("bsb68", label="", icon=icon("question"), style="info", size="small")
		                                ), multiple = FALSE),
		    bsPopover("bsb68", 'Click "Browse" to upload the track data.', trigger = "focus"),
			
		    actionButton("tabBut4", "View example data"),
			tags$script('$( "#uploaddata3" ).on( "click", function() { this.value = null; });'),
            downloadButton("example_data3.txt", "Example data"),
            br(),
			br(),
			selectInput("layerindex3", h5("Track index:",
			                              bsButton("bsb69", label="", icon=icon("question"), style="info", size="small")
			                              ), choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			bsPopover("bsb69", 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.', trigger = "focus"),
			selectInput("plottype3", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),
    	ADVANCED_OPTIONS_PANEL_3(
				list(
		    	checkboxInput("color_opt3", HTML("<font color='red'>Color</font>"), FALSE),  
			    conditionalPanel(condition="input.color_opt3",  					
				conditionalPanel(condition="input.plottype3 == 'point' | input.plottype3 == 'line' | input.plottype3 == 'bar' | input.plottype3 == 'segment'",
				                 selectInput("coltype3", h5("Data color",
			                                    bsButton("bsb70", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
			        bsPopover("bsb70", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', trigger = "focus"),
					conditionalPanel(condition="input.coltype3=='2'",
			            fluidRow(column(12, jscolorInput("colorcus3", label = NULL, value = "#FF0000"))),
                        br()			            			            
			         ),
                    conditionalPanel(condition="input.coltype3=='3'",
			            textInput("colormulgp3", NULL, value="a:red;b:blue;c:cyan")
	                )
				),
			conditionalPanel(condition="input.plottype3=='rect_discrete'",
			                 selectInput("rectcol3", h5("Data color",
			                                bsButton("bsb71", label="", icon=icon("question"), style="info", size="small")
			                                ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    bsPopover("bsb71", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.rectcol3=='2'",
			    fluidRow(column(12, jscolorInput("rectcoldis3", label = NULL, value = "#FF0000"))),
                br()
			),
			conditionalPanel(condition="input.rectcol3=='3'",
			    textInput("rectcoldiscus3", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype3=='rect_gradual'",
			                 selectInput("rectgrad_col3", h5("Colors",
			                                     bsButton("bsb72", label="", icon=icon("question"), style="info", size="small")
			                                     ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb72", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			    conditionalPanel(condition="input.rectgrad_col3=='1'",
			        selectInput("colrect3", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
			                                               "navy.cyan", "blue.red", "green.red"))
			    ),
			    conditionalPanel(condition="input.rectgrad_col3=='2'",
			        fluidRow(
			            column(4, jscolorInput("rect_lowColor3", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			            column(4, jscolorInput("rect_midColor3", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			            column(4, jscolorInput("rect_highColor3", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			            br()
			    )
			),
			conditionalPanel(condition="input.plottype3=='heatmap_gradual'",
			                 selectInput("heatmapcol3", h5("Colors",
			                                   bsButton("bsb73", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb73", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			conditionalPanel(condition="input.heatmapcol3=='1'",
			    selectInput("colhmap3", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
	                                                      "purple.yellow.red", "blue.green.red", "blue.yellow.green",
	                                                      "cyan.white.deeppink1"), selected="blue.white.red")
			),
			conditionalPanel(condition="input.heatmapcol3=='2'",
			    fluidRow(
			        column(4, jscolorInput("lowColor3", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			        column(4, jscolorInput("midColor3", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			        column(4, jscolorInput("highColor3", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			        br()
			)			
			),
			conditionalPanel(condition="input.plottype3=='heatmap_discrete'",
			                 selectInput("colhmapdis3", h5("Data color",
			                                   bsButton("bsb74", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Random" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb74", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.colhmapdis3=='2'",
			    textInput("colhmapdiscus3", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype3=='vertical line' | input.plottype3=='horizontal line'",
			    fluidRow(column(12, jscolorInput("linecolor3", label = h5('Line color:',
			                                                              bsButton("bsb75", label="", icon=icon("question"), style="info", size="small")
			                                                              ), value = "#FF0000"))),
			    bsPopover("bsb75", 'The color to be used to plot the data. ', trigger = "focus"),
                br()
			),
			conditionalPanel(condition="input.plottype3=='line'",
			                 selectInput("fillarea3", h5("Fill area",
			                                 bsButton("bsb76", label="", icon=icon("question"), style="info", size="small")
			                                 ), choices = c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb76", "Fill the area below the lines.", trigger = "focus"),
                conditionalPanel(condition="input.fillarea3=='1'",
			    radioButtons("selareatype3", h5("Area color",
			                                    bsButton("bsb77", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			    bsPopover("bsb77", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
				conditionalPanel(condition="input.selareatype3=='2'",
			        fluidRow(column(12, jscolorInput("borderarea3", label = NULL, value = "#0000FF"))),
                    br()
			)
		    )			
			),
			conditionalPanel(condition="input.plottype3=='point' | input.plottype3=='line' | input.plottype3=='bar' | input.plottype3=='rect_gradual' | input.plottype3=='rect_discrete' | input.plottype3=='heatmap_gradual' | input.plottype3=='heatmap_discrete' | input.plottype3=='vertical line' | input.plottype3=='horizontal line' | input.plottype3=='text' | input.plottype3 == 'segment'",
			                conditionalPanel(condition="input.plottype3=='text'",
			                    fluidRow(column(12, jscolorInput("textcol3", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
			                    br()
			                ),
			                selectInput("collgd3", h5("Color legend",
		                                   bsButton("bsb78", label="", icon=icon("question"), style="info", size="small")
		                                   ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb78", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
				
			    conditionalPanel(condition="input.collgd3=='1'",
 				    textInput("collgdname3", h5("Legend title:",
 				                                bsButton("bsb79", label="", icon=icon("question"), style="info", size="small")
 				                                ), value="color"),
 				    bsPopover("bsb79", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
 				    
				    conditionalPanel(condition="input.plottype3!='rect_gradual' & input.plottype3!='heatmap_gradual'",
				                     selectInput("collgdmdylabel3", h5("Modify legend labels",
					                                       bsButton("bsb80", label="", icon=icon("question"), style="info", size="small")
					                                       ), c("Yes" = "1", "No" = "2"), "2"),
					    bsPopover("bsb80", 'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					    conditionalPanel(condition="input.collgdmdylabel3=='1'",
					        textInput("collgdlabel3", NULL, value="a,b,c")
					    )
				    )
                )				
			),
			conditionalPanel(condition="input.plottype3!='rect_gradual' & input.plottype3!='heatmap_gradual' & input.plottype3!='text'",
			    sliderInput("coltransparency3", h5("Color transparency:",
			                                       bsButton("bsb81", label="", icon=icon("question"), style="info", size="small")
			                                       ), min=0, max=1, value=1, step=0.1),
			    bsPopover("bsb81", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")										  
            )          
            ), 
			conditionalPanel(condition="input.plottype3=='line' | input.plottype3=='vertical line' | input.plottype3=='horizontal line' | input.plottype3 == 'segment'",
		    checkboxInput("linetype_opt3", HTML("<font color='red'>Linetype</font>"), FALSE), 
			conditionalPanel(condition="input.linetype_opt3",                        
            sliderInput("linesize3", "Line width:", min=0, max=3, value=0.2, step=0.05),
			selectInput("linetype3", h5("Line type",
			                            bsButton("bsb82", label="", icon=icon("question"), style="info", size="small")
			                            ), choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			bsPopover("bsb82", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus"),
			
			conditionalPanel(condition="input.plottype3=='vertical line' | input.plottype3=='horizontal line'",
			                 selectInput("linetypelgd3", h5("Line type legend",
		                                        bsButton("bsb83", label="", icon=icon("question"), style="info", size="small")
		                                        ), c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb83", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
				
			    conditionalPanel(condition="input.linetypelgd3=='1'",
 				    textInput("linetypelgdname3", h5("Legend title:",
 				                                     bsButton("bsb84", label="", icon=icon("question"), style="info", size="small")
 				                                     ), value="linetype"),
 				    bsPopover("bsb84", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
 				    
 				    selectInput("linetypelgdmdylabel3", h5("Modify legend labels",
					                                        bsButton("bsb85", label="", icon=icon("question"), style="info", size="small")
					                                        ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb85", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
					
					conditionalPanel(condition="input.linetypelgdmdylabel3=='1'",
						textInput("linetypelgdlabel3", NULL, value="a")
	                )
				)
			),
			conditionalPanel(condition="input.plottype3 == 'segment'",
			                 selectInput("addarrow3", h5("Add arrow head",
			                                 bsButton("bsb86", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb86", "Add arrow head for the segment.", trigger = "focus"),
				
			conditionalPanel(condition="input.addarrow3 == '1'",
			                 selectInput("arrowpos3", h5("Arrow position",
			                                 bsButton("bsb87", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Line end" = "1", "Line beginning" = "2"),selected="1"),
			    bsPopover("bsb87", 'The position of arrow head.',trigger = "focus"),
				
				sliderInput("arrowsize3", h5("Arrow size:",
				                             bsButton("bsb88", label="", icon=icon("question"), style="info", size="small")
				                             ), min=0, max=2, value=0.1, step=0.01),
				bsPopover("bsb88", 'The size of arrow head.',trigger = "focus")								
            )
			)
			)            
			),
			conditionalPanel(condition="input.plottype3=='point'",
				checkboxInput("symbol_opt3", HTML("<font color='red'>Symbol</font>"), FALSE),  
			    conditionalPanel(condition="input.symbol_opt3",  				
			                 selectInput("sel_symbolpoint3", h5("Symbol type",
                                                    bsButton("bsb89", label="", icon=icon("question"), style="info", size="small")
                                                    ), c("One custom symbol" = "1", 'Custom for data with a "shape" column' = "2"), selected="1"),
                bsPopover("bsb89", 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_symbolpoint3=='1'",
                    sliderInput("symbolpoint3", NULL, min=0, max=25, value=16, step=1)
                ),

                selectInput("shapelgd3", h5("Symbol legend",
		                                     bsButton("bsb90", label="", icon=icon("question"), style="info", size="small")
		                                     ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb90", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),

			    conditionalPanel(condition="input.shapelgd3=='1'",
 				    textInput("shapelgdname3", h5("Legend title:",
 				                                  bsButton("bsb91", label="", icon=icon("question"), style="info", size="small")
 				                                  ), value="symbol"),
 				    bsPopover("bsb91", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
 				    
 				    selectInput("shapelgdmdylabel3", h5("Modify legend labels",
					                                     bsButton("bsb92", label="", icon=icon("question"), style="info", size="small")
					                                     ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb92", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					
					conditionalPanel(condition="input.shapelgdmdylabel3=='1'",
						textInput("shapelgdlabel3", NULL, value="a,b,c")
	                )
				)
				),
				checkboxInput("size_opt3", HTML("<font color='red'>Size</font>"), FALSE),
			    conditionalPanel(condition="input.size_opt3", 				
				selectInput("sel_pointsize3", h5("Point size",
                                                  bsButton("bsb93", label="", icon=icon("question"), style="info", size="small")
                                                  ), c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected="1"),
				bsPopover("bsb93", 'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_pointsize3=='1'",
                    sliderInput("pointsize3", NULL, min=0, max=5, value=0.8, step=0.1)
                ),
				selectInput("sizelgd3", h5("Size legend",
		                                    bsButton("bsb94", label="", icon=icon("question"), style="info", size="small")
		                                    ), choices = c("Show" = "1", "Hide" = "2"), "2"),
				bsPopover("bsb94", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.sizelgd3=='1'",
 				    textInput("sizelgdname3", h5("Legend title:",
 				                                 bsButton("bsb95", label="", icon=icon("question"), style="info", size="small")
 				                                 ), value="size"),
 				    bsPopover("bsb95", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),

 				    selectInput("sizelgdmdylabel3", h5("Modify legend labels",
				                                        bsButton("bsb96", label="", icon=icon("question"), style="info", size="small")
				                                        ), c("Yes" = "1", "No" = "2"), "2"),
				    bsPopover("bsb96", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					conditionalPanel(condition="input.sizelgdmdylabel3=='1'",
						    textInput("sizelgdlabel3", NULL, value="a,b,c")
	                )
				)
				)				
            ),
			conditionalPanel(condition="input.plottype3=='heatmap_gradual' | input.plottype3=='heatmap_discrete' | input.plottype3=='rect_gradual' | input.plottype3=='rect_discrete' | input.plottype3=='bar'",
			                 selectInput("addborder3", h5("Add cell borders",
			                                  bsButton("bsb97", label="", icon=icon("question"), style="info", size="small")
			                                  ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb97", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
			    conditionalPanel(condition="input.addborder3=='1'",
                    fluidRow(column(12, jscolorInput("bordercols3", label = h5('Borders color:'), value = "#000000"))),
                    br()
					)
            ),
			conditionalPanel(condition="input.plottype3=='line' | input.plottype3=='point' | input.plottype3=='bar'",
			                 selectInput("ylabel3", h5("Y axis label",
	                                       bsButton("bsb99", label="", icon=icon("question"), style="info", size="small")
	                                       ), choices = c("Show" = "1", "Hide" = "2"), selected="1"),
	            bsPopover("bsb99", "Add tick labels on the Y-axis.", trigger = "focus")								
			),
			conditionalPanel(condition="input.plottype3=='text'",
		    	checkboxInput("font_opt3", HTML("<font color='red'>Font</font>"), FALSE),
			    conditionalPanel(condition="input.font_opt3",					
				    sliderInput("textsize3", "Font size:", min=0, max=10, value=2, step=0.1),
			        selectInput("fontface3", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
				    sliderInput("textangle3", "Font angle:", min=0, max=360, value=60, step=1)				
				)
			)
			)
			)
		   )
		),
		checkboxInput("data4", HTML("<font color='red'>Data4</font>"), FALSE),
		conditionalPanel(condition="input.data4",
		  radioButtons("seluploaddata4", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		  conditionalPanel(condition="input.seluploaddata4 == '2'",
		    fileInput("uploaddata4", h5("Upload data4:",
		                                bsButton("bsb100", label="", icon=icon("question"), style="info", size="small")
		                                ), multiple = FALSE),
		    bsPopover("bsb100", 'Click "Browse" to upload the track data.', trigger = "focus"),
			
		    actionButton("tabBut5", "View example data"),
			tags$script('$( "#uploaddata4" ).on( "click", function() { this.value = null; });'),
            downloadButton("example_data4.txt", "Example data"),
            br(),
			br(),
			selectInput("layerindex4", h5("Track index:",
			                              bsButton("bsb101", label="", icon=icon("question"), style="info", size="small")
			                              ), choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			bsPopover("bsb101", 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.', trigger = "focus"),
			selectInput("plottype4", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),
    	ADVANCED_OPTIONS_PANEL_4(
				list(
		    	checkboxInput("color_opt4", HTML("<font color='red'>Color</font>"), FALSE),  
			    conditionalPanel(condition="input.color_opt4",  					
				conditionalPanel(condition="input.plottype4 == 'point' | input.plottype4 == 'line' | input.plottype4 == 'bar' | input.plottype4 == 'segment'",
				                 selectInput("coltype4", h5("Data color",
			                                    bsButton("bsb102", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
			        bsPopover("bsb102", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', trigger = "focus"),
					conditionalPanel(condition="input.coltype4=='2'",
			            fluidRow(column(12, jscolorInput("colorcus4", label = NULL, value = "#FF0000"))),
                        br()			            			            
			         ),
                    conditionalPanel(condition="input.coltype4=='3'",
			            textInput("colormulgp4", NULL, value="a:red;b:blue;c:cyan")
	                )
				),
			conditionalPanel(condition="input.plottype4=='rect_discrete'",
			                 selectInput("rectcol4", h5("Data color",
			                                bsButton("bsb103", label="", icon=icon("question"), style="info", size="small")
			                                ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    bsPopover("bsb103", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.rectcol4=='2'",
			    fluidRow(column(12, jscolorInput("rectcoldis4", label = NULL, value = "#FF0000"))),
                br()
			),
			conditionalPanel(condition="input.rectcol4=='3'",
			    textInput("rectcoldiscus4", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype4=='rect_gradual'",
			                 selectInput("rectgrad_col4", h5("Colors",
			                                     bsButton("bsb104", label="", icon=icon("question"), style="info", size="small")
			                                     ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb104", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			    conditionalPanel(condition="input.rectgrad_col4=='1'",
			        selectInput("colrect4", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
			                                               "navy.cyan", "blue.red", "green.red"))
			    ),
			    conditionalPanel(condition="input.rectgrad_col4=='2'",
			        fluidRow(
			            column(4, jscolorInput("rect_lowColor4", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			            column(4, jscolorInput("rect_midColor4", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			            column(4, jscolorInput("rect_highColor4", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			            br()
			    )
			),
			conditionalPanel(condition="input.plottype4=='heatmap_gradual'",
			                 selectInput("heatmapcol4", h5("Colors",
			                                   bsButton("bsb105", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb105", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			conditionalPanel(condition="input.heatmapcol4=='1'",
			    selectInput("colhmap4", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
	                                                      "purple.yellow.red", "blue.green.red", "blue.yellow.green",
	                                                      "cyan.white.deeppink1"), selected="blue.white.red")
			),
			conditionalPanel(condition="input.heatmapcol4=='2'",
			    fluidRow(
			        column(4, jscolorInput("lowColor4", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			        column(4, jscolorInput("midColor4", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			        column(4, jscolorInput("highColor4", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			        br()
			)			
			),
			conditionalPanel(condition="input.plottype4=='heatmap_discrete'",
			                 selectInput("colhmapdis4", h5("Data color",
			                                   bsButton("bsb106", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Random" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb106", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.colhmapdis4=='2'",
			    textInput("colhmapdiscus4", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype4=='vertical line' | input.plottype4=='horizontal line'",
			    fluidRow(column(12, jscolorInput("linecolor4", label = h5('Line color:',
			                                                              bsButton("bsb107", label="", icon=icon("question"), style="info", size="small")
			                                                              ), value = "#FF0000"))),
			    bsPopover("bsb107", 'The color to be used to plot the data.', trigger = "focus"),
                br()
			),
			conditionalPanel(condition="input.plottype4=='line'",
			                 selectInput("fillarea4", h5("Fill area",
			                                 bsButton("bsb108", label="", icon=icon("question"), style="info", size="small")
			                                 ), choices = c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb108", "Fill the area below the lines.", trigger = "focus"),
                conditionalPanel(condition="input.fillarea4=='1'",
			    radioButtons("selareatype4", h5("Area color",
			                                    bsButton("bsb109", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			    bsPopover("bsb109", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
				conditionalPanel(condition="input.selareatype4=='2'",
			        fluidRow(column(12, jscolorInput("borderarea4", label = NULL, value = "#0000FF"))),
                    br()
			)
		    )			
			),
			conditionalPanel(condition="input.plottype4=='point' | input.plottype4=='line' | input.plottype4=='bar' | input.plottype4=='rect_gradual' | input.plottype4=='rect_discrete' | input.plottype4=='heatmap_gradual' | input.plottype4=='heatmap_discrete' | input.plottype4=='vertical line' | input.plottype4=='horizontal line' | input.plottype4=='text' | input.plottype4 == 'segment'",
			                conditionalPanel(condition="input.plottype4=='text'",
			                    fluidRow(column(12, jscolorInput("textcol4", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
			                    br()
			                ),  			                
			                selectInput("collgd4", h5("Color legend",
		                                   bsButton("bsb110", label="", icon=icon("question"), style="info", size="small")
		                                   ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb110", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
				
			    conditionalPanel(condition="input.collgd4=='1'",
 				    textInput("collgdname4", h5("Legend title:",
 				                                bsButton("bsb111", label="", icon=icon("question"), style="info", size="small")
 				                                ), value="color"),
 				    bsPopover("bsb111", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
 				    
				    conditionalPanel(condition="input.plottype4!='rect_gradual' & input.plottype4!='heatmap_gradual'",
				                     selectInput("collgdmdylabel4", h5("Modify legend labels",
					                                       bsButton("bsb112", label="", icon=icon("question"), style="info", size="small")
					                                       ), c("Yes" = "1", "No" = "2"), "2"),
					    bsPopover("bsb112", 'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					    
					    conditionalPanel(condition="input.collgdmdylabel4=='1'",
					        textInput("collgdlabel4", NULL, value="a,b,c")
					    )
				    )
                )				
			),
			conditionalPanel(condition="input.plottype4!='rect_gradual' & input.plottype4!='heatmap_gradual' & input.plottype4!='text'",
			    sliderInput("coltransparency4", h5("Color transparency:",
			                                       bsButton("bsb113", label="", icon=icon("question"), style="info", size="small")
			                                       ), min=0, max=1, value=1, step=0.1),
			    bsPopover("bsb113", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")										  
            )          
            ),       
			conditionalPanel(condition="input.plottype4=='line' | input.plottype4=='vertical line' | input.plottype4=='horizontal line' | input.plottype4 == 'segment'",
		    checkboxInput("linetype_opt4", HTML("<font color='red'>Linetype</font>"), FALSE), 
			conditionalPanel(condition="input.linetype_opt4",                   
            sliderInput("linesize4", "Line width:", min=0, max=3, value=0.2, step=0.05),
			selectInput("linetype4", h5("Line type",
			                            bsButton("bsb114", label="", icon=icon("question"), style="info", size="small")
			                            ), choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			bsPopover("bsb114", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus"),
			conditionalPanel(condition="input.plottype4=='vertical line' | input.plottype4=='horizontal line'",
			                 selectInput("linetypelgd4", h5("Line type legend",
		                                        bsButton("bsb115", label="", icon=icon("question"), style="info", size="small")
		                                        ), c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb115", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.linetypelgd4=='1'",
 				    textInput("linetypelgdname4", h5("Legend title:",
 				                                     bsButton("bsb116", label="", icon=icon("question"), style="info", size="small")
 				                                     ), value="linetype"),
 				    bsPopover("bsb116", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("linetypelgdmdylabel4", h5("Modify legend labels",
					                                        bsButton("bsb117", label="", icon=icon("question"), style="info", size="small")
					                                        ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb117", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
					conditionalPanel(condition="input.linetypelgdmdylabel4=='1'",
						textInput("linetypelgdlabel4", NULL, value="a")
	                )
				)
			),
			conditionalPanel(condition="input.plottype4 == 'segment'",
			                 selectInput("addarrow4", h5("Add arrow head",
			                                 bsButton("bsb118", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb118", "Add arrow head for the segment.", trigger = "focus"),
			conditionalPanel(condition="input.addarrow4 == '1'",
			                 selectInput("arrowpos4", h5("Arrow position",
			                                 bsButton("bsb119", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Line end" = "1", "Line beginning" = "2"),selected="1"),
			    bsPopover("bsb119", 'The position of arrow head.',trigger = "focus"),
				sliderInput("arrowsize4", h5("Arrow size:",
				                             bsButton("bsb120", label="", icon=icon("question"), style="info", size="small")
				                             ), min=0, max=2, value=0.1, step=0.01),
				bsPopover("bsb120", 'The size of arrow head.',trigger = "focus")				
            )
			)
			)            
			),
			conditionalPanel(condition="input.plottype4=='point'",
				checkboxInput("symbol_opt4", HTML("<font color='red'>Symbol</font>"), FALSE),  
			    conditionalPanel(condition="input.symbol_opt4",  				
			                 selectInput("sel_symbolpoint4", h5("Symbol type",
                                                    bsButton("bsb121", label="", icon=icon("question"), style="info", size="small")
                                                    ), c("One custom symbol" = "1", 'Custom for data with a "shape" column' = "2"), selected="1"),
                bsPopover("bsb121", 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_symbolpoint4=='1'",
                    sliderInput("symbolpoint4", NULL, min=0, max=25, value=16, step=1)
                ),
                selectInput("shapelgd4", h5("Symbol legend",
		                                     bsButton("bsb122", label="", icon=icon("question"), style="info", size="small")
		                                     ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb122", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.shapelgd4=='1'",
 				    textInput("shapelgdname4", h5("Legend title:",
 				                                  bsButton("bsb123", label="", icon=icon("question"), style="info", size="small")
 				                                  ), value="symbol"),
 				    bsPopover("bsb123", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("shapelgdmdylabel4", h5("Modify legend labels",
					                                     bsButton("bsb124", label="", icon=icon("question"), style="info", size="small")
					                                     ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb124", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					conditionalPanel(condition="input.shapelgdmdylabel4=='1'",
						textInput("shapelgdlabel4", NULL, value="a,b,c")
	                )
				)
				),
				checkboxInput("size_opt4", HTML("<font color='red'>Size</font>"), FALSE),  
			    conditionalPanel(condition="input.size_opt4",  				
				selectInput("sel_pointsize4", h5("Point size",
                                                  bsButton("bsb125", label="", icon=icon("question"), style="info", size="small")
                                                  ), c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected="1"),
				bsPopover("bsb125", 'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_pointsize4=='1'",
                    sliderInput("pointsize4", NULL, min=0, max=5, value=0.8, step=0.1)
                ),
				selectInput("sizelgd4", h5("Size legend",
		                                    bsButton("bsb126", label="", icon=icon("question"), style="info", size="small")
		                                    ), choices = c("Show" = "1", "Hide" = "2"), "2"),
				bsPopover("bsb126", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.sizelgd4=='1'",
 				    textInput("sizelgdname4", h5("Legend title:",
 				                                 bsButton("bsb127", label="", icon=icon("question"), style="info", size="small")
 				                                 ), value="size"),
 				    bsPopover("bsb127", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("sizelgdmdylabel4", h5("Modify legend labels",
				                                        bsButton("bsb128", label="", icon=icon("question"), style="info", size="small")
				                                        ), c("Yes" = "1", "No" = "2"), "2"),
				    bsPopover("bsb128", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					conditionalPanel(condition="input.sizelgdmdylabel4=='1'",
						    textInput("sizelgdlabel4", NULL, value="a,b,c")
	                )
				)
				)				
            ),
			conditionalPanel(condition="input.plottype4=='heatmap_gradual' | input.plottype4=='heatmap_discrete' | input.plottype4=='rect_gradual' | input.plottype4=='rect_discrete' | input.plottype4=='bar'",
			                 selectInput("addborder4", h5("Add cell borders",
			                                  bsButton("bsb129", label="", icon=icon("question"), style="info", size="small")
			                                  ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb129", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
			    conditionalPanel(condition="input.addborder4=='1'",
                    fluidRow(column(12, jscolorInput("bordercols4", label = h5('Borders color:'), value = "#000000"))),
                    br()
					)
            ),
			conditionalPanel(condition="input.plottype4=='line' | input.plottype4=='point' | input.plottype4=='bar'",
			                 selectInput("ylabel4", h5("Y axis label",
	                                       bsButton("bsb131", label="", icon=icon("question"), style="info", size="small")
	                                       ), choices = c("Show" = "1", "Hide" = "2"), selected="1"),
	            bsPopover("bsb131", "Add tick labels on the Y-axis.", trigger = "focus")								
			),
			conditionalPanel(condition="input.plottype4=='text'",
		    	checkboxInput("font_opt4", HTML("<font color='red'>Font</font>"), FALSE),
			    conditionalPanel(condition="input.font_opt4",					
				    sliderInput("textsize4", "Font size:", min=0, max=10, value=2, step=0.1),
			        selectInput("fontface4", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
				    sliderInput("textangle4", "Font angle:", min=0, max=360, value=60, step=1)				
				)
			)
			)
			)
		   )
		),
		checkboxInput("data5", HTML("<font color='red'>Data5</font>"), FALSE),
		conditionalPanel(condition="input.data5",
		  radioButtons("seluploaddata5", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		  conditionalPanel(condition="input.seluploaddata5 == '2'",
		    fileInput("uploaddata5", h5("Upload data5:",
		                                bsButton("bsb132", label="", icon=icon("question"), style="info", size="small")
		                                ), multiple = FALSE),
		    bsPopover("bsb132", 'Click "Browse" to upload the track data.', trigger = "focus"),
			
		    actionButton("tabBut6", "View example data"),
			tags$script('$( "#uploaddata5" ).on( "click", function() { this.value = null; });'),
            downloadButton("example_data5.txt", "Example data"),
            br(),
			br(),
			selectInput("layerindex5", h5("Track index:",
			                              bsButton("bsb133", label="", icon=icon("question"), style="info", size="small")
			                              ), choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			bsPopover("bsb133", 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.', trigger = "focus"),
			selectInput("plottype5", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),
    	ADVANCED_OPTIONS_PANEL_5(
				list(
		    	checkboxInput("color_opt5", HTML("<font color='red'>Color</font>"), FALSE),  
			    conditionalPanel(condition="input.color_opt5",  					
				conditionalPanel(condition="input.plottype5 == 'point' | input.plottype5 == 'line' | input.plottype5 == 'bar' | input.plottype5 == 'segment'",
				                 selectInput("coltype5", h5("Data color",
			                                    bsButton("bsb134", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
			        bsPopover("bsb134", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', trigger = "focus"),
					conditionalPanel(condition="input.coltype5=='2'",
			            fluidRow(column(12, jscolorInput("colorcus5", label = NULL, value = "#FF0000"))),
                        br()			            			            
			         ),
                    conditionalPanel(condition="input.coltype5=='3'",
			            textInput("colormulgp5", NULL, value="a:red;b:blue;c:cyan")
	                )
				),
			conditionalPanel(condition="input.plottype5=='rect_discrete'",
			                 selectInput("rectcol5", h5("Data color",
			                                bsButton("bsb135", label="", icon=icon("question"), style="info", size="small")
			                                ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    bsPopover("bsb135", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.rectcol5=='2'",
			    fluidRow(column(12, jscolorInput("rectcoldis5", label = NULL, value = "#FF0000"))),
                br()
			),
			conditionalPanel(condition="input.rectcol5=='3'",
			    textInput("rectcoldiscus5", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype5=='rect_gradual'",
			                 selectInput("rectgrad_col5", h5("Colors",
			                                     bsButton("bsb136", label="", icon=icon("question"), style="info", size="small")
			                                     ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb136", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			    conditionalPanel(condition="input.rectgrad_col5=='1'",
			        selectInput("colrect5", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
			                                               "navy.cyan", "blue.red", "green.red"))
			    ),
			    conditionalPanel(condition="input.rectgrad_col5=='2'",
			        fluidRow(
			            column(4, jscolorInput("rect_lowColor5", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			            column(4, jscolorInput("rect_midColor5", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			            column(4, jscolorInput("rect_highColor5", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			            br()
			    )
			),
			conditionalPanel(condition="input.plottype5=='heatmap_gradual'",
			                 selectInput("heatmapcol5", h5("Colors",
			                                   bsButton("bsb137", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb137", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			conditionalPanel(condition="input.heatmapcol5=='1'",
			    selectInput("colhmap5", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
	                                                      "purple.yellow.red", "blue.green.red", "blue.yellow.green",
	                                                      "cyan.white.deeppink1"), selected="blue.white.red")
			),
			conditionalPanel(condition="input.heatmapcol5=='2'",
			    fluidRow(
			        column(4, jscolorInput("lowColor5", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			        column(4, jscolorInput("midColor5", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			        column(4, jscolorInput("highColor5", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			        br()
			)			
			),
			conditionalPanel(condition="input.plottype5=='heatmap_discrete'",
			                 selectInput("colhmapdis5", h5("Data color",
			                                   bsButton("bsb138", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Random" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb138", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.colhmapdis5=='2'",
			    textInput("colhmapdiscus5", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype5=='vertical line' | input.plottype5=='horizontal line'",
			    fluidRow(column(12, jscolorInput("linecolor5", label = h5('Line color:',
			                                                              bsButton("bsb139", label="", icon=icon("question"), style="info", size="small")
			                                                              ), value = "#FF0000"))),
			    bsPopover("bsb139", 'The color to be used to plot the data.', trigger = "focus"),
                br()
			),
			conditionalPanel(condition="input.plottype5=='line'",
			                 selectInput("fillarea5", h5("Fill area",
			                                 bsButton("bsb140", label="", icon=icon("question"), style="info", size="small")
			                                 ), choices = c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb140", "Fill the area below the lines.", trigger = "focus"),
                conditionalPanel(condition="input.fillarea5=='1'",
			    radioButtons("selareatype5", h5("Area color",
			                                    bsButton("bsb1400", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			    bsPopover("bsb1400", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
				conditionalPanel(condition="input.selareatype5=='2'",
			        fluidRow(column(12, jscolorInput("borderarea5", label = NULL, value = "#0000FF"))),
                    br()
			)
		    )			
			),
			conditionalPanel(condition="input.plottype5=='point' | input.plottype5=='line' | input.plottype5=='bar' | input.plottype5=='rect_gradual' | input.plottype5=='rect_discrete' | input.plottype5=='heatmap_gradual' | input.plottype5=='heatmap_discrete' | input.plottype5=='vertical line' | input.plottype5=='horizontal line' | input.plottype5=='text' | input.plottype5 == 'segment'",
			                conditionalPanel(condition="input.plottype5=='text'",
			                    fluidRow(column(12, jscolorInput("textcol5", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
			                    br()
			                ),  			                
			                selectInput("collgd5", h5("Color legend",
		                                   bsButton("bsb141", label="", icon=icon("question"), style="info", size="small")
		                                   ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb141", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.collgd5=='1'",
 				    textInput("collgdname5", h5("Legend title:",
 				                                bsButton("bsb142", label="", icon=icon("question"), style="info", size="small")
 				                                ), value="color"),
 				    bsPopover("bsb142", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
 				    
				    conditionalPanel(condition="input.plottype5!='rect_gradual' & input.plottype5!='heatmap_gradual'",
				                     selectInput("collgdmdylabel5", h5("Modify legend labels",
					                                       bsButton("bsb143", label="", icon=icon("question"), style="info", size="small")
					                                       ), c("Yes" = "1", "No" = "2"), "2"),
					    bsPopover("bsb143", 'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					    conditionalPanel(condition="input.collgdmdylabel5=='1'",
					        textInput("collgdlabel5", NULL, value="a,b,c")
					    )
				    )
                )				
			),
			conditionalPanel(condition="input.plottype5!='rect_gradual' & input.plottype5!='heatmap_gradual' & input.plottype5!='text'",
			    sliderInput("coltransparency5", h5("Color transparency:",
			                                       bsButton("bsb144", label="", icon=icon("question"), style="info", size="small")
			                                       ), min=0, max=1, value=1, step=0.1),
			    bsPopover("bsb144", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")										  
            )          
            ),   
			conditionalPanel(condition="input.plottype5=='line' | input.plottype5=='vertical line' | input.plottype5=='horizontal line' | input.plottype5 == 'segment'",
		    checkboxInput("linetype_opt5", HTML("<font color='red'>Linetype</font>"), FALSE), 
			conditionalPanel(condition="input.linetype_opt5",                       
            sliderInput("linesize5", "Line width:", min=0, max=3, value=0.2, step=0.05),
			selectInput("linetype5", h5("Line type",
			                            bsButton("bsb145", label="", icon=icon("question"), style="info", size="small")
			                            ), choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			bsPopover("bsb145", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus"),
			
			conditionalPanel(condition="input.plottype5=='vertical line' | input.plottype5=='horizontal line'",
			                 selectInput("linetypelgd5", h5("Line type legend",
		                                        bsButton("bsb146", label="", icon=icon("question"), style="info", size="small")
		                                        ), c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb146", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
				
			    conditionalPanel(condition="input.linetypelgd5=='1'",
 				    textInput("linetypelgdname5", h5("Legend title:",
 				                                     bsButton("bsb147", label="", icon=icon("question"), style="info", size="small")
 				                                     ), value="linetype"),
 				    bsPopover("bsb147", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
 				    
 				    selectInput("linetypelgdmdylabel5", h5("Modify legend labels",
					                                        bsButton("bsb148", label="", icon=icon("question"), style="info", size="small")
					                                        ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb148", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
					conditionalPanel(condition="input.linetypelgdmdylabel5=='1'",
						textInput("linetypelgdlabel5", NULL, value="a")
	                )
				)
			),
			conditionalPanel(condition="input.plottype5 == 'segment'",
			                 selectInput("addarrow5", h5("Add arrow head",
			                                 bsButton("bsb149", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb149", "Add arrow head for the segment.", trigger = "focus"),
			conditionalPanel(condition="input.addarrow5 == '1'",
			                 selectInput("arrowpos5", h5("Arrow position",
			                                 bsButton("bsb150", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Line end" = "1", "Line beginning" = "2"),selected="1"),
			    bsPopover("bsb150", 'The position of arrow head.',trigger = "focus"),
				sliderInput("arrowsize5", h5("Arrow size:",
				                             bsButton("bsb151", label="", icon=icon("question"), style="info", size="small")
				                             ), min=0, max=2, value=0.1, step=0.01),
				bsPopover("bsb151", 'The size of arrow head.',trigger = "focus")								
            )
			)
			)
			),
			conditionalPanel(condition="input.plottype5=='point'",
				checkboxInput("symbol_opt5", HTML("<font color='red'>Symbol</font>"), FALSE),  
			    conditionalPanel(condition="input.symbol_opt5",  				
			                 selectInput("sel_symbolpoint5", h5("Symbol type",
                                                    bsButton("bsb152", label="", icon=icon("question"), style="info", size="small")
                                                    ), c("One custom symbol" = "1", 'Custom for data with a "shape" column' = "2"), selected="1"),
                bsPopover("bsb152", 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_symbolpoint5=='1'",
                    sliderInput("symbolpoint5", NULL, min=0, max=25, value=16, step=1)
                ),
                selectInput("shapelgd5", h5("Symbol legend",
		                                     bsButton("bsb153", label="", icon=icon("question"), style="info", size="small")
		                                     ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb153", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),

			    conditionalPanel(condition="input.shapelgd5=='1'",
 				    textInput("shapelgdname5", h5("Legend title:",
 				                                  bsButton("bsb154", label="", icon=icon("question"), style="info", size="small")
 				                                  ), value="symbol"),
 				    bsPopover("bsb154", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
 				    
 				    selectInput("shapelgdmdylabel5", h5("Modify legend labels",
					                                     bsButton("bsb155", label="", icon=icon("question"), style="info", size="small")
					                                     ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb155", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					conditionalPanel(condition="input.shapelgdmdylabel5=='1'",
						textInput("shapelgdlabel5", NULL, value="a,b,c")
	                )
				)
				),
				checkboxInput("size_opt5", HTML("<font color='red'>Size</font>"), FALSE),  
			    conditionalPanel(condition="input.size_opt5",  				
				selectInput("sel_pointsize5", h5("Point size",
                                                  bsButton("bsb156", label="", icon=icon("question"), style="info", size="small")
                                                  ), c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected="1"),
				bsPopover("bsb156", 'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_pointsize5=='1'",
                    sliderInput("pointsize5", NULL, min=0, max=5, value=0.8, step=0.1)
                ),
				selectInput("sizelgd5", h5("Size legend",
		                                    bsButton("bsb157", label="", icon=icon("question"), style="info", size="small")
		                                    ), choices = c("Show" = "1", "Hide" = "2"), "2"),
				bsPopover("bsb157", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.sizelgd5=='1'",
 				    textInput("sizelgdname5", h5("Legend title:",
 				                                 bsButton("bsb1570", label="", icon=icon("question"), style="info", size="small")
 				                                 ), value="size"),
 				    bsPopover("bsb1570", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("sizelgdmdylabel5", h5("Modify legend labels",
				                                        bsButton("bsb158", label="", icon=icon("question"), style="info", size="small")
				                                        ), c("Yes" = "1", "No" = "2"), "2"),
				    bsPopover("bsb158", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					conditionalPanel(condition="input.sizelgdmdylabel5=='1'",
						    textInput("sizelgdlabel5", NULL, value="a,b,c")
	                )
				)
				)				
            ),
			conditionalPanel(condition="input.plottype5=='heatmap_gradual' | input.plottype5=='heatmap_discrete' | input.plottype5=='rect_gradual' | input.plottype5=='rect_discrete' | input.plottype5=='bar'",
			                 selectInput("addborder5", h5("Add cell borders",
			                                  bsButton("bsb159", label="", icon=icon("question"), style="info", size="small")
			                                  ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb159", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
			    conditionalPanel(condition="input.addborder5=='1'",
                    fluidRow(column(12, jscolorInput("bordercols5", label = h5('Borders color:'), value = "#000000"))),
                    br()
					)
            ),
			conditionalPanel(condition="input.plottype5=='line' | input.plottype5=='point' | input.plottype5=='bar'",
			                 selectInput("ylabel5", h5("Y axis label",
	                                       bsButton("bsb161", label="", icon=icon("question"), style="info", size="small")
	                                       ), choices = c("Show" = "1", "Hide" = "2"), selected="1"),
	            bsPopover("bsb161", "Add tick labels on the Y-axis.", trigger = "focus")								
			),
			conditionalPanel(condition="input.plottype5=='text'",
		    	checkboxInput("font_opt5", HTML("<font color='red'>Font</font>"), FALSE),
			    conditionalPanel(condition="input.font_opt5",					
				    sliderInput("textsize5", "Font size:", min=0, max=10, value=2, step=0.1),
			        selectInput("fontface5", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
				    sliderInput("textangle5", "Font angle:", min=0, max=360, value=60, step=1)				
				)
			)
			)
			)
		   )
		),
		checkboxInput("data6", HTML("<font color='red'>Data6</font>"), FALSE),
		conditionalPanel(condition="input.data6",
		  radioButtons("seluploaddata6", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		  conditionalPanel(condition="input.seluploaddata6 == '2'",
		    fileInput("uploaddata6", h5("Upload data6:",
		                                bsButton("bsb162", label="", icon=icon("question"), style="info", size="small")
		                                ), multiple = FALSE),
		    bsPopover("bsb162", 'Click "Browse" to upload the track data.', trigger = "focus"),
		    
		    actionButton("tabBut7", "View example data"),
			tags$script('$( "#uploaddata6" ).on( "click", function() { this.value = null; });'),
            downloadButton("example_data6.txt", "Example data"),
            br(),
			br(),
			selectInput("layerindex6", h5("Track index:",
			                              bsButton("bsb163", label="", icon=icon("question"), style="info", size="small")
			                              ), choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			bsPopover("bsb163", 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.', trigger = "focus"),
			selectInput("plottype6", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),
    	ADVANCED_OPTIONS_PANEL_6(
				list(
		    	checkboxInput("color_opt6", HTML("<font color='red'>Color</font>"), FALSE), 
			    conditionalPanel(condition="input.color_opt6", 					
				conditionalPanel(condition="input.plottype6 == 'point' | input.plottype6 == 'line' | input.plottype6 == 'bar' | input.plottype6 == 'segment'",
				                 selectInput("coltype6", h5("Data color",
			                                    bsButton("bsb164", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
			        bsPopover("bsb164", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', trigger = "focus"),
					conditionalPanel(condition="input.coltype6=='2'",
			            fluidRow(column(12, jscolorInput("colorcus6", label = NULL, value = "#FF0000"))),
                        br()			            			            
			         ),
                    conditionalPanel(condition="input.coltype6=='3'",
			            textInput("colormulgp6", NULL, value="a:red;b:blue;c:cyan")
	                )
				),
			conditionalPanel(condition="input.plottype6=='rect_discrete'",
			                 selectInput("rectcol6", h5("Data color",
			                                bsButton("bsb165", label="", icon=icon("question"), style="info", size="small")
			                                ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    bsPopover("bsb165", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.rectcol6=='2'",
			    fluidRow(column(12, jscolorInput("rectcoldis6", label = NULL, value = "#FF0000"))),
                br()
			),
			conditionalPanel(condition="input.rectcol6=='3'",
			    textInput("rectcoldiscus6", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype6=='rect_gradual'",
			                 selectInput("rectgrad_col6", h5("Colors",
			                                     bsButton("bsb166", label="", icon=icon("question"), style="info", size="small")
			                                     ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb166", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			    conditionalPanel(condition="input.rectgrad_col6=='1'",
			        selectInput("colrect6", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
			                                               "navy.cyan", "blue.red", "green.red"))
			    ),
			    conditionalPanel(condition="input.rectgrad_col6=='2'",
			        fluidRow(
			            column(4, jscolorInput("rect_lowColor6", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			            column(4, jscolorInput("rect_midColor6", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			            column(4, jscolorInput("rect_highColor6", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			            br()
			    )
			),
			conditionalPanel(condition="input.plottype6=='heatmap_gradual'",
			                 selectInput("heatmapcol6", h5("Colors",
			                                   bsButton("bsb167", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb167", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			conditionalPanel(condition="input.heatmapcol6=='1'",
			    selectInput("colhmap6", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
	                                                      "purple.yellow.red", "blue.green.red", "blue.yellow.green",
	                                                      "cyan.white.deeppink1"), selected="blue.white.red")
			),
			conditionalPanel(condition="input.heatmapcol6=='2'",
			    fluidRow(
			        column(4, jscolorInput("lowColor6", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			        column(4, jscolorInput("midColor6", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			        column(4, jscolorInput("highColor6", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			        br()
			)			
			),
			conditionalPanel(condition="input.plottype6=='heatmap_discrete'",
			                 selectInput("colhmapdis6", h5("Data color",
			                                   bsButton("bsb168", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Random" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb168", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.colhmapdis6=='2'",
			    textInput("colhmapdiscus6", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype6=='vertical line' | input.plottype6=='horizontal line'",
			    fluidRow(column(12, jscolorInput("linecolor6", label = h5('Line color:',
			                                                              bsButton("bsb169", label="", icon=icon("question"), style="info", size="small")
			                                                              ), value = "#FF0000"))),
			    bsPopover("bsb169", 'The color to be used to plot the data.', trigger = "focus"),
                br()
			),
			conditionalPanel(condition="input.plottype6=='line'",
			                 selectInput("fillarea6", h5("Fill area",
			                                 bsButton("bsb170", label="", icon=icon("question"), style="info", size="small")
			                                 ), choices = c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb170", "Fill the area below the lines.", trigger = "focus"),
                conditionalPanel(condition="input.fillarea6=='1'",
			    radioButtons("selareatype6", h5("Area color",
			                                    bsButton("bsb171", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			    bsPopover("bsb171", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
				conditionalPanel(condition="input.selareatype6=='2'",
			        fluidRow(column(12, jscolorInput("borderarea6", label = NULL, value = "#0000FF"))),
                    br()
			)
		    )			
			),
			conditionalPanel(condition="input.plottype6=='point' | input.plottype6=='line' | input.plottype6=='bar' | input.plottype6=='rect_gradual' | input.plottype6=='rect_discrete' | input.plottype6=='heatmap_gradual' | input.plottype6=='heatmap_discrete' | input.plottype6=='vertical line' | input.plottype6=='horizontal line' | input.plottype6=='text' | input.plottype6 == 'segment'",
			                conditionalPanel(condition="input.plottype6=='text'",
			                    fluidRow(column(12, jscolorInput("textcol6", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
			                    br()
			                ),
			                selectInput("collgd6", h5("Color legend",
		                                   bsButton("bsb172", label="", icon=icon("question"), style="info", size="small")
		                                   ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb172", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.collgd6=='1'",
 				    textInput("collgdname6", h5("Legend title:",
 				                                bsButton("bsb173", label="", icon=icon("question"), style="info", size="small")
 				                                ), value="color"),
 				    bsPopover("bsb173", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
				    conditionalPanel(condition="input.plottype6!='rect_gradual' & input.plottype6!='heatmap_gradual'",
				                     selectInput("collgdmdylabel6", h5("Modify legend labels",
					                                       bsButton("bsb174", label="", icon=icon("question"), style="info", size="small")
					                                       ), c("Yes" = "1", "No" = "2"), "2"),
					    bsPopover("bsb174", 'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					    conditionalPanel(condition="input.collgdmdylabel6=='1'",
					        textInput("collgdlabel6", NULL, value="a,b,c")
					    )
				    )
                )				
			),
			conditionalPanel(condition="input.plottype6!='rect_gradual' & input.plottype6!='heatmap_gradual' & input.plottype6!='text'",
			    sliderInput("coltransparency6", h5("Color transparency:",
			                                       bsButton("bsb175", label="", icon=icon("question"), style="info", size="small")
			                                       ), min=0, max=1, value=1, step=0.1),
			    bsPopover("bsb175", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")										  
            )          
            ),    
			conditionalPanel(condition="input.plottype6=='line' | input.plottype6=='vertical line' | input.plottype6=='horizontal line' | input.plottype6 == 'segment'",
		    checkboxInput("linetype_opt6", HTML("<font color='red'>Linetype</font>"), FALSE), 
			conditionalPanel(condition="input.linetype_opt6",                      
            sliderInput("linesize6", "Line width:", min=0, max=3, value=0.2, step=0.05),
			selectInput("linetype6", h5("Line type",
			                            bsButton("bsb176", label="", icon=icon("question"), style="info", size="small")
			                            ), choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			bsPopover("bsb176", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus"),
			conditionalPanel(condition="input.plottype6=='vertical line' | input.plottype6=='horizontal line'",
			                 selectInput("linetypelgd6", h5("Line type legend",
		                                        bsButton("bsb177", label="", icon=icon("question"), style="info", size="small")
		                                        ), c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb177", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.linetypelgd6=='1'",
 				    textInput("linetypelgdname6", h5("Legend title:",
 				                                     bsButton("bsb178", label="", icon=icon("question"), style="info", size="small")
 				                                     ), value="linetype"),
 				    bsPopover("bsb178", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("linetypelgdmdylabel6", h5("Modify legend labels",
					                                        bsButton("bsb179", label="", icon=icon("question"), style="info", size="small")
					                                        ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb179", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
					conditionalPanel(condition="input.linetypelgdmdylabel6=='1'",
						textInput("linetypelgdlabel6", NULL, value="a")
	                )
				)
			),
			conditionalPanel(condition="input.plottype6 == 'segment'",
			                 selectInput("addarrow6", h5("Add arrow head",
			                                 bsButton("bsb180", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb180", "Add arrow head for the segment.", trigger = "focus"),
			conditionalPanel(condition="input.addarrow6 == '1'",
			                 selectInput("arrowpos6", h5("Arrow position",
			                                 bsButton("bsb181", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Line end" = "1", "Line beginning" = "2"),selected="1"),
			    bsPopover("bsb181", 'The position of arrow head.',trigger = "focus"),
				sliderInput("arrowsize6", h5("Arrow size:",
				                             bsButton("bsb182", label="", icon=icon("question"), style="info", size="small")
				                             ), min=0, max=2, value=0.1, step=0.01),
				bsPopover("bsb182", 'The size of arrow head.',trigger = "focus")								
            )
			)
			)            
			),
			conditionalPanel(condition="input.plottype6=='point'",
				checkboxInput("symbol_opt6", HTML("<font color='red'>Symbol</font>"), FALSE), 
			    conditionalPanel(condition="input.symbol_opt6", 				
			                 selectInput("sel_symbolpoint6", h5("Symbol type",
                                                    bsButton("bsb183", label="", icon=icon("question"), style="info", size="small")
                                                    ), c("One custom symbol" = "1", 'Custom for data with a "shape" column' = "2"), selected="1"),
                bsPopover("bsb183", 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_symbolpoint6=='1'",
                    sliderInput("symbolpoint6", NULL, min=0, max=25, value=16, step=1)
                ),
                selectInput("shapelgd6", h5("Symbol legend",
		                                     bsButton("bsb184", label="", icon=icon("question"), style="info", size="small")
		                                     ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb184", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.shapelgd6=='1'",
 				    textInput("shapelgdname6", h5("Legend title:",
 				                                  bsButton("bsb185", label="", icon=icon("question"), style="info", size="small")
 				                                  ), value="symbol"),
 				    bsPopover("bsb185", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("shapelgdmdylabel6", h5("Modify legend labels",
					                                     bsButton("bsb186", label="", icon=icon("question"), style="info", size="small")
					                                     ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb186", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					conditionalPanel(condition="input.shapelgdmdylabel6=='1'",
						textInput("shapelgdlabel6", NULL, value="a,b,c")
	                )
				)
				),
				checkboxInput("size_opt6", HTML("<font color='red'>Size</font>"), FALSE),  
			    conditionalPanel(condition="input.size_opt6",  
				selectInput("sel_pointsize6", h5("Point size",
                                                  bsButton("bsb187", label="", icon=icon("question"), style="info", size="small")
                                                  ), c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected="1"),
				bsPopover("bsb187", 'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_pointsize6=='1'",
                    sliderInput("pointsize6", NULL, min=0, max=5, value=0.8, step=0.1)
                ),
				selectInput("sizelgd6", h5("Size legend",
		                                    bsButton("bsb188", label="", icon=icon("question"), style="info", size="small")
		                                    ), choices = c("Show" = "1", "Hide" = "2"), "2"),
				bsPopover("bsb188", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.sizelgd6=='1'",
 				    textInput("sizelgdname6", h5("Legend title:",
 				                                 bsButton("bsb189", label="", icon=icon("question"), style="info", size="small")
 				                                 ), value="size"),
 				    bsPopover("bsb189", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("sizelgdmdylabel6", h5("Modify legend labels",
				                                        bsButton("bsb190", label="", icon=icon("question"), style="info", size="small")
				                                        ), c("Yes" = "1", "No" = "2"), "2"),
				    bsPopover("bsb190", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					conditionalPanel(condition="input.sizelgdmdylabel6=='1'",
						    textInput("sizelgdlabel6", NULL, value="a,b,c")
	                )
				)
				)				
            ),
			conditionalPanel(condition="input.plottype6=='heatmap_gradual' | input.plottype6=='heatmap_discrete' | input.plottype6=='rect_gradual' | input.plottype6=='rect_discrete' | input.plottype6=='bar'",
			                 selectInput("addborder6", h5("Add cell borders",
			                                  bsButton("bsb191", label="", icon=icon("question"), style="info", size="small")
			                                  ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb191", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
			    conditionalPanel(condition="input.addborder6=='1'",
                    fluidRow(column(12, jscolorInput("bordercols6", label = h5('Borders color:'), value = "#000000"))),
                    br()
					)
            ),
			conditionalPanel(condition="input.plottype6=='line' | input.plottype6=='point' | input.plottype6=='bar'",
			                 selectInput("ylabel6", h5("Y axis label",
	                                       bsButton("bsb193", label="", icon=icon("question"), style="info", size="small")
	                                       ), choices = c("Show" = "1", "Hide" = "2"), selected="1"),
	            bsPopover("bsb193", "Add tick labels on the Y-axis.", trigger = "focus")								
			),
			conditionalPanel(condition="input.plottype6=='text'",
		    	checkboxInput("font_opt6", HTML("<font color='red'>Font</font>"), FALSE),
			    conditionalPanel(condition="input.font_opt6",					
				    sliderInput("textsize6", "Font size:", min=0, max=10, value=2, step=0.1),
			        selectInput("fontface6", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
				    sliderInput("textangle6", "Font angle:", min=0, max=360, value=60, step=1)				
				)
			)
			)
			)
		   )
		),
		checkboxInput("data7", HTML("<font color='red'>Data7</font>"), FALSE),
		conditionalPanel(condition="input.data7",
		  radioButtons("seluploaddata7", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		  conditionalPanel(condition="input.seluploaddata7 == '2'",
		    fileInput("uploaddata7", h5("Upload data7:",
		                                bsButton("bsb194", label="", icon=icon("question"), style="info", size="small")
		                                ), multiple = FALSE),
		    bsPopover("bsb194", 'Click "Browse" to upload the track data.', trigger = "focus"),
		    
		    actionButton("tabBut8", "View example data"),
			tags$script('$( "#uploaddata7" ).on( "click", function() { this.value = null; });'),
            downloadButton("example_data7.txt", "Example data"),
            br(),
			br(),
	     	selectInput("layerindex7", h5("Track index:",
	     	                              bsButton("bsb195", label="", icon=icon("question"), style="info", size="small")
	     	                              ), choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			bsPopover("bsb195", 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.', trigger = "focus"),
			selectInput("plottype7", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),
    	ADVANCED_OPTIONS_PANEL_7(
				list(
		    	checkboxInput("color_opt7", HTML("<font color='red'>Color</font>"), FALSE), 
			    conditionalPanel(condition="input.color_opt7", 					
				conditionalPanel(condition="input.plottype7 == 'point' | input.plottype7 == 'line' | input.plottype7 == 'bar' | input.plottype7 == 'segment'",
				                 selectInput("coltype7", h5("Data color",
			                                    bsButton("bsb196", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
			        bsPopover("bsb196", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', trigger = "focus"),
					conditionalPanel(condition="input.coltype7=='2'",
			            fluidRow(column(12, jscolorInput("colorcus7", label = NULL, value = "#FF0000"))),
                        br()			            						
			         ),
                    conditionalPanel(condition="input.coltype7=='3'",
			            textInput("colormulgp7", NULL, value="a:red;b:blue;c:cyan")
	                )
				),
			conditionalPanel(condition="input.plottype7=='rect_discrete'",
			                 selectInput("rectcol7", h5("Data color",
			                                bsButton("bsb197", label="", icon=icon("question"), style="info", size="small")
			                                ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    bsPopover("bsb197", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.rectcol7=='2'",
			    fluidRow(column(12, jscolorInput("rectcoldis7", label = NULL, value = "#FF0000"))),
                br()
			),
			conditionalPanel(condition="input.rectcol7=='3'",
			    textInput("rectcoldiscus7", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype7=='rect_gradual'",
			                 selectInput("rectgrad_col7", h5("Colors",
			                                     bsButton("bsb198", label="", icon=icon("question"), style="info", size="small")
			                                     ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb198", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			    conditionalPanel(condition="input.rectgrad_col7=='1'",
			        selectInput("colrect7", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
			                                               "navy.cyan", "blue.red", "green.red"))
			    ),
			    conditionalPanel(condition="input.rectgrad_col7=='2'",
			        fluidRow(
			            column(4, jscolorInput("rect_lowColor7", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			            column(4, jscolorInput("rect_midColor7", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			            column(4, jscolorInput("rect_highColor7", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			            br()
			    )
			),
			conditionalPanel(condition="input.plottype7=='heatmap_gradual'",
			                 selectInput("heatmapcol7", h5("Colors",
			                                   bsButton("bsb199", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb199", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			conditionalPanel(condition="input.heatmapcol7=='1'",
			    selectInput("colhmap7", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
	                                                      "purple.yellow.red", "blue.green.red", "blue.yellow.green",
	                                                      "cyan.white.deeppink1"), selected="blue.white.red")
			),
			conditionalPanel(condition="input.heatmapcol7=='2'",
			    fluidRow(
			        column(4, jscolorInput("lowColor7", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			        column(4, jscolorInput("midColor7", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			        column(4, jscolorInput("highColor7", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			        br()
			)			
			),
			conditionalPanel(condition="input.plottype7=='heatmap_discrete'",
			                 selectInput("colhmapdis7", h5("Data color",
			                                   bsButton("bsb200", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Random" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb200", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.colhmapdis7=='2'",
			    textInput("colhmapdiscus7", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype7=='vertical line' | input.plottype7=='horizontal line'",
			    fluidRow(column(12, jscolorInput("linecolor7", label = h5('Line color:',
			                                                              bsButton("bsb201", label="", icon=icon("question"), style="info", size="small")
			                                                              ), value = "#FF0000"))),
			    bsPopover("bsb201", 'The color to be used to plot the data.', trigger = "focus"),
                br()
			),
			conditionalPanel(condition="input.plottype7=='line'",
			                 selectInput("fillarea7", h5("Fill area",
			                                 bsButton("bsb202", label="", icon=icon("question"), style="info", size="small")
			                                 ), choices = c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb202", "Fill the area below the lines.", trigger = "focus"),
                conditionalPanel(condition="input.fillarea7=='1'",
			    radioButtons("selareatype7", h5("Area color",
			                                    bsButton("bsb203", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			    bsPopover("bsb203", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
				conditionalPanel(condition="input.selareatype7=='2'",
			        fluidRow(column(12, jscolorInput("borderarea7", label = NULL, value = "#0000FF"))),
                    br()
			)
		    )			
			),
			conditionalPanel(condition="input.plottype7=='point' | input.plottype7=='line' | input.plottype7=='bar' | input.plottype7=='rect_gradual' | input.plottype7=='rect_discrete' | input.plottype7=='heatmap_gradual' | input.plottype7=='heatmap_discrete' | input.plottype7=='vertical line' | input.plottype7=='horizontal line' | input.plottype7=='text' | input.plottype7 == 'segment'",
			                conditionalPanel(condition="input.plottype7=='text'",
			                    fluidRow(column(12, jscolorInput("textcol7", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
			                    br()
			                ),			                
			                selectInput("collgd7", h5("Color legend",
		                                   bsButton("bsb204", label="", icon=icon("question"), style="info", size="small")
		                                   ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb204", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.collgd7=='1'",
 				    textInput("collgdname7", h5("Legend title:",
 				                                bsButton("bsb205", label="", icon=icon("question"), style="info", size="small")
 				                                ), value="color"),
 				    bsPopover("bsb205", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
				    conditionalPanel(condition="input.plottype7!='rect_gradual' & input.plottype7!='heatmap_gradual'",
				                     selectInput("collgdmdylabel7", h5("Modify legend labels",
					                                       bsButton("bsb206", label="", icon=icon("question"), style="info", size="small")
					                                       ), c("Yes" = "1", "No" = "2"), "2"),
					    bsPopover("bsb206", 'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					    conditionalPanel(condition="input.collgdmdylabel7=='1'",
					        textInput("collgdlabel7", NULL, value="a,b,c")
					    )
				    )
                )				
			),
			conditionalPanel(condition="input.plottype7!='rect_gradual' & input.plottype7!='heatmap_gradual' & input.plottype7!='text'",
			    sliderInput("coltransparency7", h5("Color transparency:",
			                                       bsButton("bsb207", label="", icon=icon("question"), style="info", size="small")
			                                       ), min=0, max=1, value=1, step=0.1),
			    bsPopover("bsb207", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")										  
            )          
            ),      
			conditionalPanel(condition="input.plottype7=='line' | input.plottype7=='vertical line' | input.plottype7=='horizontal line' | input.plottype7 == 'segment'",
		    checkboxInput("linetype_opt7", HTML("<font color='red'>Linetype</font>"), FALSE),  
			conditionalPanel(condition="input.linetype_opt7",                     
            sliderInput("linesize7", "Line width:", min=0, max=3, value=0.2, step=0.05),
			selectInput("linetype7", h5("Line type",
			                            bsButton("bsb208", label="", icon=icon("question"), style="info", size="small")
			                            ), choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			bsPopover("bsb208", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus"),
			conditionalPanel(condition="input.plottype7=='vertical line' | input.plottype7=='horizontal line'",
			                 selectInput("linetypelgd7", h5("Line type legend",
		                                        bsButton("bsb209", label="", icon=icon("question"), style="info", size="small")
		                                        ), c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb209", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.linetypelgd7=='1'",
 				    textInput("linetypelgdname7", h5("Legend title:",
 				                                     bsButton("bsb210", label="", icon=icon("question"), style="info", size="small")
 				                                     ), value="linetype"),
 				    bsPopover("bsb210", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("linetypelgdmdylabel7", h5("Modify legend labels",
					                                        bsButton("bsb211", label="", icon=icon("question"), style="info", size="small")
					                                        ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb211", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
					conditionalPanel(condition="input.linetypelgdmdylabel7=='1'",
						textInput("linetypelgdlabel7", NULL, value="a")
	                )
				)
			),
			conditionalPanel(condition="input.plottype7 == 'segment'",
			                 selectInput("addarrow7", h5("Add arrow head",
			                                 bsButton("bsb212", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb212", "Add arrow head for the segment.", trigger = "focus"),
			conditionalPanel(condition="input.addarrow7 == '1'",
			                 selectInput("arrowpos7", h5("Arrow position",
			                                 bsButton("bsb213", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Line end" = "1", "Line beginning" = "2"),selected="1"),
			    bsPopover("bsb213", 'The position of arrow head.',trigger = "focus"),
				sliderInput("arrowsize7", h5("Arrow size:",
				                             bsButton("bsb214", label="", icon=icon("question"), style="info", size="small")
				                             ), min=0, max=2, value=0.1, step=0.01),
				bsPopover("bsb214", 'The size of arrow head.',trigger = "focus")								
            )
			)
			)            
			),
			conditionalPanel(condition="input.plottype7=='point'",
				checkboxInput("symbol_opt7", HTML("<font color='red'>Symbol</font>"), FALSE), 
			    conditionalPanel(condition="input.symbol_opt7", 				
			                 selectInput("sel_symbolpoint7", h5("Symbol type",
                                                    bsButton("bsb215", label="", icon=icon("question"), style="info", size="small")
                                                    ), c("One custom symbol" = "1", 'Custom for data with a "shape" column' = "2"), selected="1"),
                bsPopover("bsb215", 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_symbolpoint7=='1'",
                    sliderInput("symbolpoint7", NULL, min=0, max=25, value=16, step=1)
                ),
                selectInput("shapelgd7", h5("Symbol legend",
		                                     bsButton("bsb216", label="", icon=icon("question"), style="info", size="small")
		                                     ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb216", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.shapelgd7=='1'",
 				    textInput("shapelgdname7", h5("Legend title:",
 				                                  bsButton("bsb217", label="", icon=icon("question"), style="info", size="small")
 				                                  ), value="symbol"),
 				    bsPopover("bsb217", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("shapelgdmdylabel7", h5("Modify legend labels",
					                                     bsButton("bsb218", label="", icon=icon("question"), style="info", size="small")
					                                     ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb218", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					conditionalPanel(condition="input.shapelgdmdylabel7=='1'",
						textInput("shapelgdlabel7", NULL, value="a,b,c")
	                )
				)
				),
				checkboxInput("size_opt7", HTML("<font color='red'>Size</font>"), FALSE),  
			    conditionalPanel(condition="input.size_opt7",  
				selectInput("sel_pointsize7", h5("Point size",
                                                  bsButton("bsb219", label="", icon=icon("question"), style="info", size="small")
                                                  ), c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected="1"),
				bsPopover("bsb219", 'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_pointsize7=='1'",
                    sliderInput("pointsize7", NULL, min=0, max=5, value=0.8, step=0.1)
                ),
				selectInput("sizelgd7", h5("Size legend",
		                                    bsButton("bsb220", label="", icon=icon("question"), style="info", size="small")
		                                    ), choices = c("Show" = "1", "Hide" = "2"), "2"),
				bsPopover("bsb220", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.sizelgd7=='1'",
 				    textInput("sizelgdname7", h5("Legend title:",
 				                                 bsButton("bsb221", label="", icon=icon("question"), style="info", size="small")
 				                                 ), value="size"),
 				    bsPopover("bsb221", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("sizelgdmdylabel7", h5("Modify legend labels",
				                                        bsButton("bsb222", label="", icon=icon("question"), style="info", size="small")
				                                        ), c("Yes" = "1", "No" = "2"), "2"),
				    bsPopover("bsb222", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					conditionalPanel(condition="input.sizelgdmdylabel7=='1'",
						    textInput("sizelgdlabel7", NULL, value="a,b,c")
	                )
				)	
				)			
            ),
			conditionalPanel(condition="input.plottype7=='heatmap_gradual' | input.plottype7=='heatmap_discrete' | input.plottype7=='rect_gradual' | input.plottype7=='rect_discrete' | input.plottype7=='bar'",
			                 selectInput("addborder7", h5("Add cell borders",
			                                  bsButton("bsb223", label="", icon=icon("question"), style="info", size="small")
			                                  ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb223", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
			    conditionalPanel(condition="input.addborder7=='1'",
                    fluidRow(column(12, jscolorInput("bordercols7", label = h5('Borders color:'), value = "#000000"))),
                    br()
					)
            ),
			conditionalPanel(condition="input.plottype7=='line' | input.plottype7=='point' | input.plottype7=='bar'",
			                 selectInput("ylabel7", h5("Y axis label",
	                                       bsButton("bsb225", label="", icon=icon("question"), style="info", size="small")
	                                       ), choices = c("Show" = "1", "Hide" = "2"), selected="1"),
	            bsPopover("bsb225", "Add tick labels on the Y-axis.", trigger = "focus")								
			),
			conditionalPanel(condition="input.plottype7=='text'",
		    	checkboxInput("font_opt7", HTML("<font color='red'>Font</font>"), FALSE),
			    conditionalPanel(condition="input.font_opt7",					
				    sliderInput("textsize7", "Font size:", min=0, max=10, value=2, step=0.1),
			        selectInput("fontface7", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
				    sliderInput("textangle7", "Font angle:", min=0, max=360, value=60, step=1)				
				)
			)
			)
			)
		   )
		),
		checkboxInput("data8", HTML("<font color='red'>Data8</font>"), FALSE),
		conditionalPanel(condition="input.data8",
		  radioButtons("seluploaddata8", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		  conditionalPanel(condition="input.seluploaddata8 == '2'",
		    fileInput("uploaddata8", h5("Upload data8:",
		                                bsButton("bsb226", label="", icon=icon("question"), style="info", size="small")
		                                ), multiple = FALSE),
		    bsPopover("bsb226", 'Click "Browse" to upload the track data.', trigger = "focus"),
		    
		    actionButton("tabBut9", "View example data"),
			tags$script('$( "#uploaddata8" ).on( "click", function() { this.value = null; });'),
            downloadButton("example_data8.txt", "Example data"),
            br(),
			br(),
			selectInput("layerindex8", h5("Track index:",
			                              bsButton("bsb227", label="", icon=icon("question"), style="info", size="small")
			                              ), choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			bsPopover("bsb227", 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.', trigger = "focus"),
			selectInput("plottype8", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),
    	ADVANCED_OPTIONS_PANEL_8(
				list(
		    	checkboxInput("color_opt8", HTML("<font color='red'>Color</font>"), FALSE), 
			    conditionalPanel(condition="input.color_opt8", 					
				conditionalPanel(condition="input.plottype8 == 'point' | input.plottype8 == 'line' | input.plottype8 == 'bar' | input.plottype8 == 'segment'",
				                 selectInput("coltype8", h5("Data color",
			                                    bsButton("bsb228", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
			        bsPopover("bsb228", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', trigger = "focus"),
					conditionalPanel(condition="input.coltype8=='2'",
			            fluidRow(column(12, jscolorInput("colorcus8", label = NULL, value = "#FF0000"))),
                        br()			            						
			         ),
                    conditionalPanel(condition="input.coltype8=='3'",
			            textInput("colormulgp8", NULL, value="a:red;b:blue;c:cyan")
	                )
				),
			conditionalPanel(condition="input.plottype8=='rect_discrete'",
			                 selectInput("rectcol8", h5("Data color",
			                                bsButton("bsb229", label="", icon=icon("question"), style="info", size="small")
			                                ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    bsPopover("bsb229", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.rectcol8=='2'",
			    fluidRow(column(12, jscolorInput("rectcoldis8", label = NULL, value = "#FF0000"))),
                br()
			),
			conditionalPanel(condition="input.rectcol8=='3'",
			    textInput("rectcoldiscus8", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype8=='rect_gradual'",
			                 selectInput("rectgrad_col8", h5("Colors",
			                                     bsButton("bsb230", label="", icon=icon("question"), style="info", size="small")
			                                     ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb230", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			    conditionalPanel(condition="input.rectgrad_col8=='1'",
			        selectInput("colrect8", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
			                                               "navy.cyan", "blue.red", "green.red"))
			    ),
			    conditionalPanel(condition="input.rectgrad_col8=='2'",
			        fluidRow(
			            column(4, jscolorInput("rect_lowColor8", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			            column(4, jscolorInput("rect_midColor8", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			            column(4, jscolorInput("rect_highColor8", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			            br()
			    )
			),
			conditionalPanel(condition="input.plottype8=='heatmap_gradual'",
			                 selectInput("heatmapcol8", h5("Colors",
			                                   bsButton("bsb231", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb231", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			conditionalPanel(condition="input.heatmapcol8=='1'",
			    selectInput("colhmap8", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
	                                                      "purple.yellow.red", "blue.green.red", "blue.yellow.green",
	                                                      "cyan.white.deeppink1"), selected="blue.white.red")
			),
			conditionalPanel(condition="input.heatmapcol8=='2'",
			    fluidRow(
			        column(4, jscolorInput("lowColor8", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			        column(4, jscolorInput("midColor8", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			        column(4, jscolorInput("highColor8", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			        br()
			)			
			),
			conditionalPanel(condition="input.plottype8=='heatmap_discrete'",
			                 selectInput("colhmapdis8", h5("Data color",
			                                   bsButton("bsb232", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Random" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb232", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.colhmapdis8=='2'",
			    textInput("colhmapdiscus8", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype8=='vertical line' | input.plottype8=='horizontal line'",
			    fluidRow(column(12, jscolorInput("linecolor8", label = h5('Line color:',
			                                                              bsButton("bsb233", label="", icon=icon("question"), style="info", size="small")
			                                                              ), value = "#FF0000"))),
			    bsPopover("bsb233", 'The color to be used to plot the data.', trigger = "focus"),
                br()
			),
			conditionalPanel(condition="input.plottype8=='line'",
			                 selectInput("fillarea8", h5("Fill area",
			                                 bsButton("bsb234", label="", icon=icon("question"), style="info", size="small")
			                                 ), choices = c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb234", "Fill the area below the lines.", trigger = "focus"),
                conditionalPanel(condition="input.fillarea8=='1'",
			    radioButtons("selareatype8", h5("Area color",
			                                    bsButton("bsb235", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			    bsPopover("bsb235", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
				conditionalPanel(condition="input.selareatype8=='2'",
			        fluidRow(column(12, jscolorInput("borderarea8", label = NULL, value = "#0000FF"))),
                    br()
			)
		    )			
			),
			conditionalPanel(condition="input.plottype8=='point' | input.plottype8=='line' | input.plottype8=='bar' | input.plottype8=='rect_gradual' | input.plottype8=='rect_discrete' | input.plottype8=='heatmap_gradual' | input.plottype8=='heatmap_discrete' | input.plottype8=='vertical line' | input.plottype8=='horizontal line' | input.plottype8=='text' | input.plottype8 == 'segment'",
			                conditionalPanel(condition="input.plottype8=='text'",
			                    fluidRow(column(12, jscolorInput("textcol8", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
			                    br()
			                ),			                
			                selectInput("collgd8", h5("Color legend",
		                                   bsButton("bsb236", label="", icon=icon("question"), style="info", size="small")
		                                   ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb236", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.collgd8=='1'",
 				    textInput("collgdname8", h5("Legend title:",
 				                                bsButton("bsb237", label="", icon=icon("question"), style="info", size="small")
 				                                ), value="color"),
 				    bsPopover("bsb237", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
				    conditionalPanel(condition="input.plottype8!='rect_gradual' & input.plottype8!='heatmap_gradual'",
				                     selectInput("collgdmdylabel8", h5("Modify legend labels",
					                                       bsButton("bsb238", label="", icon=icon("question"), style="info", size="small")
					                                       ), c("Yes" = "1", "No" = "2"), "2"),
					    bsPopover("bsb238", 'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					    conditionalPanel(condition="input.collgdmdylabel8=='1'",
					        textInput("collgdlabel8", NULL, value="a,b,c")
					    )
				    )
                )				
			),
			conditionalPanel(condition="input.plottype8!='rect_gradual' & input.plottype8!='heatmap_gradual' & input.plottype8!='text'",
			    sliderInput("coltransparency8", h5("Color transparency:",
			                                       bsButton("bsb239", label="", icon=icon("question"), style="info", size="small")
			                                       ), min=0, max=1, value=1, step=0.1),
			    bsPopover("bsb239", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")										  
            )            
            ),  
			conditionalPanel(condition="input.plottype8=='line' | input.plottype8=='vertical line' | input.plottype8=='horizontal line' | input.plottype8 == 'segment'",
		    checkboxInput("linetype_opt8", HTML("<font color='red'>Linetype</font>"), FALSE),  
			conditionalPanel(condition="input.linetype_opt8",                         
            sliderInput("linesize8", "Line width:", min=0, max=3, value=0.2, step=0.05),
			selectInput("linetype8", h5("Line type",
			                            bsButton("bsb240", label="", icon=icon("question"), style="info", size="small")
			                            ), choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			    bsPopover("bsb240", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus"),
			conditionalPanel(condition="input.plottype8=='vertical line' | input.plottype8=='horizontal line'",
			                 selectInput("linetypelgd8", h5("Line type legend",
		                                        bsButton("bsb241", label="", icon=icon("question"), style="info", size="small")
		                                        ), c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb241", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.linetypelgd8=='1'",
 				    textInput("linetypelgdname8", h5("Legend title:",
 				                                     bsButton("bsb242", label="", icon=icon("question"), style="info", size="small")
 				                                     ), value="linetype"),
 				    bsPopover("bsb242", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("linetypelgdmdylabel8", h5("Modify legend labels",
					                                        bsButton("bsb243", label="", icon=icon("question"), style="info", size="small")
					                                        ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb243", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
					conditionalPanel(condition="input.linetypelgdmdylabel8=='1'",
						textInput("linetypelgdlabel8", NULL, value="a")
	                )
				)
			),
			conditionalPanel(condition="input.plottype8 == 'segment'",
			                 selectInput("addarrow8", h5("Add arrow head",
			                                 bsButton("bsb244", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb244", "Add arrow head for the segment.", trigger = "focus"),
			conditionalPanel(condition="input.addarrow8 == '1'",
			                 selectInput("arrowpos8", h5("Arrow position",
			                                 bsButton("bsb245", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Line end" = "1", "Line beginning" = "2"),selected="1"),
			    bsPopover("bsb245", 'The position of arrow head.',trigger = "focus"),
				sliderInput("arrowsize8", h5("Arrow size:",
				                             bsButton("bsb246", label="", icon=icon("question"), style="info", size="small")
				                             ), min=0, max=2, value=0.1, step=0.01),
				bsPopover("bsb246", 'The size of arrow head.',trigger = "focus")								
            )
			)
			)            
			),
			conditionalPanel(condition="input.plottype8=='point'",
				checkboxInput("symbol_opt8", HTML("<font color='red'>Symbol</font>"), FALSE), 
			    conditionalPanel(condition="input.symbol_opt8", 				
			                 selectInput("sel_symbolpoint8", h5("Symbol type",
                                                    bsButton("bsb247", label="", icon=icon("question"), style="info", size="small")
                                                    ), c("One custom symbol" = "1", 'Custom for data with a "shape" column' = "2"), selected="1"),
                bsPopover("bsb247", 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_symbolpoint8=='1'",
                    sliderInput("symbolpoint8", NULL, min=0, max=25, value=16, step=1)
                ),
                selectInput("shapelgd8", h5("Symbol legend",
		                                     bsButton("bsb248", label="", icon=icon("question"), style="info", size="small")
		                                     ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb248", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.shapelgd8=='1'",
 				    textInput("shapelgdname8", h5("Legend title:",
 				                                  bsButton("bsb249", label="", icon=icon("question"), style="info", size="small")
 				                                  ), value="symbol"),
 				    bsPopover("bsb249", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("shapelgdmdylabel8", h5("Modify legend labels",
					                                     bsButton("bsb250", label="", icon=icon("question"), style="info", size="small")
					                                     ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb250", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					conditionalPanel(condition="input.shapelgdmdylabel8=='1'",
						textInput("shapelgdlabel8", NULL, value="a,b,c")
	                )
				)
				),
				checkboxInput("size_opt8", HTML("<font color='red'>Size</font>"), FALSE),  
			    conditionalPanel(condition="input.size_opt8",  				
				selectInput("sel_pointsize8", h5("Point size",
                                                  bsButton("bsb251", label="", icon=icon("question"), style="info", size="small")
                                                  ), c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected="1"),
				bsPopover("bsb251", 'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_pointsize8=='1'",
                    sliderInput("pointsize8", NULL, min=0, max=5, value=0.8, step=0.1)
                ),
				selectInput("sizelgd8", h5("Size legend",
		                                    bsButton("bsb252", label="", icon=icon("question"), style="info", size="small")
		                                    ), choices = c("Show" = "1", "Hide" = "2"), "2"),
				bsPopover("bsb252", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.sizelgd8=='1'",
 				    textInput("sizelgdname8", h5("Legend title:",
 				                                 bsButton("bsb253", label="", icon=icon("question"), style="info", size="small")
 				                                 ), value="size"),
 				    bsPopover("bsb253", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("sizelgdmdylabel8", h5("Modify legend labels",
				                                        bsButton("bsb254", label="", icon=icon("question"), style="info", size="small")
				                                        ), c("Yes" = "1", "No" = "2"), "2"),
				    bsPopover("bsb254", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					conditionalPanel(condition="input.sizelgdmdylabel8=='1'",
						    textInput("sizelgdlabel8", NULL, value="a,b,c")
	                )
				)
				)				
            ),
			conditionalPanel(condition="input.plottype8=='heatmap_gradual' | input.plottype8=='heatmap_discrete' | input.plottype8=='rect_gradual' | input.plottype8=='rect_discrete' | input.plottype8=='bar'",
			                 selectInput("addborder8", h5("Add cell borders",
			                                  bsButton("bsb255", label="", icon=icon("question"), style="info", size="small")
			                                  ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb255", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
			    conditionalPanel(condition="input.addborder8=='1'",
                    fluidRow(column(12, jscolorInput("bordercols8", label = h5('Borders color:'), value = "#000000"))),
                    br()
					)
            ),
			conditionalPanel(condition="input.plottype8=='line' | input.plottype8=='point' | input.plottype8=='bar'",
			                 selectInput("ylabel8", h5("Y axis label",
	                                       bsButton("bsb257", label="", icon=icon("question"), style="info", size="small")
	                                       ), choices = c("Show" = "1", "Hide" = "2"), selected="1"),
	            bsPopover("bsb257", "Add tick labels on the Y-axis.", trigger = "focus")								
			),
			conditionalPanel(condition="input.plottype8=='text'",
		    	checkboxInput("font_opt8", HTML("<font color='red'>Font</font>"), FALSE),
			    conditionalPanel(condition="input.font_opt8",					
				    sliderInput("textsize8", "Font size:", min=0, max=10, value=2, step=0.1),
			        selectInput("fontface8", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
				    sliderInput("textangle8", "Font angle:", min=0, max=360, value=60, step=1)				
				)
			)
			)
			)
		   )
		),		
		checkboxInput("data9", HTML("<font color='red'>Data9</font>"), FALSE),
		conditionalPanel(condition="input.data9",
		  radioButtons("seluploaddata9", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		  conditionalPanel(condition="input.seluploaddata9 == '2'",
		    fileInput("uploaddata9", h5("Upload data9:",
		                                bsButton("bsb258", label="", icon=icon("question"), style="info", size="small")
		                                ), multiple = FALSE),
		    bsPopover("bsb258", 'Click "Browse" to upload the track data.', trigger = "focus"),
		    
		    actionButton("tabBut10", "View example data"),
			tags$script('$( "#uploaddata9" ).on( "click", function() { this.value = null; });'),
            downloadButton("example_data9.txt", "Example data"),
            br(),
			br(),
			selectInput("layerindex9", h5("Track index:",
			                              bsButton("bsb259", label="", icon=icon("question"), style="info", size="small")
			                              ), choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			bsPopover("bsb259", 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.', trigger = "focus"),
			selectInput("plottype9", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),
    	ADVANCED_OPTIONS_PANEL_9(
				list(
		    	checkboxInput("color_opt9", HTML("<font color='red'>Color</font>"), FALSE), 
			    conditionalPanel(condition="input.color_opt9", 					
				conditionalPanel(condition="input.plottype9 == 'point' | input.plottype9 == 'line' | input.plottype9 == 'bar' | input.plottype9 == 'segment'",
				                 selectInput("coltype9", h5("Data color",
			                                    bsButton("bsb260", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
			        bsPopover("bsb260", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', trigger = "focus"),
					conditionalPanel(condition="input.coltype9=='2'",
			            fluidRow(column(12, jscolorInput("colorcus9", label = NULL, value = "#FF0000"))),
                        br()			            			            
			         ),
                    conditionalPanel(condition="input.coltype9=='3'",
			            textInput("colormulgp9", NULL, value="a:red;b:blue;c:cyan")
	                )
				),
			conditionalPanel(condition="input.plottype9=='rect_discrete'",
			                 selectInput("rectcol9", h5("Data color",
			                                bsButton("bsb261", label="", icon=icon("question"), style="info", size="small")
			                                ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    bsPopover("bsb261", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.rectcol9=='2'",
			    fluidRow(column(12, jscolorInput("rectcoldis9", label = NULL, value = "#FF0000"))),
                br()
			),
			conditionalPanel(condition="input.rectcol9=='3'",
			    textInput("rectcoldiscus9", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype9=='rect_gradual'",
			                 selectInput("rectgrad_col9", h5("Colors",
			                                     bsButton("bsb262", label="", icon=icon("question"), style="info", size="small")
			                                     ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb262", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			    conditionalPanel(condition="input.rectgrad_col9=='1'",
			        selectInput("colrect9", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
			                                               "navy.cyan", "blue.red", "green.red"))
			    ),
			    conditionalPanel(condition="input.rectgrad_col9=='2'",
			        fluidRow(
			            column(4, jscolorInput("rect_lowColor9", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			            column(4, jscolorInput("rect_midColor9", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			            column(4, jscolorInput("rect_highColor9", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			            br()
			    )
			),
			conditionalPanel(condition="input.plottype9=='heatmap_gradual'",
			                 selectInput("heatmapcol9", h5("Colors",
			                                   bsButton("bsb263", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb263", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			conditionalPanel(condition="input.heatmapcol9=='1'",
			    selectInput("colhmap9", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
	                                                      "purple.yellow.red", "blue.green.red", "blue.yellow.green",
	                                                      "cyan.white.deeppink1"), selected="blue.white.red")
			),
			conditionalPanel(condition="input.heatmapcol9=='2'",
			    fluidRow(
			        column(4, jscolorInput("lowColor9", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			        column(4, jscolorInput("midColor9", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			        column(4, jscolorInput("highColor9", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			        br()
			)			
			),
			conditionalPanel(condition="input.plottype9=='heatmap_discrete'",
			                 selectInput("colhmapdis9", h5("Data color",
			                                   bsButton("bsb264", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Random" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb264", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.colhmapdis9=='2'",
			    textInput("colhmapdiscus9", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype9=='vertical line' | input.plottype9=='horizontal line'",
			    fluidRow(column(12, jscolorInput("linecolor9", label = h5('Line color:',
			                                                              bsButton("bsb265", label="", icon=icon("question"), style="info", size="small")
			                                                              ), value = "#FF0000"))),
			    bsPopover("bsb265", 'The color to be used to plot the data.', trigger = "focus"),
                br()
			),
			conditionalPanel(condition="input.plottype9=='line'",
			                 selectInput("fillarea9", h5("Fill area",
			                                 bsButton("bsb266", label="", icon=icon("question"), style="info", size="small")
			                                 ), choices = c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb266", "Fill the area below the lines.", trigger = "focus"),
                conditionalPanel(condition="input.fillarea9=='1'",
			    radioButtons("selareatype9", h5("Area color",
			                                    bsButton("bsb267", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			    bsPopover("bsb267", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
				conditionalPanel(condition="input.selareatype9=='2'",
			        fluidRow(column(12, jscolorInput("borderarea9", label = NULL, value = "#0000FF"))),
                    br()
			)
		    )			
			),
			conditionalPanel(condition="input.plottype9=='point' | input.plottype9=='line' | input.plottype9=='bar' | input.plottype9=='rect_gradual' | input.plottype9=='rect_discrete' | input.plottype9=='heatmap_gradual' | input.plottype9=='heatmap_discrete' | input.plottype9=='vertical line' | input.plottype9=='horizontal line' | input.plottype9=='text' | input.plottype9 == 'segment'",
			                conditionalPanel(condition="input.plottype9=='text'",
			                    fluidRow(column(12, jscolorInput("textcol9", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
			                    br()
			                ),			                
			                selectInput("collgd9", h5("Color legend",
		                                   bsButton("bsb268", label="", icon=icon("question"), style="info", size="small")
		                                   ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb268", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.collgd9=='1'",
 				    textInput("collgdname9", h5("Legend title:",
 				                                bsButton("bsb269", label="", icon=icon("question"), style="info", size="small")
 				                                ), value="color"),
 				    bsPopover("bsb269", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
				    conditionalPanel(condition="input.plottype9!='rect_gradual' & input.plottype9!='heatmap_gradual'",
				                     selectInput("collgdmdylabel9", h5("Modify legend labels",
					                                       bsButton("bsb270", label="", icon=icon("question"), style="info", size="small")
					                                       ), c("Yes" = "1", "No" = "2"), "2"),
					    bsPopover("bsb270", 'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					    conditionalPanel(condition="input.collgdmdylabel9=='1'",
					        textInput("collgdlabel9", NULL, value="a,b,c")
					    )
				    )
                )				
			),
			conditionalPanel(condition="input.plottype9!='rect_gradual' & input.plottype9!='heatmap_gradual' & input.plottype9!='text'",
			    sliderInput("coltransparency9", h5("Color transparency:",
			                                       bsButton("bsb271", label="", icon=icon("question"), style="info", size="small")
			                                       ), min=0, max=1, value=1, step=0.1),
			    bsPopover("bsb271", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")										  
            )         
            ),     
			conditionalPanel(condition="input.plottype9=='line' | input.plottype9=='vertical line' | input.plottype9=='horizontal line' | input.plottype9 == 'segment'",
		    checkboxInput("linetype_opt9", HTML("<font color='red'>Linetype</font>"), FALSE),  
			conditionalPanel(condition="input.linetype_opt9",                      
            sliderInput("linesize9", "Line width:", min=0, max=3, value=0.2, step=0.05),
			selectInput("linetype9", h5("Line type",
			                            bsButton("bsb272", label="", icon=icon("question"), style="info", size="small")
			                            ), choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			bsPopover("bsb272", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus"),
			conditionalPanel(condition="input.plottype9=='vertical line' | input.plottype9=='horizontal line'",
			                 selectInput("linetypelgd9", h5("Line type legend",
		                                        bsButton("bsb273", label="", icon=icon("question"), style="info", size="small")
		                                        ), c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb273", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.linetypelgd9=='1'",
 				    textInput("linetypelgdname9", h5("Legend title:",
 				                                     bsButton("bsb274", label="", icon=icon("question"), style="info", size="small")
 				                                     ), value="linetype"),
 				    bsPopover("bsb274", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("linetypelgdmdylabel9", h5("Modify legend labels",
					                                        bsButton("bsb275", label="", icon=icon("question"), style="info", size="small")
					                                        ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb275", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
					conditionalPanel(condition="input.linetypelgdmdylabel9=='1'",
						textInput("linetypelgdlabel9", NULL, value="a")
	                )
				)
			),
			conditionalPanel(condition="input.plottype9 == 'segment'",
			                 selectInput("addarrow9", h5("Add arrow head",
			                                 bsButton("bsb276", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb276", "Add arrow head for the segment.", trigger = "focus"),
			conditionalPanel(condition="input.addarrow9 == '1'",
			                 selectInput("arrowpos9", h5("Arrow position",
			                                 bsButton("bsb277", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Line end" = "1", "Line beginning" = "2"),selected="1"),
			    bsPopover("bsb277", 'The position of arrow head.',trigger = "focus"),
				sliderInput("arrowsize9", h5("Arrow size:",
				                             bsButton("bsb278", label="", icon=icon("question"), style="info", size="small")
				                             ), min=0, max=2, value=0.1, step=0.01),
				bsPopover("bsb278", 'The size of arrow head.',trigger = "focus")								
            )
			)
			)            
			),
			conditionalPanel(condition="input.plottype9=='point'",
				checkboxInput("symbol_opt9", HTML("<font color='red'>Symbol</font>"), FALSE), 
			    conditionalPanel(condition="input.symbol_opt9", 				
			                 selectInput("sel_symbolpoint9", h5("Symbol type",
                                                    bsButton("bsb279", label="", icon=icon("question"), style="info", size="small")
                                                    ), c("One custom symbol" = "1", 'Custom for data with a "shape" column' = "2"), selected="1"),
                bsPopover("bsb279", 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_symbolpoint9=='1'",
                    sliderInput("symbolpoint9", NULL, min=0, max=25, value=16, step=1)
                ),
                selectInput("shapelgd9", h5("Symbol legend",
		                                     bsButton("bsb280", label="", icon=icon("question"), style="info", size="small")
		                                     ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb280", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.shapelgd9=='1'",
 				    textInput("shapelgdname9", h5("Legend title:",
 				                                  bsButton("bsb281", label="", icon=icon("question"), style="info", size="small")
 				                                  ), value="symbol"),
 				    bsPopover("bsb281", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("shapelgdmdylabel9", h5("Modify legend labels",
					                                     bsButton("bsb282", label="", icon=icon("question"), style="info", size="small")
					                                     ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb282", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					conditionalPanel(condition="input.shapelgdmdylabel9=='1'",
						textInput("shapelgdlabel9", NULL, value="a,b,c")
	                )
				)
				),
				checkboxInput("size_opt9", HTML("<font color='red'>Size</font>"), FALSE),  
			    conditionalPanel(condition="input.size_opt9",  				
				selectInput("sel_pointsize9", h5("Point size",
                                                  bsButton("bsb283", label="", icon=icon("question"), style="info", size="small")
                                                  ), c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected="1"),
				bsPopover("bsb283", 'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_pointsize9=='1'",
                    sliderInput("pointsize9", NULL, min=0, max=5, value=0.8, step=0.1)
                ),
				selectInput("sizelgd9", h5("Size legend",
		                                    bsButton("bsb284", label="", icon=icon("question"), style="info", size="small")
		                                    ), choices = c("Show" = "1", "Hide" = "2"), "2"),
				bsPopover("bsb284", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.sizelgd9=='1'",
 				    textInput("sizelgdname9", h5("Legend title:",
 				                                 bsButton("bsb285", label="", icon=icon("question"), style="info", size="small")
 				                                 ), value="size"),
 				    bsPopover("bsb285", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("sizelgdmdylabel9", h5("Modify legend labels",
				                                        bsButton("bsb286", label="", icon=icon("question"), style="info", size="small")
				                                        ), c("Yes" = "1", "No" = "2"), "2"),
				    bsPopover("bsb286", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					conditionalPanel(condition="input.sizelgdmdylabel9=='1'",
						    textInput("sizelgdlabel9", NULL, value="a,b,c")
	                )
				)
				)				
            ),
			conditionalPanel(condition="input.plottype9=='heatmap_gradual' | input.plottype9=='heatmap_discrete' | input.plottype9=='rect_gradual' | input.plottype9=='rect_discrete' | input.plottype9=='bar'",
			                 selectInput("addborder9", h5("Add cell borders",
			                                  bsButton("bsb287", label="", icon=icon("question"), style="info", size="small")
			                                  ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb287", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
			    conditionalPanel(condition="input.addborder9=='1'",
                    fluidRow(column(12, jscolorInput("bordercols9", label = h5('Borders color:'), value = "#000000"))),
                    br()
					)
            ),
			conditionalPanel(condition="input.plottype9=='line' | input.plottype9=='point' | input.plottype9=='bar'",
			                 selectInput("ylabel9", h5("Y axis label",
	                                       bsButton("bsb289", label="", icon=icon("question"), style="info", size="small")
	                                       ), choices = c("Show" = "1", "Hide" = "2"), selected="1"),
	            bsPopover("bsb289", "Add tick labels on the Y-axis.", trigger = "focus")								
			),
			conditionalPanel(condition="input.plottype9=='text'",
		    	checkboxInput("font_opt9", HTML("<font color='red'>Font</font>"), FALSE),
			    conditionalPanel(condition="input.font_opt9",					
				    sliderInput("textsize9", "Font size:", min=0, max=10, value=2, step=0.1),
			        selectInput("fontface9", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
				    sliderInput("textangle9", "Font angle:", min=0, max=360, value=60, step=1)				
				)
			)
			)
			)
		   )
		),
		checkboxInput("data10", HTML("<font color='red'>Data10</font>"), FALSE),
		conditionalPanel(condition="input.data10",
		  radioButtons("seluploaddata10", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		  conditionalPanel(condition="input.seluploaddata10 == '2'",
		    fileInput("uploaddata10", h5("Upload data10:",
		                                 bsButton("bsb290", label="", icon=icon("question"), style="info", size="small")
		                                 ), multiple = FALSE),
		    bsPopover("bsb290", 'Click "Browse" to upload the track data.', trigger = "focus"),
		    
		    actionButton("tabBut11", "View example data"),
			tags$script('$( "#uploaddata10" ).on( "click", function() { this.value = null; });'),
            downloadButton("example_data10.txt", "Example data"),
            br(),
			br(),
			selectInput("layerindex10", h5("Track index:",
			                               bsButton("bsb291", label="", icon=icon("question"), style="info", size="small")
			                               ), choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			bsPopover("bsb291", 'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks.', trigger = "focus"),
			selectInput("plottype10", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),
    	ADVANCED_OPTIONS_PANEL_10(
				list(
		    	checkboxInput("color_opt10", HTML("<font color='red'>Color</font>"), FALSE), 
			    conditionalPanel(condition="input.color_opt10", 					
				conditionalPanel(condition="input.plottype10 == 'point' | input.plottype10 == 'line' | input.plottype10 == 'bar' | input.plottype10 == 'segment'",
				                 selectInput("coltype10", h5("Data color",
			                                     bsButton("bsb292", label="", icon=icon("question"), style="info", size="small")
			                                     ), c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
			        bsPopover("bsb292", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', trigger = "focus"),
					conditionalPanel(condition="input.coltype10=='2'",
			            fluidRow(column(12, jscolorInput("colorcus10", label = NULL, value = "#FF0000"))),
                        br()			            			            
			         ),
                    conditionalPanel(condition="input.coltype10=='3'",
			            textInput("colormulgp10", NULL, value="a:red;b:blue;c:cyan")
	                )
				),
			conditionalPanel(condition="input.plottype10=='rect_discrete'",
			                 selectInput("rectcol10", h5("Data color",
			                                 bsButton("bsb293", label="", icon=icon("question"), style="info", size="small")
			                                 ), c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    bsPopover("bsb293", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.rectcol10=='2'",
			    fluidRow(column(12, jscolorInput("rectcoldis10", label = NULL, value = "#FF0000"))),
                br()
			),
			conditionalPanel(condition="input.rectcol10=='3'",
			    textInput("rectcoldiscus10", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype10=='rect_gradual'",
			                 selectInput("rectgrad_col10", h5("Colors",
			                                      bsButton("bsb294", label="", icon=icon("question"), style="info", size="small")
			                                      ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb294", "Colors to be used for the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			    conditionalPanel(condition="input.rectgrad_col10=='1'",
			        selectInput("colrect10", NULL, choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange",
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold",
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange",
			                                               "navy.cyan", "blue.red", "green.red"))
			    ),
			    conditionalPanel(condition="input.rectgrad_col10=='2'",
			        fluidRow(
			            column(4, jscolorInput("rect_lowColor10", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			            column(4, jscolorInput("rect_midColor10", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			            column(4, jscolorInput("rect_highColor10", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			            br()
			    )
			),
			conditionalPanel(condition="input.plottype10=='heatmap_gradual'",
			                 selectInput("heatmapcol10", h5("Colors",
			                                    bsButton("bsb295", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb295", "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			conditionalPanel(condition="input.heatmapcol10=='1'",
			    selectInput("colhmap10", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
	                                                      "purple.yellow.red", "blue.green.red", "blue.yellow.green",
	                                                      "cyan.white.deeppink1"), selected="blue.white.red")
			),
			conditionalPanel(condition="input.heatmapcol10=='2'",
			    fluidRow(
			        column(4, jscolorInput("lowColor10", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			        column(4, jscolorInput("midColor10", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			        column(4, jscolorInput("highColor10", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			        br()
			)			
			),
			conditionalPanel(condition="input.plottype10=='heatmap_discrete'",
			                 selectInput("colhmapdis10", h5("Data color",
			                                    bsButton("bsb296", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Random" = "1", "Custom" = "2"), selected="1"),
			    bsPopover("bsb296", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set as NULL. Hex color codes as "#FF0000" are also supported.', trigger = "focus"),
			conditionalPanel(condition="input.colhmapdis10=='2'",
			    textInput("colhmapdiscus10", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype10=='vertical line' | input.plottype10=='horizontal line'",
			    fluidRow(column(12, jscolorInput("linecolor10", label = h5('Line color:',
			                                                               bsButton("bsb297", label="", icon=icon("question"), style="info", size="small")
			                                                               ), value = "#FF0000"))),
			    bsPopover("bsb297", 'The color to be used to plot the data.', trigger = "focus"),
                br()
			),
			conditionalPanel(condition="input.plottype10=='line'",
			                 selectInput("fillarea10", h5("Fill area",
			                                  bsButton("bsb298", label="", icon=icon("question"), style="info", size="small")
			                                  ), choices = c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb298", "Fill the area below the lines.", trigger = "focus"),
                conditionalPanel(condition="input.fillarea10=='1'",
			    radioButtons("selareatype10", h5("Area color",
			                                     bsButton("bsb299", label="", icon=icon("question"), style="info", size="small")
			                                     ), c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			    bsPopover("bsb299", 'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', trigger = "focus"),
				conditionalPanel(condition="input.selareatype10=='2'",
			        fluidRow(column(12, jscolorInput("borderarea10", label = NULL, value = "#0000FF"))),
                    br()
			)
		    )			
			),
			conditionalPanel(condition="input.plottype10=='point' | input.plottype10=='line' | input.plottype10=='bar' | input.plottype10=='rect_gradual' | input.plottype10=='rect_discrete' | input.plottype10=='heatmap_gradual' | input.plottype10=='heatmap_discrete' | input.plottype10=='vertical line' | input.plottype10=='horizontal line' | input.plottype10=='text' | input.plottype10 == 'segment'",
			                conditionalPanel(condition="input.plottype10=='text'",
			                    fluidRow(column(12, jscolorInput("textcol10", label = HTML('<p><font size="3.0"><strong>Font color:</strong></font></p>'), value = "#000000"))),
			                    br()
			                ),			                
			                selectInput("collgd10", h5("Color legend",
		                                    bsButton("bsb300", label="", icon=icon("question"), style="info", size="small")
		                                    ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb300", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.collgd10=='1'",
 				    textInput("collgdname10", h5("Legend title:",
 				                                 bsButton("bsb301", label="", icon=icon("question"), style="info", size="small")
 				                                 ), value="color"),
 				    bsPopover("bsb301", "Title of the color legend. Null value will result in an empty title.", trigger = "focus"),
				    conditionalPanel(condition="input.plottype10!='rect_gradual' & input.plottype10!='heatmap_gradual'",
				                     selectInput("collgdmdylabel10", h5("Modify legend labels",
					                                        bsButton("bsb302", label="", icon=icon("question"), style="info", size="small")
					                                        ), c("Yes" = "1", "No" = "2"), "2"),
					    bsPopover("bsb302", 'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					    conditionalPanel(condition="input.collgdmdylabel10=='1'",
					        textInput("collgdlabel10", NULL, value="a,b,c")
					    )
				    )
                )				
			),
			conditionalPanel(condition="input.plottype10!='rect_gradual' & input.plottype10!='heatmap_gradual' & input.plottype10!='text'",
			    sliderInput("coltransparency10", h5("Color transparency:",
			                                        bsButton("bsb303", label="", icon=icon("question"), style="info", size="small")
			                                        ), min=0, max=1, value=1, step=0.1),
			    bsPopover("bsb303", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")										  
            )          
            ),    
			conditionalPanel(condition="input.plottype10=='line' | input.plottype10=='vertical line' | input.plottype10=='horizontal line' | input.plottype10 == 'segment'",
		    checkboxInput("linetype_opt10", HTML("<font color='red'>Linetype</font>"), FALSE),  
			conditionalPanel(condition="input.linetype_opt10",                        
            sliderInput("linesize10", "Line width:", min=0, max=3, value=0.2, step=0.05),
			selectInput("linetype10", h5("Line type",
			                             bsButton("bsb304", label="", icon=icon("question"), style="info", size="small")
			                             ), choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			bsPopover("bsb304", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus"),
			conditionalPanel(condition="input.plottype10=='vertical line' | input.plottype10=='horizontal line'",
			                 selectInput("linetypelgd10", h5("Line type legend",
		                                         bsButton("bsb305", label="", icon=icon("question"), style="info", size="small")
		                                         ), c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb305", "Control the appearance of the line type legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.linetypelgd10=='1'",
 				    textInput("linetypelgdname10", h5("Legend title:",
 				                                      bsButton("bsb306", label="", icon=icon("question"), style="info", size="small")
 				                                      ), value="linetype"),
 				    bsPopover("bsb306", "Title of line type legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("linetypelgdmdylabel10", h5("Modify legend labels",
					                                         bsButton("bsb307", label="", icon=icon("question"), style="info", size="small")
					                                         ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb307", 'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', trigger = "focus"),
					conditionalPanel(condition="input.linetypelgdmdylabel10=='1'",
						textInput("linetypelgdlabel10", NULL, value="a")
	                )
				)
			),
			conditionalPanel(condition="input.plottype10 == 'segment'",
			                 selectInput("addarrow10", h5("Add arrow head",
			                                  bsButton("bsb308", label="", icon=icon("question"), style="info", size="small")
			                                  ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb308", "Add arrow head for the segment.", trigger = "focus"),
			conditionalPanel(condition="input.addarrow10 == '1'",
			                 selectInput("arrowpos10", h5("Arrow position",
			                                  bsButton("bsb309", label="", icon=icon("question"), style="info", size="small")
			                                  ), c("Line end" = "1", "Line beginning" = "2"),selected="1"),
			    bsPopover("bsb309", 'The position of arrow head.',trigger = "focus"),
				sliderInput("arrowsize10", h5("Arrow size:",
				                              bsButton("bsb310", label="", icon=icon("question"), style="info", size="small")
				                              ), min=0, max=2, value=0.1, step=0.01),
				bsPopover("bsb310", 'The size of arrow head.',trigger = "focus")								
            )
			)
			)
			),
			conditionalPanel(condition="input.plottype10=='point'",
				checkboxInput("symbol_opt10", HTML("<font color='red'>Symbol</font>"), FALSE), 
			    conditionalPanel(condition="input.symbol_opt10", 				
			                 selectInput("sel_symbolpoint10", h5("Symbol type",
                                                     bsButton("bsb311", label="", icon=icon("question"), style="info", size="small")
                                                     ), c("One custom symbol" = "1", 'Custom for data with a "shape" column' = "2"), selected="1"),
                bsPopover("bsb311", 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_symbolpoint10=='1'",
                    sliderInput("symbolpoint10", NULL, min=0, max=25, value=16, step=1)
                ),
                selectInput("shapelgd10", h5("Symbol legend",
		                                      bsButton("bsb312", label="", icon=icon("question"), style="info", size="small")
		                                      ), choices = c("Show" = "1", "Hide" = "2"), "2"),
		        bsPopover("bsb312", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.shapelgd10=='1'",
 				    textInput("shapelgdname10", h5("Legend title:",
 				                                   bsButton("bsb313", label="", icon=icon("question"), style="info", size="small")
 				                                   ), value="symbol"),
 				    bsPopover("bsb313", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("shapelgdmdylabel10", h5("Modify legend labels",
					                                      bsButton("bsb314", label="", icon=icon("question"), style="info", size="small")
					                                      ), c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb314", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					conditionalPanel(condition="input.shapelgdmdylabel10=='1'",
						textInput("shapelgdlabel10", NULL, value="a,b,c")
	                )
				)
				),
				checkboxInput("size_opt10", HTML("<font color='red'>Size</font>"), FALSE),  
			    conditionalPanel(condition="input.size_opt10",  				
				selectInput("sel_pointsize10", h5("Point size",
                                                   bsButton("bsb315", label="", icon=icon("question"), style="info", size="small")
                                                   ), c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected="1"),
				bsPopover("bsb315", 'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', trigger = "focus"),
                conditionalPanel(condition="input.sel_pointsize10=='1'",
                    sliderInput("pointsize10", NULL, min=0, max=5, value=0.8, step=0.1)
                ),
				selectInput("sizelgd10", h5("Size legend",
		                                     bsButton("bsb316", label="", icon=icon("question"), style="info", size="small")
		                                     ), choices = c("Show" = "1", "Hide" = "2"), "2"),
				bsPopover("bsb316", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
			    conditionalPanel(condition="input.sizelgd10=='1'",
 				    textInput("sizelgdname10", h5("Legend title:",
 				                                  bsButton("bsb317", label="", icon=icon("question"), style="info", size="small")
 				                                  ), value="size"),
 				    bsPopover("bsb317", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
 				    selectInput("sizelgdmdylabel10", h5("Modify legend labels",
				                                         bsButton("bsb318", label="", icon=icon("question"), style="info", size="small")
				                                         ), c("Yes" = "1", "No" = "2"), "2"),
				    bsPopover("bsb318", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
					conditionalPanel(condition="input.sizelgdmdylabel10=='1'",
						    textInput("sizelgdlabel10", NULL, value="a,b,c")
	                )
				)
				)
            ),
			conditionalPanel(condition="input.plottype10=='heatmap_gradual' | input.plottype10=='heatmap_discrete' | input.plottype10=='rect_gradual' | input.plottype10=='rect_discrete' | input.plottype10=='bar'",
			                 selectInput("addborder10", h5("Add cell borders",
			                                   bsButton("bsb319", label="", icon=icon("question"), style="info", size="small")
			                                   ), c("Yes" = "1", "No" = "2"),selected="2"),
			    bsPopover("bsb319", "Add borders to the grids, which can be used to separate cells from each other.", trigger = "focus"),
			    conditionalPanel(condition="input.addborder10=='1'",
                    fluidRow(column(12, jscolorInput("bordercols10", label = h5('Borders color:'), value = "#000000"))),
                    br()
					)
            ),
			conditionalPanel(condition="input.plottype10=='line' | input.plottype10=='point' | input.plottype10=='bar'",
			                 selectInput("ylabel10", h5("Y axis label",
	                                        bsButton("bsb321", label="", icon=icon("question"), style="info", size="small")
	                                        ), choices = c("Show" = "1", "Hide" = "2"), selected="1"),
	            bsPopover("bsb321", "Add tick labels on the Y-axis.", trigger = "focus")								
			),
			conditionalPanel(condition="input.plottype10=='text'",
		    	checkboxInput("font_opt10", HTML("<font color='red'>Font</font>"), FALSE),
			    conditionalPanel(condition="input.font_opt10",					
				    sliderInput("textsize10", "Font size:", min=0, max=10, value=2, step=0.1),
			        selectInput("fontface10", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
				    sliderInput("textangle10", "Font angle:", min=0, max=360, value=60, step=1)				
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
			            selectInput("themestyle", NULL, choices = c("theme1", "theme2", "theme3",
	                                                      "theme4", "theme5", "theme6",
	                                                      "theme7","theme8","theme9","theme10"), selected="theme1")
														  ),
                    checkboxInput("selfontsize", "Font size", FALSE),
                    conditionalPanel(condition = "input.selfontsize",
			  		    sliderInput("fontSize", NULL, min=0, max=50, value=16, step=0.5)        
									),
                    checkboxInput("addtitle", "Axis title", FALSE),
                    conditionalPanel(condition = "input.addtitle",
                        textInput("xtitle", "X axis title:", value="Genomic position"),
			            textInput("ytitle", "Y axis title:", value="Value"),
			            selectInput("titlefontface", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain")
														  ),
                    checkboxInput("addlabels", "X axis label", FALSE),
                    conditionalPanel(condition = "input.addlabels",
                                     selectInput("xlabel", NULL, choices = c("Show" = "1", "Hide" = "2"), selected="1")
					),
                    checkboxInput("legends", "Legend", FALSE),
                    conditionalPanel(condition = "input.legends",
                                     selectInput("legendpos", h5("Legend position",
			                                                bsButton("bsb326", label="", icon=icon("question"), style="info", size="small")
			                                                ), c("Right" = "1", "Bottom" = "2"), selected="1"),
			            bsPopover("bsb326", "The position to place the legend.", trigger = "focus"),
						sliderInput("lgdspacesize", h5("Legend region size",
						                               bsButton("bsb327", label="", icon=icon("question"), style="info", size="small")
						                               ), min=0, max=1, value=0.04, step=0.01),
						bsPopover("bsb327", "Percent of legend size relative to the main plotting region. Applicable values are numbers in [0-1].", trigger = "focus"),
						sliderInput("lgdintrasize", h5("Intra-spacing",
						                               bsButton("bsb328", label="", icon=icon("question"), style="info", size="small")
						                               ), min=0, max=150, value=15, step=0.5),
						bsPopover("bsb328", "Intra-spacing between different legends.", trigger = "focus"),
			            sliderInput("lgdtitlesize", h5("Title font size",
			                                           bsButton("bsb329", label="", icon=icon("question"), style="info", size="small")
			                                           ), min=0, max=40, value=12, step=0.1),
						bsPopover("bsb329", "The font size of legend title.", trigger = "focus"),
			            selectInput("lgdtitlefontface", h5("Title font face:",
			                                               bsButton("bsb330", label="", icon=icon("question"), style="info", size="small")
			                                               ), choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
						bsPopover("bsb330", "The font face of legend title.", trigger = "focus"),
						sliderInput("lgdtextsize", h5("Label font size",
						                              bsButton("bsb331", label="", icon=icon("question"), style="info", size="small")
						                              ), min=0, max=40, value=10, step=0.1),
						bsPopover("bsb331", "The font size of legend tick label.", trigger = "focus"),
						selectInput("lgdtextfontface", h5("Label font face:",
						                                  bsButton("bsb332", label="", icon=icon("question"), style="info", size="small")
						                                  ), choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
						bsPopover("bsb332", "The font face of legend tick label.", trigger = "focus")
					),
					checkboxInput("layer1", HTML("<font color='red'>Track1</font>"), FALSE),
			            conditionalPanel(condition="input.layer1",
						        sliderInput("heightlayer1", h5("Track height:",
						                                       bsButton("bsb333", label="", icon=icon("question"), style="info", size="small")
						                                       ), min=0, max=5, value=0.06, step=0.01),
						        bsPopover("bsb333", "Height of the track.", trigger = "focus"),
			                    sliderInput("marginlayer1", h5("Track margin:",
			                                                   bsButton("bsb334", label="", icon=icon("question"), style="info", size="small")
			                                                   ), min=0, max=5, value=0.01, step=0.005),
						        bsPopover("bsb334", "Margin size of the track.", trigger = "focus")	
						),
					checkboxInput("layer2", HTML("<font color='red'>Track2</font>"), FALSE),
			            conditionalPanel(condition="input.layer2",
						        sliderInput("heightlayer2", h5("Track height:",
						                                       bsButton("bsb335", label="", icon=icon("question"), style="info", size="small")
						                                       ), min=0, max=5, value=0.06, step=0.01),
						        bsPopover("bsb335", "Height of the track.", trigger = "focus"),
			                    sliderInput("marginlayer2", h5("Track margin:",
			                                                   bsButton("bsb336", label="", icon=icon("question"), style="info", size="small")
			                                                   ), min=0, max=5, value=0.01, step=0.005),
						        bsPopover("bsb336", "Margin size of the track.", trigger = "focus")
						),
					checkboxInput("layer3", HTML("<font color='red'>Track3</font>"), FALSE),
			            conditionalPanel(condition="input.layer3",
						        sliderInput("heightlayer3", h5("Track height:",
						                                       bsButton("bsb337", label="", icon=icon("question"), style="info", size="small")
						                                       ), min=0, max=5, value=0.06, step=0.01),
						        bsPopover("bsb337", "Height of the track.", trigger = "focus"),
			                    sliderInput("marginlayer3", h5("Track margin:",
			                                                   bsButton("bsb338", label="", icon=icon("question"), style="info", size="small")
			                                                   ), min=0, max=5, value=0.01, step=0.005),
						        bsPopover("bsb338", "Margin size of the track.", trigger = "focus")
						),
					checkboxInput("layer4", HTML("<font color='red'>Track4</font>"), FALSE),
			            conditionalPanel(condition="input.layer4",
						        sliderInput("heightlayer4", h5("Track height:",
						                                       bsButton("bsb339", label="", icon=icon("question"), style="info", size="small")
						                                       ), min=0, max=5, value=0.06, step=0.01),
						        bsPopover("bsb339", "Height of the track.", trigger = "focus"),
			                    sliderInput("marginlayer4", h5("Track margin:",
			                                                   bsButton("bsb340", label="", icon=icon("question"), style="info", size="small")
			                                                   ), min=0, max=5, value=0.01, step=0.005),
						        bsPopover("bsb340", "Margin size of the track.", trigger = "focus")
						),
					checkboxInput("layer5", HTML("<font color='red'>Track5</font>"), FALSE),
			            conditionalPanel(condition="input.layer5",
						        sliderInput("heightlayer5", h5("Track height:",
						                                       bsButton("bsb341", label="", icon=icon("question"), style="info", size="small")
						                                       ), min=0, max=5, value=0.06, step=0.01),
						        bsPopover("bsb341", "Height of the track.", trigger = "focus"),
			                    sliderInput("marginlayer5", h5("Track margin:",
			                                                   bsButton("bsb342", label="", icon=icon("question"), style="info", size="small")
			                                                   ), min=0, max=5, value=0.01, step=0.005),
						        bsPopover("bsb342", "Margin size of the track.", trigger = "focus")
						),
					checkboxInput("layer6", HTML("<font color='red'>Track6</font>"), FALSE),
			            conditionalPanel(condition="input.layer6",
						        sliderInput("heightlayer6", h5("Track height:",
						                                       bsButton("bsb343", label="", icon=icon("question"), style="info", size="small")
						                                       ), min=0, max=5, value=0.06, step=0.01),
						        bsPopover("bsb343", "Height of the track.", trigger = "focus"),
			                    sliderInput("marginlayer6", h5("Track margin:",
			                                                   bsButton("bsb344", label="", icon=icon("question"), style="info", size="small")
			                                                   ), min=0, max=5, value=0.01, step=0.005),
						        bsPopover("bsb344", "Margin size of the track.", trigger = "focus")
						),
					checkboxInput("layer7", HTML("<font color='red'>Track7</font>"), FALSE),
			            conditionalPanel(condition="input.layer7",
						        sliderInput("heightlayer7", h5("Track height:",
						                                       bsButton("bsb345", label="", icon=icon("question"), style="info", size="small")
						                                       ), min=0, max=5, value=0.06, step=0.01),
						        bsPopover("bsb345", "Height of the track.", trigger = "focus"),
			                    sliderInput("marginlayer7", h5("Track margin:",
			                                                   bsButton("bsb346", label="", icon=icon("question"), style="info", size="small")
			                                                   ), min=0, max=5, value=0.01, step=0.005),
						        bsPopover("bsb346", "Margin size of the track.", trigger = "focus")
						),
					checkboxInput("layer8", HTML("<font color='red'>Track8</font>"), FALSE),
			            conditionalPanel(condition="input.layer8",
						        sliderInput("heightlayer8", h5("Track height:",
						                                       bsButton("bsb347", label="", icon=icon("question"), style="info", size="small")
						                                       ), min=0, max=5, value=0.06, step=0.01),
						        bsPopover("bsb347", "Height of the track.", trigger = "focus"),
			                    sliderInput("marginlayer8", h5("Track margin:",
			                                                   bsButton("bsb348", label="", icon=icon("question"), style="info", size="small")
			                                                   ), min=0, max=5, value=0.01, step=0.005),
						        bsPopover("bsb348", "Margin size of the track.", trigger = "focus")
						),
					checkboxInput("layer9", HTML("<font color='red'>Track9</font>"), FALSE),
			            conditionalPanel(condition="input.layer9",
						        sliderInput("heightlayer9", h5("Track height:",
						                                       bsButton("bsb349", label="", icon=icon("question"), style="info", size="small")
						                                       ), min=0, max=5, value=0.06, step=0.01),
						        bsPopover("bsb349", "Height of the track.", trigger = "focus"),
			                    sliderInput("marginlayer9", h5("Track margin:",
			                                                   bsButton("bsb350", label="", icon=icon("question"), style="info", size="small")
			                                                   ), min=0, max=5, value=0.01, step=0.005),
						        bsPopover("bsb350", "Margin size of the track.", trigger = "focus")
						),
					checkboxInput("layer10", HTML("<font color='red'>Track10</font>"), FALSE),
			            conditionalPanel(condition="input.layer10",
						        sliderInput("heightlayer10", h5("Track height:",
						                                        bsButton("bsb351", label="", icon=icon("question"), style="info", size="small")
						                                        ), min=0, max=5, value=0.06, step=0.01),
						        bsPopover("bsb351", "Height of the track.", trigger = "focus"),
			                    sliderInput("marginlayer10", h5("Track margin:",
			                                                    bsButton("bsb352", label="", icon=icon("question"), style="info", size="small")
			                                                    ), min=0, max=5, value=0.01, step=0.005),
						        bsPopover("bsb352", "Margin size of the track.", trigger = "focus")
						)
		        )
		)
      ),
		
      mainPanel(id = "mainPanel_1",
          downloadButton("Visualization_1.pdf", "Download pdf-file"),
          downloadButton("Visualization_1.svg", "Download svg-file"),
		      downloadButton("Script_1.R", "Download the R scripts to reproduce the plot"),
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
       "Two genomes plot",tags$head(
			tags$style("
                input[type='file'] {width:5em;}
				.toggleButton {width:100%;} 
                .clearButton {float:right; font-size:12px;}
				.fa-angle-down:before, .fa-angle-up:before {float:right;}
				.popover{text-align:left;width:500px;background-color:#000000;}
				.popover-title{color:#FFFFFF;font-size:16px;background-color:#000000;border-color:#000000;}
				#sidebarPanel_2 {width:25em;}
				#tc_lowColor, #tc_midColor, #tc_highColor, #tc_colorcus, #tc_bordercols, #tc_verticalcol, #tc_horizontalcol {width:100%}
				#mainPanel_2 {left:28em; position:absolute; min-width:27em;}"),
			 tags$style(HTML(".shiny-output-error-validation {color: red;}")),
             tags$script(HTML('Shiny.addCustomMessageHandler("jsCode",function(message) {eval(message.value);});')), includeScript("www/google-analytics.js")				
		),
        sidebarPanel(id="sidebarPanel_2",
	        fileInput("tc_uploadchrdata_1", h5("*Upload genome1 data:",
	                                           bsButton("bsb353", label="", icon=icon("question"), style="info", size="small")
	                                           ), multiple = FALSE),
	        bsPopover("bsb353", 'Click "Browse" to upload the genome data aligned along the X-axis.', trigger = "focus"),
	        
	        actionButton("tabBut12", "View example data"),
		    tags$script('$( "#tc_uploadchrdata_1" ).on( "click", function() { this.value = null; });'),
            downloadButton("genome1_data.txt", "Example data"),
            br(),
		    br(),
	        fileInput("tc_uploadchrdata_2", h5("*Upload genome2 data:",
	                                           bsButton("bsb354", label="", icon=icon("question"), style="info", size="small")
	                                           ), multiple = FALSE),
		    bsPopover("bsb354", 'Click "Browse" to upload the genome data aligned along the Y-axis.', trigger = "focus"),
		    
		    actionButton("tabBut13", "View example data"),
		    tags$script('$( "#tc_uploadchrdata_2" ).on( "click", function() { this.value = null; });'),
            downloadButton("genome2_data.txt", "Example data"),
            br(),
		    br(),
	        fileInput("tc_uploaddata", h5("*Upload main plot data:",
	                                      bsButton("bsb355", label="", icon=icon("question"), style="info", size="small")
	                                      ), multiple = FALSE),
		    bsPopover("bsb355", 'Click "Browse" to upload data for the main plot.', trigger = "focus"),
		    
		    actionButton("tabBut14", "View example data"),
		    tags$script('$( "#tc_uploaddata" ).on( "click", function() { this.value = null; });'),
			downloadButton("example_plot_data.txt", "Example data"),
            br(),
		    br(),
			selectInput("tc_plottype", "Plot type:", choices = c("point_gradual", "point_discrete", "segment" , "rect_gradual", "rect_discrete"), selected="point_gradual"),
         	ADVANCED_OPTIONS_PANEL_tc(
	  	        list(
		    	checkboxInput("color_opt_tc", HTML("<font color='red'>Color</font>"), FALSE), 
			    conditionalPanel(condition="input.color_opt_tc", 	  	        	
			        conditionalPanel(condition="input.tc_plottype=='point_gradual' | input.tc_plottype=='rect_gradual'",
			                         selectInput("tc_selgralcol", h5("Colors",
			                                             bsButton("bsb356", label="", icon=icon("question"), style="info", size="small")
			                                             ), c("Typical" = "1", "Custom" = "2"), selected="1"),
			            bsPopover("bsb356", "Colors to be used to plot the data, which can be assigned by the application or be specified by the users.", trigger = "focus"),
			            conditionalPanel(condition="input.tc_selgralcol=='1'",
			                selectInput("tc_gralcol", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
	                                                      "purple.yellow.red", "blue.green.red", "blue.yellow.green",
	                                                      "cyan.white.deeppink1"), selected="blue.white.red")
			            ),
			        conditionalPanel(condition="input.tc_selgralcol=='2'",
			            fluidRow(
			            column(4, jscolorInput("tc_lowColor", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB")),
			            column(4, jscolorInput("tc_midColor", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF")),
			            column(4, jscolorInput("tc_highColor", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00"))),
			            br()
			        )			
			        ),
			        conditionalPanel(condition="input.tc_plottype=='point_discrete' | input.tc_plottype=='segment' | input.tc_plottype=='rect_discrete'",
			                         selectInput("tc_coltype", h5("Data color",
			                                          bsButton("bsb357", label="", icon=icon("question"), style="info", size="small")
			                                          ), c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
			            bsPopover("bsb357", 'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', trigger = "focus"),
					    conditionalPanel(condition="input.tc_coltype=='2'",
			                fluidRow(column(12, jscolorInput("tc_colorcus", label = NULL, value = "#FF0000"))),
                            br()			                
			            ),
                        conditionalPanel(condition="input.tc_coltype=='3'",
			                textInput("tc_colormulgp", NULL, value="a:red;b:blue;c:cyan")
	                    )
						),
						selectInput("tc_collgd", h5("Color legend",
					                             bsButton("bsb358", label="", icon=icon("question"), style="info", size="small")
					                             ), choices = c("Yes" = "1", "No" = "2"), "2"),
					bsPopover("bsb358", "Control the appearance of the color legend in the plotting region.", trigger = "focus"),
			        conditionalPanel(condition="input.tc_collgd=='1'",
 				        textInput("tc_collgdname", h5("Legend title:",
 				                                      bsButton("bsb359", label="", icon=icon("question"), style="info", size="small")
 				                                      ), value="color"),
 				        bsPopover("bsb359", "Title of color legend. Null value will result in an empty title.", trigger = "focus"),
			            conditionalPanel(condition="input.tc_plottype=='point_discrete' | input.tc_plottype=='segment' | input.tc_plottype=='rect_discrete'",
			                             selectInput("tc_collgdmdylabel", h5("Modify legend labels",
							                                     bsButton("bsb360", label="", icon=icon("question"), style="info", size="small")
							                                     ), c("Yes" = "1", "No" = "2"), "2"),
							bsPopover("bsb360", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
						    conditionalPanel(condition="input.tc_collgdmdylabel=='1'",
						        textInput("tc_collgdlabel", NULL, value="a,b,c")
					        )
						)
				    ),
			        conditionalPanel(condition="input.tc_plottype=='point_discrete' | input.tc_plottype=='segment' | input.tc_plottype=='rect_discrete'",
			            sliderInput("tc_coltransparency", h5("Color transparency:",
			                                                 bsButton("bsb361", label="", icon=icon("question"), style="info", size="small")
			                                                 ), min=0, max=1, value=1, step=0.1),
			            bsPopover("bsb361", "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", trigger = "focus")
                    )          
                    ),                     
                    conditionalPanel(condition="input.tc_plottype == 'point_gradual' | input.tc_plottype == 'point_discrete'",
                    	checkboxInput("symbol_opt_tc", HTML("<font color='red'>Symbol</font>"), FALSE),  
			            conditionalPanel(condition="input.symbol_opt_tc",  
                                     selectInput("sel_tc_symbolpointype", h5("Symbol type",
                                                                 bsButton("bsb362", label="", icon=icon("question"), style="info", size="small")
                                                                 ), c("One custom symbol" = "1", 'Custom for data with a "shape" column' = "2"), selected="1"),
                        bsPopover("bsb362", 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.', trigger = "focus"),
                        conditionalPanel(condition="input.sel_tc_symbolpointype=='1'",
                            sliderInput("tc_symbolpoint", NULL, min=0, max=25, value=16, step=1)
                        ),
                        selectInput("tc_shapelgd", h5("Symbol legend",
		                                               bsButton("bsb363", label="", icon=icon("question"), style="info", size="small")
		                                               ), choices = c("Yes" = "1", "No" = "2"), "2"),
		                bsPopover("bsb363", "Control the appearance of the symbol legend in the plotting region.", trigger = "focus"),
			            conditionalPanel(condition="input.tc_shapelgd=='1'",
 				            textInput("tc_shapelgdname", h5("Legend title:",
 				                                            bsButton("bsb364", label="", icon=icon("question"), style="info", size="small")
 				                                            ), value="symbol"),
 				            bsPopover("bsb364", "Title of symbol legend. Null value will result in an empty title.", trigger = "focus"),
 				            selectInput("tc_shapelgdmdylabel", h5("Modify legend labels",
					                                               bsButton("bsb365", label="", icon=icon("question"), style="info", size="small")
					                                               ), c("Yes" = "1", "No" = "2"), "2"),
					        bsPopover("bsb365", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
						    conditionalPanel(condition="input.tc_shapelgdmdylabel=='1'",
						        textInput("tc_shapelgdlabel", NULL, value="a,b,c")
	                        )
					    )
					    ),
				        checkboxInput("size_opt_tc", HTML("<font color='red'>Size</font>"), FALSE),  
			            conditionalPanel(condition="input.size_opt_tc",  					    
					    selectInput("sel_tc_pointsizetype", h5("Point size",
                                                                bsButton("bsb366", label="", icon=icon("question"), style="info", size="small")
                                                                ), c("One custom size" = "1", 'Custom for data with a "size" column' = "2"), selected="1"),
					    bsPopover("bsb366", 'Value used for different size of points. A single numeric value can be used to set the size of all points or a numeric column named as "size" in the input data can be used to set the size of different points.', trigger = "focus"),
                        conditionalPanel(condition="input.sel_tc_pointsizetype=='1'",
                            sliderInput("tc_pointsize", NULL, min=0, max=5, value=0.8, step=0.1)
                        ),
					    selectInput("tc_sizelgd", h5("Size legend",
		                                              bsButton("bsb367", label="", icon=icon("question"), style="info", size="small")
		                                              ), choices = c("Yes" = "1", "No" = "2"), "2"),
					    bsPopover("bsb367", "Control the appearance of the size legend in the plotting region.", trigger = "focus"),
			            conditionalPanel(condition="input.tc_sizelgd=='1'",
 				            textInput("tc_sizelgdname", h5("Legend title:",
 				                                           bsButton("bsb368", label="", icon=icon("question"), style="info", size="small")
 				                                           ), value="size"),
 				            bsPopover("bsb368", "Title of size legend. Null value will result in an empty title.", trigger = "focus"),
 				            selectInput("tc_sizelgdmdylabel", h5("Modify legend labels",
				                                                  bsButton("bsb3680", label="", icon=icon("question"), style="info", size="small")
				                                                  ), c("Yes" = "1", "No" = "2"), "2"),
				            bsPopover("bsb3680", 'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', trigger = "focus"),
							conditionalPanel(condition="input.tc_sizelgdmdylabel=='1'",
						            textInput("tc_sizelgdlabel", NULL, value="a,b,c")
	                        )
					    )
					    )						
					),
			        conditionalPanel(condition="input.tc_plottype=='segment'",
				        checkboxInput("linetype_opt_tc", HTML("<font color='red'>Linetype</font>"), FALSE),  
			            conditionalPanel(condition="input.linetype_opt_tc",  				        	
                        sliderInput("tc_linesize", "Line width:", min=0, max=20, value=0.2, step=0.05),
			            selectInput("tc_linetype", h5("Line type",
			                                          bsButton("bsb369", label="", icon=icon("question"), style="info", size="small")
			                                          ), choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			            bsPopover("bsb369", 'The line type is automatically set as "solid" for line with more than one color.',trigger = "focus")
			        )
			        ),
					selectInput("tc_vertical", h5("Vertical line",
				                                   bsButton("bsb370", label="", icon=icon("question"), style="info", size="small")
				                                   ), c("Show" = "1", "Hide" = "2"),selected="2"),
					bsPopover("bsb370", "Create a set of vertical lines across the X-axis to separate different chromosomes.", trigger = "focus"),
				    conditionalPanel(condition="input.tc_vertical=='1'",
						fluidRow(column(12, jscolorInput("tc_verticalcol", label = h5('Vertical line color:',
						                                                              bsButton("bsb371", label="", icon=icon("question"), style="info", size="small")
						                                                              ), value = "#000000"))),
						bsPopover("bsb371", "Color of the vertical lines.",trigger = "focus"),
						br(),
			            sliderInput("tc_verticalsize", h5("Vertical line width:",
			                                              bsButton("bsb372", label="", icon=icon("question"), style="info", size="small")
			                                              ), min=0, max=3, value=0.2, step=0.05),
						bsPopover("bsb372", "Line width of the vertical lines",trigger = "focus"),
						selectInput("tc_verticaltype", h5("Vertical line type",
						                                  bsButton("bsb373", label="", icon=icon("question"), style="info", size="small")
						                                  ), choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
						bsPopover("bsb373", "Line type of the vertical lines",trigger = "focus")
				    ),
					selectInput("tc_horizontal", h5("Horizontal line",
				                                     bsButton("bsb374", label="", icon=icon("question"), style="info", size="small")
				                                     ), c("Show" = "1", "Hide" = "2"),selected="2"),
					bsPopover("bsb374", "Create a set of horizontal lines across the Y-axis to separate different chromosomes.", trigger = "focus"),
				    conditionalPanel(condition="input.tc_horizontal=='1'",
						fluidRow(column(12, jscolorInput("tc_horizontalcol", label = h5('Horizontal line color:',
						                                                                bsButton("bsb375", label="", icon=icon("question"), style="info", size="small")
						                                                                ), value = "#000000"))),
						bsPopover("bsb375", "Color of the horizontal lines",trigger = "focus"),
						br(),
			            sliderInput("tc_horizontalsize", h5("Horizontal line width:",
			                                                bsButton("bsb376", label="", icon=icon("question"), style="info", size="small")
			                                                ), min=0, max=3, value=0.2, step=0.05),
						bsPopover("bsb376", "Line width of the horizontal lines",trigger = "focus"),
						selectInput("tc_horizontaltype", h5("Horizontal line type",
						                                    bsButton("bsb377", label="", icon=icon("question"), style="info", size="small")
						                                    ), choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
						bsPopover("bsb377", "Line type of the horizontal lines",trigger = "focus")
				    ),
			        conditionalPanel(condition="input.tc_plottype=='rect_gradual' | input.tc_plottype=='rect_discrete'",
			                         selectInput("tc_addborder", h5("Add cell borders",
			                                            bsButton("bsb378", label="", icon=icon("question"), style="info", size="small")
			                                            ), c("Yes" = "1", "No" = "2"),selected="2"),
			            bsPopover("bsb378", "Add borders to the rect grids, which can be used to separate cells from each other.", trigger = "focus"),
			            conditionalPanel(condition="input.tc_addborder=='1'",
                            fluidRow(column(12, jscolorInput("tc_bordercols", label = h5('Borders color:'), value = "#000000")))
                            )
                    )
                )
            ),

			br(),br(),
            actionButton("submit2", strong("Go!",
                                           bsButton("bsb380", label="", icon=icon("question"), style="info", size="small")
                                           )),
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
			    selectInput("tc_themestyle", NULL, choices = c("theme1", "theme2", "theme3",
	                                                  "theme4", "theme5", "theme6",
	                                                  "theme7","theme8","theme9","theme10"), selected="theme1")
			),
            checkboxInput("tc_selfontsize", "Font size", FALSE),
            conditionalPanel(condition = "input.tc_selfontsize",
		        sliderInput("tc_fontSize", NULL, min=0, max=50, value=16, step=0.5)
		    ),
            checkboxInput("tc_addtitle", "Axis title", FALSE),
            conditionalPanel(condition = "input.tc_addtitle",
                textInput("tc_xtitle", "X axis title:", value="Genomic position 1"),
			    textInput("tc_ytitle", "Y axis title:", value="Genomic position 2"),
			    selectInput("tc_titlefontface", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain")
			),
            checkboxInput("tc_addlabels", "Axis label", FALSE),
            conditionalPanel(condition = "input.tc_addlabels",
                             selectInput("tc_xlabel", h5("X axis label",
			                                 bsButton("bsb384", label="", icon=icon("question"), style="info", size="small")
			                                 ), choices = c("Show" = "1", "Hide" = "2"), selected="1"),
			    bsPopover("bsb384", "Add tick labels on the X-axis.", trigger = "focus"),
			    selectInput("tc_ylabel", h5("Y axis label",
			                                 bsButton("bsb385", label="", icon=icon("question"), style="info", size="small")
			                                 ), choices = c("Show" = "1", "Hide" = "2"), selected="1"),
			    bsPopover("bsb385", "Add tick labels on the Y-axis.", trigger = "focus")
			),
            checkboxInput("tc_legends", "Legend", FALSE),
            conditionalPanel(condition = "input.tc_legends",
                             selectInput("tc_legendpos", h5("Legend position",
			                                    bsButton("bsb386", label="", icon=icon("question"), style="info", size="small")
			                                    ), c("Right" = "1", "Bottom" = "2"), selected="1"),
			    bsPopover("bsb386", "The position to place the legend.", trigger = "focus"),
				sliderInput("tc_lgdtitlesize", h5("Title font size",
				                                  bsButton("bsb387", label="", icon=icon("question"), style="info", size="small")
				                                  ), min=0, max=40, value=12, step=0.1),
				bsPopover("bsb387", "The font size of legend title.", trigger = "focus"),
				selectInput("tc_lgdtitlefontface", h5("Title font face:",
				                                      bsButton("bsb388", label="", icon=icon("question"), style="info", size="small")
				                                      ), choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
				bsPopover("bsb388", "The font face of legend title.", trigger = "focus"),
				sliderInput("tc_lgdtextsize", h5("Label font size",
				                                 bsButton("bsb389", label="", icon=icon("question"), style="info", size="small")
				                                 ), min=0, max=40, value=10, step=0.1),
				bsPopover("bsb389", "The font size of legend tick label.", trigger = "focus"),
			    selectInput("tc_lgdtextfontface", h5("Label font face:",
			                                         bsButton("bsb390", label="", icon=icon("question"), style="info", size="small")
			                                         ), choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
				bsPopover("bsb390", "The font face of legend tick label.", trigger = "focus")				
			)
		),
       mainPanel(id = "mainPanel_2",
           downloadButton("Visualization_2.pdf", "Download pdf-file"),
           downloadButton("Visualization_2.svg", "Download svg-file"),
		       downloadButton("Script_2.R", "Download the R scripts to reproduce the plot"),
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
	
	tabPanel("Help", includeMarkdown("README.md")),
	
	tabPanel("Manual", uiOutput("pdfview"))	  
      
	)
)

