# Netflix-EDA

# Descrizione dei dati del Dataset di Netflix

    str(data)
il comando citato sopra ci dice che il dataset è composto da 128584 osservazioni e  14 variabili, che sono:
- Show_id: Numero identificativo
- Title: Nome del programma
- Director: Il direttore del programma
- Cast: Gli attori e le attrici che sono stati scelti per il programma
- Country: I paesi dove il programma è stato prodotto
- Date_added: Il giorno in cui il programma è stato aggiunto alla piattaforma di streaming Netflix
- Release_year: Il giorno in cui il programma è stato rilasciato al pubblico
- Rating: Fascia d'età del programma
- Duration: Durata del programma in minuti
- Listed_in: Il genere del programma
- Description: Una Sinossi del programma
- Movie: Distinzione del programma in Serie TV e Film
- N_seasons: Numero di stagioni di una Serie TV

# Verificare i dati mancanti

> apply(data, MARGIN = 2, FUN = function(x) sum(is.na(x)))

               X         show_id       title       director      cast        country     date_added  release_year    rating     duration 
               0            0            0            0            0            0            0            0            0         4138 
            listed_in  description     movie    n_seasons 
               0            0            0       124446


Possiamo notare che mancano molti valori nella colonna n_seasons, questo è perchè come vedremo successivamente la maggior parte delle osservazioni nel Dataset sono di tipo Film (1).

# Missing Map
![missing map](/assets/missingnessMap.png)
# Conteggio dei Film e Serie TV

# Grafico a Barre per il tipo di programmi
![bar plot](/assets/barplot)
![pie chart](/assets/piechart.png)


+ summarise(count = n())

# una tabella 2 x 2

| Movie   | Count |
|---------|-------|
|    0    | 144   |
|    1    | 5186  |

la tabella mostra che ci sono nettamente più film che serie TV

# Distribuzione della Durata dei film 
`> data.1 <- data %>% distinct(show_id, .keep_all = TRUE)`

`> data.1 %>%
   filter(movie == 1) %>%
   select(duration) %>%
   pull() %>%
   mean()`
![image](/assets/densityplot.png)

Il codice analizza la durata dei film presenti nel dataset, calcolandone la durata media in minuti. Questo ci da un'idea della lunghezza tipica dei film nel Dataset. Il grafico ci aiuta a vedere come le durate dei film sono distribuite su valori diversi. Questo potrebbe dirci se la maggior parte dei film ha durate simili o se c'è un'ampio range.

**Nel complesso, questo è uno sguardo ai modelli di lunghezza dei film nel Dataset, combinando sia approfondimenti numerici che una <span style="color: green;">rappresentazione visiva</span> per una comprensione più completa**

# Grafico a Barre di Film vs Paesi
![image](/assets/barplot2.png)

**Osservazioni dai primi 20 paesi con il maggior numero di film su Netflix:**

**Popolarità Globale:**
- La presenza di alcuni paesi ai primi posti suggerisce un appetito globale per i film provenienti da queste regioni. Ad esempio, se gli Stati Uniti, l'India o altri paesi dominano la lista, significa la popolarità internazionale delle rispettive industrie cinematografiche.

**Diversità dei Contenuti:**
- Una rappresentazione diversificata dei paesi nella Top 20 indica che Netflix offre un'ampia gamma di contenuti provenienti da diverse parti del mondo.
Se i paesi di vari continenti come l'Asia, l'Europa e l'America Latina sono ben rappresentati, dimostra l'impegno di Netflix nel fornire una selezione ricca e variegata.

**Impatto Culturale:**
- La popolarità dei film provenienti da paesi specifici può riflettere il loro impatto culturale su scala globale.
Ad esempio, l'influenza di Bollywood in India o di Hollywood negli Stati Uniti potrebbe essere evidente nella classifica.

In sintesi, la diversità dei paesi nella top 20 non solo mette in mostra la popolarità globale dei film, ma sottolinea anche l'impegno di Netflix nell'offrire un ampio spettro di contenuti, soddisfacendo i vari gusti e preferenze del suo pubblico internazionale.

# GRAFICO A BARRE GENERE VS TITOLI(MOVIES)

![image](/assets/)


# GRAFICO A BARRE GENERE VS TITOLI(TV SHOWS)

![image](/assets/)
