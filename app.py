from flask import Flask, jsonify, request
import pymongo

app = Flask(__name__)
app.config['JSON_AS_ASCII'] = False

client = pymongo.MongoClient(
    "mongodb+srv://vaccineForThePeople:vaccine@vaccineforthepeople.vodjz.mongodb.net/admin?retryWrites=true&w=majority")
db = client['vaccinePlanningDB']
managers = db['manager']


@app.route('/')
def helloWorld():
    res = {'result':'Viet Nam vo dich ne'}
    res['user'] = []

    user = managers.find({})

    for x in user:
        res['user'].append(x)

    print(res)
    return jsonify(res)


if __name__ == '__main__':
    app.run()
