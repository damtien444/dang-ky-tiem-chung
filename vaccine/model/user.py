from werkzeug.security import generate_password_hash, check_password_hash
class User:
    def __init__(self, _id, name, hash_password, tittle, username, is_admin):
        self._id = _id
        self.name = name
        self.hash_password = hash_password
        self.tittle = tittle
        self.username = username
        self.is_admin = is_admin

    def gen_dict(self):
        gen_dict = {'_id': self._id,
                    'name': self.name,
                    'password': self.hash_password,
                    'username': self.username,
                    'is_admin': self.is_admin}
        return gen_dict

    def check_password_hash(self, password_hash):
        return check_password_hash(self.hash_password, password_hash)
