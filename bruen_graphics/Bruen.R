#import ggplot2
library(ggplot2)
#read in monthly bruen data
setwd("~/Desktop/BxD/Bruen_Project/bruen_raw_data")
nys_a <- read.csv("NYS_A.csv")
nys_b <- read.csv("NYS_B.csv")
nys_w <- read.csv("NYS_W.csv")
#convert Quarter data field into type Date
nys_a$Quarter =seq(as.Date("2020-01-01"),as.Date("2023-06-01"), by="3 month")
nys_b$Quarter =seq(as.Date("2020-01-01"),as.Date("2023-06-01"), by="3 month")
nys_w$Quarter =seq(as.Date("2020-01-01"),as.Date("2023-06-01"), by="3 month")
#plot Total Cases in NYS
plot(nys_a$Quarter, nys_a$Total.Cases, type = 'l', col = "gold", lwd = 2, ylim = c(min(nys_a$Total.Cases, nys_b$Total.Cases, nys_w$Total.Cases), max(nys_a$Total.Cases, nys_b$Total.Cases, nys_w$Total.Cases)), xlab = 'Time in Quarters (3 Months)', ylab = '# of Total Cases', main = 'Race/Ethnicity vs. Total CWP in NYS')
lines(nys_b$Quarter, nys_b$Total.Cases, col = 'lightgreen', lwd = 2)
lines(nys_w$Quarter, nys_w$Total.Cases, col = 'seagreen', lwd = 2)
abline(v=as.Date("2022-07-01"), col="red", lty = 'dashed')
legend('topleft', cex = 0.5, legend = c('All', 'Black', 'White Non-Hispanic', 'Date of Bruen Ruling'), col = c('gold', 'lightgreen', 'seagreen', 'red'), lty = c('solid', 'solid', 'solid', 'dashed'))
#read in pre and post bruen data
pre_bruen <- read.csv("pre_cwp_by_region.csv")
post_bruen <- read.csv("post_cwp_by_region.csv")
pre_bruen$X..Bail.Set.or.Remanded <- as.numeric(sub("%", "", pre_bruen$X..Bail.Set.or.Remanded))
post_bruen$X..Bail.Set.or.Remanded <- as.numeric(sub("%", "", post_bruen$X..Bail.Set.or.Remanded))
#create data frame of counts
pre_counts <- data.frame(pre_bruen$X..Bail.Set.or.Remanded, pre_bruen$Region, Race.Ethnicity = pre_bruen$Race.Ethnicity)
post_counts <- data.frame(post_bruen$X..Bail.Set.or.Remanded, post_bruen$Region, Race.Ethnicity = post_bruen$Race.Ethnicity)
#plot pre_counts
ggplot(pre_counts,aes(x = pre_bruen.Region, y = pre_bruen.X..Bail.Set.or.Remanded, fill = Race.Ethnicity)) + geom_bar(stat = "identity", position = "dodge") + ggtitle("Pre-Bruen % Bail Set or Remanded in CWP \nby Region and Race/Ethnicity") + labs(y = "% Bail Set or Remanded", x = "Region") + scale_fill_manual(values=c("gold", "lightgreen", "seagreen"))
#plot post_counts
ggplot(post_counts,aes(x = post_bruen.Region, y = post_bruen.X..Bail.Set.or.Remanded, fill = Race.Ethnicity)) + geom_bar(stat = "identity", position = "dodge") + ggtitle("Post-Bruen % Bail Set or Remanded in CWP \nby Region and Race/Ethnicity") + labs(y = "% Bail Set or Remanded", x = "Region") + scale_fill_manual(values=c("gold", "lightgreen", "seagreen"))