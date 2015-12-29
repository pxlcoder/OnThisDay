from flask import Flask
import api
import datetime

app = Flask(__name__)

@app.route("/onthisday")
def today():
	now = datetime.datetime.now()
	data = api.getInformation(now.month,now.day)
	return data, 200, {'Content-Type': 'application/json; charset=utf-8'}

@app.route("/onthisday/<int:month>/<int:day>")
def anyday(month,day):
	data = api.getInformation(month,day)
	return data, 200, {'Content-Type': 'application/json; charset=utf-8'}

if __name__ == "__main__":
	app.run()