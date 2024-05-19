import pandas as pd

df = pd.read_csv('netflix.csv', encoding='latin-1')
df

df['cast'] = df['cast'].str.split(',')
df['country'] = df['country'].str.split(',')
df['listed_in'] = df['listed_in'].str.split(',')

df1 = df.explode('cast').explode('country').explode('listed_in')
df1.head()

df1.to_csv('netflix_1.csv', index = False)