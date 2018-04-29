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

PKG_NAME="SDL_ttf"
PKG_VERSION="2.0.11"
PKG_ARCH="any"
PKG_LICENSE="ZLIB"
PKG_SITE="http://www.libsdl.org/projects/SDL_ttf/"
PKG_URL="http://www.libsdl.org/projects/SDL_ttf/release/SDL_ttf-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain SDL freetype"
PKG_SECTION="lib"
PKG_SHORTDESC="sdl-ttf: truetype font library for SDL-1.2 with FreeType 2 support"
PKG_LONGDESC="SDL-ttf allows you to use TrueType fonts in your SDL applications."
PKG_AUTORECONF="no"

PKG_IS_ADDON="no"

PKG_CONFIGURE_OPTS_TARGET="--with-gnu-ld \
                           --without-x \
                           --with-freetype-prefix=${SYSROOT_PREFIX}/usr"
