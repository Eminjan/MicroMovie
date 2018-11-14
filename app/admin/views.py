#!/usr/bin/env
# -*-coding:utf-8-*-
# @Author  : E🚀M
import os

import datetime
import uuid

from app import db,app
from . import admin
from flask import render_template, redirect, url_for, flash, session, request
from app.admin.forms import LoginForm, TagForm,MovieForm
from app.models import Admin, Tag,Movie
from functools import wraps
from werkzeug.utils import secure_filename


def admin_login_req(f):
    """
    登录装饰器
    """

    @wraps(f)
    def decorated_function(*args, **kwargs):
        if "admin" in session:
            return f(*args, **kwargs)
        return redirect(url_for("admin.login"))

    return decorated_function

def change_filename(filename):
    """
    修改文件名称
    :return:
    """
    fileinfo = os.path.splitext(filename)
    filename = datetime.datetime.now().strftime("%Y%m%d%H%M%S") + str(uuid.uuid4().hex) + fileinfo[-1]
    return filename


@admin.route("/")
@admin_login_req
def index():
    """
    后台首页
    :return:
    """
    return render_template("admin/index.html")


@admin.route("/login/", methods=["GET", "POST"])
def login():
    """
    后台登录
    :return:
    """
    form = LoginForm()
    if form.validate_on_submit():
        data = form.data
        admin = Admin.query.filter_by(name=data["account"]).first()
        if not admin.check_pwd(data["pwd"]):
            flash("密码错误！","err")
            return redirect(url_for('admin.login'))
        session["admin"] = data["account"]
        return redirect(request.args.get("next") or url_for("admin.index"))
    return render_template("admin/login.html", form=form)


@admin.route("/logout/")
def logout():
    """
    后台注销登录
    """
    session.pop("admin", None)
    return redirect(url_for("admin.login"))


@admin.route("/pwd/")
@admin_login_req
def pwd():
    return render_template("admin/pwd.html")


@admin.route("/tag/add/",methods = ["GET","POST"])
@admin_login_req
def tag_add():
    """
    添加标签
    """
    form = TagForm()
    if form.validate_on_submit():
        data = form.data
        tag = Tag.query.filter_by(name=data["name"]).count()
        if tag == 1:
            flash("标签已存在", "err")
            return redirect(url_for("admin.tag_add"))
        tag = Tag(
            name=data["name"]
        )
        db.session.add(tag)
        db.session.commit()
        flash("标签添加成功", "ok")
        redirect(url_for("admin.tag_add"))
    return render_template("admin/tag_add.html", form=form)


@admin.route("/tag/edit/<int:id>/",methods = ["GET","POST"])
@admin_login_req
def tag_edit(id):
    """
    编辑标签
    :
    """
    form = TagForm()
    form.submit.label.text = "修改"
    tag = Tag.query.get_or_404(id)
    if form.validate_on_submit():
        data = form.data
        tag_count = Tag.query.filter_by(name=data["name"]).count()
        if tag.name != data["name"] and tag_count == 1:
            flash("标签已存在", "err")
            return redirect(url_for("admin.tag_edit", id=tag.id))
        tag.name = data["name"]
        db.session.add(tag)
        db.session.commit()
        flash("标签修改成功", "ok")
        redirect(url_for("admin.tag_edit", id=tag.id))
    return render_template("admin/tag_edit.html", form=form, tag=tag)

@admin.route("/tag/list/<int:page>/",methods = ["GET"])
@admin_login_req
def tag_list(page=None):
    """
    标签列表
    :return:
    """
    if page is None:
        page = 1
    page_data = Tag.query.order_by(
        Tag.addtime.desc()
    ).paginate(page=page,per_page=10)
    return render_template("admin/tag_list.html",page_data=page_data)

@admin.route("/tag/del/<int:id>/", methods=["GET"])
@admin_login_req
def tag_del(id=None):
    """
    标签的删除
    """
    tag = Tag.query.filter_by(id=id).first_or_404()
    db.session.delete(tag)
    db.session.commit()
    flash("标签【{0}】删除成功".format(tag.name), "ok")
    return redirect(url_for("admin.tag_list", page=1))


@admin.route("/movie/add/", methods=["GET", "POST"])
@admin_login_req
def movie_add():
    """
    添加电影页面
    """
    form = MovieForm()
    if form.validate_on_submit():
        data = form.data
        file_url = secure_filename(form.url.data.filename)
        file_logo = secure_filename(form.logo.data.filename)
        if not os.path.exists(app.config["UP_DIR"]):
            os.makedirs(app.config["UP_DIR"])
            os.chmod(app.config["UP_DIR"], "rw")
        url = change_filename(file_url)
        logo = change_filename(file_logo)
        form.url.data.save(app.config["UP_DIR"] + url)
        form.logo.data.save(app.config["UP_DIR"] + logo)
        movie = Movie(
            title=data["title"],
            url=url,
            info=data["info"],
            logo=logo,
            star=int(data["star"]),
            playnum=0,
            commentnum=0,
            tag_id=int(data["tag_id"]),
            area=data["area"],
            release_time=data["release_time"],
            length=data["length"]
        )
        db.session.add(movie)
        db.session.commit()
        flash("电影添加成功！", "ok")
        return redirect(url_for('admin.movie_add'))
    return render_template("admin/movie_add.html", form=form)

@admin.route("/movie/list/<int:page>/", methods=["GET"])
@admin_login_req
def movie_list(page=None):
    """
    电影列表页面
    """
    if page is None:
        page = 1
    page_data = Movie.query.join(Tag).filter(
        Tag.id == Movie.tag_id
    ).order_by(
        Movie.addtime.desc()
    ).paginate(page=page, per_page=10)
    return render_template("admin/movie_list.html", page_data=page_data)

@admin.route("/preview/add/")
@admin_login_req
def preview_add():
    return render_template("admin/preview_add.html")


@admin.route("/preview/list/")
@admin_login_req
def preview_list():
    return render_template("admin/preview_list.html")


@admin.route("/user/list/")
@admin_login_req
def user_list():
    return render_template("admin/user_list.html")


@admin.route("/user/view/")
@admin_login_req
def user_view():
    return render_template("admin/user_view.html")


@admin.route("/comment/list/")
@admin_login_req
def comment_list():
    return render_template("admin/comment_list.html")


@admin.route("/moviecol/list/")
@admin_login_req
def moviecol_list():
    return render_template("admin/moviecol_list.html")


@admin.route("/oplog/list/")
@admin_login_req
def oplog_list():
    return render_template("admin/oplog_list.html")


@admin.route("/adminloginlog/list")
@admin_login_req
def adminloginlog_list():
    return render_template("admin/adminloginlog_list.html")


@admin.route("/userloginlog/list")
@admin_login_req
def userloginlog_list():
    return render_template("admin/userloginlog_list.html")


@admin.route("/role/add/")
@admin_login_req
def role_add():
    return render_template("admin/role_add.html")


@admin.route("/role/list/")
@admin_login_req
def role_list():
    return render_template("admin/role_list.html")


@admin.route("/auth/add/")
@admin_login_req
def auth_add():
    return render_template("admin/auth_add.html")


@admin.route("/auth/list/")
@admin_login_req
def auth_list():
    return render_template("admin/auth_list.html")


@admin.route("/admin/add/")
@admin_login_req
def admin_add():
    return render_template("admin/admin_add.html")


@admin.route("/admin/List/")
@admin_login_req
def admin_list():
    return render_template("admin/admin_list.html")