# 05_cluster.R  
library(readr)
library(dplyr)
library(lubridate)
library(cluster)   # silhouette
library(factoextra) # 可视化
library(knitr)     # 输出表格

set.seed(446)
dir.create("outputs", showWarnings = FALSE)

df <- read_csv("data/potholes.csv", show_col_types = FALSE)

# === 特征工程：每个社区的统计指标 ===
feat <- df %>%
  mutate(hour = hour(creation_date)) %>% 
  group_by(community_area) %>% 
  summarise(
    n_requests = n(),
    pct_morning = mean(hour >= 7 & hour < 12, na.rm = TRUE),
    pct_weekend = mean(wday(creation_date, week_start = 1) >= 6, na.rm = TRUE),
    .groups = "drop"
  ) %>% 
  filter(complete.cases(.))        # 去掉缺失

km3 <- kmeans(select(feat, n_requests, pct_morning, pct_weekend), centers = 3)
feat$cluster <- factor(km3$cluster)

sil <- silhouette(km3$cluster, dist(feat[ , 2:4]))
cat("Average silhouette width:", mean(sil[, "sil_width"]), "\n")

write_csv(feat, "outputs/community_clusters.csv")
print("Clustering done -> outputs/community_clusters.csv")

