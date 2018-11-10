#!/usr/bin/env
# -*-coding:utf-8-*-
# @Author  : E🚀M

from flask import Blueprint

admin = Blueprint("admin",__name__)

import app.admin.views