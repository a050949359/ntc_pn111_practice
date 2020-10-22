import pandas as pd
import pandas.util.testing
# print(pd.__version__)

dict1 = {
    "col1": [1, 2, 3],
    "col2": [10, 20, 30],
    "col3": list('xyz'),
    "col4": ['a', 'b', 'c'],
    "col5": pd.Series(range(3))
}

df = pd.DataFrame(dict1)

rename_dict = {'col1':'x', 'col2':'y'}
dfNewName1 = df.rename(rename_dict, axis=1)
# print(dfNewName1)

df.columns = ['a', 'b'] + list(df.columns[2:])
# print(df)

testDf = pd.util.testing.makeDataFrame()
# makeMixedDataFrame, makeMissingDataFrame, makeTimeDataFrame
# print(testDf)

# copy data to clipboard
df = pd.read_clipboard()
# print(df)
df.to_csv("first_save.csv")

# read data from online
df = pd.read_csv('http://bit.ly/kaggletrain')
# print(df.head())