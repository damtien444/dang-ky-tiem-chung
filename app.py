import json
from typing import overload

from flask import Flask, jsonify, request, make_response

from flasgger import swag_from
import pymongo
from bson.objectid import ObjectId
import jwt
import datetime
import uuid
from werkzeug.security import generate_password_hash, check_password_hash
from functools import wraps


# Helper


class MyEncoder(json.JSONEncoder):
    def default(self, obj):
        if isinstance(obj, ObjectId):
            return str(obj)
        return super(MyEncoder, self).default(obj)


def parse_to_date(date_json):
    try:
        return datetime.strptime(date_json, "%Y-%m-%d")
    except:
        return False


# Init config


app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False
app.config['SECRET_KEY'] = "khoabimat"
app.json_encoder = MyEncoder
app.app_context()

# Database Model


client = pymongo.MongoClient(
    "mongodb+srv://vaccineForThePeople:vaccine@vaccineforthepeople.vodjz.mongodb.net/admin?retryWrites=true&w=majority")
db = client['vaccinePlanningDB']
managers = db['manager']
news_collection = db['news']
sign_collection = db['vaccination_sign']


class User:

    def __init__(self, _id, name, hash_password, tittle, username, is_admin, user=None):
        if user is None:
            self._id = _id
            self.name = name
            self.hash_password = hash_password
            self.tittle = tittle
            self.username = username
            self.is_admin = is_admin

        else:
            self._id = user['_id']
            self.name = user['name']
            self.hash_password = user['password']
            try:
                self.tittle = user['tittle']
            except Exception as ignore:
                pass
            self.username = user['username']
            self.is_admin = user['is_admin']

    def gen_dict(self):
        gen_dict = {'_id': self._id,
                    'name': self.name,
                    'password': self.hash_password,
                    'username': self.username,
                    'is_admin': self.is_admin}
        return gen_dict


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


# Decorated functions


def admin_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = None
        current_user = None

        if 'x-access-token' in request.headers:
            token = request.headers['x-access-token']

        if not token:
            return {'result': "fail", 'message': "Token is not found"}

        try:
            data = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
            current_user = managers.find_one({"_id": ObjectId(data['_id'])})

            if not current_user['is_admin']:
                return {'result': 'fail', 'message': 'not enough authority'}

            print(current_user)
        except Exception as ignore:
            print(ignore)
            return {'result': "fail", 'message': "Token is invalid"}

        return f(current_user, *args, **kwargs)

    return decorated


def login_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = None
        current_user = None

        if 'x-access-token' in request.headers:
            token = request.headers['x-access-token']

        if not token:
            return {'result': "fail", 'message': "Token is not found"}

        try:
            data = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])
            current_user = managers.find_one({"_id": ObjectId(data['_id'])})

            print(current_user)
        except Exception as ignore:
            print(ignore)
            return {'result': "fail", 'message': "Token is invalid"}

        return f(current_user, *args, **kwargs)

    return decorated


@app.route('/')
def helloWorld():
    return {'message': 'Đây là API của ứng dụng đăng ký tiêm chủng!'}


# PART ONE:
# Xem danh sách tài khoản, xem 1 tài khoản, tạo tài khoản, nâng cấp tài khoản thành admin và xóa tài khoản


@app.route('/user', methods=['GET'])
@admin_required
def get_all_users(current_user):
    res = {'user': []}
    user = managers.find({})

    for x in user:
        res['user'].append(x)

    return res


@app.route('/user/<user_id>', methods=['GET'])
@admin_required
def get_one_user(current_user, user_id):
    try:
        user = managers.find_one({'_id': ObjectId(user_id)})
        if user:
            return {"result": 'success', "user": user}
        else:
            return {"result": 'fail', 'message': 'Unable to find user'}
    except Exception as e:
        print(e)
        return {"result": 'fail', 'message': 'Unable to find user'}


@app.route('/user', methods=['POST'])
@admin_required
def create_user(current_user):
    is_admin = False

    data = request.get_json()

    hashed_pass = generate_password_hash(data['password'], method='sha256')

    new_user = User(_id=ObjectId(), name=data['name'], hash_password=hashed_pass, tittle=data['tittle'],
                    username=data['username'], is_admin=is_admin)

    verify = managers.find_one({'username': new_user.username})
    if verify is not None:
        print(verify)
        return {'result': 'fail', 'reason': 'username is not unique!'}

    try:
        managers.insert_one(new_user.gen_dict())
        return {'result': 'success', 'user': new_user.gen_dict()}
    except Exception as e:
        print(e)
        return {'result': 'fail', 'reason': 'not able to add'}


@app.route('/user/<user_id>', methods=['PUT'])
@admin_required
def promote_user(current_user, user_id):
    try:
        data = request.get_json()
        if data['is_promote']:
            user = managers.find_one_and_update({'_id': ObjectId(user_id)}, {"$set": {'is_admin': True}})
            user['is_admin'] = True
            if user:
                return {"result": 'success', "user": user}
            else:
                return {"result": 'fail', 'message': 'Unable to find user'}

    except Exception as e:
        print(e)
        return {"result": 'fail', 'message': 'Unable to find user (1)'}


@app.route('/user/<user_id>', methods=['DELETE'])
@admin_required
def delete_user(current_user, user_id):
    try:
        user = managers.find_one_and_delete({'_id': ObjectId(user_id)})
        if user:
            return {"result": 'success', "user_deleted": user}
        else:
            return {"result": 'fail', 'message': 'Unable to find user'}

    except Exception as e:
        print(e)
        return {"result": 'fail', 'message': 'Unable to find user (1)'}


@app.route('/login')
def login():
    auth = request.authorization

    if not auth or not auth.username or not auth.password:
        return make_response('Could not sign in', 401, {'WWW-authenticate': 'Basic realm="Login to use!"'})

    user = managers.find_one({'username': auth.username})

    if not user:
        return make_response('Could not sign in', 401, {'WWW-authenticate': 'Basic realm="Wrong credential!"'})

    if check_password_hash(user['password'], auth.password):
        token = jwt.encode({'_id': str(user['_id']),
                            'exp': datetime.datetime.utcnow() + datetime.timedelta(minutes=30)},
                           app.config['SECRET_KEY'])

        return {'result': 'success', 'token': token}

    return make_response('Could not sign in', 401, {'WWW-authenticate': 'Basic realm="Wrong credential!"'})


# NEWS -------------------------------------------------------

@app.route('/news', methods=['GET'])
def get_news():
    result = []
    try:
        news_arr = news_collection.find({})
        for news in news_arr:
            result.append(news)

        return {'result': 'success', 'news': result}
    except Exception as e:
        print(e)
        return {'result': 'fail'}


#


@app.route('/vaccination-sign', methods=['POST'])
def insert_sign():
    data = request.get_json()
    new_sign = Sign(_id=ObjectId, name=data['name'], birthday=data['birth_day'], sex=data['sex'], phone=data['phone'],
                    email=data['email'], cccd=data['CCCD'], bhxh_id=data['BHXH_id'], address=data['address'],
                    priority_group=data['priority_group'], vaccine_shots=data['vaccine_shots'])

    verify = sign_collection.find_one({'CCCD': data['CCCD']})
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
    app.run(debug=True)
