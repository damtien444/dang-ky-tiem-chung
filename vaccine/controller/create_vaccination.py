from vaccine import app, request, Message, mail, render_template
from vaccine.controller.service import db


@app.route('/create-vaccination', methods=['GET', 'POST'])
def create_vaccination():
    form_vaccine = {'feature': 'Đây là trang tạo đợt tiêm chủng'}
    accepted_users = ['Lorem']
    denied_users = ['23456123456']
    return render_template('create_vaccination.html', form_vaccine=form_vaccine,
                           accepted_users=accepted_users, denied_users=denied_users)
