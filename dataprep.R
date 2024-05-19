setwd("D:\\Studies\\Materials\\Second-cycle\\I year\\II trimester\\Coding-Girls\\Materials\\coding-girls\\Progetto")

# Caricare il dataset
data <- read.csv("netflix_titles.csv")

head(data)

library(dplyr)
data.1 <- data %>%
  select(-c(13:26)) %>% # Deselezionare le colonne X-X.13
  mutate_all(function(x) ifelse(x == "", NA, x)) # Cambiare le stringhe vuote in NA

# Controllare per i valori mancanti
colSums(is.na(data.1))

data.2 <- na.omit(data.1) # Deselezionare le righe con i valori mancanti
colSums(is.na(data.2))

data.2 %>%
  select(type) %>%
  distinct() # Per vedere "type" unici

#write.csv(data.2, "netflix.csv")

# Ho fatto alcune operazioni in Python

# Caricare il dataset
data.3 <- read.csv("netflix_1.csv") %>%
  select(-1) %>%
  mutate(
    cast = trimws(cast), # Eliminare lo spazio prima e dopo una stringa
    country = trimws(country),
    listed_in = trimws(listed_in),
    date_added = as.Date(date_added, format = "%B %d, %Y"), # Modificare il formato della data
    movie = as.factor(ifelse(type == "Movie", 1, 0)), # Se è Movie, il valore è 1, se TV Show, il valore è 0
    n_seasons = ifelse(movie == 1, NA, duration), # Creare una colonna n_seasons e prendere valore da "duration" se è TV Show
    duration = ifelse(movie == 1, duration, NA), # Mantenere il valore di "duration" solo se è Movie
    n_seasons = gsub("[^0-9]", "", n_seasons), # Mantenere solo il numero di una stringa
    duration = gsub("[^0-9]", "", duration)
    ) %>%
  select(-type)

colSums(is.na(data.3))

data.4 <- data.3 %>%
  filter(!is.na(date_added)) # Deselezionare le righe con valori mancanti in "date_added"

colSums(is.na(data.4))
# Ora, abbiamo alcuni valori mancanti in "duration" e in "n_seasons", ma va bene
# Se analizzate Movies, dovreste guardare "duration", se analizzate TV Shows, dovreste guardare "n_seasons"

