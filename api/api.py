import re, urllib2, json

def validateDate(month,day):
	if month > 12 or month < 1:
		return False

	return True

def constructDate(month,day):
	baseURL = "https://en.wikipedia.org/wiki/"
	months = {1:'January', 2:'February', 3:'March', 4:'April', 5:'May', 6:'June', 7:'July', 8:'August', 9:'September', 10:'October', 11:'November', 12:'December'}

	return baseURL + months[month] + "_" + str(day)

def getRawData(month,day):
	info = urllib2.urlopen(constructDate(month,day))
	return info.read()

def cleanHTML(rawData):
  	cleaner = re.compile('<.*?>')
  	cleanedData = re.sub(cleaner,'',rawData)

  	return cleanedData

def makeDict(array):
	data = []

	for i in range(len(array)):
		if "\xe2\x80\x93" in array[i]:
			year = array[i][0:array[i].index("\xe2\x80\x93")-1]
			info = array[i][array[i].index("\xe2\x80\x93")+4:len(array[i])]

			data.append({year: info})

	return data

def getInformation(month,day):

	if not validateDate(month,day):
		return None

	cleanedData = cleanHTML(getRawData(month,day))

	eventStr = cleanedData[cleanedData.index('Events[edit]'):cleanedData.index('Births[edit]')].split("\n")
	birthStr = cleanedData[cleanedData.index('Births[edit]'):cleanedData.index('Deaths[edit]')].split("\n")
	deathStr = cleanedData[cleanedData.index('Deaths[edit]'):cleanedData.index('Holidays and observances[edit]')].split("\n")

	events = makeDict(eventStr[2:len(eventStr)-2])
	births = makeDict(birthStr[2:len(birthStr)-2])
	deaths = makeDict(deathStr[2:len(deathStr)-2])

	return json.dumps({"events": events, "births": births, "deaths": deaths}, ensure_ascii=False)