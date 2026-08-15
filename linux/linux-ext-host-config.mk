################################################################################
# Host running-kernel configuration
################################################################################

# When enabled and the custom kernel configuration path is empty, use the exact
# running host kernel configuration. This deliberately uses
# /boot/config-$(uname -r) rather than scanning /boot/config-* so multiple
# installed host kernels do not select an arbitrary configuration.
ifeq ($(BR2_LINUX_KERNEL_USE_HOST_CONFIG),y)
ifeq ($(BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG),y)
LINUX_HOST_CONFIG = /boot/config-$(shell uname -r)

ifeq ($(call qstrip,$(BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE)),)
ifneq ($(wildcard $(LINUX_HOST_CONFIG)),)
LINUX_KCONFIG_FILE = $(LINUX_HOST_CONFIG)
endif
else ifeq ($(call qstrip,$(BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE)),/boot/config-$$(uname -r))
LINUX_KCONFIG_FILE = $(LINUX_HOST_CONFIG)
endif
endif
endif
