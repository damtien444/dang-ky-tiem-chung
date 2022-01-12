from vaccine import app, request, ObjectId, Message, mail, url_for, render_template, redirect
from vaccine.model.sign import Sign
from vaccine.controller.service import db
from vaccine.controller.token import confirm_token, generate_confirmation_token


@app.route('/vaccination-sign', methods=['GET', 'POST'])
def insert_sign():
    sign_collection = db['vaccination_sign']
    # data = request.get_json()
    data = sign_collection.find_one({'CCCD': '23456123456'})
    new_sign = Sign(_id=ObjectId, name=data['name'], birthday=data['birth_day'], sex=data['sex'], phone=data['phone'],
                    email=data['email'], cccd=data['CCCD'], bhxh_id=data['BHXH_id'], address=data['address'],
                    priority_group=data['priority_group'], vaccine_shots=data['vaccine_shots'])

    verify = sign_collection.find_one({'CCCD': data['CCCD']})

    token = generate_confirmation_token('yaloto9504@zherben.com')
    email = confirm_token(token)
    print(email)
    if (email == 'yaloto9504@zherben.com'):
        confirm_url = url_for('create_vaccination')
    html = render_template('/activate.html', confirm_url=confirm_url)
    send_email(email, html)

    if verify is not None:
        shot_num_in_db = len(verify['vaccine_shots'])
        vaccine_shots = verify['vaccine_shots']
        fail_result = {'result': 'fail',
                       'reason': 'You signed in the past'}
        if new_sign.vaccine_shots[0]['shot_num'] == '1':
            return fail_result
        elif new_sign.vaccine_shots[1]['shot_num'] == '2' and shot_num_in_db > 1:
            return fail_result
        else:
            # vaccine_shots.append(new_sign.vaccine_shots[0])
            try:
                # sign_collection.find_one_and_update({'CCCD': data['CCCD']}, {"$set": {'vaccine_shots': vaccine_shots}})
                return {'result': 'success'}
            except Exception as e:
                print(e)
                return {'result': 'fail', 'reason': 'not able to add'}

    try:
        # sign_collection.insert_one(new_sign.gen_dict())
        return {'result': 'success'}
    except Exception as e:
        print(e)
        return {'result': 'fail', 'reason': 'not able to add'}


@app.route('/news', methods=['GET'])
def get_news():
    news_collection = db['news']
    result = []
    news_arr = news_collection.find({})
    for news in news_arr:
        result.append(news)

    return {'news': result}


def send_email(to_email, template):
    subject = 'Please confirm your email'
    list_email = [to_email]
    msg = Message(subject, html=template, recipients=list_email)
    mail.send(msg)
