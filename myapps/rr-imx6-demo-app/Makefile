#
# myapps/rr-imx6-demo-app/Makefile
#

.PHONY: build install clean



build:
	$(V) touch rrbuilt 

install: 
	$(V) mkdir -p $(FSROOT)/opt
	$(V) cp -r ./src/scripts  $(FSROOT)/opt
	$(V) find $(FSROOT)/opt/scripts -name \*.sh -exec chmod +x {} \;

clean:
	$(V) rm rrbuilt

include ../../bsp/classes/rrsdk.class
