import glob
import pickle
import pandas as pd
import json
import collections
from datetime import timedelta, date

combined = pd.DataFrame(columns=['일자', '시간', '구', '기온', '습도', '강수량', '풍속', '미세먼지'])

# 틀 만들기
date_list = []
hour_list = [700, 800, 1800, 1900]
gu_list = []
date_month = 20181101
old = -1

df = pd.read_csv('gu/강남구 (1).csv')
for index, row in df.iterrows():
    if row.iloc[0].startswith(' Start'):
        date_month = int(row.iloc[0][9:])
    else:
        date = date_month + int(row.iloc[0]) - 1
        if date != old:
            date_list.append(date)
        old = date


for filepath in glob.iglob('gu/*.csv'):
    indicator = filepath[-6]
    if indicator == '1':
        gu = filepath[3:-8]
        gu_list.append(gu)


for i in date_list:
    print(i)
    for j in gu_list:
        for k in hour_list:
            # print([i, j, k])
            combined = combined.append({'일자': i, '시간': k, '구': j}, ignore_index=True)
            

print(combined)
print(combined.shape[0])



combined.to_pickle('format.pkl')
combined.to_csv('format.csv')



