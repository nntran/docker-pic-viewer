import os
from flask import Flask, render_template
import socket

app = Flask(__name__)
hostname = socket.gethostname()

@app.route('/')
def show_picture():
    pic_file = os.path.join('static', 'photo.jpg')
    return render_template("index.html", picture=pic_file, hostname=hostname)
 
if __name__=="__main__":
    app.logger.info('Container ID: %s', hostname)
    app.run(debug=True, threaded=True)