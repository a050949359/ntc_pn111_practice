from . import scrapying
from . import connect_mysql
from . import connect_mongo

ct_url = "https://www.chinatimes.com/realtimenews/?chdtv"

ct_html = scrapying.request_html(ct_url)
ct_data = scrapying.chinatimes_parser(ct_html)
connect_mysql.import_ct_sql(ct_data)
connect_mongo.import_ct_mongo(ct_data, "ct_news")

udn_url = "https://udn.com/news/breaknews/1"

udn_html = scrapying.request_html(ct_url)
udn_data = scrapying.chinatimes_parser(udn_html)
connect_mysql.insert_udn_sql(udn_data)
# df = connect_mongo.change_data_for_mongo(ct_data)
# connect_mongo.import_udn_mongo(df, "udn_news")