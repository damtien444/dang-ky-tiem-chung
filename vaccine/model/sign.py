from datetime import datetime


class Sign:
    def __init__(self, _id, name, birthday, sex, phone, email, cccd, address, priority_group, bhxh_id=None,
                 first_shot=None, next_expected_shot_date=None, next_expected_shot_type=None,
                 illness_history=False, user_expected_shot_date=None):
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

        if first_shot is None:
            self.vaccine_shots = []
        else:
            self.vaccine_shots = []
            self.vaccine_shots.append(first_shot)

        self.confirm_otp = False

        if next_expected_shot_date is None:
            self.next_expected_shot_date = parse_to_date("1900-01-01")
        else:
            self.next_expected_shot_date = next_expected_shot_date

        if next_expected_shot_type is None:
            self.next_expected_shot_type = "NO_NEXT"
        else:
            self.next_expected_shot_type = next_expected_shot_type

        self.illness_history = illness_history
        self.user_expected_shot_date = parse_to_date(user_expected_shot_date)

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
            'illness_history': self.illness_history,
            'user_expected_shot_date': self.user_expected_shot_date
        }

    def append_vaccine_shots(self, vaccine_shot):
        self.vaccine_shots.append(vaccine_shot)


def parse_to_date(date_json):
    try:
        return datetime.strptime(date_json, "%Y-%m-%d")
    except:
        return False
