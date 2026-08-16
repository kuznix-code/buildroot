################################################################################
#
# asciidoc
#
################################################################################

ASCIIDOC_VERSION = 10.2.1
ASCIIDOC_SOURCE = v$(ASCIIDOC_VERSION).tar.gz
ASCIIDOC_SITE = https://github.com/asciidoc-py/asciidoc-py/releases/download/$(ASCIIDOC_VERSION)
ASCIIDOC_LICENSE = GPL-2.0+
ASCIIDOC_LICENSE_FILES = COPYING
ASCIIDOC_SETUP_TYPE = setuptools

HOST_ASCIIDOC_DEPENDENCIES = host-python3

$(eval $(host-python-package))
