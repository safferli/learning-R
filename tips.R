# reading csv, certain columns, faster reading of sample data, certain columns: 
#     http://blog.mollietaylor.com/2013/09/using-colclasses-to-load-data-more.html
sampleData <- read.csv("huge-file.csv", header = TRUE, nrows = 5)
classes <- sapply(sampleData, class)
largeData <- read.csv("huge-file.csv", header = TRUE, colClasses = classes)
str(largeData)

# http://statmethods.wordpress.com/2014/06/19/quickly-export-multiple-r-objects-to-an-excel-workbook/


# head(data, -1) tail(data, -1) gives you the easy way to calculate a-b rows
