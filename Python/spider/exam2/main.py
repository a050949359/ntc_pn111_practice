from newsapi import NewsApiClient
import pandas
import json
# Init
newsapi = NewsApiClient(api_key='10a72a45c8ec4cdb89dec1a9d289feb3')

# /v2/everything
all_articles = newsapi.get_everything(q='武漢肺炎 AND NOT 外遇',
                                      domains='udn.com,chinatimes.com,storm.mg,ettoday.net',
                                      sort_by='publishedAt',
                                      page_size=100)
articles = all_articles['articles']
df = pandas.DataFrame(articles)
df.to_json('./exam2.json')