setwd("Z:/Workspaces/Kazi/OLD LAPTOP BACKUP/R Script")


library(ggmap)


location <- read.csv("testfile.csv", header=T)

str(location)


coordinates <- as.matrix(location[,5:4])

uniq_coordinates<- as.data.frame(as.matrix(unique(coordinates)))


# define an empty list with the size of no. of unique co-ordinates
myls <- vector("list", length = nrow(uniq_coordinates))   

# Pass each of the reverse geo-code response from google to fill up the element of the list
for (i in 1:nrow(uniq_coordinates) ) {

  myls[[i]] <- revgeocode(as.numeric(uniq_coordinates[i,]), output = 'more')
  

  }

library(data.table)

final_df <- rbindlist(myls, fill=TRUE)   #Makes one data.table from a list of many

rev_geo_df <-cbind(uniq_coordinates, final_df)  #combine by column. Sequence is important

View(cbind(uniq_coordinates, final_df))  #Just to view data

geocodeQueryCheck()   #see how many requests we have left with google


write.csv(rev_geo_df, file="rev_geo.csv", row.names=FALSE)
