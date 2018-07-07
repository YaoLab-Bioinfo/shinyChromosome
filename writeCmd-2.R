cat('## setwd("absolute path of a directory containing the input data files")',file="code.R",append=TRUE,sep="\n")
cat("library(gplots)
library(ggplot2)
library(plotly)
library(plyr)
library(shinyBS)
library(ggthemes)
library(RLumShiny)
library(RColorBrewer)
library(gridExtra)
library(reshape2)
library(data.table)
library(grid)",file="code.R",append=TRUE,sep="\n")
cat("",file="code.R",append=TRUE,sep="\n")
cat('g_legend <- function(a.gplot){
    tmp <- ggplot_gtable(ggplot_build(a.gplot))
    leg <- which(sapply(tmp$grobs, function(x) x$name) == "guide-box")
    legend <- tmp$grobs[[leg]]
    return(legend)
}
areColors <- function(x){
     sapply(x, function(y){
         tryCatch(is.matrix(col2rgb(y)), 
                  error = function(e) FALSE)
     })
}',file="code.R",append=TRUE,sep="\n")

cat("",file="code.R",append=TRUE,sep="\n")
cat(paste("Height <- ",tc_Height,sep=""),paste("Width <- ",tc_Width,sep=""),paste('themestyle <- "',tc_themestyle,'"',sep=""),paste("fontSize <- ",tc_fontSize,sep=""),
paste("xtitle <- ",'"',tc_xtitle,'"',sep=""),paste('ytitle <- "',tc_ytitle,'"',sep=""),paste("titlefontface <- ",'"',tc_titlefontface,'"',sep=""),paste("xlabel <- ",tc_xlabel,sep=""),paste("ylabel <- ",tc_ylabel,sep=""),
paste("legendpos <- ",tc_legendpos,sep=""),paste("lgdtitlesize <- ",tc_lgdtitlesize,sep=""),paste('lgdtitlefontface <- "',tc_lgdtitlefontface,'"',sep=""),paste("lgdtextsize <- ",tc_lgdtextsize,sep=""),paste('lgdtextfontface <- "',tc_lgdtextfontface,'"',sep=""),
paste('tc_chrdata1 <- "',tc_chrdata1$name,'"',sep=""),paste('tc_chrdata2 <- "',tc_chrdata2$name,'"',sep=""),"data.C1 <- data.frame(fread(tc_chrdata1), stringsAsFactors = F)","data.C2 <- data.frame(fread(tc_chrdata2), stringsAsFactors = F)",
paste('trackfil <- "',trackfil$name,'"',sep=""),"data.TC <- data.frame(fread(trackfil),stringsAsFactors = F)",file="code.R",append=TRUE,sep="\n")

cat(paste('plottype <- "',tc_plottype,'"',sep=""),paste("selgralcol <- ",tc_selgralcol,sep=""),paste('gralcol_tp <- "',tc_gralcol_tp,'"',sep=""),
paste('gralcol_ct <- c("',paste(tc_gralcol_ct,collapse='","'),'")',sep=""),paste("coltype <- ",tc_coltype,sep=""),paste('colorcus <- "',tc_colorcus,'"',sep=""),
paste('colormulgp <- "',tc_colormulgp,'"',sep=""),paste("coltransparency <- ",tc_coltransparency,sep=""),paste("symbolpoint <- ",tc_symbolpoint,sep=""),paste("pointsize <- ",tc_pointsize,sep=""),
paste("linesize <- ",tc_linesize,sep=""),paste("xrugs <- ",tc_xrugs,sep=""),paste("yrugs <- ",tc_yrugs,sep=""),paste('xrugscol <- "',tc_xrugscol,'"',sep=""),
paste('yrugscol <- "',tc_yrugscol,'"',sep=""),paste('vertical <- ',tc_vertical,sep=""),paste('verticalcol <- "',tc_verticalcol,'"',sep=""),paste('verticalsize <- ',tc_verticalsize,sep=""),
paste('verticaltype <- "',tc_verticaltype,'"',sep=""),paste('horizontal <- ',tc_horizontal,sep=""),paste('horizontalcol <- "',tc_horizontalcol,'"',sep=""),paste('horizontalsize <- ',tc_horizontalsize,sep=""),
paste('horizontaltype <- "',tc_horizontaltype,'"',sep=""),paste('addborder <- ',tc_addborder,sep=""),paste('bordercols <- "',tc_bordercols,'"',sep=""),paste('linetype <- "',tc_linetype,'"',sep=""),paste("addlegend <- ",tc_addlegend,sep=""),paste("collgd <- ",tc_collgd,sep=""),
paste('collgdname <- "',tc_collgdname,'"',sep=""),paste("sizelgd <- ",tc_sizelgd,sep=""),paste('sizelgdname <- "',tc_sizelgdname,'"',sep=""),paste("shapelgd <- ",tc_shapelgd,sep=""),
paste('shapelgdname <- "',tc_shapelgdname,'"',sep=""),paste("collgdmdylabel <- ",tc_collgdmdylabel,sep=""),paste('collgdlabel <- "',tc_collgdlabel,'"',sep=""),paste("sizelgdmdylabel <- ",tc_sizelgdmdylabel,sep=""),
paste('sizelgdlabel <- "',tc_sizelgdlabel,'"',sep=""),paste("shapelgdmdylabel <- ",tc_shapelgdmdylabel,sep=""),paste('shapelgdlabel <- "',tc_shapelgdlabel,'"',sep=""),
paste('laycolor.export <- "',laycolor.export,'"',sep=""),file="code.R",append=TRUE,sep="\n")

cat('names(data.C1) <- c("chr","size")
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
		      if(selgralcol==1){',paste('gralcols <- gsub(',"'","\\\\",'"',"'",',"",gralcol_tp)',sep=""),
'}else{
		          gralcols <- gralcol_ct                                         
		      }
              gralcols <- unlist(strsplit(gralcols,"\\\\."))
          }
          if(plottype %in% c("point_discrete","segment","rect_discrete")){
            data.TTC <- NULL
            if(coltype==2){
              laycolor <- colorcus
              laycolor <- gsub("\\\\s","",strsplit(laycolor,",")[[1]])',paste('laycolor <- gsub(',"'","\\\\",'"',"'",',"",laycolor)',sep=""),
'laycolor <- gsub("0x","#", laycolor)
			  if(length(laycolor)==0){
			      laycolor <- NA
			  }
              data.TT$color <- laycolor
            }else if(coltype==3 & ("color" %in% colnames(data.TT))){
			  laycolor <- colormulgp
              laycolor <- unlist(strsplit(laycolor,";"))
              laycolor <- data.frame(id=laycolor,stringsAsFactors=F)
              laycolor$group <- gsub("\\\\:.*","",laycolor$id)
              laycolor$cols <- gsub(".*\\\\:","",laycolor$id)
              laycolor$group <- gsub(" ","",laycolor$group)
              laycolor$cols <- gsub(" ","",laycolor$cols)
			  jd_col <- laycolor$cols
			  colname <- colnames(data.TT)
              data.TTC <- merge(data.TT,laycolor,by.x="color",by.y="group",all.x=T)
			  data.TT <- data.TTC[c(colname,"cols")]
              laycolor <- unique(data.TT$cols)
              data.TT$raw_color <- data.TT$color
			  data.TT$color <- data.TT$cols
			  data.TT$cols <- NULL
            }else if(coltype==1 & ("color" %in% colnames(data.TT))){
			  laycolor <- unlist(strsplit(laycolor.export,"\\\\."))
			  laycolor <- data.frame(group=unique(data.TT$color),cols=laycolor,stringsAsFactors=F)
              colname <- colnames(data.TT)
              data.TTC <- merge(data.TT,laycolor,by.x="color",by.y="group",all.x=T)
              data.TT <- data.TTC[c(colname,"cols")]
              laycolor <- unique(data.TT$cols)
              data.TT$raw_color <- data.TT$color			  
			  data.TT$color <- data.TT$cols
			  data.TT$cols <- NULL		
            }else{
			  laycolor <- unlist(strsplit(laycolor.export,"\\\\."))			  
			  data.TT$color <- laycolor
            }			
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
		     if(!"shape" %in% names(data.TT)){
				 data.TT$shape <- as.numeric(symbolpoint)
			 }
			 if(!"size" %in% names(data.TT)){
			     data.TT$size <- as.numeric(pointsize)		 
		     }
			 breakspch <- unique(data.TT$shape)
			 labelspch <- breakspch
			 breakscex <- unique(data.TT$size)
			 labelscex <- breakscex 
		 }
         ## *** Borders ***
		 if(addborder==2){
		     bordercols <- NA
		 }		 
		 ## *** Legends ***
		 addcollgd <- "none"
		 addsizelgd <- "none"
		 addshapelgd <- "none"
		 if(addlegend==1){
		   if(collgd==1){
		      if(plottype %in% c("point_gradual","rect_gradual")){
		          addcollgd <- "colourbar"
			  }else{
		          addcollgd <- "legend"			  
			  }
			  if(plottype %in% c("point_discrete","segment","rect_discrete")){			  
			  if(collgdmdylabel==1){
                  collgdlabelp <- gsub("\\\\s","",strsplit(collgdlabel,",")[[1]])',paste('collgdlabelp <- gsub(',"'","\\\\",'"',"'",',"",collgdlabelp)',sep=""),
'if(length(collgdlabelp)==0){
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
                 sizelgdlabelp <- gsub("\\\\s","",strsplit(sizelgdlabel,",")[[1]])',paste('sizelgdlabelp <- gsub(',"'","\\\\",'"',"'",',"",sizelgdlabelp)',sep=""),
'if(length(sizelgdlabelp)==0){
			         sizelgdlabelp <- "NA"
			     }
             labelscex <- rep(sizelgdlabelp,length(breakscex))[1:length(breakscex)]	 
			 }	  
		   }
		   if(shapelgd==1){
		     addshapelgd <- "legend"
			 if(shapelgdmdylabel==1){
                 shapelgdlabelp <- gsub("\\\\s","",strsplit(shapelgdlabel,",")[[1]])',paste('shapelgdlabelp <- gsub(',"'","\\\\",'"',"'",',"",shapelgdlabelp)',sep=""),
'if(length(shapelgdlabelp)==0){
			         shapelgdlabelp <- "NA"
			     }
             labelspch <- rep(shapelgdlabelp,length(breakspch))[1:length(breakspch)]
			 }
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
	     if(plottype %in% c("point_gradual","point_discrete","segment")){
		     if(xrugs==1){
			     tc_p1 <- tc_p1 + geom_rug(data=data.TT, x=data.TT$pos1, color=xrugscol)
		     }
		     if(yrugs==1){
		         tc_p1 <- tc_p1 + geom_rug(data=data.TT, y=data.TT$pos2, color=yrugscol)				  
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
         tc_p1 <- tc_p1 + theme(text = element_text(size=fontSize))',file="code.R",append=TRUE,sep="\n")		 
cat("",file="code.R",append=TRUE,sep="\n")

cat(paste('pdf("Visualization_2.pdf", width=',tc_Width,"/72,"," height=",tc_Height,"/72)",sep=""),paste('## svg("Visualization_2.svg", width=',tc_Width,"/72,"," height=",tc_Height,"/72)",sep=""),
"grid.draw(tc_p1)","dev.off()",file="code.R",append=TRUE,sep="\n")		 

out <<- readLines("code.R")
file.remove("code.R")