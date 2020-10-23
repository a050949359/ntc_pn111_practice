from pymongo import MongoClient

def import_udn_mongo(records):
    client = MongoClient('mongodb://192.168.56.105:27017/')
    db = client["assignment"]
    col = db["udn_news"]
    col.insert_many(records)

def change_data_for_mongo(data):
    return_data = []
    
    for i in range(data["title"]):
        return_data.append({"title":data["title"][i],
                            "eye":data["eye"][i],
                            "time":data["time"][i]})

    return return_data

def import_ct_mongo(df):
    client = MongoClient('mongodb://192.168.56.105:27017/')
    db = client["assignment"]
    col = db["ct_news"]
    records = df.to_dict('records') 
    col.insert_many(records)