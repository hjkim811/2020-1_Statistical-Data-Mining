import glob
import pickle
import pandas as pd
import json
import collections
from datetime import timedelta, date


for filepath in glob.iglob('*.csv'):
    df = pd.read_csv(filepath)
    df['date'] = -1

    date_month = 20181101
    hour_range = [700, 800, 1800, 1900]

    for index, row in df.iterrows():
        if row.iloc[0].startswith(' Start'):
            date_month = int(row.iloc[0][9:])
        else:
            date = date_month + int(row.iloc[0]) - 1
            df.at[index, 'date'] = date

    for index, row in df.iterrows():
        if row.iloc[1] not in hour_range:
            df.drop(index, inplace=True)
    df = df.reset_index(drop=True)

    df.to_csv('r_{}'.format(filepath), index=False)
    print(filepath, 'done')


