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
from model.user import User
from service import mongo_db_connection as conn
from model.my_encoder import MyEncoder


# class MyEncoder(json.JSONEncoder):
#     def default(self, obj):
#         if isinstance(obj, ObjectId):
#             return str(obj)
#         return super(MyEncoder, self).default(obj)


app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False
app.config['SECRET_KEY'] = "khoabimat"
app.json_encoder = MyEncoder
app.app_context()


db = conn.get_db('vaccinePlanningDB')
managers = db['manager']


# class User:
#
#     def __init__(self, _id, name, hash_password, tittle, username, is_admin, user=None):
#         if user is None:
#             self._id = _id
#             self.name = name
#             self.hash_password = hash_password
#             self.tittle = tittle
#             self.username = username
#             self.is_admin = is_admin
#
#         else:
#             self._id = user['_id']
#             self.name = user['name']
#             self.hash_password = user['password']
#             try:
#                 self.tittle = user['tittle']
#             except Exception as ignore:
#                 pass
#             self.username = user['username']
#             self.is_admin = user['is_admin']
#
#     def gen_dict(self):
#         gen_dict = {'_id': self._id,
#                     'name': self.name,
#                     'password': self.hash_password,
#                     'username': self.username,
#                     'is_admin': self.is_admin}
#         return gen_dict


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

# TODO: user_require


@app.route('/')
def helloWorld():
    return {'message': 'Đây là API của ứng dụng đăng ký tiêm chủng!'}


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

        return {'token': token}

    return make_response('Could not sign in', 401, {'WWW-authenticate': 'Basic realm="Wrong credential!"'})


if __name__ == '__main__':
    app.run()
