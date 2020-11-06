from newsapi import NewsApiClient
from pymongo import MongoClient
import pandas
import json
import pymysql
import contextlib

# 定義上下文管理器，連線後自動關閉連線
@contextlib.contextmanager
def mysql(host='192.168.56.102', user='harold', passwd='123456', db='assignment'):
    conn = pymysql.connect(host=host, user=user, passwd=passwd, db=db)
    cursor = conn.cursor(cursor=pymysql.cursors.DictCursor)
    try:
        yield cursor
    finally:
        conn.commit()
        cursor.close()
        conn.close()
        
# 先在mysql內建立DB與table，再插入資料
def insert_news_sql(df):
    sql = 'insert ignore into newsapi (sourceId, sourceName, author, title, description, url, urlToImage, publishedAt, content) values ("{}", "{}", "{}", "{}", "{}", "{}", "{}", "{}", "{}")'
    with mysql() as cursor:
        for index,row in df.iterrows():
            print(row["source"]["id"])
            # print(index, sql.format(row["source"]["id"], row["source"]["id"], row["author"], row["title"], row["description"], row["url"], row["urlToImage"], row["publishedAt"].replace('T', ' ').replace('Z',''), row['content']))
            cursor.execute(sql.format(row["source"]["id"], row["source"]["name"], row["author"], row["title"], row["description"], row["url"], row["urlToImage"], row["publishedAt"].replace('T', ' ').replace('Z',''), row['content']))
        result = cursor.fetchall()
        # print(result)

def insert_news_mongo(df):
    client = MongoClient('mongodb://192.168.56.102:27017/')
    db = client["assignment"]
    col = db["newsapi"]
    # print(list(col.find({},{'_id':0,'sum_title':1})))
    json_data = eval(df.to_json(orient='records', force_ascii=False).replace("null","'null'"))
    
    df = pandas.DataFrame(col.find({},{'_id':0,'sum_title':1}))
    
    if df.empty:
        col.insert_many(json_data)
    else:
        for news in json_data:
            if not df['sum_title'].str.contains(news['sum_title']).any():
                col.insert_one(news)

# Init
newsapi = NewsApiClient(api_key='10a72a45c8ec4cdb89dec1a9d289feb3')

# /v2/everything
all_articles = newsapi.get_everything(q='武漢肺炎 AND NOT 外遇',
                                      domains='udn.com,chinatimes.com,storm.mg,ettoday.net',
                                      sort_by='publishedAt',
                                      page_size=100)
articles = all_articles['articles']
# df = pandas.DataFrame(articles)
# # pandas.DataFrame.to_json()
# news_json = df.to_json(orient='records', force_ascii=False)

with open('./exam2.json','w+') as file:
    for i,news in enumerate(articles):
        if i == 0:
            file.write(json.dumps(news, ensure_ascii=False))
        else:
            file.write(',\n' + json.dumps(news, ensure_ascii=False))

with open('./exam2.json') as file:
    json_file = file.read()

df = pandas.read_json('['+json_file+']')
insert_news_sql(df)
insert_news_mongo(df)
