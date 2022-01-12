from datetime import datetime

from bson import ObjectId

from vaccine import app, request, admin_required
from vaccine.controller.service import db
from vaccine.model.agregation_pipeline import create_list_people_in_campaign
from vaccine.model.campaign import Campaign

sign = db['vaccination_sign']
campaign = db['shot_campaign']


# Tiến
# campaign/ POST
# TODO: create campaign
@app.route('/campaign', methods=['POST'])
@admin_required
def create_campaign(user):
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
            log.append("Vaccine_type is a require argument")

        if not valid:
            return {'result': "fail", 'log': log}, 400
        else:

            # DONE: tạo aggregation để tạo danh sách đợt tiêm nháp
            # adapt được 5 loại biến, (3 biến required - khu vực, thời gian expect, loại mũi tiêm)
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

            # DONE: đăng ký đợt tiêm nháp lên campaign collection

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

            # Done: trả lại id đợt tiêm nháp đã tao cùng danh sách của đợt tiêm
            return {'result': 'success', 'campaign_id': result.inserted_id, 'val': campaign_draft.to_json(),
                    'count': len(list_of_people), 'log': log}

    except Exception as e:
        print(e)
        return {'result': 'fail', 'message': 'not able to create new campaign'}, 400


# Thịnh
# campaign/ GET
# TODO: get all campaign
@app.route('/campaign/get-all-campaign/', methods=['GET'])
@admin_required
def get_all_campaign(user):
    try:
        shots_campaign = campaign.find({})
        if shots_campaign:
            dict_shots_campaign_id = {'_id_confirmed': [],
                                      '_id_not_confirm': []}
            for shot_campaign in shots_campaign:
                if shot_campaign['status']:
                    dict_shots_campaign_id['_id_confirmed'].append(shot_campaign['_id'])
                else:
                    dict_shots_campaign_id['_id_not_confirm'].append(shot_campaign['_id'])
            return {'Status': 'Success',
                    'Message': [f'list of shots campaign comfirmed {dict_shots_campaign_id["_id_confirmed"]}',
                                f'List of shots campaign not comfirm {dict_shots_campaign_id["_id_not_confirm"]}']}
        else:
            return {'Status': 'Warning', 'Message': 'Do not hve any shot campaign! Please create shots campaign'}
    except Exception as e:
        return {'Status': 'Fail', 'Message': e}


# Thịnh
# campaign/<campaign-id> GET
# TODO: get a campaign
@app.route('/campaign/<string:campaign_id>', methods=['GET'])
@admin_required
def get_a_campaign(user, campaign_id):
    try:
        current_shot_campaign = campaign.find_one({'_id': ObjectId(campaign_id)})
        if current_shot_campaign:
            return {'Status': 'Success',
                    'Current shot campaign': current_shot_campaign}
        else:
            return {'Status': 'Fail',
                    'Message': f'Can not find campaign from {campaign_id}! Please check again'}
    except Exception as e:
        return {'Status': 'Error!',
                'Message': e}

# Tiến
# campaign/<campaign-id> PUT
# TODO: update or promote a campaign
@app.route('/campaign/<campaign_id>', methods=['PUT'])
@admin_required
def update_and_promote_campaign(user,campaign_id):
    print(campaign_id)
    try:
        data = request.get_json()
        log = []

        update_type = data['update_type']
        update = {}

        if update_type == 'promote':

            response = campaign.find_one_and_update({'_id': ObjectId(campaign_id)}, {"$set": {'status': True}})

            if response:
                return {'result': 'success', 'campaign_promoted': response}
            else:
                return {'result': 'fail', 'message': 'unable to find the designated campaign'}, 400

            # TODO: start batch-job gửi mail hàng loạt

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
                    time_range = data['time_range']

                    time_range = time_range.split('-')
                    start_, end_ = str(time_range[0]), str(time_range[1])
                    update['date_start'] = parse_to_date(start_)
                    update['date_end'] = parse_to_date(end_)
                except Exception as e:
                    log.append("Not update campaign's time")

                try:
                    place = data['place']
                    update['place'] = place
                except Exception as e:
                    log.append("Not update campaign's place")

                updated = campaign.find_one_and_update({'_id': ObjectId(campaign_id)}, {"$set": update})
                return {'result': 'success', 'campaign_updated': updated}
            else:
                return {'result': 'fail', 'message': 'unable to find the designated campaign'}, 400

    except Exception as e:
        print(e)
        return {'result': 'fail', 'message': 'not able to update campaign'}, 400


# Thịnh
# campaign/<campaign-id> DELETE
# TODO: delete a campaign
@app.route('/campaign/<string:campaign_id>', methods=['DELETE'])
@admin_required
def delete_a_campaign(user, campaign_id):
    try:
        shot_campaign_deleted = campaign.find_one_and_delete({'_id': ObjectId(campaign_id)})
        if shot_campaign_deleted:
            return {'Status': 'Success',
                    'Message': f'Deleted {shot_campaign_deleted}'}
        else:
            return {'Status': 'Fail',
                    'Message': f'Can not find campaign from {campaign_id}! Please check again'}
    except Exception as e:
        return {'Status': 'Error!',
                'Message': e}


# Huyền
# campaign/<campaign-id>/user/<user-id> GET
# TODO: get a person in campaign

# Huyền
# campaign/<campaign-id>/user/ POST
# TODO: add a person to campaign

# Huyền
# campaign/<campaign-id>/user/<user-id> DELETE
# TODO: delete a person from campaign

# Huyền
# campaign/<campaign-id>/user/<user-id> PUT
# TODO: update a person in campaign

def parse_to_date(date_json):
    try:
        return datetime.strptime(date_json, "%Y-%m-%d")
    except:
        return False