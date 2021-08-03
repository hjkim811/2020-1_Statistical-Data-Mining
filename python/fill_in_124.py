import glob
import pickle
import pandas as pd
import json
import collections
from datetime import datetime

d_gu = {

    '강남구': 0,
    '강동구': 1,
    '강북구': 2,
    '강서구': 3,
    '관악구': 4,
    '광진구': 5,
    '구로구': 6,
    '금천구': 7,
    '노원구': 8,
    '도봉구': 9,
    '동대문구': 10,
    '동작구': 11,
    '마포구': 12,
    '서대문구': 13,
    '서초구': 14,
    '성동구': 15,
    '성북구': 16,
    '송파구': 17,
    '양천구': 18,
    '영등포구': 19,
    '용산구': 20,
    '은평구': 21,
    '종로구': 22,
    '중구': 23,
    '중랑구': 24

}

d_time = {

    700: 0,
    800: 1,
    1800: 2,
    1900: 3

}

def day_count(d2):
    d1 = datetime.strptime(str(20181101), "%Y%m%d")
    d2 = datetime.strptime(str(d2), "%Y%m%d")
    return abs((d2 - d1).days)


main = pd.read_csv('format.csv', index_col=0)


for filepath in glob.iglob('r_gu/*.csv'):
    df = pd.read_csv(filepath)
    indicator = filepath[-6]
    count_row = df.shape[0]
    if count_row != 1460:
        print(filepath, 'row number not 1460')
        exit()

    for index, row in df.iterrows():
        d = day_count(int(row.iloc[3]))
        g = d_gu[filepath[7:-8]]
        t = d_time[int(row.iloc[1])]
        idx = 100 * d + 4 * g + t
        value = row.iloc[2]

        if indicator == '1':
            main.loc[idx, '습도'] = value
        elif indicator == '2':
            main.loc[idx, '강수량'] = value
        elif indicator == '4':
            main.loc[idx, '풍속'] = value
        else:
            print('indicator error')
            exit()

    print(filepath, 'done')

print(main)

main.to_pickle('format+124.pkl')
main.to_csv('format+124.csv')