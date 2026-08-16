################################################################################
#
# fastfetch
#
################################################################################

FASTFETCH_VERSION = 2.67.1
FASTFETCH_SITE = https://github.com/fastfetch-cli/fastfetch/releases/download/$(FASTFETCH_VERSION)
FASTFETCH_SOURCE = $(FASTFETCH_VERSION).tar.gz
FASTFETCH_LICENSE = MIT
FASTFETCH_LICENSE_FILES = LICENSE
FASTFETCH_DEPENDENCIES = yyjson

FASTFETCH_CONF_OPTS = \
	-DENABLE_SYSTEM_YYJSON=ON \
	-DBUILD_FLASHFETCH=OFF \
	-DBUILD_TESTS=OFF \
	-DPACKAGES_REMOVE_DISABLED=ON \
	-DENABLE_DIRECTX_HEADERS=OFF \
	-DENABLE_WAYLAND=OFF \
	-DENABLE_XCB_RANDR=OFF \
	-DENABLE_XRANDR=OFF \
	-DENABLE_VULKAN=OFF \
	-DENABLE_GIO=OFF \
	-DENABLE_DCONF=OFF \
	-DENABLE_DBUS=OFF \
	-DENABLE_PULSE=OFF \
	-DENABLE_DRM=OFF \
	-DENABLE_DRM_AMDGPU=OFF

$(eval $(cmake-package))
