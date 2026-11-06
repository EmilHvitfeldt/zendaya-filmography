library(readr)
library(dplyr)
library(ggplot2)

df <- read_csv("euphoria_episodes.csv", show_col_types = FALSE) |>
  filter(type == "regular")

ggplot(df, aes(x = factor(episode), y = factor(season), fill = imdb_rating)) +
  geom_tile(color = "white", linewidth = 1) +
  geom_text(aes(label = sprintf("%.1f", imdb_rating)), size = 4) +
  scale_y_discrete(limits = rev) +
  scale_fill_distiller(
    palette = "RdYlGn",
    direction = 1,
    name = "IMDb rating"
  ) +
  coord_fixed() +
  labs(
    x = "Episode",
    y = "Season",
    title = "Euphoria: IMDb Rating by Episode",
    caption = "Source: IMDb non-commercial datasets"
  ) +
  theme_minimal() +
  theme(panel.grid = element_blank())

ggsave("euphoria_heatmap.png", width = 9, height = 4, dpi = 300, bg = "white")
