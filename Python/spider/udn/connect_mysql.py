import pymysql
import contextlib
import pandas as pd
from sqlalchemy import create_engine

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

def insert_udn_sql(data):
    sql = "insert ignore into udn_news(title, eye, time) values('{}', {}, '{}');"
    with mysql() as cursor:
        for i in range(len(data["title"])):
            print(sql.format(data["title"][i], data["eye"][i], data["time"][i]))
            cursor.execute(sql.format(data["title"][i], data["eye"][i], data["time"][i]))
        result = cursor.fetchall()
        print(result)

def import_ct_sql(data):
    df = pd.DataFrame(data)
    engine = create_engine("mysql+pymysql://{}:{}@{}/{}?charset={}".format('harold', '123456', '192.168.56.102:3306', 'assignment','utf8'))
    con = engine.connect()#建立連線
    df.to_sql(name='ct_news', con=con, if_exists='fail', index=True)