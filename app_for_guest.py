from flask import Flask, jsonify, request
import json
import pymongo
from bson.objectid import ObjectId
from datetime import datetime


class MyEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, ObjectId):
            return str(obj)
        return super(MyEncoder, self).default(obj)


app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False
app.config['SECRET_KEY'] = "khoabimat"
app.json_encoder = MyEncoder
app.app_context()

# connect to db
client = pymongo.MongoClient(
    "mongodb+srv://vaccineForThePeople:vaccine@vaccineforthepeople.vodjz.mongodb.net/admin?retryWrites=true&w=majority")
db = client['vaccinePlanningDB']
news_collection = db['news']
sign_collection = db['vaccination_sign']


class News:
    def __init__(self, _id, title, content):
        self._id = _id
        self.title = title
        self.content = content


class Sign:
    def __init__(self, _id, name, birthday, sex, phone, email, cccd, bhxh_id, address, priority_group, vaccine_shots):
        self._id = _id
        self.name = name
        self.birthday = parse_to_date(birthday)
        self.sex = sex
        self.phone = phone
        self.email = email
        self.cccd = cccd
        self.bhxh_id = bhxh_id
        self.address = {'province': address['provine'],
                        'district': address['district'],
                        'ward': address['ward'],
                        'st_no': address['st_no']}
        self.priority_group = priority_group
        self.vaccine_shots = []
        for shot in vaccine_shots:
            temp_shot = {'type_name': shot['type_name'],
                         'shot_num': shot['shot_num'],
                         'shot_date': parse_to_date(shot['shot_date']),
                         'shot_place': shot['shot_place'],
                         'next_shot_expect_time': parse_to_date(shot['next_shot_expect_time'])}
            self.vaccine_shots.append(temp_shot)

    def gen_dict(self):
        return {
                'name': self.name,
                'birth_day': self.birthday,
                'sex': self.sex,
                'phone': self.phone,
                'email': self.email,
                'CCCD': self.cccd,
                'BHXH_id': self.bhxh_id,
                'address': self.address,
                'priority_group': self.priority_group,
                'vaccination_shots': self.vaccine_shots
                }


def parse_to_date(date_json):
    try:
        return datetime.strptime(date_json, "%Y-%m-%d")
    except:
        return False


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
                    priority_group=data['priority_group'], vaccine_shots=data['vaccine_shots'])

    verify = sign_collection.find_one({'name': data['name']})
    if verify is not None:
        return {'result': 'fail',
                'reason': 'You signed in the past'}

    try:
        sign_collection.insert_one(new_sign.gen_dict())
        return {'result': 'success'}
    except Exception as e:
        print(e)
        return {'result': 'fail', 'reason': 'not able to add'}


if __name__ == '__main__':
    app.run()
