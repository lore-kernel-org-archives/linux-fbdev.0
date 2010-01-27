From: Andrew Morton <akpm@linux-foundation.org>
Date: Wed, 27 Jan 2010 23:48:18 +0000
Subject: Re: [PATCH] imxfb: correct location of callbacks in suspend and
Message-Id: <20100127154818.de91e255.akpm@linux-foundation.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1263226881-28008-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1264433854-878-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1264433854-878-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 25 Jan 2010 16:37:34 +0100
Uwe Kleine-K__nig  <u.kleine-koenig@pengutronix.de> wrote:

> The probe function passes a pointer to a struct fb_info to
> platform_set_drvdata, so don't interpret the return value of
> platform_get_drvdata as a pointer to struct imxfb_info.
> 
> Signed-off-by: Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de>
> Acked-by: Sascha Hauer <kernel@pengutronix.de>
> Cc: linux-arm-kernel@lists.infradead.org
> ---
>  drivers/video/imxfb.c |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index 66358fa..b4b6dec 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -593,7 +593,8 @@ static int imxfb_activate_var(struct fb_var_screeninfo *var, struct fb_info *inf
>   */
>  static int imxfb_suspend(struct platform_device *dev, pm_message_t state)
>  {
> -	struct imxfb_info *fbi = platform_get_drvdata(dev);
> +	struct fb_info *info = platform_get_drvdata(dev);
> +	struct imxfb_info *fbi = info->par;
>  
>  	pr_debug("%s\n", __func__);
>  
> @@ -603,7 +604,8 @@ static int imxfb_suspend(struct platform_device *dev, pm_message_t state)
>  
>  static int imxfb_resume(struct platform_device *dev)
>  {
> -	struct imxfb_info *fbi = platform_get_drvdata(dev);
> +	struct fb_info *info = platform_get_drvdata(dev);
> +	struct imxfb_info *fbi = info->par;
>  
>  	pr_debug("%s\n", __func__);
>  

What were the runtime effects of this bug?
