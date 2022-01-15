from bson import ObjectId

from vaccine import app, request, Message, mail, url_for, render_template
from vaccine.controller.token import confirm_token, generate_confirmation_token
import time
from vaccine.controller.service import db

# confirm email for sign vaccination
my_token = 0


def confirm_email_sign(email, waiting_time=60):
    global my_token
    token = generate_confirmation_token(email)
    confirmed_url = url_for('confirmed_email', token=token, email=email, _external=True)
    html = render_template('/activate.html', confirmed_url=confirmed_url)
    send_email_sign(email, html)
    while waiting_time:
        if my_token:
            return {'Results': 'Success',
                    'Token': my_token}
        waiting_time -= 1
        time.sleep(1)
    return {'Status': 'Request timeout',
            'Message': 'Please check your email'}


@app.route("/confirmed_email/", methods=['GET'])
def confirmed_email():
    global my_token
    bar = request.args.to_dict()
    token, email = bar['token'], bar['email']
    try:
        if (is_checked(email, token)):
            my_token = token
            return {'Result': 'Success',
                    'Message': f'Confirmed your email: {email}'}
        else:
            return {'Result': 'Warning',
                    'Message': f'This is not your email: {email}'}
    except Exception as e:
        return {'Error': str(e)}


# check confirm email in postman
@app.route("/confirm_email_check", methods=['POST'])
def confirm_email_check():
    global my_token
    data = request.get_json()
    token = generate_confirmation_token(data['email'])
    confirmed_url = url_for('confirmed_email', token=token, email=data['email'], _external=True)
    html = render_template('/activate.html', confirmed_url=confirmed_url)
    send_email_sign(data['email'], html)

    while data['waiting_time']:
        if my_token:
            return {'Results': 'Success',
                    'Token': my_token}
        data['waiting_time'] -= 1
        time.sleep(1)
    return {'Status': 'Request timeout',
            'Message': 'Please check your email'}


# send email
def send_email_sign(to_email, template):
    try:
        subject = 'Please confirm your email'
        list_email = [to_email]
        msg = Message(subject, html=template, recipients=list_email)
        mail.send(msg)
    except Exception as e:
        return {'Error': str(e)}


# check token email
def is_checked(email, token):
    email_truth = confirm_token(token)
    if email_truth == email:
        return True
    else:
        return False


def send_email_vaccination_campaign(person: dict,
                                    date_start: str,
                                    date_end: str,
                                    place: str,
                                    vaccine_type: str):
    try:
        to_email = person['email']
        name = person['name']
        cccd = person['CCCD']
        address = person['address']
    except Exception as e:
        return str(e)

    subject = f'Thư mời tiêm vaccine '
    content = f''' Kính mời {"ông" if person["sex"] else "bà"} {name}\n
                    - CCCD: {cccd}\n
                    - Địa chỉ: {address}\n
                    Vào lúc {date_start} đến {date_end} tại {place} để tham gia tiêm vaccine {vaccine_type}'''
    msg = Message(subject, recipients=to_email)
    msg.body = content
    mail.send(msg)


def send_email_confirm_vaccination_campaign(campaign: dict):
    sign = db['vaccination_sign']
    dict_people = campaign['list_of_people']
    log = {'_id': [],
           'date_start': [],
           'date_end': [],
           'place': [],
           'vaccine_type': []}
    try:
        if dict_people:
            date_start, date_end, place, vaccine_type = '', '', '', ''

            # check place
            try:
                place = campaign['date_place']
                if place:
                    log['place'].append(place)
                else:
                    log['place'].append('Can not find place')
            except:
                log['place'].append({'Error!': 'place'})

            # check date start
            try:
                date_start = campaign['date_start']
                if date_start:
                    log['date_start'].append(date_start)
                else:
                    log['date_start'].append('Can not find date start')
            except:
                log['date_start'].append({'Error!': 'date_start'})

            # check date end
            try:
                date_end = campaign['date_end']
                if date_end:
                    log['date_end'].append(date_end)
                else:
                    log['date_end'].append('Can not find date end')
            except:
                log['date_end'].append({'Error!': 'date_end'})

            # check vaccine type
            try:
                vaccine_type = campaign['type_of_people']['vaccine_type']
                if vaccine_type:
                    log['vaccine_type'].append(vaccine_type)
                else:
                    log['vaccine_type'].append('Can not find date end')
            except:
                log['vaccine_type'].append({'Error!': 'vaccine_type'})

            for position in range(len(dict_people)):
                person_signed = None
                # check person id
                try:
                    person_signed = sign.find_one({'_id': dict_people[position]['_id']})
                    if person_signed:
                        log['_id'].append(person_signed['_id'])
                        try:
                            error = send_email_vaccination_campaign(person_signed, date_start, date_end, place, vaccine_type)
                        except:
                            return {'Error': f'Error send email : {error}'}
                    else:
                        log['_id'].append(f'Can not find person {dict_people[position]["_id"]}')
                except:
                    log['_id'].append({'Error!': 'person_signed'})


        else:
            log = 'Do not have any person in this campaign'
        return {'Result': log}
    except:
        return {'Error': log}
