from pymongo import MongoClient

def change_data_for_mongo(data):
    records = []
    
    for i in range(data["title"]):
        records.append({"title":data["title"][i],
                          "eye":data["eye"][i],
                         "time":data["time"][i]})

    return records

def import_udn_mongo(records, tname):
    client = MongoClient('mongodb://192.168.56.105:27017/')
    db = client["assignment"]
    col = db[tname]
    col.insert_many(records)

def import_ct_mongo(df, tname):
    client = MongoClient('mongodb://192.168.56.105:27017/')
    db = client["assignment"]
    col = db[tname]
    records = df.to_dict('records') 
    col.insert_many(records)