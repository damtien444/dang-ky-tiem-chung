from datetime import datetime


class Sign:
    def __init__(self, _id, name, birthday, sex, phone, email, cccd, bhxh_id, address, priority_group, vaccine_shots,
                 next_expected_shot_date=None, next_expected_shot_type=None, illness_history=False):
        self._id = _id
        self.name = name
        self.birthday = parse_to_date(birthday)
        self.sex = sex
        self.phone = phone
        self.email = email
        self.cccd = cccd
        self.bhxh_id = bhxh_id
        self.address = address
        self.priority_group = priority_group
        self.vaccine_shots = vaccine_shots
        self.confirm_otp = False
        self.next_expected_shot_date = next_expected_shot_date
        self.next_expected_shot_type = next_expected_shot_type
        self.illness_history = illness_history

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
            'vaccine_shots': self.vaccine_shots,
            'confirm_otp': self.confirm_otp,
            'next_expected_shot_date': self.next_expected_shot_date,
            'next_expected_shot_type': self.next_expected_shot_type,
            'illness_history': self.illness_history
        }


    def append_vaccine_shots(self, vaccine_shot):
        self.vaccine_shots.append(vaccine_shot)

def parse_to_date(date_json):
    try:
        return datetime.strptime(date_json, "%Y-%m-%d")
    except:
        return False
