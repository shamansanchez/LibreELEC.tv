#!/usr/bin/python
import os
import time
import signal

import pygame
from mpd import MPDClient

import RPi.GPIO as GPIO

def handler(signum, frame):
    pass

try:
    signal.signal(signal.SIGHUP, handler)
except AttributeError:
    pass

client = MPDClient(use_unicode=True)
client.connect("127.0.0.1",6600)

pygame.init()
pygame.mouse.set_visible(False)
clock = pygame.time.Clock()
drivers = ['directfb', 'fbcon', 'svgalib']

found = False
for driver in drivers:
    if not os.getenv('SDL_VIDEODRIVER'):
        os.putenv('SDL_VIDEODRIVER', driver)
    try:
        pygame.display.init()
    except pygame.error:
        print 'Driver: {0} failed.'.format(driver)
        continue
    found = True
    break

if not found:
   raise Exception('No suitable video driver found!')


size = (pygame.display.Info().current_w, pygame.display.Info().current_h)
screen = pygame.display.set_mode(size, pygame.FULLSCREEN)

# font = pygame.font.Font("Lato-Medium.ttf", 30)
# font_black = pygame.font.Font("Lato-Black.ttf", 30)
font = pygame.font.Font("/opt/plent/NotoSansCJKjp-Bold.otf", 30)
font_black = pygame.font.Font("/opt/plent/NotoSansCJKjp-Black.otf", 40)

pos = "wat"

while 1:
    for event in pygame.event.get():
            if event.type == pygame.QUIT:
                sys.exit()


    delta = clock.tick(4)
    delta /= 1000.0

    song = client.currentsong()
    status = client.status()

    font_color = pygame.Color(255,255,255)
    title_pos = (15,300)
    artist_pos = (15,360)
    album_pos = (15,400)
    track_pos = (15,10)

    shuffle_pos = (600, 5)

    if pos != song.get('pos', 'no'):
        pos = song.get('pos', 'no')
        album_art = os.path.dirname("/var/media/plent/" + song.get('file','nope')) + "/cover.jpg"
        album_art = album_art.encode('utf-8')
        print(album_art)

        background_color = pygame.Color(0,0,0)

        if os.path.exists(album_art):
            art = pygame.image.load(album_art)
            art = pygame.transform.smoothscale(art,(art.get_width()/art.get_height() * 480,480))
            print("woo")
            print(art)
            background_color = pygame.transform.average_color(art)

        else:
            screen.fill(background_color)
            pygame.display.update()
            continue

        screen.fill(background_color)
        art_rect = art.get_rect(center=(320,240))
        screen.blit(art, art_rect)

        title = font_black.render(song.get('title', '...'), True, font_color)
        title_back = font_black.render(song.get('title', '...'), True, pygame.Color(0,0,0))

        track = font_black.render(song.get('track', '...'), True, font_color)
        track_back = font_black.render(song.get('track', '...'), True, pygame.Color(0,0,0))

        try:
            artist = font.render(song.get('artist', '...'), True, font_color)
            artist_back = font.render(song.get('artist', '...'), True, pygame.Color(0,0,0))
        except:
            artist = font.render('...', True, font_color)
            artist_back = font.render('...', True, pygame.Color(0,0,0))

        album = font.render(song.get('album', '...'), True, font_color)
        album_back = font.render(song.get('album', '...'), True, pygame.Color(0,0,0))


        # screen.blit(title, title.get_rect(center=(320,340)))
        # screen.blit(artist, artist.get_rect(center=(320,380)))
        # screen.blit(album, album.get_rect(center=(320,420)))


        for back_pos in [(2,0), (2,-2), (0,-2), (-2,-2), (-2,0), (-2,2), (0,2), (2,2)]:
            screen.blit(title_back, tuple(sum(i) for i in zip(title_pos, back_pos)))
            screen.blit(artist_back, tuple(sum(i) for i in zip(artist_pos, back_pos)))
            screen.blit(album_back, tuple(sum(i) for i in zip(album_pos, back_pos)))
            screen.blit(track_back, tuple(sum(i) for i in zip(track_pos, back_pos)))

        screen.blit(title, title_pos)
        screen.blit(artist, artist_pos)
        screen.blit(album, album_pos)
        screen.blit(track, track_pos)

    if status['random'] == '1':
        shuffle_color = font_color
    else:
        shuffle_color = pygame.Color(20,20,20)

    shuffle = font_black.render("S", True, shuffle_color)
    shuffle_back = font_black.render("S", True, pygame.Color(0,0,0))

    for back_pos in [(2,0), (2,-2), (0,-2), (-2,-2), (-2,0), (-2,2), (0,2), (2,2)]:
        screen.blit(shuffle_back, tuple(sum(i) for i in zip(shuffle_pos, back_pos)))

    screen.blit(shuffle, shuffle_pos)

    elapsed = status.get('elapsed', 0)
    duration = status.get('duration', 1)
    pygame.draw.rect(screen, (0, 0, 0), [0, 457, 640 * (float(elapsed) / float(duration)) + 3, 480])
    pygame.draw.rect(screen, (255, 255, 255), [0, 460, 640 * (float(elapsed) / float(duration)), 480])

    pygame.display.update()
