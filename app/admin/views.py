#!/usr/bin/env
# -*-coding:utf-8-*-
# @Author  : E🚀M

from . import admin
from flask import render_template,redirect,url_for

@admin.route("/")
def index():
    return "<h1 style='color:red'>Eminjan</h1>"

@admin.route("/login")
def login():
    return render_template("admin/login.html")

@admin.route("/logout")
def logout():
    return redirect(url_for("admin.login"))
