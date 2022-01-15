from vaccine import app, request, ObjectId, Message, mail, url_for, render_template, redirect
from vaccine.model.sign import Sign
from vaccine.controller.service import db
from vaccine.controller.token import confirm_token, generate_confirmation_token
from datetime import datetime


@app.route('/vaccination-sign', methods=['POST'])
def insert_vaccination_sign():
    sign_collection = db['vaccination_sign']
    data = request.get_json()
    shot = data['order_shot']
    check = True
    fail_result_signed = {'result': 'fail', 'reason': 'You signed in the past'}
    fail_result_cannot_add = {'result': 'fail', 'reason': 'not able to add'}

    if shot == 1:
        new_sign = Sign(_id=ObjectId, name=data['name'], birthday=data['birth_day'], sex=data['sex'],
                        phone=data['phone'], email=data['email'], cccd=data['CCCD'], bhxh_id=data['BHXH_id'],
                        address=data['address'], priority_group=data['priority_group'],
                        illness_history=data['illness_history'], user_expected_shot_date=data['expected_shot_date'])
        verify = sign_collection.find_one({'CCCD': data['CCCD']})
        if verify is not None:
            return fail_result_signed
        else:
            try:
                sign_collection.insert_one(new_sign.gen_dict())
                confirm_email(data['email'])
                return {'result': 'success'}
            except Exception as e:
                print(e)
                return fail_result_cannot_add
    elif shot == 2:
        first_shot_json = data['first_shot']
        first_shot = {"type_name": first_shot_json['type_name'],
                      "shot_num": 1,
                      "shot_date": datetime.strptime(first_shot_json['shot_date'], "%Y-%m-%d"),
                      "shot_place": first_shot_json['shot_place'],
                      "status": "not_trusted"}
        new_sign = Sign(_id=ObjectId, name=data['name'], birthday=data['birth_day'], sex=data['sex'],
                        phone=data['phone'], email=data['email'], cccd=data['CCCD'], bhxh_id=data['BHXH_id'],
                        address=data['address'], priority_group=data['priority_group'], first_shot=first_shot,
                        illness_history=data['illness_history'], user_expected_shot_date=data['expected_shot_date'])

        verify = sign_collection.find_one({'CCCD': data['CCCD']})
        if verify is not None:
            vaccine_shots = verify['vaccine_shots']
            for vaccine_shot in vaccine_shots:
                if vaccine_shot['shot_num'] == 1 and vaccine_shot['status'] == 'not_trusted':
                    check = False
                    return fail_result_signed
            if check:
                vaccine_shots.append(first_shot)
                try:
                    sign_collection.find_one_and_update({'CCCD': data['CCCD']},
                                                        {"$set": {'vaccine_shots': vaccine_shots}})
                    sign_collection.find_one_and_update({'CCCD': data['CCCD']},
                                                    {"$set": {'user_expected_shot_date': data['expected_shot_date']}})
                    confirm_email(data['email'])
                    return {'result': 'success'}
                except Exception as e:
                    print(e)
                    return fail_result_cannot_add
        else:
            try:
                sign_collection.insert_one(new_sign.gen_dict())
                confirm_email(data['email'])
                return {'result': 'success'}
            except Exception as e:
                print(e)
                return fail_result_cannot_add


def confirm_email(email):
    token = generate_confirmation_token(email)
    email_confirm = confirm_token(token)
    print(email_confirm)
    if email_confirm == email:
        confirm_url = url_for('create_vaccination')
    html = render_template('/activate.html', confirm_url=confirm_url)
    send_email_sign(email, html)


def send_email_sign(to_email, template):
    subject = 'Please confirm your email'
    list_email = [to_email]
    msg = Message(subject, html=template, recipients=list_email)
    mail.send(msg)