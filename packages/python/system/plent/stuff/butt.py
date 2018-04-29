#!/usr/bin/python
import os
import time
import signal
from subprocess import call

from mpd import MPDClient
import RPi.GPIO as GPIO

def handler(signum, frame):
    pass

try:
    signal.signal(signal.SIGHUP, handler)
except AttributeError:
    pass

def prev_handler(channel):
    call(["/usr/bin/mpc","-h", "127.0.0.1", "cdprev"])

def playpause_handler(channel):
    call(["/usr/bin/mpc","-h", "127.0.0.1", "toggle"])

def random_handler(channel):
    call(["/usr/bin/mpc","-h", "127.0.0.1", "random"])

def next_handler(channel):
    call(["/usr/bin/mpc","-h", "127.0.0.1", "next"])

GPIO.setmode(GPIO.BCM)
GPIO.setup(27, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(23, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(22, GPIO.IN, pull_up_down=GPIO.PUD_UP)
GPIO.setup(17, GPIO.IN, pull_up_down=GPIO.PUD_UP)

GPIO.add_event_detect(27, GPIO.RISING, callback=prev_handler, bouncetime=300)
GPIO.add_event_detect(23, GPIO.RISING, callback=playpause_handler, bouncetime=300)
GPIO.add_event_detect(22, GPIO.RISING, callback=random_handler, bouncetime=300)
GPIO.add_event_detect(17, GPIO.RISING, callback=next_handler, bouncetime=300)

while 1:
    time.sleep(0.01)
