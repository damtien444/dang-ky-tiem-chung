from datetime import datetime


class Sign:
    def __init__(self, _id, name, birthday, sex, phone, email, cccd, bhxh_id, address, priority_group, vaccine_shot):
        self._id = _id
        self.name = name
        self.birthday = parse_to_date(birthday)
        self.sex = sex
        self.phone = phone
        self.email = email
        self.cccd = cccd
        self.bhxh_id = bhxh_id
        self.address = {'province': address['provine'],
                        'district': address['district'],
                        'ward': address['ward'],
                        'st_no': address['st_no']}
        self.priority_group = priority_group
        self.vaccine_shot = {'type_name': vaccine_shot['type_name'],
                             'shot_num': vaccine_shot['shot_num'],
                             'shot_date': parse_to_date(vaccine_shot['shot_date']),
                             'shot_place': vaccine_shot['shot_place'],
                             'status': 'signed'}
        self.vaccine_shots = []
        self.vaccine_shots.append({'type_name': vaccine_shot['type_name'],
                                   'shot_num': vaccine_shot['shot_num'],
                                   'shot_date': parse_to_date(vaccine_shot['shot_date']),
                                   'shot_place': vaccine_shot['shot_place'],
                                   'status': 'signed'})

    def gen_dict(self):
        return {
            'name': self.name,
            'birth_day': self.birthday,
            'sex': self.sex,
            'phone': self.phone,
            'email': self.email,
            'CCCD': self.cccd,
            'BHXH_id': self.bhxh_id,
            'address': self.address,
            'priority_group': self.priority_group,
            'vaccine_shots': self.vaccine_shots
        }


def parse_to_date(date_json):
    try:
        return datetime.strptime(date_json, "%Y-%m-%d")
    except:
        return False
