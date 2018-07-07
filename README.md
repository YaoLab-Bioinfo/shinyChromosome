shinyChromosome
========

This is the repository for the Shiny application presented in "shinyChromosome: an R/Shiny application for interactive creation of non-circular plots of whole genomes" (Yu et al. 2018).

*****


#	Use shinyChromosome online

shinyChromosome is deployed at https://yimingyu.shinyapps.io/shinychromosome/ and http://shinychromosome.ncpgr.cn/ for online use.  
shinyChromosome is idle until you activate it by accessing the two URLs.  
So it may take some time when you access this URL for the first time.   
Once it was activated, shinyChromosome could be used smoothly and easily.

*****

#	<font color="red">Launch shinyChromosome directly from R and GitHub (preferred approach)</font>

User can choose to run shinyChromosome installed locally for a more preferable experience.

**Step 1: Install R and RStudio**

Before running the app you will need to have R and RStudio installed (tested with <font color="red">R 3.5.0</font> and RStudio 1.1.419).  
Please check CRAN (https://cran.r-project.org/) for the installation of R.  
Please check https://www.rstudio.com/ for the installation of RStudio.  

**Step 2: Install the R Shiny package and other packages required by shinyChromosome**

Start an R session using RStudio and run these lines:  
```
# try an http CRAN mirror if https CRAN mirror doesn't work
install.packages("shiny")
install.packages("rlang")
install.packages("gplots")
install.packages("ggplot2")
install.packages("plyr")
install.packages("ggthemes")
install.packages("RLumShiny")
install.packages("RColorBrewer")
install.packages("gridExtra")
install.packages("reshape2")
install.packages("data.table")
install.packages("shinythemes")
install.packages("shinyBS")
install.packages("markdown")
```

**Step 3: Start the app**  

Start an R session using RStudio and run these lines:  
```
shiny::runGitHub("shinyChromosome", "venyao")  
```

Your web browser will open the app.

*****

#	Deploy shinyChromosome on local or web Linux server

**Step 1: Install R**  

Please check CRAN (https://cran.r-project.org/) for the installation of R.

**Step 2: Install the R Shiny package and other packages required by shinyChromosome**  

Start an R session and run these lines in R:  
```
# try an http CRAN mirror if https CRAN mirror doesn't work  
install.packages("shiny")
install.packages("rlang")
install.packages("gplots")
install.packages("ggplot2")
install.packages("plyr")
install.packages("ggthemes")
install.packages("RLumShiny")
install.packages("RColorBrewer")
install.packages("gridExtra")
install.packages("reshape2")
install.packages("data.table")
install.packages("shinythemes")
install.packages("shinyBS")
install.packages("markdown")
```

For more information, please check the following pages:  
https://cran.r-project.org/web/packages/shiny/index.html  
https://github.com/rstudio/shiny  
https://shiny.rstudio.com/  

**Step 3: Install Shiny-Server**

Please check the following pages for the installation of shiny-server.  
https://www.rstudio.com/products/shiny/download-server/  
https://github.com/rstudio/shiny-server/wiki/Building-Shiny-Server-from-Source  

**Step 4: Upload files of shinyChromosome**

Put the directory containing the code and data of shinyChromosome to /srv/shiny-server.  

**Step 5: Configure shiny server (/etc/shiny-server/shiny-server.conf)**

```
# Define the user to spawn R Shiny processes
run_as shiny;

# Define a top-level server which will listen on a port
server {  
  # Use port 3838  
  listen 3838;  
  # Define the location available at the base URL  
  location /shinychromosome {  
    # Directory containing the code and data of shinyChromosome  
    app_dir /srv/shiny-server/shinyChromosome;  
    # Directory to store the log files  
    log_dir /var/log/shiny-server;  
  }  
}  
```

**Step 6: Change the owner of the shinyChromosome directory**

```
$ chown -R shiny /srv/shiny-server/shinyChromosome  
```

**Step 7: Start Shiny-Server**

```
$ start shiny-server  
```

Now, the shinyChromosome app is available at http://IPAddressOfTheServer:3838/shinychromosome/.  


