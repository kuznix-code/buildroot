################################################################################
# Host running-kernel configuration
################################################################################

# When enabled, use the exact configuration of the kernel currently running
# on the build host. This deliberately uses /boot/config-$(uname -r) rather
# than scanning /boot/config-* so multiple installed host kernels do not
# select an arbitrary configuration.
ifeq ($(BR2_LINUX_KERNEL_USE_HOST_RUNNING_CONFIG),y)
ifeq ($(BR2_LINUX_KERNEL_USE_CUSTOM_CONFIG),y)
LINUX_HOST_CONFIG = /boot/config-$(shell uname -r)

ifeq ($(call qstrip,$(BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE)),)
ifeq ($(wildcard $(LINUX_HOST_CONFIG)),)
$(error Buildroot: running host kernel configuration not found: $(LINUX_HOST_CONFIG))
endif
LINUX_KCONFIG_FILE = $(LINUX_HOST_CONFIG)
else ifeq ($(call qstrip,$(BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE)),/boot/config-$$(uname -r))
ifeq ($(wildcard $(LINUX_HOST_CONFIG)),)
$(error Buildroot: running host kernel configuration not found: $(LINUX_HOST_CONFIG))
endif
LINUX_KCONFIG_FILE = $(LINUX_HOST_CONFIG)
endif
endif
endif
