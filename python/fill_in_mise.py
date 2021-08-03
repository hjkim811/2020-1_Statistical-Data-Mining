import glob
import pickle
import pandas as pd
import json
import collections
from datetime import datetime


main = pd.read_csv('format+124+m2018+temp.csv', index_col=0)
count_2019 = 0

df = pd.read_csv('mise/기간별_일평균_대기환경_정보_2019년.csv', engine='python')


for index, row in df.iterrows():
    local_count = 0
    date = row['측정일자']
    gu = row['측정소명']
    mise = row['미세먼지(㎍/㎥)']
    print([date, gu, mise])

    for index2, row2 in main.iterrows():
        if row2['일자'] == date:
            if row2['구'] == gu:
                main.loc[index2, '미세먼지'] = mise
                count_2019 = count_2019 + 1
                local_count = local_count + 1
                if local_count == 4:
                    break

print(main)
print("count: ", count_2019)

main.to_pickle('format_final.pkl')
main.to_csv('format_final.csv')