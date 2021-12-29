from flask import Flask, jsonify, request
from bson.objectid import ObjectId
from model.sign import Sign
from service import mongo_db_connection as conn
from model.my_encoder import MyEncoder


app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False
app.config['SECRET_KEY'] = "khoabimat"
app.json_encoder = MyEncoder
app.app_context()

# connect to db
db = conn.get_db('vaccinePlanningDB')
news_collection = db['news']
sign_collection = db['vaccination_sign']


@app.route('/news', methods=['GET'])
def get_news():
    result = []
    news_arr = news_collection.find({})
    for news in news_arr:
        result.append(news)

    return {'news': result}


@app.route('/vaccination-sign', methods=['POST'])
def insert_sign():
    data = request.get_json()
    new_sign = Sign(_id=ObjectId, name=data['name'], birthday=data['birth_day'], sex=data['sex'], phone=data['phone'],
                    email=data['email'], cccd=data['CCCD'], bhxh_id=data['BHXH_id'], address=data['address'],
                    priority_group=data['priority_group'], vaccine_shot=data['vaccine_shot'])

    verify = sign_collection.find_one({'CCCD': data['CCCD']})
    if verify is not None:
        shot_num_in_db = len(verify['vaccine_shots'])
        vaccine_shots = verify['vaccine_shots']
        fail_result = {'result': 'fail',
                       'reason': 'You signed in the past'}
        if new_sign.vaccine_shot['shot_num'] == '1':
            return fail_result
        elif new_sign.vaccine_shot['shot_num'] == '2' and shot_num_in_db > 1:
            return fail_result
        else:
            vaccine_shots.append(new_sign.vaccine_shots[0])
            try:
                sign_collection.find_one_and_update({'CCCD': data['CCCD']}, {"$set": {'vaccine_shots': vaccine_shots}})
                return {'result': 'success'}
            except Exception as e:
                print(e)
                return {'result': 'fail', 'reason': 'not able to add'}

    try:
        sign_collection.insert_one(new_sign.gen_dict())
        return {'result': 'success'}
    except Exception as e:
        print(e)
        return {'result': 'fail', 'reason': 'not able to add'}


if __name__ == '__main__':
    app.run()
