# Zendaya Filmography

A small dataset and plot exploring Zendaya's screen time vs. box office performance across her film roles.

- `zendaya_filmography.csv`: film-by-film data (box office, RT scores, screen time)
- `zendaya_2022_2026.csv`: Zendaya's film and TV titles from 2022 to 2026 with release dates, pulled from the keyless Wikidata SPARQL and TVmaze APIs
- `euphoria_episodes.csv`: episode-by-episode data for Euphoria (seasons 1 to 3 plus specials) with air dates and times, runtimes, TVmaze ratings, and IMDb ratings and vote counts (IMDb columns are blank for specials)
- `euphoria_heatmap.R`: R script that produces the Euphoria heatmap
- `euphoria_heatmap.png`: rendered heatmap of IMDb rating by season (rows) and episode (columns)
- `euphoria_heatmap_compare.R`: R script that produces the IMDb vs. TVmaze small multiples
- `euphoria_heatmap_compare.png`: rendered small multiples of IMDb and TVmaze ratings by season and episode, on a shared color scale
- `zendaya_google_trends.csv`: monthly Google Trends interest for the search term "Zendaya" (US, Nov 2021 to Nov 2026, scaled 0 to 100 where 100 is the peak month), downloaded from [Google Trends](https://trends.google.com/trends/) on 2026-11-05
- `euphoria_trends.R`: R script that produces the Euphoria IMDb ratings vs. Google Trends chart
- `euphoria_trends.png`: rendered chart stacking Google Trends interest for "Zendaya" above Euphoria IMDb ratings by air date. Trends are for Zendaya, not Euphoria, and monthly, so this is a rough comparison
- `zendaya_scatter.R`: R script that produces the scatter plot
- `zendaya_scatter.png`: rendered chart of screen time (%) vs. worldwide box office

## Sources for `euphoria_episodes.csv`

| Columns | Source |
| --- | --- |
| `season`, `episode`, `type`, `title`, `airdate`, `airtime`, `airstamp_utc`, `runtime`, `tvmaze_rating` | [TVmaze API](https://www.tvmaze.com/api), show 28826 (`https://api.tvmaze.com/shows/28826/episodes?specials=1`). Air times are US Eastern; `airstamp_utc` is the same moment in UTC. `tvmaze_rating` is TVmaze's average user rating (no vote counts). |
| `imdb_id`, `imdb_rating`, `imdb_votes` | [IMDb non-commercial datasets](https://developer.imdb.com/non-commercial-datasets/) (`title.episode.tsv.gz` and `title.ratings.tsv.gz`), joined on parent title `tt8772296` plus season and episode number. Blank for specials, which the dataset does not list as numbered episodes. |

Data was pulled on 2026-11-05. Ratings change over time. IMDb data is used under IMDb's non-commercial terms; see the link above.
