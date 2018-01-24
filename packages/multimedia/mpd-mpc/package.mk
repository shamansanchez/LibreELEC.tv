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

PKG_NAME="mpd-mpc"
PKG_VERSION="0.28"
PKG_SHA256="a4337d06c85dc81a638821d30fce8a137a58d13d510be34a11c1cce95cabc547"
PKG_REV="104"
PKG_ARCH="any"
PKG_LICENSE="GPL"
PKG_SITE="https://www.musicpd.org"
PKG_URL="http://www.musicpd.org/download/mpc/0/mpc-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain mpd"
PKG_SECTION="service.multimedia"
PKG_SHORTDESC="MPD Client"
PKG_LONGDESC="mpc ($PKG_VERSION) is a thing."
PKG_SOURCE_DIR="mpc-${PKG_VERSION}"
