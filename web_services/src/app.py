from flask import Flask
from flask_cors import CORS
from flask_sqlalchemy import SQLAlchemy
from controlers.user_controler import UserControler

app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:root@database:3306/users'
db = SQLAlchemy(app)
UserControler.register(app)

if __name__ == "main":
    app.run(debug=True, host='0.0.0.0')
