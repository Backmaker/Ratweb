from flask_sqlalchemy import SQLAlchemy
from models.user import User

db = SQLAlchemy()

def get_users():
    return db.session.query(User)


def get_user_by_login(login):
    return db.session.query(User).filter(User.login == login)


def create_user(user):
    db.session.add(user)
    # Cette ligne permet de supprimer le problème au niveau de delete au niveau de l'app flask
    db.session.query(User)
    db.session.commit()
    return user


def update_user(user_id, user):
    user_data = User.query.get(user_id)
    user_data.lastname = user.lastname
    user_data.firstname = user.firstname
    user_data.birth = user.birth
    user_data.email = user.email
    user_data.login = user.login
    user_data.password = user.password
    # Cette ligne permet de supprimer le problème au niveau de delete au niveau de l'app flask
    db.session.query(User)
    db.session.commit()
    return user


def delete_user(user_id):
    db.session.query(User).filter(User.id == user_id).delete()
    # Cette ligne permet de supprimer le problème au niveau de delete au niveau de l'app flask
    db.session.query(User)
    db.session.commit()
