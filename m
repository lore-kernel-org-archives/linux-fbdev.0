From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 18 Jan 2016 08:55:31 +0000
Subject: [GIT PULL] fbdev changes for 4.5
Message-Id: <569CA883.9010606@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="j5R8R4jJHXgmE2J6VBosBHrnOsKev4EC2"
List-Id: <linux-fbdev.vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-fbdev <linux-fbdev@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, DRI Development <dri-devel@lists.freedesktop.org>

--j5R8R4jJHXgmE2J6VBosBHrnOsKev4EC2
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Linus,

The following changes since commit 9f9499ae8e6415cefc4fe0a96ad0e27864353c=
89:

  Linux 4.4-rc5 (2015-12-13 17:42:58 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tomba/linux.git tags/fbde=
v-4.5

for you to fetch changes up to 6f6abd360603aff043352db90c28748c8c46560e:

  video: fbdev: pxafb: fix out of memory error path (2016-01-18 10:26:17 =
+0200)

----------------------------------------------------------------
fbdev changes for 4.5

* pxafb: device-tree support
* An unsafe kernel parameter 'lockless_register_fb' for debugging problem=
s
  happening while inside the console lock
* Small miscellaneous fixes & cleanups
* omapdss: add writeback support functions
* Separation of omapfb and omapdrm (see below)

About the separation of omapfb and omapdrm, see
http://permalink.gmane.org/gmane.comp.video.dri.devel/143151 for longer s=
tory.

The short version:

omapfb and omapdrm have shared low level drivers (omapdss and panel drive=
rs),
making further development of omapdrm difficult. After these patches omap=
fb and
omapdrm have their own versions of the drivers, which are more or less
direct copies for now but will diverge soon.

This also means that omapfb (everything under drivers/video/fbdev/omap2/)=
 is
now in maintenance mode, and all new development will be done for omapdrm=

(drivers/gpu/drm/omapdrm/).

----------------------------------------------------------------
Arnd Bergmann (3):
      fbdev: sis: enforce selection of at least one backend
      fbdev: auo_k190x: avoid unused function warnings
      fbdev: sm712fb: avoid unused function warnings

Chen-Yu Tsai (2):
      dt-bindings: simplefb: Support regulator supply properties
      simplefb: Claim and enable regulators

Dan Carpenter (2):
      OMAPDSS: DSI: cleanup DSI_IRQ_ERROR_MASK define
      OMAPDSS: DSS: fix a warning message

Daniel Vetter (1):
      fbdev: Debug knob to register without holding console_lock

Dave Gerlach (1):
      OMAPDSS: adopt pinctrl support

Dmitry Eremin-Solenikov (1):
      video: fbdev: rivafb: unlock chip before probiding EDID

Ezequiel Garcia (1):
      fbdev: Make fb-notify a no-op if CONFIG_FB=3Dn

Geert Uytterhoeven (1):
      fbdev: Remove unused SH-Mobile HDMI driver

Julia Lawall (2):
      video: constify geode ops structures
      video: omapdss: delete unneeded of_node_put

Luis de Bethencourt (1):
      OMAPDSS: DISPC: Remove boolean comparisons

Robert Jarzmik (3):
      video: fbdev: pxafb: loosen the platform data bond
      video: fbdev: pxafb: initial devicetree conversion
      video: fbdev: pxafb: fix out of memory error path

Sudip Mukherjee (1):
      drivers/video/fbdev/i740fb: remove unused variable

Tomi Valkeinen (29):
      OMAPDSS: DISPC: always set ALIGN when available
      OMAPDSS: fix DISPC_MFLAG_THRESHOLD_OFFSET for WB
      OMAPDSS: add WB to register dump
      OMAPDSS: add num_wbs=3D1 to omap5 dss features
      OMAPDSS: add 'has_writeback' flag
      OMAPDSS: add OMAP_DSS_CHANNEL_WB to 'enum omap_channel'
      OMAPDSS: refactor dispc_ovl_get_channel_out
      OMAPDSS: handle WB channel in dispc_set/get_channel_out
      OMAPDSS: configure burst size for WB
      OMAPDSS: configure WB fifo thresholds
      OMAPDSS: configure WB mflag threshold
      OMAPDSS: skip pclk check for WB mem2mem
      OMAPDSS: fix rgb-to-yuv color conv coefs
      OMAPDSS: set WB capturemode for m2m mode
      OMAPDSS: add setup for WB capture mode in dispc_wb_setup()
      OMAPDSS: remove extra EXPORT_SYMBOLs
      OMAPDSS: make a two dss feat funcs internal to omapdss
      OMAPDSS: change internal dispc functions to static
      OMAPDSS: remove extra out =3D=3D NULL checks
      omapfb: allow compilation only if DRM_OMAP is disabled
      omapfb: copy omapdss & displays for omapfb
      omapdss: remove CONFIG_OMAP2_DSS_VENC from omapdss.h
      omapfb/dss: change CONFIG_OMAP* to CONFIG_FB_OMAP*
      omapfb/displays: change CONFIG_DISPLAY_* to CONFIG_FB_OMAP2_*
      omapfb: take omapfb's private omapdss into use
      omapfb: move vrfb into omapfb
      drm/omap: move omapdss & displays under omapdrm
      drm/omap: make omapdrm select OMAP2_DSS
      Merge omapdss split between omapdrm and omapfb

Uwe Kleine-K=C3=B6nig (2):
      fbdev: omap2: panel-dpi: in .disable first disable backlight then d=
isplay
      fbdev: omap2: panel-dpi: simplify gpio setting

 .../bindings/display/simple-framebuffer.txt        |   13 +-
 drivers/gpu/drm/Makefile                           |    2 +-
 drivers/gpu/drm/omapdrm/Kconfig                    |   10 +-
 drivers/gpu/drm/omapdrm/Makefile                   |    3 +
 .../drm/omapdrm/displays}/Kconfig                  |    3 +-
 .../drm/omapdrm/displays}/Makefile                 |    0
 .../drm/omapdrm/displays}/connector-analog-tv.c    |    0
 .../drm/omapdrm/displays}/connector-dvi.c          |    0
 .../drm/omapdrm/displays}/connector-hdmi.c         |    0
 .../drm/omapdrm/displays}/encoder-opa362.c         |    0
 .../drm/omapdrm/displays}/encoder-tfp410.c         |    0
 .../drm/omapdrm/displays}/encoder-tpd12s015.c      |    0
 .../drm/omapdrm/displays}/panel-dpi.c              |    8 +-
 .../drm/omapdrm/displays}/panel-dsi-cm.c           |    0
 .../omapdrm/displays}/panel-lgphilips-lb035q02.c   |    0
 .../drm/omapdrm/displays}/panel-nec-nl8048hl11.c   |    0
 .../omapdrm/displays}/panel-sharp-ls037v7dw01.c    |    0
 .../drm/omapdrm/displays}/panel-sony-acx565akm.c   |    0
 .../drm/omapdrm/displays}/panel-tpo-td028ttec1.c   |    0
 .../drm/omapdrm/displays}/panel-tpo-td043mtea1.c   |    0
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/Kconfig    |    0
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/Makefile   |    0
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/apply.c    |    0
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/core.c     |    0
 .../omap2 =3D> gpu/drm/omapdrm}/dss/dispc-compat.c   |    6 +-
 .../omap2 =3D> gpu/drm/omapdrm}/dss/dispc-compat.h   |    0
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dispc.c    |  163 +-
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dispc.h    |    2 +
 .../omap2 =3D> gpu/drm/omapdrm}/dss/dispc_coefs.c    |    0
 .../omap2 =3D> gpu/drm/omapdrm}/dss/display-sysfs.c  |    0
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/display.c  |    0
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dpi.c      |    2 +-
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dsi.c      |    4 +-
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dss-of.c   |    0
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dss.c      |    6 +
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dss.h      |    8 +-
 .../omap2 =3D> gpu/drm/omapdrm}/dss/dss_features.c   |   11 -
 .../omap2 =3D> gpu/drm/omapdrm}/dss/dss_features.h   |    5 +-
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi.h     |    0
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi4.c    |    2 +-
 .../omap2 =3D> gpu/drm/omapdrm}/dss/hdmi4_core.c     |    0
 .../omap2 =3D> gpu/drm/omapdrm}/dss/hdmi4_core.h     |    0
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi5.c    |    2 +-
 .../omap2 =3D> gpu/drm/omapdrm}/dss/hdmi5_core.c     |    0
 .../omap2 =3D> gpu/drm/omapdrm}/dss/hdmi5_core.h     |    0
 .../omap2 =3D> gpu/drm/omapdrm}/dss/hdmi_common.c    |    0
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi_phy.c |    0
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi_pll.c |    0
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi_wp.c  |    0
 .../omap2 =3D> gpu/drm/omapdrm}/dss/manager-sysfs.c  |    0
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/manager.c  |    2 +-
 .../drm/omapdrm}/dss/omapdss-boot-init.c           |    4 +-
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/output.c   |    0
 .../omap2 =3D> gpu/drm/omapdrm}/dss/overlay-sysfs.c  |    0
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/overlay.c  |    0
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/pll.c      |    0
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/rfbi.c     |    2 +-
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/sdi.c      |    2 +-
 .../fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/venc.c     |    2 +-
 .../omap2 =3D> gpu/drm/omapdrm}/dss/video-pll.c      |    0
 drivers/media/platform/omap/Kconfig                |    2 +-
 drivers/video/fbdev/Kconfig                        |   17 +-
 drivers/video/fbdev/Makefile                       |    1 -
 drivers/video/fbdev/auo_k190x.c                    |   11 +-
 drivers/video/fbdev/core/Makefile                  |    2 +-
 drivers/video/fbdev/core/fbmem.c                   |   14 +-
 drivers/video/fbdev/geode/display_gx1.c            |    2 +-
 drivers/video/fbdev/geode/display_gx1.h            |    2 +-
 drivers/video/fbdev/geode/geodefb.h                |    4 +-
 drivers/video/fbdev/geode/video_cs5530.c           |    2 +-
 drivers/video/fbdev/geode/video_cs5530.h           |    2 +-
 drivers/video/fbdev/i740fb.c                       |    8 +-
 drivers/video/fbdev/omap2/Kconfig                  |    5 -
 drivers/video/fbdev/omap2/Makefile                 |    6 +-
 drivers/video/fbdev/omap2/omapfb/Kconfig           |   14 +-
 drivers/video/fbdev/omap2/omapfb/Makefile          |    3 +
 drivers/video/fbdev/omap2/omapfb/displays/Kconfig  |   86 +
 drivers/video/fbdev/omap2/omapfb/displays/Makefile |   14 +
 .../omap2/omapfb/displays/connector-analog-tv.c    |  320 ++
 .../fbdev/omap2/omapfb/displays/connector-dvi.c    |  398 ++
 .../fbdev/omap2/omapfb/displays/connector-hdmi.c   |  348 ++
 .../fbdev/omap2/omapfb/displays/encoder-opa362.c   |  278 +
 .../fbdev/omap2/omapfb/displays/encoder-tfp410.c   |  320 ++
 .../omap2/omapfb/displays/encoder-tpd12s015.c      |  328 ++
 .../video/fbdev/omap2/omapfb/displays/panel-dpi.c  |  328 ++
 .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     | 1388 +++++
 .../omapfb/displays/panel-lgphilips-lb035q02.c     |  404 ++
 .../omap2/omapfb/displays/panel-nec-nl8048hl11.c   |  437 ++
 .../omapfb/displays/panel-sharp-ls037v7dw01.c      |  415 ++
 .../omap2/omapfb/displays/panel-sony-acx565akm.c   |  917 ++++
 .../omap2/omapfb/displays/panel-tpo-td028ttec1.c   |  511 ++
 .../omap2/omapfb/displays/panel-tpo-td043mtea1.c   |  686 +++
 drivers/video/fbdev/omap2/omapfb/dss/Kconfig       |  129 +
 drivers/video/fbdev/omap2/omapfb/dss/Makefile      |   18 +
 drivers/video/fbdev/omap2/omapfb/dss/apply.c       | 1702 ++++++
 drivers/video/fbdev/omap2/omapfb/dss/core.c        |  343 ++
 .../video/fbdev/omap2/omapfb/dss/dispc-compat.c    |  667 +++
 .../video/fbdev/omap2/omapfb/dss/dispc-compat.h    |   30 +
 drivers/video/fbdev/omap2/omapfb/dss/dispc.c       | 4234 ++++++++++++++=
+
 drivers/video/fbdev/omap2/omapfb/dss/dispc.h       |  918 ++++
 drivers/video/fbdev/omap2/omapfb/dss/dispc_coefs.c |  325 ++
 .../video/fbdev/omap2/omapfb/dss/display-sysfs.c   |  356 ++
 drivers/video/fbdev/omap2/omapfb/dss/display.c     |  338 ++
 drivers/video/fbdev/omap2/omapfb/dss/dpi.c         |  899 ++++
 drivers/video/fbdev/omap2/omapfb/dss/dsi.c         | 5607 ++++++++++++++=
++++++
 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c      |  183 +
 drivers/video/fbdev/omap2/omapfb/dss/dss.c         | 1329 +++++
 drivers/video/fbdev/omap2/omapfb/dss/dss.h         |  468 ++
 .../video/fbdev/omap2/omapfb/dss/dss_features.c    |  951 ++++
 .../video/fbdev/omap2/omapfb/dss/dss_features.h    |  108 +
 drivers/video/fbdev/omap2/omapfb/dss/hdmi.h        |  370 ++
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c       |  839 +++
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c  |  904 ++++
 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.h  |  273 +
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c       |  876 +++
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c  |  916 ++++
 drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.h  |  304 ++
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_common.c |  148 +
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c    |  247 +
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c    |  255 +
 drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c     |  282 +
 .../video/fbdev/omap2/omapfb/dss/manager-sysfs.c   |  531 ++
 drivers/video/fbdev/omap2/omapfb/dss/manager.c     |  263 +
 .../fbdev/omap2/omapfb/dss/omapdss-boot-init.c     |  225 +
 drivers/video/fbdev/omap2/omapfb/dss/output.c      |  267 +
 .../video/fbdev/omap2/omapfb/dss/overlay-sysfs.c   |  456 ++
 drivers/video/fbdev/omap2/omapfb/dss/overlay.c     |  202 +
 drivers/video/fbdev/omap2/omapfb/dss/pll.c         |  389 ++
 drivers/video/fbdev/omap2/omapfb/dss/rfbi.c        | 1078 ++++
 drivers/video/fbdev/omap2/omapfb/dss/sdi.c         |  454 ++
 drivers/video/fbdev/omap2/omapfb/dss/venc.c        |  997 ++++
 drivers/video/fbdev/omap2/omapfb/dss/video-pll.c   |  211 +
 drivers/video/fbdev/omap2/{ =3D> omapfb}/vrfb.c      |    0
 drivers/video/fbdev/pxafb.c                        |  210 +-
 drivers/video/fbdev/pxafb.h                        |    2 +
 drivers/video/fbdev/riva/fbdev.c                   |    1 +
 drivers/video/fbdev/sh_mobile_hdmi.c               | 1489 ------
 drivers/video/fbdev/simplefb.c                     |  120 +-
 drivers/video/fbdev/sm712fb.c                      |   16 +-
 include/linux/fb.h                                 |   18 +
 include/video/omapdss.h                            |    5 +-
 include/video/sh_mobile_hdmi.h                     |   49 -
 142 files changed, 36836 insertions(+), 1701 deletions(-)
 rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/disp=
lays}/Kconfig (96%)
 rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/disp=
lays}/Makefile (100%)
 rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/disp=
lays}/connector-analog-tv.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/disp=
lays}/connector-dvi.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/disp=
lays}/connector-hdmi.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/disp=
lays}/encoder-opa362.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/disp=
lays}/encoder-tfp410.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/disp=
lays}/encoder-tpd12s015.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/disp=
lays}/panel-dpi.c (98%)
 rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/disp=
lays}/panel-dsi-cm.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/disp=
lays}/panel-lgphilips-lb035q02.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/disp=
lays}/panel-nec-nl8048hl11.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/disp=
lays}/panel-sharp-ls037v7dw01.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/disp=
lays}/panel-sony-acx565akm.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/disp=
lays}/panel-tpo-td028ttec1.c (100%)
 rename drivers/{video/fbdev/omap2/displays-new =3D> gpu/drm/omapdrm/disp=
lays}/panel-tpo-td043mtea1.c (100%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/Kconfig (100=
%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/Makefile (10=
0%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/apply.c (100=
%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/core.c (100%=
)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dispc-compat=
=2Ec (98%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dispc-compat=
=2Eh (100%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dispc.c (96%=
)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dispc.h (99%=
)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dispc_coefs.=
c (100%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/display-sysf=
s.c (100%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/display.c (1=
00%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dpi.c (99%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dsi.c (99%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dss-of.c (10=
0%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dss.c (99%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dss.h (97%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dss_features=
=2Ec (99%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/dss_features=
=2Eh (94%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi.h (100%=
)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi4.c (99%=
)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi4_core.c=
 (100%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi4_core.h=
 (100%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi5.c (99%=
)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi5_core.c=
 (100%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi5_core.h=
 (100%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi_common.=
c (100%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi_phy.c (=
100%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi_pll.c (=
100%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/hdmi_wp.c (1=
00%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/manager-sysf=
s.c (100%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/manager.c (9=
9%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/omapdss-boot=
-init.c (98%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/output.c (10=
0%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/overlay-sysf=
s.c (100%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/overlay.c (1=
00%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/pll.c (100%)=

 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/rfbi.c (99%)=

 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/sdi.c (99%)
 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/venc.c (99%)=

 rename drivers/{video/fbdev/omap2 =3D> gpu/drm/omapdrm}/dss/video-pll.c =
(100%)
 create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/Kconfig
 create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/Makefile
 create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/connector-a=
nalog-tv.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/connector-d=
vi.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/connector-h=
dmi.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/encoder-opa=
362.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp=
410.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd=
12s015.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c=

 create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-c=
m.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-lgphi=
lips-lb035q02.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-nec-n=
l8048hl11.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-sharp=
-ls037v7dw01.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-sony-=
acx565akm.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-t=
d028ttec1.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-t=
d043mtea1.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/Kconfig
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/Makefile
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/apply.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/core.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.h
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dispc.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dispc.h
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dispc_coefs.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/display.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dpi.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dsi.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dss.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dss.h
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dss_features.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dss_features.h
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi.h
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.h
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.h
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi_common.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/manager.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-ini=
t.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/output.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/overlay.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/pll.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/rfbi.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/sdi.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/venc.c
 create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/video-pll.c
 rename drivers/video/fbdev/omap2/{ =3D> omapfb}/vrfb.c (100%)
 delete mode 100644 drivers/video/fbdev/sh_mobile_hdmi.c
 delete mode 100644 include/video/sh_mobile_hdmi.h



--j5R8R4jJHXgmE2J6VBosBHrnOsKev4EC2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWnKiEAAoJEPo9qoy8lh71syoQAK9U0GDCGts4EjOziUXBPjsd
1jYnYQPxJ7wilEDKWZ4gY6qdpGnp84DmPRk7IrmHL0je/KXG5/HRlDL9tMaPtJ9X
NcpKqTsUJcMKSbIdpLbGH9rn5PXGd4f/ALyxXlX7HOjWCKKA1XDc1yq4kPbcPSC3
XV+zUdEnXVc4+zDlVOJVyPLzxY7HwAorhz3hAnZFPufXDZWKRFf8hVkXnYcWLs/9
ucc/AK5Q8tBFksaUS5BYcAHizNi43YyaCsAcTqCUGWn29htxdeoo4OmTwudF3M4Q
Ty7IyzIadL4u0NgI27UXUW4Zwocndf4TNycXKOEcqVw2GVfkgHU2dRfZ7Q6bVafn
McetuT1vN4QkhQfNk8Shx27FbeTXFsyFZfWNgG6toqSbPTgpOBfmZEch/TQIZUKz
XEkqxJyu/6j7SrhNS/pNElcycEGvu3Dzxz5V+DYkOBuSS1RSg/RzIIIJvbqq722b
5j28s7QU2kLGDcN54blZyoltklo5OtUxM8Kib0XPEXaSH++Iqz62h4+6VAYIb23S
0IUlc9O6dNJ0kNBiBs43USle5T1hfZfQMo8nKhv2FYcAETdxBQLZCr5IbxMMLMe0
fAsna2iB9h3oKHIlhsnD4xbnlEqeBLT8ZT9IzK2mRPxV56JFBI459F/wDzFYEd0b
Lr5BLYSqnGmyckKBBOmt
=bLJN
-----END PGP SIGNATURE-----

--j5R8R4jJHXgmE2J6VBosBHrnOsKev4EC2--
