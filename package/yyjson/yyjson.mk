################################################################################
#
# yyjson
#
################################################################################

YYJSON_VERSION = 0.12.0
YYJSON_SITE = https://github.com/ibireme/yyjson/archive/$(YYJSON_VERSION)
YYJSON_SOURCE = yyjson-$(YYJSON_VERSION).tar.gz
YYJSON_LICENSE = MIT
YYJSON_LICENSE_FILES = LICENSE
YYJSON_INSTALL_STAGING = YES
YYJSON_CONF_OPTS = \
	-DYYJSON_BUILD_TESTS=OFF \
	-DBUILD_SHARED_LIBS=$(if $(BR2_STATIC_LIBS),OFF,ON)

$(eval $(cmake-package))
