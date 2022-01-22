import datetime

from bson import ObjectId

from vaccine import app, request, admin_required
from vaccine.controller.email_confirm import send_email_confirm_report, send_email_announce_response_report
from vaccine.controller.service import db

report = db['report']


# /report post
# TODO: create report
@app.route('/report-public', methods=['POST'])
def create_report():
    try:
        data = request.get_json()
        print(data)
        name = data['name']
        email = data['email']
        status = 'NOT_SOLVE'
        content = data['content']
        date_created = datetime.datetime.utcnow()
        date_created_vn = date_created + datetime.timedelta(hours=7)
        has_reponse = False

        res = report.insert_one({'name': name, 'email': email, 'status': status, 'content': content,
                                 'date_created': date_created, 'has_response': has_reponse,
                                 'date_created_vn': date_created_vn})

        # invoke an email to confirm
        id = res.inserted_id
        print(email, id)
        send_email_confirm_report(name, content, date_created_vn, email, id)

        return {'result': 'success', 'message': 'go to email to verify email', 'report_id': id}

    except Exception as e:
        print(e)
        return {'result': 'fail', 'message': 'unable to create report'}, 400


# /report-confirm
@app.route('/report-public/<report_id>', methods=['GET'])
def confirm(report_id):
    try:
        rep = report.find_one_and_update({'_id': ObjectId(report_id)}, {'$unset': {'date_created': 1}})
        if rep:

            return {"result": 'success', "report": rep}
        else:
            return {"result": 'fail', 'message': 'Phản hồi không khả dụng, có thể đã bị quá hạn'}, 400
    except Exception as e:
        print(e)
        return {'result': 'fail', 'message': 'unable to create report'}, 400


# /report/id get
# TODO: get a report
@app.route('/report-public', methods=['GET'])
# @admin_required
def get_one_report():
    try:
        name = request.args.get('name')
        email = request.args.get('email')

        rep = report.find_one({'name': name, 'email': email})
        if rep:
            return {"result": 'success', "report": rep}
        else:
            return {"result": 'fail', 'message': 'Unable to find report'}, 400
    except Exception as e:
        print(e)
        return {"result": 'fail', 'message': 'Unable to find report'}, 400


# /report get
# TODO: get all report
@app.route('/report', methods=['GET'])
def get_all_reports():
    try:
        res = report.find({'date_created': {'$exists': False}})

        not_solve = []
        solved = []

        for thing in res:
            try:
                if thing['status'] == 'NOT_SOLVE':
                    not_solve.append(thing)
                elif thing['status'] == 'SOLVED':
                    solved.append(thing)
            except:
                continue

        return {'result': 'success', 'message': 'all reports gather', 'not_solve': not_solve, 'solved': solved}
    except Exception as e:
        print(e)
        return {'result': 'fail', 'message': 'unable to gather reports', 'error': e}, 400


# /report/id put
# TODO: update report status or details
@app.route('/report/<report_id>', methods=['PUT'])
def update_report(report_id):
    try:
        data = request.get_json()

        status = data['status']
        if status != 'SOLVED' and status != 'NOT_SOLVE':
            return {"result": 'fail', 'message': 'wrong body, status need to be either "SOLVED" or "NOT_SOLVE"'}, 400

        response = data['response']

        res = report.find_one_and_update({'_id': ObjectId(report_id)}, {'$set': {'status': status, 'response': response,
                                                                                 'has_response': True}})

        if res:
            if response:
                send_email_announce_response_report(res['name'], res['content'], res['email'], response)

            return {"result": 'success', "report": res}
        else:
            return {"result": 'fail', 'message': 'Unable to find designated report'}, 400

    except Exception as e:
        print(e)
        return {"result": 'fail', 'message': 'Unable to update designated report or wrong request body',
                'err': e}, 400


# /report/id delete
# TODO: delete a report
@app.route('/report/<report_id>', methods=['DELETE'])
def delete_a_report(report_id):
    try:
        res = report.find_one_and_delete({'_id': ObjectId(report_id)})
        return {'result': 'success', 'message': 'delete successfully', 'report': res}
    except Exception as e:
        print(e)
        return {"result": 'fail', 'message': 'Unable to delete designated report',
                'err': e}, 400


if __name__ == '__main__':
    report.ensure_index('date_created', expireAfterSeconds=30)

    report.insert_one({"test": "ghaha", "date_created": datetime.datetime.now()})
