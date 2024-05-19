# Install packages
install.packages("dplyr")
install.packages("ggplot2")
install.packages("Amelia")
install.packages("plotly")
install.packages("knitr")

# Read data from csv file
data <- read.csv("netflix_2.csv", stringsAsFactors = TRUE)
head(data)
str(data)

#----------------Data Exploration------------------------------------

# controllare dati mancanti
colSums(is.na(data))
library(Amelia)
missmap(data, col = c("black", "tomato"), legend = TRUE)

# riassumere le variabili numeriche
summary(data)


library(dplyr) # importare dplyr per manipolazione dei dati

data %>%
  distinct(show_id, .keep_all = TRUE) %>%
  group_by(movie) %>%
  summarise(count = n ())


#-------------------------BAR PLOT FOR TYPE OF SHOWS---------------------------

library(ggplot2)
data %>%
  distinct(show_id, .keep_all = TRUE) %>%
  group_by(movie) %>%
  summarise(count = n()) %>%
  mutate(movie = factor(movie, labels = c("TV Show", "Movie"))) %>%
  ggplot() +
  geom_col(aes(x = movie, y = count, fill = movie)) +
  theme_minimal() +
  labs(title = "N. Tipi di Contenuto su Netflix") +
  scale_fill_manual(name = "Tipo di Contenuto", values = c("TV Show" = "#4A90E2", "Movie" = "#ff6961"))

#--------------------------------GRAFICO A TORTA--------------------------------------

library(plotly)

amount_by_type <- data %>%
  distinct(show_id, .keep_all = TRUE) %>%
  group_by(movie) %>%
  summarise(count = n()) %>%
  mutate(label = ifelse(movie == 1, "Movies", "TV Shows"))

fig1 <- plot_ly(amount_by_type, labels = ~label, values = ~count, type = 'pie', marker = list(colors = c("#4A90E2", "#ff6961")))
fig1 <- fig1 %>%
  layout(title = 'N. di contenuti su Netflix per Tipologia',
         xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
         yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE)
)

fig1

#----------------------------DISTRIBUZIONE DEI FILM---------------------------------

data.1 <- data %>% distinct(show_id, .keep_all = TRUE)

data.1 %>%
  filter(movie == 1) %>%
  select(duration) %>%
  pull() %>%
  mean()

data_movies <- data.1 %>%
  mutate(duration_in_mins = as.numeric(gsub("[^0-9]", "", duration)))

data_movies <- data_movies %>%
  filter(!is.na(duration_in_mins))

# Calcolo delle statistiche
mean_duration <- mean(data_movies$duration_in_mins)
median_duration <- median(data_movies$duration_in_mins)
mode_duration <- as.numeric(names(sort(table(data_movies$duration_in_mins), decreasing = TRUE)[1]))
range_duration <- range(data_movies$duration_in_mins)
iqr_duration <- IQR(data_movies$duration_in_mins)
sd_duration <- sd(data_movies$duration_in_mins)
var_duration <- var(data_movies$duration_in_mins)

# Stampa delle statistiche
print(paste("Media:", mean_duration))
print(paste("Mediana:", median_duration))
print(paste("Moda:", mode_duration))
print(paste("Range:", range_duration[1], "to", range_duration[2]))
print(paste("IQR:", iqr_duration))
print(paste("Deviazione Standard:", sd_duration))
print(paste("Varianza:", var_duration))

data %>%
  distinct(show_id, .keep_all = TRUE) %>%
  filter(movie == "1") %>%
  mutate(duration_in_mins = as.numeric(gsub("[^0-9]", "", duration))) %>%
  ggplot() +
  geom_density(aes(x = duration_in_mins)) +
  labs(title = "Distribuzione della Durata dei Film", subtitle = "in Minuti")




#---------------------GRAFICO A BARRE FILM VS PAESI-------------------------

data %>%
  distinct(show_id, .keep_all = TRUE) %>%
  group_by(country) %>%
  count() %>%
  arrange(desc(n)) %>%
  head(20) %>%
  ggplot() +
  geom_col(aes(y = reorder(country, n), x = n), fill = "#4A90E2") +
  geom_label(aes(y = reorder(country, n), x = n, label = n), hjust = -0.1) +
  labs(title = "N. di Film per Paese", subtitle = "Top 20 Paesi") +
  theme_minimal() +
  theme(
    axis.title.x = element_blank(),
    axis.title.y = element_blank()
  )

#-------------------GRAFICO A BARRE GENERE VS TITOLI(MOVIES)--------------------

movies_data <- data %>%
  filter(movie == 1) %>%
  distinct(show_id, .keep_all = TRUE)


movies_plot <- movies_data %>%
  group_by(listed_in) %>%
  count() %>%
  arrange(desc(n)) %>%
  head(30) %>%
  ggplot() +
  geom_col(aes(y = reorder(listed_in, n), x = n), fill = "#ff6961") +
  labs(title = "Generi Vs Titoli (Movies)", x = "N. di Titoli", y = "Genere") +
  theme_minimal()

print(movies_plot)

library(knitr)
movies_genre_count <- movies_data %>%
  group_by(listed_in) %>%
  count() %>%
  arrange(desc(n)) %>%
  head(30)

kable(movies_genre_count, caption = "Top 30 Movie Genres")
#-------------------GRAFICO A BARRE GENERE VS TITOLI(TV SHOWS)--------------------

library(knitr)
tvshows_data <- data %>%
  filter(movie == 0) %>%
  distinct(show_id, .keep_all = TRUE)

tvshows_plot <- tvshows_data %>%
  group_by(listed_in) %>%
  count() %>%
  arrange(desc(n)) %>%
  head(30) %>%
  ggplot() +
  geom_col(aes(y = reorder(listed_in, n), x = n), fill = "#4A90E2") +
  labs(title = "Generi Vs Titoli (TV Shows)", x = "N. di Titoli", y = "Genere") +
  theme_minimal()

print(tvshows_plot)

tvshows_genre_count <- tvshows_data %>%
  group_by(listed_in) %>%
  count() %>%
  arrange(desc(n)) %>%
  head(30)
kable(tvshows_genre_count, caption = "Top 30 TV Show Genres")
#-------------------------------------------------------------------------------
# remove all variables from the environment
rm(list=ls())

