from vaccine import app
from vaccine.data.getdata import db

@app.route('/news', methods=['GET'])
def get_news():
    news_collection = db['news']
    result = []
    news_arr = news_collection.find({})
    for news in news_arr:
        result.append(news)

    return {'news': result}