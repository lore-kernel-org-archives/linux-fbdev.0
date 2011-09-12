From: Archit Taneja <archit@ti.com>
Date: Mon, 12 Sep 2011 11:13:35 +0000
Subject: Re: [PATCHv2 8/8] OMAP: DSS2: HDMI: improve hdmi output enable
Message-Id: <4E6DE68F.3020809@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1315818773-18660-1-git-send-email-tomi.valkeinen@ti.com> <1315818773-18660-9-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1315818773-18660-9-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Valkeinen, Tomi" <tomi.valkeinen@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "K, Mythri P" <mythripk@ti.com>

On Monday 12 September 2011 02:42 PM, Valkeinen, Tomi wrote:
> Enabling HDMI output often causes sync lost errors, and almost always
> causes timeout errors being printed from dispc_mgr_enable_digit_out().
>
> The sync lost problem seems to go lessen greatly if we first enable the
> HDMI output, and only then enable the DISPC output. However, as this is
> only based on observations, the fix may not be perfect as the problem
> may lie somewhere else. Nevertheless, HDMI works better with this patch.
>
> This will also fix the dispc's dispc_mgr_enable_digit_out(), as the code
> waits for two VSYNCs after enabling the output. If the HDMI output is
> disabled (as it was previously), there are no VSYNCs and
> dispc_mgr_enable_digit_out() will print timeout errors.
>
> Cc: Mythri P K<mythripk@ti.com>
> Signed-off-by: Tomi Valkeinen<tomi.valkeinen@ti.com>
> ---
>   drivers/video/omap2/dss/hdmi.c |    4 ++--
>   1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
> index 4752137..06a78b2 100644
> --- a/drivers/video/omap2/dss/hdmi.c
> +++ b/drivers/video/omap2/dss/hdmi.c
> @@ -529,10 +529,10 @@ static int hdmi_power_on(struct omap_dss_device *dssdev)
>   	dispc_set_digit_size(dssdev->panel.timings.x_res,
>   			dssdev->panel.timings.y_res);
>
> -	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 1);
> -
>   	hdmi.ip_data.ops->video_enable(&hdmi.ip_data, 1);
>
> +	dispc_mgr_enable(OMAP_DSS_CHANNEL_DIGIT, 1);
> +

What content would HDMI push out till the time DIGIT is enabled? It 
might be interesting to put some milliseconds of delay here and see what 
happens.

Archit

>   	return 0;
>   err:
>   	hdmi_runtime_put();

