#
# myapps/rr-imx6-demo-app/Makefile
#

.PHONY: build install clean

include ../../bsp/classes/rrsdk.class
include ../../bsp/classes/fetcher.defs

PKG_TARBALL=rr-imx6-demo-app-videos.tar.gz
PKG_SHA1SUM=bb21f3cb98bbc3e55fc6cf0bdccd4bb944269d2e
FETCHER_EXTRACT_DIRECTORY_NAME=$(DEVDIR)/myapps/rr-imx6-demo-app/src/scripts/media

build:
	$(V) touch rrbuilt 

install:
	$(V) mkdir -p $(FSROOT)/opt
	$(V) cp -r ./src/scripts  $(FSROOT)/opt
	$(V) find $(FSROOT)/opt/scripts -name \*.sh -exec chmod +x {} \;

clean:
	$(V)if [ -f rrbuilt ] ; then \
		rm rrbuilt; \
	fi;

distclean: clean
	$(V)if [ -f rrfetched ] ; then \
		rm rrfetched; \
	fi;
