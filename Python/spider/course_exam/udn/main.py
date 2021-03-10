import scrapying
import connect_mysql
import connect_mongo
from pymongo import MongoClient
import pandas as pd
# 讀中時的內容
ct_url = "https://www.chinatimes.com/realtimenews/?chdtv"
ct_html = scrapying.request_html(ct_url)
ct_data = scrapying.chinatimes_parser(ct_html)

# 存入mysql
# connect_mysql.import_ct_sql(ct_data)
# 存入mongodb
connect_mongo.import_ct_mongo(data = ct_data, tname = "ct_news")

# 讀UDN的網頁
udn_url = "https://udn.com/news/breaknews/1"
udn_html = scrapying.request_html(udn_url)
udn_data = scrapying.udn_parser(udn_html)
# 插入資料到mysql
# connect_mysql.insert_udn_sql(udn_data)
# 存入mysql
records = connect_mongo.change_data_for_mongo(udn_data)
connect_mongo.import_udn_mongo(records, "udn_news")