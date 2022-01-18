from datetime import datetime


def get_time_register():
    now = datetime.now()
    return datetime.strptime(now.strftime("%Y-%m-%d %H-%M-%S"), "%Y-%m-%d %H-%M-%S")


class email_sign:

    def __init__(self,
                 email: str,
                 status: bool):
        self.email = email
        self.status = status
        self.time_register = get_time_register()

    def to_dict(self):
        return {
            'email': self.email,
            'status': self.status,
            'time_register': self.time_register
        }


if __name__ == '__main__':
    x = email_sign(email='mail',
                   status=False)

    print(x.time_register)
