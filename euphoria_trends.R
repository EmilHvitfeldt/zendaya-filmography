library(readr)
library(dplyr)
library(ggplot2)
library(patchwork)

trends <- read_csv("zendaya_google_trends.csv", show_col_types = FALSE) |>
  rename(date = Time, interest = Zendaya)

eps <- read_csv("euphoria_episodes.csv", show_col_types = FALSE) |>
  filter(type == "regular", airdate >= min(trends$date)) |>
  mutate(season = factor(season, labels = paste("Season", 2:3)))

# Shaded windows for each season's run
windows <- eps |>
  group_by(season) |>
  summarise(start = min(airdate), end = max(airdate))

xlim <- c(min(trends$date), as.Date("2026-11-30"))

shade <- geom_rect(
  data = windows,
  aes(xmin = start, xmax = end, ymin = -Inf, ymax = Inf),
  inherit.aes = FALSE,
  fill = "grey80",
  alpha = 0.6
)

p_trends <- ggplot(trends, aes(date, interest)) +
  shade +
  geom_line(color = "steelblue", linewidth = 0.9) +
  scale_x_date(limits = xlim, date_breaks = "6 months", date_labels = "%b %Y") +
  labs(
    x = NULL,
    y = "Google Trends interest",
    title = "Euphoria IMDb Ratings vs. Google Searches for Zendaya",
    subtitle = "Grey bands mark each Euphoria season's air dates. Trends are monthly, US, scaled 0 to 100 (100 = peak month)."
  ) +
  theme_minimal() +
  theme(axis.text.x = element_blank())

p_imdb <- ggplot(eps, aes(airdate, imdb_rating, color = season)) +
  shade +
  geom_line(linewidth = 0.9) +
  geom_point(size = 2.5) +
  scale_x_date(limits = xlim, date_breaks = "6 months", date_labels = "%b %Y") +
  scale_color_manual(values = c("Season 2" = "#C8553D", "Season 3" = "#2F6F73")) +
  labs(
    x = NULL,
    y = "IMDb rating",
    color = NULL,
    caption = "Sources: Google Trends (term: Zendaya), IMDb non-commercial datasets"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

p_trends / p_imdb + plot_layout(heights = c(2, 1))

ggsave("euphoria_trends.png", width = 10, height = 7, dpi = 300, bg = "white")
