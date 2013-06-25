#$L$
# Copyright (C) 2011 Ridgerun (http://www.ridgerun.com). 
##$L$

include ../../bsp/classes/rrsdk.class

LIBRARIES=

# Build libraries
INCLUDE="-I$(FSDEVROOT)/usr/include \
-I$(KERNELDIR)/drivers/mxc/security/rng/include \
-I$(KERNELDIR)/drivers/mxc/security/sahara2/include \
-I$(KERNEL_INCLUDE)"

PLATFORM=IMX6Q

DEST_DIR=$FSDEVROOT

LIBRARIES=/usr/lib/{libipu.so.0,libpxp.so.0,libfsl_shw.so.0,libvpu.so.4}
LINKS=/usr/lib/{libipu.so,libpxp.so,libfsl_shw.so,libvpu.so}

build:
	 $(MAKE) -C src PLATFORM=$(PLATFORM) INCLUDE=$(INCLUDE)
	 @touch rrbuilt
	 
pre_install:
	 $(MAKE) -C src install PLATFORM=$(PLATFORM) INCLUDE=$(INCLUDE) DEST_DIR=$(FSDEVROOT)

install: pre_install rrsdk_install

clean: 
	 $(MAKE) -C src clean PLATFORM=$(PLATFORM) INCLUDE=$(INCLUDE)
	 @rm -f rrbuilt

