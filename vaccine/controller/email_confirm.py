from bson import ObjectId

from vaccine import app, request, Message, mail, url_for, render_template, redirect
from vaccine.controller.token import confirm_token, generate_confirmation_token
import time
from vaccine.controller.service import db
from vaccine.model.email_sign import email_sign

# confirm email for sign vaccination
my_token = 0

email_confirm = db['email_confirm']
sign_collection = db['vaccination_sign']


def confirm_email_sign(email):
    global my_token
    token = generate_confirmation_token(email)
    confirmed_url = url_for('confirmed_email', token=token, email=email, _external=True)
    html = render_template('/activate.html', confirmed_url=confirmed_url)
    send_email_sign(email, html)

    # save email register to database
    current_email = email_sign(email=email, status=False)
    email_confirm.insert_one(current_email.to_dict())

    return 'Please check your email'


@app.route("/confirmed_email/", methods=['GET'])
def confirmed_email():
    global my_token

    bar = request.args.to_dict()
    token, email = bar['token'], bar['email']
    try:
        if (is_checked(email, token)):
            current_email = email_confirm.find_one_and_update({'email': email,
                                                               'status': False},
                                                              {'$set': {'status': True}})
            sign_collection.find_one_and_update({'email': email},
                                                {'$set': {'confirm_email': True}})
            if current_email:
                return redirect(url_for('helloWorld'))
            else:
                return {'Message': f'Can not find your email: {email} in database! please contact to admin to response'}
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

    # save email register to database
    current_email = email_sign(email=data['email'], status=False)
    email_confirm.insert_one(current_email.to_dict())

    return {'Status': 'Send succeed',
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
    msg = Message(subject, recipients=[to_email])
    msg.body = content
    mail.send(msg)


def send_email_confirm_report(name, content, date_created, email, id):
    subject = f'Confirm your report'
    content = f''' \tMời ông/bà {name}\n
                Đã gửi một phàn hồi đến hệ thống tiêm chủng nội dung như sau:\n
                \t {content}\n
                Gửi lúc {str(date_created)}.\n
                Ông/bà vui lòng bấm đường link sau để xác nhận địa chỉ email của ông bà là đúng để nhận phản hồi của cơ quan có thẩm quyền\n
                http://vaccine-for-the-people.herokuapp.com/report-public/{str(id)} \n
                Trân trọng cảm ơn!'''

    msg = Message(subject, recipients=[email])
    msg.body = content
    mail.send(msg)


def send_email_announce_response_report(name, content, email, response):
    subject = f'Announce that your problem has been solve'
    content = f''' Kính gửi ông/bà {name}\n
                Đã gửi một phản hồi đến hệ thống tiêm chủng nội dung như sau:\n
                \t {content}\n
                Cơ quan quản lý tiêm chủng phản hồi như sau:\n
                \t {response}
                Trân trọng cảm ơn!'''

    msg = Message(subject, recipients=[email])
    msg.body = content
    mail.send(msg)

def send_email_delete_campaign(person: dict,
                               date_start: str,
                               date_end: str,
                               place: str,
                               vaccine_type: str,
                               reason: str = ''):
    try:
        to_email = person['email']
        name = person['name']
        cccd = person['CCCD']
        address = person['address']
    except Exception as e:
        return str(e)

    subject = f'Thông báo hủy đợt tiêm chủng đến {"ông" if person["sex"] else "bà"} {name}'
    content = f''' Kính gửi t đang {"ông" if person["sex"] else "bà"} {name}\n
                    - CCCD: {cccd}\n
                    - Địa chỉ: {address}\n
                   Vì {reason} nên chúng tôi xin hủy đợt tiêm vaccine {vaccine_type} từ {date_start} đến {date_end} tại {place}\n
                   Chúng tôi chân thành xin lỗi vì bất tiện này'''
    msg = Message(subject, recipients=[to_email])
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
                    person_signed = sign.find_one({'_id': ObjectId(dict_people[position]['_id'])})
                    if person_signed:
                        log['_id'].append(person_signed['_id'])
                        try:
                            error = send_email_vaccination_campaign(person_signed, date_start, date_end, place,
                                                                    vaccine_type)
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


def send_email_notification_delete_campaign(campaign: dict):
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
                    person_signed = sign.find_one({'_id': ObjectId(dict_people[position]['_id'])})
                    if person_signed:
                        log['_id'].append(person_signed['_id'])

                        # TODO xóa mũi dự tiêm hiện tại và cập nhập thông tin mũi tiêm dự kiến

                        # gửi mail xác nhận
                        try:
                            error = send_email_delete_campaign(person_signed, date_start, date_end, place,
                                                               vaccine_type)
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
