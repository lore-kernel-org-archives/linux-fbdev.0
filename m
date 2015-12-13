From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Sun, 13 Dec 2015 20:24:22 +0000
Subject: Re: [PATCH 00/23] OMAPDSS: misc patches
Message-Id: <1799099.Fk5I3ijBtQ@avalon>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1449676791-26304-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1449676791-26304-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Tomi,

Thank you for the patches.

On Wednesday 09 December 2015 17:59:28 Tomi Valkeinen wrote:
> Hi,
> 
> Here is a pile of smallish patches for omapdss, forward ported from TI's
> product kernel (which means they have had some testing).
> 
> Many of these patches prepare the omapdss driver for writeback by cleaning
> up writeback related code, and adding bits here and there for register
> level writeback support. The patch to add writeback support itself is
> missing, as it's still not in a stable state.

For 1/23, 2/13, 20/23, 21/23 and 23/23,

Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> Dave Gerlach (1):
>   OMAPDSS: adopt pinctrl support
> 
> Manisha Agrawal (3):
>   OMAPDSS: tpd12s015: remove platform data support
>   OMAPDSS: tpd12s015: gpio descriptor API
>   OMAPDSS: tpd12s015: CT_CP_HPD as optional gpio
> 
> Tomi Valkeinen (19):
>   OMAPDSS: DISPC: always set ALIGN when available
>   OMAPDSS: fix DISPC_MFLAG_THRESHOLD_OFFSET for WB
>   OMAPDSS: add WB to register dump
>   OMAPDSS: add num_wbs=1 to omap5 dss features
>   OMAPDSS: add 'has_writeback' flag
>   OMAPDSS: add OMAP_DSS_CHANNEL_WB to 'enum omap_channel'
>   OMAPDSS: refactor dispc_ovl_get_channel_out
>   OMAPDSS: handle WB channel in dispc_set/get_channel_out
>   OMAPDSS: configure burst size for WB
>   OMAPDSS: configure WB fifo thresholds
>   OMAPDSS: configure WB mflag threshold
>   OMAPDSS: skip pclk check for WB mem2mem
>   OMAPDSS: fix rgb-to-yuv color conv coefs
>   OMAPDSS: set WB capturemode for m2m mode
>   OMAPDSS: add setup for WB capture mode in dispc_wb_setup()
>   OMAPDSS: remove extra EXPORT_SYMBOLs
>   OMAPDSS: make a two dss feat funcs internal to omapdss
>   OMAPDSS: change internal dispc functions to static
>   OMAPDSS: remove extra out = NULL checks
> 
>  .../fbdev/omap2/displays-new/encoder-tpd12s015.c   | 119 +++++-----------
>  drivers/video/fbdev/omap2/dss/dispc.c              | 157 ++++++++++++++----
>  drivers/video/fbdev/omap2/dss/dispc.h              |   2 +
>  drivers/video/fbdev/omap2/dss/dpi.c                |   2 +-
>  drivers/video/fbdev/omap2/dss/dsi.c                |   2 +-
>  drivers/video/fbdev/omap2/dss/dss.c                |   6 +
>  drivers/video/fbdev/omap2/dss/dss.h                |   5 -
>  drivers/video/fbdev/omap2/dss/dss_features.c       |  11 --
>  drivers/video/fbdev/omap2/dss/dss_features.h       |   5 +-
>  drivers/video/fbdev/omap2/dss/hdmi4.c              |   2 +-
>  drivers/video/fbdev/omap2/dss/hdmi5.c              |   2 +-
>  drivers/video/fbdev/omap2/dss/rfbi.c               |   2 +-
>  drivers/video/fbdev/omap2/dss/sdi.c                |   2 +-
>  drivers/video/fbdev/omap2/dss/venc.c               |   2 +-
>  include/video/omap-panel-data.h                    |  15 --
>  include/video/omapdss.h                            |   3 +-
>  16 files changed, 184 insertions(+), 153 deletions(-)

-- 
Regards,

Laurent Pinchart

