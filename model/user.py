class User:

    def __init__(self, _id, name, hash_password, tittle, username, is_admin, user=None):
        if user is None:
            self._id = _id
            self.name = name
            self.hash_password = hash_password
            self.tittle = tittle
            self.username = username
            self.is_admin = is_admin

        else:
            self._id = user['_id']
            self.name = user['name']
            self.hash_password = user['password']
            try:
                self.tittle = user['tittle']
            except Exception as ignore:
                pass
            self.username = user['username']
            self.is_admin = user['is_admin']

    def gen_dict(self):
        gen_dict = {'_id': self._id,
                    'name': self.name,
                    'password': self.hash_password,
                    'username': self.username,
                    'is_admin': self.is_admin}
        return gen_dict
