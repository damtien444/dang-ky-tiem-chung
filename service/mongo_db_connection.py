import pymongo


def get_db(name):
    client = pymongo.MongoClient(
        "mongodb+srv://vaccineForThePeople:vaccine@vaccineforthepeople.vodjz.mongodb.net/admin?retryWrites=true&w"
        "=majority")
    return client[name]