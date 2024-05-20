# Netflix-EDA

# Preparazione del Dataset
La preparazione del [Dataset](https://www.kaggle.com/datasets/rahulvyasm/netflix-movies-and-tv-shows) è stata svolta prima utilizzando Python, usato per suddividere le colonne 'cast', 'country' e 'listed_in' da stringhe separate da virgole in liste e la successiva espansione di queste liste in righe separate, creando un dataset più dettagliato.
In R, il dataset originale viene pulito rimouvendo colonne inutili e sostituendo stringhe vuote con valori NA. Le righe con valori mancanti vengono eliminate e vengono eseguite ulteriori trasformazioni, come la pulizia degli spazi bianchi, la conversione del formato delle date, e la creazione di colonne specifiche per distinguere tra film e Show TV. Questo processo assicura che i dati siano strutturati, puliti e pronti per ulteriori analisi.

# Descrizione dei dati del Dataset di Netflix

    str(data)
il comando citato sopra ci dice che il dataset è composto da 128584 osservazioni e  14 variabili, che sono:
- Show_id: Numero identificativo
- Title: Nome del programma
- Director: Il direttore del programma
- Cast: Gli attori e le attrici che sono stati scelti per il programma
- Country: I paesi dove il programma è stato prodotto
- Date_added: Il giorno in cui il programma è stato aggiunto alla piattaforma di streaming Netflix
- Release_year: L'anno in cui il programma è stato rilasciato al pubblico
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


# Conteggio dei Film e Serie TV

# Grafico a Barre per il tipo di programmi
La maggior parte dei titoli nel dataset sono film, con un valore medio per la variabile 'movie' di circa 0.9678, indicando che la stragrande maggioranza dei record (circa il 96.78%) sono film (1) rispetto a serie TV (0). La variabile 'movie' ha un valore minimo di 0 e un valore massimo di 1, con il primo quartile, la mediana e il terzo quartile tutti pari a 1, evidenziando ulteriormente la predominanza dei film nel Dataset.

![bar plot](/assets/barplot.png)
![pie chart](/assets/piechart.png)


+ summarise(count = n())

# una tabella 2 x 2

| Movie   | Count |
|---------|-------|
|    0    | 144   |
|    1    | 5186  |

la tabella mostra che ci sono nettamente più film che serie TV

# Distribuzione della Durata dei film 

La durata dei film nel Dataset presenta una distribuzione abbastanza uniforme, con la maggior parte dei film che si aggirano intorno ai 102.70 minuti in media. La mediana della durata è di 101 minuti, indicando che la metà dei film ha una durata inferiore a questo valore. La moda, ossia il valore più frequente, è di 94 minuti. L'intervallo della durata dei film varia da un minimo di 8 a un massimo di 253 minuti, suggerendo una vasta gamma di lunghezze. L'intervallo interquartile è di 28 minuti, indicando che il 50% **centrale** dei film ha una durata compresa tra 86 e 114 minuti. La deviazione standerd è di circa 25.96 minuti, suggerendo una moderata dispersione dei dati intorno alla media. Infine, la varianza è di circa 673.95, indicando la quantità di dispersione dei dati rispetto alla media, elevata al quadrato.

`> data.1 <- data %>% distinct(show_id, .keep_all = TRUE)`

`> data.1 %>%
   filter(movie == 1) %>%
   select(duration) %>%
   pull() %>%
   mean()`

![image](/assets/histogram.png)

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

![image](/assets/barplot3.png)

Table: Top 30 Movie Genres

|listed_in              |n.titles|
|:---------------------- |------:|
|Dramas                  | 1518  |
|Comedies                | 1127  |
|Action & Adventure       |  806 |
|Children & Family Movies |  469 |
|Documentaries            |  372 |
|Stand-Up Comedy          |  286 |
|Horror Movies            |  261 |
|International Movies     |  109 |
|Classic Movies           |   73 |
|Thrillers                |   62 |
|Independent Movies       |   20 |
|Movies                   |   20 |
|Anime Features           |   18 |
|Music & Musicals         |   15 |
|Sci-Fi & Fantasy         |   13 |
|Cult Movies              |   12 |
|Romantic Movies          |    3 |
|Drama                    |    1 |
|LGBTQ Movies             |    1 |

I dati offrono una panoramica completa dei generi cinematografici presenti nel dataset. Tra questi, i 'Drammi' emergono come la categoria più diffusa, con un totale di 1518 titoli, seguiti a stretto giro dalle 'Commedie' con 1127 titoli. 'Azione & Avventura' si posiziona al terzo posto con 806 titoli, mentre 'Film per Bambini e Famiglie' e 'Documentari' garantiscono rispettivamente 469 e 372 titoli. Generi come 'Commedie Stand-Up', 'Film Horror' e 'Film Internazionali' occupano anche una posizione di rilievo nella lista. Interessante notare che 'Drammi' e 'Film' compaiono come voci autonome, forse indicando una classificazione più ampia. Generi come 'Film Romantici' e 'Film LGBTQ' sono relativamente rari, ognuno con un solo titolo. Questa diversità di generi offre agli spettatori una vasta gamma di scelte, che soddisfano diverse preferenze e gusti."

# GRAFICO A BARRE GENERE VS TITOLI(TV SHOWS)

![image](/assets/barplot4.png)

Table: Top 30 TV Show Genres

|listed_in                    |  n|
|:----------------------------|--:|
|International TV Shows       | 44|
|Crime TV Shows               | 32|
|British TV Shows             | 20|
|Anime Series                 | 10|
|Kids' TV                     | 10|
|Stand-Up Comedy & Talk Shows |  7|
|Docuseries                   |  6|
|TV Shows                     |  5|
|TV Action & Adventure        |  2|
|TV Comedies                  |  2|
|Classic & Cult TV            |  1|
|Reality TV                   |  1|
|Romantic TV Shows            |  1|
|Sci-fi                       |  1|
|TV Dramas                    |  1|
|TV Horror                    |  1|

I dati mostrano una panoramica dei generi di programmi TV più popolari presenti nel dataset. 'Programmi TV Internazionali' dominano la lista con 44 titoli, seguiti da 'Programmi TV Crimine' con 32 titoli. 'Programmi TV Britannici', 'Serie Anime' e 'Programmi TV per Bambini' si collocano anche tra i primi posti della classifica con 20, 10 e 10 titoli rispettivamente. Altri generi rappresentati includono 'Commedie Stand-Up e Talk Show', 'Docuserie' e 'Programmi TV d'Azione e Avventura'. Alcuni generi come 'TV Drammi', 'TV Horror' e 'TV Romantici' sono meno rappresentati, ognuno con solo un titolo. Questa varietà di generi televisivi offre agli spettatori una vasta gamma di opzioni, dalle serie internazionali ai programmi per bambini, garantendo una varietà di intrattenimento adatta a diversi gusti e interessi.

# Grafico a Barre - Frequenza dei contenuti per anno

![image](/assets/barplot5.png)

La maggior parte dei contenuti nel dataset sono stati pubblicati negli anni recenti, con un picco significativo a partire dal 2000. Il numero di pubblicazioni per anno aumenta costantemente fino a raggiungere il massimo nel periodo tra il 2015 e il 2020, dove la frequenza supera i 600 titoli all'anno. Dopo il 2020, si nota una leggera diminuzione nel numero di nuovi contenuti. Questa tendenza suggerisce un'espansione rapida e recente della libreria di contenuti di Netflix, con un focus crescente su produzioni recenti.

# Frequenza dei Rating

![image](/assets/barplot7.png)

La maggior parte dei contenuti nel dataset è classificata come TV-MA, con oltre 1500 titoli, seguita da TV-14 con più di 1000 titoli. Le categorie R e PG-13 presentano un numero significativo di contenuti, rispettivamente con circa 700 e 500 titoli. Le fasce d'età TV-PG e PG contano meno di 500 titoli ciascuna. Le categorie meno rappresentate includono TV-G, TV-Y, TV-Y7, NR, G, TV-Y7-FV, UR, NC-17, e la categoria non classificata, ciascuna con meno di 100 titoli. Questi dati indicano che la maggior parte dei contenuti su Netflix è destinata a un pubblico adulto, mentre i contenuti per bambini e famiglie sono meno rappresentati.

# CORRELAZIONE TRA DURATA DEL FILM E DATA DI USCITA

![image](/assets/dispersione.png)

La maggior parte dei film nel dataset è stata pubblicata dopo l'anno 2000, con una durata che varia principalmente tra 50 e 150 minuti. Le durate dei film più recenti tendono a concentrarsi intorno ai 100 minuti. Prima degli anni '80, c'è una maggiore variazione nelle durate, con alcuni film molto brevi e altri particolarmente lunghi. Dal 2000 in poi, la distribuzione della durata dei film diventa più uniforme, evidenziando una standardizzazione nel tempo di visione. Questo suggerisce che, con il passare degli anni, i film hanno raggiunto una durata più omogenea, mentre in passato c'era una maggiore variabilità.