# 用兩種方法轉資料：ct:DataFrame.to_dict('records') & udn:手動轉
from pymongo import MongoClient
import pandas as pd

def change_data_for_mongo(data):
    records = []

    for i in range(len(data["title"])):
        records.append({"title":data["title"][i],
                          "eye":data["eye"][i],
                         "time":data["time"][i]})

    return records
# import 聯合 的資料 
def import_udn_mongo(records, tname):
    client = MongoClient('mongodb://192.168.56.105:27017/')
    db = client["assignment"]
    col = db[tname]
    col.insert_many(records)

# import 中時 的資料 
def import_ct_mongo(data, tname):
    client = MongoClient('mongodb://192.168.56.105:27017/')
    db = client["assignment"]
    col = db["ct_news"]
    df = pd.DataFrame(data)
    records = df.to_dict(orient = 'records') 
    col.insert_many(records)