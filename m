From: Archit Taneja <architt@codeaurora.org>
Date: Fri, 11 Dec 2015 06:26:48 +0000
Subject: Re: [PATCH RFC 0/9] omapdrm/omapfb/omapdss split
Message-Id: <566A69D8.2060607@codeaurora.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1449757535-5674-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org, Laurent Pinchart <laurent.pinchart@ideasonboard.com>



On 12/10/2015 07:55 PM, Tomi Valkeinen wrote:
> Hi,
>
> Here's an RFC series to fix the mess we have at the moment with
> omapdrm/omapfb/omapdss.
>
> First, a short background on the current status. We have the following
> entities:
>
> * omapdss, located in drivers/video/fbdev/omap2/dss/. This is a driver for the
>    display subsystem IPs used on OMAP (and related) SoCs. It offers only a
>    kernel internal API, and does not implement anything for fbdev or drm.
>
> * omapdss panels and encoders, located in
>    drivers/video/fbdev/omap2/displays-new/. These are panel and external encoder
>    drivers, which use APIs offered by omapdss driver. These also don't implement
>    anything for fbdev or drm.
>
> * omapdrm, located in drivers/gpu/drm/omapdrm/. This is a drm driver, which
>    uses omapdss and the panel/encoder drivers to operate the hardware.
>
> * omapfb, located in drivers/video/fbdev/omap2/omapfb/. This is an fbdev
>    driver, which uses omapdss and the panel/encoder drivers to operate the
>    hardware.
>
> * omap_vout, located in drivers/media/platform/omap/. This is a v4l2 driver,
>    which uses omapdss and omapfb to implement a v4l2 API for the video overlays.
>
> So, on the top level, we have either omapdrm, or omapfb+omap_vout. Both of
> those use the same low level drivers. Without going to the historical details
> why the architecture is like that, I think it's finally time to change that.
>
> The situation with omapfb+omap_vout is that it still works, but no new features
> have been added for a long time, and I want to keep it working as it's still
> being used.  At some point in the future I'd like to remove omapfb and
> omap_vout altogether.
>
> Omapdrm, on the other hand, is being actively developed. Sharing the low level
> parts with omapfb makes that development more difficult than it should be. It
> also "hides" half of the development, as everything happening in the low level
> parts resides under fbdev directory, not in the drm directory.
>
> I've been wanting to clean this up for a long time, but I haven't figured out a
> very good way to do it. I still haven't, but here's the best way I have come up
> with.
>
> This series makes a full copy of the low level parts, omapdss and panel/encoder
> drivers. Both omapfb+omap_vout and omapdrm will have their own versions. The
> copy omapfb+omap_vout get is a new copy, and the copy that omapdrm gets is just
> the current files moved. This way git will associate the omapdrm version with
> the old files.

Is it possible to make omapfb get some of the old files (apply.c, 
overlay.c, manager.c, sysfs files etc)? It might be helpful to have git 
associate these files with omapfb/omap_vout since they have been the 
only users of it. After cleanups, these files would eventually be
removed in the omapdrm copy, and it would be hard to track their history
using the omapfb copy.

>
> The omapfb+omap_vout versions won't be touched unless there are some big issues
> there.
>
> The omapdrm versions can be refactored and cleaned up, as the omapfb support
> code is no longer needed. We can perhaps also merge omapdss and omapdrm into
> the same kernel module.
>
> This series only does the copy, and the absolutely necessary parts. No further
> cleanups are done yet.

Ack for the series!

Archit

>
>   Tomi
>
> Tomi Valkeinen (9):
>    omapfb: allow compilation only if DRM_OMAP is disabled
>    omapfb: copy omapdss & displays for omapfb
>    omapdss: remove CONFIG_OMAP2_DSS_VENC from omapdss.h
>    omapfb/dss: change CONFIG_OMAP* to CONFIG_FB_OMAP*
>    omapfb/displays: change CONFIG_DISPLAY_* to CONFIG_FB_OMAP2_*
>    omapfb: take omapfb's prive omapdss into use
>    omapfb: move vrfb into omapfb
>    drm/omap: move omapdss & displays under omapdrm
>    drm/omap: make omapdrm select OMAP2_DSS
>
>   drivers/gpu/drm/Makefile                           |    2 +-
>   drivers/gpu/drm/omapdrm/Kconfig                    |   10 +-
>   drivers/gpu/drm/omapdrm/Makefile                   |    3 +
>   .../drm/omapdrm/displays}/Kconfig                  |    3 +-
>   .../drm/omapdrm/displays}/Makefile                 |    0
>   .../drm/omapdrm/displays}/connector-analog-tv.c    |    0
>   .../drm/omapdrm/displays}/connector-dvi.c          |    0
>   .../drm/omapdrm/displays}/connector-hdmi.c         |    0
>   .../drm/omapdrm/displays}/encoder-opa362.c         |    0
>   .../drm/omapdrm/displays}/encoder-tfp410.c         |    0
>   .../drm/omapdrm/displays}/encoder-tpd12s015.c      |    0
>   .../drm/omapdrm/displays}/panel-dpi.c              |    0
>   .../drm/omapdrm/displays}/panel-dsi-cm.c           |    0
>   .../omapdrm/displays}/panel-lgphilips-lb035q02.c   |    0
>   .../drm/omapdrm/displays}/panel-nec-nl8048hl11.c   |    0
>   .../omapdrm/displays}/panel-sharp-ls037v7dw01.c    |    0
>   .../drm/omapdrm/displays}/panel-sony-acx565akm.c   |    0
>   .../drm/omapdrm/displays}/panel-tpo-td028ttec1.c   |    0
>   .../drm/omapdrm/displays}/panel-tpo-td043mtea1.c   |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/Kconfig    |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/Makefile   |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/apply.c    |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/core.c     |    0
>   .../omap2 => gpu/drm/omapdrm}/dss/dispc-compat.c   |    0
>   .../omap2 => gpu/drm/omapdrm}/dss/dispc-compat.h   |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/dispc.c    |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/dispc.h    |    0
>   .../omap2 => gpu/drm/omapdrm}/dss/dispc_coefs.c    |    0
>   .../omap2 => gpu/drm/omapdrm}/dss/display-sysfs.c  |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/display.c  |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/dpi.c      |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/dsi.c      |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/dss-of.c   |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/dss.c      |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/dss.h      |    0
>   .../omap2 => gpu/drm/omapdrm}/dss/dss_features.c   |    0
>   .../omap2 => gpu/drm/omapdrm}/dss/dss_features.h   |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi.h     |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi4.c    |    0
>   .../omap2 => gpu/drm/omapdrm}/dss/hdmi4_core.c     |    0
>   .../omap2 => gpu/drm/omapdrm}/dss/hdmi4_core.h     |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi5.c    |    0
>   .../omap2 => gpu/drm/omapdrm}/dss/hdmi5_core.c     |    0
>   .../omap2 => gpu/drm/omapdrm}/dss/hdmi5_core.h     |    0
>   .../omap2 => gpu/drm/omapdrm}/dss/hdmi_common.c    |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi_phy.c |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi_pll.c |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi_wp.c  |    0
>   .../omap2 => gpu/drm/omapdrm}/dss/manager-sysfs.c  |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/manager.c  |    0
>   .../drm/omapdrm}/dss/omapdss-boot-init.c           |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/output.c   |    0
>   .../omap2 => gpu/drm/omapdrm}/dss/overlay-sysfs.c  |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/overlay.c  |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/pll.c      |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/rfbi.c     |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/sdi.c      |    0
>   .../fbdev/omap2 => gpu/drm/omapdrm}/dss/venc.c     |    0
>   .../omap2 => gpu/drm/omapdrm}/dss/video-pll.c      |    0
>   drivers/media/platform/omap/Kconfig                |    2 +-
>   drivers/video/fbdev/omap2/Kconfig                  |    5 -
>   drivers/video/fbdev/omap2/Makefile                 |    6 +-
>   drivers/video/fbdev/omap2/omapfb/Kconfig           |   14 +-
>   drivers/video/fbdev/omap2/omapfb/Makefile          |    3 +
>   drivers/video/fbdev/omap2/omapfb/displays/Kconfig  |   86 +
>   drivers/video/fbdev/omap2/omapfb/displays/Makefile |   14 +
>   .../omap2/omapfb/displays/connector-analog-tv.c    |  320 ++
>   .../fbdev/omap2/omapfb/displays/connector-dvi.c    |  398 ++
>   .../fbdev/omap2/omapfb/displays/connector-hdmi.c   |  348 ++
>   .../fbdev/omap2/omapfb/displays/encoder-opa362.c   |  278 +
>   .../fbdev/omap2/omapfb/displays/encoder-tfp410.c   |  320 ++
>   .../omap2/omapfb/displays/encoder-tpd12s015.c      |  379 ++
>   .../video/fbdev/omap2/omapfb/displays/panel-dpi.c  |  330 ++
>   .../fbdev/omap2/omapfb/displays/panel-dsi-cm.c     | 1388 +++++
>   .../omapfb/displays/panel-lgphilips-lb035q02.c     |  404 ++
>   .../omap2/omapfb/displays/panel-nec-nl8048hl11.c   |  437 ++
>   .../omapfb/displays/panel-sharp-ls037v7dw01.c      |  415 ++
>   .../omap2/omapfb/displays/panel-sony-acx565akm.c   |  917 ++++
>   .../omap2/omapfb/displays/panel-tpo-td028ttec1.c   |  511 ++
>   .../omap2/omapfb/displays/panel-tpo-td043mtea1.c   |  686 +++
>   drivers/video/fbdev/omap2/omapfb/dss/Kconfig       |  129 +
>   drivers/video/fbdev/omap2/omapfb/dss/Makefile      |   18 +
>   drivers/video/fbdev/omap2/omapfb/dss/apply.c       | 1702 ++++++
>   drivers/video/fbdev/omap2/omapfb/dss/core.c        |  343 ++
>   .../video/fbdev/omap2/omapfb/dss/dispc-compat.c    |  667 +++
>   .../video/fbdev/omap2/omapfb/dss/dispc-compat.h    |   30 +
>   drivers/video/fbdev/omap2/omapfb/dss/dispc.c       | 4135 +++++++++++++++
>   drivers/video/fbdev/omap2/omapfb/dss/dispc.h       |  916 ++++
>   drivers/video/fbdev/omap2/omapfb/dss/dispc_coefs.c |  325 ++
>   .../video/fbdev/omap2/omapfb/dss/display-sysfs.c   |  356 ++
>   drivers/video/fbdev/omap2/omapfb/dss/display.c     |  338 ++
>   drivers/video/fbdev/omap2/omapfb/dss/dpi.c         |  899 ++++
>   drivers/video/fbdev/omap2/omapfb/dss/dsi.c         | 5607 ++++++++++++++++++++
>   drivers/video/fbdev/omap2/omapfb/dss/dss-of.c      |  183 +
>   drivers/video/fbdev/omap2/omapfb/dss/dss.c         | 1323 +++++
>   drivers/video/fbdev/omap2/omapfb/dss/dss.h         |  472 ++
>   .../video/fbdev/omap2/omapfb/dss/dss_features.c    |  962 ++++
>   .../video/fbdev/omap2/omapfb/dss/dss_features.h    |  105 +
>   drivers/video/fbdev/omap2/omapfb/dss/hdmi.h        |  370 ++
>   drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c       |  839 +++
>   drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c  |  904 ++++
>   drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.h  |  273 +
>   drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c       |  876 +++
>   drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c  |  916 ++++
>   drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.h  |  304 ++
>   drivers/video/fbdev/omap2/omapfb/dss/hdmi_common.c |  148 +
>   drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c    |  247 +
>   drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c    |  255 +
>   drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c     |  282 +
>   .../video/fbdev/omap2/omapfb/dss/manager-sysfs.c   |  531 ++
>   drivers/video/fbdev/omap2/omapfb/dss/manager.c     |  263 +
>   .../fbdev/omap2/omapfb/dss/omapdss-boot-init.c     |  227 +
>   drivers/video/fbdev/omap2/omapfb/dss/output.c      |  267 +
>   .../video/fbdev/omap2/omapfb/dss/overlay-sysfs.c   |  456 ++
>   drivers/video/fbdev/omap2/omapfb/dss/overlay.c     |  202 +
>   drivers/video/fbdev/omap2/omapfb/dss/pll.c         |  389 ++
>   drivers/video/fbdev/omap2/omapfb/dss/rfbi.c        | 1078 ++++
>   drivers/video/fbdev/omap2/omapfb/dss/sdi.c         |  454 ++
>   drivers/video/fbdev/omap2/omapfb/dss/venc.c        |  997 ++++
>   drivers/video/fbdev/omap2/omapfb/dss/video-pll.c   |  211 +
>   drivers/video/fbdev/omap2/{ => omapfb}/vrfb.c      |    0
>   include/video/omapdss.h                            |    2 -
>   122 files changed, 36260 insertions(+), 20 deletions(-)
>   rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/Kconfig (96%)
>   rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/Makefile (100%)
>   rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/connector-analog-tv.c (100%)
>   rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/connector-dvi.c (100%)
>   rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/connector-hdmi.c (100%)
>   rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/encoder-opa362.c (100%)
>   rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/encoder-tfp410.c (100%)
>   rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/encoder-tpd12s015.c (100%)
>   rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/panel-dpi.c (100%)
>   rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/panel-dsi-cm.c (100%)
>   rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/panel-lgphilips-lb035q02.c (100%)
>   rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/panel-nec-nl8048hl11.c (100%)
>   rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/panel-sharp-ls037v7dw01.c (100%)
>   rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/panel-sony-acx565akm.c (100%)
>   rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/panel-tpo-td028ttec1.c (100%)
>   rename drivers/{video/fbdev/omap2/displays-new => gpu/drm/omapdrm/displays}/panel-tpo-td043mtea1.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/Kconfig (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/Makefile (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/apply.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/core.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dispc-compat.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dispc-compat.h (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dispc.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dispc.h (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dispc_coefs.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/display-sysfs.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/display.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dpi.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dsi.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dss-of.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dss.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dss.h (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dss_features.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/dss_features.h (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi.h (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi4.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi4_core.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi4_core.h (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi5.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi5_core.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi5_core.h (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi_common.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi_phy.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi_pll.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/hdmi_wp.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/manager-sysfs.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/manager.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/omapdss-boot-init.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/output.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/overlay-sysfs.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/overlay.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/pll.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/rfbi.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/sdi.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/venc.c (100%)
>   rename drivers/{video/fbdev/omap2 => gpu/drm/omapdrm}/dss/video-pll.c (100%)
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/Kconfig
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/Makefile
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/connector-analog-tv.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/connector-dvi.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/connector-hdmi.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/encoder-opa362.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/encoder-tfp410.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/encoder-tpd12s015.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-dpi.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-dsi-cm.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-lgphilips-lb035q02.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-nec-nl8048hl11.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-sharp-ls037v7dw01.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-sony-acx565akm.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td028ttec1.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/displays/panel-tpo-td043mtea1.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/Kconfig
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/Makefile
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/apply.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/core.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dispc-compat.h
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dispc.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dispc.h
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dispc_coefs.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/display-sysfs.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/display.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dpi.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dsi.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dss-of.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dss.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dss.h
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dss_features.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/dss_features.h
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi.h
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi4_core.h
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi5.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi5_core.h
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi_common.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi_pll.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/hdmi_wp.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/manager-sysfs.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/manager.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/omapdss-boot-init.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/output.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/overlay-sysfs.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/overlay.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/pll.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/rfbi.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/sdi.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/venc.c
>   create mode 100644 drivers/video/fbdev/omap2/omapfb/dss/video-pll.c
>   rename drivers/video/fbdev/omap2/{ => omapfb}/vrfb.c (100%)
>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora 
Forum, hosted by The Linux Foundation
