library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)

df <- read_csv("euphoria_episodes.csv", show_col_types = FALSE) |>
  filter(type == "regular") |>
  select(season, episode, IMDb = imdb_rating, TVmaze = tvmaze_rating) |>
  pivot_longer(c(IMDb, TVmaze), names_to = "source", values_to = "rating")

ggplot(df, aes(x = factor(episode), y = factor(season), fill = rating)) +
  geom_tile(color = "white", linewidth = 1) +
  geom_text(aes(label = sprintf("%.1f", rating)), size = 3.5) +
  facet_wrap(vars(source), ncol = 1) +
  scale_y_discrete(limits = rev) +
  scale_fill_distiller(
    palette = "RdYlGn",
    direction = 1,
    name = "Rating"
  ) +
  coord_fixed() +
  labs(
    x = "Episode",
    y = "Season",
    title = "Euphoria: IMDb vs. TVmaze Rating by Episode",
    caption = "Sources: IMDb non-commercial datasets, TVmaze API. Same color scale in both panels."
  ) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    strip.text = element_text(face = "bold", size = 12)
  )

ggsave("euphoria_heatmap_compare.png", width = 8, height = 7, dpi = 300, bg = "white")
