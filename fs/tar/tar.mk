################################################################################
#
# tar to archive target filesystem
#
################################################################################

TAR_OPTS = $(call qstrip,$(BR2_TARGET_ROOTFS_TAR_OPTIONS))

ROOTFS_TAR_DEPENDENCIES = $(BR2_TAR_HOST_DEPENDENCY)

# do not store atime/ctime in PaxHeaders to ensure reproducbility
TAR_OPTS += --pax-option=exthdr.name=%d/PaxHeaders/%f,atime:=0,ctime:=0

define ROOTFS_TAR_CMD
	(cd $(TARGET_DIR); find -print0 | LC_ALL=C sort -z | \
		$(TAR) $(TAR_OPTS) -cf $@ --null --xattrs-include='*' --no-recursion -T - --numeric-owner)
endef

# Append the contents of an already-built package archive to an existing
# rootfs tarball. The helper transparently handles the supported compression
# formats and replaces the tarball only after the append succeeds.
.PHONY: rootfs-tar-append-package
rootfs-tar-append-package:
	@test -n "$(call qstrip,$(ROOTFS_TAR_APPEND_PACKAGE))" || \
		{ echo "Usage: make rootfs-tar-append-package ROOTFS_TAR_APPEND_PACKAGE=/path/to/package.tar[.*]" >&2; exit 1; }
	@test -n "$(call qstrip,$(ROOTFS_TAR_APPEND_FILE))" || \
		{ echo "Usage: make rootfs-tar-append-package ROOTFS_TAR_APPEND_FILE=$(BINARIES_DIR)/rootfs.tar[.*]" >&2; exit 1; }
	@$(TOPDIR)/support/scripts/rootfs-tar-append-package \
		"$(call qstrip,$(ROOTFS_TAR_APPEND_FILE))" \
		"$(call qstrip,$(ROOTFS_TAR_APPEND_PACKAGE))"

$(eval $(rootfs))
