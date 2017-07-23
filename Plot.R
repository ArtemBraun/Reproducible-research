library(ggplot2)

# downloading data
Url_data <- "https://d3c33hcgiwev3.cloudfront.net/_e143dff6e844c7af8da2a4e71d7c054d_payments.csv?Expires=1500854400&Signature=BKulhWLKetPb58J8MLu9362an6admAVRvXnZ9UO1wZaneMQlOw1TqGpU8J0MoK3U4vHoQqjy-7BbG8T~Jq7bxLT8x1H~ZQPRw71JV4wEx3tDmabVfZr~0lZCoOPQ5CMb3mpPqBDiB4yTq6rmkBZSPGfkuzAlrpS~jULw0~9SO-Q_&Key-Pair-Id=APKAJLTNE6QMUY6HBC5A"

File_data <- "_e143dff6e844c7af8da2a4e71d7c054d_payments.csv"
if (!file.exists("payments.csv")) {
        download.file(Url_data, File_data, mode = "wb")
}

file.rename("_e143dff6e844c7af8da2a4e71d7c054d_payments.csv", "payments.csv")

#reading data
main_data <- read.table("payments.csv", header = TRUE, sep = ",")
NY_data <- subset(main_data, main_data$Provider.State == "NY")


#plotting the first plot
g <- ggplot(NY_data, aes(Average.Covered.Charges, Average.Total.Payments)) + 
        geom_point() +
        geom_smooth(method = "lm") + 
        labs(title = expression(atop("Relationship between Mean Covered Charges", paste("and Mean Total Payments in New York")))) +
        theme(plot.title = element_text(hjust = 0.5)) +
        labs(x = "Avarage Covered Charges", y = "Avarage Total Payments")
print(g)
ggsave("Plot1.pdf")

#plotting the second plot
g2 <- ggplot(main_data, aes(Average.Covered.Charges, Average.Total.Payments, color = DRG.Definition)) + 
        geom_point() +
        geom_smooth(method = "lm") + 
        ylim(2500,25000) +
        xlim(0,125000) +
        facet_wrap(~ Provider.State) +
        labs(title = "Relationship between Mean Covered Charges and Mean Total Payments by medical condition and state") +
        theme(plot.title = element_text(hjust = 0.5, size = 14,face="bold")) +
        theme(legend.position="bottom") +
        labs(x = "Avarage Covered Charges", y = "Avarage Total Payments")
print(g2)
ggsave("Plot2.pdf", dpi = 1200, width = 16, height = 12, units = "in")
