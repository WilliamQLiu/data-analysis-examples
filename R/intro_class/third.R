require(ggplot2)
# Using Base R plots
head(diamonds)
boxplot(diamonds$price) # shows min, line = 1st quartile, 2nd quartile, median, 3rd quartile, 4th quartile, max
hist(diamonds$price)
plot(price ~ carat, data=diamonds)

# Now using GGPlot for boxplots
ggplot(diamonds, aes(x=1, y=price)) + geom_boxplot() #regular boxplot, looks a little better
ggplot(diamonds, aes(x=cut, y=price)) + geom_boxplot() #boxplot, now splits to 5 graphs by price
ggplot(diamonds, aes(x=cut, y=price)) + geom_violin() #boxplot, now splits to 5 graphs and shows density of data
ggplot(diamonds, aes(x=cut, y=price)) + geom_jitter() + geom_violin() #boxplot, shows density of data and random noise
ggplot(diamonds, aes(x=cut, y=price)) + geom_jitter() + geom_violin(alpha=1/20) #boxplot, now splits to 5 graphs, shows density of data, and shows alpha
?geom_violin

# Now using GGPlot for histograms
ggplot(diamonds, aes(x=price)) + geom_histogram() #histogram, boxy width (default binwidth = range / 30)
ggplot(diamonds, aes(x=price)) + geom_histogram(binwidth=10) #histogram, small width
ggplot(diamonds, aes(x=price)) + geom_histogram() + facet_wrap(~cut)#small multiples; series of small similar graphics or charts
ggplot(diamonds, aes(x=price)) + geom_histogram(aes(fill=cut))#color code plot

# Now using GGPlot for scatterplots
g <- ggplot(diamonds, aes(x=carat, y=price)) # Shortening the base function
g + geom_point() # create scatterplot
g + geom_point(aes(color=cut)) # Adding color, R colorbrewer allows good color combinations
g + geom_point(aes(color=table)) + scale_color_continuous(low="blue", high="red") # Adding color, R colorbrewer allows good color combinations
?aes
g + geom_point() + facet_grid(color ~ clarity) # made small multiples based on two variables (clarity and color)
g + geom_point(aes(color=cut)) + facet_grid(color ~ clarity) # made small multiples based on two variables (clarity and color) along with color for cut
?aes

require(ggthemes)
g2 <- g + geom_point(aes(color=cut))
g2 + theme_economist() + scale_color_economist()
g2 + theme_wsj() + scale_color_wsj()
g2 + theme_excel()
g2 + theme_tufte()
#There's a ggthemes plot that lets you draw like xkcd comic

require(RXKCD) # Shows XKCD comics
RXKCD::getXKCD(which=552) # Shows XKCD Comics in 'File'