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
    confirmed_url = url_for('confirmed_email', token=token, _external=True)
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
    email = confirm_token(bar['token'])
    check_mail = email_confirm.find_one({'email': email})
    try:
        if (check_mail):
            current_email = email_confirm.find_one_and_update({'email': email,
                                                               'status': False},
                                                              {'$set': {'status': True}})
            sign_collection.find_one_and_update({'email': email},
                                                {'$set': {'confirm_email': True}})
            if current_email:
                return redirect(url_for('checked'))
            else:
                return {'Message': f'Can not find your email: {email} in database! please contact to admin to response'}
        else:
            return {'Result': 'Warning',
                    'Message': f'This is not your email: {email}'}
    except Exception as e:
        return {'Error': str(e)}


@app.route("/confirmed_email/checked")
def checked():
    return 'You have been successfully validated!'


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


def send_email_vaccination_campaign(person: dict,
                                    date_start: str,
                                    date_end: str,
                                    place: str,
                                    vaccine_type: str):
    province, district, ward, st_no = None, None, None, None

    try:
        to_email = person['email']
        name = person['name']
        cccd = person['CCCD']
        address = person['address']
        try:
            province = address['province']
        except:
            pass
        try:
            district = address['district']
        except:
            pass
        try:
            ward = address['ward']
        except:
            pass

        try:
            st_no = address['st_no']
        except:
            pass

    except Exception as e:
        return str(e)

    subject = f'Th?? m???i ti??m vaccine '
    content = f''' K??nh m???i {"??ng" if person["sex"] else "b??"} {name}\n
                    - CCCD: {cccd}\n
                    - ?????a ch???: '''f'{st_no if st_no is not None else ""}, ' + f'{ward if ward is not None else ""}, ' \
              + f'{district if district is not None else ""}, ' + f'{province if province is not None else ""}' + f'''\n 
                    V??o l??c {date_start} ?????n {date_end} t???i {place} ????? tham gia ti??m vaccine {vaccine_type}'''
    msg = Message(subject, recipients=[to_email])
    msg.body = content
    mail.send(msg)


def send_email_confirm_report(name, content, date_created, email, id):
    subject = f'Confirm your report'
    content = f''' \tM???i ??ng/b?? {name}\n
                ???? g???i m???t ph??n h???i ?????n h??? th???ng ti??m ch???ng n???i dung nh?? sau:\n
                \t {content}\n
                G???i l??c {str(date_created)}.\n
                ??ng/b?? vui l??ng b???m ???????ng link sau ????? x??c nh???n ?????a ch??? email c???a ??ng b?? l?? ????ng ????? nh???n ph???n h???i c???a c?? quan c?? th???m quy???n\n
                http://vaccine-for-the-people.herokuapp.com/report-public/{str(id)} \n
                Tr??n tr???ng c???m ??n!'''

    msg = Message(subject, recipients=[email])
    msg.body = content
    mail.send(msg)


def send_email_announce_response_report(name, content, email, response):
    subject = f'Announce that your problem has been solve'
    content = f''' K??nh g???i ??ng/b?? {name}\n
                ???? g???i m???t ph???n h???i ?????n h??? th???ng ti??m ch???ng n???i dung nh?? sau:\n
                \t {content}\n
                C?? quan qu???n l?? ti??m ch???ng ph???n h???i nh?? sau:\n
                \t {response}
                Tr??n tr???ng c???m ??n!'''

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

    subject = f'Th??ng b??o h???y ?????t ti??m ch???ng ?????n {"??ng" if person["sex"] else "b??"} {name}'
    content = f''' K??nh g???i t ??ang {"??ng" if person["sex"] else "b??"} {name}\n
                    - CCCD: {cccd}\n
                    - ?????a ch???: {address}\n
                   V?? {reason} n??n ch??ng t??i xin h???y ?????t ti??m vaccine {vaccine_type} t??? {date_start} ?????n {date_end} t???i {place}\n
                   Ch??ng t??i ch??n th??nh xin l???i v?? b???t ti???n n??y'''
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

                        # TODO x??a m??i d??? ti??m hi???n t???i v?? c???p nh???p th??ng tin m??i ti??m d??? ki???n

                        # g???i mail x??c nh???n
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
