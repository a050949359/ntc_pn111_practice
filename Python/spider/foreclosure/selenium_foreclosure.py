from selenium import webdriver
from selenium.webdriver.support.ui import Select
from sqlalchemy import create_engine
from datetime import date
import pandas as pd
import time
from pymongo import MongoClient

def getTodayStr():
    today = date.today()
    year = today.strftime("%Y")
    year = int(year)- 1911
    return str(year) + today.strftime("%m%d")

def import_foreclosure_sql(df):
    engine = create_engine("mysql+pymysql://{}:{}@{}/{}?charset={}".format('harold', '123456', '192.168.56.102:3306', 'assignment','utf8'))
    con = engine.connect()#建立連線
    df.to_sql(name='foreclosure', con=con, if_exists='replace', index=False)

def import_foreclosure_mongol(df):
    client = MongoClient('mongodb://192.168.56.105:27017/')
    db = client["assignment"]
    col = db["foreclosure"]
    records = df.to_dict('records') 
    col.insert_many(records)

url = "https://www2.bot.com.tw/house/default.aspx"

driver = webdriver.Chrome(executable_path="/Users/hou-yehchen/Documents/ntc_pn111_practice/Python/spider/foreclosure/chromedriver")
driver.get(url)

input_fromdate = driver.find_element_by_css_selector("#fromdate_TextBox")
input_fromdate.clear()
input_fromdate.send_keys("880101")
time.sleep(1)

input_todate = driver.find_element_by_css_selector("#todate_TextBox")
input_todate.clear()
input_todate.send_keys(getTodayStr())
time.sleep(1)

select_pagecount = driver.find_element_by_css_selector("#PageCount_DDL")
Select(select_pagecount).select_by_value("100")
time.sleep(1)

driver.find_element_by_css_selector("#Submit_Button").click()
time.sleep(10)

df = pd.read_html(driver.page_source)
data = df[1][['管理編號', '拍賣日期', '門　牌', '用途', '拍賣總價', '執行法院', '拍賣次數']]
data.columns = ['管理編號', '拍賣日期', '門牌', '用途', '拍賣總價', '執行法院', '拍賣次數']

import_foreclosure_sql(data)
import_foreclosure_mongol(data)