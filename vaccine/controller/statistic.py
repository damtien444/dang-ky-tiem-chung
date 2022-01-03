from vaccine import app, request, Message, mail, render_template
from vaccine.controller.service import db


@app.route('/statistic')
def statistic():
    form_statistic = {'Thống kê': 'Đây là trang thống kê'}
    return render_template('statistic.html', form_statistic=form_statistic)