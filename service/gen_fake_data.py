import datetime
import json
import random
import string

from bson import ObjectId
from vietnam_provinces import Province, District, Ward
from vietnam_provinces.enums import ProvinceEnum, ProvinceDEnum, DistrictEnum, DistrictDEnum
from vietnam_provinces.enums.wards import WardEnum, WardDEnum

doc = []

list_of_vaccine = ['AstraZeneca', 'Pfizer–BioNTech', 'Janssen', 'Moderna', 'Sinopharm']

with open('name.json', encoding='utf-8') as jsonfile:

    name_dictionary = json.load(jsonfile)



def gen_random_address():
    province = random.choice(list(ProvinceEnum))
    province_code = province.value.code
    list_of_district = []

    for district in list(DistrictEnum):
        if province_code == district.value.province_code:
            list_of_district.append(district)
            # print(district.value.name)

    district = random.choice(list_of_district)
    district_code = district.value.code

    list_of_ward = []
    for ward in list(WardEnum):
        if district_code == ward.value.district_code:
            list_of_ward.append(ward)

    ward = random.choice(list_of_ward)

    # print(province.value.name, district.value.name, ward.value.name, sep=", ")

    return {
        'province': province.value.name,
        'district': district.value.name,
        'ward': ward.value.name,
        'st_no': ''.join(random.choices(string.ascii_uppercase + string.digits, k=10))
    }


def random_string(len):
    return ''.join(random.choices(string.ascii_uppercase + string.ascii_lowercase, k=len))


def random_date(start_date, end_date):
    # start_date = datetime.date(2020, 1, 1)
    # end_date = datetime.date(2020, 2, 1)

    time_between_dates = end_date - start_date
    days_between_dates = time_between_dates.days
    random_number_of_days = random.randrange(days_between_dates)
    random_date = start_date + datetime.timedelta(days=random_number_of_days)
    return random_date


def random_phone():
    return ''.join(random.choices(string.digits, k=10))


def random_cccd():
    return ''.join(random.choices(string.digits, k=15))


def random_BHXH():
    return ''.join(random.choices(string.digits, k=12))


def random_email():
    pre = ''.join(random.choices(string.ascii_uppercase + string.ascii_lowercase + string.digits, k=15))
    aft = '@gmail.com'
    return pre + aft


list_of_status = ['not_trusted', 'shotted']


def random_history():
    num_shot = random.randint(0, 3)
    vaccine_shots = []
    for i in range(num_shot):
        if i == 0:
            shot = {'type_name': random.choice(list_of_vaccine), 'shot_num': i + 1,
                    'shot_date': random_date(datetime.datetime(2021, 10, 31), datetime.datetime.today()),
                    'shot_place': random_string(20), 'status': random.choice(list_of_status)}
            vaccine_shots.append(shot)
        else:

            shot = {'type_name': vaccine_shots[i - 1]['type_name'], 'shot_num': i + 1,
                    'shot_date': vaccine_shots[i - 1]['shot_date'] + datetime.timedelta(days=random.randint(15, 60)),
                    'shot_place': random_string(20), 'status': random.choice(list_of_status)}
            vaccine_shots.append(shot)

    return vaccine_shots

def random_name():
    name = random.choice(name_dictionary)

    return name['full_name']

def random_sign():
    name = random_name()
    birth_day = random_date(datetime.datetime(1950, 1, 1), datetime.datetime.today())
    sex = bool(random.getrandbits(1))
    phone = random_phone()
    email = random_email()
    CCCD = random_cccd()
    BHXH_id = random_BHXH()
    address = gen_random_address()
    priority = random.randint(1, 16)
    vaccine_shots = random_history()
    if len(vaccine_shots) == 0:
        next_expected_shot_date = datetime.datetime(1900, 1, 1)
        next_expected_shot_type = 'NO_NEXT'
    else:
        next_expected_shot_date = vaccine_shots[len(vaccine_shots) - 1]['shot_date'] + datetime.timedelta(
            days=random.randint(15, 90))
        next_expected_shot_type = vaccine_shots[len(vaccine_shots) - 1]['type_name']

    illness_history = bool(random.getrandbits(1))
    user_expected_shot_date = datetime.datetime.today() + datetime.timedelta(days=random.randint(15, 90))

    sign = {'name': name, 'birth_day': birth_day, 'sex': sex, 'phone': phone, 'email': email, 'CCCD': CCCD,
            'BHXH_id': BHXH_id, 'address': address, 'priority_group': priority, 'vaccine_shots': vaccine_shots,
            'next_expected_shot_date': next_expected_shot_date, 'next_expected_shot_type': next_expected_shot_type,
            'illness_history': illness_history, 'user_expected_shot_date': user_expected_shot_date}

    return sign


fake_sign = []
for i in range(80000):
    try:
        fake_sign.append(random_sign())
    except Exception as ignore:
        pass


from vaccine.controller.service import db

sign = db['vaccination_sign']
sign.insert_many(fake_sign)
report = db['report']
sign = db['vaccination_sign']
# update = sign.find_one_and_update({'_id': ObjectId('61dee1edf2cd403b79cd1daf')},
#                                   {'$pull': {'vaccine_shots': {'status': 'scheduled'}}})
# report.create_index('date_created', expireAfterSeconds=30)

# report.insert_one({"test": "ghaha", "date_created": datetime.datetime.utcnow()})
# report.insert_one({"test": "ghaha"})

# report.find_one_and_update({'_id': ObjectId('61e976d07a077b6a49a7c7f6')}, {'$unset': {'date_created': 1}})
#
# res = report.find({'date_created': {'$exists': False}})
# for thing in res:
#     print(thing)
