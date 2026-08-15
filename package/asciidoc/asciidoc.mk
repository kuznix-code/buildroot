################################################################################
#
# asciidoc
#
################################################################################

ASCIIDOC_VERSION = 10.2.1
ASCIIDOC_SOURCE = asciidoc-$(ASCIIDOC_VERSION).tar.gz
ASCIIDOC_SITE = https://files.pythonhosted.org/packages/1d/73/6d0a1f7f6e6c4f8b4b9f3c3c8b7a9f0a0f0a7a9e5e1d2c2f2f4d4e0e5e5e6
ASCIIDOC_LICENSE = GPL-2.0+
ASCIIDOC_LICENSE_FILES = COPYING
ASCIIDOC_SETUP_TYPE = setuptools

HOST_ASCIIDOC_DEPENDENCIES = host-python3

$(eval $(host-python-package))
