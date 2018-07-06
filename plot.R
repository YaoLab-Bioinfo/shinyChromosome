
plotfig <- function(input, output, data.C, data.T, trackindx, chrplotype, plotdirection, plottype, layerindex, Height, Width, coltype, colorcus, colormulgp, coltransparency, heightlayer, marginlayer, themestyle, fontSize, xtitle, ytitle, titlefontface, xlabel, ylabel, legendpos, lgdspacesize, lgdintrasize, lgdtitlesize, lgdtitlefontface, lgdtextsize, lgdtextfontface, addborder, bordercols, rectcol, rectcoldis, rectcoldiscus, colrect, heatmapcol, colhmap, heatmapcols, colhmapdis, colhmapdiscus, symbolpoint, pointsize, linecolor, linesize, fillarea, selareatype, borderarea, xrugs, yrugs, xrugscol, yrugscol, linetype, addarrow, arrowpos, arrowsize, textcol, textsize, fontface, textangle, addlegend, collgd, collgdname, sizelgd, sizelgdname, shapelgd, shapelgdname, linetypelgd, linetypelgdname, collgdmdylabel, collgdlabel, sizelgdmdylabel, sizelgdlabel, shapelgdmdylabel, shapelgdlabel, linetypelgdmdylabel, linetypelgdlabel){
	  output$figure_1 <- renderPlot({
	      withProgress(message='Making plots',value = 0,{      
	      names(data.C) <- c("chr","size")
	      chr_order <- unique(data.C$chr)	  
	      data.C$size <- as.numeric(data.C$size) 
	      layernum <- length(unique(layerindex))
	      layerindex <- as.numeric(gsub("track", "", layerindex))
	      val_range <- list()
	      data.C$chrstart <- 0
	      names(data.C) <- c("chr","chrsize","chrstart")
	      data.C <- data.C[,c(1,3,2)]
	      val_range_chr <- melt(data=data.C,id.vars="chr")
	      val_range_chr$variable <- NULL	  
	      chr.len <- data.C$chrsize
          names(chr.len) <- data.C$chr
          chr.cum.len <- c(0, cumsum(chr.len)[-length(chr.len)])
          names(chr.cum.len) <- names(chr.len)
	  for(m in 1:length(data.T)){
	     data.TT <- data.T[[m]]
         if(!plottype[m] %in% c("rect_gradual","rect_discrete","heatmap_gradual","heatmap_discrete","vertical line")){
            if(plottype[m] %in% c("point","line")){
		       names(data.TT)[1:3] <- c("chr","pos","value")
		    }else if(plottype[m] %in% "bar"){
		       names(data.TT)[1:4] <- c("chr","xmin","xmax","value")		 
		    }else if(plottype[m] %in% "horizontal line"){
		       names(data.TT) <- "value"			
			   rep_num <- nrow(data.TT)
			   data.TT <- data.TT[rep(rownames(data.TT),length(unique(data.C$chr))),,drop=F]
			   data.TT$chr <- rep(unique(data.C$chr),each=rep_num)
		    }else if(plottype[m] %in% "segment"){
			   names(data.TT)[1:5] <- c("chr","xpos1","ypos1","xpos2","ypos2")
			}else if(plottype[m] %in% "text"){
			   names(data.TT) <- c("chr","pos","value","symbol")
			}
			if(plottype[m] %in% "segment"){
			   for(n in unique(data.TT$chr)){
                  data.TTT <- data.TT[data.TT$chr %in% n,]
			      val_range <- c(val_range,list(c(layerindex[m],n,min(c(data.TTT$ypos1,data.TTT$ypos2),na.rm = T),max(c(data.TTT$ypos1,data.TTT$ypos2),na.rm = T))))		   			   			  
			   }
			}else{
			   for(n in unique(data.TT$chr)){
                  data.TTT <- data.TT[data.TT$chr %in% n,]
			      val_range <- c(val_range,list(c(layerindex[m],n,min(data.TTT$value,na.rm = T),max(data.TTT$value,na.rm = T))))		   			   			  
			   }
			}
		 }
	  }
	  if(length(val_range)>0){
	     val_range <- as.data.frame(do.call(rbind,val_range),stringsAsFactors=F)
		 names(val_range) <- c("layer","chr","min_val","max_val")
		 val_range$layer <- as.numeric(val_range$layer)
		 val_range$min_val <- as.numeric(val_range$min_val)
		 val_range$max_val <- as.numeric(val_range$max_val)
		 val_range <- val_range[,c(1,3,4)]
		 val_range <- ddply(val_range,.(layer),function(x){
		     x$min_val <- min(x$min_val,na.rm = T)
			 x$max_val <- max(x$max_val,na.rm = T)
             return(x)
		 })
         val_range <- unique(val_range)
	  }
	  rg <- data.frame(num=sort(layerindex),height=heightlayer,gap=marginlayer,stringsAsFactors=F)
	  rg <- unique(rg)
	  heightlayer <- rg$height
	  names(heightlayer) <- rg$num
	  rg$height <- cumsum(rg$height)
	  rg$gap <- cumsum(rg$gap) 
      rg$ystart <- c(0,rg$height)[-(length(rg$height)+1)]+c(0,rg$gap)[-(length(rg$gap)+1)]
      rg$yend <- rg$height+c(0,rg$gap)[-length(rg$gap)]
	  rg_chrs <- rep(data.C$chr,length(unique(layerindex)))
	  rg_tmp <- rg[c("ystart","yend")][rep(rownames(rg),each=length(rg_chrs)/length(unique(layerindex))),]
	  rg_tmp$chr <- rg_chrs
	  names(val_range_chr) <- c("chr","pos")
	  val_range_chr <- merge(val_range_chr,rg_tmp,by="chr",all.x=T)
	  if(chrplotype==1){
	  	  val_range_chr$chr <- factor(val_range_chr$chr,levels = names(chr.cum.len),ordered=T)
	      val_range_chr$pos <- val_range_chr$pos + chr.cum.len[val_range_chr$chr]
		  val_range_chr$chr <- as.character(val_range_chr$chr)	      
		  val_range_chr <- val_range_chr[c(which(val_range_chr$pos==min(val_range_chr$pos)),which(val_range_chr$pos==max(val_range_chr$pos))),]
	  }
	  val_range_chr <- melt(data=val_range_chr,id.vars=c("chr","pos"))
	  val_range_chr$variable <- NULL
	  p1 <- ggplot() + geom_point(data=val_range_chr, aes(pos,value),color=NA)
      yaxis_breaks <- list()
	  yaxis_labels <- list()
      ## *** change priority level ***
	  indx <- lapply(c("heatmap_gradual", "heatmap_discrete", "rect_gradual","rect_discrete", "bar", "line", "segment", "point", "vertical line", "horizontal line", "text"), function(x){
          indx <- which(plottype %in% x)
          return(indx)
      })
      indx <- unlist(indx)
	  laycolor.export <<- list()
	  rect_discol.export <<- list()
	  heatmap_discol.export <<- list()
	  for(i in indx){	  
	     data.TT <- data.T[[i]]
         data.CC <- data.C
		 if(plottype[i] %in% c("point","line")){
		    names(data.TT)[1:3] <- c("chr","pos","value")
			data.TT$pos <- as.numeric(data.TT$pos)
		 }else if(plottype[i] %in% c("bar","rect_gradual","rect_discrete")){
		    names(data.TT)[1:4] <- c("chr","xmin","xmax","value")
			data.TT$xmin <- as.numeric(data.TT$xmin)
			data.TT$xmax <- as.numeric(data.TT$xmax)			
		 }else if(plottype[i] %in% c("heatmap_gradual","heatmap_discrete")){
            raw_names <- colnames(data.TT)[-c(1:3)]
            names(raw_names) <- paste("v",1:(ncol(data.TT)-3),sep="")            
			colnames(data.TT) <- c(c("chr","xmin","xmax"),paste("v",1:(ncol(data.TT)-3),sep=""))          
			data.TT <- melt(data.TT,id=c("chr","xmin","xmax"))
            data.TT$variable <- as.character(data.TT$variable)
			data.TT$raw_names <- raw_names[data.TT$variable]
            data.TT$variable <- as.numeric(gsub("v","",data.TT$variable))
            colnames(data.TT) <- c("chr","xmin","xmax","value","color","raw_names")
			data.TT$xmin <- as.numeric(data.TT$xmin)
			data.TT$xmax <- as.numeric(data.TT$xmax)
		 }else if(plottype[i] %in% "vertical line"){
		    names(data.TT) <- c("chr","pos")
            data.TT$ymin <- 1
            data.TT$ymax <- 10
			data.TT$pos <- as.numeric(data.TT$pos)			
		 }else if(plottype[i] %in% "horizontal line"){
		    names(data.TT) <- "value"
            data.TT$xmin <- 0			
			rep_num <- nrow(data.TT)
			names(data.CC) <- c("chr","xmin","xmax")
			data.CC <- data.CC[,c(1,3)]
			data.TT <- data.TT[rep(rownames(data.TT),length(unique(data.CC$chr))),]
			data.TT$chr <- rep(unique(data.CC$chr),each=rep_num)
			data.TT <- merge(data.TT,data.CC,by.x="chr",all.x=T)
			data.TT$xmin <- as.numeric(data.TT$xmin)
			data.TT$xmax <- as.numeric(data.TT$xmax)			
		 }else if(plottype[i] %in% "text"){
            names(data.TT) <- c("chr","pos","value","symbol")
			data.TT$pos <- as.numeric(data.TT$pos)
            data.TT$value <- as.numeric(data.TT$value)
			data.TT$symbol <- as.character(data.TT$symbol)
		 }else if(plottype[i] %in% "segment"){
		    names(data.TT)[1:5] <- c("chr","xpos1","ypos1","xpos2","ypos2")
			data.TT$xpos1 <- as.numeric(data.TT$xpos1)
			data.TT$ypos1 <- as.numeric(data.TT$ypos1)
			data.TT$xpos2 <- as.numeric(data.TT$xpos2)
			data.TT$ypos2 <- as.numeric(data.TT$ypos2)
		 }
         ## *** raw value ***
		 if(plottype[i] %in% c("point","line","bar")){
		     data.TT$raw_value <- data.TT$value
		 }		 
		 #### color
          if(plottype[i] %in% c("point","line","bar","segment")){
            data.TTC <- NULL
            coltypep <- coltype[i]
            if(coltypep==2){
              laycolor <- colorcus[i]
              laycolor <- gsub("\\s","",strsplit(laycolor,",")[[1]])
              laycolor <- gsub('\\"',"",laycolor)
              laycolor <- gsub("0x","#", laycolor)
			  if(length(laycolor)==0){
			      laycolor <- NA
			  }
              data.TT$color <- laycolor
            }else if(coltypep==3 & ("color" %in% colnames(data.TT))){
			  laycolor <- colormulgp[i]
              laycolor <- unlist(strsplit(laycolor,";"))
              laycolor <- data.frame(id=laycolor,stringsAsFactors=F)
              laycolor$group <- gsub("\\:.*","",laycolor$id)
              laycolor$cols <- gsub(".*\\:","",laycolor$id)
              laycolor$group <- gsub(" ","",laycolor$group)
              laycolor$cols <- gsub(" ","",laycolor$cols)
			  jd_col <- laycolor$cols
			  output$errorinfo2 <- renderPrint({
                  if(input[[paste("plottype",i,sep="")]] %in% c("point","line","bar","segment") && input[[paste("coltype",i,sep="")]]==3){			          
					  validate(
                          need(all(areColors(jd_col)), paste("Error: Data color error for Data",i,"!"," Please input applicable color name.",sep=""))	 
                      )
				  }
              })
              outputOptions(output, "errorinfo2", suspendWhenHidden = FALSE)
			  colname <- colnames(data.TT)
              data.TTC <- merge(data.TT,laycolor,by.x="color",by.y="group",all.x=T)
			  data.TT <- data.TTC[c(colname,"cols")]
              laycolor <- unique(data.TT$cols)
              data.TT$raw_color <- data.TT$color
			  data.TT$color <- data.TT$cols
			  data.TT$cols <- NULL
            }else if(coltypep==1 & ("color" %in% colnames(data.TT))){
              selcols <- c("blue", "red", "green", "cyan", "purple", "pink", "orange", "yellow", "navy", "seagreen", "maroon", "burlywood3", "magenta2")
              laycolor <- sample(selcols,length(unique(data.TT$color)))
			  laycolor.export <<- c(laycolor.export,paste(laycolor,collapse="."))
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
		      laycolor.export <<- c(laycolor.export,paste(laycolor,collapse="."))			  
			  data.TT$color <- laycolor
            }			
          }else{
		      laycolor.export <<- c(laycolor.export,NA)
		  }
          ## *** The data color ***
          ## *** Select color ***
		  if(plottype[i] %in% "rect_gradual"){
              selrectcol <- rectcol[i]		  
              rectcolor <- colrect[i]
              if(rectcolor=="blue"){
                  rectcols <<- c("#EDEDFD","#6969F5","#00008B")
              }else if(rectcolor=="red"){
                  rectcols <<- c("#FDEDED","#F56969","#8B0000")
              }else if(rectcolor=="green"){
                  rectcols <<- c("#EDFBED","#69E169","#008B00")
              }else if(rectcolor=="cyan"){
                  rectcols <<- c("#EDFBFB","#69E1E1","#008B8B")
              }else if(rectcolor=="purple"){
                  rectcols <<- c("#F6F0FB","#B27FE1","#551A8B")
              }else if(rectcolor=="pink"){
                  rectcols <<- c("#FBEEF5","#E172AE","#8B1076")
              }else if(rectcolor=="orange"){
                  rectcols <<- c("#FDF5ED","#F5AE69","#8B4500")
              }else if(rectcolor=="yellow"){
                  rectcols <<- c("#FDFDED","#EFEF1A","#8B8B00")
              }else if(rectcolor=="navy"){
                  rectcols <<- c("#EDEDF6","#7272B8","#000080")
              }else if(rectcolor=="seagreen"){
                  rectcols <<- c("#F2FBF6","#4EEE94","#2E8B57")
              }else if(rectcolor=="maroon"){
                  rectcols <<- c("#FFF4FB","#FF69C7","#8B1C62")
              }else if(rectcolor=="olivedrab"){
                  rectcols <<- c("#FBFFF4","#C6FF52","#698B22")
              }else if(rectcolor=="gold"){
                  rectcols <<- c("#FFFCF1","#FFDD28","#8B7500")
              }else if(rectcolor=="lightblue"){
                  rectcols <<- c("#EFF5F7","#AFCDD7","#68838B")
              }else if(rectcolor=="navy.yellow"){
                  rectcols <<- c("#000080","#7B7B41","#FFFF00")
              }else if(rectcolor=="purple.seagreen"){
                  rectcols <<- c("#551A8B","#548994","#54FF9F")
              }else if(rectcolor=="navy.orange"){
                  rectcols <<- c("#000080","#7B5041","#FFA500")
              }else if(rectcolor=="navy.cyan"){
                  rectcols <<- c("#000080","#007BBD","#00FFFF")
              }else if(rectcolor=="blue.red"){
                  rectcols <<- c("#0000FF","#730083","#EE0000")
              }else if(rectcolor=="green.red"){
                  rectcols <<- c("#00EE00","#757800","#EE0000")
              }
          }
		  if(plottype[i] %in% "rect_discrete"){
              selrectcol <- rectcol[i]		  
		      if(selrectcol==1){
                  cols <- c(brewer.pal(11,'Set3'),brewer.pal(9,'Set1')[c(-1,-3,-6)],brewer.pal(8,'Dark2'),"chartreuse","aquamarine","cornflowerblue","blue","cyan","bisque1","darkorchid2","firebrick1","gold1","magenta1","olivedrab1","navy","maroon1","tan","yellow3","black","bisque4","seagreen3","plum2","yellow1","springgreen","slateblue1","lightsteelblue1","lightseagreen","limegreen")
				  if(length(unique(data.TT[,4]))<= length(cols)){
                      selcol <- sample(cols,length(unique(data.TT[,4])))
		              rect_discol.export <<- c(rect_discol.export,paste(selcol,collapse="."))
					  names(selcol) <- unique(data.TT[,4])
			          data.TT$color <- selcol[data.TT[,4]]
				  }else{
				      data.TT$color <- NA
				  }
			  }else if(selrectcol==2){
                  rectcols <- rectcoldis[i] 
                  rectcols <- gsub("\\s","",strsplit(rectcols,",")[[1]])
                  rectcols <- gsub('\\"',"",rectcols)
                  rectcols <- gsub("0x","#", rectcols)
			      if(length(rectcols)==0){
			          rectcols <- NA
			      }
                  data.TT$color <- rectcols
				  data.TT$value <- rectcols
			  }else if(selrectcol==3){
                  rectcols <- rectcoldiscus[i]
                  rectcols <- unlist(strsplit(rectcols,";"))
                  rectcols <- data.frame(id=rectcols,stringsAsFactors=F)
                  rectcols$group <- gsub("\\:.*","",rectcols$id)
                  rectcols$cols <- gsub(".*\\:","",rectcols$id)
                  rectcols$group <- gsub(" ","",rectcols$group)
                  rectcols$cols <- gsub(" ","",rectcols$cols)				  
				  colname <- colnames(data.TT)
                  data.TT <- merge(data.TT,rectcols,by.x=colnames(data.TT)[4],by.y="group",all.x=T)
                  data.TT <- data.TT[c(colname,"cols")]
			      names(data.TT)[ncol(data.TT)] <- "color"
			  }
			  jd_col <- data.TT$color
			  output$errorinfo3 <- renderPrint({
			      if(input[[paste("plottype",i,sep="")]] %in% "rect_discrete" && input[[paste("rectcol",i,sep="")]]!=1){
			          validate(
                          need(all(areColors(jd_col)), paste("Error: Data color error for Data",i,"!"," Please input applicable color name.",sep=""))	 
                      )
				  }
              })
              outputOptions(output, "errorinfo3", suspendWhenHidden = FALSE)
			  data.TT$color[!areColors(data.TT$color)] <- NA			  
		      data.TT$color <- adjustcolor(data.TT$color,alpha.f = coltransparency[i])
              if(!all(is.na(data.TT$color))){
			      rectval_1 <- unique(data.TT$value[!is.na(data.TT$value)])
                  rectcol_1 <- data.TT$color[match(rectval_1,data.TT$value)]
			  }else{
			      rectval_1 <- unique(data.TT$value[!is.na(data.TT$value)])[1]
				  rectcol_1 <- "#FFFFFF00"
			  }
			  rectval_1 <- rectval_1[!duplicated(rectcol_1)]
			  rectcol_1 <- rectcol_1[!duplicated(rectcol_1)]
              data.TT$value <- factor(data.TT$value,levels=rectval_1,ordered = T)
              data.TT$color <- factor(data.TT$color,levels=rectcol_1,ordered = T)
			  rectval_1 <- rectval_1[which(!rectcol_1 %in% "#FFFFFF00")]
			  rectcol_1 <- rectcol_1[!rectcol_1 %in% "#FFFFFF00"]
		  }	  
         ## *** The fill color for track ***
         if(plottype[i] %in% "heatmap_gradual"){
		     if(heatmapcol[i]==1){
                 hmapcols <- gsub('\\"',"",colhmap[i])    
		     }else{
		         hmapcols <- heatmapcols[i]                                         
		     }
             hmapcols <- unlist(strsplit(hmapcols,"\\."))
         }
		 if(plottype[i] %in% "heatmap_discrete"){
    		 selcolhmapdis <- colhmapdis[i]			 
		     if(selcolhmapdis==1){
                 cols <- c(brewer.pal(11,'Set3'),brewer.pal(9,'Set1')[c(-1,-3,-6)],brewer.pal(8,'Dark2'),"chartreuse","aquamarine","cornflowerblue","blue","cyan","bisque1","darkorchid2","firebrick1","gold1","magenta1","olivedrab1","navy","maroon1","tan","yellow3","black","bisque4","seagreen3","plum2","yellow1","springgreen","slateblue1","lightsteelblue1","lightseagreen","limegreen")
				  data.TT$raw_color <- data.TT$color
				  if(length(unique(data.TT$color))<= length(cols)){
                      selcol <- sample(cols,length(unique(data.TT$color)))
		              heatmap_discol.export <<- c(heatmap_discol.export,paste(selcol,collapse="."))
				      names(selcol) <- unique(data.TT$color)
			          data.TT$color <- selcol[data.TT$color]
				  }else{
				      data.TT$color <- NA
				  }
			  }else if(selcolhmapdis==2){
                  hmapcols <- colhmapdiscus[i]				  
                  hmapcols <- unlist(strsplit(hmapcols,";"))
                  hmapcols <- data.frame(id=hmapcols,stringsAsFactors=F)
                  hmapcols$group <- gsub("\\:.*","",hmapcols$id)
                  hmapcols$cols <- gsub(".*\\:","",hmapcols$id)
                  hmapcols$group <- gsub(" ","",hmapcols$group)
                  hmapcols$cols <- gsub(" ","",hmapcols$cols)				  
				  colname <- colnames(data.TT)
                  data.TT <- merge(data.TT,hmapcols,by.x="color",by.y="group",all.x=T)
                  data.TT <- data.TT[c(colname,"cols")]
                  colnames(data.TT)[which(colnames(data.TT) %in% "color")] <- "raw_color"				  
			      names(data.TT)[ncol(data.TT)] <- "color"
			  }
			  jd_col <- data.TT$color
			  output$errorinfo4 <- renderPrint({
			      if(input[[paste("plottype",i,sep="")]] %in% "heatmap_discrete" && input[[paste("colhmapdis",i,sep="")]]!=1){
			          validate(
                          need(all(areColors(jd_col)), paste("Error: Data color error for Data",i,"!"," Please input applicable color name.",sep=""))	 
                      )
				  }
              })
              outputOptions(output, "errorinfo4", suspendWhenHidden = FALSE)
			  data.TT$color[!areColors(data.TT$color)] <- NA			  
		      data.TT$color <- adjustcolor(data.TT$color,alpha.f = coltransparency[i])
              if(!all(is.na(data.TT$color))){
			      hmapval_1 <- unique(data.TT$raw_color[!is.na(data.TT$raw_color)])
                  hmapcol_1 <- data.TT$color[match(hmapval_1,data.TT$raw_color)]
			  }else{
			      hmapval_1 <- unique(data.TT$raw_color[!is.na(data.TT$raw_color)])[1]
				  hmapcol_1 <- "#FFFFFF00"
			  }
			  hmapval_1 <- hmapval_1[!duplicated(hmapcol_1)]
			  hmapcol_1 <- hmapcol_1[!duplicated(hmapcol_1)]	  
              data.TT$raw_color <- factor(data.TT$raw_color,levels=hmapval_1,ordered = T)
              data.TT$color <- factor(data.TT$color,levels=hmapcol_1,ordered = T)
			  hmapval_1 <- hmapval_1[which(!hmapcol_1 %in% "#FFFFFF00")]
			  hmapcol_1 <- hmapcol_1[!hmapcol_1 %in% "#FFFFFF00"]
		 }
         if(plottype[i] %in% c("vertical line","horizontal line")){
		     linecolorp <- linecolor[i]
             linecolorp <- gsub("\\s","",strsplit(linecolorp,",")[[1]])[1]
             linecolorp <- gsub('\\"',"",linecolorp)
             linecolorp <- gsub("0x","#", linecolorp)			 
			 if(length(linecolorp)==0){
		         linecolorp <- NA
	         }			 
			 data.TT$color <- linecolorp
		 }	 
		 ### Transparency of color ***
         if(!plottype[i] %in% c("heatmap_gradual","heatmap_discrete","text","rect_gradual","rect_discrete")){
			 coltransparencyp <- coltransparency[i]
			 if(!"raw_color" %in% names(data.TT)){
			     data.TT$raw_color <- data.TT$color
			 } 
			 data.TT$color[!areColors(data.TT$color)] <- NA
             data.TT$color <- adjustcolor(data.TT$color, alpha.f = coltransparencyp)		 
             if(!plottype[i] %in% "segment"){
			     labelscol <- unique(data.TT$raw_color[!is.na(data.TT$value)])
			 }else{
			     labelscol <- unique(data.TT$raw_color)
			 }
			 if(plottype[i] %in% "vertical line"){
			     labelscol <- unique(data.TT$raw_color)
			 }
             breakscol <- data.TT$color[match(labelscol,data.TT$raw_color)]		 
			 labelscol <- labelscol[!duplicated(breakscol)]
			 breakscol <- breakscol[!duplicated(breakscol)] 
			 data.TT$raw_color <- factor(data.TT$raw_color,levels=labelscol,ordered = T)
             data.TT$color <- factor(data.TT$color,levels=breakscol,ordered = T)
			 labelscol <- labelscol[which(!breakscol %in% "#FFFFFF00")]
			 breakscol <- breakscol[!breakscol %in% "#FFFFFF00"]		 
		 }
		 if(plottype[i] %in% "text"){
			 labelscol <- textcol[i]
		 }
         ## *** Fill area color ***
		 if(plottype[i] %in% "line"){
		     if(fillarea[i]==1){
                 if(selareatype[i]==1){
				     data.TT$areacol <- data.TT$color
				 }else{
				     areacol <- unlist(strsplit(borderarea[i],","))
				     if(length(areacol)==0){
				         areacol <- rep(NA,length(unique(data.TT$color)))
                     }else{
                         areacol <- rep(areacol,length(unique(data.TT$color)))
					     areacol <- areacol[1:length(unique(data.TT$color))]
                     }
					 areacol[!areColors(areacol)] <- NA
					 names(areacol) <- unique(data.TT$color)
					 data.TT$areacol <- adjustcolor(areacol[data.TT$color], alpha.f = coltransparency[i])
				 }			 
			 }
		 }	 
		 ## *** Point type and size ***
		 if(plottype[i] %in% "point"){
		     if(!"shape" %in% names(data.TT)){
				 data.TT$shape <- as.numeric(symbolpoint[i])
			 }
			 if(!"size" %in% names(data.TT)){
			     data.TT$size <- as.numeric(pointsize[i])		 
		     }
			 breakspch <- unique(data.TT$shape[!is.na(data.TT$value)])
			 labelspch <- breakspch
			 breakscex <- unique(data.TT$size[!is.na(data.TT$value)])
			 labelscex <- breakscex	 
		 }
		 output$errorinfo7 <- renderPrint({
             if(input[[paste("plottype",i,sep="")]] %in% "point"){			          
			     validate(
                     need(breakspch>=0 & breakspch<=25, paste("Error: Symbol type error for Data",i,"!"," Please input one applicable integer in [0-25].",sep=""))	 
                 )
			 }
         })
         outputOptions(output, "errorinfo7", suspendWhenHidden = FALSE)
		 ## *** Line type ***
		 if(plottype[i] %in% c("line","segment","vertical line","horizontal line")){
			 linetypep <- linetype[i]
             labelslinetype <- linetypep
		 }
         ## *** Direction of bars ***
         if(plottype[i] %in% "bar"){
			 if(all(data.TT$raw_value < 0)){
		         directbarp <- 2			 
			 }else{
			     directbarp <- 1
			 }
		 }
         ## *** Borders ***
	     addborderp <- addborder[i]
		 if(addborderp==1){
		     bordercolsp <- bordercols[i]
		 }else{
		     bordercolsp <- NA		 
		 }
		 ## *** Legends ***
		 addcollgd <- "none"
		 addsizelgd <- "none"
		 addshapelgd <- "none"
		 addlinetypelgd <- "none"		 
		 if(addlegend[i]==1){
		   if(collgd[i]==1){
		      addcollgd <- "legend"
			  if(collgdmdylabel[i]==1){
                  collgdlabelp <- gsub("\\s","",strsplit(collgdlabel[i],",")[[1]])
                  collgdlabelp <- gsub('\\"',"",collgdlabelp)
			  if(length(collgdlabelp)==0){
			      collgdlabelp <- "NA"
			  }
			  if(!plottype[i] %in% c("heatmap_gradual","heatmap_discrete","text","rect_gradual","rect_discrete")){
			      collgdlabelp <- rep(collgdlabelp,length(breakscol))[1:length(breakscol)]
				  names(collgdlabelp) <- labelscol
	              data.TT$raw_color <- as.character(data.TT$raw_color)
				  data.TT$raw_color <- collgdlabelp[data.TT$raw_color]				  
				  labelscol <- unname(collgdlabelp)
			      data.TT$raw_color <- factor(data.TT$raw_color,levels=unique(labelscol),ordered = T)				  
			  }else if(plottype[i] %in% "rect_discrete"){
			      collgdlabelp <- rep(collgdlabelp,length(rectcol_1))[1:length(rectcol_1)]
				  names(collgdlabelp) <- rectval_1
	              data.TT$value <- as.character(data.TT$value)
				  data.TT$value <- collgdlabelp[data.TT$value]
				  rectval_1 <- unname(collgdlabelp)
			      data.TT$value <- factor(data.TT$value,levels=unique(rectval_1),ordered = T)			  
			  }else if(plottype[i] %in% "heatmap_discrete"){
				  collgdlabelp <- rep(collgdlabelp,length(hmapcol_1))[1:length(hmapcol_1)]
				  names(collgdlabelp) <- hmapval_1
				  hmapval_1 <- unname(collgdlabelp)
			  }else if(plottype[i] %in% "text"){
			      labelscol <- collgdlabelp[1]
			  }		  
			  }
		   }
		   if(sizelgd[i]==1){
		     addsizelgd <- "legend"
			 if(sizelgdmdylabel[i]==1){
                 sizelgdlabelp <- gsub("\\s","",strsplit(sizelgdlabel[i],",")[[1]])
                 sizelgdlabelp <- gsub('\\"',"",sizelgdlabelp)
				 if(length(sizelgdlabelp)==0){
			         sizelgdlabelp <- "NA"
			     }
             labelscex <- rep(sizelgdlabelp,length(breakscex))[1:length(breakscex)]	 
			 }	  
		   }
		   if(shapelgd[i]==1){
		     addshapelgd <- "legend"
			 if(shapelgdmdylabel[i]==1){
                 shapelgdlabelp <- gsub("\\s","",strsplit(shapelgdlabel[i],",")[[1]])
                 shapelgdlabelp <- gsub('\\"',"",shapelgdlabelp)
				 if(length(shapelgdlabelp)==0){
			         shapelgdlabelp <- "NA"
			     }
             labelspch <- rep(shapelgdlabelp,length(breakspch))[1:length(breakspch)]
			 }
		   }
		   if(linetypelgd[i]==1){
		     addlinetypelgd <- "legend"
			 if(linetypelgdmdylabel[i]==1){
                 linetypelgdlabelp <- gsub("\\s","",strsplit(linetypelgdlabel[i],",")[[1]])
                 linetypelgdlabelp <- gsub('\\"',"",linetypelgdlabelp)
				 if(length(linetypelgdlabelp)==0){
			         linetypelgdlabelp <- "NA"
			     }
             labelslinetype <- rep(linetypelgdlabelp,length(linetypep))[1:length(linetypep)]
			 }
		   }
		 }
         ## *** Legend of fill area ***
		if(plottype[i] %in% "line" & fillarea[i]==1 & addlegend[i]==1 & addcollgd %in% "legend"){
            data.TT$raw_areacol <- as.character(data.TT$raw_color)                      
			raw_areacol_1 <- unique(data.TT$raw_areacol[!is.na(data.TT$value)])
            areacol_1 <- data.TT$areacol[match(raw_areacol_1,data.TT$raw_areacol)]
            raw_areacol_1 <- raw_areacol_1[!duplicated(areacol_1)]
			areacol_1 <- areacol_1[!duplicated(areacol_1)]
			data.TT$areacol <- factor(data.TT$areacol,levels=areacol_1,ordered = T)
			data.TT$raw_areacol <- factor(data.TT$raw_areacol,levels=raw_areacol_1,ordered = T)
		 }
		 ## *** Number of chromosomes
		 data.TTP <- data.TT
		 data.TTP$layer <- layerindex[i]
		 data.TTP <- merge(data.TTP, rg, by.x="layer", by.y="num", all.x=T)
		 if(!plottype[i] %in% c("rect_gradual","rect_discrete","heatmap_gradual","heatmap_discrete","vertical line")){
			min_val <- val_range$min_val[val_range$layer==layerindex[i]]
			max_val <- val_range$max_val[val_range$layer==layerindex[i]]
			if(min_val >0 & plottype[i] %in% "horizontal line" & length(which(layerindex==layerindex[i]))==1){
			   fold_1 <- abs(as.numeric(heightlayer[names(heightlayer) == layerindex[i]])/(1.02*max_val))
            }else{
			if(max_val!=min_val){
			    fold_1 <- abs(as.numeric(heightlayer[names(heightlayer) == layerindex[i]])/(1.02*(max_val-min_val)))						
			}else if(max_val==min_val & max_val==0){
			    fold_1 <- abs(as.numeric(heightlayer[names(heightlayer) == layerindex[i]])/1.02)
			}else if(max_val==min_val & max_val!=0){
                fold_1 <- abs(as.numeric(heightlayer[names(heightlayer) == layerindex[i]])/(1.02*max_val))
			}
			}			
			if(min_val < 0){
                minnum_1 <- unique(abs(min_val)*fold_1+data.TTP$ystart)			   
            }else{			
			    minnum_1 <- unique(data.TTP$ystart)
			}
			minnum_p <- minnum_1			
            if(plottype[i] %in% "segment"){
			    if(min_val < 0){			
			        data.TTP$ypos1 <- data.TTP$ypos1 + abs(min_val)
			        data.TTP$ypos2 <- data.TTP$ypos2 + abs(min_val)					
			    }			
                data.TTP$ypos1 <- data.TTP$ypos1*fold_1+data.TTP$ystart
                data.TTP$ypos2 <- data.TTP$ypos2*fold_1+data.TTP$ystart			
			}else{
			    if(min_val < 0){			
			        data.TTP$value <- data.TTP$value + abs(min_val)		
			    }			
                data.TTP$yvalue <- data.TTP$value*fold_1+data.TTP$ystart		    
			}
		 }
		 if(plottype[i] %in% "heatmap_gradual"){
			fold_2 <- as.numeric(heightlayer[names(heightlayer) == layerindex[i]])/max(data.TTP$value,na.rm = T)
			data.TTP$yvalue <- fold_2*data.TTP$value-fold_2/2+data.TTP$ystart[1]
		 }
		 if(plottype[i] %in% "heatmap_discrete"){
			fold_2 <- as.numeric(heightlayer[names(heightlayer) == layerindex[i]])/max(as.numeric(as.character(data.TTP$value)),na.rm = T)			
		    data.TTP$yvalue1 <- fold_2*as.numeric(as.character(data.TTP$value))-fold_2+data.TTP$ystart[1]
			data.TTP$yvalue2 <- fold_2*as.numeric(as.character(data.TTP$value))+data.TTP$ystart[1]
		 }	 
		 chr.len <- data.C$chrsize
         names(chr.len) <- data.C$chr
         chr.cum.len <- c(0, cumsum(chr.len)[-length(chr.len)])
         names(chr.cum.len) <- names(chr.len)
	  	 data.TTP$chr <- factor(data.TTP$chr,levels = names(chr.cum.len),ordered=T)
		 if(plottype[i] %in% c("point","line","vertical line")){
            data.TTP$pos <- data.TTP$pos + chr.cum.len[data.TTP$chr]
		 }else if(plottype[i] %in% "bar"){
            data.TTP$xmin <- data.TTP$xmin + chr.cum.len[data.TTP$chr]
            data.TTP$xmax <- data.TTP$xmax + chr.cum.len[data.TTP$chr]			
		 }else if(plottype[i] %in% c("rect_gradual","rect_discrete")){
            data.TTP$xmin <- data.TTP$xmin + chr.cum.len[data.TTP$chr]
            data.TTP$xmax <- data.TTP$xmax + chr.cum.len[data.TTP$chr]			
		 }else if(plottype[i] %in% c("heatmap_gradual", "heatmap_discrete")){
            data.TTP$xmin <- data.TTP$xmin + chr.cum.len[data.TTP$chr]
            data.TTP$xmax <- data.TTP$xmax + chr.cum.len[data.TTP$chr]
			data.TTP$xpos <- (data.TTP$xmin+data.TTP$xmax)/2
            data.TTP$width <- (data.TTP$xmax-data.TTP$xpos)*2
		 }else if(plottype[i] %in% "horizontal line"){
		    data.TTP$xmax <- data.TTP$xmax + chr.cum.len[data.TTP$chr]
			data.TTP <- data.TTP[c("chr","xmin","xmax","yvalue","color")]
			data.TTP <- data.TTP[which(data.TTP$xmax == max(data.TTP$xmax,na.rm = T)),]
		 }else if(plottype[i] %in% "text"){
		    data.TTP$pos <- data.TTP$pos + chr.cum.len[data.TTP$chr]
		 }else if(plottype[i] %in% "segment"){
            data.TTP$xpos1 <- data.TTP$xpos1 + chr.cum.len[data.TTP$chr]
            data.TTP$xpos2 <- data.TTP$xpos2 + chr.cum.len[data.TTP$chr]
		 }
         data.TTP$chr <- as.character(data.TTP$chr)
		 if(chrplotype==1){
		     data.TT <- data.TTP
		 }else if(chrplotype==2){
		 data.TT$layer <- layerindex[i]
		 data.TT <- merge(data.TT, rg, by.x="layer", by.y="num", all.x=T)
		 if(!plottype[i] %in% c("rect_gradual","rect_discrete","heatmap_gradual","heatmap_discrete","vertical line")){				 
			 if(max_val!=min_val){
			     fold_5 <- abs(as.numeric(heightlayer[names(heightlayer) == layerindex[i]])/(1.02*(max_val-min_val)))
			 }else if(max_val==min_val & max_val==0){
			     fold_5 <- abs(as.numeric(heightlayer[names(heightlayer) == layerindex[i]])/1.02)
			 }else if(max_val==min_val & max_val!=0){
                 fold_5 <- abs(as.numeric(heightlayer[names(heightlayer) == layerindex[i]])/(1.02*max_val))
			 }
			 if(min_val < 0){
                 minnum_2 <- unique(abs(min_val)*fold_5 + data.TT$ystart)			   
			 }else{
				 minnum_2 <- unique(data.TT$ystart)
			 }
			 if(plottype[i] %in% "segment"){
			     if(min_val < 0){
 			         data.TT$ypos1 <- data.TT$ypos1 + abs(min_val)
 			         data.TT$ypos2 <- data.TT$ypos2 + abs(min_val)					 
			     }
			     data.TT$ypos1 <- data.TT$ypos1*fold_5 + data.TT$ystart
			     data.TT$ypos2 <- data.TT$ypos2*fold_5 + data.TT$ystart				 
			 }else{
			     if(min_val < 0){
 			         data.TT$value <- data.TT$value + abs(min_val)
			     }
			     data.TT$yvalue <- data.TT$value*fold_5 + data.TT$ystart
		     }
			 minnum_p <- minnum_2
		 }
		 if(plottype[i] %in% "heatmap_gradual"){
			fold_2 <- as.numeric(heightlayer[names(heightlayer) == layerindex[i]])/max(data.TT$value,na.rm = T)			
		    data.TT$yvalue <- fold_2*data.TT$value-fold_2/2+data.TT$ystart[1]
		 }		 
		 if(plottype[i] %in% "heatmap_discrete"){
			fold_2 <- as.numeric(heightlayer[names(heightlayer) == layerindex[i]])/max(as.numeric(as.character(data.TT$value)),na.rm = T)			
		    data.TT$yvalue1 <- fold_2*as.numeric(as.character(data.TT$value))-fold_2+data.TT$ystart[1]
			data.TT$yvalue2 <- fold_2*as.numeric(as.character(data.TT$value))+data.TT$ystart[1]
		 }
		 if(plottype[i] %in% c("heatmap_gradual","heatmap_discrete")){
			data.TT$xpos <- (data.TT$xmin+data.TT$xmax)/2
            data.TT$width <- (data.TT$xmax-data.TT$xpos)*2
		 }
	     }
	     data.TT$chr.f <- factor(data.TT$chr,levels=chr_order,ordered=T)
		 if(plottype[i] %in% "point"){
		     if(addlegend[i]==1 & any(c(addcollgd,addsizelgd,addshapelgd) %in% "legend")){
			     if(is.numeric(labelscex)){
			         labelscex <- sprintf("%.1f",sort(labelscex))
			     }
			     if(legendpos==1){
		             lg1 <- ggplot() + geom_point(data=data.TTP, aes(pos, yvalue, color=color, shape=as.character(shape), size=size)) + scale_color_identity(name=collgdname[i],guide = addcollgd,breaks=breakscol,labels=labelscol) + scale_size_identity(name=sizelgdname[i],guide = addsizelgd,breaks=sort(breakscex),labels=labelscex) + scale_shape_manual(name=shapelgdname[i],guide = addshapelgd,values=sort(breakspch),labels=sort(labelspch)) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA)) + guides(color = guide_legend(order = 1), size = guide_legend(order = 2))
			     }else{
		             lg1 <- ggplot() + geom_point(data=data.TTP, aes(pos, yvalue, color=color, shape=as.character(shape), size=size)) + scale_color_identity(name=collgdname[i],guide = addcollgd,breaks=breakscol,labels=labelscol) + scale_size_identity(name=sizelgdname[i],guide = addsizelgd,breaks=sort(breakscex),labels=labelscex) + scale_shape_manual(name=shapelgdname[i],guide = addshapelgd,values=sort(breakspch),labels=sort(labelspch)) + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA)) + guides(color = guide_legend(order = 1), size = guide_legend(order = 2))			 
			     }
			     assign(paste("legend",i,sep=""),g_legend(lg1))
			 }else{
			     assign(paste("legend",i,sep=""),NA)
			 }
			 for(f in unique(data.TT$chr)){
                 dat <- data.TT[data.TT$chr %in% f,]
		         p1 <- p1 + geom_point(data=dat, aes(pos,yvalue),color=as.character(dat$color), shape=dat$shape, size=as.numeric(dat$size))
			 }
	     }
		 if(plottype[i] %in% "line"){
		     if(length(unique(data.TTP$color))>1){
			     linetypep <- "solid"
			 }
		     if(fillarea[i]==2){
                 if(addlegend[i]==1 & addcollgd %in% "legend"){
                     if(legendpos==1){				 
		                 lg1 <- ggplot() + geom_line(data=data.TTP, aes(pos, yvalue, color=color), size=linesize[i], linetype=linetypep) + scale_color_identity(name=collgdname[i],guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
					 }else{
		                 lg1 <- ggplot() + geom_line(data=data.TTP, aes(pos, yvalue, color=color), size=linesize[i], linetype=linetypep) + scale_color_identity(name=collgdname[i],guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))					 
					 }
				     assign(paste("legend",i,sep=""),g_legend(lg1))
				 }else{
			         assign(paste("legend",i,sep=""),NA)
			     }
			 	 for(f in unique(data.TT$chr)){
				     for(j in unique(data.TT$color[data.TT$chr %in% f])){
                         dat <- data.TT[data.TT$chr %in% f & data.TT$color %in% j,]				 
                         p1 <- p1 + geom_line(data=dat, aes(pos,yvalue), color=as.character(dat$color), size=linesize[i], linetype=linetypep)
					 }
				 }				 
			 }else{
			 	 if(addlegend[i]==1 & addcollgd %in% "legend"){
                     if(legendpos==1){		                 
						 lg1 <- ggplot() + geom_line(data=data.TTP, aes(pos,yvalue), color=as.character(data.TTP$color), size=linesize[i], linetype=linetypep) + geom_area(data=data.TTP,aes(x=pos,y=yvalue,fill=areacol)) + scale_fill_identity(name=collgdname[i],guide = addcollgd,breaks=areacol_1,labels=raw_areacol_1) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
					 }else{					 
		                 lg1 <- ggplot() + geom_line(data=data.TTP, aes(pos,yvalue), color=as.character(data.TTP$color), size=linesize[i], linetype=linetypep) + geom_area(data=data.TTP,aes(x=pos,y=yvalue,fill=areacol)) + scale_fill_identity(name=collgdname[i],guide = addcollgd,breaks=areacol_1,labels=raw_areacol_1) + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))					 
					 }
				     assign(paste("legend",i,sep=""),g_legend(lg1))
				 }else{
			         assign(paste("legend",i,sep=""),NA)
			     }				 
			 	 for(f in unique(data.TT$chr)){
				     for(j in unique(data.TT$color[data.TT$chr %in% f])){
                         dat <- data.TT[data.TT$chr %in% f & data.TT$color %in% j,]
                         p1 <- p1 + geom_line(data=dat, aes(pos,yvalue), color=as.character(j), size=linesize[i], linetype=linetypep) + geom_ribbon(data=dat,aes(x=pos),ymin=pmin(dat$yvalue,minnum_p),fill=unique(as.character(dat$areacol)),ymax=minnum_p) + geom_ribbon(data=dat,aes(x=pos),ymax=pmax(dat$yvalue,minnum_p),fill=unique(as.character(dat$areacol)),ymin=minnum_p)
					 }
				 }
			 }
		 }
		 if(plottype[i] %in% "bar"){
			if(max(data.T[[i]][,4], na.rm = T)<=0 | min(data.T[[i]][,4], na.rm = T)>=0){
			    if(directbarp==1){
				    if(length(which(layerindex==layerindex[i]))>1){
						if(addlegend[i]==1 & addcollgd %in% "legend"){
                            if(legendpos==1){						
                                lg1 <- ggplot() + geom_rect(data=data.TTP, aes(xmin=xmin, xmax=xmax, ymax=yvalue, fill=color), ymin=data.TTP$ystart+minnum_1, color=bordercolsp) + scale_fill_identity(name=collgdname[i],guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
							}else{
                                lg1 <- ggplot() + geom_rect(data=data.TTP, aes(xmin=xmin, xmax=xmax, ymax=yvalue, fill=color), ymin=data.TTP$ystart+minnum_1, color=bordercolsp) + scale_fill_identity(name=collgdname[i],guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))							
							}
				            assign(paste("legend",i,sep=""),g_legend(lg1))
						}else{
			                assign(paste("legend",i,sep=""),NA)
			            }
			 	        for(f in unique(data.TT$chr)){
				            for(j in unique(data.TT$color[data.TT$chr %in% f])){
                                dat <- data.TT[data.TT$chr %in% f & data.TT$color %in% j,]						
                                p1 <- p1 + geom_rect(data=dat, aes(xmin=xmin, xmax=xmax, ymax=yvalue), ymin=dat$ystart[1]+minnum_p, fill=as.character(dat$color), color=bordercolsp)
						    }
					    }
					}else{
		                if(addlegend[i]==1 & addcollgd %in% "legend"){
                            if(legendpos==1){						
                                lg1 <- ggplot() + geom_rect(data=data.TTP, aes(xmin=xmin, xmax=xmax, ymin=ystart, ymax=yvalue, fill=color), color=bordercolsp) + scale_fill_identity(name=collgdname[i],guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
							}else{
                                lg1 <- ggplot() + geom_rect(data=data.TTP, aes(xmin=xmin, xmax=xmax, ymin=ystart, ymax=yvalue, fill=color), color=bordercolsp) + scale_fill_identity(name=collgdname[i],guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))							
							}
				            assign(paste("legend",i,sep=""),g_legend(lg1))
						}else{
			                assign(paste("legend",i,sep=""),NA)
			            }
			 	        for(f in unique(data.TT$chr)){
				            for(j in unique(data.TT$color[data.TT$chr %in% f])){
                                dat <- data.TT[data.TT$chr %in% f & data.TT$color %in% j,]							
						        p1 <- p1 + geom_rect(data=dat, aes(xmin=xmin, xmax=xmax, ymin=ystart, ymax=yvalue), fill=as.character(dat$color), color=bordercolsp)
						    }
						}
					}
			    }else if(directbarp==2){
				    if(addlegend[i]==1 & addcollgd %in% "legend"){
                        if(legendpos==1){					
                            lg1 <- ggplot() + geom_rect(data=data.TTP, aes(xmin=xmin, xmax=xmax, ymax=yvalue, fill=color), ymin=minnum_1, color=bordercolsp) + scale_fill_identity(name=collgdname[i],guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
						}else{
                            lg1 <- ggplot() + geom_rect(data=data.TTP, aes(xmin=xmin, xmax=xmax, ymax=yvalue, fill=color), ymin=minnum_1, color=bordercolsp) + scale_fill_identity(name=collgdname[i],guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))						
						}
				        assign(paste("legend",i,sep=""),g_legend(lg1))
					}else{
			            assign(paste("legend",i,sep=""),NA)
			        }
			 	    for(f in unique(data.TT$chr)){
				        for(j in unique(data.TT$color[data.TT$chr %in% f])){
                            dat <- data.TT[data.TT$chr %in% f & data.TT$color %in% j,]						
                            p1 <- p1 + geom_rect(data=dat, aes(xmin=xmin, xmax=xmax, ymax=yvalue), ymin=minnum_p, fill=as.character(dat$color), color=bordercolsp)
					    }
					}
				}
			}else{
			    if(min_val < 0){
					if(addlegend[i]==1 & addcollgd %in% "legend"){
                        if(legendpos==1){					
                            lg1 <- ggplot() + geom_rect(data=data.TTP, aes(xmin=xmin, xmax=xmax, ymax=yvalue, fill=color), ymin=minnum_1, color=bordercolsp) + scale_fill_identity(name=collgdname[i],guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
						}else{
                            lg1 <- ggplot() + geom_rect(data=data.TTP, aes(xmin=xmin, xmax=xmax, ymax=yvalue, fill=color), ymin=minnum_1, color=bordercolsp) + scale_fill_identity(name=collgdname[i],guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))						
						}
				        assign(paste("legend",i,sep=""),g_legend(lg1))
					}else{
			            assign(paste("legend",i,sep=""),NA)
			        }
			 	    for(f in unique(data.TT$chr)){
				        for(j in unique(data.TT$color[data.TT$chr %in% f])){
                            dat <- data.TT[data.TT$chr %in% f & data.TT$color %in% j,]						
                            p1 <- p1 + geom_rect(data=dat, aes(xmin=xmin, xmax=xmax, ymax=yvalue), ymin=minnum_p, fill=as.character(dat$color), color=bordercolsp)
					    }
					}
			    }else{
					if(addlegend[i]==1 & addcollgd %in% "legend"){
                        if(legendpos==1){					
                            lg1 <- ggplot() + geom_rect(data=data.TTP, aes(xmin=xmin, xmax=xmax, ymin=ystart, ymax=yvalue, fill=color), color=bordercolsp) + scale_fill_identity(name=collgdname[i],guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
						}else{
                            lg1 <- ggplot() + geom_rect(data=data.TTP, aes(xmin=xmin, xmax=xmax, ymin=ystart, ymax=yvalue, fill=color), color=bordercolsp) + scale_fill_identity(name=collgdname[i],guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))						
						}
				        assign(paste("legend",i,sep=""),g_legend(lg1))
					}else{
			            assign(paste("legend",i,sep=""),NA)
			        }
			 	    for(f in unique(data.TT$chr)){
				        for(j in unique(data.TT$color[data.TT$chr %in% f])){
                            dat <- data.TT[data.TT$chr %in% f & data.TT$color %in% j,]						
                            p1 <- p1 + geom_rect(data=dat, aes(xmin=xmin, xmax=xmax, ymin=ystart, ymax=yvalue), fill=as.character(dat$color), color=bordercolsp)
					    }
					}
			    }
			}		 
		 }
		 if(plottype[i] %in% "rect_gradual"){
			 if(is.numeric(data.TTP$value)){
		         midpoint <- mean(data.TTP$value,na.rm = T)
                 if(legendpos==1){				 
			         lg1 <- ggplot() + geom_rect(data=data.TTP, aes(xmin=xmin, xmax=xmax, ymin=ystart, ymax=yend, fill=value), color=bordercolsp)+ scale_fill_gradient2(name=collgdname[i],low = rectcols[1],midpoint=midpoint,mid=rectcols[2],high=rectcols[3],na.value="#FFFFFF00") + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
				 }else{
			         lg1 <- ggplot() + geom_rect(data=data.TTP, aes(xmin=xmin, xmax=xmax, ymin=ystart, ymax=yend, fill=value), color=bordercolsp)+ scale_fill_gradient2(name=collgdname[i],low = rectcols[1],midpoint=midpoint,mid=rectcols[2],high=rectcols[3],na.value="#FFFFFF00") + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA)) + guides(fill = guide_colourbar(title.vjust = 0.75, title.hjust = 1.2))
				 }
                 g1 <- ggplot_build(lg1)
                 data.TT$fillcol <- g1$data[[1]][,"fill"]
				 if(addlegend[i]==1 & addcollgd %in% "legend"){				 
				     assign(paste("legend",i,sep=""),g_legend(lg1))
				 }else{
			         assign(paste("legend",i,sep=""),NA)				 
				 }				 
			     p1 <- p1 + geom_rect(data=data.TT, aes(xmin=xmin, xmax=xmax, ymin=ystart, ymax=yend), fill=as.character(data.TT$fillcol), color=bordercolsp)		 
				 }else{
			         assign(paste("legend",i,sep=""),NA)		 
				 }
		 }
		 if(plottype[i] %in% "rect_discrete"){
             if(legendpos==1){
		         lg1 <- ggplot() + geom_rect(data=data.TTP, aes(xmin=xmin, xmax=xmax, ymin=ystart, ymax=yend, fill=color), color=bordercolsp) + scale_fill_identity(name=collgdname[i],guide = addcollgd,breaks=rectcol_1,labels=rectval_1) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))				 
			 }else{
			     lg1 <- ggplot() + geom_rect(data=data.TTP, aes(xmin=xmin, xmax=xmax, ymin=ystart, ymax=yend, fill=color), color=bordercolsp) + scale_fill_identity(name=collgdname[i],guide = addcollgd,breaks=rectcol_1,labels=rectval_1) + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
			 }
			 if(addlegend[i]==1 & addcollgd %in% "legend"){				 
			     assign(paste("legend",i,sep=""),g_legend(lg1))
			 }else{
			     assign(paste("legend",i,sep=""),NA)				 
			 }
             for(f in unique(data.TT$chr)){
			     dat <- data.TT[data.TT$chr %in% f,]
			     p1 <- p1 + geom_rect(data=dat, aes(xmin=xmin, xmax=xmax, ymin=ystart, ymax=yend), fill=as.character(dat$color), color=bordercolsp)
             }
		 }	 
		 if(plottype[i] %in% "heatmap_gradual"){
		    midpoint <- mean(data.TTP$color,na.rm = T)
            if(legendpos==1){			
			    lg1 <- ggplot() + geom_tile(data=data.TTP, aes(x=xpos, y=yvalue, fill=color), width=data.TTP$width, height=as.numeric(heightlayer[names(heightlayer) == layerindex[i]]), color=bordercolsp) + scale_fill_gradient2(name=collgdname[i],low = hmapcols[1],midpoint=midpoint,mid=hmapcols[2],high=hmapcols[3],na.value="#FFFFFF00") + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
			}else{
			    lg1 <- ggplot() + geom_tile(data=data.TTP, aes(x=xpos, y=yvalue, fill=color), width=data.TTP$width, height=as.numeric(heightlayer[names(heightlayer) == layerindex[i]]), color=bordercolsp) + scale_fill_gradient2(name=collgdname[i],low = hmapcols[1],midpoint=midpoint,mid=hmapcols[2],high=hmapcols[3],na.value="#FFFFFF00") + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA)) + guides(fill = guide_colourbar(title.vjust = 0.75, title.hjust = 1.2))
			}
            g1 <- ggplot_build(lg1)
            data.TT$fillcol <- g1$data[[1]][,"fill"]
			if(addlegend[i]==1 & addcollgd %in% "legend"){				 
			    assign(paste("legend",i,sep=""),g_legend(lg1))
			}else{
			    assign(paste("legend",i,sep=""),NA)				 
			}
            for(f in unique(data.TT$chr)){
			    dat <- data.TT[data.TT$chr %in% f,]
			    p1 <- p1 + geom_tile(data=dat, aes(x=xpos, y=yvalue), width=dat$width, height=fold_2, fill=dat$fillcol, color=bordercolsp)			
            }
		 }
		 if(plottype[i] %in% "heatmap_discrete"){
             if(legendpos==1){
		         lg1 <- ggplot() + geom_rect(data=data.TTP, aes(xmin=xmin, xmax=xmax, ymin=ystart, ymax=yend, fill=color), color=bordercolsp) + scale_fill_identity(name=collgdname[i],guide = addcollgd,breaks=hmapcol_1,labels=hmapval_1) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))				 
			 }else{
			     lg1 <- ggplot() + geom_rect(data=data.TTP, aes(xmin=xmin, xmax=xmax, ymin=ystart, ymax=yend, fill=color), color=bordercolsp) + scale_fill_identity(name=collgdname[i],guide = addcollgd,breaks=hmapcol_1,labels=hmapval_1) + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
			 }
			 if(addlegend[i]==1 & addcollgd %in% "legend"){				 
			     assign(paste("legend",i,sep=""),g_legend(lg1))
			 }else{
			     assign(paste("legend",i,sep=""),NA)				 
			 }
             for(f in unique(data.TT$chr)){
			     dat <- data.TT[data.TT$chr %in% f,]
			     p1 <- p1 + geom_rect(data=dat, aes(xmin=xmin, xmax=xmax, ymin=yvalue1, ymax=yvalue2), fill=as.character(dat$color), color=bordercolsp)
             }
		 }
		 if(plottype[i] %in% "vertical line"){
		    if(addlegend[i]==1 & any(c(addcollgd,addlinetypelgd) %in% "legend")){
                if(legendpos==1){			
		            lg1 <- ggplot() + geom_segment(data=data.TTP, aes(x = pos, y = ystart, xend = pos, yend = yend, color=color, linetype=linetypep), size=linesize[i]) + scale_color_identity(name=collgdname[i], guide=addcollgd,breaks=breakscol,labels=labelscol) + scale_linetype_identity(name=linetypelgdname[i], guide=addlinetypelgd,breaks=as.character(linetypep),labels=labelslinetype) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA)) + guides(color = guide_legend(order = 1), linetype = guide_legend(order = 2))
				}else{
		            lg1 <- ggplot() + geom_segment(data=data.TTP, aes(x = pos, y = ystart, xend = pos, yend = yend, color=color, linetype=linetypep), size=linesize[i]) + scale_color_identity(name=collgdname[i], guide=addcollgd,breaks=breakscol,labels=labelscol) + scale_linetype_identity(name=linetypelgdname[i], guide=addlinetypelgd,breaks=as.character(linetypep),labels=labelslinetype) + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA)) + guides(color = guide_legend(order = 1), linetype = guide_legend(order = 2))
				}
			    assign(paste("legend",i,sep=""),g_legend(lg1))
			}else{
			    assign(paste("legend",i,sep=""),NA)
			}			
		    p1 <- p1 + geom_segment(data=data.TT, aes(x = pos, y = ystart, xend = pos, yend = yend), color=as.character(data.TT$color), size=linesize[i], linetype=linetypep)			
		 }
		 if(plottype[i] %in% "horizontal line"){
		 	if(addlegend[i]==1 & any(c(addcollgd,addlinetypelgd) %in% "legend")){
                if(legendpos==1){			
		            lg1 <- ggplot() + geom_segment(data=data.TTP, aes(x = xmin, y = yvalue, xend = xmax, yend = yvalue, color=color, linetype=linetypep), size=linesize[i]) + scale_color_identity(name=collgdname[i], guide=addcollgd,breaks=breakscol,labels=labelscol) + scale_linetype_identity(name=linetypelgdname[i], guide=addlinetypelgd,breaks=as.character(linetypep),labels=labelslinetype) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA)) + guides(color = guide_legend(order = 1), linetype = guide_legend(order = 2))
				}else{
		            lg1 <- ggplot() + geom_segment(data=data.TTP, aes(x = xmin, y = yvalue, xend = xmax, yend = yvalue, color=color, linetype=linetypep), size=linesize[i]) + scale_color_identity(name=collgdname[i], guide=addcollgd,breaks=breakscol,labels=labelscol) + scale_linetype_identity(name=linetypelgdname[i], guide=addlinetypelgd,breaks=as.character(linetypep),labels=labelslinetype) + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA)) + guides(color = guide_legend(order = 1), linetype = guide_legend(order = 2))		
				}
			    assign(paste("legend",i,sep=""),g_legend(lg1))
			}else{
			    assign(paste("legend",i,sep=""),NA)
			}			
		    p1 <- p1 + geom_segment(data=data.TT, aes(x = xmin, y = yvalue, xend = xmax, yend = yvalue), color=as.character(data.TT$color), size=linesize[i], linetype=linetypep)			
		 }
		 if(plottype[i] %in% "text"){
		 	if(addlegend[i]==1 & addcollgd %in% "legend"){
			    data.TTP$color <- textcol[i]
                if(legendpos==1){                
				    lg1 <- ggplot() + geom_text(data=data.TTP, aes(x=pos, y=yvalue, label=symbol, color=color), size=textsize[i], hjust=0, angle=textangle[i], fontface=fontface[i]) + scale_color_identity(name=collgdname[i], guide=addcollgd, breaks=textcol[i],labels=labelscol) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
				}else{
				    lg1 <- ggplot() + geom_text(data=data.TTP, aes(x=pos, y=yvalue, label=symbol, color=color), size=textsize[i], hjust=0, angle=textangle[i], fontface=fontface[i]) + scale_color_identity(name=collgdname[i], guide=addcollgd, breaks=textcol[i],labels=labelscol) + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA)) 				
				}
			    assign(paste("legend",i,sep=""),g_legend(lg1))
			}else{
			    assign(paste("legend",i,sep=""),NA)
			}
			p1 <- p1 + geom_text(data=data.TT, aes(x=pos, y=yvalue, label=symbol), color=textcol[i], size=textsize[i], hjust=0, angle=textangle[i], fontface=fontface[i])
		 }
		 if(plottype[i] %in% "segment"){
		     if(length(unique(data.TTP$color))>1){
			     linetypep <- "solid"
			 }
         if(addlegend[i]==1 & addcollgd %in% "legend"){
             if(legendpos==1){
		         lg1 <- ggplot() + geom_segment(data=data.TTP, aes(x=xpos1, y=ypos1, xend=xpos2, yend=ypos2, color=color), size=linesize[i], linetype=linetypep) + scale_color_identity(name=collgdname[i],guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
			 }else{       
				 lg1 <- ggplot() + geom_segment(data=data.TTP, aes(x=xpos1, y=ypos1, xend=xpos2, yend=ypos2, color=color), size=linesize[i], linetype=linetypep) + scale_color_identity(name=collgdname[i],guide = addcollgd,breaks=breakscol,labels=labelscol) + theme(legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA))
			 }
			 assign(paste("legend",i,sep=""),g_legend(lg1))
		 }else{
		     assign(paste("legend",i,sep=""),NA)
		 }
		 for(f in unique(data.TT$chr)){
		     for(j in unique(data.TT$color[data.TT$chr %in% f])){
                 dat <- data.TT[data.TT$chr %in% f & data.TT$color %in% j,]
                 if(addarrow[i]==1){
				     if(arrowpos[i]==1){
                         p1 <- p1 + geom_segment(data=dat, aes(x=xpos1, y=ypos1, xend=xpos2, yend=ypos2), color=as.character(dat$color), size=linesize[i], linetype=linetypep, arrow = arrow(length = unit(arrowsize[i], "inches")))				 
				     }else{
                         p1 <- p1 + geom_segment(data=dat, aes(x=xpos2, y=ypos2, xend=xpos1, yend=ypos1), color=as.character(dat$color), size=linesize[i], linetype=linetypep, arrow = arrow(length = unit(arrowsize[i], "inches")))				 
				     }
                 }else{        
                     p1 <- p1 + geom_segment(data=dat, aes(x=xpos1, y=ypos1, xend=xpos2, yend=ypos2), color=as.character(dat$color), size=linesize[i], linetype=linetypep)
				 }				 
			 }
		 }
		 }
	  if(plottype[i] %in% c("point","line","bar")){
		  if(ylabel[i]==1){
              yaxis_breaks <- c(yaxis_breaks,list(c(layerindex[i],range(data.TT$yvalue))))
		      yaxis_labels <- c(yaxis_labels,list(c(layerindex[i],round(range(data.TT$raw_value),2))))
		  }
		  if(xrugs[i]==1){
		      if(plottype[i] %in% "bar"){
			      data.TT$pos <- (data.TT$xmin + data.TT$xmax)/2
			  }
			  p1 <- p1 + geom_rug(data=data.TT, x=data.TT$pos, color=xrugscol[i])
		  }
		  if(yrugs[i]==1){
		      p1 <- p1 + geom_rug(data=data.TT, y=data.TT$yvalue, color=yrugscol[i])				  
		  }
	  }
	  output$errorinfo9 <- renderPrint({
          if(input[[paste("plottype",i,sep="")]] %in% c("point","line","bar") && input[[paste("xrugs",i,sep="")]]==1){	  		          
		      validate(
                  need(all(areColors(xrugscol[i])), paste("Error: Incorrect color for y-axis rugs of ",i,"!"," Please input applicable color name.",sep=""))
              )
		  }
          if(input[[paste("plottype",i,sep="")]] %in% c("point","line","bar") && input[[paste("yrugs",i,sep="")]]==1){	  		          
		      validate(
                  need(all(areColors(yrugscol[i])), paste("Error: Incorrect color for y-axis rugs of ",i,"!"," Please input applicable color name.",sep=""))
              )
	      }			 
      })
      outputOptions(output, "errorinfo9", suspendWhenHidden = FALSE)		  
	  }
	  ## *** Plot theme ***
      if(themestyle %in% "theme1"){
	      p1 <- p1 + theme_bw()
	  }else if(themestyle %in% "theme2"){
		  p1 <- p1 + theme_classic()
	  }else if(themestyle %in% "theme3"){
		  p1 <- p1 + theme_minimal()
      }else if(themestyle %in% "theme4"){
		  p1 <- p1 + theme_few()
	  }else if(themestyle %in% "theme5"){
		  p1 <- p1+ theme_grey()
	  }else if(themestyle %in% "theme6"){
		  p1 <- p1 + theme_tufte()
	  }else if(themestyle %in% "theme7"){
		  p1 <- p1 + theme_calc()
      }else if(themestyle %in% "theme8"){
		  p1 <- p1 + theme_void()
	  }else if(themestyle %in% "theme9"){
		  p1 <- p1 + theme_base()
	  }else if(themestyle %in% "theme10"){
		  p1 <- p1 + theme_linedraw()
      }
	  ## *** axis label***
      if(chrplotype==1 & xlabel==1){
          x_text <- data.C 
		  x_text$pos <- (x_text$chrstart+x_text$chrsize)/2
	  	  x_text$chr <- factor(x_text$chr,levels = names(chr.cum.len),ordered=T)	  
		  x_text$pos <- x_text$pos + chr.cum.len[x_text$chr]
		  x_text$chr <- as.character(x_text$chr)
	      p1 <- p1 + scale_x_continuous(breaks=x_text$pos,labels=x_text$chr)
	  }else if(xlabel==2){
	      if(plotdirection==1){
	          p1 <- p1 + theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())
		  }else{
	          p1 <- p1 + theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())		  
		  }
	  }	  
	  if(any(plottype %in% c("point","line","bar")) && any(ylabel[plottype %in% c("point","line","bar")]==1)){
	      yaxis_breaks <- as.data.frame(do.call(rbind,yaxis_breaks),stringsAsFactors=F)	      
		  names(yaxis_breaks) <- c("layer","min_val","max_val")
	      yaxis_labels <- as.data.frame(do.call(rbind,yaxis_labels),stringsAsFactors=F)
	      names(yaxis_labels) <- c("layer","min_val","max_val")
		  yaxis_breaks <- ddply(yaxis_breaks,.(layer),function(x){
		      xmin <- min(x$min_val, na.rm=T)
			  xmax <- max(x$max_val, na.rm=T)
		      rs <- c(x$layer[1],xmin,xmax)
			  return(rs)
		  })
		  yaxis_labels <- ddply(yaxis_labels,.(layer),function(x){
		      xmin <- min(x$min_val, na.rm=T)
			  xmax <- max(x$max_val, na.rm=T)
		      rs <- c(x$layer[1],xmin,xmax)
			  return(rs)
		  })
		  yaxis_breaks <- yaxis_breaks[,-2]
		  yaxis_labels <- yaxis_labels[,-2]
		  names(yaxis_breaks) <- c("layer","min_val","max_val")		  
		  names(yaxis_labels) <- c("layer","min_val","max_val")
	      p1 <- p1 + scale_y_continuous(breaks=c(yaxis_breaks$min_val,yaxis_breaks$max_val),labels=c(yaxis_labels$min_val,yaxis_labels$max_val))
	  }else{
	      if(plotdirection==1){
	          p1 <- p1 + theme(axis.text.y=element_blank(),axis.ticks.y=element_blank())
		  }else{
	          p1 <- p1 + theme(axis.text.x=element_blank(),axis.ticks.x=element_blank())		  
		  }
	  }
      ## *** x and y axis title***
	  p1 <- p1 + xlab(xtitle) + ylab(ytitle)
      ## *** Font face ***
	  p1 <- p1 + theme(axis.title = element_text(face=titlefontface))
	  ## *** Font size ***
      p1 <- p1 + theme(text = element_text(size=fontSize))
      ## *** Orientation ***
	  if(plotdirection==2){
	      p1 <- p1 + coord_flip()
	  }
	  ## *** facet_grid ***
      if(chrplotype==2){	  
	      if(plotdirection==2){
		      p1 <- p1 + facet_grid(.~chr.f)
          }else{
		      p1 <- p1 + facet_grid(chr.f~.)
		  }
	  }  
	  ## *** Legend ***
	  legends <- NA
	  lgd_width <- 0
	  for(g in length(data.T):1){	  
	      if(!all(is.na(get(paste("legend",g,sep=""))))){
              if(all(is.na(legends))){
                  lgd_width <- 0
              }else{
                  lgd_width <- lgd_width + lgdintrasize
              }
	          if(legendpos==1){
	              legends <- arrangeGrob(legends, get(paste("legend",g,sep="")),heights=unit.c(unit(lgd_width, "mm"),unit(lgdintrasize, "mm")))
	              legends <- legends[!is.na(legends$grobs),]			  
		      }else{
	              legends <- arrangeGrob(legends, get(paste("legend",g,sep="")),widths=unit.c(unit(lgd_width, "mm"),unit(lgdintrasize, "mm")))		  
	              legends <- legends[,!is.na(legends$grobs)]			  
		      }
		  }
	  }
	  if(any(addlegend==1) && all(!is.na(legends)) && !all(is.na(legends$grobs))){
		  if(legendpos==1){
	          p1 <- arrangeGrob(p1, legends, widths=c(1.05-lgdspacesize, lgdspacesize+0.05), ncol = 2)
		  }else{
	          p1 <- arrangeGrob(p1, legends, heights=c(1.05-lgdspacesize, lgdspacesize+0.05), nrow = 2)		
		  }
	  }
	  grid.draw(p1)
	  figure_1 <<- recordPlot()
      incProgress(1/1, detail="Finished")
      })		 
   }, height = Height, width = Width)  
}

plotfig_tc <- function(input, output, data.C1, data.C2, data.TC, Height, Width, selgralcol, gralcol_tp, gralcol_ct, coltype, colorcus, colormulgp, coltransparency, themestyle, fontSize, xtitle, ytitle, titlefontface, xlabel, ylabel, legendpos, lgdtitlesize, lgdtitlefontface, lgdtextsize, lgdtextfontface, symbolpoint, pointsize, linesize, xrugs, yrugs, xrugscol, yrugscol, vertical, verticalcol, verticalsize, verticaltype, horizontal, horizontalcol, horizontalsize, horizontaltype, addborder, bordercols, linetype, curvature, addlegend, collgd, collgdname, sizelgd, sizelgdname, shapelgd, shapelgdname, collgdmdylabel, collgdlabel, sizelgdmdylabel, sizelgdlabel, shapelgdmdylabel, shapelgdlabel, plottype){
	  output$figure_2 <- renderPlot({
	      withProgress(message='Making plots',value = 0,{	  
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
		 if(addlegend==1){
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
			     tc_p1 <- tc_p1 + guides(color = guide_colorbar(order = 1), size = guide_legend(order = 2))
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
		         tc_p1 <- tc_p1 + geom_rect(data=data.TT, aes(xmin=xpos1, xmax=xpos2, ymin=ypos1, ymax=ypos2, fill=color), color=bordercols) + scale_fill_gradient2(name=collgdname,guide = addcollgd,low = gralcols[1],midpoint=midpoint,mid=gralcols[2],high=gralcols[3],na.value="#FFFFFF00") + theme(legend.position = "bottom", legend.title = element_text(size=lgdtitlesize,face=lgdtitlefontface),legend.text = element_text(size=lgdtextsize,face=lgdtextfontface), legend.key = element_rect(fill = NA)) + guides(fill = guide_colourbar(title.vjust = 0.75, title.hjust = 1.2))			 
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
         tc_p1 <- tc_p1 + theme(text = element_text(size=fontSize))	  
		 grid.draw(tc_p1)
	     figure_2 <<- recordPlot()
         incProgress(1/1, detail="Finished")
         })		 
    }, height = Height, width = Width)
}



