#$L$
# Copyright (C) 2011 Ridgerun (http://www.ridgerun.com). 
##$L$

PKG_TARBALL=libfslaacpcodec-3.0.5.tar.gz
PKG_SHA1SUM=ec418ca9c9dc1b1963d26ee3f0aae93985ce179e

include ../../bsp/classes/rrsdk.class
include $(CLASSES)/autotools.class

APPS_LDFLAGS+=-Wl,--rpath-link -Wl,$(FSDEVROOT)/usr/lib 

AUTOTOOLS_PARAMS=LDFLAGS="$(APPS_LDFLAGS)" CFLAGS="$(APPS_CFLAGS)"

#BINARIES= /usr/bin/{test_aacplus_dec_arm11_elinux,test_aacplus_dec_arm9_elinux}
LIBRARIES= /usr/lib/imx-mm/audio-codec/{lib_aacplus_dec_arm11_elinux.so.3,lib_aacplus_dec_arm9_elinux.so.3} \
	  /usr/lib/imx-mm/audio-codec/wrap/{lib_aacplusd_wrap_arm11_elinux.so.3,lib_aacplusd_wrap_arm9_elinux.so.3,lib_aacplusd_wrap_arm12_elinux.so.3}
LINKS= /usr/lib/imx-mm/audio-codec/{lib_aacplus_dec_arm11_elinux.so,lib_aacplus_dec_arm9_elinux.so} \
       /usr/lib/imx-mm/audio-codec/wrap/{lib_aacplusd_wrap_arm11_elinux.so,lib_aacplusd_wrap_arm12_elinux.so,lib_aacplusd_wrap_arm9_elinux.so}

