# app.py


from flask import Flask
from flask import request, render_template
from flask.ext.sqlalchemy import SQLAlchemy
from src.config import BaseConfig
from src.db.models import *


app = Flask(__name__)
app.config.from_object(BaseConfig)
db = SQLAlchemy(app)


@app.route('/healthcheck')
def healthcheck():
    return jsonify({'status': 'ok'}), 200


@app.route('/posts', methods=['POST'])
def add_post():
    text = request.form['text']
    post = Post(text)
    db.session.add(post)
    db.session.commit()

    return jsonify(post), 200


@app.route('/posts', methods=['GET'])
def get_posts():
    posts = Post.query.order_by(Post.date_posted.desc()).all()
    return jsonify(posts), 200

if __name__ == '__main__':
    app.run()
