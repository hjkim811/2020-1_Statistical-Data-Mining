import glob
import pickle
import pandas as pd
import json
import collections
from datetime import datetime


main = pd.read_csv('format_final_n.csv', index_col=0, engine='python')
main['check'] = -999
main.to_csv('format_final_n_check.csv')

exit()


n_mise = 0
empty_date = []
empty_num = [0]*13

for index, row in main.iterrows():
    if row['미세먼지'] == -999:
        date = row['일자']
        if date == 20181117:
            empty_num[0] = empty_num[0] + 1
        elif date == 20181118:
            empty_num[1] = empty_num[1] + 1
        elif date == 20190309:
            empty_num[2] = empty_num[2] + 1
        elif date == 20190310:
            empty_num[3] = empty_num[3] + 1
        elif date == 20190311:
            empty_num[4] = empty_num[4] + 1
        elif date == 20190312:
            empty_num[5] = empty_num[5] + 1
        elif date == 20190313:
            empty_num[6] = empty_num[6] + 1
        elif date == 20190316:
            empty_num[7] = empty_num[7] + 1
        elif date == 20190317:
            empty_num[8] = empty_num[8] + 1
        elif date == 20190907:
            empty_num[9] = empty_num[9] + 1
        elif date == 20190908:
            empty_num[10] = empty_num[10] + 1
        elif date == 20191009:
            empty_num[11] = empty_num[11] + 1
        elif date == 20191010:
            empty_num[12] = empty_num[12] + 1


print(empty_num)


