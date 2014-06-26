From: Jyri Sarha <jsarha@ti.com>
Date: Thu, 26 Jun 2014 19:05:01 +0000
Subject: Re: [PATCH 14/15] OMAPDSS: HDMI: remove the unused code
Message-Id: <53AC6EDD.6040300@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1403604240-16738-1-git-send-email-tomi.valkeinen@ti.com> <1403604240-16738-15-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1403604240-16738-15-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Archit Taneja <archit@ti.com>

On 06/24/2014 01:03 PM, Tomi Valkeinen wrote:
> We no longer need the horrible driver internal videmode tables, which
> were used to decide if a given videomode is a HDMI or DVI mode. So
> remove all related code.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>   drivers/video/fbdev/omap2/dss/hdmi.h        |  11 -
>   drivers/video/fbdev/omap2/dss/hdmi_common.c | 316 ----------------------------
>   2 files changed, 327 deletions(-)
>
> diff --git a/drivers/video/fbdev/omap2/dss/hdmi.h b/drivers/video/fbdev/omap2/dss/hdmi.h
> index e3956defc1c3..262771b9b76b 100644
> --- a/drivers/video/fbdev/omap2/dss/hdmi.h
> +++ b/drivers/video/fbdev/omap2/dss/hdmi.h
...
> @@ -192,7 +187,6 @@ struct hdmi_video_format {
>
>   struct hdmi_config {
>   	struct omap_video_timings timings;
> -	struct hdmi_cm cm;
>   	struct hdmi_avi_infoframe infoframe;
>   	enum hdmi_core_hdmi_dvi hdmi_dvi_mode;
>   };

The HDMI audio finctionality is broken already now, but removing 
hdmi_config.cm will cause compilation failure if HDMI audio is enabled.

I'll mail a patch set to fix OMAP4+ HDMI audio shortly. The set should 
be applied on top of these patches and it fixes (obviously) the 
compilation issue too.

Best regards,
Jyri
