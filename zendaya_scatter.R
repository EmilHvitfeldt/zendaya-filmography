library(readr)
library(dplyr)
library(stringr)
library(ggplot2)
library(ggrepel)

df <- read_csv("~/Desktop/zendaya_filmography.csv", show_col_types = FALSE)

df <- df %>%
  filter(`Screen Time Pct` != "Unreleased", !is.na(`Screen Time Pct`)) %>%
  mutate(
    screen_time_pct = as.numeric(str_remove(`Screen Time Pct`, "%")),
    box_office_m = as.numeric(str_remove_all(`Worldwide Box Office`, "[$M]"))
  )

ggplot(df, aes(x = screen_time_pct, y = box_office_m)) +
  geom_point(size = 3, color = "steelblue") +
  geom_text_repel(aes(label = Movie), size = 3.5, max.overlaps = 20) +
  labs(
    x = "Zendaya's Screen Time (%)",
    y = "Worldwide Box Office ($ millions)",
    title = "Zendaya Films: Screen Time vs. Box Office"
  ) +
  theme_minimal()

ggsave("~/Desktop/zendaya_scatter.png", width = 8, height = 6, dpi = 300)
