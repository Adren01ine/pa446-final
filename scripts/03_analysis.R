# 03_analysis.R
library(dplyr)
library(ggplot2)
library(readr)

df <- read_csv("data/potholes.csv")

# 每个社区的投诉数量
by_area <- df %>%
  group_by(community_area) %>%
  summarise(count = n()) %>%
  arrange(desc(count))

# 简单柱状图（前 20 个社区）
top20 <- head(by_area, 20)

ggplot(top20, aes(x = reorder(community_area, count), y = count)) +
  geom_col(fill = "steelblue") +
  coord_flip() +
  labs(
    title = "Top 20 Community Areas by Pothole Complaints",
    x = "Community Area",
    y = "Number of Complaints"
  ) +
  theme_minimal()

# 可选：保存图表
ggsave("plots/pothole_bar.png", width = 6, height = 4)

