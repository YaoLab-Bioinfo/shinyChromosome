
source("global_ui.R")

footerTagList <- list(
  tags$footer(id = "myFooter",
              shiny::includeHTML("www/footer.html")
  )
)

shinyUI(
  fluidPage(
    titlePanel(
      title=div(
        img(src="headerN.png"),
        span("shinyChromosome:", style = "font-size:36px;color:white;"), 
        span("interactive creation of non-circular whole genome diagram", style = "font-size:28px;color:white;"),
        style = "background-color:#0073B7;margin-left: -15px;margin-right: -15px;margin-top: -20px;margin-bottom: -10px;"
      ), windowTitle = "Welcome to shinyChromosome!"
    ),
    
    includeCSS("www/footer.css"),
    
    shinydisconnect::disconnectMessage(
      text = "Your session timed out, reload the application!",
      refresh = "Reload now",
      background = "#f89f43",
      colour = "white",
      overlayColour = "grey",
      overlayOpacity = 0.75,
      top = 250,
      refreshColour = "brown"
    ),
    
    
    navbarPage(
      title = "",
      # theme = shinytheme("flatly"),
      windowTitle = "Welcome to shinyChromosome!",
      
      tabPanel(
        "Single-genome plot",
        icon = icon("align-left", class = NULL, lib = "font-awesome"),
        tags$head(
          tags$style("
        input[type='file'] {width:5em;}
        .toggleButton {width:100%;}
        .clearButton {float:right; font-size:12px;}
        .fa-angle-down:before, .fa-angle-up:before {float:right;}
        .popover{text-align:left;width:500px;background-color:#000000;}
        .popover-title{color:#FFFFFF;font-size:16px;background-color:#000000;border-color:#000000;}
        .jhr{display: inline; vertical-align: top; padding-left: 10px;}
        .popover{max-width: 60%;}
        
        #sidebarPanel_1 {width:25em;}
        #hmap_2cols_low1, #hmap_2cols_high1 {width:100%}
        #hmap_2cols_low2, #hmap_2cols_high2 {width:100%}
        #hmap_2cols_low3, #hmap_2cols_high3 {width:100%}
        #hmap_2cols_low4, #hmap_2cols_high4 {width:100%}
        #hmap_2cols_low5, #hmap_2cols_high5 {width:100%}
        #hmap_2cols_low6, #hmap_2cols_high6 {width:100%}
        #hmap_2cols_low7, #hmap_2cols_high7 {width:100%}
        #hmap_2cols_low8, #hmap_2cols_high8 {width:100%}
        #hmap_2cols_low9, #hmap_2cols_high9 {width:100%}
        #hmap_2cols_low10, #hmap_2cols_high10 {width:100%}

        #hmap_3cols_low1, #hmap_3cols_mid1, #hmap_3cols_high1 {width:100%}
        #hmap_3cols_low2, #hmap_3cols_mid2, #hmap_3cols_high2 {width:100%}
        #hmap_3cols_low3, #hmap_3cols_mid3, #hmap_3cols_high3 {width:100%}
        #hmap_3cols_low4, #hmap_3cols_mid4, #hmap_3cols_high4 {width:100%}
        #hmap_3cols_low5, #hmap_3cols_mid5, #hmap_3cols_high5 {width:100%}
        #hmap_3cols_low6, #hmap_3cols_mid6, #hmap_3cols_high6 {width:100%}
        #hmap_3cols_low7, #hmap_3cols_mid7, #hmap_3cols_high7 {width:100%}
        #hmap_3cols_low8, #hmap_3cols_mid8, #hmap_3cols_high8 {width:100%}
        #hmap_3cols_low9, #hmap_3cols_mid9, #hmap_3cols_high9 {width:100%}
        #hmap_3cols_low10, #hmap_3cols_mid10, #hmap_3cols_high10 {width:100%}

        #color_cus1, #color_cus2, #color_cus3, #color_cus4, #color_cus5, #color_cus6, #color_cus7, #color_cus8, #color_cus9, #color_cus10 {width:100%}
        #text_col1, #text_col2, #text_col3, #text_col4, #text_col5, #text_col6, #text_col7, #text_col8, #text_col9, #text_col10 {width:100%}
        #line_color1, #line_color2, #line_color3, #line_color4, #line_color5, #line_color6, #line_color7, #line_color8, #line_color9, #line_color10 {width:100%}
        #rect_col_dis1, #rect_col_dis2, #rect_col_dis3, #rect_col_dis4, #rect_col_dis5, #rect_col_dis6, #rect_col_dis7, #rect_col_dis8, #rect_col_dis9, #rect_col_dis10 {width:100%}
        #border_col1, #border_col2, #border_col3, #border_col4, #border_col5, #border_col6, #border_col7, #border_col8, #border_col9, #border_col10 {width:100%}
        #border_area1, #border_area2, #border_area3, #border_area4, #border_area5, #border_area6, #border_area7, #border_area8, #border_area9, #border_area10 {width:100%}

        #rect_2cols_low1, #rect_2cols_high1 {width:100%}
        #rect_2cols_low2, #rect_2cols_high2 {width:100%}
        #rect_2cols_low3, #rect_2cols_high3 {width:100%}
        #rect_2cols_low4, #rect_2cols_high4 {width:100%}
        #rect_2cols_low5, #rect_2cols_high5 {width:100%}
        #rect_2cols_low6, #rect_2cols_high6 {width:100%}
        #rect_2cols_low7, #rect_2cols_high7 {width:100%}
        #rect_2cols_low8, #rect_2cols_high8 {width:100%}
        #rect_2cols_low9, #rect_2cols_high9 {width:100%}
        #rect_2cols_low10, #rect_2cols_high10 {width:100%}
		
        #rect_3cols_low1, #rect_3cols_mid1, #rect_3cols_high1 {width:100%}
        #rect_3cols_low2, #rect_3cols_mid2, #rect_3cols_high2 {width:100%}
        #rect_3cols_low3, #rect_3cols_mid3, #rect_3cols_high3 {width:100%}
        #rect_3cols_low4, #rect_3cols_mid4, #rect_3cols_high4 {width:100%}
        #rect_3cols_low5, #rect_3cols_mid5, #rect_3cols_high5 {width:100%}
        #rect_3cols_low6, #rect_3cols_mid6, #rect_3cols_high6 {width:100%}
        #rect_3cols_low7, #rect_3cols_mid7, #rect_3cols_high7 {width:100%}
        #rect_3cols_low8, #rect_3cols_mid8, #rect_3cols_high8 {width:100%}
        #rect_3cols_low9, #rect_3cols_mid9, #rect_3cols_high9 {width:100%}
        #rect_3cols_low10, #rect_3cols_mid10, #rect_3cols_high10 {width:100%}
        #mainPanel_1 {left:28em; position:absolute; min-width:27em;}"
          ),
          
          tags$style(HTML(".shiny-output-error-validation {color: red;}")),
          tags$style(HTML(
            ".checkbox {margin: 0}
                 .checkbox p {margin: 0;}
                 .shiny-input-container {margin-bottom: 0;}
                 .navbar-default .navbar-brand {color: black; font-size:150%;}
                 .navbar-default .navbar-nav > li > a {color:black; font-size:120%;}
                 .shiny-input-container:not(.shiny-input-container-inline) {width: 100%;}
               ")
            ),
          
          tags$script(HTML('Shiny.addCustomMessageHandler("jsCode",function(message) {eval(message.value);});')),
          
          tags$head(tags$script(HTML('Shiny.addCustomMessageHandler("jsCode",function(message) {eval(message.value);});')),
                    tags$style(
                      HTML(
                        "
            #inputs-table {
              border-collapse: collapse;
            }
            
            #inputs-table td {
              padding: 3px;
              vertical-align: bottom;
            }

            .multicol .shiny-options-group{
                            -webkit-column-count: 2; /* Chrome, Safari, Opera */
              -moz-column-count: 2;    /* Firefox */
              column-count: 2;
              -moz-column-fill: balanced;
              -column-fill: balanced;
            }
            "
                      ) #/ HTML
                    ) #/ style
          ),
          
          includeScript("www/google-analytics.js")
        ),
        
        sidebarPanel(id = "sidebarPanel_1",
                     radioButtons("plotype",
                                  tags$div(HTML('<i class="fa fa-play" aria-hidden="true"></i> <font size="4" color="red"><b>Image type:</b></font>'),
                                           bsButton("bsb1", label="", icon=icon("question"), style="info", size="small")
                                  ), c("Concatenated chromosomes" = "1", "Separated chromosomes" = "2"), "1"),
                     bsPopover("bsb1", "All chromosomes can either be concatenated or separated.",
                               trigger = "focus"),
                     radioButtons("plot_direct",
                                  tags$div(HTML('<i class="fa fa-play" aria-hidden="true"></i> <font size="4" color="red"><b>Chromosome orientation:</b></font>'),
                                     bsButton("bsb2", label="", icon=icon("question"), style="info", size="small")
                                  ), c("Horizontally aligned" = "1", "Vertically aligned" = "2"), "1"),
                     bsPopover("bsb2",
                               "Chromosomes could be aligned to the horizontal axis or the vertical axis.",
                               trigger = "focus"),
                     
                     fileInput("upload_chr_data",
                               tags$div(HTML('<i class="fa fa-play" aria-hidden="true"></i> <font size="4" color="red"><b>Upload genome data:</b></font>'),
                                  bsButton("bsb3", label="", icon=icon("question"), style="info", size="small")
                               ), multiple = FALSE, width = "100%"),
                     bsPopover("bsb3",
                               'Click "Browse" to upload the genome data, which is compulsory and defines the frame of the non-circular plot.',
                               trigger = "focus"),
                     
                     actionButton("tabBut1", "View example data"),
                     tags$script('$( "#upload_chr_data" ).on( "click", function() { this.value = null; });'),
                     downloadButton("genome_data.txt", "Example data"),
                     
                     br(),
                     
                     checkboxInput("data1", HTML("<font size='4' color='red'>Data1</font>"), FALSE),
                     source("sig_data1_ui.R")$value,
                     
                     checkboxInput("data2", HTML("<font size='4' color='red'>Data2</font>"), FALSE),
                     source("sig_data2_ui.R")$value,
                     
                     checkboxInput("data3", HTML("<font size='4' color='red'>Data3</font>"), FALSE),
                     source("sig_data3_ui.R")$value,
                     
                     checkboxInput("data4", HTML("<font size='4' color='red'>Data4</font>"), FALSE),
                     source("sig_data4_ui.R")$value,
                     
                     checkboxInput("data5", HTML("<font size='4' color='red'>Data5</font>"), FALSE),
                     source("sig_data5_ui.R")$value,
                     
                     checkboxInput("data6", HTML("<font size='4' color='red'>Data6</font>"), FALSE),
                     source("sig_data6_ui.R")$value,
                     
                     checkboxInput("data7", HTML("<font size='4' color='red'>Data7</font>"), FALSE),
                     source("sig_data7_ui.R")$value,
                     
                     checkboxInput("data8", HTML("<font size='4' color='red'>Data8</font>"), FALSE),
                     source("sig_data8_ui.R")$value,
                     
                     checkboxInput("data9", HTML("<font size='4' color='red'>Data9</font>"), FALSE),
                     source("sig_data9_ui.R")$value,
                     
                     checkboxInput("data10", HTML("<font size='4' color='red'>Data10</font>"), FALSE),
                     source("sig_data10_ui.R")$value,
                     
                     tags$div(HTML('<i class="fa fa-play" aria-hidden="true"></i> <font size="4" color="red"><b>Plot options:</b></font>')),
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
                                          selectInput("lgd_pos", h5("Legend position:",
                                                                    bsButton("bsb326", label="", icon=icon("question"), style="info", size="small")
                                          ), c("Right" = "1", "Bottom" = "2"), selected = "1"),
                                          bsPopover("bsb326", "The position to place the legend.", trigger = "focus"),
                                          sliderInput("lgd_space_size", h5("Legend region size:",
                                                                           bsButton("bsb327", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.04, step = 0.01),
                                          bsPopover("bsb327", "Percent of legend size relative to the main plotting region. Applicable values are numbers in [0-1].", trigger = "focus"),
                                          sliderInput("lgd_intra_size", h5("Intra-spacing:",
                                                                           bsButton("bsb328", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 150, value = 40, step = 0.5),
                                          bsPopover("bsb328", "Intra-spacing between different legends.", trigger = "focus"),
                                          sliderInput("lgd_title_size", h5("Title font size:",
                                                                           bsButton("bsb329", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 40, value = 12, step = 0.1),
                                          bsPopover("bsb329", "The font size of legend title.", trigger = "focus"),
                                          selectInput("lgd_title_font_face", h5("Title font face:",
                                                                                bsButton("bsb330", label="", icon=icon("question"), style="info", size="small")
                                          ), choices = c("plain", "italic", "bold", "bold.italic"), selected = "plain"),
                                          bsPopover("bsb330", "The font face of legend title.", trigger = "focus"),
                                          sliderInput("lgd_text_size", h5("Label font size:",
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
                                          ), min = 0, max = 1, value = 0.06, step = 0.01),
                                          bsPopover("bsb333", "Height of the track.", trigger = "focus"),
                                          sliderInput("margin_layer1", h5("Track margin:",
                                                                          bsButton("bsb334", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.01, step = 0.005),
                                          bsPopover("bsb334", "Margin size of the track.", trigger = "focus")
                         ),
                         
                         checkboxInput("layer2", HTML("<font color='red'>Track2</font>"), FALSE),
                         conditionalPanel(condition="input.layer2",
                                          sliderInput("height_layer2", h5("Track height:",
                                                                          bsButton("bsb335", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.06, step = 0.01),
                                          bsPopover("bsb335", "Height of the track.", trigger = "focus"),
                                          sliderInput("margin_layer2", h5("Track margin:",
                                                                          bsButton("bsb336", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.01, step = 0.005),
                                          bsPopover("bsb336", "Margin size of the track.", trigger = "focus")
                         ),
                         
                         checkboxInput("layer3", HTML("<font color='red'>Track3</font>"), FALSE),
                         conditionalPanel(condition="input.layer3",
                                          sliderInput("height_layer3", h5("Track height:",
                                                                          bsButton("bsb337", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.06, step = 0.01),
                                          bsPopover("bsb337", "Height of the track.", trigger = "focus"),
                                          sliderInput("margin_layer3", h5("Track margin:",
                                                                          bsButton("bsb338", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.01, step = 0.005),
                                          bsPopover("bsb338", "Margin size of the track.", trigger = "focus")
                         ),
                         
                         checkboxInput("layer4", HTML("<font color='red'>Track4</font>"), FALSE),
                         conditionalPanel(condition = "input.layer4",
                                          sliderInput("height_layer4", h5("Track height:",
                                                                          bsButton("bsb339", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.06, step = 0.01),
                                          bsPopover("bsb339", "Height of the track.", trigger = "focus"),
                                          sliderInput("margin_layer4", h5("Track margin:",
                                                                          bsButton("bsb340", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.01, step = 0.005),
                                          bsPopover("bsb340", "Margin size of the track.", trigger = "focus")
                         ),
                         
                         checkboxInput("layer5", HTML("<font color='red'>Track5</font>"), FALSE),
                         conditionalPanel(condition = "input.layer5",
                                          sliderInput("height_layer5", h5("Track height:",
                                                                          bsButton("bsb341", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.06, step = 0.01),
                                          bsPopover("bsb341", "Height of the track.", trigger = "focus"),
                                          sliderInput("margin_layer5", h5("Track margin:",
                                                                          bsButton("bsb342", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.01, step = 0.005),
                                          bsPopover("bsb342", "Margin size of the track.", trigger = "focus")
                         ),
                         
                         checkboxInput("layer6", HTML("<font color='red'>Track6</font>"), FALSE),
                         conditionalPanel(condition="input.layer6",
                                          sliderInput("height_layer6", h5("Track height:",
                                                                          bsButton("bsb343", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.06, step = 0.01),
                                          bsPopover("bsb343", "Height of the track.", trigger = "focus"),
                                          sliderInput("margin_layer6", h5("Track margin:",
                                                                          bsButton("bsb344", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.01, step = 0.005),
                                          bsPopover("bsb344", "Margin size of the track.", trigger = "focus")
                         ),
                         
                         checkboxInput("layer7", HTML("<font color='red'>Track7</font>"), FALSE),
                         conditionalPanel(condition = "input.layer7",
                                          sliderInput("height_layer7", h5("Track height:",
                                                                          bsButton("bsb345", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.06, step = 0.01),
                                          bsPopover("bsb345", "Height of the track.", trigger = "focus"),
                                          sliderInput("margin_layer7", h5("Track margin:",
                                                                          bsButton("bsb346", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.01, step = 0.005),
                                          bsPopover("bsb346", "Margin size of the track.", trigger = "focus")
                         ),
                         
                         checkboxInput("layer8", HTML("<font color='red'>Track8</font>"), FALSE),
                         conditionalPanel(condition = "input.layer8",
                                          sliderInput("height_layer8", h5("Track height:",
                                                                          bsButton("bsb347", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.06, step = 0.01),
                                          bsPopover("bsb347", "Height of the track.", trigger = "focus"),
                                          sliderInput("margin_layer8", h5("Track margin:",
                                                                          bsButton("bsb348", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.01, step = 0.005),
                                          bsPopover("bsb348", "Margin size of the track.", trigger = "focus")
                         ),
                         
                         checkboxInput("layer9", HTML("<font color='red'>Track9</font>"), FALSE),
                         conditionalPanel(condition = "input.layer9",
                                          sliderInput("height_layer9", h5("Track height:",
                                                                          bsButton("bsb349", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.06, step = 0.01),
                                          bsPopover("bsb349", "Height of the track.", trigger = "focus"),
                                          sliderInput("margin_layer9", h5("Track margin:",
                                                                          bsButton("bsb350", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.01, step = 0.005),
                                          bsPopover("bsb350", "Margin size of the track.", trigger = "focus")
                         ),
                         
                         checkboxInput("layer10", HTML("<font color='red'>Track10</font>"), FALSE),
                         conditionalPanel(condition = "input.layer10",
                                          sliderInput("height_layer10", h5("Track height:",
                                                                           bsButton("bsb351", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.06, step = 0.01),
                                          bsPopover("bsb351", "Height of the track.", trigger = "focus"),
                                          sliderInput("margin_layer10", h5("Track margin:",
                                                                           bsButton("bsb352", label="", icon=icon("question"), style="info", size="small")
                                          ), min = 0, max = 1, value = 0.01, step = 0.005),
                                          bsPopover("bsb352", "Margin size of the track.", trigger = "focus")
                         )
                       )
                     ),
                     
                     br(),
                     br(),
                     
                     actionButton("submit1", strong("Submit!",
                                                    bsButton("bsb322", label="", icon=icon("question"), style="info", size="small")
                     ), styleclass = "success"),
                     
                     conditionalPanel(condition="input.submit1 != '0'", busyIndicator(HTML("<div style='color:red;font-size:30px'>Calculation In progress...</div>"), wait = 0)),
                     bsPopover("bsb322", 'Please click the "Submit!" button, if suitable data is uploaded or any options are modified.', trigger = "focus")	   
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
        "Two-genome plot",
        icon = icon("th", class = NULL, lib = "font-awesome"),
        tags$head(
          tags$style("
          input[type='file'] {width:5em;}
          .toggleButton {width:100%}
          .clearButton {float:right; font-size:12px;}
          .fa-angle-down:before, .fa-angle-up:before {float:right;}
          .popover{text-align:left;width:500px;background-color:#000000;}
          .popover-title{color:#FFFFFF;font-size:16px;background-color:#000000;border-color:#000000;}

          #sidebarPanel_2 {width:25em;}
          #tc_color_cus, #tc_border_col, #tc_vertical_col, #tc_horizontal_col {width:100%}
          #tc_2cols_low, #tc_2cols_high, #tc_3cols_low, #tc_3cols_mid, #tc_3cols_high {width:100%}
          #mainPanel_2 {left:28em; position:absolute; min-width:27em;}"),
          
          tags$style(HTML(".shiny-output-error-validation {color: red;}")),
          tags$script(HTML('Shiny.addCustomMessageHandler("jsCode",function(message) {eval(message.value);});')), includeScript("www/google-analytics.js")
        ),
        sidebarPanel(id = "sidebarPanel_2",
                     fileInput("tc_upload_chr_data_1",
                               tags$div(HTML('<i class="fa fa-play" aria-hidden="true"></i> <font size="4" color="red"><b>Upload genome1 data:</b></font>'),
                                  bsButton("bsb353", label="", icon=icon("question"), style="info", size="small")
                               ), multiple = FALSE),
                     bsPopover("bsb353", 'Click "Browse" to upload the genome data aligned along the X-axis.', trigger = "focus"),
                     
                     actionButton("tabBut12", "View example data"),
                     tags$script('$( "#tc_upload_chr_data_1" ).on( "click", function() { this.value = null; });'),
                     downloadButton("genome1_data.txt", "Example data"),
                     
                     br(),
                     br(),
                     
                     fileInput("tc_upload_chr_data_2",
                               tags$div(HTML('<i class="fa fa-play" aria-hidden="true"></i> <font size="4" color="red"><b>Upload genome2 data:</b></font>'),
                                  bsButton("bsb354", label="", icon=icon("question"), style="info", size="small")
                               ), multiple = FALSE),
                     bsPopover("bsb354", 'Click "Browse" to upload the genome data aligned along the Y-axis.', trigger = "focus"),
                     actionButton("tabBut13", "View example data"),
                     tags$script('$( "#tc_upload_chr_data_2" ).on( "click", function() { this.value = null; });'),
                     downloadButton("genome2_data.txt", "Example data"),
                     
                     br(),
                     br(),
                     
                     fileInput("tc_uploaddata",
                               tags$div(HTML('<i class="fa fa-play" aria-hidden="true"></i> <font size="4" color="red"><b>Upload main plot data:</b></font>'),
                                  bsButton("bsb355", label="", icon=icon("question"), style="info", size="small")
                               ), multiple = FALSE),
                     bsPopover("bsb355", 'Click "Browse" to upload data for the main plot.', trigger = "focus"),
                     actionButton("tabBut14", "View example data"),
                     tags$script('$( "#tc_uploaddata" ).on( "click", function() { this.value = null; });'),
                     downloadButton("example_plot_data.txt", "Example data"),
                     
                     br(),
                     br(),
                     
                     selectInput("tc_plot_type", 
                                 tags$div(HTML('<i class="fa fa-play" aria-hidden="true"></i> <font size="4" color="red"><b>Plot type:</b></font>')),
                                 choices = c("point_gradual", "point_discrete", "segment" , "rect_gradual", "rect_discrete"), selected="point_gradual"),
                     ADVANCED_OPTIONS_PANEL_tc(
                       list(
                         checkboxInput("color_opt_tc", HTML("<font color='red'>Color</font>"), FALSE),
                         conditionalPanel(condition = "input.color_opt_tc",
                                          conditionalPanel(condition = "input.tc_plot_type=='point_gradual' | input.tc_plot_type=='rect_gradual'",
                                                           selectInput("tc_sel_gral_col", h5("Data color",
                                                                                             bsButton("bsb356", label="", icon=icon("question"), style="info", size="small")
                                                           ), c("Typical" = "1", "Low_high_color" = "2", "Low_middle_high_color" = "3"), selected = "1"),
                                                           bsPopover("bsb356", "Colors to be used to plot the data, which can be assigned by the application or be specified by the users. By default, predefined color would be used.", trigger = "focus"),
                                                           
                                                           conditionalPanel(condition = "input.tc_sel_gral_col=='1'",
                                                                            selectInput("tc_gral_col", NULL, choices = c("blue.white.red", "green.black.red", "green.yellow.red",
                                                                                                                         "purple.yellow.red", "blue.green.red", "blue.yellow.green",
                                                                                                                         "cyan.white.deeppink1"), selected="blue.white.red")
                                                           ),
                                                           
                                                           conditionalPanel(condition="input.tc_sel_gral_col=='2'",
                                                                            fluidRow(			                                        
                                                                              column(6, colourInput("tc_2cols_low", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB", returnName = TRUE, allowTransparent = TRUE)), 
                                                                              column(6, colourInput("tc_2cols_high", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00", returnName = TRUE, allowTransparent = TRUE))),
                                                                            br()
                                                           ),																											  
                                                           conditionalPanel(condition="input.tc_sel_gral_col=='3'",
                                                                            fluidRow(			                                        
                                                                              column(4, colourInput("tc_3cols_low", label = HTML('<p><font size="2.0"><strong>Low Color</strong></font></p>'), value = "#0016DB", returnName = TRUE, allowTransparent = TRUE)), 
                                                                              column(4, colourInput("tc_3cols_mid", label = HTML('<p><font size="2.0"><strong>Middle Color</strong></font></p>'), value = "#FFFFFF", returnName = TRUE, allowTransparent = TRUE)), 
                                                                              column(4, colourInput("tc_3cols_high", label = HTML('<p><font size="2.0"><strong>High Color</strong></font></p>'), value = "#FFFF00", returnName = TRUE, allowTransparent = TRUE))),
                                                                            br()
                                                           )	
                                          ),
                                          
                                          conditionalPanel(condition = "input.tc_plot_type=='point_discrete' | input.tc_plot_type=='segment' | input.tc_plot_type=='rect_discrete'",
                                                           selectInput("tc_col_type", h5("Data color",
                                                                                         bsButton("bsb357", label="", icon=icon("question"), style="info", size="small")
                                                           ), c("Random" = "1", "One custom color" = "2",
                                                                "Custom for data with multi-group" = "3"), selected = "1"),
                                                           bsPopover("bsb357",
                                                                     'The color to be used to plot the data, which can be random assigned by the application or be specified by the users. By default, random assigned color would be used. To customize one color for data, users should choose a color from the color palette. To customize color for data with multiple groups, the column indicating different groups should be named as "color" in the input data. Users should provide a character string assigning colors to each group. For example, "a:red;b:green;c:blue", in which "a b c" represent different data groups. Color for data groups without assigned color would be set as "NA". Hex color codes as "#FF0000" are also supported. See example data for more details.',
                                                                     trigger = "focus"),
                                                           conditionalPanel(condition = "input.tc_col_type=='2'",
                                                                            fluidRow(column(12, colourInput("tc_color_cus", label = NULL, value = "#FF0000", returnName = TRUE, allowTransparent = TRUE))),
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
                                                                     'Symbol used for different points. Applicable values are integers in [0-25]. Check <a href="http://www.endmemo.com/program/R/pchsymbols.php" target="_blank">R_pchsymbols</a> for more details. A single integer can be used to set the shape of all points or a integer column named as "shape" in the input data can be used to set the shape of different points.',
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
                                          fluidRow(column(12, colourInput("tc_vertical_col", label = h5('Vertical line color:',
                                                                                                         bsButton("bsb371", label="", icon=icon("question"), style="info", size="small")), value = "#000000", returnName = TRUE, allowTransparent = TRUE))),
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
                                          fluidRow(column(12, colourInput("tc_horizontal_col", label = h5('Horizontal line color:',
                                                                                                           bsButton("bsb375", label="", icon=icon("question"), style="info", size="small")
                                          ), value = "#000000", returnName = TRUE, allowTransparent = TRUE))),
                                          bsPopover("bsb375", "Color of the horizontal lines.",trigger = "focus"),
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
                                                           fluidRow(column(12, colourInput("tc_border_col", label = h5('Borders color:'), value = "#000000", returnName = TRUE, allowTransparent = TRUE)))
                                          )
                         )
                       )
                     ),
                     
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
                                                  h5("Title font face",
                                                     bsButton("bsb388", label="", icon=icon("question"), style="info", size="small")
                                                  ), choices = c("plain", "italic", "bold", "bold.italic"), selected = "plain"),
                                      bsPopover("bsb388", "The font face of legend title.", trigger = "focus"),
                                      sliderInput("tc_lgd_text_size", h5("Label font size",
                                                                         bsButton("bsb389", label="", icon=icon("question"), style="info", size="small")
                                      ), min = 0, max = 40, value = 10, step = 0.1),
                                      bsPopover("bsb389", "The font size of legend tick label.", trigger = "focus"),
                                      selectInput("tc_lgd_text_font_face",
                                                  h5("Label font face",
                                                     bsButton("bsb390", label="", icon=icon("question"), style="info", size="small")
                                                  ), choices = c("plain", "italic", "bold", "bold.italic"), selected = "plain"),
                                      bsPopover("bsb390", "The font face of legend tick label.", trigger = "focus")
                     ),
                     
                     actionButton("submit2", strong("Submit!",
                                                    bsButton("bsb380", label="", icon=icon("question"), style="info", size="small")
                     ), styleclass = "success"),
                     
                     conditionalPanel(condition="input.submit2 != '0'", busyIndicator(HTML("<div style='color:red;font-size:30px'>Calculation In progress...</div>"), wait = 0)),
                     bsPopover("bsb380", 'Please click the "Submit!" button, if suitable data is uploaded or any options are modified.', trigger = "focus")				   
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
      
      tabPanel("Gallery", icon = icon("image", class = NULL, lib = "font-awesome"), includeHTML("www/gallery.html")),
      
      tabPanel("About", icon = icon("info-circle", class = NULL, lib = "font-awesome"),
               includeMarkdown("www/About.md")),
      
      navbarMenu("Help",
                 icon = icon("book", class = NULL, lib = "font-awesome"),
                 tabPanel("Usage and installation", includeMarkdown("README.md")),
                 tabPanel("Input data format", includeMarkdown("In_Data_Format.md")),
                 
                 tabPanel("User manual", 
                          fluidRow(
                            column(
                              width = 8,
                              conditionalPanel(
                                condition = "input.helplan == 1",
                                HTML('<font style="font-size: 25px;font-family: Arial, Helvetica, sans-serif;font-weight: bolder;"><h2><i class="fa-solid fa-play"></i> Section</font>')
                              ),
                              conditionalPanel(
                                condition = "input.helplan == 2",
                                HTML('<font style="font-size: 25px;font-family: Arial, Helvetica, sans-serif;font-weight: bolder;"><h2><i class="fa-solid fa-play"></i> 章节</font>')
                              ),
                              
                              tags$style(
                                type='text/css',
                                "#helpsection div .radio {font-size: 23px;font-weight:100;margin-bottom: -10px;margin-top: 2px; }"
                              ),
                              radioButtons(
                                inputId = "helpsection",
                                label = NULL,
                                choices = c(
                                  "Introduction" = 1, 
                                  "Use shinyChromosome online or on local computer" = 2,  
                                  "Creation of non-circular single-genome plot" = 3, 
                                  "Creation of Non-circular two-genome plot" = 4,
                                  "Plot options to decorate non-circular whole genome plots" = 5
                                ),
                                selected = 1,
                                width = "100%"
                              )
                            ),
                            column(
                              width = 4,
                              conditionalPanel(
                                condition = "input.helplan == 1",
                                HTML('<font style="font-size: 25px;font-family: Arial, Helvetica, sans-serif;font-weight: bolder;"><h2><i class="fa-solid fa-play"></i> Language</font>')
                              ),
                              conditionalPanel(
                                condition = "input.helplan == 2",
                                HTML('<font style="font-size: 25px;font-family: Arial, Helvetica, sans-serif;font-weight: bolder;"><h2><i class="fa-solid fa-play"></i> 语言</font>')
                              ),
                              pickerInput(
                                inputId = "helplan",
                                label = NULL,
                                choices = c("English" = 1, "简体中文" = 2),
                                selected = 1
                              )
                            )
                          ),
                          
                        #  tags$div(
                            conditionalPanel(
                              condition = "input.helplan == '1'",
                              conditionalPanel(
                                condition = "input.helpsection == 1",
                                shiny::includeHTML("www/helpdocument/help-English1-S12.html")
                              ),
                              conditionalPanel(
                                condition = "input.helpsection == 2",
                                shiny::includeHTML("www/helpdocument/help-English2-S3.html")
                              ),
                              conditionalPanel(
                                condition = "input.helpsection == 3",
                                shiny::includeHTML("www/helpdocument/help-English3-S4.html")
                              ),
                              conditionalPanel(
                                condition = "input.helpsection == 4",
                                shiny::includeHTML("www/helpdocument/help-English4-S5.html")
                              ),
                              conditionalPanel(
                                condition = "input.helpsection == 5",
                                shiny::includeHTML("www/helpdocument/help-English5-S6.html")
                              )
                            ),
                        
                            conditionalPanel(
                              condition = "input.helplan == '2'",
                              conditionalPanel(
                                condition = "input.helpsection == 1",
                                shiny::includeHTML("www/helpdocument/Help-Chinese1-S12.html")
                              ),
                              conditionalPanel(
                                condition = "input.helpsection == 2",
                                shiny::includeHTML("www/helpdocument/Help-Chinese2-S3.html")
                              ),
                              conditionalPanel(
                                condition = "input.helpsection == 3",
                                shiny::includeHTML("www/helpdocument/Help-Chinese3-S4.html")
                              ),
                              conditionalPanel(
                                condition = "input.helpsection == 4",
                                shiny::includeHTML("www/helpdocument/Help-Chinese4-S5.html")
                              ),
                              conditionalPanel(
                                condition = "input.helpsection == 5",
                                shiny::includeHTML("www/helpdocument/Help-Chinese5-S6.html")
                              )
                            )
                       #   )
                 )
      ),
      
      
      footer = footerTagList
    )
  )
)

