
options(scipen=5)

shinyServer(function(input, output, session) {   
  observe({
    if(input$submit1>0){
      isolate({	  
        Height <<- input$Height
        Width <<- input$Width
        chrplotype <<- input$plotype
        plotdirection <<- input$plotdirection
        themestyle <<- input$themestyle
        fontSize <<- input$fontSize
        xtitle <<- input$xtitle
        ytitle <<- input$ytitle
        titlefontface <<- input$titlefontface
        xlabel <<- input$xlabel
        legendpos <<- input$legendpos
        lgdspacesize <<- input$lgdspacesize
        lgdintrasize <<- input$lgdintrasize
        lgdtitlesize <<- input$lgdtitlesize
        lgdtitlefontface <<- input$lgdtitlefontface
        lgdtextfontface <<- input$lgdtextfontface
        lgdtextsize <<- input$lgdtextsize
        chrdata <<- input$uploadchrdata
        if(!is.null(input$uploadchrdata)){
          data.C <<- data.frame(fread(chrdata$datapath), stringsAsFactors = F)		
        }else{
          data.C <<- NULL
        }		
        seluploaddata.export <<- c()
        uploadfile.export <<- c()		
        data.T <<- lapply(1:10,function(x){
          assign(paste("seluploaddata",x,sep=""),input[[paste("seluploaddata",x,sep="")]])	
          seluploaddata.export <<- c(seluploaddata.export,get(paste("seluploaddata",x,sep="")))
          trackfil <- input[[paste("uploaddata",x,sep="")]]	  
          if(get(paste("seluploaddata",x,sep="")) == 2 & !is.null(trackfil)){
            uploadfile.export <<- c(uploadfile.export,trackfil$name)		               
			data.frame(fread(trackfil$datapath),stringsAsFactors = F)
          }
        })
		uploadfile.export_1 <<- seluploaddata.export
		uploadfile.export_1[uploadfile.export_1==2] <<- uploadfile.export
		uploadfile.export <<- uploadfile.export_1
        trackindx <<- which(!unlist(lapply(data.T, is.null)))
        data.T <<- data.T[trackindx]		
        if(length(data.T) == 0){
          data.T <<- NULL
        }		
        if(!is.null(data.T)){
          plottype <<- c()
          coltype <<- c()
          colorcus <<- c()
          colormulgp <<- c()
          coltransparency <<- c()
          heightlayer <<- c()
          marginlayer <<- c()
          addborder <<- c()
          bordercols <<- c()
          rectcol <<- c()
          rectcoldis <<- c()
          rectcoldiscus <<- c()
          rectgrad_col <<- c()		
          colrect <<- c()
          heatmapcol <<- c()
          colhmap <<- c()
          heatmapcols <<- c()
          rectgrad_cuscols <<- c()
          colhmapdis <<- c()
          colhmapdiscus <<- c()
          symbolpoint <<- c()
          sel_symbolpoint <<- c()
          pointsize <<- c()
          sel_pointsize <<- c()
          linecolor <<- c()
          linesize <<- c()
          fillarea <<- c()
          selareatype <<- c()
          borderarea <<- c()
          linetype <<- c()
          addarrow <<- c()
          arrowpos <<- c()
          arrowsize <<- c()
          textcol <<- c()
          textsize <<- c()
          fontface <<- c()
          textangle <<- c()
          collgd <<- c()
          collgdname <<- c()
          sizelgd <<- c()
          sizelgdname <<- c()
          shapelgd <<- c()
          shapelgdname <<- c()
          linetypelgd <<- c()
          linetypelgdname <<- c()
          collgdmdylabel <<- c()
          collgdlabel <<- c()
          sizelgdmdylabel <<- c()
          sizelgdlabel <<- c()
          shapelgdmdylabel <<- c()
          shapelgdlabel <<- c()
          linetypelgdmdylabel <<- c()
          linetypelgdlabel <<- c()
          layerindex <<- c()
          ylabel <<- c()
          for(k in 1:length(data.T)){		
            plottype <<- c(plottype,input[[paste("plottype",trackindx[k],sep="")]])
            layerindex <<- c(layerindex,input[[paste("layerindex",trackindx[k],sep="")]])
            coltype <<- c(coltype,input[[paste("coltype",trackindx[k],sep="")]])		   
            colorcus <<- c(colorcus,input[[paste("colorcus",trackindx[k],sep="")]])		   
            colormulgp <<- c(colormulgp,input[[paste("colormulgp",trackindx[k],sep="")]])
            coltransparency <<- c(coltransparency,input[[paste("coltransparency",trackindx[k],sep="")]])
            addborder <<- c(addborder,input[[paste("addborder",trackindx[k],sep="")]])	
            bordercols <<- c(bordercols,input[[paste("bordercols",trackindx[k],sep="")]])
            rectcol <<- c(rectcol,input[[paste("rectcol",trackindx[k],sep="")]])
            rectcoldis <<- c(rectcoldis,input[[paste("rectcoldis",trackindx[k],sep="")]])
            rectcoldiscus <<- c(rectcoldiscus,input[[paste("rectcoldiscus",trackindx[k],sep="")]])
            rectgrad_col <<- c(rectgrad_col,input[[paste("rectgrad_col",trackindx[k],sep="")]])
            colrect <<- c(colrect,input[[paste("colrect",trackindx[k],sep="")]])
            heatmapcol <<- c(heatmapcol,input[[paste("heatmapcol",trackindx[k],sep="")]])
            colhmap <<- c(colhmap,input[[paste("colhmap",trackindx[k],sep="")]])
            heatmapcols <<- c(heatmapcols,paste(input[[paste("lowColor",trackindx[k],sep="")]],input[[paste("midColor",trackindx[k],sep="")]],input[[paste("highColor",trackindx[k],sep="")]],sep="."))
            rectgrad_cuscols <<- c(rectgrad_cuscols,paste(input[[paste("rect_lowColor",trackindx[k],sep="")]],input[[paste("rect_midColor",trackindx[k],sep="")]],input[[paste("rect_highColor",trackindx[k],sep="")]],sep="."))
            colhmapdis <<- c(colhmapdis,input[[paste("colhmapdis",trackindx[k],sep="")]])
            colhmapdiscus <<- c(colhmapdiscus,input[[paste("colhmapdiscus",trackindx[k],sep="")]])
            symbolpoint <<- c(symbolpoint,input[[paste("symbolpoint",trackindx[k],sep="")]])
            sel_symbolpoint <<- c(sel_symbolpoint,input[[paste("sel_symbolpoint",trackindx[k],sep="")]])
            pointsize <<- c(pointsize,input[[paste("pointsize",trackindx[k],sep="")]])
            sel_pointsize <<- c(sel_pointsize,input[[paste("sel_pointsize",trackindx[k],sep="")]])
            linecolor <<- c(linecolor,input[[paste("linecolor",trackindx[k],sep="")]])
            linesize <<- c(linesize,input[[paste("linesize",trackindx[k],sep="")]])
            fillarea <<- c(fillarea,input[[paste("fillarea",trackindx[k],sep="")]])
            selareatype <<- c(selareatype,input[[paste("selareatype",trackindx[k],sep="")]])
            borderarea <<- c(borderarea,input[[paste("borderarea",trackindx[k],sep="")]])
            linetype <<- c(linetype,input[[paste("linetype",trackindx[k],sep="")]])
            addarrow <<- c(addarrow,input[[paste("addarrow",trackindx[k],sep="")]])
            arrowpos <<- c(arrowpos,input[[paste("arrowpos",trackindx[k],sep="")]])
            arrowsize <<- c(arrowsize,input[[paste("arrowsize",trackindx[k],sep="")]])
            textcol <<- c(textcol,input[[paste("textcol",trackindx[k],sep="")]])
            textsize <<- c(textsize,input[[paste("textsize",trackindx[k],sep="")]])
            fontface <<- c(fontface,input[[paste("fontface",trackindx[k],sep="")]])
            textangle <<- c(textangle,input[[paste("textangle",trackindx[k],sep="")]])
            collgd <<- c(collgd,input[[paste("collgd",trackindx[k],sep="")]])
            collgdname <<- c(collgdname,input[[paste("collgdname",trackindx[k],sep="")]])
            sizelgd <<- c(sizelgd,input[[paste("sizelgd",trackindx[k],sep="")]])
            sizelgdname <<- c(sizelgdname,input[[paste("sizelgdname",trackindx[k],sep="")]])
            shapelgd <<- c(shapelgd,input[[paste("shapelgd",trackindx[k],sep="")]])
            shapelgdname <<- c(shapelgdname,input[[paste("shapelgdname",trackindx[k],sep="")]])
            linetypelgd <<- c(linetypelgd,input[[paste("linetypelgd",trackindx[k],sep="")]])
            linetypelgdname <<- c(linetypelgdname,input[[paste("linetypelgdname",trackindx[k],sep="")]])
            collgdmdylabel <<- c(collgdmdylabel,input[[paste("collgdmdylabel",trackindx[k],sep="")]])
            collgdlabel <<- c(collgdlabel,input[[paste("collgdlabel",trackindx[k],sep="")]])
            sizelgdmdylabel <<- c(sizelgdmdylabel,input[[paste("sizelgdmdylabel",trackindx[k],sep="")]])
            sizelgdlabel <<- c(sizelgdlabel,input[[paste("sizelgdlabel",trackindx[k],sep="")]])
            shapelgdmdylabel <<- c(shapelgdmdylabel,input[[paste("shapelgdmdylabel",trackindx[k],sep="")]])
            shapelgdlabel <<- c(shapelgdlabel,input[[paste("shapelgdlabel",trackindx[k],sep="")]])
            linetypelgdmdylabel <<- c(linetypelgdmdylabel,input[[paste("linetypelgdmdylabel",trackindx[k],sep="")]])
            linetypelgdlabel <<- c(linetypelgdlabel,input[[paste("linetypelgdlabel",trackindx[k],sep="")]])
            ylabel <<- c(ylabel,input[[paste("ylabel",trackindx[k],sep="")]])
          }
          for(i in sort(as.numeric(gsub("track", "", layerindex)))){		
            heightlayer <<- c(heightlayer,input[[paste("heightlayer",i,sep="")]])
            marginlayer <<- c(marginlayer,input[[paste("marginlayer",i,sep="")]])
          }
          output$errorinfo1 <- renderPrint({
            validate(
              need(!is.null(data.C), "Please upload genome data!")
            )		
            validate(
              need(!is.null(data.T), "Please upload track data!")
            )
            if(!is.null(data.T)){
              for(m in 1:length(data.T)){
                dt.TT <- data.T[[m]]
                if(plottype[m] %in% c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text", "segment")){
                  validate(
                    need(ncol(dt.TT)>=3, paste("Error: Data formatting error for Data",trackindx[m],"!"," Please upload applicable data.",sep=""))
                  )
                  if(plottype[m] %in% c("point", "line", "bar") && coltype[m]==2){
                    validate(
                      need(areColors(colorcus[m]), paste("Error: Data color error for Data",trackindx[m],"!"," Please input applicable color name.",sep=""))	 
                    )
                  }	
                }
                if(plottype[m] %in% "rect_gradual"){
                  validate(
                    need(is.numeric(dt.TT[,4]), paste("Error: Data formatting error for Data",trackindx[m],"!"," For gradual data, the 4th column should be a numeric vector."," Please upload applicable data.",sep=""))
                  )
                }
                if(plottype[m] %in% "rect_discrete"){
                  validate(
                    need(length(unique(dt.TT[,4]))<=50, paste("Error: Data formatting error for Data",trackindx[m],"!"," For discrete data, the 4th column should be a categorical character vector with no more than 50 groups."," Please upload applicable data.",sep=""))
                  )
                }
                if(plottype[m] %in% "segment"){			          
                  validate(
                    need(ncol(dt.TT)==5 | (ncol(dt.TT)==6 && names(dt.TT)[6]=="color"), paste("Error: Data formatting error for Data",trackindx[m],"!"," Please upload applicable data.",sep=""))	 
                  )
                }					
                if(plottype[m] %in% "vertical line"){
                  validate(
                    need(ncol(dt.TT)==2, paste("Error: Data formatting error for Data",trackindx[m],"!"," Please upload applicable data.",sep=""))
                  )
                  validate(
                    need(areColors(linecolor[m]), paste("Error: Line color error for Data",trackindx[m],"!"," Please input applicable color name.",sep=""))
                  )
                }
                if(plottype[m] %in% "horizontal line"){
                  validate(
                    need(ncol(dt.TT)==1, paste("Error: Data formatting error for Data",trackindx[m],"!"," Please upload applicable data.",sep=""))
                  )
                  validate(
                    need(areColors(linecolor[m]), paste("Error: Line color error for Data",trackindx[m],"!"," Please input applicable color name.",sep=""))
                  )						
                }					
              }
            }
          })
          outputOptions(output, "errorinfo1", suspendWhenHidden = FALSE)
          plotfig(input=input, output=output, data.C=data.C, data.T=data.T, trackindx=trackindx, chrplotype=chrplotype, plottype=plottype, plotdirection=plotdirection, layerindex=layerindex, Height=Height, Width=Width, coltype=coltype, colorcus=colorcus, colormulgp=colormulgp, coltransparency=coltransparency, heightlayer=heightlayer, marginlayer=marginlayer, themestyle=themestyle, fontSize=fontSize, xtitle=xtitle, ytitle=ytitle, titlefontface=titlefontface, xlabel=xlabel, ylabel=ylabel, legendpos=legendpos, lgdspacesize=lgdspacesize, lgdintrasize=lgdintrasize, lgdtitlesize=lgdtitlesize, lgdtitlefontface=lgdtitlefontface, lgdtextfontface=lgdtextfontface, lgdtextsize=lgdtextsize, addborder=addborder, bordercols=bordercols, rectcol=rectcol, rectcoldis=rectcoldis, rectcoldiscus=rectcoldiscus, rectgrad_col=rectgrad_col, colrect=colrect, heatmapcol=heatmapcol, colhmap=colhmap, heatmapcols=heatmapcols, rectgrad_cuscols=rectgrad_cuscols, colhmapdis=colhmapdis, colhmapdiscus=colhmapdiscus, symbolpoint=symbolpoint, sel_symbolpoint=sel_symbolpoint, pointsize=pointsize, sel_pointsize=sel_pointsize, linecolor=linecolor, linesize=linesize, fillarea=fillarea, selareatype=selareatype, borderarea=borderarea, linetype=linetype, addarrow=addarrow, arrowpos=arrowpos, arrowsize=arrowsize, textcol=textcol, textsize=textsize, fontface=fontface, textangle=textangle, collgd=collgd, collgdname=collgdname, sizelgd=sizelgd, sizelgdname=sizelgdname, shapelgd=shapelgd, shapelgdname=shapelgdname, linetypelgd=linetypelgd, linetypelgdname=linetypelgdname, collgdmdylabel=collgdmdylabel, collgdlabel=collgdlabel, sizelgdmdylabel=sizelgdmdylabel, sizelgdlabel=sizelgdlabel, shapelgdmdylabel=shapelgdmdylabel, shapelgdlabel=shapelgdlabel, linetypelgdmdylabel=linetypelgdmdylabel, linetypelgdlabel=linetypelgdlabel)
        }
      })
    } else {
      NULL
    }
  })
  observe({
    if(input$submit2>0){
      isolate({
        tc_Height <<- input$tc_Height
        tc_Width <<- input$tc_Width
        tc_themestyle <<- input$tc_themestyle
        tc_fontSize <<- input$tc_fontSize
        tc_xtitle <<- input$tc_xtitle
        tc_ytitle <<- input$tc_ytitle
        tc_titlefontface <<- input$tc_titlefontface
        tc_xlabel <<- input$tc_xlabel
        tc_ylabel <<- input$tc_ylabel
        tc_legendpos <<- input$tc_legendpos
        tc_lgdtitlesize <<- input$tc_lgdtitlesize
        tc_lgdtitlefontface <<- input$tc_lgdtitlefontface
        tc_lgdtextfontface <<- input$tc_lgdtextfontface
        tc_lgdtextsize <<- input$tc_lgdtextsize
        tc_chrdata1 <<- input$tc_uploadchrdata_1
        tc_chrdata2 <<- input$tc_uploadchrdata_2
        if(!is.null(tc_chrdata1)){
          data.C1 <<- data.frame(fread(tc_chrdata1$datapath), stringsAsFactors = F)		
        }else{
          data.C1 <<- NULL
        }
        if(!is.null(tc_chrdata2)){
          data.C2 <<- data.frame(fread(tc_chrdata2$datapath), stringsAsFactors = F)		
        }else{
          data.C2 <<- NULL
        }
        trackfil <<- input$tc_uploaddata
        if(!is.null(trackfil)){
          data.TC <<- data.frame(fread(trackfil$datapath),stringsAsFactors = F)
        }else{
          data.TC <<- NULL
        }
        if(!is.null(data.TC)){
          tc_plottype <<- input$tc_plottype
          tc_selgralcol <<- input$tc_selgralcol
          tc_gralcol_tp <<- input$tc_gralcol
          tc_gralcol_ct <<- c(input$tc_lowColor,input$tc_midColor,input$tc_highColor)
          tc_coltype <<- input$tc_coltype
          tc_colorcus <<- input$tc_colorcus
          tc_colormulgp <<- input$tc_colormulgp
          tc_coltransparency <<- input$tc_coltransparency
          tc_symbolpoint <<- input$tc_symbolpoint
          sel_tc_symbolpointype <<- input$sel_tc_symbolpointype
          tc_pointsize <<- input$tc_pointsize
          sel_tc_pointsizetype <<- input$sel_tc_pointsizetype
          tc_linesize <<- input$tc_linesize
          tc_vertical <<- input$tc_vertical
          tc_verticalcol <<- input$tc_verticalcol
          tc_verticalsize <<- input$tc_verticalsize
          tc_verticaltype <<- input$tc_verticaltype
          tc_horizontal <<- input$tc_horizontal
          tc_horizontalcol <<- input$tc_horizontalcol
          tc_horizontalsize <<- input$tc_horizontalsize		
          tc_horizontaltype <<- input$tc_horizontaltype
          tc_addborder <<- input$tc_addborder
          tc_bordercols <<- input$tc_bordercols
          tc_linetype <<- input$tc_linetype
          tc_collgd <<- input$tc_collgd
          tc_collgdname <<- input$tc_collgdname
          tc_sizelgd <<- input$tc_sizelgd
          tc_sizelgdname <<- input$tc_sizelgdname
          tc_shapelgd <<- input$tc_shapelgd
          tc_shapelgdname <<- input$tc_shapelgdname
          tc_collgdmdylabel <<- input$tc_collgdmdylabel
          tc_collgdlabel <<- input$tc_collgdlabel
          tc_sizelgdmdylabel <<- input$tc_sizelgdmdylabel
          tc_sizelgdlabel <<- input$tc_sizelgdlabel
          tc_shapelgdmdylabel <<- input$tc_shapelgdmdylabel
          tc_shapelgdlabel <<- input$tc_shapelgdlabel
          output$errorinfo6 <- renderPrint({
            validate(
              need(!is.null(data.C1), "Please upload genome1 data!")
            )		
            validate(
              need(!is.null(data.C2), "Please upload genome2 data!")
            )		
            if(input$tc_plottype %in% c("point_gradual","point_discrete")){			          
              validate(
                need(ncol(data.TC)==4 | (ncol(data.TC)>4 && all(names(data.TC)[5:ncol(data.TC)] %in% c("color","shape","size"))), "Error: Data formatting error! Please upload applicable plot data.")	 
              )
            }
            if(input$tc_plottype %in% "segment"){			          
              validate(
                need(ncol(data.TC)==6 | (ncol(data.TC)==7 && names(data.TC)[7]=="color"), "Error: Data formatting error! Please upload applicable plot data.")	 
              )
            }
            if(input$tc_plottype %in% "point_gradual"){
              validate(
                need(is.numeric(data.TC[,"color"]), 'Error: Data formatting error! For gradual data, the "color" column should be a numeric vector. Please upload applicable plot data.')
              )
            }
            if(input$tc_plottype %in% "point_discrete"){
              validate(
                need(("color" %in% names(data.TC) && length(unique(data.TC[,"color"]))<=50) | !"color" %in% names(data.TC), 'Error: Data formatting error! For discrete data, the "color" column should be a categorical character vector with no more than 50 groups. Please upload applicable plot data.')
              )
            }	
            if(input$tc_plottype %in% "rect_gradual"){
              validate(
                need(ncol(data.TC)==7 && is.numeric(data.TC[,"color"]), 'Error: Data formatting error! Data should contain 7 columns. For gradual data, the "color" column should be a numeric vector. Please upload applicable plot data.')
              )
            }
            if(input$tc_plottype %in% "rect_discrete"){
              validate(
                need(ncol(data.TC)==6 | (ncol(data.TC)==7 && names(data.TC)[7]=="color" && length(unique(data.TC[,"color"]))<=50), 'Error: Data formatting error! Data should contain 6 columns or 7 columns. For discrete data with 7 columns, the "color" column should be a categorical character vector with no more than 50 groups. Please upload applicable plot data.')
              )
            }			
          })
          outputOptions(output, "errorinfo6", suspendWhenHidden = FALSE)
          plotfig_tc(input=input, output=output, data.C1=data.C1, data.C2=data.C2, data.TC=data.TC, Height=tc_Height, Width=tc_Width, selgralcol=tc_selgralcol, gralcol_tp=tc_gralcol_tp, gralcol_ct=tc_gralcol_ct, coltype=tc_coltype, colorcus=tc_colorcus, colormulgp=tc_colormulgp, coltransparency=tc_coltransparency, themestyle=tc_themestyle, fontSize=tc_fontSize, xtitle=tc_xtitle, ytitle=tc_ytitle, titlefontface=tc_titlefontface, xlabel=tc_xlabel, ylabel=tc_ylabel, legendpos=tc_legendpos, lgdtitlesize=tc_lgdtitlesize, lgdtitlefontface=tc_lgdtitlefontface, lgdtextfontface=tc_lgdtextfontface, lgdtextsize=tc_lgdtextsize, symbolpoint=tc_symbolpoint, symbolpointype=sel_tc_symbolpointype, pointsize=tc_pointsize, pointsizetype=sel_tc_pointsizetype, linesize=tc_linesize, vertical=tc_vertical, verticalcol=tc_verticalcol, verticalsize=tc_verticalsize, verticaltype=tc_verticaltype, horizontal=tc_horizontal, horizontalcol=tc_horizontalcol, horizontalsize=tc_horizontalsize, horizontaltype=tc_horizontaltype, bordercols=tc_bordercols, addborder=tc_addborder, linetype=tc_linetype, collgd=tc_collgd, collgdname=tc_collgdname, sizelgd=tc_sizelgd, sizelgdname=tc_sizelgdname, shapelgd=tc_shapelgd, shapelgdname=tc_shapelgdname, collgdmdylabel=tc_collgdmdylabel, collgdlabel=tc_collgdlabel, sizelgdmdylabel=tc_sizelgdmdylabel, sizelgdlabel=tc_sizelgdlabel, shapelgdmdylabel=tc_shapelgdmdylabel, shapelgdlabel=tc_shapelgdlabel, plottype=tc_plottype)
        }
      })
    } else {
      NULL
    }
  })  
  ## Download PDF file
  output$Visualization_1.pdf <- downloadHandler(
    filename <- function() { paste('Visualization_1.pdf') },
    content <- function(file) {
      pdf(file, width = input$Width/72, height = input$Height/72)
      print(figure_1)
      dev.off()
    }, contentType = 'application/pdf')
  output$Visualization_2.pdf <- downloadHandler(
    filename <- function() { paste('Visualization_2.pdf') },
    content <- function(file) {
      pdf(file, width = input$tc_Width/72, height = input$tc_Height/72)
      print(figure_2)
      dev.off()
    }, contentType = 'application/pdf')
  ## *** Download SVG file ***
  output$Visualization_1.svg <- downloadHandler(
    filename <- function(){ paste('Visualization_1.svg') },
    content <- function(file){
      svg(file, width = input$Width/72, height = input$Height/72)
      print(figure_1)		 
      dev.off()
    }, contentType = 'image/svg')
  output$Visualization_2.svg <- downloadHandler(
    filename <- function(){ paste('Visualization_2.svg') },
    content <- function(file){
      svg(file, width = input$tc_Width/72, height = input$tc_Height/72)
      print(figure_2)		 
      dev.off()
    }, contentType = 'image/svg')  
  ## *** Download Source code file ***  
  output$Script_1.R <- downloadHandler(
    filename <- function() { paste('Script_1.R') },
    content <- function(file) {
      source("writeCmd-1.R")
      writeLines(out,con=file)
    }, contentType = NULL)
  output$Script_2.R <- downloadHandler(
    filename <- function() { paste('Script_2.R') },
    content <- function(file) {
      source("writeCmd-2.R")
      writeLines(out,con=file)
    }, contentType = NULL)	
  ## *** Download data file ***
  output$data.zip <- downloadHandler(
    filename <- function() {
      paste("data.zip")
    },
    content <- function(file) {
      file.copy("www/data.zip", file)
    },contentType = "application/zip"
  )
  
  ## Download example data
  output$genome_data.txt <- downloadHandler(
    filename <- function() { paste('genome_data.txt') },
    content <- function(file) {
      input_file <- "www/data/download_example_data/single_genome/genome_data.txt"
      example_dat <- read.table(input_file,head=T,as.is=T,sep="\t",quote="")
      write.table(example_dat,file=file,row.names=F,quote=F,sep="\t")
    }, contentType = 'text/csv')	
  
  output$genome1_data.txt <- downloadHandler(
    filename <- function() { paste('genome1_data.txt') },
    content <- function(file) {
      input_file <- "www/data/download_example_data/two_genome/genome1_data.txt"
      example_dat <- read.table(input_file,head=T,as.is=T,sep="\t",quote="")
      write.table(example_dat,file=file,row.names=F,quote=F,sep="\t")
    }, contentType = 'text/csv')	
  
  output$genome2_data.txt <- downloadHandler(
    filename <- function() { paste('genome2_data.txt') },
    content <- function(file) {
      input_file <- "www/data/download_example_data/two_genome/genome2_data.txt"
      example_dat <- read.table(input_file,head=T,as.is=T,sep="\t",quote="")
      write.table(example_dat,file=file,row.names=F,quote=F,sep="\t")
    }, contentType = 'text/csv')	
  
  output$example_data1.txt <- downloadHandler(
    filename <- function() { paste('example_data1.txt') },
    content <- function(file) {
      if(input$plottype1 %in% "point"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
      }else if(input$plottype1 %in% "line"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
      }else if(input$plottype1 %in% "bar"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
      }else if(input$plottype1 %in% "rect_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
      }else if(input$plottype1 %in% "rect_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
      }else if(input$plottype1 %in% "heatmap_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
      }else if(input$plottype1 %in% "heatmap_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
      }else if(input$plottype1 %in% "text"){
        input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
      }else if(input$plottype1 %in% "segment"){
        input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
      }else if(input$plottype1 %in% "vertical line"){
        input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
      }else if(input$plottype1 %in% "horizontal line"){
        input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
      }
      example_dat <- read.table(input_file,head=T,as.is=T,sep="\t",quote="")
      write.table(example_dat,file=file,row.names=F,quote=F,sep="\t")
    }, contentType = 'text/csv')
  
  output$example_data2.txt <- downloadHandler(
    filename <- function() { paste('example_data2.txt') },
    content <- function(file) {
      if(input$plottype2 %in% "point"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
      }else if(input$plottype2 %in% "line"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
      }else if(input$plottype2 %in% "bar"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
      }else if(input$plottype2 %in% "rect_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
      }else if(input$plottype2 %in% "rect_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
      }else if(input$plottype2 %in% "heatmap_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
      }else if(input$plottype2 %in% "heatmap_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
      }else if(input$plottype2 %in% "text"){
        input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
      }else if(input$plottype2 %in% "segment"){
        input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
      }else if(input$plottype2 %in% "vertical line"){
        input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
      }else if(input$plottype2 %in% "horizontal line"){
        input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
      }
      example_dat <- read.table(input_file,head=T,as.is=T,sep="\t",quote="")
      write.table(example_dat,file=file,row.names=F,quote=F,sep="\t")
    }, contentType = 'text/csv')
  
  output$example_data3.txt <- downloadHandler(
    filename <- function() { paste('example_data3.txt') },
    content <- function(file) {
      if(input$plottype3 %in% "point"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
      }else if(input$plottype3 %in% "line"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
      }else if(input$plottype3 %in% "bar"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
      }else if(input$plottype3 %in% "rect_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
      }else if(input$plottype3 %in% "rect_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
      }else if(input$plottype3 %in% "heatmap_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
      }else if(input$plottype3 %in% "heatmap_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
      }else if(input$plottype3 %in% "text"){
        input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
      }else if(input$plottype3 %in% "segment"){
        input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
      }else if(input$plottype3 %in% "vertical line"){
        input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
      }else if(input$plottype3 %in% "horizontal line"){
        input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
      }
      example_dat <- read.table(input_file,head=T,as.is=T,sep="\t",quote="")
      write.table(example_dat,file=file,row.names=F,quote=F,sep="\t")
    }, contentType = 'text/csv')
  
  output$example_data4.txt <- downloadHandler(
    filename <- function() { paste('example_data4.txt') },
    content <- function(file) {
      if(input$plottype4 %in% "point"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
      }else if(input$plottype4 %in% "line"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
      }else if(input$plottype4 %in% "bar"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
      }else if(input$plottype4 %in% "rect_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
      }else if(input$plottype4 %in% "rect_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
      }else if(input$plottype4 %in% "heatmap_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
      }else if(input$plottype4 %in% "heatmap_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
      }else if(input$plottype4 %in% "text"){
        input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
      }else if(input$plottype4 %in% "segment"){
        input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
      }else if(input$plottype4 %in% "vertical line"){
        input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
      }else if(input$plottype4 %in% "horizontal line"){
        input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
      }
      example_dat <- read.table(input_file,head=T,as.is=T,sep="\t",quote="")
      write.table(example_dat,file=file,row.names=F,quote=F,sep="\t")
    }, contentType = 'text/csv')	
  
  output$example_data5.txt <- downloadHandler(
    filename <- function() { paste('example_data5.txt') },
    content <- function(file) {
      if(input$plottype5 %in% "point"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
      }else if(input$plottype5 %in% "line"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
      }else if(input$plottype5 %in% "bar"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
      }else if(input$plottype5 %in% "rect_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
      }else if(input$plottype5 %in% "rect_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
      }else if(input$plottype5 %in% "heatmap_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
      }else if(input$plottype5 %in% "heatmap_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
      }else if(input$plottype5 %in% "text"){
        input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
      }else if(input$plottype5 %in% "segment"){
        input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
      }else if(input$plottype5 %in% "vertical line"){
        input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
      }else if(input$plottype5 %in% "horizontal line"){
        input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
      }
      example_dat <- read.table(input_file,head=T,as.is=T,sep="\t",quote="")
      write.table(example_dat,file=file,row.names=F,quote=F,sep="\t")
    }, contentType = 'text/csv')	
  
  output$example_data6.txt <- downloadHandler(
    filename <- function() { paste('example_data6.txt') },
    content <- function(file) {
      if(input$plottype6 %in% "point"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
      }else if(input$plottype6 %in% "line"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
      }else if(input$plottype6 %in% "bar"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
      }else if(input$plottype6 %in% "rect_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
      }else if(input$plottype6 %in% "rect_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
      }else if(input$plottype6 %in% "heatmap_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
      }else if(input$plottype6 %in% "heatmap_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
      }else if(input$plottype6 %in% "text"){
        input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
      }else if(input$plottype6 %in% "segment"){
        input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
      }else if(input$plottype6 %in% "vertical line"){
        input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
      }else if(input$plottype6 %in% "horizontal line"){
        input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
      }
      example_dat <- read.table(input_file,head=T,as.is=T,sep="\t",quote="")
      write.table(example_dat,file=file,row.names=F,quote=F,sep="\t")
    }, contentType = 'text/csv')	
  
  output$example_data7.txt <- downloadHandler(
    filename <- function() { paste('example_data7.txt') },
    content <- function(file) {
      if(input$plottype7 %in% "point"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
      }else if(input$plottype7 %in% "line"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
      }else if(input$plottype7 %in% "bar"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
      }else if(input$plottype7 %in% "rect_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
      }else if(input$plottype7 %in% "rect_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
      }else if(input$plottype7 %in% "heatmap_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
      }else if(input$plottype7 %in% "heatmap_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
      }else if(input$plottype7 %in% "text"){
        input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
      }else if(input$plottype7 %in% "segment"){
        input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
      }else if(input$plottype7 %in% "vertical line"){
        input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
      }else if(input$plottype7 %in% "horizontal line"){
        input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
      }
      example_dat <- read.table(input_file,head=T,as.is=T,sep="\t",quote="")
      write.table(example_dat,file=file,row.names=F,quote=F,sep="\t")
    }, contentType = 'text/csv')	
  
  output$example_data8.txt <- downloadHandler(
    filename <- function() { paste('example_data8.txt') },
    content <- function(file) {
      if(input$plottype8 %in% "point"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
      }else if(input$plottype8 %in% "line"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
      }else if(input$plottype8 %in% "bar"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
      }else if(input$plottype8 %in% "rect_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
      }else if(input$plottype8 %in% "rect_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
      }else if(input$plottype8 %in% "heatmap_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
      }else if(input$plottype8 %in% "heatmap_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
      }else if(input$plottype8 %in% "text"){
        input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
      }else if(input$plottype8 %in% "segment"){
        input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
      }else if(input$plottype8 %in% "vertical line"){
        input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
      }else if(input$plottype8 %in% "horizontal line"){
        input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
      }
      example_dat <- read.table(input_file,head=T,as.is=T,sep="\t",quote="")
      write.table(example_dat,file=file,row.names=F,quote=F,sep="\t")
    }, contentType = 'text/csv')
  
  output$example_data9.txt <- downloadHandler(
    filename <- function() { paste('example_data9.txt') },
    content <- function(file) {
      if(input$plottype9 %in% "point"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
      }else if(input$plottype9 %in% "line"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
      }else if(input$plottype9 %in% "bar"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
      }else if(input$plottype9 %in% "rect_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
      }else if(input$plottype9 %in% "rect_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
      }else if(input$plottype9 %in% "heatmap_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
      }else if(input$plottype9 %in% "heatmap_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
      }else if(input$plottype9 %in% "text"){
        input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
      }else if(input$plottype9 %in% "segment"){
        input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
      }else if(input$plottype9 %in% "vertical line"){
        input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
      }else if(input$plottype9 %in% "horizontal line"){
        input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
      }
      example_dat <- read.table(input_file,head=T,as.is=T,sep="\t",quote="")
      write.table(example_dat,file=file,row.names=F,quote=F,sep="\t")
    }, contentType = 'text/csv')	
  
  output$example_data10.txt <- downloadHandler(
    filename <- function() { paste('example_data10.txt') },
    content <- function(file) {
      if(input$plottype10 %in% "point"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
      }else if(input$plottype10 %in% "line"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
      }else if(input$plottype10 %in% "bar"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
      }else if(input$plottype10 %in% "rect_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
      }else if(input$plottype10 %in% "rect_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
      }else if(input$plottype10 %in% "heatmap_gradual"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
      }else if(input$plottype10 %in% "heatmap_discrete"){
        input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
      }else if(input$plottype10 %in% "text"){
        input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
      }else if(input$plottype10 %in% "segment"){
        input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
      }else if(input$plottype10 %in% "vertical line"){
        input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
      }else if(input$plottype10 %in% "horizontal line"){
        input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
      }
      example_dat <- read.table(input_file,head=T,as.is=T,sep="\t",quote="")
      write.table(example_dat,file=file,row.names=F,quote=F,sep="\t")
    }, contentType = 'text/csv')
  
  output$example_plot_data.txt <- downloadHandler(
    filename <- function() { paste('example_plot_data.txt') },
    content <- function(file) {
      if(input$tc_plottype %in% "point_gradual"){
        input_file <- "www/data/download_example_data/two_genome/plot_data_point_gradual.txt"
      }else if(input$tc_plottype %in% "point_discrete"){
        input_file <- "www/data/download_example_data/two_genome/plot_data_point_discrete.txt"
      }else if(input$tc_plottype %in% "segment"){
        input_file <- "www/data/download_example_data/two_genome/plot_data_segment.txt"
      }else if(input$tc_plottype %in% "rect_gradual"){
        input_file <- "www/data/download_example_data/two_genome/plot_data_rect_gradual.txt"
      }else if(input$tc_plottype %in% "rect_discrete"){
        input_file <- "www/data/download_example_data/two_genome/plot_data_rect_discrete.txt" 
      }
      example_dat <- read.table(input_file,head=T,as.is=T,sep="\t",quote="")
      write.table(example_dat,file=file,row.names=F,quote=F,sep="\t")
    }, contentType = 'text/csv')
  
  ## *** Manual ***
  output$pdfview <- renderUI({
    tags$iframe(style="height:1500px; width:100%; scrolling=yes", src="shinyChromosome_Help_Manual.pdf")
  })
  
  output$Table1 <- renderDataTable({
    x <- fread("www/data/download_example_data/single_genome/genome_data.txt")
    return(x)
  }, options = list(pageLength=10))
  
  output$Table2 <- renderDataTable({
    if(input$plottype1 %in% "point"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
    }else if(input$plottype1 %in% "line"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
    }else if(input$plottype1 %in% "bar"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
    }else if(input$plottype1 %in% "rect_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
    }else if(input$plottype1 %in% "rect_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
    }else if(input$plottype1 %in% "heatmap_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
    }else if(input$plottype1 %in% "heatmap_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
    }else if(input$plottype1 %in% "text"){
      input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
    }else if(input$plottype1 %in% "segment"){
      input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
    }else if(input$plottype1 %in% "vertical line"){
      input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
    }else if(input$plottype1 %in% "horizontal line"){
      input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
    }
    
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength=10))
  
  output$Table3 <- renderDataTable({
    if(input$plottype2 %in% "point"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
    }else if(input$plottype2 %in% "line"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
    }else if(input$plottype2 %in% "bar"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
    }else if(input$plottype2 %in% "rect_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
    }else if(input$plottype2 %in% "rect_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
    }else if(input$plottype2 %in% "heatmap_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
    }else if(input$plottype2 %in% "heatmap_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
    }else if(input$plottype2 %in% "text"){
      input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
    }else if(input$plottype2 %in% "segment"){
      input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
    }else if(input$plottype2 %in% "vertical line"){
      input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
    }else if(input$plottype2 %in% "horizontal line"){
      input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
    }
    
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength=10))
  
  output$Table4 <- renderDataTable({
    if(input$plottype3 %in% "point"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
    }else if(input$plottype3 %in% "line"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
    }else if(input$plottype3 %in% "bar"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
    }else if(input$plottype3 %in% "rect_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
    }else if(input$plottype3 %in% "rect_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
    }else if(input$plottype3 %in% "heatmap_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
    }else if(input$plottype3 %in% "heatmap_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
    }else if(input$plottype3 %in% "text"){
      input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
    }else if(input$plottype3 %in% "segment"){
      input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
    }else if(input$plottype3 %in% "vertical line"){
      input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
    }else if(input$plottype3 %in% "horizontal line"){
      input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
    }
    
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength=10))
  
  output$Table5 <- renderDataTable({
    if(input$plottype4 %in% "point"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
    }else if(input$plottype4 %in% "line"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
    }else if(input$plottype4 %in% "bar"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
    }else if(input$plottype4 %in% "rect_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
    }else if(input$plottype4 %in% "rect_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
    }else if(input$plottype4 %in% "heatmap_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
    }else if(input$plottype4 %in% "heatmap_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
    }else if(input$plottype4 %in% "text"){
      input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
    }else if(input$plottype4 %in% "segment"){
      input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
    }else if(input$plottype4 %in% "vertical line"){
      input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
    }else if(input$plottype4 %in% "horizontal line"){
      input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
    }
    
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength=10))
  
  output$Table6 <- renderDataTable({
    if(input$plottype5 %in% "point"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
    }else if(input$plottype5 %in% "line"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
    }else if(input$plottype5 %in% "bar"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
    }else if(input$plottype5 %in% "rect_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
    }else if(input$plottype5 %in% "rect_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
    }else if(input$plottype5 %in% "heatmap_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
    }else if(input$plottype5 %in% "heatmap_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
    }else if(input$plottype5 %in% "text"){
      input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
    }else if(input$plottype5 %in% "segment"){
      input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
    }else if(input$plottype5 %in% "vertical line"){
      input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
    }else if(input$plottype5 %in% "horizontal line"){
      input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
    }
    
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength=10))
  
  output$Table7 <- renderDataTable({
    if(input$plottype6 %in% "point"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
    }else if(input$plottype6 %in% "line"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
    }else if(input$plottype6 %in% "bar"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
    }else if(input$plottype6 %in% "rect_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
    }else if(input$plottype6 %in% "rect_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
    }else if(input$plottype6 %in% "heatmap_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
    }else if(input$plottype6 %in% "heatmap_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
    }else if(input$plottype6 %in% "text"){
      input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
    }else if(input$plottype6 %in% "segment"){
      input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
    }else if(input$plottype6 %in% "vertical line"){
      input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
    }else if(input$plottype6 %in% "horizontal line"){
      input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
    }
    
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength=10))
  
  output$Table8 <- renderDataTable({
    if(input$plottype7 %in% "point"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
    }else if(input$plottype7 %in% "line"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
    }else if(input$plottype7 %in% "bar"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
    }else if(input$plottype7 %in% "rect_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
    }else if(input$plottype7 %in% "rect_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
    }else if(input$plottype7 %in% "heatmap_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
    }else if(input$plottype7 %in% "heatmap_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
    }else if(input$plottype7 %in% "text"){
      input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
    }else if(input$plottype7 %in% "segment"){
      input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
    }else if(input$plottype7 %in% "vertical line"){
      input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
    }else if(input$plottype7 %in% "horizontal line"){
      input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
    }
    
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength=10))
  
  output$Table9 <- renderDataTable({
    if(input$plottype8 %in% "point"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
    }else if(input$plottype8 %in% "line"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
    }else if(input$plottype8 %in% "bar"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
    }else if(input$plottype8 %in% "rect_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
    }else if(input$plottype8 %in% "rect_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
    }else if(input$plottype8 %in% "heatmap_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
    }else if(input$plottype8 %in% "heatmap_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
    }else if(input$plottype8 %in% "text"){
      input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
    }else if(input$plottype8 %in% "segment"){
      input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
    }else if(input$plottype8 %in% "vertical line"){
      input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
    }else if(input$plottype8 %in% "horizontal line"){
      input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
    }
    
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength=10))
  
  output$Table10 <- renderDataTable({
    if(input$plottype9 %in% "point"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
    }else if(input$plottype9 %in% "line"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
    }else if(input$plottype9 %in% "bar"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
    }else if(input$plottype9 %in% "rect_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
    }else if(input$plottype9 %in% "rect_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
    }else if(input$plottype9 %in% "heatmap_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
    }else if(input$plottype9 %in% "heatmap_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
    }else if(input$plottype9 %in% "text"){
      input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
    }else if(input$plottype9 %in% "segment"){
      input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
    }else if(input$plottype9 %in% "vertical line"){
      input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
    }else if(input$plottype9 %in% "horizontal line"){
      input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
    }
    
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength=10))
  
  output$Table11 <- renderDataTable({
    if(input$plottype10 %in% "point"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_point.txt"
    }else if(input$plottype10 %in% "line"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_line.txt"
    }else if(input$plottype10 %in% "bar"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_bar.txt"
    }else if(input$plottype10 %in% "rect_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_gradual.txt"
    }else if(input$plottype10 %in% "rect_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_rect_discrete.txt" 
    }else if(input$plottype10 %in% "heatmap_gradual"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_gradual.txt" 
    }else if(input$plottype10 %in% "heatmap_discrete"){
      input_file <- "www/data/download_example_data/single_genome/data1_track1_heatmap_discrete.txt" 	   
    }else if(input$plottype10 %in% "text"){
      input_file <- "www/data/download_example_data/single_genome/data2_track2_text.txt" 	   
    }else if(input$plottype10 %in% "segment"){
      input_file <- "www/data/download_example_data/single_genome/data3_track2_segment.txt" 	   
    }else if(input$plottype10 %in% "vertical line"){
      input_file <- "www/data/download_example_data/single_genome/data2_track1_vertical_line.txt" 	   
    }else if(input$plottype10 %in% "horizontal line"){
      input_file <- "www/data/download_example_data/single_genome/data3_track1_horizontal_line.txt" 	   
    }
    
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength=10))
  
  output$Table12 <- renderDataTable({
    input_file <- "www/data/download_example_data/two_genome/genome1_data.txt"
    
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength=10))
  
  output$Table13 <- renderDataTable({
    input_file <- "www/data/download_example_data/two_genome/genome2_data.txt"
    
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength=10))
  
  output$Table14 <- renderDataTable({
    if(input$tc_plottype %in% "point_gradual"){
      input_file <- "www/data/download_example_data/two_genome/plot_data_point_gradual.txt"
    }else if(input$tc_plottype %in% "point_discrete"){
      input_file <- "www/data/download_example_data/two_genome/plot_data_point_discrete.txt"
    }else if(input$tc_plottype %in% "segment"){
      input_file <- "www/data/download_example_data/two_genome/plot_data_segment.txt"
    }else if(input$tc_plottype %in% "rect_gradual"){
      input_file <- "www/data/download_example_data/two_genome/plot_data_rect_gradual.txt"
    }else if(input$tc_plottype %in% "rect_discrete"){
      input_file <- "www/data/download_example_data/two_genome/plot_data_rect_discrete.txt" 
    }
    
    x <- fread(input_file)
    return(x)
  }, options = list(pageLength=10))
  
})



