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

PKG_NAME="SDL_image"
PKG_VERSION="1.2.12"
PKG_ARCH="any"
PKG_LICENSE="ZLIB"
PKG_SITE="http://www.libsdl.org/projects/SDL_ttf/"
PKG_URL="http://www.libsdl.org/projects/SDL_image/release/SDL_image-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain SDL zlib giflib libjpeg-turbo libpng"
PKG_SECTION="lib"
PKG_SHORTDESC="sdl-image: an image file loading library for SDL-1.2"
PKG_LONGDESC="SDL-image loads images as SDL surfaces, and supports the following formats: BMP, GIF, JPEG, LBM, PCX, PNG, PNM, TGA, TIFF, WEBP, XCF, XPM, XV"
PKG_AUTORECONF="no"

PKG_IS_ADDON="no"

PKG_CONFIGURE_OPTS_TARGET="--enable-bmp \
                           --enable-jpg \
                           --enable-png \
                           --disable-png-shared \
                           --enable-gif \
                           --disable-jpg-shared \
                           --disable-lbm \
                           --disable-pcx \
                           --disable-pnm \
                           --disable-tga \
                           --disable-tif \
                           --disable-tif-shared \
                           --disable-xcf \
                           --disable-xpm \
                           --disable-xv"
