from flask import Blueprint, render_template, request

main = Blueprint("main", __name__)

@main.route("/")
def index():
    return render_template("index.html")

@main.route("/status")
def status():
    return render_template("status.html", status="OK")

@main.route("/echo", methods=["POST"])
def echo():
    user_input = request.form.get("user_input")
    return render_template("index.html", message=user_input)
