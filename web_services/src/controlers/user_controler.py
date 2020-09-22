from flask_classful import FlaskView, route
import json
from flask import abort, jsonify, request, make_response
import services.user_service as us

class UserControler(FlaskView):
    route_base = 'api/users'

    @route('/')
    def get_users(self):
        users = []
        for user in us.get_users():
            users.append(json.dumps(user.__dict__))
        return jsonify(users), 200

    @route('/<string:login>')
    def get_user_by_login(self, login):
        users = []
        for user in us.get_user_by_login(login):
            users.append(json.dumps(user.__dict__))
        return jsonify(users), 200

    @route('/', methods=['POST'])
    def create_user(self):
        response = make_response(json.dumps(
            us.create_user(request.get_json()).__dict__), 201)
        return response

    @route('/<int:user_id>', methods=['PUT'])
    def update_user(self, user_id):
        return json.dumps(us.update_user(user_id, request.get_json()).__dict__), 200

    @route('/<int:user_id>', methods=['DELETE'])
    def delete_user(self, user_id):
        us.delete_user(user_id)
        return "Utilisateur supprimay", 200
