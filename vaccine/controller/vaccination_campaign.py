from datetime import datetime

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
            log.append("Vaccine_type is a require argument")

        if not valid:
            return {'result': "fail", 'log': log}
        else:

            # todo: tạo aggregation để tạo danh sách đợt tiêm nháp
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
                'vaccine_type': vaccine_type,
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
        return {'result': 'fail', 'message': 'not able to create new campaign'}


# Thịnh
# campaign/ GET
# TODO: get all campaign

# Thịnh
# campaign/<campaign-id> GET
# TODO: get a campaign

# Tiến
# campaign/<campaign-id> PUT
# TODO: update or promote a campaign



# Thịnh
# campaign/<campaign-id> DELETE
# TODO: delete a campaign

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
