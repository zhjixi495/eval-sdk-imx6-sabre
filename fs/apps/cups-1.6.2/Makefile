#$L$
# Copyright (C) 2013 Ridgerun (http://www.ridgerun.com)
##$L$

PKG_URL=http://www.cups.org/software/1.6.2
PKG_TARBALL=cups-1.6.2-source.tar.gz
PKG_SHA1SUM=c405eaa66b5f335596a6cf5f967a5ddb9f7263cb

BINARIES= /usr/bin/{cancel,cups-config,lp,lpq,lpr,lprm,lpstat,ppdi,ppdmerge,ppdpo,ppdhtml,lpoptions,lppasswd}\
/usr/sbin/{accept,cupsaccept,cupsctl,cupsd,cupsdisable,cupsenable,cupsfilter,cupsreject,lpadmin,lpc,lpinfo,lpmove,reject}
LIBRARIES = /usr/lib/{libcupscgi.so.1,libcupsimage.so.2,libcupsmime.so.1,libcupsppdc.so.1,libcups.so.2}
EXTRA_FILES = /usr/share/cups/{banners,data,drv,mime,model,profiles} /etc/cups \
/var/{cache/cups,run/cups,log/cups,spool/cups} /usr/lib/cups

INIT_SCRIPT=cupsd.init
INIT_SCRIPT_LEVEL=80

export LDFLAGS =-Wl,--rpath-link -Wl,$(FSDEVROOT)/usr/lib -L$(FSDEVROOT)/usr/lib
export DSOFLAGS=-L$(FSDEVROOT)/usr/lib
export DSTROOT=$(FSDEVROOT)

# Cups does not build fine outside itself
AUTOTOOLS_CLONE_SOURCE=yes
AUTOTOOLS_PARAMS=--disable-gssapi --disable-ssl --with-cups-system-groups=pl --without-php --enable-libusb\
--prefix=/usr --sysconfdir=/etc --localstatedir=/var

include ../../../bsp/classes/rrsdk.class
include $(CLASSES)/autotools.class

# Correct cups-config, and some file permissions
install:: 
	$(V)sed -i -e 's?prefix=/usr?prefix=$(FSDEVROOT)/usr?' \
	           -e 's?dir=/usr?dir=$(FSDEVROOT)/usr?' \
	                $(FSDEVROOT)/usr/bin/cups-config
	$(V) cp $(FSDEVROOT)/usr/bin/cups-config $(LOCALDIR)/bin
	$(V) if test -d $(FSROOT)/usr/lib/cups/ ; then  $(SUDO) chown -R --from=root:lp `id -nu`:`id -ng` $(FSROOT)/usr/lib/cups/  ; fi
	$(V) $(SUDO) chmod 777 $(LOCALDIR)/bin/cups-config
	$(V) $(SUDO) chmod 666 $(FSDEVROOT)/usr/share/cups/mime/mime.{convs,types}

clean::
	$(V) $(SUDO) rm -rf $(FSROOT)/usr/lib/cups/ $(FSROOT)/etc/cups $(FSDEVROOT)/usr/share/cups
