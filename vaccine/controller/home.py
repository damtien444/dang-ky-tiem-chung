from vaccine import app, render_template
@app.route('/')
@app.route('/home', methods=['GET'])
def home_page():
    form_message = {'message': 'Đây là API của ứng dụng đăng ký tiêm chủng!'}
    return render_template('home.html', form_message=form_message)