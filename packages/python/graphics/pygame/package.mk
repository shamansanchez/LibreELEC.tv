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

#  the upcoming stable version
#PKG_VERSION="1.9.2"
#PKG_URL="http://www.pygame.org/ftp/pygame-${PKG_VERSION}release.tar.gz"

PKG_NAME="pygame"
PKG_VERSION="aa82244e06e5"
PKG_ARCH="any"
PKG_LICENSE="LGPL-2.1"
PKG_SITE="http://www.pygame.org"
PKG_URL="https://bitbucket.org/pygame/pygame/get/$PKG_VERSION.tar.bz2"
PKG_SOURCE_DIR="pygame-pygame-$PKG_VERSION"
PKG_DEPENDS_TARGET="toolchain distutilscross:host SDL SDL_image SDL_ttf"
PKG_SECTION="python"
PKG_SHORTDESC="pygame: a set of Python modules designed for writing games and multimedia programs"
PKG_LONGDESC="Pygame is a Python wrapper module for the SDL multimedia library"
PKG_AUTORECONF="no"

PKG_IS_ADDON="no"

pre_configure_target() {

  cd $PKG_BUILD
  export PYTHONXCPREFIX="$SYSROOT_PREFIX/usr"
  export LOCALBASE="$SYSROOT_PREFIX/usr"
  export PYTHON_INCLUDES="$($SYSROOT_PREFIX/usr/bin/python2-config --includes)"
  export SDL_CONFIG="$SYSROOT_PREFIX/usr/bin/sdl-config"
  export FREETYPE_CONFIG="$SYSROOT_PREFIX/usr/bin/freetype-config"
  export LDSHARED="$CC -shared"
}

configure_target() {
  python config.py -auto
}

make_target() {
  python setup.py build --cross-compile
}

makeinstall_target() {
  python setup.py install --root=$INSTALL --prefix=/usr
}

post_makeinstall_target() {
  EXCLUDE="docs examples gp2x tests macosx* pygame_icon*"
  for exclude in $EXCLUDE; do
    rm -rf $INSTALL/usr/lib/python*/site-packages/pygame/$exclude
  done
}
