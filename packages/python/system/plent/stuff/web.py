#!/usr/bin/python
import os

from bottle import route, run, static_file, response, install, redirect
from mpd import MPDClient

def mpdclient(callback):
    def wrapper(*args, **kwargs):
        client = MPDClient(use_unicode=True)
        client.connect("127.0.0.1",6600)
        kwargs['client'] = client
        body = callback(*args, **kwargs)
        return body
    return wrapper

install(mpdclient)


@route('/song')
def song(client):
    return {
            "song": client.currentsong(),
            "status": client.status()
            }


@route('/art')
def art(client):
    song = client.currentsong()
    album_art = os.path.dirname("/var/media/plent/" + song.get('file','nope')) + "/cover.jpg"
    print(album_art)
    return static_file(album_art, root="/")


@route('/next')
def next(client):
    client.next()
    redirect("/song")


@route('/prev')
def prev(client):
    client.previous()
    redirect("/song")


@route('/play/<song_id>')
def play(client, song_id):
    s = int(song_id)
    client.play(s)
    redirect("/song")


@route('/songs')
def songs(client):
    playlist = client.playlistinfo()
    print(playlist)

    output = []

    for song in playlist:
        album = song.get('album').encode("UTF-8")
        title = song.get('title').encode("UTF-8")
        pos = song['pos']

        artist = song.get('artist')
        if isinstance(artist, (list,)):
            artist = " + ".join(artist).encode("UTF-8")
        else:
            artist = artist.encode("UTF-8")

        output.append("<p><a href='/play/{}'>{} - {} - {}</a></p>".format(song['pos'], artist, album, title))
    return output

run(host='0.0.0.0', port=80)
