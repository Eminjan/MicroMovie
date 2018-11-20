#!/usr/bin/env
# -*-coding:utf-8-*-
# @Author  : E🚀M

from app import app
from flask_script import Manager

manage = Manager(app)
if __name__ == "__main__":
    manage.run()
