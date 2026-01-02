
##############################################################
#
# LDD Package Makefile
#
##############################################################

LDD_VERSION = 5165ddf0ba8f812de5324e7c070ee3b7c09ac7f3
LDD_SITE = git@github.com:cu-ecen-aeld/assignment-7-ahmedwefky.git
LDD_SITE_METHOD = git
LDD_GIT_SUBMODULES = YES
# Ensure that the linux headers are built before building ldd modules
LDD_DEPENDENCIES = linux

define LDD_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/scull modules KERNELDIR=$(LINUX_DIR) $(LINUX_MAKE_FLAGS)
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/misc-modules modules KERNELDIR=$(LINUX_DIR) $(LINUX_MAKE_FLAGS)
endef

define LDD_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0644 $(@D)/scull/scull.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/scull.ko
	$(INSTALL) -m 0755 $(@D)/scull/scull_load $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/scull/scull_unload $(TARGET_DIR)/usr/bin
	$(INSTALL) -D -m 0644 $(@D)/misc-modules/hello.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/hello.ko
	$(INSTALL) -D -m 0644 $(@D)/misc-modules/faulty.ko $(TARGET_DIR)/lib/modules/$(LINUX_VERSION_PROBED)/extra/faulty.ko
	$(INSTALL) -m 0755 $(@D)/misc-modules/module_load $(TARGET_DIR)/usr/bin
	$(INSTALL) -m 0755 $(@D)/misc-modules/module_unload $(TARGET_DIR)/usr/bin
endef

$(eval $(generic-package))