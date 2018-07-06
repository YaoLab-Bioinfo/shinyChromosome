
source("global_ui.R")

shinyUI(
  navbarPage(
    title = "shinyChromosome", theme = shinytheme("flatly"), 
    windowTitle = "interactive creation of non-circular plots",
    tabPanel(
        "About",       
        HTML('<p <ul><li style="list-style-type: none; background-image: url(bullet.jpg); padding-left: 18px; background-size:12px 12px; background-repeat: no-repeat; background-position: 0px 50%"><font size="5.5">Software references</font></li></ul></p>'),
        HTML(
          '<p><font size="4">&nbsp;&nbsp;&nbsp;&nbsp;1. R Development Core Team. <i><a href="http://www.r-project.org/" target="_blank">R</a>:  A Language and Environment for Statistical Computing.</i> R Foundation for Statistical Computing, Vienna (2018) <br>
         &nbsp;&nbsp;&nbsp;&nbsp;2. RStudio and Inc. <i><a href="http://www.rstudio.com/shiny/" target="_blank">shiny</a>: Web Application Framework for R.</i> R package version 1.0.5 (2017) <br>
         &nbsp;&nbsp;&nbsp;&nbsp;3. H. Wickham. <i><a href="http://cran.r-project.org/web/packages/ggplot2/index.html" target="_blank">ggplot2</a>: Create Elegant Data Visualisations Using the Grammar of Graphics.</i> R package version 2.2.1.9000 (2016) <br>          
		 &nbsp;&nbsp;&nbsp;&nbsp;4. Gregory R. Warnes, Ben Bolker, Lodewijk Bonebakker, Robert Gentleman, et al. <i><a href="http://cran.r-project.org/web/packages/gplots/index.html" target="_blank">gplots</a>: Various R Programming Tools for Plotting Data.</i> R package version 3.0.1 (2016) <br>
		 &nbsp;&nbsp;&nbsp;&nbsp;5. Erich Neuwirth. <i><a href="http://cran.r-project.org/web/packages/RColorBrewer/index.html" target="_blank">RColorBrewer</a>: ColorBrewer palettes.</i> R package version 1.1-2 (2014) <br>
		 &nbsp;&nbsp;&nbsp;&nbsp;6. Hadley Wickham. <i><a href="http://cran.r-project.org/web/packages/plyr/index.html" target="_blank">plyr</a>: Tools for Splitting, Applying and Combining Data.</i> R package version 1.8.4 (2016) <br>
		 &nbsp;&nbsp;&nbsp;&nbsp;7. Jeffrey B. Arnold. <i><a href="http://cran.r-project.org/web/packages/ggthemes/index.html" target="_blank">ggthemes</a>: Extra Themes, Scales and Geoms for "ggplot2".</i> R package version 3.4.0 (2017) <br>
		 &nbsp;&nbsp;&nbsp;&nbsp;8. Christoph Burow, Urs Tilmann Wolpert and Sebastian Kreutzer. <i><a href="http://cran.r-project.org/web/packages/RLumShiny/index.html" target="_blank">RLumShiny</a>: "Shiny" Applications for the R Package "Luminescence".</i> R package version 0.2.0 (2017) <br>
		 &nbsp;&nbsp;&nbsp;&nbsp;9. Baptiste Auguie. <i><a href="http://cran.r-project.org/web/packages/gridExtra/index.html" target="_blank">gridExtra</a>: Miscellaneous Functions for "Grid" Graphics.</i> R package version 2.3 (2017) <br>
		 &nbsp;10. Hadley Wickham. <i><a href="http://cran.r-project.org/web/packages/reshape2/index.html" target="_blank">reshape2</a>: Flexibly Reshape Data: A Reboot of the Reshape Package.</i> R package version 1.4.3 (2017) <br>
		 &nbsp;11. Matt Dowle and Arun Srinivasan. <i><a href="http://cran.r-project.org/web/packages/data.table/index.html" target="_blank">data.table</a>: Extension of "data.frame".</i> R package version 1.10.4-3 (2017) <br>
		 &nbsp;12. JJ Allaire, Jeffrey Horner, Vicent Marti and Natacha Porte. <i><a href="http://cran.r-project.org/web/packages/markdown/index.html" target="_blank">markdown</a>: "Markdown" Rendering for R</i> R package version 0.8 (2017) <br></font></p>'
        ),
        HTML('<p <ul><li style="list-style-type: none; background-image: url(bullet.jpg); padding-left: 18px; background-size:12px 12px; background-repeat: no-repeat; background-position: 0px 50%"><font size="5.5">Further references</font></li></ul></p>'),
        HTML('<p><font size="4">This application was created by <a href="http://www.researchgate.net/profile/Wen_Yao" target="_blank">Wen Yao</a> and <a href="http://www.researchgate.net/profile/Yiming_Yu6" target="_blank">Yiming Yu</a>. Please send bugs and feature requests to Wen Yao (ywhzau at gmail.com) or Yiming Yu (yimingyyu at gmail.com). This application uses the shiny package from <a href="http://www.rstudio.com/shiny/" target="_blank">RStudio</a>.</font></p>')      
    ),    
	tabPanel(
      "One genome",tags$head(
			tags$style("
                input[type='file'] {width:5em;}
				.toggleButton {width:100%;} 
                .clearButton {float:right; font-size:12px;}
				.fa-angle-down:before, .fa-angle-up:before {float:right;}
				.popover{text-align:left;width:500px;background-color:#000000;}
				.popover-title{color:#FFFFFF;font-size:16px;background-color:#000000;border-color:#000000;}
				#sidebarPanel_1 {width:25em;}
				#lowColor1, #midColor1, #highColor1 {width:100%}
				#mainPanel_1 {left:28em; position:absolute; min-width:27em;}"),
			 tags$style(HTML(".shiny-output-error-validation {color: red;}")),
             tags$script(HTML('Shiny.addCustomMessageHandler("jsCode",function(message) {eval(message.value);});')), includeScript("google-analytics.js")				
		),    
      sidebarPanel(id="sidebarPanel_1",	  
    	tipify(radioButtons("plotype", "Image type", c("Concatenated chromosome" = "1", "Separated chromosome" = "2"), "1"),
		    "All chromosomes can either be concatenated or separated.", placement="right", options=list(container="body")),
    	tipify(radioButtons("plotdirection", "Orientation", c("Horizontal" = "1", "Vertical" = "2"), "1"),
		    'The coordinate frame could be flipped in one click.', placement="right", options=list(container="body")),		
	    tipify(fileInput("uploadchrdata", "Upload genome data:", multiple = FALSE),
			'Click "Browse" to upload the genome data, which is compulsory and defines the frame of the non-circular plot.', placement="right", options=list(container="body")),						
		tags$script('$( "#uploadchrdata" ).on( "click", function() { this.value = null; });'),		
					
		checkboxInput("data1", HTML("<font color='red'>Data1</font>"), FALSE),
		conditionalPanel(condition="input.data1",
		  radioButtons("seluploaddata1", NULL, c("NULL" = "1", "Upload" = "2"), "1"),
		  conditionalPanel(condition="input.seluploaddata1 == '2'",
		    tipify(fileInput("uploaddata1", "Upload data1:", multiple = FALSE),
			'Click "Browse" to upload the track data.', placement="right", options=list(container="body")),																							
			tags$script('$( "#uploaddata1" ).on( "click", function() { this.value = null; });'),
			selectInput("plottype1", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),
			tipify(selectInput("layerindex1", "Track index:", choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks. The track index can be set at the choice of the users, if only one data file is uploaded.', placement="right", options=list(container="body")),																										
    	ADVANCED_OPTIONS_PANEL_1(
		    list(
				conditionalPanel(condition="input.plottype1 == 'point' | input.plottype1 == 'line' | input.plottype1 == 'bar' | input.plottype1 == 'segment'",
			        tipify(radioButtons("coltype1", "Data color", c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
                    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should provide a character string representing one color as "red". To customize color for data with multiple groups, the column indicating different groups in the uploaded data should be named as "color". Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', placement="right", options=list(container="body")),																								
					conditionalPanel(condition="input.coltype1=='2'",	
			            textInput("colorcus1", NULL, value="red")
			         ),
                    conditionalPanel(condition="input.coltype1=='3'",	
			            textInput("colormulgp1", NULL, value="a:red;b:blue;c:cyan")
	                )
				),
			conditionalPanel(condition="input.plottype1=='rect_discrete'",
			    tipify(radioButtons("rectcol1", "Data color", c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),
			conditionalPanel(condition="input.rectcol1=='2'",
			    textInput("rectcoldis1", NULL, value="red")
			),
			conditionalPanel(condition="input.rectcol1=='3'",
			    textInput("rectcoldiscus1", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype1=='rect_gradual'",
			    selectInput("colrect1", "Data color", choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange", 
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold", 
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange", 
			                                               "navy.cyan", "blue.red", "green.red"))
			),
			conditionalPanel(condition="input.plottype1=='heatmap_gradual'",			
			    tipify(radioButtons("heatmapcol1", "Colors", c("Typical" = "1", "Custom" = "2"), selected="1"), "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", placement="right", options=list(container="body")),			
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
			        HTML('<br>')
			)			
			),			
			conditionalPanel(condition="input.plottype1=='heatmap_discrete'",
			    tipify(radioButtons("colhmapdis1", "Data color", c("Random" = "1", "Custom" = "2"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),
			conditionalPanel(condition="input.colhmapdis1=='2'",
			    textInput("colhmapdiscus1", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype1=='vertical line' | input.plottype1=='horizontal line'",	
			    tipify(textInput("linecolor1", "Line color:", value="black"),
			'The color to be used to plot the data. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body"))				
			),
			conditionalPanel(condition="input.plottype1=='line'",	
			    tipify(radioButtons("fillarea1", "Fill area", c("Yes" = "1", "No" = "2"),selected="2"),
			"Fill the area below the lines.", placement="right", options=list(container="body")),
                conditionalPanel(condition="input.fillarea1=='1'",			
			    tipify(radioButtons("selareatype1", "Area color", c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			'Color to be used to fill the area, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', placement="right", options=list(container="body")),
				conditionalPanel(condition="input.selareatype1=='2'",
			        textInput("borderarea1", NULL, value="blue")
			)
			)
			),			
			conditionalPanel(condition="input.plottype1!='rect_gradual' & input.plottype1!='heatmap_gradual' & input.plottype1!='text'",				
			    tipify(numericInput("coltransparency1", "Color transparency:", value=1, min=0, max=1, step=0.1),
			"A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", placement="right", options=list(container="body"))										  
            ),		
			conditionalPanel(condition="input.plottype1=='line' | input.plottype1=='vertical line' | input.plottype1=='horizontal line' | input.plottype1 == 'segment'",	
			    numericInput("linesize1", "Line width:", value=0.2, min=0, max=20, step=0.05)
			),
			conditionalPanel(condition="input.plottype1=='line' | input.plottype1=='vertical line' | input.plottype1=='horizontal line' | input.plottype1 == 'segment'",	
			    tipify(selectInput("linetype1", "Line type", choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			'The line type is automatically set to "solid" for line with more than one color.',placement="right", options=list(container="body"))
			),
			conditionalPanel(condition="input.plottype1 == 'segment'",	
			    tipify(radioButtons("addarrow1", "Add arrow head", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add arrow head for the segment.", placement="right", options=list(container="body")),
			conditionalPanel(condition="input.addarrow1 == '1'",
			    tipify(radioButtons("arrowpos1", "Arrow position", c("Line end" = "1", "Line beginning" = "2"),selected="1"),
				'The position of arrow head.',placement="right", options=list(container="body")),
				tipify(numericInput("arrowsize1", "Arrow size:", value=0.1, min=0, max=20, step=0.05),
			    'The size of arrow head.',placement="right", options=list(container="body"))								
            )
			),
			conditionalPanel(condition="input.plottype1=='point'",			
                tipify(textInput("symbolpoint1", "Symbol type:", value="16"), 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. The option is suitable for data without a "shape" column.', placement="right", options=list(container="body")),				
			    tipify(numericInput("pointsize1", "Point size:", value=0.8, min=0, max=2, step=0.05), 'Value used for different size of points. The option is suitable for data without a "size" column.', placement="right", options=list(container="body"))
            ),
			conditionalPanel(condition="input.plottype1=='heatmap_gradual' | input.plottype1=='heatmap_discrete' | input.plottype1=='rect_gradual' | input.plottype1=='rect_discrete' | input.plottype1=='bar'",
			    tipify(radioButtons("addborder1", "Add cell borders", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add borders to the grids, which can be used to separate cells from each other.", placement="right", options=list(container="body")),
			    conditionalPanel(condition="input.addborder1=='1'",
                    tipify(textInput("bordercols1", "Borders color:", value="black"),
					"The color to be used for the borders of grids. For example, 'white' or 'red'. Hex color codes as '#FF0000' are also supported.", placement="right", options=list(container="body"))
			    )
            ),
			conditionalPanel(condition="input.plottype1=='line' | input.plottype1=='point' | input.plottype1=='bar'",				
				tipify(radioButtons("xrugs1", "X-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the X-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.xrugs1=='1'",
				    textInput("xrugscol1", "Color:", value="black")				
				),				
				tipify(radioButtons("yrugs1", "Y-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the Y-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.yrugs1=='1'",
				    textInput("yrugscol1", "Color:", value="black")				
				),
	            tipify(radioButtons("ylabel1", "Y label", c("Show" = "1", "Hide" = "2"), selected="1"),
			"Add tick labels on the Y-axis.", placement="right", options=list(container="body"))				
			),
			conditionalPanel(condition="input.plottype1=='text'",
				textInput("textcol1", "Font color:", value="black"),
			    numericInput("textsize1", "Font size:", value=2, min=0, max=100, step=0.5),
			    selectInput("fontface1", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),			    
				numericInput("textangle1", "Font angle:", value=60, min=-360, max=360, step=1)
			),
		    tipify(radioButtons("addlegend1", "Add legend", c("Yes" = "1", "No" = "2"), "2"),
			"Control the appearance of the legend in the plotting region.", placement="right", options=list(container="body")),			  
			  conditionalPanel(condition="input.addlegend1=='1'",
			    conditionalPanel(condition="input.plottype1=='point' | input.plottype1=='line' | input.plottype1=='bar' | input.plottype1=='rect_gradual' | input.plottype1=='rect_discrete' | input.plottype1=='heatmap_gradual' | input.plottype1=='heatmap_discrete' | input.plottype1=='vertical line' | input.plottype1=='horizontal line' | input.plottype1=='text' | input.plottype1 == 'segment'",
		          radioButtons("collgd1", "Color legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.collgd1=='1'",
 				      tipify(textInput("collgdname1", "Name:", value="color"),
			          "Title of the color legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  
					    conditionalPanel(condition="input.plottype1!='rect_gradual' & input.plottype1!='heatmap_gradual'",
					      tipify(radioButtons("collgdmdylabel1", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of different colors in the color legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),
						  conditionalPanel(condition="input.collgdmdylabel1=='1'",
						    textInput("collgdlabel1", NULL, value="a,b,c")
					      )
						)	
					)
				),
			    conditionalPanel(condition="input.plottype1=='point'",
		          radioButtons("sizelgd1", "Size legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.sizelgd1=='1'",
 				      tipify(textInput("sizelgdname1", "Name:", value="size"),
			          "Title of size legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  
				      tipify(radioButtons("sizelgdmdylabel1", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),
						  conditionalPanel(condition="input.sizelgdmdylabel1=='1'",
						    textInput("sizelgdlabel1", NULL, value="a,b,c")
	                      )
					),
		          radioButtons("shapelgd1", "Shape legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.shapelgd1=='1'",
 				      tipify(textInput("shapelgdname1", "Name:", value="shape"),
			          "Title of shape legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      
					  tipify(radioButtons("shapelgdmdylabel1", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),
						  conditionalPanel(condition="input.shapelgdmdylabel1=='1'",
						    textInput("shapelgdlabel1", NULL, value="a,b,c")
	                      )
					)
				),
			    conditionalPanel(condition="input.plottype1=='vertical line' | input.plottype1=='horizontal line'",
		          radioButtons("linetypelgd1", "Line type legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.linetypelgd1=='1'",
 				      tipify(textInput("linetypelgdname1", "Name:", value="linetype"),
			          "Title of line type legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  
					  tipify(radioButtons("linetypelgdmdylabel1", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', placement="right", options=list(container="body")),
						  conditionalPanel(condition="input.linetypelgdmdylabel1=='1'",
						    textInput("linetypelgdlabel1", NULL, value="a")
	                      )
					)
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
		    tipify(fileInput("uploaddata2", "Upload data2:", multiple = FALSE),
			'Click "Browse" to upload the track data.', placement="right", options=list(container="body")),																										
			tags$script('$( "#uploaddata2" ).on( "click", function() { this.value = null; });'),
			selectInput("plottype2", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),		
			tipify(selectInput("layerindex2", "Track index:", choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks. The track index can be set at the choice of the users, if only one data file is uploaded.', placement="right", options=list(container="body")),																													
    	ADVANCED_OPTIONS_PANEL_2(
				list(
				conditionalPanel(condition="input.plottype2 == 'point' | input.plottype2 == 'line' | input.plottype2 == 'bar' | input.plottype2 == 'segment'",
			        tipify(radioButtons("coltype2", "Data color", c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
                    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should provide a character string representing one color as "red". To customize color for data with multiple groups, the column indicating different groups should be named as "color". Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', placement="right", options=list(container="body")),																								
					conditionalPanel(condition="input.coltype2=='2'",	
			            textInput("colorcus2", NULL, value="red")
			         ),
                    conditionalPanel(condition="input.coltype2=='3'",	
			            textInput("colormulgp2", NULL, value="a:red;b:blue;c:cyan")
	                )
				),
			conditionalPanel(condition="input.plottype2=='rect_discrete'",
			    tipify(radioButtons("rectcol2", "Data color", c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),											  
			conditionalPanel(condition="input.rectcol2=='2'",
			    textInput("rectcoldis2", NULL, value="red")
			),
			conditionalPanel(condition="input.rectcol2=='3'",
			    textInput("rectcoldiscus2", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype2=='rect_gradual'",
			    selectInput("colrect2", "Data color", choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange", 
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold", 
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange", 
			                                               "navy.cyan", "blue.red", "green.red"))
			),
			conditionalPanel(condition="input.plottype2=='heatmap_gradual'",			
			    tipify(radioButtons("heatmapcol2", "Colors", c("Typical" = "1", "Custom" = "2"), selected="1"), "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", placement="right", options=list(container="body")),			
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
			        HTML('<br>')
			)			
			),
			conditionalPanel(condition="input.plottype2=='heatmap_discrete'",
			    tipify(radioButtons("colhmapdis2", "Data color", c("Random" = "1", "Custom" = "2"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),
			conditionalPanel(condition="input.colhmapdis2=='2'",
			    textInput("colhmapdiscus2", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype2=='vertical line' | input.plottype2=='horizontal line'",	
			    tipify(textInput("linecolor2", "Line color:", value="black"),
			'The color to be used to plot the data. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body"))				
			),
			conditionalPanel(condition="input.plottype2=='line'",	
			    tipify(radioButtons("fillarea2", "Fill area", c("Yes" = "1", "No" = "2"),selected="2"),
			"Fill the area below the lines.", placement="right", options=list(container="body")),
                conditionalPanel(condition="input.fillarea2=='1'",			
			    tipify(radioButtons("selareatype2", "Area color", c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', placement="right", options=list(container="body")),
				conditionalPanel(condition="input.selareatype2=='2'",
			        textInput("borderarea2", NULL, value="blue")
			)
			)
			),			
			conditionalPanel(condition="input.plottype2!='rect_gradual' & input.plottype2!='heatmap_gradual' & input.plottype2!='text'",				
			    tipify(numericInput("coltransparency2", "Color transparency:", value=1, min=0, max=1, step=0.1),
			"A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", placement="right", options=list(container="body"))										  
            ),
			conditionalPanel(condition="input.plottype2=='line' | input.plottype2=='vertical line' | input.plottype2=='horizontal line' | input.plottype2 == 'segment'",	
			    numericInput("linesize2", "Line width:", value=0.2, min=0, max=20, step=0.05)
			),
			conditionalPanel(condition="input.plottype2=='line' | input.plottype2=='vertical line' | input.plottype2=='horizontal line' | input.plottype2 == 'segment'",	
			    tipify(selectInput("linetype2", "Line type", choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			'The line type is automatically set to "solid" for line with more than one color.',placement="right", options=list(container="body"))
			),
			conditionalPanel(condition="input.plottype2 == 'segment'",	
			    tipify(radioButtons("addarrow2", "Add arrow head", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add arrow head for the segment.", placement="right", options=list(container="body")),
			conditionalPanel(condition="input.addarrow2 == '1'",
			    tipify(radioButtons("arrowpos2", "Arrow position", c("Line end" = "1", "Line beginning" = "2"),selected="1"),
				'The position of arrow head.',placement="right", options=list(container="body")),				
				tipify(numericInput("arrowsize2", "Arrow size:", value=0.1, min=0, max=20, step=0.05),
			    'The size of arrow head.',placement="right", options=list(container="body"))								
            )
			),			
			conditionalPanel(condition="input.plottype2=='point'",			
                tipify(textInput("symbolpoint2", "Symbol type:", value="16"), 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. The option is suitable for data without a "shape" column.', placement="right", options=list(container="body")),				
			    tipify(numericInput("pointsize2", "Point size:", value=0.8, min=0, max=2, step=0.05), 'Value used for different size of points. The option is suitable for data without a "size" column.', placement="right", options=list(container="body"))
            ),
			conditionalPanel(condition="input.plottype2=='heatmap_gradual' | input.plottype2=='heatmap_discrete' | input.plottype2=='rect_gradual' | input.plottype2=='rect_discrete' | input.plottype2=='bar'",
			    tipify(radioButtons("addborder2", "Add cell borders", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add borders to the grids, which can be used to separate cells from each other.", placement="right", options=list(container="body")),
			    conditionalPanel(condition="input.addborder2=='1'",
                    tipify(textInput("bordercols2", "Borders color:", value="black"),
					"The color to be used for the borders of grids. For example, 'white' or 'red'. Hex color codes as '#FF0000' are also supported.", placement="right", options=list(container="body"))
			    )
            ),
			conditionalPanel(condition="input.plottype2=='line' | input.plottype2=='point' | input.plottype2=='bar'",				
				tipify(radioButtons("xrugs2", "X-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the X-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.xrugs2=='1'",
				    textInput("xrugscol2", "Color:", value="black")				
				),				
				tipify(radioButtons("yrugs2", "Y-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the Y-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.yrugs2=='1'",
				    textInput("yrugscol2", "Color:", value="black")				
				),
	            tipify(radioButtons("ylabel2", "Y label", c("Show" = "1", "Hide" = "2"), selected="1"),
			"Add tick labels on the Y-axis.", placement="right", options=list(container="body"))								
			),			
			conditionalPanel(condition="input.plottype2=='text'",
				textInput("textcol2", "Font color:", value="black"),			
			    numericInput("textsize2", "Font size:", value=2, min=0, max=100, step=0.5),
			    selectInput("fontface2", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),			    
				numericInput("textangle2", "Font angle:", value=60, min=-360, max=360, step=1)
			),
		    tipify(radioButtons("addlegend2", "Add legend", c("Yes" = "1", "No" = "2"), "2"),
			"Control the appearance of the legend in the plotting region.", placement="right", options=list(container="body")),			  
			  conditionalPanel(condition="input.addlegend2=='1'",
			    conditionalPanel(condition="input.plottype2=='point' | input.plottype2=='line' | input.plottype2=='bar' | input.plottype2=='rect_gradual' | input.plottype2=='rect_discrete' | input.plottype2=='heatmap_gradual' | input.plottype2=='heatmap_discrete' | input.plottype2=='vertical line' | input.plottype2=='horizontal line' | input.plottype2=='text'",
		          radioButtons("collgd2", "Color legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.collgd2=='1'",
 				      tipify(textInput("collgdname2", "Name:", value="color"),
			          "Title of color legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  
					    conditionalPanel(condition="input.plottype2!='rect_gradual' & input.plottype2!='heatmap_gradual'",
					      tipify(radioButtons("collgdmdylabel2", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.collgdmdylabel2=='1'",
						    textInput("collgdlabel2", NULL, value="a,b,c")
					      )
						)
					)
				),
			    conditionalPanel(condition="input.plottype2=='point'",
		          radioButtons("sizelgd2", "Size legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.sizelgd2=='1'",
 				      tipify(textInput("sizelgdname2", "Name:", value="size"),	
			          "Title of size legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  					  
				      tipify(radioButtons("sizelgdmdylabel2", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.sizelgdmdylabel2=='1'",
						    textInput("sizelgdlabel2", NULL, value="a,b,c")
	                      )
					),
		          radioButtons("shapelgd2", "Shape legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.shapelgd2=='1'",
 				      tipify(textInput("shapelgdname2", "Name:", value="shape"),
			          "Title of shape legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  
					  tipify(radioButtons("shapelgdmdylabel2", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.shapelgdmdylabel2=='1'",
						    textInput("shapelgdlabel2", NULL, value="a,b,c")
	                      )	  
					)
				),
			    conditionalPanel(condition="input.plottype2=='vertical line' | input.plottype2=='horizontal line'",
		          radioButtons("linetypelgd2", "Line type legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.linetypelgd2=='1'",
 				      tipify(textInput("linetypelgdname2", "Name:", value="linetype"),					  
			          "Title of line type legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  					  
					  tipify(radioButtons("linetypelgdmdylabel2", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', placement="right", options=list(container="body")),						
						  conditionalPanel(condition="input.linetypelgdmdylabel2=='1'",
						    textInput("linetypelgdlabel2", NULL, value="a")
	                      )
					)
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
		    tipify(fileInput("uploaddata3", "Upload data3:", multiple = FALSE),
			'Click "Browse" to upload the track data.', placement="right", options=list(container="body")),																										
			tags$script('$( "#uploaddata3" ).on( "click", function() { this.value = null; });'),
			selectInput("plottype3", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),		
			tipify(selectInput("layerindex3", "Track index:", choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks. The track index can be set at the choice of the users, if only one data file is uploaded.', placement="right", options=list(container="body")),																													
    	ADVANCED_OPTIONS_PANEL_3(
				list(
				conditionalPanel(condition="input.plottype3 == 'point' | input.plottype3 == 'line' | input.plottype3 == 'bar' | input.plottype3 == 'segment'",
			        tipify(radioButtons("coltype3", "Data color", c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
                    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should provide a character string representing one color as "red". To customize color for data with multiple groups, the column indicating different groups should be named as "color". Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', placement="right", options=list(container="body")),																								
					conditionalPanel(condition="input.coltype3=='2'",	
			            textInput("colorcus3", NULL, value="red")
			         ),
                    conditionalPanel(condition="input.coltype3=='3'",	
			            textInput("colormulgp3", NULL, value="a:red;b:blue;c:cyan")
	                )
				),
			conditionalPanel(condition="input.plottype3=='rect_discrete'",
			    tipify(radioButtons("rectcol3", "Data color", c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),											  
			conditionalPanel(condition="input.rectcol3=='2'",
			    textInput("rectcoldis3", NULL, value="red")
			),
			conditionalPanel(condition="input.rectcol3=='3'",
			    textInput("rectcoldiscus3", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype3=='rect_gradual'",
			    selectInput("colrect3", "Data color", choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange", 
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold", 
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange", 
			                                               "navy.cyan", "blue.red", "green.red"))
			),
			conditionalPanel(condition="input.plottype3=='heatmap_gradual'",			
			    tipify(radioButtons("heatmapcol3", "Colors", c("Typical" = "1", "Custom" = "2"), selected="1"), "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", placement="right", options=list(container="body")),			
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
			        HTML('<br>')
			)			
			),
			conditionalPanel(condition="input.plottype3=='heatmap_discrete'",
			    tipify(radioButtons("colhmapdis3", "Data color", c("Random" = "1", "Custom" = "2"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),
			conditionalPanel(condition="input.colhmapdis3=='2'",
			    textInput("colhmapdiscus3", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype3=='vertical line' | input.plottype3=='horizontal line'",	
			    tipify(textInput("linecolor3", "Line color:", value="black"),
			'The color to be used to plot the data. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body"))				
			),
			conditionalPanel(condition="input.plottype3=='line'",	
			    tipify(radioButtons("fillarea3", "Fill area", c("Yes" = "1", "No" = "2"),selected="2"),
			"Fill the area below the lines.", placement="right", options=list(container="body")),
                conditionalPanel(condition="input.fillarea3=='1'",			
			    tipify(radioButtons("selareatype3", "Area color", c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', placement="right", options=list(container="body")),
				conditionalPanel(condition="input.selareatype3=='2'",
			        textInput("borderarea3", NULL, value="blue")
			)
		    )			
			),			
			conditionalPanel(condition="input.plottype3!='rect_gradual' & input.plottype3!='heatmap_gradual' & input.plottype3!='text'",				
			    tipify(numericInput("coltransparency3", "Color transparency:", value=1, min=0, max=1, step=0.1),
			"A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", placement="right", options=list(container="body"))										  
            ),
			conditionalPanel(condition="input.plottype3=='line' | input.plottype3=='vertical line' | input.plottype3=='horizontal line' | input.plottype3 == 'segment'",	
			    numericInput("linesize3", "Line width:", value=0.2, min=0, max=20, step=0.05)
			),	
			conditionalPanel(condition="input.plottype3=='line' | input.plottype3=='vertical line' | input.plottype3=='horizontal line' | input.plottype3 == 'segment'",	
			    tipify(selectInput("linetype3", "Line type", choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			'The line type is automatically set to "solid" for line with more than one color.',placement="right", options=list(container="body"))
			),
			conditionalPanel(condition="input.plottype3 == 'segment'",	
			    tipify(radioButtons("addarrow3", "Add arrow head", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add arrow head for the segment.", placement="right", options=list(container="body")),
			conditionalPanel(condition="input.addarrow3 == '1'",
			    tipify(radioButtons("arrowpos3", "Arrow position", c("Line end" = "1", "Line beginning" = "2"),selected="1"),
				'The position of arrow head.',placement="right", options=list(container="body")),				
				tipify(numericInput("arrowsize3", "Arrow size:", value=0.1, min=0, max=20, step=0.05),
			    'The size of arrow head.',placement="right", options=list(container="body"))								
            )
			),
			conditionalPanel(condition="input.plottype3=='point'",			
                tipify(textInput("symbolpoint3", "Symbol type:", value="16"), 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. The option is suitable for data without a "shape" column.', placement="right", options=list(container="body")),				
			    tipify(numericInput("pointsize3", "Point size:", value=0.8, min=0, max=2, step=0.05), 'Value used for different size of points. The option is suitable for data without a "size" column.', placement="right", options=list(container="body"))
            ),
			conditionalPanel(condition="input.plottype3=='heatmap_gradual' | input.plottype3=='heatmap_discrete' | input.plottype3=='rect_gradual' | input.plottype3=='rect_discrete' | input.plottype3=='bar'",
			    tipify(radioButtons("addborder3", "Add cell borders", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add borders to the grids, which can be used to separate cells from each other.", placement="right", options=list(container="body")),
			    conditionalPanel(condition="input.addborder3=='1'",
                    tipify(textInput("bordercols3", "Borders color:", value="black"),
					"The color to be used for the borders of grids. For example, 'white' or 'red'. Hex color codes as '#FF0000' are also supported.", placement="right", options=list(container="body"))
			    )
            ),
			conditionalPanel(condition="input.plottype3=='line' | input.plottype3=='point' | input.plottype3=='bar'",				
				tipify(radioButtons("xrugs3", "X-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the X-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.xrugs3=='1'",
				    textInput("xrugscol3", "Color:", value="black")				
				),				
				tipify(radioButtons("yrugs3", "Y-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the Y-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.yrugs3=='1'",
				    textInput("yrugscol3", "Color:", value="black")				
				),
	            tipify(radioButtons("ylabel3", "Y label", c("Show" = "1", "Hide" = "2"), selected="1"),
			"Add tick labels on the Y-axis.", placement="right", options=list(container="body"))								
			),
			conditionalPanel(condition="input.plottype3=='text'",
				textInput("textcol3", "Font color:", value="black"),			
			    numericInput("textsize3", "Font size:", value=2, min=0, max=100, step=0.5),
			    selectInput("fontface3", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),			    
				numericInput("textangle3", "Font angle:", value=60, min=-360, max=360, step=1)
			),
		    tipify(radioButtons("addlegend3", "Add legend", c("Yes" = "1", "No" = "2"), "2"),
			"Control the appearance of the legend in the plotting region.", placement="right", options=list(container="body")),			
			  conditionalPanel(condition="input.addlegend3=='1'",
			    conditionalPanel(condition="input.plottype3=='point' | input.plottype3=='line' | input.plottype3=='bar' | input.plottype3=='rect_gradual' | input.plottype3=='rect_discrete' | input.plottype3=='heatmap_gradual' | input.plottype3=='heatmap_discrete' | input.plottype3=='vertical line' | input.plottype3=='horizontal line' | input.plottype3=='text'",
		          radioButtons("collgd3", "Color legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.collgd3=='1'",
 				      tipify(textInput("collgdname3", "Name:", value="color"),
			          "Title of color legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  
					    conditionalPanel(condition="input.plottype3!='rect_gradual' & input.plottype3!='heatmap_gradual'",
					      tipify(radioButtons("collgdmdylabel3", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.collgdmdylabel3=='1'",
						    textInput("collgdlabel3", NULL, value="a,b,c")
					      )
						)
					)
				),
			    conditionalPanel(condition="input.plottype3=='point'",
		          radioButtons("sizelgd3", "Size legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.sizelgd3=='1'",
 				      tipify(textInput("sizelgdname3", "Name:", value="size"),
			          "Title of size legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  					  
				      tipify(radioButtons("sizelgdmdylabel3", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.sizelgdmdylabel3=='1'",
						    textInput("sizelgdlabel3", NULL, value="a,b,c")
	                      )
					),
		          radioButtons("shapelgd3", "Shape legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.shapelgd3=='1'",
 				      tipify(textInput("shapelgdname3", "Name:", value="shape"),
			          "Title of shape legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  
					  tipify(radioButtons("shapelgdmdylabel3", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.shapelgdmdylabel3=='1'",
						    textInput("shapelgdlabel3", NULL, value="a,b,c")
	                      )
					)
				),
			    conditionalPanel(condition="input.plottype3=='vertical line' | input.plottype3=='horizontal line'",
		          radioButtons("linetypelgd3", "Line type legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.linetypelgd3=='1'",
 				      tipify(textInput("linetypelgdname3", "Name:", value="linetype"),		
			          "Title of line type legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  					  
					  tipify(radioButtons("linetypelgdmdylabel3", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.linetypelgdmdylabel3=='1'",
						    textInput("linetypelgdlabel3", NULL, value="a")
	                      )
					)
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
		    tipify(fileInput("uploaddata4", "Upload data4:", multiple = FALSE),
			'Click "Browse" to upload the track data.', placement="right", options=list(container="body")),																										
			tags$script('$( "#uploaddata4" ).on( "click", function() { this.value = null; });'),
			selectInput("plottype4", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),	
			tipify(selectInput("layerindex4", "Track index:", choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks. The track index can be set at the choice of the users, if only one data file is uploaded.', placement="right", options=list(container="body")),																													
    	ADVANCED_OPTIONS_PANEL_4(
				list(
				conditionalPanel(condition="input.plottype4 == 'point' | input.plottype4 == 'line' | input.plottype4 == 'bar' | input.plottype4 == 'segment'",				
			        tipify(radioButtons("coltype4", "Data color", c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
                    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should provide a character string representing one color as "red". To customize color for data with multiple groups, the column indicating different groups should be named as "color". Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', placement="right", options=list(container="body")),																									
					conditionalPanel(condition="input.coltype4=='2'",	
			            textInput("colorcus4", NULL, value="red")
			         ),
                    conditionalPanel(condition="input.coltype4=='3'",	
			            textInput("colormulgp4", NULL, value="a:red;b:blue;c:cyan")
	                )
				),
			conditionalPanel(condition="input.plottype4=='rect_discrete'",
			    tipify(radioButtons("rectcol4", "Data color", c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),										  
			conditionalPanel(condition="input.rectcol4=='2'",
			    textInput("rectcoldis4", NULL, value="red")
			),
			conditionalPanel(condition="input.rectcol4=='3'",
			    textInput("rectcoldiscus4", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype4=='rect_gradual'",
			    selectInput("colrect4", "Data color", choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange", 
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold", 
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange", 
			                                               "navy.cyan", "blue.red", "green.red"))
			),
			conditionalPanel(condition="input.plottype4=='heatmap_gradual'",			
			    tipify(radioButtons("heatmapcol4", "Colors", c("Typical" = "1", "Custom" = "2"), selected="1"), "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", placement="right", options=list(container="body")),			
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
			        HTML('<br>')
			)			
			),
			conditionalPanel(condition="input.plottype4=='heatmap_discrete'",
			    tipify(radioButtons("colhmapdis4", "Data color", c("Random" = "1", "Custom" = "2"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),
			conditionalPanel(condition="input.colhmapdis4=='2'",
			    textInput("colhmapdiscus4", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype4=='vertical line' | input.plottype4=='horizontal line'",	
			    tipify(textInput("linecolor4", "Line color:", value="black"),
			'The color to be used to plot the data. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body"))				
			),
			conditionalPanel(condition="input.plottype4=='line'",	
			    tipify(radioButtons("fillarea4", "Fill area", c("Yes" = "1", "No" = "2"),selected="2"),
			"Fill the area below the lines.", placement="right", options=list(container="body")),
                conditionalPanel(condition="input.fillarea4=='1'",			
			    tipify(radioButtons("selareatype4", "Area color", c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', placement="right", options=list(container="body")),
				conditionalPanel(condition="input.selareatype4=='2'",
			        textInput("borderarea4", NULL, value="blue")
			)
		    )			
			),			
			conditionalPanel(condition="input.plottype4!='rect_gradual' & input.plottype4!='heatmap_gradual' & input.plottype4!='text'",				
			    tipify(numericInput("coltransparency4", "Color transparency:", value=1, min=0, max=1, step=0.1),
			"A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", placement="right", options=list(container="body"))										  
            ),
			conditionalPanel(condition="input.plottype4=='line' | input.plottype4=='vertical line' | input.plottype4=='horizontal line' | input.plottype4 == 'segment'",	
			    numericInput("linesize4", "Line width:", value=0.2, min=0, max=20, step=0.05)
			),	
			conditionalPanel(condition="input.plottype4=='line' | input.plottype4=='vertical line' | input.plottype4=='horizontal line' | input.plottype4 == 'segment'",	
			    tipify(selectInput("linetype4", "Line type", choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			'The line type is automatically set to "solid" for line with more than one color.',placement="right", options=list(container="body"))
			),
			conditionalPanel(condition="input.plottype4 == 'segment'",	
			    tipify(radioButtons("addarrow4", "Add arrow head", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add arrow head for the segment.", placement="right", options=list(container="body")),
			conditionalPanel(condition="input.addarrow4 == '1'",
			    tipify(radioButtons("arrowpos4", "Arrow position", c("Line end" = "1", "Line beginning" = "2"),selected="1"),
				'The position of arrow head.',placement="right", options=list(container="body")),				
				tipify(numericInput("arrowsize4", "Arrow size:", value=0.1, min=0, max=20, step=0.05),
			    'The size of arrow head.',placement="right", options=list(container="body"))				
            )
			),			
			conditionalPanel(condition="input.plottype4=='point'",			
                tipify(textInput("symbolpoint4", "Symbol type:", value="16"), 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. The option is suitable for data without a "shape" column.', placement="right", options=list(container="body")),				
			    tipify(numericInput("pointsize4", "Point size:", value=0.8, min=0, max=2, step=0.05), 'Value used for different size of points. The option is suitable for data without a "size" column.', placement="right", options=list(container="body"))
            ),
			conditionalPanel(condition="input.plottype4=='heatmap_gradual' | input.plottype4=='heatmap_discrete' | input.plottype4=='rect_gradual' | input.plottype4=='rect_discrete' | input.plottype4=='bar'",
			    tipify(radioButtons("addborder4", "Add cell borders", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add borders to the grids, which can be used to separate cells from each other.", placement="right", options=list(container="body")),
			    conditionalPanel(condition="input.addborder4=='1'",
                    tipify(textInput("bordercols4", "Borders color:", value="black"),
					"The color to be used for the borders of grids. For example, 'white' or 'red'. Hex color codes as '#FF0000' are also supported.", placement="right", options=list(container="body"))
			    )
            ),
			conditionalPanel(condition="input.plottype4=='line' | input.plottype4=='point' | input.plottype4=='bar'",				
				tipify(radioButtons("xrugs4", "X-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the X-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.xrugs4=='1'",
				    textInput("xrugscol4", "Color:", value="black")				
				),				
				tipify(radioButtons("yrugs4", "Y-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the Y-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.yrugs4=='1'",
				    textInput("yrugscol4", "Color:", value="black")				
				),
	            tipify(radioButtons("ylabel4", "Y label", c("Show" = "1", "Hide" = "2"), selected="1"),
			"Add tick labels on the Y-axis.", placement="right", options=list(container="body"))								
			),
			conditionalPanel(condition="input.plottype4=='text'",
				textInput("textcol4", "Font color:", value="black"),			
			    numericInput("textsize4", "Font size:", value=2, min=0, max=100, step=0.5),
			    selectInput("fontface4", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),			    
				numericInput("textangle4", "Font angle:", value=60, min=-360, max=360, step=1)
			),
		    tipify(radioButtons("addlegend4", "Add legend", c("Yes" = "1", "No" = "2"), "2"),
			"Control the appearance of the legend in the plotting region.", placement="right", options=list(container="body")),			
			  conditionalPanel(condition="input.addlegend4=='1'",
			    conditionalPanel(condition="input.plottype4=='point' | input.plottype4=='line' | input.plottype4=='bar' | input.plottype4=='rect_gradual' | input.plottype4=='rect_discrete' | input.plottype4=='heatmap_gradual' | input.plottype4=='heatmap_discrete' | input.plottype4=='vertical line' | input.plottype4=='horizontal line' | input.plottype4=='text'",
		          radioButtons("collgd4", "Color legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.collgd4=='1'",
 				      tipify(textInput("collgdname4", "Name:", value="color"),
			          "Title of color legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  
					    conditionalPanel(condition="input.plottype4!='rect_gradual' & input.plottype4!='heatmap_gradual'",
					      tipify(radioButtons("collgdmdylabel4", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.collgdmdylabel4=='1'",
						    textInput("collgdlabel4", NULL, value="a,b,c")
					      )
						)
					)
				),
			    conditionalPanel(condition="input.plottype4=='point'",
		          radioButtons("sizelgd4", "Size legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.sizelgd4=='1'",
 				      tipify(textInput("sizelgdname4", "Name:", value="size"),
			          "Title of size legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  					  					  
				      tipify(radioButtons("sizelgdmdylabel4", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.sizelgdmdylabel4=='1'",
						    textInput("sizelgdlabel4", NULL, value="a,b,c")
	                      )
					),
		          radioButtons("shapelgd4", "Shape legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.shapelgd4=='1'",
 				      tipify(textInput("shapelgdname4", "Name:", value="shape"),
			          "Title of shape legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  
					  tipify(radioButtons("shapelgdmdylabel4", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.shapelgdmdylabel4=='1'",
						    textInput("shapelgdlabel4", NULL, value="a,b,c")
	                      )
					)
				),
			    conditionalPanel(condition="input.plottype4=='vertical line' | input.plottype4=='horizontal line'",
		          radioButtons("linetypelgd4", "Line type legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.linetypelgd4=='1'",
 				      tipify(textInput("linetypelgdname4", "Name:", value="linetype"),	
			          "Title of line type legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  					  
					  tipify(radioButtons("linetypelgdmdylabel4", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.linetypelgdmdylabel4=='1'",
						    textInput("linetypelgdlabel4", NULL, value="a")
	                      )
					)
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
		    tipify(fileInput("uploaddata5", "Upload data5:", multiple = FALSE),
			'Click "Browse" to upload the track data.', placement="right", options=list(container="body")),																										
			tags$script('$( "#uploaddata5" ).on( "click", function() { this.value = null; });'),
			selectInput("plottype5", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),	
			tipify(selectInput("layerindex5", "Track index:", choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks. The track index can be set at the choice of the users, if only one data file is uploaded.', placement="right", options=list(container="body")),																													
    	ADVANCED_OPTIONS_PANEL_5(
				list(
				conditionalPanel(condition="input.plottype5 == 'point' | input.plottype5 == 'line' | input.plottype5 == 'bar' | input.plottype5 == 'segment'",
			        tipify(radioButtons("coltype5", "Data color", c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
                    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should provide a character string representing one color as "red". To customize color for data with multiple groups, the column indicating different groups should be named as "color". Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', placement="right", options=list(container="body")),																								
					conditionalPanel(condition="input.coltype5=='2'",	
			            textInput("colorcus5", NULL, value="red")
			         ),
                    conditionalPanel(condition="input.coltype5=='3'",	
			            textInput("colormulgp5", NULL, value="a:red;b:blue;c:cyan")
	                )
				),
			conditionalPanel(condition="input.plottype5=='rect_discrete'",
			    tipify(radioButtons("rectcol5", "Data color", c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),											  
			conditionalPanel(condition="input.rectcol5=='2'",
			    textInput("rectcoldis5", NULL, value="red")
			),
			conditionalPanel(condition="input.rectcol5=='3'",
			    textInput("rectcoldiscus5", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype5=='rect_gradual'",
			    selectInput("colrect5", "Data color", choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange", 
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold", 
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange", 
			                                               "navy.cyan", "blue.red", "green.red"))
			),
			conditionalPanel(condition="input.plottype5=='heatmap_gradual'",			
			    tipify(radioButtons("heatmapcol5", "Colors", c("Typical" = "1", "Custom" = "2"), selected="1"), "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", placement="right", options=list(container="body")),			
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
			        HTML('<br>')
			)			
			),
			conditionalPanel(condition="input.plottype5=='heatmap_discrete'",
			    tipify(radioButtons("colhmapdis5", "Data color", c("Random" = "1", "Custom" = "2"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),
			conditionalPanel(condition="input.colhmapdis5=='2'",
			    textInput("colhmapdiscus5", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype5=='vertical line' | input.plottype5=='horizontal line'",	
			    tipify(textInput("linecolor5", "Line color:", value="black"),
			'The color to be used to plot the data. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body"))				
			),
			conditionalPanel(condition="input.plottype5=='line'",	
			    tipify(radioButtons("fillarea5", "Fill area", c("Yes" = "1", "No" = "2"),selected="2"),
			"Fill the area below the lines.", placement="right", options=list(container="body")),
                conditionalPanel(condition="input.fillarea5=='1'",			
			    tipify(radioButtons("selareatype5", "Area color", c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', placement="right", options=list(container="body")),
				conditionalPanel(condition="input.selareatype5=='2'",
			        textInput("borderarea5", NULL, value="blue")
			)
		    )			
			),			
			conditionalPanel(condition="input.plottype5!='rect_gradual' & input.plottype5!='heatmap_gradual' & input.plottype5!='text'",				
			    tipify(numericInput("coltransparency5", "Color transparency:", value=1, min=0, max=1, step=0.1),
			"A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", placement="right", options=list(container="body"))										  
            ),
			conditionalPanel(condition="input.plottype5=='line' | input.plottype5=='vertical line' | input.plottype5=='horizontal line' | input.plottype5 == 'segment'",	
			    numericInput("linesize5", "Line width:", value=0.2, min=0, max=20, step=0.05)
			),
			conditionalPanel(condition="input.plottype5=='line' | input.plottype5=='vertical line' | input.plottype5=='horizontal line' | input.plottype5 == 'segment'",	
			    tipify(selectInput("linetype5", "Line type", choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			'The line type is automatically set to "solid" for line with more than one color.',placement="right", options=list(container="body"))
			),
			conditionalPanel(condition="input.plottype5 == 'segment'",	
			    tipify(radioButtons("addarrow5", "Add arrow head", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add arrow head for the segment.", placement="right", options=list(container="body")),
			conditionalPanel(condition="input.addarrow5 == '1'",
			    tipify(radioButtons("arrowpos5", "Arrow position", c("Line end" = "1", "Line beginning" = "2"),selected="1"),
				'The position of arrow head.',placement="right", options=list(container="body")),				
				tipify(numericInput("arrowsize5", "Arrow size:", value=0.1, min=0, max=20, step=0.05),
			    'The size of arrow head.',placement="right", options=list(container="body"))								
            )
			),			
			conditionalPanel(condition="input.plottype5=='point'",			
                tipify(textInput("symbolpoint5", "Symbol type:", value="16"), 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. The option is suitable for data without a "shape" column.', placement="right", options=list(container="body")),				
			    tipify(numericInput("pointsize5", "Point size:", value=0.8, min=0, max=2, step=0.05), 'Value used for different size of points. The option is suitable for data without a "size" column.', placement="right", options=list(container="body"))
            ),
			conditionalPanel(condition="input.plottype5=='heatmap_gradual' | input.plottype5=='heatmap_discrete' | input.plottype5=='rect_gradual' | input.plottype5=='rect_discrete' | input.plottype5=='bar'",
			    tipify(radioButtons("addborder5", "Add cell borders", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add borders to the grids, which can be used to separate cells from each other.", placement="right", options=list(container="body")),
			    conditionalPanel(condition="input.addborder5=='1'",
                    tipify(textInput("bordercols5", "Borders color:", value="black"),
					"The color to be used for the borders of grids. For example, 'white' or 'red'. Hex color codes as '#FF0000' are also supported.", placement="right", options=list(container="body"))
			    )
            ),
			conditionalPanel(condition="input.plottype5=='line' | input.plottype5=='point' | input.plottype5=='bar'",				
				tipify(radioButtons("xrugs5", "X-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the X-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.xrugs5=='1'",
				    textInput("xrugscol5", "Color:", value="black")				
				),				
				tipify(radioButtons("yrugs5", "Y-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the Y-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.yrugs5=='1'",
				    textInput("yrugscol5", "Color:", value="black")				
				),
	            tipify(radioButtons("ylabel5", "Y label", c("Show" = "1", "Hide" = "2"), selected="1"),
			"Add tick labels on the Y-axis.", placement="right", options=list(container="body"))								
			),
			conditionalPanel(condition="input.plottype5=='text'",
				textInput("textcol5", "Font color:", value="black"),			
			    numericInput("textsize5", "Font size:", value=2, min=0, max=100, step=0.5),
			    selectInput("fontface5", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),			    
				numericInput("textangle5", "Font angle:", value=60, min=-360, max=360, step=1)
			),
		    tipify(radioButtons("addlegend5", "Add legend", c("Yes" = "1", "No" = "2"), "2"),
			"Control the appearance of the legend in the plotting region.", placement="right", options=list(container="body")),			
			  conditionalPanel(condition="input.addlegend5=='1'",
			    conditionalPanel(condition="input.plottype5=='point' | input.plottype5=='line' | input.plottype5=='bar' | input.plottype5=='rect_gradual' | input.plottype5=='rect_discrete' | input.plottype5=='heatmap_gradual' | input.plottype5=='heatmap_discrete' | input.plottype5=='vertical line' | input.plottype5=='horizontal line' | input.plottype5=='text'",
		          radioButtons("collgd5", "Color legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.collgd5=='1'",
 				      tipify(textInput("collgdname5", "Name:", value="color"),
			          "Title of color legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  
					    conditionalPanel(condition="input.plottype5!='rect_gradual' & input.plottype5!='heatmap_gradual'",
					      tipify(radioButtons("collgdmdylabel5", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),						
						  conditionalPanel(condition="input.collgdmdylabel5=='1'",
						    textInput("collgdlabel5", NULL, value="a,b,c")
					      )
						)
					)
				),
			    conditionalPanel(condition="input.plottype5=='point'",
		          radioButtons("sizelgd5", "Size legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.sizelgd5=='1'",
 				      tipify(textInput("sizelgdname5", "Name:", value="size"),
			          "Title of size legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  					  					  
				      tipify(radioButtons("sizelgdmdylabel5", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.sizelgdmdylabel5=='1'",
						    textInput("sizelgdlabel5", NULL, value="a,b,c")
	                      )
					),
		          radioButtons("shapelgd5", "Shape legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.shapelgd5=='1'",
 				      tipify(textInput("shapelgdname5", "Name:", value="shape"),
			          "Title of shape legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  
					  tipify(radioButtons("shapelgdmdylabel5", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.shapelgdmdylabel5=='1'",
						    textInput("shapelgdlabel5", NULL, value="a,b,c")
	                      )
					)
				),
			    conditionalPanel(condition="input.plottype5=='vertical line' | input.plottype5=='horizontal line'",
		          radioButtons("linetypelgd5", "Line type legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.linetypelgd5=='1'",
 				      tipify(textInput("linetypelgdname5", "Name:", value="linetype"),	
			          "Title of line type legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  					  
					  tipify(radioButtons("linetypelgdmdylabel5", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', placement="right", options=list(container="body")),				
						  conditionalPanel(condition="input.linetypelgdmdylabel5=='1'",
						    textInput("linetypelgdlabel5", NULL, value="a")
	                      )
					)
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
		    tipify(fileInput("uploaddata6", "Upload data6:", multiple = FALSE),
			'Click "Browse" to upload the track data.', placement="right", options=list(container="body")),																										
			tags$script('$( "#uploaddata6" ).on( "click", function() { this.value = null; });'),
			selectInput("plottype6", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),		
			tipify(selectInput("layerindex6", "Track index:", choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks. The track index can be set at the choice of the users, if only one data file is uploaded.', placement="right", options=list(container="body")),																													
    	ADVANCED_OPTIONS_PANEL_6(
				list(
				conditionalPanel(condition="input.plottype6 == 'point' | input.plottype6 == 'line' | input.plottype6 == 'bar' | input.plottype6 == 'segment'",
			        tipify(radioButtons("coltype6", "Data color", c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
                    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should provide a character string representing one color as "red". To customize color for data with multiple groups, the column indicating different groups should be named as "color". Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', placement="right", options=list(container="body")),																									
					conditionalPanel(condition="input.coltype6=='2'",	
			            textInput("colorcus6", NULL, value="red")
			         ),
                    conditionalPanel(condition="input.coltype6=='3'",	
			            textInput("colormulgp6", NULL, value="a:red;b:blue;c:cyan")
	                )
				),		
			conditionalPanel(condition="input.plottype6=='rect_discrete'",
			    tipify(radioButtons("rectcol6", "Data color", c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),										  
			conditionalPanel(condition="input.rectcol6=='2'",
			    textInput("rectcoldis6", NULL, value="red")
			),
			conditionalPanel(condition="input.rectcol6=='3'",
			    textInput("rectcoldiscus6", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype6=='rect_gradual'",
			    selectInput("colrect6", "Data color", choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange", 
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold", 
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange", 
			                                               "navy.cyan", "blue.red", "green.red"))
			),			
			conditionalPanel(condition="input.plottype6=='heatmap_gradual'",			
			    tipify(radioButtons("heatmapcol6", "Colors", c("Typical" = "1", "Custom" = "2"), selected="1"), "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", placement="right", options=list(container="body")),			
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
			        HTML('<br>')
			)			
			),
			conditionalPanel(condition="input.plottype6=='heatmap_discrete'",
			    tipify(radioButtons("colhmapdis6", "Data color", c("Random" = "1", "Custom" = "2"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),
			conditionalPanel(condition="input.colhmapdis6=='2'",
			    textInput("colhmapdiscus6", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype6=='vertical line' | input.plottype6=='horizontal line'",	
			    tipify(textInput("linecolor6", "Line color:", value="black"),
			'The color to be used to plot the data. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body"))				
			),
			conditionalPanel(condition="input.plottype6=='line'",	
			    tipify(radioButtons("fillarea6", "Fill area", c("Yes" = "1", "No" = "2"),selected="2"),
			"Fill the area below the lines.", placement="right", options=list(container="body")),
                conditionalPanel(condition="input.fillarea6=='1'",			
			    tipify(radioButtons("selareatype6", "Area color", c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', placement="right", options=list(container="body")),
				conditionalPanel(condition="input.selareatype6=='2'",
			        textInput("borderarea6", NULL, value="blue")
			)
		    )			
			),			
			conditionalPanel(condition="input.plottype6!='rect_gradual' & input.plottype6!='heatmap_gradual' & input.plottype6!='text'",				
			    tipify(numericInput("coltransparency6", "Color transparency:", value=1, min=0, max=1, step=0.1),
			"A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", placement="right", options=list(container="body"))										  
            ),
			conditionalPanel(condition="input.plottype6=='line' | input.plottype6=='vertical line' | input.plottype6=='horizontal line' | input.plottype6 == 'segment'",	
			    numericInput("linesize6", "Line width:", value=0.2, min=0, max=20, step=0.05)
			),
			conditionalPanel(condition="input.plottype6=='line' | input.plottype6=='vertical line' | input.plottype6=='horizontal line' | input.plottype6 == 'segment'",	
			    tipify(selectInput("linetype6", "Line type", choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			'The line type is automatically set to "solid" for line with more than one color.',placement="right", options=list(container="body"))
			),
			conditionalPanel(condition="input.plottype6 == 'segment'",	
			    tipify(radioButtons("addarrow6", "Add arrow head", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add arrow head for the segment.", placement="right", options=list(container="body")),
			conditionalPanel(condition="input.addarrow6 == '1'",
			    tipify(radioButtons("arrowpos6", "Arrow position", c("Line end" = "1", "Line beginning" = "2"),selected="1"),
				'The position of arrow head.',placement="right", options=list(container="body")),				
				tipify(numericInput("arrowsize6", "Arrow size:", value=0.1, min=0, max=20, step=0.05),
			    'The size of arrow head.',placement="right", options=list(container="body"))								
            )
			),			
			conditionalPanel(condition="input.plottype6=='point'",			
                tipify(textInput("symbolpoint6", "Symbol type:", value="16"), 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. The option is suitable for data without a "shape" column.', placement="right", options=list(container="body")),				
			    tipify(numericInput("pointsize6", "Point size:", value=0.8, min=0, max=2, step=0.05), 'Value used for different size of points. The option is suitable for data without a "size" column.', placement="right", options=list(container="body"))
            ),
			conditionalPanel(condition="input.plottype6=='heatmap_gradual' | input.plottype6=='heatmap_discrete' | input.plottype6=='rect_gradual' | input.plottype6=='rect_discrete' | input.plottype6=='bar'",
			    tipify(radioButtons("addborder6", "Add cell borders", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add borders to the grids, which can be used to separate cells from each other.", placement="right", options=list(container="body")),
			    conditionalPanel(condition="input.addborder6=='1'",
                    tipify(textInput("bordercols6", "Borders color:", value="black"),
					"The color to be used for the borders of grids. For example, 'white' or 'red'. Hex color codes as '#FF0000' are also supported.", placement="right", options=list(container="body"))
			    )
            ),
			conditionalPanel(condition="input.plottype6=='line' | input.plottype6=='point' | input.plottype6=='bar'",				
				tipify(radioButtons("xrugs6", "X-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the X-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.xrugs6=='1'",
				    textInput("xrugscol6", "Color:", value="black")				
				),				
				tipify(radioButtons("yrugs6", "Y-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the Y-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.yrugs6=='1'",
				    textInput("yrugscol6", "Color:", value="black")				
				),
	            tipify(radioButtons("ylabel6", "Y label", c("Show" = "1", "Hide" = "2"), selected="1"),
			"Add tick labels on the Y-axis.", placement="right", options=list(container="body"))								
			),
			conditionalPanel(condition="input.plottype6=='text'",
				textInput("textcol6", "Font color:", value="black"),			
			    numericInput("textsize6", "Font size:", value=2, min=0, max=100, step=0.5),
			    selectInput("fontface6", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),			    
				numericInput("textangle6", "Font angle:", value=60, min=-360, max=360, step=1)
			),
		    tipify(radioButtons("addlegend6", "Add legend", c("Yes" = "1", "No" = "2"), "2"),
			"Control the appearance of the legend in the plotting region.", placement="right", options=list(container="body")),			  			
			  conditionalPanel(condition="input.addlegend6=='1'",
			    conditionalPanel(condition="input.plottype6=='point' | input.plottype6=='line' | input.plottype6=='bar' | input.plottype6=='rect_gradual' | input.plottype6=='rect_discrete' | input.plottype6=='heatmap_gradual' | input.plottype6=='heatmap_discrete' | input.plottype6=='vertical line' | input.plottype6=='horizontal line' | input.plottype6=='text'",
		          radioButtons("collgd6", "Color legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.collgd6=='1'",
 				      tipify(textInput("collgdname6", "Name:", value="color"),
			          "Title of color legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  
					    conditionalPanel(condition="input.plottype6!='rect_gradual' & input.plottype6!='heatmap_gradual'",
					      tipify(radioButtons("collgdmdylabel6", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),						
						  conditionalPanel(condition="input.collgdmdylabel6=='1'",
						    textInput("collgdlabel6", NULL, value="a,b,c")
					      )
						)
					)
				),
			    conditionalPanel(condition="input.plottype6=='point'",
		          radioButtons("sizelgd6", "Size legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.sizelgd6=='1'",
 				      tipify(textInput("sizelgdname6", "Name:", value="size"),
			          "Title of size legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  					  					  
				      tipify(radioButtons("sizelgdmdylabel6", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.sizelgdmdylabel6=='1'",
						    textInput("sizelgdlabel6", NULL, value="a,b,c")
	                      )
					),
		          radioButtons("shapelgd6", "Shape legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.shapelgd6=='1'",
 				      tipify(textInput("shapelgdname6", "Name:", value="shape"),
			          "Title of shape legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  
					  tipify(radioButtons("shapelgdmdylabel6", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.shapelgdmdylabel6=='1'",
						    textInput("shapelgdlabel6", NULL, value="a,b,c")
	                      )
					)
				),
			    conditionalPanel(condition="input.plottype6=='vertical line' | input.plottype6=='horizontal line'",
		          radioButtons("linetypelgd6", "Line type legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.linetypelgd6=='1'",
 				      tipify(textInput("linetypelgdname6", "Name:", value="linetype"),	
			          "Title of line type legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  					  
					  tipify(radioButtons("linetypelgdmdylabel6", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', placement="right", options=list(container="body")),				
						  conditionalPanel(condition="input.linetypelgdmdylabel6=='1'",
						    textInput("linetypelgdlabel6", NULL, value="a")
	                      )
					)
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
		    tipify(fileInput("uploaddata7", "Upload data7:", multiple = FALSE),
			'Click "Browse" to upload the track data.', placement="right", options=list(container="body")),																										
			tags$script('$( "#uploaddata7" ).on( "click", function() { this.value = null; });'),
			selectInput("plottype7", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),		
	     	tipify(selectInput("layerindex7", "Track index:", choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks. The track index can be set at the choice of the users, if only one data file is uploaded.', placement="right", options=list(container="body")),																													
    	ADVANCED_OPTIONS_PANEL_7(
				list(
				conditionalPanel(condition="input.plottype7 == 'point' | input.plottype7 == 'line' | input.plottype7 == 'bar' | input.plottype7 == 'segment'",
			        tipify(radioButtons("coltype7", "Data color", c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
                    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should provide a character string representing one color as "red". To customize color for data with multiple groups, the column indicating different groups should be named as "color". Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', placement="right", options=list(container="body")),																									
					conditionalPanel(condition="input.coltype7=='2'",	
			            textInput("colorcus7", NULL, value="red")
			         ),
                    conditionalPanel(condition="input.coltype7=='3'",	
			            textInput("colormulgp7", NULL, value="a:red;b:blue;c:cyan")
	                )
				),
			conditionalPanel(condition="input.plottype7=='rect_discrete'",
			    tipify(radioButtons("rectcol7", "Data color", c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),											  
			conditionalPanel(condition="input.rectcol7=='2'",
			    textInput("rectcoldis7", NULL, value="red")
			),
			conditionalPanel(condition="input.rectcol7=='3'",
			    textInput("rectcoldiscus7", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype7=='rect_gradual'",
			    selectInput("colrect7", "Data color", choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange", 
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold", 
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange", 
			                                               "navy.cyan", "blue.red", "green.red"))
			),
			conditionalPanel(condition="input.plottype7=='heatmap_gradual'",			
			    tipify(radioButtons("heatmapcol7", "Colors", c("Typical" = "1", "Custom" = "2"), selected="1"), "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", placement="right", options=list(container="body")),			
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
			        HTML('<br>')
			)			
			),
			conditionalPanel(condition="input.plottype7=='heatmap_discrete'",
			    tipify(radioButtons("colhmapdis7", "Data color", c("Random" = "1", "Custom" = "2"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),
			conditionalPanel(condition="input.colhmapdis7=='2'",
			    textInput("colhmapdiscus7", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype7=='vertical line' | input.plottype7=='horizontal line'",	
			    tipify(textInput("linecolor7", "Line color:", value="black"),
			'The color to be used to plot the data. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body"))				
			),
			conditionalPanel(condition="input.plottype7=='line'",	
			    tipify(radioButtons("fillarea7", "Fill area", c("Yes" = "1", "No" = "2"),selected="2"),
			"Fill the area below the lines.", placement="right", options=list(container="body")),
                conditionalPanel(condition="input.fillarea7=='1'",			
			    tipify(radioButtons("selareatype7", "Area color", c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', placement="right", options=list(container="body")),
				conditionalPanel(condition="input.selareatype7=='2'",
			        textInput("borderarea7", NULL, value="blue")
			)
		    )			
			),			
			conditionalPanel(condition="input.plottype7!='rect_gradual' & input.plottype7!='heatmap_gradual' & input.plottype7!='text'",				
			    tipify(numericInput("coltransparency7", "Color transparency:", value=1, min=0, max=1, step=0.1),
			"A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", placement="right", options=list(container="body"))										  
            ),
			conditionalPanel(condition="input.plottype7=='line' | input.plottype7=='vertical line' | input.plottype7=='horizontal line' | input.plottype7 == 'segment'",	
			    numericInput("linesize7", "Line width:", value=0.2, min=0, max=20, step=0.05)
			),	
			conditionalPanel(condition="input.plottype7=='line' | input.plottype7=='vertical line' | input.plottype7=='horizontal line' | input.plottype7 == 'segment'",	
			    tipify(selectInput("linetype7", "Line type", choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			'The line type is automatically set to "solid" for line with more than one color.',placement="right", options=list(container="body"))
			),
			conditionalPanel(condition="input.plottype7 == 'segment'",	
			    tipify(radioButtons("addarrow7", "Add arrow head", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add arrow head for the segment.", placement="right", options=list(container="body")),
			conditionalPanel(condition="input.addarrow7 == '1'",
			    tipify(radioButtons("arrowpos7", "Arrow position", c("Line end" = "1", "Line beginning" = "2"),selected="1"),
				'The position of arrow head.',placement="right", options=list(container="body")),				
				tipify(numericInput("arrowsize7", "Arrow size:", value=0.1, min=0, max=20, step=0.05),
			    'The size of arrow head.',placement="right", options=list(container="body"))								
            )
			),			
			conditionalPanel(condition="input.plottype7=='point'",			
                tipify(textInput("symbolpoint7", "Symbol type:", value="16"), 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. The option is suitable for data without a "shape" column.', placement="right", options=list(container="body")),				
			    tipify(numericInput("pointsize7", "Point size:", value=0.8, min=0, max=2, step=0.05), 'Value used for different size of points. The option is suitable for data without a "size" column.', placement="right", options=list(container="body"))
            ),
			conditionalPanel(condition="input.plottype7=='heatmap_gradual' | input.plottype7=='heatmap_discrete' | input.plottype7=='rect_gradual' | input.plottype7=='rect_discrete' | input.plottype7=='bar'",
			    tipify(radioButtons("addborder7", "Add cell borders", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add borders to the grids, which can be used to separate cells from each other.", placement="right", options=list(container="body")),
			    conditionalPanel(condition="input.addborder7=='1'",
                    tipify(textInput("bordercols7", "Borders color:", value="black"),
					"The color to be used for the borders of grids. For example, 'white' or 'red'. Hex color codes as '#FF0000' are also supported.", placement="right", options=list(container="body"))
			    )
            ),
			conditionalPanel(condition="input.plottype7=='line' | input.plottype7=='point' | input.plottype7=='bar'",				
				tipify(radioButtons("xrugs7", "X-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the X-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.xrugs7=='1'",
				    textInput("xrugscol7", "Color:", value="black")				
				),				
				tipify(radioButtons("yrugs7", "Y-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the Y-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.yrugs7=='1'",
				    textInput("yrugscol7", "Color:", value="black")				
				),
	            tipify(radioButtons("ylabel7", "Y label", c("Show" = "1", "Hide" = "2"), selected="1"),
			"Add tick labels on the Y-axis.", placement="right", options=list(container="body"))								
			),
			conditionalPanel(condition="input.plottype7=='text'",
				textInput("textcol7", "Font color:", value="black"),			
			    numericInput("textsize7", "Font size:", value=2, min=0, max=100, step=0.5),
			    selectInput("fontface7", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),			    
				numericInput("textangle7", "Font angle:", value=60, min=-360, max=360, step=1)
			),
		    tipify(radioButtons("addlegend7", "Add legend", c("Yes" = "1", "No" = "2"), "2"),
			"Control the appearance of the legend in the plotting region.", placement="right", options=list(container="body")),			  			
			  conditionalPanel(condition="input.addlegend7=='1'",
			    conditionalPanel(condition="input.plottype7=='point' | input.plottype7=='line' | input.plottype7=='bar' | input.plottype7=='rect_gradual' | input.plottype7=='rect_discrete' | input.plottype7=='heatmap_gradual' | input.plottype7=='heatmap_discrete' | input.plottype7=='vertical line' | input.plottype7=='horizontal line' | input.plottype7=='text'",
		          radioButtons("collgd7", "Color legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.collgd7=='1'",
 				      tipify(textInput("collgdname7", "Name:", value="color"),
			          "Title of color legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  
					    conditionalPanel(condition="input.plottype7!='rect_gradual' & input.plottype7!='heatmap_gradual'",
					      tipify(radioButtons("collgdmdylabel7", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.collgdmdylabel7=='1'",
						    textInput("collgdlabel7", NULL, value="a,b,c")
					      )
						)
					)
				),
			    conditionalPanel(condition="input.plottype7=='point'",
		          radioButtons("sizelgd7", "Size legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.sizelgd7=='1'",
 				      tipify(textInput("sizelgdname7", "Name:", value="size"),
			          "Title of size legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  					  					  
				      tipify(radioButtons("sizelgdmdylabel7", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.sizelgdmdylabel7=='1'",
						    textInput("sizelgdlabel7", NULL, value="a,b,c")
	                      )
					),
		          radioButtons("shapelgd7", "Shape legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.shapelgd7=='1'",
 				      tipify(textInput("shapelgdname7", "Name:", value="shape"),
			          "Title of shape legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  
					  tipify(radioButtons("shapelgdmdylabel7", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),						
						  conditionalPanel(condition="input.shapelgdmdylabel7=='1'",
						    textInput("shapelgdlabel7", NULL, value="a,b,c")
	                      )
					)
				),
			    conditionalPanel(condition="input.plottype7=='vertical line' | input.plottype7=='horizontal line'",
		          radioButtons("linetypelgd7", "Line type legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.linetypelgd7=='1'",
 				      tipify(textInput("linetypelgdname7", "Name:", value="linetype"),		
			          "Title of line type legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  					  
					  tipify(radioButtons("linetypelgdmdylabel7", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.linetypelgdmdylabel7=='1'",
						    textInput("linetypelgdlabel7", NULL, value="a")
	                      )
					)
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
		    tipify(fileInput("uploaddata8", "Upload data8:", multiple = FALSE),
			'Click "Browse" to upload the track data.', placement="right", options=list(container="body")),																										
			tags$script('$( "#uploaddata8" ).on( "click", function() { this.value = null; });'),
			selectInput("plottype8", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),		
			tipify(selectInput("layerindex8", "Track index:", choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks. The track index can be set at the choice of the users, if only one data file is uploaded.', placement="right", options=list(container="body")),																													
    	ADVANCED_OPTIONS_PANEL_8(
				list(
				conditionalPanel(condition="input.plottype8 == 'point' | input.plottype8 == 'line' | input.plottype8 == 'bar' | input.plottype8 == 'segment'",
			        tipify(radioButtons("coltype8", "Data color", c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
                    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should provide a character string representing one color as "red". To customize color for data with multiple groups, the column indicating different groups should be named as "color". Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', placement="right", options=list(container="body")),																								
					conditionalPanel(condition="input.coltype8=='2'",	
			            textInput("colorcus8", NULL, value="red")
			         ),
                    conditionalPanel(condition="input.coltype8=='3'",	
			            textInput("colormulgp8", NULL, value="a:red;b:blue;c:cyan")
	                )
				),
			conditionalPanel(condition="input.plottype8=='rect_discrete'",
			    tipify(radioButtons("rectcol8", "Data color", c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),										  
			conditionalPanel(condition="input.rectcol8=='2'",
			    textInput("rectcoldis8", NULL, value="red")
			),
			conditionalPanel(condition="input.rectcol8=='3'",
			    textInput("rectcoldiscus8", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype8=='rect_gradual'",
			    selectInput("colrect8", "Data color", choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange", 
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold", 
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange", 
			                                               "navy.cyan", "blue.red", "green.red"))
			),
			conditionalPanel(condition="input.plottype8=='heatmap_gradual'",			
			    tipify(radioButtons("heatmapcol8", "Colors", c("Typical" = "1", "Custom" = "2"), selected="1"), "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", placement="right", options=list(container="body")),			
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
			        HTML('<br>')
			)			
			),
			conditionalPanel(condition="input.plottype8=='heatmap_discrete'",
			    tipify(radioButtons("colhmapdis8", "Data color", c("Random" = "1", "Custom" = "2"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),
			conditionalPanel(condition="input.colhmapdis8=='2'",
			    textInput("colhmapdiscus8", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype8=='vertical line' | input.plottype8=='horizontal line'",	
			    tipify(textInput("linecolor8", "Line color:", value="black"),
			'The color to be used to plot the data. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body"))				
			),
			conditionalPanel(condition="input.plottype8=='line'",	
			    tipify(radioButtons("fillarea8", "Fill area", c("Yes" = "1", "No" = "2"),selected="2"),
			"Fill the area below the lines.", placement="right", options=list(container="body")),
                conditionalPanel(condition="input.fillarea8=='1'",			
			    tipify(radioButtons("selareatype8", "Area color", c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', placement="right", options=list(container="body")),
				conditionalPanel(condition="input.selareatype8=='2'",
			        textInput("borderarea8", NULL, value="blue")
			)
		    )			
			),			
			conditionalPanel(condition="input.plottype8!='rect_gradual' & input.plottype8!='heatmap_gradual' & input.plottype8!='text'",				
			    tipify(numericInput("coltransparency8", "Color transparency:", value=1, min=0, max=1, step=0.1),
			"A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", placement="right", options=list(container="body"))										  
            ),
			conditionalPanel(condition="input.plottype8=='line' | input.plottype8=='vertical line' | input.plottype8=='horizontal line' | input.plottype8 == 'segment'",	
			    numericInput("linesize8", "Line width:", value=0.2, min=0, max=20, step=0.05)
			),
			conditionalPanel(condition="input.plottype8=='line' | input.plottype8=='vertical line' | input.plottype8=='horizontal line' | input.plottype8 == 'segment'",	
			    tipify(selectInput("linetype8", "Line type", choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			'The line type is automatically set to "solid" for line with more than one color.',placement="right", options=list(container="body"))
			),
			conditionalPanel(condition="input.plottype8 == 'segment'",	
			    tipify(radioButtons("addarrow8", "Add arrow head", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add arrow head for the segment.", placement="right", options=list(container="body")),
			conditionalPanel(condition="input.addarrow8 == '1'",
			    tipify(radioButtons("arrowpos8", "Arrow position", c("Line end" = "1", "Line beginning" = "2"),selected="1"),
				'The position of arrow head.',placement="right", options=list(container="body")),				
				tipify(numericInput("arrowsize8", "Arrow size:", value=0.1, min=0, max=20, step=0.05),
			    'The size of arrow head.',placement="right", options=list(container="body"))								
            )
			),			
			conditionalPanel(condition="input.plottype8=='point'",			
                tipify(textInput("symbolpoint8", "Symbol type:", value="16"), 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. The option is suitable for data without a "shape" column.', placement="right", options=list(container="body")),				
			    tipify(numericInput("pointsize8", "Point size:", value=0.8, min=0, max=2, step=0.05), 'Value used for different size of points. The option is suitable for data without a "size" column.', placement="right", options=list(container="body"))
            ),
			conditionalPanel(condition="input.plottype8=='heatmap_gradual' | input.plottype8=='heatmap_discrete' | input.plottype8=='rect_gradual' | input.plottype8=='rect_discrete' | input.plottype8=='bar'",
			    tipify(radioButtons("addborder8", "Add cell borders", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add borders to the grids, which can be used to separate cells from each other.", placement="right", options=list(container="body")),
			    conditionalPanel(condition="input.addborder8=='1'",
                    tipify(textInput("bordercols8", "Borders color:", value="black"),
					"The color to be used for the borders of grids. For example, 'white' or 'red'. Hex color codes as '#FF0000' are also supported.", placement="right", options=list(container="body"))
			    )
            ),
			conditionalPanel(condition="input.plottype8=='line' | input.plottype8=='point' | input.plottype8=='bar'",				
				tipify(radioButtons("xrugs8", "X-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the X-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.xrugs8=='1'",
				    textInput("xrugscol8", "Color:", value="black")				
				),				
				tipify(radioButtons("yrugs8", "Y-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the Y-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.yrugs8=='1'",
				    textInput("yrugscol8", "Color:", value="black")				
				),
	            tipify(radioButtons("ylabel8", "Y label", c("Show" = "1", "Hide" = "2"), selected="1"),
			"Add tick labels on the Y-axis.", placement="right", options=list(container="body"))								
			),
			conditionalPanel(condition="input.plottype8=='text'",
				textInput("textcol8", "Font color:", value="black"),			
			    numericInput("textsize8", "Font size:", value=2, min=0, max=100, step=0.5),
			    selectInput("fontface8", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),			    
				numericInput("textangle8", "Font angle:", value=60, min=-360, max=360, step=1)
			),
		    tipify(radioButtons("addlegend8", "Add legend", c("Yes" = "1", "No" = "2"), "2"),
			"Control the appearance of the legend in the plotting region.", placement="right", options=list(container="body")),			  			
			  conditionalPanel(condition="input.addlegend8=='1'",
			    conditionalPanel(condition="input.plottype8=='point' | input.plottype8=='line' | input.plottype8=='bar' | input.plottype8=='rect_gradual' | input.plottype8=='rect_discrete' | input.plottype8=='heatmap_gradual' | input.plottype8=='heatmap_discrete' | input.plottype8=='vertical line' | input.plottype8=='horizontal line' | input.plottype8=='text'",
		          radioButtons("collgd8", "Color legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.collgd8=='1'",
 				      tipify(textInput("collgdname8", "Name:", value="color"),		
			          "Title of color legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  
					    conditionalPanel(condition="input.plottype8!='rect_gradual' & input.plottype8!='heatmap_gradual'",
					      tipify(radioButtons("collgdmdylabel8", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.collgdmdylabel8=='1'",
						    textInput("collgdlabel8", NULL, value="a,b,c")
					      )
						)
					)
				),
			    conditionalPanel(condition="input.plottype8=='point'",
		          radioButtons("sizelgd8", "Size legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.sizelgd8=='1'",
 				      tipify(textInput("sizelgdname8", "Name:", value="size"),
			          "Title of size legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  					  					  
				      tipify(radioButtons("sizelgdmdylabel8", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.sizelgdmdylabel8=='1'",
						    textInput("sizelgdlabel8", NULL, value="a,b,c")
	                      )
					),
		          radioButtons("shapelgd8", "Shape legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.shapelgd8=='1'",
 				      tipify(textInput("shapelgdname8", "Name:", value="shape"),
			          "Title of shape legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  
					  tipify(radioButtons("shapelgdmdylabel8", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.shapelgdmdylabel8=='1'",
						    textInput("shapelgdlabel8", NULL, value="a,b,c")
	                      )
					)
				),
			    conditionalPanel(condition="input.plottype8=='vertical line' | input.plottype8=='horizontal line'",
		          radioButtons("linetypelgd8", "Line type legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.linetypelgd8=='1'",
 				      tipify(textInput("linetypelgdname8", "Name:", value="linetype"),	
			          "Title of line type legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  					  
					  tipify(radioButtons("linetypelgdmdylabel8", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', placement="right", options=list(container="body")),						
						  conditionalPanel(condition="input.linetypelgdmdylabel8=='1'",
						    textInput("linetypelgdlabel8", NULL, value="a")
	                      )
					)
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
		    tipify(fileInput("uploaddata9", "Upload data9:", multiple = FALSE),
			'Click "Browse" to upload the track data.', placement="right", options=list(container="body")),																										
			tags$script('$( "#uploaddata9" ).on( "click", function() { this.value = null; });'),
			selectInput("plottype9", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),
			tipify(selectInput("layerindex9", "Track index:", choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks. The track index can be set at the choice of the users, if only one data file is uploaded.', placement="right", options=list(container="body")),																													
    	ADVANCED_OPTIONS_PANEL_9(
				list(
				conditionalPanel(condition="input.plottype9 == 'point' | input.plottype9 == 'line' | input.plottype9 == 'bar' | input.plottype9 == 'segment'",
			        tipify(radioButtons("coltype9", "Data color", c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
                    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should provide a character string representing one color as "red". To customize color for data with multiple groups, the column indicating different groups should be named as "color". Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', placement="right", options=list(container="body")),																								
					conditionalPanel(condition="input.coltype9=='2'",	
			            textInput("colorcus9", NULL, value="red")
			         ),
                    conditionalPanel(condition="input.coltype9=='3'",	
			            textInput("colormulgp9", NULL, value="a:red;b:blue;c:cyan")
	                )
				),		
			conditionalPanel(condition="input.plottype9=='rect_discrete'",
			    tipify(radioButtons("rectcol9", "Data color", c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),										  
			conditionalPanel(condition="input.rectcol9=='2'",
			    textInput("rectcoldis9", NULL, value="red")
			),
			conditionalPanel(condition="input.rectcol9=='3'",
			    textInput("rectcoldiscus9", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype9=='rect_gradual'",
			    selectInput("colrect9", "Data color", choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange", 
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold", 
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange", 
			                                               "navy.cyan", "blue.red", "green.red"))
			),
			conditionalPanel(condition="input.plottype9=='heatmap_gradual'",			
			    tipify(radioButtons("heatmapcol9", "Colors", c("Typical" = "1", "Custom" = "2"), selected="1"), "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", placement="right", options=list(container="body")),			
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
			        HTML('<br>')
			)			
			),
			conditionalPanel(condition="input.plottype9=='heatmap_discrete'",
			    tipify(radioButtons("colhmapdis9", "Data color", c("Random" = "1", "Custom" = "2"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),
			conditionalPanel(condition="input.colhmapdis9=='2'",
			    textInput("colhmapdiscus9", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype9=='vertical line' | input.plottype9=='horizontal line'",	
			    tipify(textInput("linecolor9", "Line color:", value="black"),
			'The color to be used to plot the data. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body"))				
			),
			conditionalPanel(condition="input.plottype9=='line'",	
			    tipify(radioButtons("fillarea9", "Fill area", c("Yes" = "1", "No" = "2"),selected="2"),
			"Fill the area below the lines.", placement="right", options=list(container="body")),
                conditionalPanel(condition="input.fillarea9=='1'",			
			    tipify(radioButtons("selareatype9", "Area color", c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', placement="right", options=list(container="body")),
				conditionalPanel(condition="input.selareatype9=='2'",
			        textInput("borderarea9", NULL, value="blue")
			)
		    )			
			),			
			conditionalPanel(condition="input.plottype9!='rect_gradual' & input.plottype9!='heatmap_gradual' & input.plottype9!='text'",				
			    tipify(numericInput("coltransparency9", "Color transparency:", value=1, min=0, max=1, step=0.1),
			"A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", placement="right", options=list(container="body"))										  
            ),
			conditionalPanel(condition="input.plottype9=='line' | input.plottype9=='vertical line' | input.plottype9=='horizontal line' | input.plottype9 == 'segment'",	
			    numericInput("linesize9", "Line width:", value=0.2, min=0, max=20, step=0.05)
			),
			conditionalPanel(condition="input.plottype9=='line' | input.plottype9=='vertical line' | input.plottype9=='horizontal line' | input.plottype9 == 'segment'",	
			    tipify(selectInput("linetype9", "Line type", choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			'The line type is automatically set to "solid" for line with more than one color.',placement="right", options=list(container="body"))
			),
			conditionalPanel(condition="input.plottype9 == 'segment'",	
			    tipify(radioButtons("addarrow9", "Add arrow head", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add arrow head for the segment.", placement="right", options=list(container="body")),
			conditionalPanel(condition="input.addarrow9 == '1'",
			    tipify(radioButtons("arrowpos9", "Arrow position", c("Line end" = "1", "Line beginning" = "2"),selected="1"),
				'The position of arrow head.',placement="right", options=list(container="body")),				
				tipify(numericInput("arrowsize9", "Arrow size:", value=0.1, min=0, max=20, step=0.05),
			    'The size of arrow head.',placement="right", options=list(container="body"))								
            )
			),			
			conditionalPanel(condition="input.plottype9=='point'",			
                tipify(textInput("symbolpoint9", "Symbol type:", value="16"), 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. The option is suitable for data without a "shape" column.', placement="right", options=list(container="body")),				
			    tipify(numericInput("pointsize9", "Point size:", value=0.8, min=0, max=2, step=0.05), 'Value used for different size of points. The option is suitable for data without a "size" column.', placement="right", options=list(container="body"))
            ),
			conditionalPanel(condition="input.plottype9=='heatmap_gradual' | input.plottype9=='heatmap_discrete' | input.plottype9=='rect_gradual' | input.plottype9=='rect_discrete' | input.plottype9=='bar'",
			    tipify(radioButtons("addborder9", "Add cell borders", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add borders to the grids, which can be used to separate cells from each other.", placement="right", options=list(container="body")),
			    conditionalPanel(condition="input.addborder9=='1'",
                    tipify(textInput("bordercols9", "Borders color:", value="black"),
					"The color to be used for the borders of grids. For example, 'white' or 'red'. Hex color codes as '#FF0000' are also supported.", placement="right", options=list(container="body"))
			    )
            ),
			conditionalPanel(condition="input.plottype9=='line' | input.plottype9=='point' | input.plottype9=='bar'",				
				tipify(radioButtons("xrugs9", "X-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the X-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.xrugs9=='1'",
				    textInput("xrugscol9", "Color:", value="black")				
				),				
				tipify(radioButtons("yrugs9", "Y-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the Y-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.yrugs9=='1'",
				    textInput("yrugscol9", "Color:", value="black")				
				),
	            tipify(radioButtons("ylabel9", "Y label", c("Show" = "1", "Hide" = "2"), selected="1"),
			"Add tick labels on the Y-axis.", placement="right", options=list(container="body"))								
			),
			conditionalPanel(condition="input.plottype9=='text'",
				textInput("textcol9", "Font color:", value="black"),			
			    numericInput("textsize9", "Font size:", value=2, min=0, max=100, step=0.5),
			    selectInput("fontface9", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),			    
				numericInput("textangle9", "Font angle:", value=60, min=-360, max=360, step=1)
			),
		    tipify(radioButtons("addlegend9", "Add legend", c("Yes" = "1", "No" = "2"), "2"),
			"Control the appearance of the legend in the plotting region.", placement="right", options=list(container="body")),			  			
			  conditionalPanel(condition="input.addlegend9=='1'",
			    conditionalPanel(condition="input.plottype9=='point' | input.plottype9=='line' | input.plottype9=='bar' | input.plottype9=='rect_gradual' | input.plottype9=='rect_discrete' | input.plottype9=='heatmap_gradual' | input.plottype9=='heatmap_discrete' | input.plottype9=='vertical line' | input.plottype9=='horizontal line' | input.plottype9=='text'",
		          radioButtons("collgd9", "Color legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.collgd9=='1'",
 				      tipify(textInput("collgdname9", "Name:", value="color"),
			          "Title of color legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  
					    conditionalPanel(condition="input.plottype9!='rect_gradual' & input.plottype9!='heatmap_gradual'",
					      tipify(radioButtons("collgdmdylabel9", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.collgdmdylabel9=='1'",
						    textInput("collgdlabel9", NULL, value="a,b,c")
					      )
						)
					)
				),
			    conditionalPanel(condition="input.plottype9=='point'",
		          radioButtons("sizelgd9", "Size legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.sizelgd9=='1'",
 				      tipify(textInput("sizelgdname9", "Name:", value="size"),
			          "Title of size legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  					  					  
				      tipify(radioButtons("sizelgdmdylabel9", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),						
						  conditionalPanel(condition="input.sizelgdmdylabel9=='1'",
						    textInput("sizelgdlabel9", NULL, value="a,b,c")
	                      )
					),
		          radioButtons("shapelgd9", "Shape legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.shapelgd9=='1'",
 				      tipify(textInput("shapelgdname9", "Name:", value="shape"),
			          "Title of shape legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  
					  tipify(radioButtons("shapelgdmdylabel9", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),						
						  conditionalPanel(condition="input.shapelgdmdylabel9=='1'",
						    textInput("shapelgdlabel9", NULL, value="a,b,c")
	                      )
					)
				),
			    conditionalPanel(condition="input.plottype9=='vertical line' | input.plottype9=='horizontal line'",
		          radioButtons("linetypelgd9", "Line type legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.linetypelgd9=='1'",
 				      tipify(textInput("linetypelgdname9", "Name:", value="linetype"),		
			          "Title of line type legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  					  
					  tipify(radioButtons("linetypelgdmdylabel9", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.linetypelgdmdylabel9=='1'",
						    textInput("linetypelgdlabel9", NULL, value="a")
	                      )
					)
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
		    tipify(fileInput("uploaddata10", "Upload data10:", multiple = FALSE),
			'Click "Browse" to upload the track data.', placement="right", options=list(container="body")),																										
			tags$script('$( "#uploaddata10" ).on( "click", function() { this.value = null; });'),
			selectInput("plottype10", "Plot type:", choices = c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment", "vertical line", "horizontal line"), selected="point"),		
			tipify(selectInput("layerindex10", "Track index:", choices = c("track1", "track2", "track3", "track4", "track5", "track6", "track7", "track8", "track9", "track10"), selected="track1"),
			'Data with the same track index will be plotted in the same track, while data with different track indices will be displayed in differing tracks. The track index can be set at the choice of the users, if only one data file is uploaded.', placement="right", options=list(container="body")),																													
    	ADVANCED_OPTIONS_PANEL_10(
				list(
				conditionalPanel(condition="input.plottype10 == 'point' | input.plottype10 == 'line' | input.plottype10 == 'bar' | input.plottype10 == 'segment'",
			        tipify(radioButtons("coltype10", "Data color", c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
                    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should provide a character string representing one color as "red". To customize color for data with multiple groups, the column indicating different groups should be named as "color". Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', placement="right", options=list(container="body")),																									
					conditionalPanel(condition="input.coltype10=='2'",	
			            textInput("colorcus10", NULL, value="red")
			         ),
                    conditionalPanel(condition="input.coltype10=='3'",	
			            textInput("colormulgp10", NULL, value="a:red;b:blue;c:cyan")
	                )
				),		
			conditionalPanel(condition="input.plottype10=='rect_discrete'",
			    tipify(radioButtons("rectcol10", "Data color", c("Random" = "1", "Specific" = "2", "Custom" = "3"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),										  
			conditionalPanel(condition="input.rectcol10=='2'",
			    textInput("rectcoldis10", NULL, value="red")
			),
			conditionalPanel(condition="input.rectcol10=='3'",
			    textInput("rectcoldiscus10", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype10=='rect_gradual'",
			    selectInput("colrect10", "Data color", choices = c("blue", "red", "green", "cyan", "purple", "pink", "orange", 
			                                               "yellow", "navy", "seagreen", "maroon", "olivedrab", "gold", 
			                                               "lightblue", "navy.yellow", "purple.seagreen", "navy.orange", 
			                                               "navy.cyan", "blue.red", "green.red"))
			),
			conditionalPanel(condition="input.plottype10=='heatmap_gradual'",			
			    tipify(radioButtons("heatmapcol10", "Colors", c("Typical" = "1", "Custom" = "2"), selected="1"), "Colors to be used for the heatmap, which can be assigned by the application or be specified by the users.", placement="right", options=list(container="body")),			
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
			        HTML('<br>')
			)			
			),
			conditionalPanel(condition="input.plottype10=='heatmap_discrete'",
			    tipify(radioButtons("colhmapdis10", "Data color", c("Random" = "1", "Custom" = "2"), selected="1"),
			    'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. If "Custom" was chosen, the 4th column of the uploaded data should be a categorical character vector with no more than 50 groups. Users should provide values as "a:red;b:green;c:blue", in which "a b c" represent different data categories indicated by the 4th column of the uploaded data. Color for data without custom color will be set to NULL. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body")),
			conditionalPanel(condition="input.colhmapdis10=='2'",
			    textInput("colhmapdiscus10", NULL, value="a:red;b:blue;c:cyan")
			)
			),
			conditionalPanel(condition="input.plottype10=='vertical line' | input.plottype10=='horizontal line'",	
			    tipify(textInput("linecolor10", "Line color:", value="black"),
			'The color to be used to plot the data. Hex color codes as "#FF0000" are also supported.', placement="right", options=list(container="body"))				
			),
			conditionalPanel(condition="input.plottype10=='line'",	
			    tipify(radioButtons("fillarea10", "Fill area", c("Yes" = "1", "No" = "2"),selected="2"),
			"Fill the area below the lines.", placement="right", options=list(container="body")),
                conditionalPanel(condition="input.fillarea10=='1'",			
			    tipify(radioButtons("selareatype10", "Area color", c("Identical with lines" = "1", "Specific" = "2"),selected="1"),
			'Fill the area with color, which can be identical with lines color or be specified by the users. If "Specific" was chosen, all data will be filled by a specified color as "blue".', placement="right", options=list(container="body")),
				conditionalPanel(condition="input.selareatype10=='2'",
			        textInput("borderarea10", NULL, value="blue")
			)
		    )			
			),			
			conditionalPanel(condition="input.plottype10!='rect_gradual' & input.plottype10!='heatmap_gradual' & input.plottype10!='text'",				
			    tipify(numericInput("coltransparency10", "Color transparency:", value=1, min=0, max=1, step=0.1),
			"A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", placement="right", options=list(container="body"))										  
            ),
			conditionalPanel(condition="input.plottype10=='line' | input.plottype10=='vertical line' | input.plottype10=='horizontal line' | input.plottype10 == 'segment'",	
			    numericInput("linesize10", "Line width:", value=0.2, min=0, max=20, step=0.05)
			),
			conditionalPanel(condition="input.plottype10=='line' | input.plottype10=='vertical line' | input.plottype10=='horizontal line' | input.plottype10 == 'segment'",	
			    tipify(selectInput("linetype10", "Line type", choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			'The line type is automatically set to "solid" for line with more than one color.',placement="right", options=list(container="body"))
			),
			conditionalPanel(condition="input.plottype10 == 'segment'",	
			    tipify(radioButtons("addarrow10", "Add arrow head", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add arrow head for the segment.", placement="right", options=list(container="body")),
			conditionalPanel(condition="input.addarrow10 == '1'",
			    tipify(radioButtons("arrowpos10", "Arrow position", c("Line end" = "1", "Line beginning" = "2"),selected="1"),
				'The position of arrow head.',placement="right", options=list(container="body")),				
				tipify(numericInput("arrowsize10", "Arrow size:", value=0.1, min=0, max=20, step=0.05),
			    'The size of arrow head.',placement="right", options=list(container="body"))								
            )
			),			
			conditionalPanel(condition="input.plottype10=='point'",			
                tipify(textInput("symbolpoint10", "Symbol type:", value="16"), 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. The option is suitable for data without a "shape" column.', placement="right", options=list(container="body")),				
			    tipify(numericInput("pointsize10", "Point size:", value=0.8, min=0, max=2, step=0.05), 'Value used for different size of points. The option is suitable for data without a "size" column.', placement="right", options=list(container="body"))
            ),
			conditionalPanel(condition="input.plottype10=='heatmap_gradual' | input.plottype10=='heatmap_discrete' | input.plottype10=='rect_gradual' | input.plottype10=='rect_discrete' | input.plottype10=='bar'",
			    tipify(radioButtons("addborder10", "Add cell borders", c("Yes" = "1", "No" = "2"),selected="2"),
				"Add borders to the grids, which can be used to separate cells from each other.", placement="right", options=list(container="body")),
			    conditionalPanel(condition="input.addborder10=='1'",
                    tipify(textInput("bordercols10", "Borders color:", value="black"),
					"The color to be used for the borders of grids. For example, 'white' or 'red'. Hex color codes as '#FF0000' are also supported.", placement="right", options=list(container="body"))
			    )
            ),
			conditionalPanel(condition="input.plottype10=='line' | input.plottype10=='point' | input.plottype10=='bar'",				
				tipify(radioButtons("xrugs10", "X-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the X-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.xrugs10=='1'",
				    textInput("xrugscol10", "Color:", value="black")				
				),				
				tipify(radioButtons("yrugs10", "Y-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			"Create a set of tick marks along the Y-axis.", placement="right", options=list(container="body")),
				conditionalPanel(condition="input.yrugs10=='1'",
				    textInput("yrugscol10", "Color:", value="black")				
				),
	            tipify(radioButtons("ylabel10", "Y label", c("Show" = "1", "Hide" = "2"), selected="1"),
			"Add tick labels on the Y-axis.", placement="right", options=list(container="body"))								
			),
			conditionalPanel(condition="input.plottype10=='text'",
				textInput("textcol10", "Font color:", value="black"),			
			    numericInput("textsize10", "Font size:", value=2, min=0, max=100, step=0.5),
			    selectInput("fontface10", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),			    
				numericInput("textangle10", "Font angle:", value=60, min=-360, max=360, step=1)
			),
		    tipify(radioButtons("addlegend10", "Add legend", c("Yes" = "1", "No" = "2"), "2"),
			"Control the appearance of the legend in the plotting region.", placement="right", options=list(container="body")),			  			
			  conditionalPanel(condition="input.addlegend10=='1'",
			    conditionalPanel(condition="input.plottype10=='point' | input.plottype10=='line' | input.plottype10=='bar' | input.plottype10=='rect_gradual' | input.plottype10=='rect_discrete' | input.plottype10=='heatmap_gradual' | input.plottype10=='heatmap_discrete' | input.plottype10=='vertical line' | input.plottype10=='horizontal line' | input.plottype10=='text'",
		          radioButtons("collgd10", "Color legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.collgd10=='1'",
 				      tipify(textInput("collgdname10", "Name:", value="color"),	
			          "Title of color legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  
					    conditionalPanel(condition="input.plottype10!='rect_gradual' & input.plottype10!='heatmap_gradual'",
					      tipify(radioButtons("collgdmdylabel10", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),						
						  conditionalPanel(condition="input.collgdmdylabel10=='1'",
						    textInput("collgdlabel10", NULL, value="a,b,c")
					      )
						)
					)
				),
			    conditionalPanel(condition="input.plottype10=='point'",
		          radioButtons("sizelgd10", "Size legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.sizelgd10=='1'",
 				      tipify(textInput("sizelgdname10", "Name:", value="size"),
			          "Title of size legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  					  					  
				      tipify(radioButtons("sizelgdmdylabel10", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.sizelgdmdylabel10=='1'",
						    textInput("sizelgdlabel10", NULL, value="a,b,c")
	                      )
					),
		          radioButtons("shapelgd10", "Shape legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.shapelgd10=='1'",
 				      tipify(textInput("shapelgdname10", "Name:", value="shape"),
			          "Title of shape legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      				      
					  tipify(radioButtons("shapelgdmdylabel10", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.shapelgdmdylabel10=='1'",
						    textInput("shapelgdlabel10", NULL, value="a,b,c")
	                      )
					)
				),
			    conditionalPanel(condition="input.plottype10=='vertical line' | input.plottype10=='horizontal line'",
		          radioButtons("linetypelgd10", "Line type legend", c("Yes" = "1", "No" = "2"), "2"),
			        conditionalPanel(condition="input.linetypelgd10=='1'",
 				      tipify(textInput("linetypelgdname10", "Name:", value="linetype"),
			          "Title of line type legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      					  					  
					  tipify(radioButtons("linetypelgdmdylabel10", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                          'The labels of legend can be assigned by the application or be specified by the users, which should contain only one character as "a".', placement="right", options=list(container="body")),					
						  conditionalPanel(condition="input.linetypelgdmdylabel10=='1'",
						    textInput("linetypelgdlabel10", NULL, value="a")
	                      )
					)
				)
			  )		
			)
			)			
		   )
		),		
		HTML('<br>'),
        tipify(actionButton("submit1", strong("Go!")),
		'Please click the "Go!" button, if suitable data is uploaded or any options are modified.', placement="right", options=list(container="body")),							  					  				      					  					  		
        br(),
        h4("Plot options"),
    	ADVANCED_OPTIONS_PANEL(
				list(
                    tipify(checkboxInput("plotSize", "Adjust plot size", FALSE),
			          "Adjust the height and width of the non-circular plot. The figure size in both the browser and the download files would be affected.", placement="right", options=list(container="body")),							  					  				      				      					
                    conditionalPanel(condition = "input.plotSize",
                        numericInput("Height", "Plot height:", value = 550),
                        numericInput("Width", "Plot width:", value = 750)
                    ),
                    tipify(checkboxInput("plotheme", "Figure theme", FALSE),
                    "Figure themes which control all non-data display.", placement="right", options=list(container="body")),					
                    conditionalPanel(condition = "input.plotheme",					
			            selectInput("themestyle", NULL, choices = c("theme1", "theme2", "theme3", 
	                                                      "theme4", "theme5", "theme6", 
	                                                      "theme7","theme8","theme9","theme10"), selected="theme1")
														  ),
                    checkboxInput("selfontsize", "Font size", FALSE),
                    conditionalPanel(condition = "input.selfontsize",					
			            numericInput("fontSize", NULL, value=16, min=0, max=100, step=0.5)														  
														  ),														  
                    tipify(checkboxInput("addtitle", "Axis title", FALSE),
                    "Modify axis title of non-circular plot.", placement="right", options=list(container="body")),									
                    conditionalPanel(condition = "input.addtitle",
                        textInput("xtitle", "X title:", value="Genomic position"),
			            textInput("ytitle", "Y title:", value="Value"),
			            selectInput("titlefontface", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain")
														  ),
                    checkboxInput("addlabels", "X axis label", FALSE),
                    conditionalPanel(condition = "input.addlabels",					
			            tipify(radioButtons("xlabel", NULL, c("Show" = "1", "Hide" = "2"), selected="1"),
			        "Add tick labels on the Y-axis.", placement="right", options=list(container="body"))										
					),					
                    checkboxInput("legends", "Legend", FALSE),
                    conditionalPanel(condition = "input.legends",
			            tipify(radioButtons("legendpos", "Position", c("Right" = "1", "Bottom" = "2"), selected="1"),
			            "The position to place the legend.", placement="right", options=list(container="body")),						
						tipify(numericInput("lgdspacesize", "Space size", value=0.04, min=0, max=1, step=0.05),
						"Percent of legend size relative to the main plotting region. Applicable values are numbers in [0-1].", placement="right", options=list(container="body")),
						tipify(numericInput("lgdintrasize", "Intra-spacing", value=15, min=0, max=100, step=1),
						"Intra-spacing between different legends.", placement="right", options=list(container="body")),						
			            tipify(numericInput("lgdtitlesize", "Title size", value=10, min=0, max=100, step=0.5),
						    "The font size of legend title.", placement="right", options=list(container="body")),						
			            tipify(selectInput("lgdtitlefontface", "Title font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
						    "The font face of legend title.", placement="right", options=list(container="body")),						
						tipify(numericInput("lgdtextsize", "Label size", value=10, min=0, max=100, step=0.5),
						    "The font size of legend tick label.", placement="right", options=list(container="body")),			            
						tipify(selectInput("lgdtextfontface", "Label font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),	
						    "The font face of legend tick label.", placement="right", options=list(container="body"))
					),					
					checkboxInput("layer1", HTML("<font color='red'>Track1</font>"), FALSE),
			            conditionalPanel(condition="input.layer1",
						        tipify(numericInput("heightlayer1", "Track height:", value=0.06, min=0, max=0.8, step=0.01),
								"Height of the track.", placement="right", options=list(container="body")),
			                    tipify(numericInput("marginlayer1", "Track margin:", value=0.01, min=0, max=0.8, step=0.005), 
								"Margin size of the track.", placement="right", options=list(container="body"))	
						),
					checkboxInput("layer2", HTML("<font color='red'>Track2</font>"), FALSE),
			            conditionalPanel(condition="input.layer2",
						        tipify(numericInput("heightlayer2", "Track height:", value=0.06, min=0, max=0.8, step=0.01),
								"Height of the track.", placement="right", options=list(container="body")),
			                    tipify(numericInput("marginlayer2", "Track margin:", value=0.01, min=0, max=0.8, step=0.005), 
								"Margin size of the track.", placement="right", options=list(container="body"))
						),					
					checkboxInput("layer3", HTML("<font color='red'>Track3</font>"), FALSE),
			            conditionalPanel(condition="input.layer3",
						        tipify(numericInput("heightlayer3", "Track height:", value=0.06, min=0, max=0.8, step=0.01),
								"Height of the track.", placement="right", options=list(container="body")),
			                    tipify(numericInput("marginlayer3", "Track margin:", value=0.01, min=0, max=0.8, step=0.005), 
								"Margin size of the track.", placement="right", options=list(container="body"))
						),					
					checkboxInput("layer4", HTML("<font color='red'>Track4</font>"), FALSE),
			            conditionalPanel(condition="input.layer4",
						        tipify(numericInput("heightlayer4", "Track height:", value=0.06, min=0, max=0.8, step=0.01),
								"Height of the track.", placement="right", options=list(container="body")),
			                    tipify(numericInput("marginlayer4", "Track margin:", value=0.01, min=0, max=0.8, step=0.005), 
								"Margin size of the track.", placement="right", options=list(container="body"))
						),					
					checkboxInput("layer5", HTML("<font color='red'>Track5</font>"), FALSE),
			            conditionalPanel(condition="input.layer5",
						        tipify(numericInput("heightlayer5", "Track height:", value=0.06, min=0, max=0.8, step=0.01),
								"Height of the track.", placement="right", options=list(container="body")),
			                    tipify(numericInput("marginlayer5", "Track margin:", value=0.01, min=0, max=0.8, step=0.005), 
								"Margin size of the track.", placement="right", options=list(container="body"))
						),					
					checkboxInput("layer6", HTML("<font color='red'>Track6</font>"), FALSE),
			            conditionalPanel(condition="input.layer6",
						        tipify(numericInput("heightlayer6", "Track height:", value=0.06, min=0, max=0.8, step=0.01),
								"Height of the track.", placement="right", options=list(container="body")),
			                    tipify(numericInput("marginlayer6", "Track margin:", value=0.01, min=0, max=0.8, step=0.005), 
								"Margin size of the track.", placement="right", options=list(container="body"))
						),					
					checkboxInput("layer7", HTML("<font color='red'>Track7</font>"), FALSE),
			            conditionalPanel(condition="input.layer7",
						        tipify(numericInput("heightlayer7", "Track height:", value=0.06, min=0, max=0.8, step=0.01),
								"Height of the track.", placement="right", options=list(container="body")),
			                    tipify(numericInput("marginlayer7", "Track margin:", value=0.01, min=0, max=0.8, step=0.005), 
								"Margin size of the track.", placement="right", options=list(container="body"))
						),					
					checkboxInput("layer8", HTML("<font color='red'>Track8</font>"), FALSE),
			            conditionalPanel(condition="input.layer8",
						        tipify(numericInput("heightlayer8", "Track height:", value=0.06, min=0, max=0.8, step=0.01),
								"Height of the track.", placement="right", options=list(container="body")),
			                    tipify(numericInput("marginlayer8", "Track margin:", value=0.01, min=0, max=0.8, step=0.005), 
								"Margin size of the track.", placement="right", options=list(container="body"))
						),					
					checkboxInput("layer9", HTML("<font color='red'>Track9</font>"), FALSE),
			            conditionalPanel(condition="input.layer9",
						        tipify(numericInput("heightlayer9", "Track height:", value=0.06, min=0, max=0.8, step=0.01),
								"Height of the track.", placement="right", options=list(container="body")),
			                    tipify(numericInput("marginlayer9", "Track margin:", value=0.01, min=0, max=0.8, step=0.005), 
								"Margin size of the track.", placement="right", options=list(container="body"))
						),					
					checkboxInput("layer10", HTML("<font color='red'>Track10</font>"), FALSE),
			            conditionalPanel(condition="input.layer10",
						        tipify(numericInput("heightlayer10", "Track height:", value=0.06, min=0, max=0.8, step=0.01),
								"Height of the track.", placement="right", options=list(container="body")),
			                    tipify(numericInput("marginlayer10", "Track margin:", value=0.01, min=0, max=0.8, step=0.005), 
								"Margin size of the track.", placement="right", options=list(container="body"))
						)
		        )
		)
      ),     
      mainPanel(id = "mainPanel_1",
          downloadButton("Visualization_1.pdf", "Download pdf-file"),
          downloadButton("Visualization_1.svg", "Download svg-file"),
		  downloadButton("Script_1.R", "Download the R scripts to reproduce the plot"),
		  HTML('<br>'),
		  HTML('<br>'),
		  textOutput("errorinfo1"),
		  textOutput("errorinfo2"),
		  textOutput("errorinfo3"),
          textOutput("errorinfo4"),	
          textOutput("errorinfo7"),	
          textOutput("errorinfo9"),		  		  
		  plotOutput("figure_1", height = '100%', width = '100%')
	  )
    ),
    tabPanel(
       "Two genomes",tags$head(
			tags$style("
                input[type='file'] {width:5em;}
				.toggleButton {width:100%;} 
                .clearButton {float:right; font-size:12px;}
				.fa-angle-down:before, .fa-angle-up:before {float:right;}
				.popover{text-align:left;width:500px;background-color:#000000;}
				.popover-title{color:#FFFFFF;font-size:16px;background-color:#000000;border-color:#000000;}
				#sidebarPanel_2 {width:25em;}
				#tc_lowColor, #tc_midColor, #tc_highColor {width:100%}
				#mainPanel_2 {left:28em; position:absolute; min-width:27em;}"),
			 tags$style(HTML(".shiny-output-error-validation {color: red;}")),
             tags$script(HTML('Shiny.addCustomMessageHandler("jsCode",function(message) {eval(message.value);});')), includeScript("google-analytics.js")				
		),
        sidebarPanel(id="sidebarPanel_2",
	        tipify(fileInput("tc_uploadchrdata_1", "Upload genome1 data:", multiple = FALSE),
			'Click "Browse" to upload the genome1 data along the X-axis.', placement="right", options=list(container="body")),														
		    tags$script('$( "#tc_uploadchrdata_1" ).on( "click", function() { this.value = null; });'),
	        tipify(fileInput("tc_uploadchrdata_2", "Upload genome2 data:", multiple = FALSE),
			'Click "Browse" to upload the genome2 data along the Y-axis.', placement="right", options=list(container="body")),																	
		    tags$script('$( "#tc_uploadchrdata_2" ).on( "click", function() { this.value = null; });'),			
	        tipify(fileInput("tc_uploaddata", "Upload plot data:", multiple = FALSE),
			'Click "Browse" to upload the plot data.', placement="right", options=list(container="body")),																				
		    tags$script('$( "#tc_uploaddata" ).on( "click", function() { this.value = null; });'),
			selectInput("tc_plottype", "Plot type:", choices = c("point_gradual", "point_discrete", "segment" , "rect_gradual", "rect_discrete"), selected="point_gradual"),
         	ADVANCED_OPTIONS_PANEL_tc(
	  	        list(
			        conditionalPanel(condition="input.tc_plottype=='point_gradual' | input.tc_plottype=='rect_gradual'",			
			            tipify(radioButtons("tc_selgralcol", "Colors", c("Typical" = "1", "Custom" = "2"), selected="1"), "Colors to be used to plot the data, which can be assigned by the application or be specified by the users.", placement="right", options=list(container="body")),			
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
			            HTML('<br>')
			        )			
			        ),	
			        conditionalPanel(condition="input.tc_plottype=='point_discrete' | input.tc_plottype=='segment' | input.tc_plottype=='rect_discrete'",			
			            tipify(radioButtons("tc_coltype", "Data color", c("Random" = "1", "One custom color" = "2",
	                                            "Custom for data with multi-group" = "3"), selected="1"),
                        'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. To customize one color for data, users should provide a character string representing one color as "red". To customize color for data with multiple groups, the column indicating different groups should be named as "color". Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.', placement="right", options=list(container="body")),
					    conditionalPanel(condition="input.tc_coltype=='2'",	
			                textInput("tc_colorcus", NULL, value="red")
			            ),
                        conditionalPanel(condition="input.tc_coltype=='3'",	
			                textInput("tc_colormulgp", NULL, value="a:red;b:blue;c:cyan")
	                    ),
			            tipify(numericInput("tc_coltransparency", "Color transparency:", value=1, min=0, max=1, step=0.1),
			                "A decimal number in [0, 1] to adjust the color transparency. The higher the value, the deeper the color.", placement="right", options=list(container="body"))
					),
                    conditionalPanel(condition="input.tc_plottype == 'point_gradual' | input.tc_plottype == 'point_discrete'",						
                        tipify(textInput("tc_symbolpoint", "Symbol type:", value="16"), 'Symbol used for different points. Applicable values are integers in [0-25]. Type ?pch in R console for more details. The option is suitable for data without a "shape" column.', placement="right", options=list(container="body")),				
			            tipify(numericInput("tc_pointsize", "Point size:", value=0.8, min=0, max=2, step=0.05), 'Value used for different size of points. The option is suitable for data without a "size" column.', placement="right", options=list(container="body")) 						
					),
			        conditionalPanel(condition="input.tc_plottype=='segment'",	
			            numericInput("tc_linesize", "Line width:", value=2, min=0, max=20, step=0.05),
			            tipify(selectInput("tc_linetype", "Line type", choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
			                'The line type is automatically set to "solid" for line with more than one color.',placement="right", options=list(container="body"))
			        ),
                    conditionalPanel(condition="input.tc_plottype == 'point_gradual' | input.tc_plottype == 'point_discrete'",
				        tipify(radioButtons("tc_xrugs", "X-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			                "Create a set of tick marks along the X-axis.", placement="right", options=list(container="body")),
				        conditionalPanel(condition="input.tc_xrugs=='1'",
				            textInput("tc_xrugscol", "Color:", value="black")				
				        ),				
				        tipify(radioButtons("tc_yrugs", "Y-axis rugs", c("Show" = "1", "Hide" = "2"),selected="2"),
			                "Create a set of tick marks along the Y-axis.", placement="right", options=list(container="body")),
				        conditionalPanel(condition="input.tc_yrugs=='1'",
				            textInput("tc_yrugscol", "Color:", value="black")				
				        )
					),
				    tipify(radioButtons("tc_vertical", "Vertical line", c("Show" = "1", "Hide" = "2"),selected="1"),
			            "Create a set of vertical lines across the X-axis to separate different chromosomes.", placement="right", options=list(container="body")),
				    conditionalPanel(condition="input.tc_vertical=='1'",
						tipify(textInput("tc_verticalcol", "Vertical line color:", value="black"),"Color for the vertical line.",placement="right", options=list(container="body")),
			            tipify(numericInput("tc_verticalsize", "Vertical line width:", value=0.2, min=0, max=20, step=0.05),"Line width for the vertical line.",placement="right", options=list(container="body")),
						tipify(selectInput("tc_verticaltype", "Vertical line type", choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
						"Line type for the vertical line.",placement="right", options=list(container="body"))
				    ),
				    tipify(radioButtons("tc_horizontal", "Horizontal line", c("Show" = "1", "Hide" = "2"),selected="1"),
			            "Create a set of horizontal lines across the Y-axis to separate different chromosomes.", placement="right", options=list(container="body")),
				    conditionalPanel(condition="input.tc_horizontal=='1'",
						tipify(textInput("tc_horizontalcol", "Horizontal line color:", value="black"),"Color for the horizontal line.",placement="right", options=list(container="body")),
			            tipify(numericInput("tc_horizontalsize", "Horizontal line width:", value=0.2, min=0, max=20, step=0.05),"Line width for the horizontal line.",placement="right", options=list(container="body")),			            
						tipify(selectInput("tc_horizontaltype", "Horizontal line type", choices = c("solid","dashed","dotted","dotdash","longdash","twodash"), selected="solid"),
						"Line type for the horizontal line.",placement="right", options=list(container="body"))
				    ),
			        conditionalPanel(condition="input.tc_plottype=='rect_gradual' | input.tc_plottype=='rect_discrete'",
			            tipify(radioButtons("tc_addborder", "Add cell borders", c("Yes" = "1", "No" = "2"),selected="2"),
				        "Add borders to the rect grids, which can be used to separate cells from each other.", placement="right", options=list(container="body")),
			            conditionalPanel(condition="input.tc_addborder=='1'",
                            tipify(textInput("tc_bordercols", "Borders color:", value="black"),
					        "The color to be used for the borders of rect grids. For example, 'white' or 'red'. Hex color codes as '#FF0000' are also supported.", placement="right", options=list(container="body"))
			            )
                    ),					
		            tipify(radioButtons("tc_addlegend", "Add legend", c("Yes" = "1", "No" = "2"), "2"),
			        "Control the appearance of the legend in the plotting region.", placement="right", options=list(container="body")),					
			            conditionalPanel(condition="input.tc_addlegend=='1'",
		                    radioButtons("tc_collgd", "Color legend", c("Yes" = "1", "No" = "2"), "2"),
			                conditionalPanel(condition="input.tc_collgd=='1'",
 				                tipify(textInput("tc_collgdname", "Name:", value="color"),
							    "Title of color legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  
			                    conditionalPanel(condition="input.tc_plottype=='point_discrete' | input.tc_plottype=='segment' | input.tc_plottype=='rect_discrete'",
								    tipify(radioButtons("tc_collgdmdylabel", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                                    'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),
						            conditionalPanel(condition="input.tc_collgdmdylabel=='1'",
						                textInput("tc_collgdlabel", NULL, value="a,b,c")
					                )
								)
				            ),
			                 conditionalPanel(condition="input.tc_plottype == 'point_gradual' | input.tc_plottype == 'point_discrete'",
		                         radioButtons("tc_sizelgd", "Size legend", c("Yes" = "1", "No" = "2"), "2"),
			                     conditionalPanel(condition="input.tc_sizelgd=='1'",
 				                     tipify(textInput("tc_sizelgdname", "Name:", value="size"),
			                         "Title of size legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  					  									 
				                     tipify(radioButtons("tc_sizelgdmdylabel", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                                     'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),						             
									 conditionalPanel(condition="input.tc_sizelgdmdylabel=='1'",
						                 textInput("tc_sizelgdlabel", NULL, value="a,b,c")
	                                 )
					             ),
		                         radioButtons("tc_shapelgd", "Shape legend", c("Yes" = "1", "No" = "2"), "2"),
			                     conditionalPanel(condition="input.tc_shapelgd=='1'",
 				                     tipify(textInput("tc_shapelgdname", "Name:", value="shape"),	
			                         "Title of shape legend. Null value will result in an empty title.", placement="right", options=list(container="body")),							  					  				      									 
					                 tipify(radioButtons("tc_shapelgdmdylabel", "Modify labels", c("Yes" = "1", "No" = "2"), "2"),
                                     'The labels of legend can be assigned by the application or be specified by the users. Character vector of arbitrary length is accepted and adjusted automatically to the number of groups, which is separated by commas. For example, "a" or "a,b,c".', placement="right", options=list(container="body")),
						             conditionalPanel(condition="input.tc_shapelgdmdylabel=='1'",
						                 textInput("tc_shapelgdlabel", NULL, value="a,b,c")
	                                 )
					             )
			             	)
			           )
                )
            ),
		    HTML('<br>'),
		    HTML('<br>'),			
            tipify(actionButton("submit2", strong("Go!")),
		    'Please click the "Go!" button, if suitable data is uploaded or any options are modified.', placement="right", options=list(container="body")),							  					  				      					  					  					
            br(),
            h4("Plot options"),
            tipify(checkboxInput("tc_plotSize", "Adjust plot size", FALSE),
			"Adjust the height and width of the non-circular plot. The figure size in both the browser and the download files would be affected.", placement="right", options=list(container="body")),							  					  				      				      								
            conditionalPanel(condition = "input.tc_plotSize",
                numericInput("tc_Height", "Plot height:", value = 550),
                numericInput("tc_Width", "Plot width:", value = 750)
            ),
            tipify(checkboxInput("tc_plotheme", "Figure theme", FALSE),
            "Figure themes which control all non-data display.", placement="right", options=list(container="body")),			
            conditionalPanel(condition = "input.tc_plotheme",					
			    selectInput("tc_themestyle", NULL, choices = c("theme1", "theme2", "theme3", 
	                                                  "theme4", "theme5", "theme6", 
	                                                  "theme7","theme8","theme9","theme10"), selected="theme1")
			),
            checkboxInput("tc_selfontsize", "Font size", FALSE),
            conditionalPanel(condition = "input.tc_selfontsize",					
			    numericInput("tc_fontSize", NULL, value=16, min=0, max=100, step=0.5)														  
		    ),														  
            tipify(checkboxInput("tc_addtitle", "Axis title", FALSE),
            "Modify axis title of non-circular plot.", placement="right", options=list(container="body")),												
            conditionalPanel(condition = "input.tc_addtitle",					
                textInput("tc_xtitle", "X title:", value="Genomic position 1"),
			    textInput("tc_ytitle", "Y title:", value="Genomic position 2"),
			    selectInput("tc_titlefontface", "Font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain")
			),
            checkboxInput("tc_addlabels", "Axis label", FALSE),
            conditionalPanel(condition = "input.tc_addlabels",					
			    tipify(radioButtons("tc_xlabel", "X label", c("Show" = "1", "Hide" = "2"), selected="1"),
			"Add tick labels on the X-axis.", placement="right", options=list(container="body")),								
			    tipify(radioButtons("tc_ylabel", "Y label", c("Show" = "1", "Hide" = "2"), selected="1"),
			"Add tick labels on the Y-axis.", placement="right", options=list(container="body"))								
			),
            checkboxInput("tc_legends", "Legend", FALSE),
            conditionalPanel(condition = "input.tc_legends",
			    tipify(radioButtons("tc_legendpos", "Position", c("Right" = "1", "Bottom" = "2"), selected="1"),
			        "The position to place the legend.", placement="right", options=list(container="body")),			    
				tipify(numericInput("tc_lgdtitlesize", "Title size", value=10, min=0, max=100, step=0.5),
			        "The font size of legend title.", placement="right", options=list(container="body")),			    
				tipify(selectInput("tc_lgdtitlefontface", "Title font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
			        "The font face of legend title.", placement="right", options=list(container="body")),				
				tipify(numericInput("tc_lgdtextsize", "Label size", value=10, min=0, max=100, step=0.5),
			        "The font size of legend tick label.", placement="right", options=list(container="body")),								
			    tipify(selectInput("tc_lgdtextfontface", "Label font face:", choices = c("plain", "italic", "bold", "bold.italic"), selected="plain"),
			        "The font face of legend tick label.", placement="right", options=list(container="body"))				
			)
		),			
       mainPanel(id = "mainPanel_2",
           downloadButton("Visualization_2.pdf", "Download pdf-file"),
           downloadButton("Visualization_2.svg", "Download svg-file"),
		   downloadButton("Script_2.R", "Download the R scripts to reproduce the plot"),
		   HTML('<br>'),
           HTML('<br>'),
		   textOutput("errorinfo5"),
		   textOutput("errorinfo6"),
		   textOutput("errorinfo8"),		   
		   plotOutput("figure_2", height = '100%', width = '100%')
	   )
	   ),
	tabPanel(
        "Gallery",
        includeHTML("www/gallery.html")
    ), 
	tabPanel(
        "Help",
        includeMarkdown("README.md")
      ),
	tabPanel(
        "Manual",
		uiOutput("pdfview")
      )	  
      )
  )

