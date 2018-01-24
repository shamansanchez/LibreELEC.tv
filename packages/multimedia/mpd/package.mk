################################################################################
#      This file is part of LibreELEC - https://libreelec.tv
#      Copyright (C) 2016-present Team LibreELEC
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="mpd"
PKG_VERSION="0.20.15"
PKG_SHA256="c69c4f67e665380ea3bbde6cff8958edc85f7cd40e7918ae5ce0a2184ca9eb40"
PKG_REV="104"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.musicpd.org"
PKG_URL="http://www.musicpd.org/download/${PKG_NAME}/${PKG_VERSION%.*}/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain alsa-lib boost curl faad2 ffmpeg flac glib lame libcdio libiconv libid3tag \
                    libmad libmpdclient libvorbis libnfs libogg opus samba yajl"
PKG_SECTION="service.multimedia"
PKG_SHORTDESC="Music Player Daemon (MPD): a free and open Music Player Server"
PKG_LONGDESC="Music Player Daemon ($PKG_VERSION) is a flexible and powerful server-side application for playing music"

pre_configure_target() {
  export LIBS="$LIBS -logg -lFLAC -ldl"
}

PKG_CONFIGURE_OPTS_TARGET=" \
  --enable-aac \
  --disable-adplug \
  --enable-alsa \
  --disable-ao \
  --disable-audiofile \
  --enable-bzip2 \
  --disable-cdio-paranoia \
  --enable-cue \
  --enable-curl \
  --enable-database \
  --disable-debug \
  --disable-documentation \
  --enable-expat \
  --enable-ffmpeg \
  --enable-flac \
  --disable-fluidsynth \
  --disable-gme \
  --disable-haiku \
  --enable-httpd-output \
  --enable-iconv \
  --disable-icu \
  --enable-id3 \
  --enable-iso9660 \
  --disable-jack \
  --enable-lame-encoder \
  --enable-libmpdclient \
  --disable-libwrap \
  --enable-lsr \
  --enable-mad \
  --disable-mikmod\
  --disable-mms \
  --disable-modplug \
  --disable-mpc \
  --disable-mpg123 \
  --enable-nfs \
  --disable-openal \
  --enable-opus \
  --disable-oss \
  --enable-pipe-output \
  --disable-pulse \
  --disable-recorder-output \
  --disable-roar \
  --disable-shout \
  --disable-shine-encoder \
  --disable-sidplay \
  --enable-smbclient \
  --enable-sndfile \
  --disable-sndio \
  --disable-solaris-output \
  --enable-soundcloud \
  --enable-soxr \
  --enable-sqlite \
  --disable-syslog \
  --disable-systemd-daemon \
  --disable-test \
  --disable-twolame-encoder \
  --disable-upnp \
  --enable-vorbis \
  --enable-vorbis-encoder \
  --disable-wavpack \
  --enable-webdav \
  --disable-wildmidi \
  --enable-zlib \
  --with-zeroconf=no"

post_makeinstall_target() {
  mkdir -p $INSTALL/etc
  mkdir -p $INSTALL/usr/bin

  cp $PKG_DIR/config/mpd.conf $INSTALL/etc/
  cp $PKG_DIR/config/mpd_startup.sh $INSTALL/usr/bin
  chmod 755 $INSTALL/usr/bin/mpd_startup.sh

  mkdir -p $INSTALL/var/media/plent
}

post_install() {
  enable_service mpd.service
  enable_service var-media-plent.mount
}
