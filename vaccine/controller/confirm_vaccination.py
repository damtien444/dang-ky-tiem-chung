from vaccine import app, request, Message, mail, render_template, redirect, url_for
from vaccine.controller.service import db


@app.route('/confirm-vaccination', methods=['GET', 'POST'])
def confirm_vaccination():
    sign_collection = db['vaccination_sign']
    if request.method == 'POST':
        list_accepted_user = request.form['accepted_users']
        list_denied_user = request.form['denied_users']
        if list_accepted_user and list_denied_user:
            accepted_user = sign_collection.find_one({'CCCD': str(list_accepted_user)})
            denied_user = sign_collection.find_one({'CCCD': str(list_denied_user)})
            # if accepted_user:
            #     send_email(database=accepted_user, accept=True)
            # if denied_user:
            #     send_email(database=denied_user, accept=False)
            return render_template('confirm_vaccination.html', accepted_user=accepted_user, denied_user=denied_user)
        else:
            return 'Error!!'
    return redirect(url_for('create_vaccination'))

def send_email(database, accept):
    information = f'Thư mời xác nhận tiêm vaccine tới anh/chị {database["name"]}'
    list_email = ['yomat60271@xxyxi.com']
    msg = Message(information, recipients=list_email)
    if(accept == True):
        msg.body = 'Yêu cầu của bạn hợp lệ'
    else:
        msg.body = 'Yêu cầu của bạn không hợp lệ'
    mail.send(msg)


