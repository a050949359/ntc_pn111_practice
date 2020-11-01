import requests
from bs4 import BeautifulSoup
import pandas as pd
import time

def get_news_content(url):
    html = requests.get(url)
    soup = BeautifulSoup(html.text, 'html.parser')
    return soup.select_one('div.content div.indent')
    

def extract_p_strong(content):
    for tag in content.findAll(['p','h3']):
        if(tag.name == 'p'):         
            for strong in tag.findAll('strong'):
                strong.extract()

def get_sum_file_name(df, i):
    return './'+'sum_'+df['category'][i]+'_'+str.replace(df['sum_title'][i][0:4], " ", "_")+'.txt'

def get_spot_file_name(df, i, j):
    return './'+'spot_'+df['category'][i]+'_'+str.replace(df['spotlist'][i][j]['title'][0:4], " ", "_")+'.txt'

def write_to_file(file_name):
    with open(file_name, 'w') as file:
        for tag in content.findAll(['p','h3']):
            file.write(tag.text+'\n')

df = pd.read_json('./exam1_1.json')

for i,url in enumerate(df['sum_title_url']):
    time.sleep(2)
    content = get_news_content(url)
    extract_p_strong(content)
    
    file_name = get_sum_file_name(df, i)
    print('write news to',file_name)
    write_to_file(file_name)

for i,spotlist in enumerate(df['spotlist']):
    for j,spot in enumerate(spotlist):
        time.sleep(2)
        content = get_news_content(spot['url'])
        extract_p_strong(content)
        
        file_name = get_spot_file_name(df, i, j)
        print('write news to',file_name)
        write_to_file(file_name)
    