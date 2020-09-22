from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class User(db.Model):
    __tablename__ = 'users'

    id = db.Column(db.Integer, primary_key=True)
    lastname = db.Column(db.String, nullable=False)
    firstname = db.Column(db.String, nullable=False)
    birth = db.Column(db.String, nullable=False)
    email = db.Column(db.String, nullable=False)
    login = db.Column(db.String, nullable=False)
    password = db.Column(db.String, nullable=False)

    def __init__(self, lastname, firstname, birth, email, login, password):
        self.lastname = lastname
        self.firstname = firstname
        self.birth = birth
        self.email = email
        self.login = login
        self.password = password

    def __repr__(self):
        return f'<id:{self.id} lastname:{self.lastname} firstname:{self.firstname} birth:{self.birth} email:{self.email} login:{self.login} password:{self.password}>'
