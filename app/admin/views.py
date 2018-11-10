#!/usr/bin/env
# -*-coding:utf-8-*-
# @Author  : E🚀M

from . import admin


@admin.route("/")
def index():
    return "<h1 style='color:red'>Eminjan</h1>"
