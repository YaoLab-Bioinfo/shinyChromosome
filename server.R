
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
           uploadfile.export <<- c(uploadfile.export,trackfil$name)		   
           if(get(paste("seluploaddata",x,sep="")) == 2 & !is.null(trackfil)){
              data.frame(fread(trackfil$datapath),stringsAsFactors = F)
           }
        })
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
		colrect <<- c()
		heatmapcol <<- c()
		colhmap <<- c()
		heatmapcols <<- c()
		colhmapdis <<- c()
		colhmapdiscus <<- c()
		symbolpoint <<- c()
		pointsize <<- c()
		linecolor <<- c()
		linesize <<- c()
		fillarea <<- c()
		selareatype <<- c()
		borderarea <<- c()
	    xrugs <<- c()
		yrugs <<- c()
		xrugscol <<- c()
		yrugscol <<- c()
		linetype <<- c()
		addarrow <<- c()
		arrowpos <<- c()
		arrowsize <<- c()
		textcol <<- c()
		textsize <<- c()
		fontface <<- c()
		textangle <<- c()
		addlegend <<- c()
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
		   colrect <<- c(colrect,input[[paste("colrect",trackindx[k],sep="")]])
		   heatmapcol <<- c(heatmapcol,input[[paste("heatmapcol",trackindx[k],sep="")]])
		   colhmap <<- c(colhmap,input[[paste("colhmap",trackindx[k],sep="")]])
           heatmapcols <<- c(heatmapcols,paste(input[[paste("lowColor",trackindx[k],sep="")]],input[[paste("midColor",trackindx[k],sep="")]],input[[paste("highColor",trackindx[k],sep="")]],sep="."))
		   colhmapdis <<- c(colhmapdis,input[[paste("colhmapdis",trackindx[k],sep="")]])
		   colhmapdiscus <<- c(colhmapdiscus,input[[paste("colhmapdiscus",trackindx[k],sep="")]])
		   symbolpoint <<- c(symbolpoint,input[[paste("symbolpoint",trackindx[k],sep="")]])
		   pointsize <<- c(pointsize,input[[paste("pointsize",trackindx[k],sep="")]])
		   linecolor <<- c(linecolor,input[[paste("linecolor",trackindx[k],sep="")]])
		   linesize <<- c(linesize,input[[paste("linesize",trackindx[k],sep="")]])
		   fillarea <<- c(fillarea,input[[paste("fillarea",trackindx[k],sep="")]])
		   selareatype <<- c(selareatype,input[[paste("selareatype",trackindx[k],sep="")]])
		   borderarea <<- c(borderarea,input[[paste("borderarea",trackindx[k],sep="")]])
		   xrugs <<- c(xrugs,input[[paste("xrugs",trackindx[k],sep="")]])
		   yrugs <<- c(yrugs,input[[paste("yrugs",trackindx[k],sep="")]])
		   xrugscol <<- c(xrugscol,input[[paste("xrugscol",trackindx[k],sep="")]])
		   yrugscol <<- c(yrugscol,input[[paste("yrugscol",trackindx[k],sep="")]])
		   linetype <<- c(linetype,input[[paste("linetype",trackindx[k],sep="")]])
		   addarrow <<- c(addarrow,input[[paste("addarrow",trackindx[k],sep="")]])
		   arrowpos <<- c(arrowpos,input[[paste("arrowpos",trackindx[k],sep="")]])
		   arrowsize <<- c(arrowsize,input[[paste("arrowsize",trackindx[k],sep="")]])
		   textcol <<- c(textcol,input[[paste("textcol",trackindx[k],sep="")]])
		   textsize <<- c(textsize,input[[paste("textsize",trackindx[k],sep="")]])
		   fontface <<- c(fontface,input[[paste("fontface",trackindx[k],sep="")]])
		   textangle <<- c(textangle,input[[paste("textangle",trackindx[k],sep="")]])
		   addlegend <<- c(addlegend,input[[paste("addlegend",trackindx[k],sep="")]])
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
					if(plottype[m] %in% c("point", "line", "bar", "rect_gradual", "rect_discrete", "heatmap_gradual", "heatmap_discrete", "text")){
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
                             need(is.numeric(dt.TT[,4]), paste("Error: Data formatting error for Data",trackindx[m],"!"," For gradual data, the fourth column should be a numeric vector."," Please upload applicable data.",sep=""))
                         )
			        }
		            if(plottype[m] %in% "rect_discrete"){
						 validate(
                             need(length(unique(dt.TT[,4]))<=50, paste("Error: Data formatting error for Data",trackindx[m],"!"," For discrete data, the fourth column should be a categorical character vector with no more than 50 groups."," Please upload applicable data.",sep=""))
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
		plotfig(input=input, output=output, data.C=data.C, data.T=data.T, trackindx=trackindx, chrplotype=chrplotype, plottype=plottype, plotdirection=plotdirection, layerindex=layerindex, Height=Height, Width=Width, coltype=coltype, colorcus=colorcus, colormulgp=colormulgp, coltransparency=coltransparency, heightlayer=heightlayer, marginlayer=marginlayer, themestyle=themestyle, fontSize=fontSize, xtitle=xtitle, ytitle=ytitle, titlefontface=titlefontface, xlabel=xlabel, ylabel=ylabel, legendpos=legendpos, lgdspacesize=lgdspacesize, lgdintrasize=lgdintrasize, lgdtitlesize=lgdtitlesize, lgdtitlefontface=lgdtitlefontface, lgdtextfontface=lgdtextfontface, lgdtextsize=lgdtextsize, addborder=addborder, bordercols=bordercols, rectcol=rectcol, rectcoldis=rectcoldis, rectcoldiscus=rectcoldiscus, colrect=colrect, heatmapcol=heatmapcol, colhmap=colhmap, heatmapcols=heatmapcols, colhmapdis=colhmapdis, colhmapdiscus=colhmapdiscus, symbolpoint=symbolpoint, pointsize=pointsize, linecolor=linecolor, linesize=linesize, fillarea=fillarea, selareatype=selareatype, borderarea=borderarea, xrugs=xrugs, yrugs=yrugs, xrugscol=xrugscol, yrugscol=yrugscol, linetype=linetype, addarrow=addarrow, arrowpos=arrowpos, arrowsize=arrowsize, textcol=textcol, textsize=textsize, fontface=fontface, textangle=textangle, addlegend=addlegend, collgd=collgd, collgdname=collgdname, sizelgd=sizelgd, sizelgdname=sizelgdname, shapelgd=shapelgd, shapelgdname=shapelgdname, linetypelgd=linetypelgd, linetypelgdname=linetypelgdname, collgdmdylabel=collgdmdylabel, collgdlabel=collgdlabel, sizelgdmdylabel=sizelgdmdylabel, sizelgdlabel=sizelgdlabel, shapelgdmdylabel=shapelgdmdylabel, shapelgdlabel=shapelgdlabel, linetypelgdmdylabel=linetypelgdmdylabel, linetypelgdlabel=linetypelgdlabel)
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
		tc_pointsize <<- input$tc_pointsize
		tc_linesize <<- input$tc_linesize
	    tc_xrugs <<- input$tc_xrugs
		tc_yrugs <<- input$tc_yrugs
		tc_xrugscol <<- input$tc_xrugscol
		tc_yrugscol <<- input$tc_yrugscol
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
		tc_addlegend <<- input$tc_addlegend
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
                    need(ncol(data.TC)==4 | (ncol(data.TC)>4 && all(names(data.TC)[5:ncol(data.TC)] %in% c("color","shape","size"))), "Error: Data formatting error! Please upload applicable data.")	 
                )
			}
            if(input$tc_plottype %in% "segment"){			          
			    validate(
                    need(ncol(data.TC)==6 | (ncol(data.TC)==7 && names(data.TC)[7]=="color"), "Error: Data formatting error! Please upload applicable data.")	 
                )
			}
		    if(input$tc_plottype %in% "point_gradual"){
			    validate(
                    need(is.numeric(data.TC[,"color"]), 'Error: Data formatting error! For gradual data, the "color" column should be a numeric vector. Please upload applicable data.')
                )
			}
		    if(input$tc_plottype %in% "point_discrete"){
				validate(
                    need(("color" %in% names(data.TC) && length(unique(data.TC[,"color"]))<=50) | !"color" %in% names(data.TC), 'Error: Data formatting error! For discrete data, the "color" column should be a categorical character vector with no more than 50 groups. Please upload applicable data.')
                )
			}	
        })
        outputOptions(output, "errorinfo6", suspendWhenHidden = FALSE)
		plotfig_tc(input=input, output=output, data.C1=data.C1, data.C2=data.C2, data.TC=data.TC, Height=tc_Height, Width=tc_Width, selgralcol=tc_selgralcol, gralcol_tp=tc_gralcol_tp, gralcol_ct=tc_gralcol_ct, coltype=tc_coltype, colorcus=tc_colorcus, colormulgp=tc_colormulgp, coltransparency=tc_coltransparency, themestyle=tc_themestyle, fontSize=tc_fontSize, xtitle=tc_xtitle, ytitle=tc_ytitle, titlefontface=tc_titlefontface, xlabel=tc_xlabel, ylabel=tc_ylabel, legendpos=tc_legendpos, lgdtitlesize=tc_lgdtitlesize, lgdtitlefontface=tc_lgdtitlefontface, lgdtextfontface=tc_lgdtextfontface, lgdtextsize=tc_lgdtextsize, symbolpoint=tc_symbolpoint, pointsize=tc_pointsize, linesize=tc_linesize, xrugs=tc_xrugs, yrugs=tc_yrugs, xrugscol=tc_xrugscol, yrugscol=tc_yrugscol, vertical=tc_vertical, verticalcol=tc_verticalcol, verticalsize=tc_verticalsize, verticaltype=tc_verticaltype, horizontal=tc_horizontal, horizontalcol=tc_horizontalcol, horizontalsize=tc_horizontalsize, horizontaltype=tc_horizontaltype, bordercols=tc_bordercols, addborder=tc_addborder, linetype=tc_linetype, addlegend=tc_addlegend, collgd=tc_collgd, collgdname=tc_collgdname, sizelgd=tc_sizelgd, sizelgdname=tc_sizelgdname, shapelgd=tc_shapelgd, shapelgdname=tc_shapelgdname, collgdmdylabel=tc_collgdmdylabel, collgdlabel=tc_collgdlabel, sizelgdmdylabel=tc_sizelgdmdylabel, sizelgdlabel=tc_sizelgdlabel, shapelgdmdylabel=tc_shapelgdmdylabel, shapelgdlabel=tc_shapelgdlabel, plottype=tc_plottype)
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
    ## *** Manual ***
    output$pdfview <- renderUI({
      tags$iframe(style="height:1500px; width:100%; scrolling=yes", src="shinyChromosome_Help_Manual.pdf")
    })
})



