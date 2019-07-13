import os
from flask import Flask, render_template

app = Flask(__name__)

@app.route('/')
def show_picture():
    pic_file = os.path.join('static', 'photo.jpg')
    return render_template("index.html", picture = pic_file)
 
if __name__=="__main__":
    app.run(debug=True)