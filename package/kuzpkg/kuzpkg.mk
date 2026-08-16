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
# Generate .kuzpkg.tar.zst packages for selected Buildroot target packages
################################################################################

define KUZPKG_GENERATE_ALL_PACKAGES
	$(Q)mkdir -p $(BINARIES_DIR)/kuzpkg
	$(foreach pkg,$(PACKAGES),\
		$(if $(filter host-%,$(pkg)),,\
			$(if $(wildcard $($(call UPPERCASE,$(pkg))_DIR)/.files-list.txt),\
				$(Q)$(TOPDIR)/support/scripts/kuzpkg-build \
					--target "$(TARGET_DIR)" \
					--output "$(BINARIES_DIR)/kuzpkg" \
					--proto "$(KUZPKG_PKGDIR)/PKGBUILD.proto" \
					--file-list "$($(call UPPERCASE,$(pkg))_DIR)/.files-list.txt" \
					--pkgname "$(pkg)" \
					--pkgver "$(or $($(call UPPERCASE,$(pkg))_VERSION),1)" \
					--arch "$(BR2_ARCH)" \
					--url "$(or $($(call UPPERCASE,$(pkg))_SITE),https://buildroot.org/)" \
					--desc "Buildroot package $(pkg)" \
					--makepkg "$(HOST_DIR)/bin/makepkg"$(sep))))
endef

KUZPKG_TARGET_FINALIZE_HOOKS += KUZPKG_GENERATE_ALL_PACKAGES


################################################################################
# Build target package
################################################################################

$(eval $(meson-package))


################################################################################
# Build host package
################################################################################

$(eval $(host-meson-package))
