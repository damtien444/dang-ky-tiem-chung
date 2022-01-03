from vaccine import app, request, make_response, render_template, redirect, url_for
import jwt
import datetime
from vaccine.controller.service import db
from werkzeug.security import generate_password_hash, check_password_hash

@app.route('/login')
def login():
    managers = db['manager']
    auth = request.authorization

    if not auth or not auth.username or not auth.password:
        return make_response('Could not sign in', 401, {'WWW-authenticate': 'Basic realm="Login to use!"'})

    user = managers.find_one({'username': auth.username})

    if not user:
        # return make_response('Could not sign in', 401, {'WWW-authenticate': 'Basic realm="Wrong credential!"'})
        return render_template('base_admin.html')
    # if user.check_password_hash(auth.password):
    if  check_password_hash(user['password'], auth.password):
        token = jwt.encode({'_id': str(user['_id']),
                            'exp': datetime.datetime.utcnow() + datetime.timedelta(minutes=30)},
                           app.config['SECRET_KEY'])

        return {'token': token}

    return make_response('Could not sign in', 401, {'WWW-authenticate': 'Basic realm="Wrong credential!"'})


@app.route('/logout')
def logout():
    return redirect(url_for("home_page"))