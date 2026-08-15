################################################################################
#
# kuzpkg
#
################################################################################

KUZPKG_VERSION = master
KUZPKG_SITE = https://github.com/Kuznix-Team/kuzpkg.git
KUZPKG_SITE_METHOD = git
KUZPKG_GIT_SUBMODULES = YES
KUZPKG_LICENSE = GPL-2.0+
KUZPKG_LICENSE_FILES = COPYING
KUZPKG_INSTALL_STAGING = YES

KUZPKG_DEPENDENCIES = \
	bash \
	libarchive \
	libcurl \
	gpgme \
	openssl \
	zstd

KUZPKG_CONF_OPTS = \
	-Duse-git-version=true \
	-Dcrypto=openssl \
	-Dcurl=enabled \
	-Dgpgme=enabled \
	-Ddoc=enabled \
	-Dpkg-ext=.kuzpkg.tar.zst

HOST_KUZPKG_DEPENDENCIES = \
	host-meson \
	host-ninja \
	host-libarchive \
	host-fakeroot \
	host-curl \
	host-gpgme \
	host-zstd \
	host-asciidoc

HOST_KUZPKG_CONF_OPTS = \
	-Duse-git-version=true \
	-Dcrypto=openssl \
	-Dcurl=enabled \
	-Dgpgme=enabled \
	-Ddoc=enabled \
	-Dpkg-ext=.kuzpkg.tar.zst

ifeq ($(BR2_PACKAGE_KUZPKG_AUTO_PACKAGE),y)
KUZPKG_BUILD_VERSION = $(subst -,.,$(BR2_VERSION_FULL))

define KUZPKG_GENERATE_SYSTEM_PACKAGE
	$(Q)mkdir -p $(BINARIES_DIR)
	$(Q)$(TOPDIR)/support/scripts/kuzpkg-build \
		--target "$(TARGET_DIR)" \
		--output "$(BINARIES_DIR)" \
		--proto "$(KUZPKG_PKGDIR)/PKGBUILD.proto" \
		--pkgname buildroot-system \
		--pkgver "$(KUZPKG_BUILD_VERSION)" \
		--arch "$(BR2_ARCH)" \
		--url "https://buildroot.org/" \
		--desc "Buildroot target filesystem generated from the selected configuration" \
		--makepkg "$(HOST_DIR)/bin/makepkg"
endef
KUZPKG_TARGET_FINALIZE_HOOKS += KUZPKG_GENERATE_SYSTEM_PACKAGE
endif

$(eval $(meson-package))
$(eval $(host-meson-package))
