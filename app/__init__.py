#!/usr/bin/env
# -*-coding:utf-8-*-
# @Author  : E🚀M

from flask import Flask
from flask import render_template
from flask_sqlalchemy import SQLAlchemy
import mysql.connector


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = "mysql+mysqlconnector://root:root@127.0.0.1:3306/movie?charset=utf8"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = True
app.config["SECRET_KEY"] = 'f00cd2a8351943b4a52573fcbb3a4c97'
app.debug = True
db = SQLAlchemy(app)


from app.home import home as home_blueprint
from app.admin import admin as admin_blueprint

app.register_blueprint(home_blueprint)
app.register_blueprint(admin_blueprint,url_prefix = "/admin")

@app.errorhandler(404)
def page_not_found(error):
    return render_template("home/404.html"),404
