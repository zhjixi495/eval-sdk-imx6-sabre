#$L$
# Copyright (C) 2011 Ridgerun (http://www.ridgerun.com). 
##$L$

PKG_TARBALL=libfslvpuwrap-1.0.28.tar.gz
PKG_SHA1SUM=32cc080e594ab82607d27694f1d032e9089cf639

include ../../bsp/classes/rrsdk.class

APPS_LDFLAGS+=-Wl,--rpath-link -Wl,$(FSDEVROOT)/usr/lib 

AUTOTOOLS_PARAMS=LDFLAGS="$(APPS_LDFLAGS)" CFLAGS="$(APPS_CFLAGS)"


LIBRARIES= /usr/lib/libfslvpuwrap.so.3.0.0
LINKS= /usr/lib/{libfslvpuwrap.so,libfslvpuwrap.so.3}

include $(CLASSES)/autotools.class

