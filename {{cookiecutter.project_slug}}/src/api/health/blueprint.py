import flask
from flask_smorest import Blueprint
from flask.views import MethodView

blp = Blueprint(
    "health",
    "health",
    url_prefix="/api/v1/health",
    description="{{ cookiecutter.project_slug }} service health.",
)


@blp.route("/")
class Health(MethodView):
    @blp.response(200)
    def get(self):
        return flask.Response(
            status=200, response="Service {{ cookiecutter.project_slug }} is healthy!", mimetype="text/plain"
        )
