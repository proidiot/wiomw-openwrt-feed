#
# Copyright (C) 2011 OpenWrt.org
#
# This is free software, licensed under the GNU General Public License v2.
# See /LICENSE for more information.
#

include $(TOPDIR)/rules.mk

PKG_NAME:=wiomw-sui
PKG_VERSION:=0.7.10
PKG_RELEASE:=1
PKG_MAINTAINER:=WIOMW Support <support@whoisonmywifi.com>
PKG_LICENSE:=GPL-3.0+
PKG_LICENSE_FILES:=COPYING

PKG_SOURCE_PROTO:=git
PKG_REV:=87d37402ad970c5e0ce6573f11c94ed7fc0dfde7
PKG_SOURCE_URL:=git://github.com/whoisonmywifi/wiomw-sui.git
PKG_SOURCE:=$(PKG_NAME)-$(PKG_VERSION).tar.gz
PKG_SOURCE_SUBDIR:=${PKG_NAME}-${PKG_VERSION}
PKG_SOURCE_VERSION:=${PKG_REV}

PKG_FIXUP:=autoreconf
PKG_INSTALL:=1

include $(INCLUDE_DIR)/package.mk

define Package/wiomw-sui
  SECTION:=admin
  CATEGORY:=Administration
  DEPENDS:=+wiomw +uhttpd +yajl +libuci +libpolarssl +libcurl
  TITLE:=Simple UI (includes Who Is On My WiFi)
  URL:=http://www.whoisonmywifi.com/
  MAINTAINER:=support@whoisonmywifi.com
endef

define Package/wiomw-sui/description
  Simple UI is an extremely simple web interface for OpenWRT. It includes an interface for Who Is On My WiFi.
endef

CONFIGURE_ARGS+= \
		--without-fcgi \
		--bindir=/www/cgi-bin \
		--with-release=$(PKG_RELEASE)

define Package/wiomw-sui/postinst
#!/bin/sh
# add xsrfd to init
if [ -z "$${IPKG_INSTROOT}" ]; then
        echo "Enabling rc.d symlink for xsrfd"
        /etc/init.d/xsrfd enable
fi
exit 0
endef

define Package/wiomw-sui/prerm
#!/bin/sh
# check if we are on real system
if [ -z "$${IPKG_INSTROOT}" ]; then
        echo "Removing rc.d symlink for xsrfd"
        /etc/init.d/xsrfd disable
fi
exit 0
endef

define Package/wiomw-sui/install
	$(INSTALL_DIR) $(1)/etc/init.d
	$(INSTALL_BIN) ./files/xsrfd.init $(1)/etc/init.d/xsrfd
	$(INSTALL_DIR) $(1)/etc/uci-defaults
	$(INSTALL_BIN) ./files/sui.defaults $(1)/etc/uci-defaults/sui-setup
	$(INSTALL_DIR) $(1)/usr/sbin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/usr/sbin/xsrfd $(1)/usr/sbin/
	$(INSTALL_DIR) $(1)/www
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www-static/index.html $(1)/www/
	$(INSTALL_DIR) $(1)/www/cgi-bin
	$(INSTALL_BIN) $(PKG_INSTALL_DIR)/www/cgi-bin/*.cgi $(1)/www/cgi-bin/
	$(INSTALL_DIR) $(1)/www/css
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www-static/css/*.css $(1)/www/css
	$(INSTALL_DIR) $(1)/www/js
	$(INSTALL_DATA) $(PKG_BUILD_DIR)/www-static/js/*.js $(1)/www/js
endef

$(eval $(call BuildPackage,wiomw-sui))
