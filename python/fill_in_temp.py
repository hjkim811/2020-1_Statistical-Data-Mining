import glob
import pickle
import pandas as pd
import json
import collections
from datetime import datetime


main = pd.read_csv('format+124+m2018.csv', index_col=0)
df = pd.read_csv('20181101-20191031 tmp.csv', engine='python')
d = 0


for index, row in df.iterrows():
    temp = row['평균기온(℃)']
    for i in range(100*d, 100*d+100):
        main.loc[i, '기온'] = temp
    d = d + 1

main.to_pickle('format+124+m2018+temp.pkl')
main.to_csv('format+124+m2018+temp.csv')
