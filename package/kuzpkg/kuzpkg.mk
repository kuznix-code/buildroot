################################################################################
#
# kuzpkg
#
################################################################################

KUZPKG_VERSION = 0.1.0-alpha
KUZPKG_SITE = https://github.com/Kuznix-Team/kuzpkg/archive/refs/tags
KUZPKG_SOURCE = $(KUZPKG_VERSION).tar.gz
KUZPKG_LICENSE = GPL-2.0+
KUZPKG_LICENSE_FILES = COPYING
KUZPKG_INSTALL_STAGING = YES

KUZPKG_DEPENDENCIES = \
	bash \
	libarchive \
	libcurl \
	gnupg \
	openssl \
	zstd

KUZPKG_CONF_OPTS = \
	-Duse-git-version=false \
	-Dcrypto=openssl \
	-Dcurl=enabled \
	-Dgpgme=disabled \
	-Ddoc=enabled \
	-Dpkg-ext=.kuzpkg.tar.zst

HOST_KUZPKG_DEPENDENCIES = \
	host-meson \
	host-ninja \
	host-libarchive \
	host-fakeroot \
	host-gnupg \
	host-asciidoc \
	host-zstd

HOST_KUZPKG_CONF_OPTS = \
	-Duse-git-version=false \
	-Dcrypto=openssl \
	-Dcurl=disabled \
	-Dgpgme=disabled \
	-Ddoc=enabled \
	-Dpkg-ext=.kuzpkg.tar.zst


################################################################################
# Build target package
################################################################################

$(eval $(meson-package))


################################################################################
# Build host package
################################################################################

$(eval $(host-meson-package))
