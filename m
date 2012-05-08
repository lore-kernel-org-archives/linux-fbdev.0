From: Russ Dill <russ.dill@gmail.com>
Date: Tue, 08 May 2012 23:38:52 +0000
Subject: Re: [PATCH 0/6] OMAPDSS: Misc fixes and cleanups
Message-Id: <CA+Bv8Xa0KDmf3=DTbWmw2khNNm6DvtZc+4+adVqX-22rNYoeEA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1336389696-21636-1-git-send-email-archit@ti.com>
In-Reply-To: <1336389696-21636-1-git-send-email-archit@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Archit Taneja <archit@ti.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

On Mon, May 7, 2012 at 4:21 AM, Archit Taneja <archit@ti.com> wrote:
>
> The first patch in this series is a follow up on the previously posted
> series
> 'OMAPDSS: APPLY: Treat overlay manager timings as shadow registers'. It is
> required for HDMI and DPI interfaces to work properly, it ensures manager
> timings are applied in the set_timing() ops for these interfaces.
>
> The next 3 patches remove some unnecessary usage of omap_dss_device
> pointer in
> DISPC and APPLY.
>
> The last 2 patches are miscellaneous fixes and are self explanatory.
>
> Reference tree containing this series:
>
> git://gitorious.org/~boddob/linux-omap-dss2/archit-dss2-clone.git
> mgr_timing_and_fixes
>
> Tested on OMAP4 SDP.
>
> Archit Taneja (6):
>  OMAPDSS: DPI/HDMI: Apply manager timings even if panel is disabled
>  OMAPDSS: APPLY: Remove an unnecessary omap_dss_device pointer
>  OMAPDSS: DISPC: Remove omap_dss_device pointer usage from
>    dispc_mgr_pclk_rate()
>  OMAPDSS: DISPC: Remove usage of dispc_mgr_get_device()
>  OMAPDSS: Fix DSI_FCLK clock source selection
>  OMAPDSS: DISPC: Remove Fake VSYNC support
>
>  drivers/video/omap2/dss/Kconfig |    9 ------
>  drivers/video/omap2/dss/apply.c |    3 --
>  drivers/video/omap2/dss/dispc.c |   61
> +++++++++++++-------------------------
>  drivers/video/omap2/dss/dpi.c   |    2 +
>  drivers/video/omap2/dss/dsi.c   |    4 --
>  drivers/video/omap2/dss/dss.c   |    5 ++-
>  drivers/video/omap2/dss/dss.h   |    1 -
>  drivers/video/omap2/dss/hdmi.c  |    2 +
>  8 files changed, 28 insertions(+), 59 deletions(-)

I did a build and boot of each one of the patches on the
mgr_timing_and_fixes branch including these on:

Beagleboard-xM rev C1
Beagleboard rev B4
Mistral AM37x-EVM
Zoom AM3517 EVM
Zoom AM1808 EVM

Tested-by: Russ.Dill@ti.com
