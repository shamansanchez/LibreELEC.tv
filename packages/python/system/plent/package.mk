################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2017 Stephan Raue (stephan@openelec.tv)
#
#  OpenELEC is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 2 of the License, or
#  (at your option) any later version.
#
#  OpenELEC is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.  If not, see <http://www.gnu.org/licenses/>.
################################################################################

PKG_NAME="plent"
PKG_VERSION="0.1"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_DEPENDS_TARGET="toolchain mpd mpd-mpc rpi-fbcp pygame python-mpd2 RPi.GPIO"
PKG_SECTION="python/system"
PKG_SHORTDESC="plent"
PKG_LONGDESC="plent"
PKG_TOOLCHAIN="manual"

pre_make_target() {
  :
}

make_target() {
  :
}

makeinstall_target() {
  :
}

post_makeinstall_target() {
  mkdir -p $INSTALL/opt/plent
  mkdir -p $INSTALL/usr/bin

  cp $PKG_DIR/stuff/NotoSansCJKjp-Black.otf $INSTALL/opt/plent
  cp $PKG_DIR/stuff/NotoSansCJKjp-Bold.otf $INSTALL/opt/plent

  cp $PKG_DIR/stuff/plent.py $INSTALL/usr/bin
  cp $PKG_DIR/stuff/butt.py $INSTALL/usr/bin
  cp $PKG_DIR/stuff/dog.py $INSTALL/usr/bin

  chmod 755 $INSTALL/usr/bin/plent.py
  chmod 755 $INSTALL/usr/bin/butt.py
  chmod 755 $INSTALL/usr/bin/dog.py
}

post_install() {
  enable_service butt.service
  enable_service plent.service
}
