from flask_cors import CORS

from vaccine.model.my_encoder import MyEncoder
from flask import Flask, request, make_response, render_template, redirect, url_for
from bson.objectid import ObjectId
from flask_mail import Mail, Message

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False
app.config['SECRET_KEY'] = 'f1f3e2e6c48a0be22183dad6'  # os.urandom(12).hex()
app.json_encoder = MyEncoder

app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USERNAME'] = 'luongbui711277@gmail.com'
app.config['MAIL_PASSWORD'] = ''
app.config['MAIL_DEFAULT_SENDER'] = 'luongbui711277@gmail.com'
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USE_SSL'] = False
app.config['DEBUG'] = True
app.config['SECURITY_PASSWORD_SALT'] = '1bf82d1c4d517b98b32ed229'
mail = Mail(app)
CORS(app)

from vaccine.controller.app_test import admin_required
from vaccine.controller import app_test
from vaccine.controller import home, vaccination_sign, confirm_vaccination, create_vaccination, statistic, app_test


