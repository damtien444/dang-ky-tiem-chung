from flask import request, make_response

from vaccine import app
from vaccine.model.agregation_pipeline import match_area, sort_order, \
    by_group_distribution, by_age_distribution, by_sex_distribution
from vaccine.controller.service import db
from bson.objectid import ObjectId
import jwt
import datetime
from werkzeug.security import generate_password_hash, check_password_hash
from functools import wraps
from model.user import User

# db = conn.get_db('vaccinePlanningDB')
managers = db['manager']
sign = db['vaccination_sign']


def admin_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        token = None
        current_user = None

        if 'x-access-token' in request.headers:
            token = request.headers['x-access-token']

        if not token:
            return {'result': "fail", 'message': "Token is not found"}, 401

        try:
            data = jwt.decode(token, app.config['SECRET_KEY'], algorithms=['HS256'])

            current_user = managers.find_one({"_id": ObjectId(data['_id'])})

            if not current_user['is_admin']:
                return {'result': 'fail', 'message': 'not enough authority'}, 401

            print(current_user)

        except Exception as ignore:
            print(ignore)
            return {'result': "fail", 'message': "Token is invalid"}, 401

        return f(current_user, *args, **kwargs)

    return decorated


# TODO: user_require


@app.route('/')
def helloWorld():
    return {'message': 'Đây là API của ứng dụng đăng ký tiêm chủng!'}


@app.route('/user', methods=['GET'])
@admin_required
def get_all_users(current_user):
    try:
        res = {'user': []}
        user = managers.find({})

        for x in user:
            res['user'].append(x)

        return {"result": 'success', "users": res}

    except Exception as e:
        print(e)
        return {"result": 'fail', 'message': 'Unable to find user'}, 400


@app.route('/user/<user_id>', methods=['GET'])
@admin_required
def get_one_user(current_user, user_id):
    try:
        user = managers.find_one({'_id': ObjectId(user_id)})
        if user:
            return {"result": 'success', "user": user}
        else:
            return {"result": 'fail', 'message': 'Unable to find user'}, 400
    except Exception as e:
        print(e)
        return {"result": 'fail', 'message': 'Unable to find user'}, 400


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
        return {'result': 'fail', 'reason': 'username is not unique!'}, 400

    try:
        managers.insert_one(new_user.gen_dict())
        return {'result': 'success', 'user': new_user.gen_dict()}
    except Exception as e:
        print(e)
        return {'result': 'fail', 'reason': 'not able to add'}, 400


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
                return {"result": 'fail', 'message': 'Unable to find user'}, 400

    except Exception as e:
        print(e)
        return {"result": 'fail', 'message': 'Unable to find user (1)'}, 400


@app.route('/user/<user_id>', methods=['DELETE'])
@admin_required
def delete_user(current_user, user_id):
    try:
        user = managers.find_one_and_delete({'_id': ObjectId(user_id)})
        if user:
            return {"result": 'success', "user_deleted": user}
        else:
            return {"result": 'fail', 'message': 'Unable to find user'}, 400

    except Exception as e:
        print(e)
        return {"result": 'fail', 'message': 'Unable to find user (1)'}, 400


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
                            'exp': datetime.datetime.utcnow() + datetime.timedelta(minutes=120)},
                           app.config['SECRET_KEY'])

        return {'token': token}

    return make_response('Could not sign in', 401, {'WWW-authenticate': 'Basic realm="Wrong credential!"'})




if __name__ == '__main__':
    app.run()
