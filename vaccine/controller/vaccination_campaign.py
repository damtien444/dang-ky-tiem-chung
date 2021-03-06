from datetime import datetime
from bson import ObjectId
from pymongo import UpdateOne

from vaccine import app, request, admin_required
from vaccine.controller.email_confirm import send_email_confirm_vaccination_campaign, \
    send_email_notification_delete_campaign
from vaccine.controller.service import db
from vaccine.model.agregation_pipeline import create_list_people_in_campaign
from vaccine.model.campaign import Campaign

sign = db['vaccination_sign']
campaign = db['shot_campaign']


@app.route('/campaign-preview', methods=['POST'])
def create_campaign_preview():
    try:
        log = []
        valid = True

        data = request.get_json()

        city = None
        try:
            address = data['address']
            city = address['province']
        except Exception as e:
            valid = False
            log.append("address.province is a require argument!")

        district = None
        ward = None
        try:
            if address['district'] is not None:
                district = address['district']
            if address['ward'] is not None:
                ward = address['ward']
        except Exception as ignore:
            pass

        age_range = None
        try:
            age_range = data['age_range']
        except Exception as e:
            log.append("NO age_range")

        priority_type = None
        try:
            priority_type = data['priority_type']
        except Exception as e:
            log.append("NO priority")

        start, end, date_of_shot = None, None, None
        try:
            date_of_shot = data['date_of_shot']
            start = date_of_shot['start_date']
            end = date_of_shot['end_date']
        except Exception as e:
            valid = False
            log.append("Date_of_shot is a require argument!")

        illness_history = None
        try:
            illness_history = data['illness_history']
        except Exception as e:
            log.append("no illness_history was given")

        vaccine_type = None
        try:
            vaccine_type = data['vaccine_type']
        except Exception as e:
            valid = False
            log.append("Vaccine_type is a require argument")

        if not valid:
            return {'result': "fail", 'log': log}, 400
        else:

            # DONE: t???o aggregation ????? t???o danh s??ch ?????t ti??m nh??p
            # adapt ???????c 5 lo???i bi???n, (3 bi???n required - khu v???c, th???i gian expect, lo???i m??i ti??m)
            start_date = parse_to_date(start)
            end_date = parse_to_date(end)
            if age_range is not None:
                min_age, max_age = age_range.split("-")

                draft = sign.aggregate(create_list_people_in_campaign(start_date, end_date, vaccine_type, city,
                                                                      district, ward, min_age=int(min_age),
                                                                      max_age=int(max_age),
                                                                      priority_type=priority_type,
                                                                      illness_history=illness_history))
                print(create_list_people_in_campaign(start_date, end_date, vaccine_type, city,
                                                     district, ward, min_age=int(min_age),
                                                     max_age=int(max_age),
                                                     priority_type=priority_type,
                                                     illness_history=illness_history))



            else:
                draft = sign.aggregate(create_list_people_in_campaign(start_date, end_date, vaccine_type, city,
                                                                      district, ward,
                                                                      priority_type=priority_type,
                                                                      illness_history=illness_history))
                print(create_list_people_in_campaign(start_date, end_date, vaccine_type, city,
                                                     district, ward,
                                                     priority_type=priority_type,
                                                     illness_history=illness_history))

            # DONE: ????ng k?? ?????t ti??m nh??p l??n campaign collection

            list_of_people = []
            for thing in draft:
                list_of_people.append(thing)

            _object = {
                'address': address,
                'date_of_shot_expect': date_of_shot,
                'next_vaccine_type': vaccine_type,
                'priority_group': priority_type,
                'age_range': age_range
            }

            # campaign_draft = Campaign(name, list_of_people, start_date, end_date, vaccine_type, place, _object, False)

            # result = campaign.insert_one(campaign_draft.to_json())

            # Done: tr??? l???i id ?????t ti??m nh??p ???? tao c??ng danh s??ch c???a ?????t ti??m
            return {'result': 'success', 'list': list_of_people,
                    'count': len(list_of_people), 'log': log}, 200

    except Exception as e:
        print(e)
        return {'result': 'fail', 'message': 'not able to create new campaign'}, 400


# Ti???n
# campaign/ POST
# TODO: create campaign
@app.route('/campaign', methods=['POST'])
# @admin_required
def create_campaign():
    try:

        log = []
        valid = True

        data = request.get_json()

        city = None
        try:
            address = data['address']
            city = address['province']
        except Exception as e:
            valid = False
            log.append("address.province is a require argument!")

        district = None
        ward = None
        try:
            if address['district'] is not None:
                district = address['district']
            if address['ward'] is not None:
                ward = address['ward']
        except Exception as ignore:
            pass

        name = None
        try:
            name = data['name']
        except Exception as e:
            log.append("NO name")

        age_range = None
        try:
            age_range = data['age_range']
        except Exception as e:
            log.append("NO age_range")

        priority_type = None
        try:
            priority_type = data['priority_type']
        except Exception as e:
            log.append("NO priority")

        start, end, date_of_shot = None, None, None
        try:
            date_of_shot = data['date_of_shot']
            start = date_of_shot['start_date']
            end = date_of_shot['end_date']
        except Exception as e:
            valid = False
            log.append("Date_of_shot is a require argument!")

        vaccine_type = None
        place = None
        try:
            vaccine_type = data['vaccine_type']
            place = data['place']
        except Exception as e:
            valid = False
            log.append("vaccine_type and place is a require argument")

        if not valid:
            return {'result': "fail", 'log': log}, 400
        else:

            # DONE: t???o aggregation ????? t???o danh s??ch ?????t ti??m nh??p
            # adapt ???????c 5 lo???i bi???n, (3 bi???n required - khu v???c, th???i gian expect, lo???i m??i ti??m)
            start_date = parse_to_date(start)
            end_date = parse_to_date(end)
            if age_range is not None:
                min_age, max_age = age_range.split("-")
                draft = sign.aggregate(create_list_people_in_campaign(start_date, end_date, vaccine_type, city,
                                                                      district, ward, min_age=int(min_age),
                                                                      max_age=int(max_age),
                                                                      priority_type=priority_type))
            else:
                draft = sign.aggregate(create_list_people_in_campaign(start_date, end_date, vaccine_type, city,
                                                                      district, ward,
                                                                      priority_type=priority_type))

            # DONE: ????ng k?? ?????t ti??m nh??p l??n campaign collection

            list_of_people = []
            for thing in draft:
                list_of_people.append(thing)

            _object = {
                'address': address,
                'date_of_shot_expect': date_of_shot,
                'next_vaccine_type': vaccine_type,
                'priority_group': priority_type,
                'age_range': age_range
            }

            campaign_draft = Campaign(name, list_of_people, start_date, end_date, vaccine_type, place, _object, False)

            result = campaign.insert_one(campaign_draft.to_json())

            # Done: tr??? l???i id ?????t ti??m nh??p ???? tao c??ng danh s??ch c???a ?????t ti??m
            return {'result': 'success', 'campaign_id': result.inserted_id, 'val': campaign_draft.to_json(),
                    'count': len(list_of_people), 'log': log}

    except Exception as e:
        print(e)
        return {'result': 'fail', 'message': 'not able to create new campaign'}, 400


# Th???nh
# campaign/ GET
# TODO: get all campaign
@app.route('/campaign', methods=['GET'])
# @admin_required
def get_all_campaign():
    try:
        shots_campaign = campaign.find({})
        if shots_campaign:
            dict_shots_campaign_id = {'_id_confirmed': [],
                                      '_id_not_confirm': []}
            for shot_campaign in shots_campaign:
                for people in shot_campaign['list_of_people']:
                    people.pop('vaccine_shots')
                if shot_campaign['status']:
                    dict_shots_campaign_id['_id_confirmed'].append(shot_campaign)
                else:
                    dict_shots_campaign_id['_id_not_confirm'].append(shot_campaign)
            return dict_shots_campaign_id
        else:
            return {'Status': 'Warning', 'Message': 'Do not hve any shot campaign! Please create shots campaign'}
    except Exception as e:
        print(e)
        return {'Status': 'Fail', 'Message': str(e)}, 400


# Th???nh
# campaign/<campaign-id> GET
# TODO: get a campaign
@app.route('/campaign/<string:campaign_id>', methods=['GET'])
# @admin_required
def get_a_campaign(campaign_id):
    try:
        # offset = request.args.get('offset')
        # limit = request.args.get('limit')
        # current_shot_campaign = campaign.find_one({'_id': ObjectId(campaign_id)}).limit(limit).skip(offset)
        current_shot_campaign = campaign.find_one({'_id': ObjectId(campaign_id)})
        if current_shot_campaign:
            return {'Status': 'Success',
                    'Current shot campaign': current_shot_campaign}
        else:
            return {'Status': 'Fail',
                    'Message': f'Can not find campaign from {campaign_id}! Please check again'}
    except Exception as e:
        return {'Status': 'Error!',
                'Message': e},400


# Ti???n
# campaign/<campaign-id> PUT
# TODO: update or promote a campaign
@app.route('/campaign/<campaign_id>', methods=['PUT'])
# @admin_required
def update_and_promote_campaign(campaign_id):
    print(campaign_id)
    try:
        data = request.get_json()
        log = []

        update_type = data['update_type']
        update = {}

        if update_type == 'promote':

            response = campaign.find_one({'_id': ObjectId(campaign_id)})

            if response['status']:
                return {'result': 'fail', 'message': 'unable to update or find the designated campaign'}, 400

            response = campaign.find_one_and_update({'_id': ObjectId(campaign_id)}, {"$set": {'status': True}})
            log_email = send_email_confirm_vaccination_campaign(response)
            # log_email = "send _email"

            if response:
                list_of_update = []
                for people in response['list_of_people']:
                    shot = {
                        'type_name': response['type_of_people']['next_vaccine_type'],
                        'shot_num': len(people['vaccine_shots']) + 1,
                        'shot_date': people['next_expected_shot_date'],
                        'shot_place': response['date_place'],
                        'status': 'scheduled'
                    }

                    update = UpdateOne({'_id': ObjectId(people['_id'])},
                                       {'$push': {'vaccine_shots': shot}})

                    list_of_update.append(update)

                change = sign.bulk_write(list_of_update)

                return {'result': 'success', 'campaign_promoted': response, 'log_email': log_email, 'change_db': change.bulk_api_result}
            else:
                return {'result': 'fail', 'message': 'unable to find the designated campaign',
                        'log_email': log_email}, 400

            # DONE: th??m c??i shot d??? ki???n ti??m v??o c??i vaccination_sign c???a ng?????i d??n

        elif update_type == 'update':

            campaign_ = campaign.find_one({'_id': ObjectId(campaign_id)})

            if campaign_['status']:
                return {'result': 'fail', 'message': 'unable to update campaign that is promoted, you need to delete '
                                                     'and create a new campaign in order to do so'}, 400

            if campaign_:

                name, time_range, place = None, None, None
                try:
                    name = data['name']
                    update['name'] = name
                except Exception as e:
                    log.append("Not update campaign's name")

                try:

                    update['date_start'] = parse_to_date(data['date_start'])
                    update['date_end'] = parse_to_date(data['date_end'])
                except Exception as e:
                    log.append("Not update campaign's time")

                try:
                    place = data['place']
                    update['date_place'] = place
                except Exception as e:
                    log.append("Not update campaign's place")

                updated = campaign.find_one_and_update({'_id': ObjectId(campaign_id)}, {"$set": update})
                return {'result': 'success', 'campaign_updated': updated}
            else:
                return {'result': 'fail', 'message': 'unable to find the designated campaign'}, 400

    except Exception as e:
        print(e)
        return {'result': 'fail', 'message': 'not able to update campaign'}, 400


# Th???nh
# campaign/<campaign-id> DELETE
# TODO: delete a campaign
@app.route('/campaign/<string:campaign_id>', methods=['DELETE'])
# @admin_required
def delete_a_campaign(campaign_id):
    try:
        shot_campaign = campaign.find_one({'_id': ObjectId(campaign_id)})
        if shot_campaign:
            # if shot_campaign['status']:
            #     # log = send_email_notification_delete_campaign(shot_campaign)
            #     # campaign.delete_one({'_id': ObjectId(campaign_id)})
            #     return {'message': "ok"}
            res = campaign.find_one_and_delete({'_id': ObjectId(campaign_id)})
            if shot_campaign['status']:
                list_id = []

                for people in res['list_of_people']:
                    list_id.append(ObjectId(people['_id']))

                # print(list_id)
                sign.update_many({'_id': {'$in': list_id}},
                                 {'$pull': {'vaccine_shots': {'status': 'scheduled'}}})

            return {'Status': 'Success',
                    'Message': f'Deleted {shot_campaign["_id"]}'}
        else:
            return {'Status': 'Fail',
                    'Message': f'Can not find campaign from {campaign_id}! Please check again'},  400
    except Exception as e:
        return {'Status': 'Error!',
                'Message': e},  400


# Huy???n
# campaign/<campaign-id>/user/<user-id> GET
# TODO: get a person in campaign
@app.route('/campaign/<string:campaign_id>/user/<string:user_id>', methods=['GET'])
# @admin_required
def get_a_person_in_campaign(campaign_id, user_id):
    try:
        current_shot_campaign = campaign.find_one({'_id': ObjectId(campaign_id)})
        if current_shot_campaign is None:
            return {'Result': 'Fail',
                    'Message': f'Can not find campaign having id: {campaign_id}! Please check again'}
        else:
            person = sign.find_one({'_id': ObjectId(user_id)})
            if person is not None:
                return {'Result': 'Success',
                        'User Information': person}
            else:
                return {'Result': 'Fail',
                        'Message': f'Can not find user from {campaign_id}! Please check again'},  400
    except Exception as e:
        print(e)
        return {'Result': 'Error!',
                'Message': 'Error!'},  400


# Huy???n
# campaign/<campaign-id>/user/ POST
# TODO: add a person to campaign
@app.route('/campaign/<string:campaign_id>/user/<string:user_id>', methods=['POST'])
# @admin_required
def add_a_person_to_campaign(campaign_id, user_id):
    try:
        current_shot_campaign = campaign.find_one({'_id': ObjectId(campaign_id)})
        if current_shot_campaign is None:
            return {'Result': 'Fail',
                    'Message': f'Can not find campaign having id: {campaign_id}! Please check again'}
        else:
            list_of_people = current_shot_campaign['list_of_people']
            for person in list_of_people:
                if person['_id'] == ObjectId(user_id):
                    return {'Result': 'Fail',
                            'Message': 'This person was in campaign'}
            try:
                person = sign.find_one({'_id': ObjectId(user_id)})
                if person is not None:
                    birthday = person['birth_day']
                    age = datetime.now().year - birthday.year
                    new_person = {'_id': ObjectId(user_id),
                                  'age': age,
                                  'priority_group': person['priority_group'],
                                  'next_expected_shot_date': person['next_expected_shot_date'],
                                  'next_expected_shot_type': person['next_expected_shot_type']}
                    list_of_people.append(new_person)
                    try:
                        campaign.find_one_and_update({'_id': ObjectId(campaign_id)},
                                                     {"$set": {'list_of_people': list_of_people}})
                        return {'Result': 'Success'}
                    except Exception as e:
                        print(e)
                        return {'Result': 'Fail!',
                                'Message': 'Can not add'},  400
                else:
                    return {'Result': 'Fail!',
                            'Message': f'Can not find user having id {user_id}! Please check again'},  400
            except Exception as e:
                print(e)
                return {'Result': 'Fail!',
                        'Message': f'Can not find user having id {user_id}! Please check again'},  400
    except Exception as e:
        print(e)
        return {'Result': 'Error!'},  400


# Huy???n
# campaign/<campaign-id>/user/<user-id> DELETE
# TODO: delete a person from campaign
@app.route('/campaign/<string:campaign_id>/user/<string:user_id>', methods=['DELETE'])
# @admin_required
def delete_a_person_from_campaign(campaign_id, user_id):
    try:
        current_shot_campaign = campaign.find_one({'_id': ObjectId(campaign_id)})
        if current_shot_campaign['status'] is False:
            list_of_people = current_shot_campaign['list_of_people']
            for person in list_of_people:
                if person['_id'] == ObjectId(user_id):
                    list_of_people.remove(person)
                    campaign.find_one_and_update({'_id': ObjectId(campaign_id)},
                                                 {"$set": {'list_of_people': list_of_people}})
                    return {'Result': 'Success',
                            'Message': f'Deleted {person}'}

            return {'Result': 'Fail',
                    'Message': f'Can not find user from {campaign_id}! Please check again'},  400
        else:
            return {'Result': 'Fail',
                    'Message': f'Campaign {campaign_id} was promoted'},  400
    except Exception as e:
        return {'Result': 'Error!'},  400


# Huy???n
# campaign/<campaign-id>/user/<user-id> PUT
# TODO: update a person in campaign
@app.route('/campaign/<string:campaign_id>/user/<string:user_id>', methods=['PUT'])
# @admin_required
def update_a_person_in_campaign(campaign_id, user_id):
    data = request.get_json()
    update = {
        'name': data['name'],
        'birth_day': data['birth_day'],
        'sex': data['sex'],
        'phone': data['phone'],
        'email': data['email'],
        'CCCD': data['CCCD'],
        'BHXH_id': data['BHXH_id'],
        'address': data['address'],
        'priority_group': data['priority_group'],
        'illness_history': data['illness_history'],
    }
    try:
        sign.find_one_and_update({'_id': ObjectId(user_id)},
                                 {"$set": update})
        return {'Result': 'Success'}
    except Exception as e:
        print(e)
        return {'Result': 'Error'},  400


def parse_to_date(date_json):
    try:
        return datetime.strptime(date_json, "%Y-%m-%d")
    except:
        return False
