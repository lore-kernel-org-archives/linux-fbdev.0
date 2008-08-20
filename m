From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] i.MX Framebuffer: rename
 imxfb_mach_info to imx_fb_platform_data
Date: Wed, 20 Aug 2008 17:51:12 +0200
Message-ID: <20080820175112.c49ef384.krzysztof.h1@poczta.fm>
References: <1219158403-5180-1-git-send-email-s.hauer@pengutronix.de>
	<1219158403-5180-5-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KVpyW-0001r1-Bq for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Aug 2008 08:51:56 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KVprw-0000RM-Cl
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 20 Aug 2008 08:45:11 -0700
In-Reply-To: <1219158403-5180-5-git-send-email-s.hauer@pengutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Tue, 19 Aug 2008 17:06:43 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> rename imxfb_mach_info to a name more common to kernel hackers
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-imx/include/mach/imxfb.h |    5 +-
>  drivers/video/imxfb.c                  |   68 ++++++++++++++++----------------
>  2 files changed, 37 insertions(+), 36 deletions(-)
> 
> diff --git a/arch/arm/mach-imx/include/mach/imxfb.h b/arch/arm/mach-imx/include/mach/imxfb.h
> index 3ed9ec8..ffcff5a 100644
> --- a/arch/arm/mach-imx/include/mach/imxfb.h
> +++ b/arch/arm/mach-imx/include/mach/imxfb.h
> @@ -1,7 +1,7 @@
>  /*
>   * This structure describes the machine which we are running on.
>   */
> -struct imxfb_mach_info {
> +struct imx_fb_platform_data {
>  	u_long		pixclock;
>  
>  	u_short		xres;
> @@ -34,4 +34,5 @@ struct imxfb_mach_info {
>  	void (*lcd_power)(int);
>  	void (*backlight_power)(int);
>  };
> -void set_imx_fb_info(struct imxfb_mach_info *hard_imx_fb_info);
> +
> +void set_imx_fb_info(struct imx_fb_platform_data *);
> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index e450e6b..a4a4940 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -510,7 +510,7 @@ static int imxfb_resume(struct platform_device *dev)
>  
>  static int __init imxfb_init_fbinfo(struct platform_device *pdev)
>  {
> -	struct imxfb_mach_info *inf = pdev->dev.platform_data;
> +	struct imx_fb_platform_data *pdata = pdev->dev.platform_data;
>  	struct fb_info *info = dev_get_drvdata(&pdev->dev);
>  	struct imxfb_info *fbi = info->par;
>  
> @@ -546,32 +546,32 @@ static int __init imxfb_init_fbinfo(struct platform_device *pdev)
>  	fbi->rgb[RGB_16]		= &def_rgb_16;
>  	fbi->rgb[RGB_8]			= &def_rgb_8;
>  
> -	fbi->max_xres			= inf->xres;
> -	info->var.xres			= inf->xres;
> -	info->var.xres_virtual		= inf->xres;
> -	fbi->max_yres			= inf->yres;
> -	info->var.yres			= inf->yres;
> -	info->var.yres_virtual		= inf->yres;
> -	fbi->max_bpp			= inf->bpp;
> -	info->var.bits_per_pixel	= inf->bpp;
> -	info->var.nonstd		= inf->nonstd;
> -	info->var.pixclock		= inf->pixclock;
> -	info->var.hsync_len		= inf->hsync_len;
> -	info->var.left_margin		= inf->left_margin;
> -	info->var.right_margin		= inf->right_margin;
> -	info->var.vsync_len		= inf->vsync_len;
> -	info->var.upper_margin		= inf->upper_margin;
> -	info->var.lower_margin		= inf->lower_margin;
> -	info->var.sync			= inf->sync;
> -	info->var.grayscale		= inf->cmap_greyscale;
> -	fbi->cmap_inverse		= inf->cmap_inverse;
> -	fbi->cmap_static		= inf->cmap_static;
> -	fbi->pcr			= inf->pcr;
> -	fbi->lscr1			= inf->lscr1;
> -	fbi->dmacr			= inf->dmacr;
> -	fbi->pwmr			= inf->pwmr;
> -	fbi->lcd_power			= inf->lcd_power;
> -	fbi->backlight_power		= inf->backlight_power;
> +	fbi->max_xres			= pdata->xres;
> +	info->var.xres			= pdata->xres;
> +	info->var.xres_virtual		= pdata->xres;
> +	fbi->max_yres			= pdata->yres;
> +	info->var.yres			= pdata->yres;
> +	info->var.yres_virtual		= pdata->yres;
> +	fbi->max_bpp			= pdata->bpp;
> +	info->var.bits_per_pixel	= pdata->bpp;

These max_foo fields seem redundant. Especially, the max_bpp.
Most ARM chips can handle any bpp regardless the connected 
display (I don't know the iMX chips). Also, if resolution switching
is not allowed (usual for LCD displays) max_xres/yres is also 
redundant.

Otherwise, the patch is fine.

Regards,
Krzysztof

----------------------------------------------------------------------
Podbij Dziki Zachod, wygraj laptopa lub iPoda 
>> http://link.interia.pl/f1ede


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
