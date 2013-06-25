#$L$
# Copyright (C) 2013 Ridgerun (http://www.ridgerun.com). 
##$L$

BOOST_VERSION_MAJOR=1
BOOST_VERSION_MINOR=52
BOOST_VERSION_PATCH=0
BOOST_VERSION=$(BOOST_VERSION_MAJOR).$(BOOST_VERSION_MINOR).$(BOOST_VERSION_PATCH)

PKG_URL=http://downloads.sourceforge.net/project/boost/boost/$(BOOST_VERSION)
PKG_TARBALL=boost_$(subst .,_,$(BOOST_VERSION)).tar.bz2
PKG_SHA1SUM=cddd6b4526a09152ddc5db856463eaa1dc29c5d9

LIBRARIES= /usr/lib/libboost_date_time.so.$(BOOST_VERSION) \
 /usr/lib/libboost_filesystem.so.$(BOOST_VERSION) \
 /usr/lib/libboost_program_options.so.$(BOOST_VERSION) \
 /usr/lib/libboost_thread.so.$(BOOST_VERSION) \
 /usr/lib/libboost_system.so.$(BOOST_VERSION) \
 /usr/lib/libboost_random.so.$(BOOST_VERSION) \
 /usr/lib/libboost_serialization.so.$(BOOST_VERSION) \
 /usr/lib/libboost_wserialization.so.$(BOOST_VERSION) \
 /usr/lib/libboost_regex.so.$(BOOST_VERSION) \
 /usr/lib/libboost_chrono.so.$(BOOST_VERSION) \
 

#Note the libraries below are built as part of boost but I don't
# need them
#/usr/lib/libboost_log.so.$(BOOST_VERSION) \
#/usr/lib/libboost_log_setup.so.$(BOOST_VERSION) 

LINKS= /usr/lib/libboost_date_time.so \
 /usr/lib/libboost_filesystem.so \
 /usr/lib/libboost_program_options.so \
 /usr/lib/libboost_thread.so \
 /usr/lib/libboost_system.so \
 /usr/lib/libboost_random.so \
 /usr/lib/libboost_serialization.so \
 /usr/lib/libboost_wserialization.so \
 /usr/lib/libboost_regex.so \
 /usr/lib/libboost_chrono.so \
 
#/usr/lib/libboost_log_setup.so \
#/usr/lib/libboost_log.so

FETCHER_EXTRACT_DIRECTORY_NAME=src
include ../../../bsp/classes/rrsdk.class

ifeq ($(MAKECMDGOALS),sim)
  BOOST_PREFIX:=$(SIMROOT)/usr
else
  BOOST_PREFIX:=$(FSDEVROOT)/usr
endif

build$(ARCH_SUFFIX): rrfetched built$(ARCH_SUFFIX)

built$(ARCH_SUFFIX): configured$(ARCH_SUFFIX)
	$(V) cd src;./b2 --build-dir=../$(ARCH) toolset=gcc-arm stage  $(QOUT)
	$(V) touch $@ $(QOUT)

configured$(ARCH_SUFFIX): rrpatched
	$(V) $(RM) -rf $(ARCH) $(QOUT)
	$(V) mkdir $(ARCH) $(QOUT)
	$(V) cd src;./bootstrap.sh --prefix=$(FSDEVROOT)/usr --without-libraries=python,mpi,wave,locale,graph,graph_parallel,test,iostreams,math,signals $(QOUT)
	$(V) touch $@ $(QOUT)

installed$(ARCH_SUFFIX): 
	$(V) cd src;./b2 --build-dir=../$(ARCH) toolset=gcc-arm install $(QOUT)
	$(V) touch $@ $(QOUT)

install$(ARCH_SUFFIX): installed$(ARCH_SUFFIX) rrsdk_install

clean$(ARCH_SUFFIX): 
	$(V) rm -Rf installed* built* configured* sim $(ARCH)
	$(V)$(MAKE) unpatch

distclean: clean$(ARCH_SUFFIX) rrfetched_clean

sim: build$(ARCH_SUFFIX) install$(ARCH_SUFFIX)
	
include $(CLASSES)/fetcher.defs
	
