################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
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

PKG_NAME="rpi-fbcp"
PKG_VERSION="8087a71d0330a078d91aa78656684ab5313616c6"
PKG_SHA256="2e7475dad8c489ccbd2d0a710bc88cf914a7a8d5ab9474bf1686a2a0da62b566"
PKG_ARCH="any"
PKG_LICENSE="OSS"
PKG_SITE="https://github.com/tasanakorn/rpi-fbcp"
PKG_URL="https://github.com/tasanakorn/rpi-fbcp/archive/8087a71d0330a078d91aa78656684ab5313616c6.zip"
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="graphics"
PKG_SHORTDESC="fbcp"
PKG_LONGDESC="fbcp"
PKG_TOOLCHAIN="manual"

make_target() {
	mkdir build
	cd build
	cmake $PKG_BUILD
  make
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/bin
  install fbcp $INSTALL/usr/bin
}

post_install() {
  enable_service fbcp.service
}
