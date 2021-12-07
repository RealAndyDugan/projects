import logging, time, uuid, requests, base64
import pysnap
import snap
import constants

def do_login():
	name = request.forms.get('username')
	password = request.forms.get('password')
	friend = request.forms.get('friend')
	pic = "tlo.jpg"
	s = Snapchat()
	s.login(name, password)

	# Send a snapchat
	media_id = s.upload(Snapchat.MEDIA_IMAGE, pic)
	s.send(media_id, friend)