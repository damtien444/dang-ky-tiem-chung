from vaccine.controller.service import db

def get_data(name_data):
    return db[name_data]