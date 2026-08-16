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
	gpgme2 \
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

# Generate one .kuzpkg.tar.zst for every selected target package. The generic
# package infrastructure already records each package's target file list in
# .files-list.txt, so no changes are required in the ~3,000 package .mk files.
# Host packages are excluded because they are not part of TARGET_DIR.
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

$(eval $(meson-package))
$(eval $(host-meson-package))
