################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016 Team LibreELEC
#
#  LibreELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  LibreELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with LibreELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="SDL"
PKG_VERSION="1.2.15"
PKG_ARCH="any"
PKG_LICENSE="LGPL-2.1"
PKG_SITE="http://www.libsdl.org"
PKG_URL="http://www.libsdl.org/release/SDL-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="lib"
PKG_SHORTDESC="libsdl: a cross-platform Graphic API"
PKG_LONGDESC="SDL (Simple DirectMedia Layer) is a cross-platform multimedia library designed to provide fast access to the graphics framebuffer and audio device. It is used by MPEG playback software, emulators, and many popular games, including the award winning Linux port of 'Civilization: Call To Power.' Simple DirectMedia Layer supports Linux, Win32, BeOS, MacOS, Solaris, IRIX, and FreeBSD."
PKG_AUTORECONF="no"

PKG_IS_ADDON="no"

PKG_CONFIGURE_OPTS_TARGET="
            --enable-libc \
            --disable-audio \
            --enable-video \
            --disable-events \
            --enable-joystick \
            --disable-cdrom \
            --enable-threads \
            --enable-timers \
            --enable-file \
            --enable-loadso \
            --enable-cpuinfo \
            --enable-assembly \
            --disable-oss \
            --disable-alsa \
            --disable-pulseaudio \
            --disable-esd \
            --disable-esdtest \
            --disable-esd-shared \
            --disable-arts \
            --disable-arts-shared \
            --disable-nas \
            --disable-diskaudio \
            --disable-mintaudio \
            --enable-nasm \
            --disable-altivec \
            --disable-ipod \
            --disable-video-nanox \
            --disable-nanox-debug \
            --disable-nanox-share-memory \
            --disable-nanox-direct-fb \
            --disable-x11-shared \
            --disable-dga \
            --disable-video-dga \
            --disable-video-x11-dgamouse \
            --disable-video-x11-xinerama \
            --disable-video-x11-xme \
            --disable-video-x11-xrandr \
            --disable-video-photon \
            --disable-video-carbon \
            --disable-video-cocoa \
            --enable-video-fbcon \
            --disable-video-directfb \
            --disable-video-ps2gs \
            --disable-video-ps3 \
            --disable-video-ggi \
            --disable-video-svga \
            --disable-video-vgl \
            --disable-video-wscons \
            --disable-video-aalib \
            --disable-video-qtopia \
            --disable-video-picogui \
            --disable-osmesa-shared \
            --disable-input-events \
            --disable-input-tslib \
            --disable-pth \
            --enable-pthreads \
            --enable-pthread-sem \
            --disable-stdio-redirect \
            --disable-directx \
            --enable-sdl-dlopen \
            --disable-atari-ldg \
            --disable-clock_gettime \
            --disable-video-x11 \
            --disable-video-x11-vm \
            --disable-video-x11-xv \
            --without-x \
            --disable-dummyaudio \
			--disable-video-dummy \
            --disable-video-opengl"

post_makeinstall_target() {
  $SED "s:\(['=\" ]\)/usr:\\1$SYSROOT_PREFIX/usr:g" $SYSROOT_PREFIX/usr/bin/sdl-config
}
