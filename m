From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Mon, 01 Jun 2020 13:25:03 +0000
Subject: Re: [PATCH] omapfb/dss: fix comparison to bool warning
Message-Id: <266bc2e0-c2bf-1c0c-a5ac-58941ff38f5f@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200422072450eucas1p106befe0a06fe20557d7ea4297525878a@eucas1p1.samsung.com>
 <20200422071903.637-1-yanaijie@huawei.com>
In-Reply-To: <20200422071903.637-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jason Yan <yanaijie@huawei.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, afd@ti.com, tomi.valkeinen@ti.com, linux-omap@vger.kernel.org


On 4/22/20 9:19 AM, Jason Yan wrote:
> Fix the following coccicheck warning:
> 
> drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c:461:15-32: WARNING:
> Comparison to bool
> drivers/video/fbdev/omap2/omapfb/dss/dispc.c:891:5-35: WARNING:
> Comparison of 0/1 to bool variable
> 
> Signed-off-by: Jason Yan <yanaijie@huawei.com>

Applied to drm-misc-next tree (patch should show up in v5.9), thanks.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

> ---
>  drivers/video/fbdev/omap2/omapfb/dss/dispc.c | 2 +-
>  drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c | 4 +---
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> index 4a16798b2ecd..3bb951eb29c7 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> @@ -888,7 +888,7 @@ static void dispc_ovl_set_color_mode(enum omap_plane plane,
>  static void dispc_ovl_configure_burst_type(enum omap_plane plane,
>  		enum omap_dss_rotation_type rotation_type)
>  {
> -	if (dss_has_feature(FEAT_BURST_2D) = 0)
> +	if (!dss_has_feature(FEAT_BURST_2D))
>  		return;
>  
>  	if (rotation_type = OMAP_DSS_ROT_TILER)
> diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
> index 7060ae56c062..ef659c89ba58 100644
> --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
> +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi4.c
> @@ -455,11 +455,9 @@ static void hdmi_disconnect(struct omap_dss_device *dssdev,
>  static int hdmi_read_edid(struct omap_dss_device *dssdev,
>  		u8 *edid, int len)
>  {
> -	bool need_enable;
> +	bool need_enable = !hdmi.core_enabled;
>  	int r;
>  
> -	need_enable = hdmi.core_enabled = false;
> -
>  	if (need_enable) {
>  		r = hdmi_core_enable(dssdev);
>  		if (r)
> 
