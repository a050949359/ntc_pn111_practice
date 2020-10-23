import requests
from bs4 import BeautifulSoup 

#"https://udn.com/news/breaknews/1"
#"https://www.chinatimes.com/realtimenews/?chdtv"
def request_html(_url):
    web = requests.get(_url)
    return BeautifulSoup(web.text, "html.parser")

def udn_parser(html):
    news = html.select("section.thumb-news div.story-list__news")

    title_l = []
    eye_l = []
    time_l = []

    for data in news:
        title_l.append(data.select_one("h2 a").text)
        eye_l.append(int(data.select_one("span").text))
        time_l.append(data.select_one("time").text)
        
    return {"title":title_l, "eye":eye_l, "time":time_l}

def chinatimes_parser(html):
    news = html.select("ul.vertical-list div.articlebox-compact")

    title_l = []
    time_l = []
    category_l = []

    for data in news:
        print(data)
        title_l.append(data.select_one("h3 a").text)
        time_l.append(data.find("time")["datetime"])
        category_l.append(data.select_one("div.category a").text)

    return {"title":title_l, "category":category_l, "time":time_l}
    
