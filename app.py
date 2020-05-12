import os
from flask import Flask, render_template
import socket
# from healthcheck import HealthCheck, EnvironmentDump

app = Flask(__name__)

# # wrap the flask app and give a heathcheck url
# health = HealthCheck(app, "/health")
# envdump = EnvironmentDump(app, "/env")

@app.route('/')
def show_picture():
    pic_file = os.path.join('static', 'picture.jpg')
    hostname = socket.gethostname()
    app.logger.info('Container ID: %s', hostname)
    return render_template("index.html", picture=pic_file, hostname=hostname)

@app.route('/health')
def health_check():
    return {'message': 'Healthy'}
 
if __name__=="__main__":
    app.run(debug=True, threaded=True)