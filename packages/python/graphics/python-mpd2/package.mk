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

PKG_NAME="python-mpd2"
PKG_VERSION="0.5.5"
PKG_ARCH="any"
PKG_LICENSE="LGPL-3.0"
PKG_SITE="http://www.pygame.org"
PKG_URL="https://github.com/Mic92/$PKG_NAME/archive/v$PKG_VERSION.tar.gz"
PKG_DEPENDS_TARGET="toolchain distutilscross:host"
PKG_SECTION="python"
PKG_SHORTDESC="python-mpd2 is a Python library which provides a client interface for the Music Player Daemon"
PKG_LONGDESC="python-mpd2 is a Python library which provides a client interface for the Music Player Daemon"
PKG_AUTORECONF="no"

PKG_TOOLCHAIN="manual"

make_target() {
  python setup.py build --cross-compile
}

makeinstall_target() {
  python setup.py install --root=$INSTALL --prefix=/usr
}

post_makeinstall_target() {
  find $INSTALL/usr/lib -name "*.py" -exec rm -rf "{}" ";"

  rm -rf $INSTALL/usr/bin
}
