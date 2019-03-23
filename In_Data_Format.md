---
title:
output: 
  html_document:
    keep_md: TRUE
---



<h1><center> Input data format </center></h1>

The detailed format of input data for different types of plots are described in the following sections.  

## **1. Single genome plot**

### **1.1 Genome data**

The dataset should contain only 2 columns with fixed order. Column names are **optional**.  
**1st column**: chromosome ID.  
**2nd column**: chromosome length.  

Acceptable input data format can be  


```
 chr     size
   1 43268879
   2 35930381
   3 36406689
```

or 


```
1	43268879
2	35930381
3	36406689
```


### **1.2 Point**

The dataset should contain >=3 columns.  
In the simplest situation, the dataset should contain 3 columns with fixed order. In this case, column names are **optional**.  
**1st column**: chromosome ID.  
**2nd column**: chromosome position.  
**3rd column**: data value.  

Acceptable input data format can be  


```
 chr position    value
   1   202360 0.315323
   1   213775 1.113439
   1   218457 0.393112
```

or  


```
1	202360	0.315323
1	213775	1.113439
1	218457	0.393112
```

To control the color of points, add a **color** column to categorize the data into different groups. Then different colors will be assigned to different groups of data. In this case, column names are **compulsory**. The name of the first three columns can be any appropriate variable names in R and the order of the first three columns must be fixed as the simplest situation. The name of the **color** column must be 'color'. 


```
 chr position    value color
   1   202360 0.315323     a
   1   213775 1.113439     a
   1   218457 0.393112     a
```

To control the symbol used for each point, add a **shape** column. Check http://www.endmemo.com/program/R/pchsymbols.php for more information. In this case, column names are **compulsory**. The name of the first three columns can be any appropriate variable names in R and the order of the first three columns must be fixed as the simplest situation. The name of the **shape** column must be 'shape'. 


```
 chr position value shape
   1        1    29    15
   1   100001    18    15
   1   200001    22    15
```

To control the size of each point, add a **size** column. Larger number in the **size** column means lareger point size. In this case, column names are **compulsory**. The name of the first three columns can be any appropriate variable names in R and the order of the first three columns must be fixed as the simplest situation. The name of the **size** column must be 'size'.  


```
 chr position value size
   1        1    29  1.1
   1   100001    18  1.0
   1   200001    22  1.1
```

Users can choose to control two or more of the **color**, **shape** and **size** features at the same time. In this case, column names are **compulsory**. The name of the first three columns can be any appropriate variable names in R and the order of the first three columns must be fixed as the simplest situation. The name of the **shape** column must be 'shape'. The name of the **color** column must be 'color'. The name of the **size** column must be 'size'. The order of the **color**, **shape** and **size** columns is flexible. Acceptable input data can be  


```
 chr position value color shape
   1        1    29     a    15
   1   100001    18     a    15
   1   200001    22     a    15
```

or  


```
 chr position value color shape size
   1        1    29     a    15  1.1
   1   100001    18     a    15  1.0
   1   200001    22     a    15  1.1
```

or  


```
 chr position value color size
   1        1    29     a  1.1
   1   100001    18     a  1.0
   1   200001    22     a  1.1
```

or  


```
 chr position value shape size
   1        1    29    15  1.1
   1   100001    18    15  1.0
   1   200001    22    15  1.1
```


### **1.3 Line**

The dataset should contain >=3 columns.  
In the simplest situation, the dataset should contain 3 columns with fixed order. In this case, column names are **optional**.  
**1st column**: chromosome ID.  
**2nd column**: chromosome position.  
**3rd column**: data value.  

Acceptable input data format can be  


```
 chr position  value
   1        0 0.0428
   1   565000 0.0522
   1   599000 0.0674
```

or  


```
1	     0	0.0428
1	565000	0.0522
1	599000	0.0674
```

To add multiple lines and assign different colors to different lines, add a **color** column to categorize the data into different groups. In this case, column names are **compulsory**. The name of the first three columns can be any appropriate variable names in R and the order of the first three columns must be fixed as the simplest situation. The name of the **color** column must be 'color'. 


```
 chr position value color
   1        1    29     a
   1   100001    18     a
   1        1     4     b
   1   200001     5     b
```


### **1.4 Bar**

The dataset should contain >=4 columns.  
In the simplest situation, the dataset should contain 4 columns with fixed order. In this case, column names are **optional**.  
**1st column**: chromosome ID.  
**2nd column**: start coordinate of bars.  
**3rd column**: end coordinate of bars.  
**4th column**: data value.  

Acceptable input data format can be  


```
 chr  start    end value
   1      1 100000   672
   1 100001 200000   486
   1 200001 300000   650
```

or  


```
1	     1	100000	672
1	100001	200000	486
1	200001	300000	650
```

To control the color of bars, add a **color** column to categorize the data into different groups. Then different colors will be assigned to different groups of data. In this case, column names are **compulsory**. The name of the first four columns can be any appropriate variable names in R and the order of the first four columns must be fixed as the simplest situation. The name of the **color** column must be 'color'.  


```
 chr  start    end  value color
   1      0 565000 0.5923     a
   1 565000 599000 0.6701     a
   1 599000 922000 0.6785     a
```


### **1.5 Rect**

The dataset should contain 4 columns with fixed order. Column names are **optional**.  
**1st column**: chromosome ID.  
**2nd column**: start coordinate of rects.  
**3rd column**: end coordinate of rects.  
**4th column**: data value.  

The 4th column can be a character vector or a numeric vector. For a character vector, choose the `rect_discrete` plot type. For a numeric vector, choose the `rect_gradual` plot type.  

Acceptable input data format can be  


```
 chr  start    end color
   1      1 100000     A
   1 100001 200000     C
   1 200001 300000     A
```

or


```
1	     1	100000	A
1	100001	200000	C
1	200001	300000	A
```

or


```
 chr  start    end NTE
   1      1 100000  29
   1 100001 200000  18
   1 200001 300000  22
```

or


```
1	     1	100000	29
1	100001	200000	18
1	200001	300000	22
```

### **1.6 Heatmap**

The dataset should contain >=4 columns. Column names are **optional**. The order of the first three columns must be fixed as follows.  
**1st column**: chromosome ID.  
**2nd column**: start coordinate of cells.  
**3rd column**: end coordinate of cells.  

Except for the first three columns, all the rest columns are treated as data values by shinyChromosome.  
The rest columns can be character vectors or numeric vectors. Mix of character vector and numeric vector are not allowed.  
For character vectors, choose the `heatmap_discrete` plot type. For numeric vectors, choose the `heatmap_gradual` plot type.  

Acceptable input data format can be  


```
 chr   start     end val1 val2 val3 val4 val5 val6
   1       0  631164    a    e    c    c    a    b
   1  631165 1749192    b    b    c    d    d    c
   1 1749193 2077793    c    e    a    b    e    e
```

or  


```
1	      0	 631164	a	e	c	c	a	b
1	 631165	1749192	b	b	c	d	d	c
1	1749193	2077793	c	e	a	b	e	e
```

or 


```
 chr    start      end TE NTE TR NTR
   1        1   100000  4  29 17  45
   1 10000001 10100000  9  14 20  28
   1  1000001  1100000  1  16 -5  29
```

or 


```
1	       1	  100000	4	29	17	45
1	10000001	10100000	9	14	20	28
1	 1000001	 1100000	1	16	-5	29
```

### **1.7 Segment**

The dataset should contain 5 columns with fixed order. Column names are **optional**.  
**1st column**: chromosome ID.  
**2nd column**: X-axis start coordinate of segments.  
**3rd column**: Y-axis start coordinate of segments.  
**4th column**: X-axis end coordinate of segments.  
**5th column**: Y-axis end coordinate of segments.  

Acceptable input data format can be  


```
 chr   xstart ystart     xend yend
   1   134291      0   134291  2.8
   1  2665412      0  2665412  2.8
   1 24392841      0 24392841  2.8
```

or  


```
1	  134291	0	  134291	2.8
1	 2665412	0	 2665412	2.8
1	24392841	0	24392841	2.8
```

### **1.8 Text**

The dataset should contain 4 columns with fixed order. Column names are **optional**.  
**1st column**: chromosome ID.  
**2nd column**: X-axis position of texts.  
**3rd column**: Y-axis position of texts.  
**4th column**: the symbols of texts.  

Acceptable input data format can be  


```
 chr     xpos ypos  symbol
   1   134291    3 OsTLP27
   1  2665412    3    MT2D
   1 24392841    3   OCPI1
```

or 


```
1	  134291	3	OsTLP27
1	 2665412	3	   MT2D
1	24392841	3	  OCPI1
```

### **1.9 Vertical line**

The dataset should contain 2 columns with fixed order. Column names are **optional**.  
**1st column**: chromosome ID.  
**2nd column**: genomic position of vertical lines.  

Acceptable input data format can be  


```
 chr position
   1        0
   1 43268879
   2 35930381
```

or 


```
1	       0
1	43268879
2	35930381
```

### **1.10 Horizontal line**

The dataset should contain 1 column. Column names are **optional**.  
**1st column**: Y-axis value of horizontal lines.  

Acceptable input data format can be  


```
 position
        8
       12
        5
```

or  


```
 8
12
 5
```

## **2. Two genomes plot**

### **2.1 Data of genome along the horizontal axis**

The dataset should contain only 2 columns with fixed order. Column names are **optional**.  
**1st column**: chromosome ID.  
**2nd column**: chromosome length.  

Acceptable input data format can be  


```
 chr     size
   1 43268879
   2 35930381
   3 36406689
```

or  


```
1	43268879
2	35930381
3	36406689
```

### **2.2 Data of genome along the vertical axis**

The dataset should contain only 2 columns with fixed order. Column names are **optional**.  
**1st column**: chromosome ID.  
**2nd column**: chromosome length.  

Acceptable input data format can be  


```
   chr     size
 Chr01 41185095
 Chr02 34608401
 Chr03 37032663
```

or  


```
Chr01	41185095
Chr02	34608401
Chr03	37032663
```

### **2.3 Point**

The dataset should contain >=4 columns.  
In the simplest situation, the dataset should contain 4 columns with fixed order. In this case, column names are **optional**.  
**1st column**: chromosome ID of genome along the horizontal axis.  
**2nd column**: chromosome position in genome along the horizontal axis.  
**3rd column**: chromosome ID of genome along the horizontal axis.  
**4th column**: chromosome position in genome along the vertical axis.  

Acceptable input data format can be  


```
 chrX     posX chrY     posY
    4 23006000    6 27706220
    6 26269000    6 27706227
   11 17015000    6 27706228
```

or  


```
 4	23006000	6	27706220
 6	26269000	6	27706227
11	17015000	6	27706228
```

To control the color of points, add a **color** column. In this case, column names are **compulsory**. The name of the first four columns can be any appropriate variable names in R and the order of the first four columns must be fixed as the simplest situation. The name of the **color** column must be 'color'. The color column can be a character vector or a numeric vector. If the color column is a character vector, choose the `point_discrete` plot type.    


```
 chrX     posX chrY     posY color
    1 15414550    1 17415683     a
    1  2314068    1  2291659     a
    1  2583523    1  2546654     c
```

If the color column is a numeric vector, choose the `point_gradual` plot type.   


```
 chrX     posX chrY     posY  color
    4 23006000    6 27706220  5.222
    6 26269000    6 27706227 10.424
   11 17015000    6 27706228  5.802
```

To control the symbol used for each point, add a **shape** column. Check http://www.endmemo.com/program/R/pchsymbols.php for more information. In this case, column names are **compulsory**. The name of the first four columns can be any appropriate variable names in R and the order of the first four columns must be fixed as the simplest situation. The name of the **shape** column must be 'shape'. The **shape** column should be an integer vector.  


```
 chrX     posX chrY     posY shape
    1 15414550    1 17415683    12
    1  2314068    1  2291659    12
    1  2583523    1  2546654    12
```

To control the size of each point, add a **size** column. Larger number in the **size** column means lareger point size. In this case, column names are **compulsory**. The name of the first four columns can be any appropriate variable names in R and the order of the first four columns must be fixed as the simplest situation. The name of the **size** column must be 'size'. The **size** column should be an integer vector. 


```
 chrX     posX chrY     posY size
    1 15414550    1 17415683  1.2
    1  2314068    1  2291659  1.2
    1  2583523    1  2546654  1.2
```

Acceptable input data can also be  


```
 chrX     posX chrY     posY color shape
    1 15414550    1 17415683     a    12
    1  2314068    1  2291659     a    12
    1  2583523    1  2546654     c    12
```

or  


```
 chrX     posX chrY     posY color size
    1 15414550    1 17415683     a  1.2
    1  2314068    1  2291659     a  1.2
    1  2583523    1  2546654     c  1.2
```

or  


```
 chrX     posX chrY     posY shape size
    1 15414550    1 17415683    12  1.2
    1  2314068    1  2291659    12  1.2
    1  2583523    1  2546654    12  1.2
```

or  


```
 chrX     posX chrY     posY color shape size
    1 15414550    1 17415683     a    12  1.2
    1  2314068    1  2291659     a    12  1.2
    1  2583523    1  2546654     c    12  1.2
```


### **2.4 Segment**

The dataset should contain >=6 columns.  
In the simplest situation, the dataset should contain 6 columns with fixed order. In this case, column names are **optional**.  
**1st column**: chromosome ID of genome along the horizontal axis.  
**2nd column**: X-axis start coordinate of segments.  
**3rd column**: X-axis end coordinate of segments.  
**4th column**: chromosome ID of genome along the vertical axis.  
**5th column**: Y-axis start coordinate of segments.  
**6th column**: Y-axis end coordinate of segments.  

Acceptable input data can be  


```
  chrX startX stopX  chrY startY stopY
 Chr01    101 21963 Chr01  19600 41490
 Chr01  25221 49370 Chr01  41483 65682
 Chr01  49604 67964 Chr01  65681 84044
```

or  


```
Chr01	  101	21963	Chr01	19600	41490
Chr01	25221	49370	Chr01	41483	65682
Chr01	49604	67964	Chr01	65681	84044
```

To control the color of segments, add a **color** column to categorize data into different groups. Then different colors will be assigned to different groups of data. In this case, column names are **compulsory**. The name of the first six columns can be any appropriate variable names in R and the order of the first six columns must be fixed as the simplest situation. The name of the **color** column must be 'color'.  


```
  chrX   startX    stopX  chrY   startY    stopY color
 Chr01        1 35619588 Chr01        1 36185095     a
 Chr02 35140161        1 Chr02 34608401        1     b
 Chr03        1 33736842 Chr03 37032663        1     c
```


### **2.5 Rect**

The dataset should contain 7 columns with fixed order. Column names are **optional**.  
**1st column**: chromosome ID of genome along the horizontal axis.  
**2nd column**: X-axis start coordinate of rects.  
**3rd column**: X-axis end coordinate of rects.  
**4th column**: chromosome ID of genome along the vertical axis.  
**5th column**: Y-axis start coordinate of rects.  
**6th column**: Y-axis end coordinate of rects.  
**7th column**: the color of rects.  

The 7th column can be a character vector or a numeric vector. For a character vector, choose the `rect_discrete` plot type. For a numeric vector, choose the `rect_gradual` plot type.  

Acceptable input data format can be  


```
 chrx startx   stopx chry  starty   stopy color
    1      1 1000000    1       1 1000000    41
    1      1 1000000    1 1000001 2000000    43
    1      1 1000000    1 2000001 3000000    59
```

or  


```
 chrx startx   stopx chry  starty   stopy color
    1      1 1000000    1       1 1000000     b
    1      1 1000000    1 1000001 2000000     b
    1      1 1000000    1 2000001 3000000     b
```

<br>
<br>
<br>


