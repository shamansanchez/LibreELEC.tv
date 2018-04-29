#!/usr/bin/python2
import pygame
import base64
import os
import sys

SDOG_SIZE = (22 * 4,19 * 4)
BDOG_SIZE = (22 * 15,19 * 15)

SCREEN_SIZE = (640,480)

DOG1_STR = """
AAAAAAAAAAAAAAD/AAAAAAAAAP8AAAD/AAAA/wAAAP8AAAAAAAAA/wAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD//////wAAAP//////////////
////////AAAA//////8AAAD/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAA////////////////////////////////////////////AAAA/wAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP//////////////////
//////////////////////////////8AAAD/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAP///////////wAAAP///////////wAAAP//////////////////////AAAA
/wAAAP8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP8AAAAAAAAAAAAAAAAAAAD/////////////////
////////////////////////////////////////////////AAAA/wAAAP8AAAAAAAAAAAAAAP//
////AAAA/wAAAAAAAAAAAAAA/////////////////wAAAP8AAAD/////////////////////////
////////////////////////AAAA/wAAAP8AAAD//////wAAAP8AAAAAAAAAAAAAAP//////AAAA
//////8AAAD///////////8AAAD/////////////////////////////////////////////////
//////////8AAAD/AAAAAAAAAAAAAAD///////////8AAAD/AAAA/wAAAP8AAAD/////////////
////////////////////////////////////////////////////AAAA/wAAAAAAAAAAAAAA////
////////////////////////////////////////////////////////////////////////////
/////////////////wAAAP8AAAAAAAAAAAAAAP//////////////////////////////////////
//////////////////////////////////////////////////////////8AAAD/AAAAAAAAAAAA
AAD/////////////////////////////////////////////////////////////////////////
////////////////////////AAAA/wAAAAAAAAAAAAAA////////////////////////////////
/////////////////////////////////////////////////////////////////wAAAP8AAAAA
AAAAAAAAAP//////////////////////////////////////////////////////////////////
/////////////////////////wAAAP8AAAAAAAAAAAAAAAAAAAAAAAAA////////////////////
//////////////////////////////////////////////////////////////////8AAAD/AAAA
AAAAAAAAAAAAAAAAAAAAAP///////////wAAAP8AAAD///////////8AAAD/AAAA/wAAAP8AAAD/
//////////8AAAD/AAAA////////////AAAA/wAAAAAAAAAAAAAAAAAAAAAAAAD//////wAAAP8A
AAAAAAAA////////////AAAA/wAAAAAAAAAAAAAA////////////AAAA/wAAAP//////AAAA/wAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP8AAAAAAAAAAAAAAP//////AAAA/wAAAAAAAAAAAAAA
AAAAAP//////AAAA/wAAAAAAAAAAAAAA/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAA/wAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA/wAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAA==
"""

DOG2_STR = """
AAAAAAAAAAAAAAD/AAAAAAAAAP8AAAD/AAAA/wAAAP8AAAAAAAAA/wAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD//////wAAAP//////////////
////////AAAA//////8AAAD/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAA////////////////////////////////////////////AAAA/wAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP//////////////////
//////////////////////////////8AAAD/AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAP///////////wAAAP///////////wAAAP//////////////////////AAAA
/wAAAP8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD/////////////////
////////////////////////////////////////////////AAAA/wAAAP8AAAAAAAAAAAAAAAAA
AAAAAAAAAAAAAAAAAAAAAAAA/////////////////wAAAP8AAAD/////////////////////////
////////////////////////AAAA/wAAAP8AAAD/AAAA/wAAAP8AAAD/AAAAAAAAAP//////AAAA
//////8AAAD///////////8AAAD/////////////////////////////////////////////////
/////////////////////wAAAP8AAAD///////////8AAAD/AAAA/wAAAP8AAAD/////////////
////////////////////////////////////////////////////AAAA/wAAAP8AAAAAAAAA////
////////////////////////////////////////////////////////////////////////////
/////////////////wAAAP8AAAAAAAAAAAAAAP//////////////////////////////////////
//////////////////////////////////////////////////////////8AAAD/AAAAAAAAAAAA
AAD/////////////////////////////////////////////////////////////////////////
////////////////////////AAAA/wAAAAAAAAAAAAAA////////////////////////////////
/////////////////////////////////////////////////////////////////wAAAP8AAAAA
AAAAAAAAAP//////////////////////////////////////////////////////////////////
/////////////////////////wAAAP8AAAAAAAAAAAAAAAAAAAAAAAAA////////////////////
//////////////////////////////////////////////////////////////////8AAAD/AAAA
AAAAAAAAAAAAAAAAAAAAAP///////////wAAAP8AAAD///////////8AAAD/AAAA/wAAAP8AAAD/
//////////8AAAD/AAAA////////////AAAA/wAAAAAAAAAAAAAAAAAAAAAAAAD///////////8A
AAD/AAAA//////8AAAD/AAAAAAAAAAAAAAAAAAAA//////8AAAD/AAAAAAAAAP///////////wAA
AP8AAAAAAAAAAAAAAAAAAAAAAAAA//////8AAAD/AAAAAAAAAAAAAAD/AAAAAAAAAAAAAAAAAAAA
AAAAAAAAAAD/AAAAAAAAAAAAAAD//////wAAAP8AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAD/
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAP8A
AAAAAAAAAAAAAAAAAAAAAAAAAA==
"""

class Dog(pygame.sprite.Sprite):
    def __init__(self, width, height, delay, initx = 0, inity = 0):
        pygame.sprite.Sprite.__init__(self)

        dog1 = pygame.image.fromstring(base64.decodestring(DOG1_STR), (22,19), "RGBA").convert_alpha()
        dog2 = pygame.image.fromstring(base64.decodestring(DOG2_STR), (22,19), "RGBA").convert_alpha()
        sdog1 = pygame.transform.scale(dog1, (width, height))
        sdog2 = pygame.transform.scale(dog2, (width, height))

        self.images = [sdog1, sdog2]
        self.tick = 0
        self.index = 0

        self.width, self.height = width, height
        self.x = initx
        self.delay = delay

        self.image = self.images[self.index]
        self.rect  = pygame.Rect(initx,inity, self.width, self.height)

    def update(self, delta, deltax):
        self.tick += delta
        if self.tick >= self.delay:
            self.index ^= 1
            self.image = self.images[self.index]
            self.tick = 0

        self.x += deltax
        self.rect.x = int(self.x)

def main():
    pygame.init()
    pygame.mouse.set_visible(False)
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

    SCREEN_SIZE = (pygame.display.Info().current_w, pygame.display.Info().current_h)
    win = pygame.display.set_mode(SCREEN_SIZE, pygame.FULLSCREEN)
    clock = pygame.time.Clock()

    dogs = pygame.sprite.Group()
    numdogs = (SCREEN_SIZE[0] / BDOG_SIZE[0]) + 2
    dogs.add([Dog(BDOG_SIZE[0],BDOG_SIZE[1],0.15, x + SCREEN_SIZE[0],SCREEN_SIZE[1] / 2 - (BDOG_SIZE[1] / 2)) for x in range(0,numdogs * BDOG_SIZE[0],BDOG_SIZE[0])])

    bdogs = pygame.sprite.Group()
    bdogs.add([Dog(SDOG_SIZE[0],SDOG_SIZE[1],0.27,x,y) for x in range(0,SCREEN_SIZE[0],SDOG_SIZE[0]) for y in range(0,SCREEN_SIZE[1],SDOG_SIZE[1])])

    while 1:
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                sys.exit()
        win.fill(pygame.Color(255,255,255))

        delta = clock.tick(30)

        delta /= 1000.0

        bdogs.update(delta, 0)

        bdogs.draw(win)

        for d in dogs:
            d.update(delta, -(delta * 50.0))
            if d.x <= -BDOG_SIZE[0]:
                d.x += BDOG_SIZE[0] * numdogs

        dogs.draw(win)
        pygame.display.update()

if __name__ == "__main__":
    main()
