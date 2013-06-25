#$L$
# Copyright (C) 2013 Ridgerun (http://www.ridgerun.com). 
##$L$

PKG_TARBALL=gst-fsl-plugins-3.0.5.tar.gz
PKG_SHA1SUM=faa427f94123f397d73d38bef1ef873879090c2c

include ../../bsp/classes/rrsdk.class

APPS_LDFLAGS+=-Wl,-rpath-link -Wl,$(FSDEVROOT)/usr/lib 
APPS_LDFLAGS+=-Wl,-rpath-link -Wl,$(FSDEVROOT)/usr/lib/imx-mm/audio-codec/
APPS_LDFLAGS+=-Wl,-rpath-link -Wl,$(FSDEVROOT)/usr/lib/imx-mm/video-codec/ 
APPS_LDFLAGS+=-Wl,-rpath-link -Wl,$(FSDEVROOT)/usr/lib/imx-mm/audio-codec/wrap/

APPS_LDFLAGS+=-Wl,-rpath=/usr/lib/imx-mm/audio-codec/
APPS_LDFLAGS+=-Wl,-rpath=/usr/lib/imx-mm/audio-codec/wrap/
APPS_LDFLAGS+=-Wl,-rpath=/usr/lib/imx-mm/video-codec/
APPS_LDFLAGS+=-Wl,-rpath=/usr/lib/imx-mm/parser/

#Header files search path needs to be corrected in order to compile
#the plugins in the arm directory
APPS_CFLAGS+=-I$(GST_PLUGINS_IMX)/src
APPS_CFLAGS+=-I$(GST_PLUGINS_IMX)/src/libs
APPS_CFLAGS+=-I$(GST_PLUGINS_IMX)/src/inc/{common,plugin}
APPS_CFLAGS+=-I$(GST_PLUGINS_IMX)/src/libs/{gstbufmeta,gstnext,gstsutils,me,sconf,vss}
APPS_CFLAGS+=-I$(KERNEL_INCLUDE)

AUTOTOOLS_PARAMS=LDFLAGS="$(APPS_LDFLAGS)" CFLAGS="$(APPS_CFLAGS)" PLATFORM=MX6 


BINARIES= /usr/bin/gplay

LIBRARIES= /usr/lib/{libgplaycore.so.0.0.1,libgstfsl-0.10.so.0.0.1}
LINKS= /usr/lib/{libgplaycore.so,libgplaycore.so.0,libgstfsl-0.10.so,libgstfsl-0.10.so.0}

OTHERS= /usr/share/{beep_registry.arm11.cf,beep_registry.arm12.cf,aiur_registry.arm11.cf}

build::
	$(V) $(MAKE) coprocessors.init

#============================================================================================
# coprocessor.init creates the init script that will be used to load all the
# necessary modules into the target board
#============================================================================================

.PHONY: coprocessors.init coprocessors.init.in
coprocessors.init: coprocessors.init.in
	$(V)sed -e 's?@KERNELVERSION@?$(KERNELVERSION)?g' \
	    $< > $@


include $(CLASSES)/gstreamer-plugin.class

INIT_SCRIPT=coprocessors.init
INIT_SCRIPT_LEVEL=35