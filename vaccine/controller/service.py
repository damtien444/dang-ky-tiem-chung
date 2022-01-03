import pymongo

name_server = "mongodb+srv://vaccineForThePeople:vaccine@vaccineforthepeople.vodjz.mongodb.net/admin?retryWrites=true&w=majority"
name_database = 'vaccinePlanningDB'

def connect_server(name_server):
    client = pymongo.MongoClient(name_server)
    return client


conn = connect_server(name_server)
db = conn[name_database]