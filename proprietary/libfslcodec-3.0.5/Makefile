#$L$
# Copyright (C) 2011 Ridgerun (http://www.ridgerun.com). 
##$L$

PKG_TARBALL=libfslcodec-3.0.5.tar.gz
PKG_SHA1SUM=4ba65f210186ce00329b9188edddc5a6a4e5b3eb

include ../../bsp/classes/rrsdk.class


APPS_LDFLAGS+=-Wl,-rpath-link  -Wl,$(FSDEVROOT)/usr/lib 
APPS_LDFLAGS+=-Wl,-rpath-link -Wl,$(FSDEVROOT)/usr/lib/imx-mm/audio-codec/
APPS_LDFLAGS+=-Wl,-rpath-link -Wl,$(FSDEVROOT)/usr/lib/imx-mm/video-codec/ 
APPS_LDFLAGS+=-Wl,-rpath-link -Wl,$(FSDEVROOT)/usr/lib/imx-mm/audio-codec/wrap/



AUTOTOOLS_PARAMS= LDFLAGS="$(APPS_LDFLAGS)" CFLAGS="$(APPS_CFLAGS)" 

BINARIES= /usr/share/imx-mm/audio-codec/examples/aac-dec/bin/{test_aac_dec_arm11_elinux,test_aac_dec_arm12_elinux,test_aac_dec_arm9_elinux} \
		/usr/share/imx-mm/audio-codec/examples/amrnb/bin/{test_nb_amr_dec_arm9_elinux,test_nb_amr_enc_arm9_elinux} \
		/usr/share/imx-mm/audio-codec/examples/amrwb/bin/{test_wb_amr_dec_arm9_elinux,test_wb_amr_enc_arm9_elinux} \
		/usr/share/imx-mm/audio-codec/examples/g711/bin/{test_g.711_dec_arm11_elinux,test_g.711_dec_arm9_elinux} \
		/usr/share/imx-mm/audio-codec/examples/g711/bin/{test_g.711_enc_arm11_elinux,test_g.711_enc_arm9_elinux} \
		/usr/share/imx-mm/audio-codec/examples/g723/bin/{test_g.723.1_dec_arm11_elinux,test_g.723.1_dec_arm9_elinux,test_g.723.1_enc_arm11_elinux,test_g.723.1_enc_arm9_elinux} \
		/usr/share/imx-mm/audio-codec/examples/g726/bin/{test_g.726_dec_arm11_elinux,test_g.726_dec_arm9_elinux,test_g.726_enc_arm11_elinux,test_g.726_enc_arm9_elinux} \
		/usr/share/imx-mm/audio-codec/examples/g729/bin/{test_g.729ab_dec_arm11_elinux,test_g.729ab_dec_arm9_elinux,test_g.729ab_enc_arm11_elinux,test_g.729ab_enc_arm9_elinux} \
		/usr/share/imx-mm/audio-codec/examples/mp3-dec/bin/{test_mp3_dec_arm11_elinux,test_mp3_dec_arm12_elinux,test_mp3_dec_arm9_elinux} \
		/usr/share/imx-mm/audio-codec/examples/mp3-enc/bin/{test_mp3_enc_arm11_elinux,test_mp3_enc_arm12_elinux,test_mp3_enc_arm9_elinux} \
		/usr/share/imx-mm/audio-codec/examples/oggvorbis-dec/bin/test_oggvorbis_dec_arm11_elinux \
		/usr/share/imx-mm/audio-codec/examples/sbc-enc/bin/{test_sbc_enc_arm11_elinux,test_sbc_enc_arm9_elinux} \
		/usr/share/imx-mm/video-codec/examples/bmp-dec/bin/{test_bmp_dec_arm11_elinux,test_bmp_dec_arm9_elinux} \
		/usr/share/imx-mm/video-codec/examples/deinterlace/bin/{test_deinterlace_arm11_elinux,test_deinterlace_arm9_elinux} \
		/usr/share/imx-mm/video-codec/examples/gif-dec/bin/test_gif_dec_arm11_elinux \
		/usr/share/imx-mm/video-codec/examples/h264-dec/bin/test_dec_arm_elinux \
		/usr/share/imx-mm/video-codec/examples/jpeg-dec/bin/{test_jpeg_dec_arm11_elinux,test_jpeg_dec_arm11_elinux_novpu,test_jpeg_dec_arm9_elinux} \
		/usr/share/imx-mm/video-codec/examples/jpeg-enc/bin/test_jpeg_enc_arm11_elinux \
		/usr/share/imx-mm/video-codec/examples/png-dec/bin/{test_png_dec_arm11_elinux,test_png_dec_arm9_elinux} \
		/usr/share/imx-mm/video-codec/examples/uniform-test/bin/test_dec_arm_elinux
LIBRARIES= /usr/lib/imx-mm/audio-codec/{lib_aac_dec_arm11_elinux.so.3,lib_aac_dec_arm12_elinux.so.3,lib_aac_dec_arm9_elinux.so.3} \
		/usr/lib/imx-mm/audio-codec/{lib_bsac_dec_arm11_elinux.so.2,lib_flac_dec_arm11_elinux.so.2,lib_flac_dec_arm9_elinux.so.2} \
		/usr/lib/imx-mm/audio-codec/{lib_g.711_dec_arm11_elinux.so.2,lib_g.711_dec_arm9_elinux.so.2,lib_g.711_enc_arm11_elinux.so.2} \
		/usr/lib/imx-mm/audio-codec/{lib_g.711_enc_arm9_elinux.so.2,lib_g.723.1_dec_arm11_elinux.so.2,lib_g.723.1_dec_arm9_elinux.so.2} \
		/usr/lib/imx-mm/audio-codec/{lib_g.723.1_enc_arm11_elinux.so.2,lib_g.723.1_enc_arm9_elinux.so.2,lib_g.726_dec_arm11_elinux.so.2} \
		/usr/lib/imx-mm/audio-codec/{lib_g.726_dec_arm9_elinux.so.2,lib_g.726_enc_arm11_elinux.so.2,lib_g.726_enc_arm9_elinux.so.2} \
		/usr/lib/imx-mm/audio-codec/{lib_g.729ab_dec_arm11_elinux.so.3.1.0,lib_g.729ab_dec_arm9_elinux.so.3.1.0} \
		/usr/lib/imx-mm/audio-codec/{lib_g.729ab_enc_arm11_elinux.so.3.1.0,lib_g.729ab_enc_arm9_elinux.so.3.1.0,lib_mp3_dec_arm11_elinux.so.2} \
		/usr/lib/imx-mm/audio-codec/{lib_mp3_dec_arm12_elinux.so.2,lib_mp3_dec_arm9_elinux.so.2,lib_mp3_enc_arm11_elinux.so.2} \
		/usr/lib/imx-mm/audio-codec/{lib_mp3_enc_arm12_elinux.so.2,lib_mp3_enc_arm9_elinux.so.2,lib_nb_amr_dec_arm9_elinux.so.2} \
		/usr/lib/imx-mm/audio-codec/{lib_nb_amr_enc_arm9_elinux.so.2,lib_oggvorbis_dec_arm11_elinux.so.2,lib_peq_arm11_elinux.so.1} \
		/usr/lib/imx-mm/audio-codec/{lib_sbc_enc_arm11_elinux.so.2,lib_sbc_enc_arm9_elinux.so.2,lib_wb_amr_dec_arm9_elinux.so.2} \
		/usr/lib/imx-mm/audio-codec/lib_wb_amr_enc_arm9_elinux.so.2 \
		/usr/lib/imx-mm/audio-codec/wrap/{lib_aacd_wrap_arm11_elinux.so.3,lib_aacd_wrap_arm12_elinux.so.3} \
		/usr/lib/imx-mm/audio-codec/wrap/{lib_aacd_wrap_arm9_elinux.so.3,lib_mp3d_wrap_arm11_elinux.so.3,lib_mp3d_wrap_arm12_elinux.so.3} \
		/usr/lib/imx-mm/audio-codec/wrap/{lib_mp3d_wrap_arm9_elinux.so.3,lib_vorbisd_wrap_arm11_elinux.so.3,lib_vorbisd_wrap_arm12_elinux.so.3} \
		/usr/lib/imx-mm/video-codec/{lib_bmp_dec_arm11_elinux.so.1,lib_deinterlace_arm11_elinux.so,lib_gif_dec_arm11_elinux.so.1} \
		/usr/lib/imx-mm/video-codec/{lib_H264_dec_arm11_elinux.so,lib_H264_dec_arm11_elinux.so.2.6.1,lib_H264_dec_arm9_elinux.so.2.6.1,lib_jpeg_dec_arm11_elinux.so.1.6.1} \
		/usr/lib/imx-mm/video-codec/{lib_jpeg_dec_arm9_elinux.so.1.6.1,lib_jpeg_enc_arm11_elinux.so.1,lib_mpeg2_dec_arm11_elinux.so.2.2.0} \
		/usr/lib/imx-mm/video-codec/{lib_MPEG4ASP_dec_arm11_elinux.so.1.2.1,lib_MPEG4ASP_dec_arm9_elinux.so.1.2.1,lib_png_dec_arm11_elinux.so.1}
LINKS=/usr/lib/imx-mm/video-codec/{lib_H264_dec_arm11_elinux.so,lib_mpeg2_dec_arm11_elinux.so} \
	/usr/lib/imx-mm/video-codec/lib_MPEG4ASP_dec_arm11_elinux.so \
	/usr/lib/imx-mm/audio-codec/{lib_aac_dec_arm12_elinux.so,lib_oggvorbis_dec_arm11_elinux.so} \
	/usr/lib/imx-mm/audio-codec/{lib_mp3_dec_arm12_elinux.so,lib_nb_amr_dec_arm9_elinux.so} \
	/usr/lib/imx-mm/audio-codec/{lib_mp3_enc_arm12_elinux.so,lib_aac_dec_arm12_elinux.so,lib_peq_arm11_elinux.so} \
	/usr/lib/imx-mm/audio-codec/wrap/{lib_aacd_wrap_arm11_elinux.so,lib_aacd_wrap_arm12_elinux.so,lib_aacd_wrap_arm9_elinux.so} \
	/usr/lib/imx-mm/audio-codec/wrap/{lib_mp3d_wrap_arm11_elinux.so,lib_mp3d_wrap_arm12_elinux.so,lib_mp3d_wrap_arm9_elinux.so} \
	/usr/lib/imx-mm/audio-codec/wrap/{lib_vorbisd_wrap_arm11_elinux.so,lib_vorbisd_wrap_arm12_elinux.so}
include $(CLASSES)/autotools.class

#build::
#	patchelf $(IMX6CODECS)/src/release/

