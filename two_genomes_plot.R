plotfig_tc <- function(input, output, data.C1, data.C2, data.TC, Height, Width, selgralcol, gralcol_tp, gralcol_ct, coltype, colorcus, colormulgp, coltransparency, themestyle, fontSize, xtitle, ytitle, titlefontface, xlabel, ylabel, legendpos, lgdtitlesize, lgdtitlefontface, lgdtextsize, lgdtextfontface, symbolpoint, symbolpointype, pointsizetype, pointsize, linesize, vertical, verticalcol, verticalsize, verticaltype, horizontal, horizontalcol, horizontalsize, horizontaltype, addborder, bordercols, linetype, curvature, collgd, collgdname, sizelgd, sizelgdname, shapelgd, shapelgdname, collgdmdylabel, collgdlabel, sizelgdmdylabel, sizelgdlabel, shapelgdmdylabel, shapelgdlabel, plottype){
	  output$figure_2 <- renderPlot({
#	      withProgress(message='Making plots',value = 0,{	  
	          names(data.C1) <- c("chr","size")
	          data.C1$size <- as.numeric(data.C1$size)
	          names(data.C2) <- c("chr","size")
	          data.C2$size <- as.numeric(data.C2$size) 
	          tc_p1 <- ggplot()
	          ## *** Plot theme ***
              if(themestyle %in% "theme1"){
	              tc_p1 <- tc_p1 + theme_bw()
	          }else if(themestyle %in% "theme2"){
		          tc_p1 <- tc_p1 + theme_classic()
	          }else if(themestyle %in% "theme3"){
		          tc_p1 <- tc_p1 + theme_minimal()
              }else if(themestyle %in% "theme4"){
		          tc_p1 <- tc_p1 + theme_few()
	          }else if(themestyle %in% "theme5"){
		          tc_p1 <- tc_p1+ theme_grey()
	          }else if(themestyle %in% "theme6"){
		          tc_p1 <- tc_p1 + theme_tufte()
	          }else if(themestyle %in% "theme7"){
		          tc_p1 <- tc_p1 + theme_calc()
              }else if(themestyle %in% "theme8"){
		          tc_p1 <- tc_p1 + theme_void()
	          }else if(themestyle %in% "theme9"){
		          tc_p1 <- tc_p1 + theme_base()
	          }else if(themestyle %in% "theme10"){
		          tc_p1 <- tc_p1 + theme_linedraw()
              }
	     data.TT <- data.TC
		 if(plottype %in% c("point_gradual","point_discrete")){
		    names(data.TT)[1:4] <- c("chr1","pos1","chr2","pos2")
			data.TT$pos1 <- as.numeric(data.TT$pos1)
			data.TT$pos2 <- as.numeric(data.TT$pos2)
		 }
         if(plottype %in% c("segment","rect_gradual","rect_discrete")){
		    names(data.TT)[1:6] <- c("chr1","xpos1","xpos2","chr2","ypos1","ypos2")
			data.TT$xpos1 <- as.numeric(data.TT$xpos1)
			data.TT$xpos2 <- as.numeric(data.TT$xpos2)	
			data.TT$ypos1 <- as.numeric(data.TT$ypos1)
			data.TT$ypos2 <- as.numeric(data.TT$ypos2)
		 }
		 #### color		  
          if(plottype %in% c("point_gradual","rect_gradual")){
		      if(selgralcol==1){
                  gralcols <- gsub('\\"',"",gralcol_tp)    
		      }else{
		          gralcols <- gralcol_ct                                         
		      }
              gralcols <- unlist(strsplit(gralcols,"\\."))
          }	
          laycolor.export <<- c()		  
          if(plottype %in% c("point_discrete","segment","rect_discrete")){
            data.TTC <- NULL
            if(coltype==2){
              laycolor <- colorcus
              laycolor <- gsub("\\s","",strsplit(laycolor,",")[[1]])
              laycolor <- gsub('\\"',"",laycolor)
              laycolor <- gsub("0x","#", laycolor)
			  if(length(laycolor)==0){
			      laycolor <- NA
			  }
              data.TT$color <- laycolor
            }else if(coltype==3 & ("color" %in% colnames(data.TT))){
			  laycolor <- colormulgp
              laycolor <- unlist(strsplit(laycolor,";"))
              laycolor <- data.frame(id=laycolor,stringsAsFactors=F)
              laycolor$group <- gsub("\\:.*","",laycolor$id)
              laycolor$cols <- gsub(".*\\:","",laycolor$id)
              laycolor$group <- gsub(" ","",laycolor$group)
              laycolor$cols <- gsub(" ","",laycolor$cols)
			  colname <- colnames(data.TT)
              data.TTC <- merge(data.TT,laycolor,by.x="color",by.y="group",all.x=T)
			  data.TT <- data.TTC[c(colname,"cols")]
              laycolor <- unique(data.TT$cols)
              data.TT$raw_color <- data.TT$color
			  data.TT$color <- data.TT$cols
			  data.TT$cols <- NULL
            }else if(coltype==1 & ("color" %in% colnames(data.TT))){
              selcols <- c("blue", "red", "green", "cyan", "purple", "pink", "orange", "yellow", "navy", "seagreen", "maroon", "burlywood3", "magenta2")
              laycolor <- sample(selcols,length(unique(data.TT$color)))
			  laycolor.export <<- paste(laycolor,collapse=".")
			  laycolor <- data.frame(group=unique(data.TT$color),cols=laycolor,stringsAsFactors=F)
              colname <- colnames(data.TT)
              data.TTC <- merge(data.TT,laycolor,by.x="color",by.y="group",all.x=T)
              data.TT <- data.TTC[c(colname,"cols")]
              laycolor <- unique(data.TT$cols)
              data.TT$raw_color <- data.TT$color			  
			  data.TT$color <- data.TT$cols
			  data.TT$cols <- NULL		
            }else{
              selcols <- c("blue", "red", "green", "cyan", "purple", "pink", "orange", "yellow", "navy", "seagreen", "maroon", "burlywood3", "magenta2")
              laycolor <- sample(selcols,1)
			  laycolor.export <<- paste(laycolor,collapse=".")
			  data.TT$color <- laycolor
            }
			jd_col <- data.TT$color
			output$errorinfo5 <- renderPrint({
                if(input$tc_plottype %in% c("point_discrete","segment","rect_discrete")){			          
			        validate(
                        need(all(areColors(jd_col)), "Error: Data color error! Please input applicable color name.")	 
                    )
				}
            })
            outputOptions(output, "errorinfo5", suspendWhenHidden = FALSE)
          }
          ## *** The data color ***
		 if(!plottype %in% c("point_gradual","rect_gradual")){
		     if(!"raw_color" %in% names(data.TT)){
		         data.TT$raw_color <- data.TT$color
		     }		 
		     data.TT$color[!areColors(data.TT$color)] <- NA
             data.TT$color <- adjustcolor(data.TT$color, alpha.f = coltransparency)		 
		     labelscol <- unique(data.TT$raw_color)
             breakscol <- data.TT$color[match(labelscol,data.TT$raw_color)]		 
		     labelscol <- labelscol[!duplicated(breakscol)]
		     breakscol <- breakscol[!duplicated(breakscol)]
             data.TT$raw_color <- factor(data.TT$raw_color,levels=labelscol,ordered = T)
             data.TT$color <- factor(data.TT$color,levels=breakscol,ordered = T)			 
			 labelscol <- labelscol[which(!breakscol %in% "#FFFFFF00")]
			 breakscol <- breakscol[!breakscol %in% "#FFFFFF00"]		 
		 }
		 ## *** Point type and size ***
		 if(plottype %in% c("point_gradual","point_discrete")){			 
		     if(symbolpointype==1){
			     data.TT$shape <- as.numeric(symbolpoint)
			 }else if(symbolpointype==2 & (!"shape" %in% names(data.TT))){
			     data.TT$shape <- 16
			 }
			 if(pointsizetype==1){
			     data.TT$size <- as.numeric(pointsize)		 			 
			 }else if(pointsizetype==2 & (!"size" %in% names(data.TT))){
			     data.TT$size <- 0.8
			 }
			 breakspch <- unique(data.TT$shape)
			 labelspch <- breakspch
			 breakscex <- unique(data.TT$size)
			 labelscex <- breakscex 
		 }
		 output$errorinfo8 <- renderPrint({
             if(input$tc_plottype %in% c("point_gradual","point_discrete")){			          
			     validate(
                     need(breakspch>=0 & breakspch<=25, "Error: Symbol type error for Data! Please input one applicable integer in [0-25].")
                 )
			 }
         })
         outputOptions(output, "errorinfo8", suspendWhenHidden = FALSE)		 
         ## *** Borders ***
		 if(addborder==2){
		     bordercols <- NA
		 }
		 ## *** Legends ***
		 addcollgd <- "none"
		 addsizelgd <- "none"
		 addshapelgd <- "none"
		   if(collgd==1){
		      if(plottype %in% c("point_gradual","rect_gradual")){
		          addcollgd <- "colourbar"
			  }else{
		          addcollgd <- "legend"			  
			  }
			  if(plottype %in% c("point_discrete","segment","rect_discrete")){
			      if(collgdmdylabel==1){
                      collgdlabelp <- gsub("\\s","",strsplit(collgdlabel,",")[[1]])
                      collgdlabelp <- gsub('\\"',"",collgdlabelp)
			      if(length(collgdlabelp)==0){
			          collgdlabelp <- "NA"
			      }
			      collgdlabelp <- rep(collgdlabelp,length(breakscol))[1:length(breakscol)]
			      names(collgdlabelp) <- labelscol
	              data.TT$raw_color <- as.character(data.TT$raw_color)
			      data.TT$raw_color <- collgdlabelp[data.TT$raw_color]				  
			      labelscol <- unname(collgdlabelp)
			      data.TT$raw_color <- factor(data.TT$raw_color,levels=unique(labelscol),ordered = T)
			      }
			  }
		   }
		   if(plottype %in% c("point_gradual","point_discrete")){
		   if(sizelgd==1){
		     addsizelgd <- "legend"
			 if(sizelgdmdylabel==1){
                 sizelgdlabelp <- gsub("\\s","",strsplit(sizelgdlabel,",")[[1]])
                 sizelgdlabelp <- gsub('\\"',"",sizelgdlabelp)
				 if(length(sizelgdlabelp)==0){
			         sizelgdlabelp <- "NA"
			     }
             labelscex <- rep(sizelgdlabelp,length(breakscex))[1:length(breakscex)]	 
			 }	  
		   }
		   if(shapelgd==1){
		     addshapelgd <- "legend"
			 if(shapelgdmdylabel==1){
                 shapelgdlabelp <- gsub("\\s","",strsplit(shapelgdlabel,",")[[1]])
                 shapelgdlabelp <- gsub('\\"',"",shapelgdlabelp)
				 if(length(shapelgdlabelp)==0){
			         shapelgdlabelp <- "NA"
			     }
             labelspch <- rep(shapelgdlabelp,length(breakspch))[1:length(breakspch)]
			 }
		   }
		   }
		 chr.len <- data.C1$size
         names(chr.len) <- data.C1$chr
         chr.cum.len_1 <- c(0, cumsum(chr.len))
		 chr.cum.len <- c(0, cumsum(chr.len)[-length(chr.len)])
         names(chr.cum.len) <- names(chr.len)
		 data.C1$chrstart <- 0
		 data.C1$pos <- (data.C1$chrstart+data.C1$size)/2
		 data.C1$chr <- factor(data.C1$chr,levels = names(chr.cum.len),ordered=T)
		 data.C1$pos <- data.C1$pos + chr.cum.len[data.C1$chr]
		 data.C1$chr <- as.character(data.C1$chr)
		 data.TT$chr1 <- factor(data.TT$chr1,levels = names(chr.cum.len),ordered=T)
		 
		 if(plottype %in% c("segment","rect_gradual","rect_discrete")){
		     data.TT$xpos1 <- data.TT$xpos1 + chr.cum.len[data.TT$chr1]
			 data.TT$xpos2 <- data.TT$xpos2 + chr.cum.len[data.TT$chr1]
		 }else{
             data.TT$pos1 <- data.TT$pos1 + chr.cum.len[data.TT$chr1]
		 }
		 data.TT$chr1 <- as.character(data.TT$chr1)
		 chr.len <- data.C2$size
         names(chr.len) <- data.C2$chr
		 chr.cum.len_2 <- c(0, cumsum(chr.len))
         chr.cum.len <- c(0, cumsum(chr.len)[-length(chr.len)])
         names(chr.cum.len) <- names(chr.len)
		 data.C2$chrstart <- 0
		 data.C2$pos <- (data.C2$chrstart+data.C2$size)/2
		 data.C2$chr <- factor(data.C2$chr,levels = names(chr.cum.len),ordered=T)		 
		 data.C2$pos <- data.C2$pos + chr.cum.len[data.C2$chr]
		 data.C2$chr <- as.character(data.C2$chr)
		 data.TT$chr2 <- factor(data.TT$chr2,levels = names(chr.cum.len),ordered=T)		 
		 if(plottype %in% c("segment","rect_gradual","rect_discrete")){
		     data.TT$ypos1 <- data.TT$ypos1 + chr.cum.len[data.TT$chr2]
			 data.TT$ypos2 <- data.TT$ypos2 + chr.cum.len[data.TT$chr2]
		 }else{
             data.TT$pos2 <- data.TT$pos2 + chr.cum.len[data.TT$chr2]	 
		 }
		 data.TT$chr2 <- as.character(data.TT$chr2)
		 if(plottype %in% "point_gradual"){
		     midpoint <- mean(data.TT$color,na.rm = T)
			 if(is.numeric(labelscex)){
			     labelscex <- sprintf("%.1f",sort(labelscex))
			 }
             if(legendpos==1){
			     tc_p1 <- tc_p1 + geom_point(data=data.TT, aes(x=pos1, y=pos2, color=color, shape=as.character(shape), size=size)) + scale_color_gradient2(name=collgdname,guide=addcollgd,low = gralcols[1],midpoint=midpoint,mid=gralcols[2],high=gralcols[3],na.value="#FFFFFF00") + scale_size_identity(name=sizelgdname,guide = addsizelgd,breaks=sort(breakscex),labels=labelscex) + scale_shape_manual(name=shapelgdname,guide = addshapelgd,values=sort(breakspch),labels=sort(labelspch)) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
			 }else{
			     tc_p1 <- tc_p1 + geom_point(data=data.TT, aes(x=pos1, y=pos2, color=color, shape=as.character(shape), size=size)) + scale_color_gradient2(name=collgdname,guide=addcollgd,low = gralcols[1],midpoint=midpoint,mid=gralcols[2],high=gralcols[3],na.value="#FFFFFF00") + scale_size_identity(name=sizelgdname,guide = addsizelgd,breaks=sort(breakscex),labels=labelscex) + scale_shape_manual(name=shapelgdname,guide = addshapelgd,values=sort(breakspch),labels=sort(labelspch)) + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
			 }
			 if(addcollgd %in% "colourbar"){
			     tc_p1 <- tc_p1 + guides(color = guide_colorbar(order = 1, title.vjust = 0.8, title.hjust = 0.4), size = guide_legend(order = 2))
			 }else{
			     tc_p1 <- tc_p1 + guides(size = guide_legend(order = 1))			 
			 }
         }
		 if(plottype %in% "point_discrete"){
			 if(is.numeric(labelscex)){
			     labelscex <- sprintf("%.1f",sort(labelscex))
			 }		 
			 if(legendpos==1){
		         tc_p1 <- tc_p1 + geom_point(data=data.TT, aes(pos1, pos2, color=color, shape=as.character(shape), size=size)) + scale_color_identity(name=collgdname,guide = addcollgd,breaks=breakscol,labels=labelscol) + scale_size_identity(name=sizelgdname,guide = addsizelgd,breaks=sort(breakscex),labels=labelscex) + scale_shape_manual(name=shapelgdname,guide = addshapelgd,values=sort(breakspch),labels=sort(labelspch)) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA)) + guides(color = guide_legend(order = 1), size = guide_legend(order = 2))
			 }else{
		         tc_p1 <- tc_p1 + geom_point(data=data.TT, aes(pos1, pos2, color=color, shape=as.character(shape), size=size)) + scale_color_identity(name=collgdname,guide = addcollgd,breaks=breakscol,labels=labelscol) + scale_size_identity(name=sizelgdname,guide = addsizelgd,breaks=sort(breakscex),labels=labelscex) + scale_shape_manual(name=shapelgdname,guide = addshapelgd,values=sort(breakspch),labels=sort(labelspch)) + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA)) + guides(color = guide_legend(order = 1), size = guide_legend(order = 2))			 
			 }
	     }
		 if(plottype %in% "segment"){
		     if(length(unique(data.TT$color))>1){
			     linetype <- "solid"
			 }
             if(legendpos==1){				 
		         tc_p1 <- tc_p1 + geom_segment(data=data.TT, aes(x=xpos1, y=ypos1, xend=xpos2, yend=ypos2, color=color), size=linesize, linetype=linetype) + scale_color_identity(name=collgdname,guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
			 }else{
		         tc_p1 <- tc_p1 + geom_segment(data=data.TT, aes(x=xpos1, y=ypos1, xend=xpos2, yend=ypos2, color=color), size=linesize, linetype=linetype) + scale_color_identity(name=collgdname,guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))					 
			 }
		 }
		 if(plottype %in% "rect_gradual"){
		     midpoint <- mean(data.TT$color,na.rm = T)
             if(legendpos==1){				 
		         tc_p1 <- tc_p1 + geom_rect(data=data.TT, aes(xmin=xpos1, xmax=xpos2, ymin=ypos1, ymax=ypos2, fill=color), color=bordercols) + scale_fill_gradient2(name=collgdname,guide = addcollgd,low = gralcols[1],midpoint=midpoint,mid=gralcols[2],high=gralcols[3],na.value="#FFFFFF00") + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
			 }else{
		         tc_p1 <- tc_p1 + geom_rect(data=data.TT, aes(xmin=xpos1, xmax=xpos2, ymin=ypos1, ymax=ypos2, fill=color), color=bordercols) + scale_fill_gradient2(name=collgdname,guide = addcollgd,low = gralcols[1],midpoint=midpoint,mid=gralcols[2],high=gralcols[3],na.value="#FFFFFF00") + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA)) + guides(fill = guide_colourbar(title.vjust = 0.8, title.hjust = 0.4))			 
			 }
		 } 
		 if(plottype %in% "rect_discrete"){		 
             if(legendpos==1){
		         tc_p1 <- tc_p1 + geom_rect(data=data.TT, aes(xmin=xpos1, xmax=xpos2, ymin=ypos1, ymax=ypos2, fill=color), color=bordercols) + scale_fill_identity(name=collgdname,guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))				 
			 }else{
			     tc_p1 <- tc_p1 + geom_rect(data=data.TT, aes(xmin=xpos1, xmax=xpos2, ymin=ypos1, ymax=ypos2, fill=color), color=bordercols) + scale_fill_identity(name=collgdname,guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
			 }		 
		 }
		 ## *** vertical line ***
		 if(vertical==1){
		    tc_p1 <- tc_p1 + geom_vline(xintercept=chr.cum.len_1, linetype=verticaltype, color=verticalcol, size=verticalsize)
		 }
		 ## *** horizontal line ***		 
		 if(horizontal==1){
		    tc_p1 <- tc_p1 + geom_hline(yintercept=chr.cum.len_2, linetype=horizontaltype, color=horizontalcol, size=horizontalsize)
		 }
	     ## *** axis label***
         if(xlabel==1){
	         tc_p1 <- tc_p1 + scale_x_continuous(breaks=data.C1$pos,labels=data.C1$chr)
	     }else{
	         tc_p1 <- tc_p1 + theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())
	     }	
         if(ylabel==1){
	         tc_p1 <- tc_p1 + scale_y_continuous(breaks=data.C2$pos,labels=data.C2$chr)		 
		 }else{
	         tc_p1 <- tc_p1 + theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())
	     }	  
         ## *** x and y axis title***
	     tc_p1 <- tc_p1 + xlab(xtitle) + ylab(ytitle)
         ## *** Font face ***
	     tc_p1 <- tc_p1 + theme(axis.title = element_text(face=titlefontface))		 
         ## *** Font size ***
         tc_p1 <- tc_p1 + theme(text = element_text(size=fontSize))	  
		 grid.draw(tc_p1)
	     figure_2 <<- recordPlot()
#         incProgress(1/1, detail="Finished")
#         })		 
    }, height = Height, width = Width)
}