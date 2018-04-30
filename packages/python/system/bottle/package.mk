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

PKG_NAME="bottle"
PKG_VERSION="0.12.13"
PKG_ARCH="any"
PKG_LICENSE="MIT"
PKG_SITE="http://www.pygame.org"
PKG_URL="https://github.com/bottlepy/$PKG_NAME/archive/$PKG_VERSION.zip"
PKG_DEPENDS_TARGET="toolchain distutilscross:host"
PKG_SECTION="python"
PKG_SHORTDESC="bottle.py is a fast and simple micro-framework for python web-applications"
PKG_LONGDESC="bottle.py is a fast and simple micro-framework for python web-applications"
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
