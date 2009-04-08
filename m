From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: [patch] mx3fb: Fix compilation with
	CONFIG_PM
Date: Wed, 8 Apr 2009 12:08:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0904081205040.4722@axis700.grange>
References: <20090408094547.GJ14383@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <g.liakhovetski@gmx.de>) id 1LrUht-0001c6-Dh
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Apr 2009 10:08:33 +0000
Received: from mail.gmx.net ([213.165.64.20])
	by 72vjzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1LrUho-0003XX-9e for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 08 Apr 2009 10:08:33 +0000
In-Reply-To: <20090408094547.GJ14383@pengutronix.de>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: linux-fbdev-devel@lists.sourceforge.net

On Wed, 8 Apr 2009, Sascha Hauer wrote:

> Hi Guennadi,
> 
> The following fixes mx3fb compilation with CONFIG_PM
> 
> Sascha
> 
> >From cb9f64e5c9bc108d6b6bcf78ae19df45107d766c Mon Sep 17 00:00:00 2001
> From: Sascha Hauer <s.hauer@pengutronix.de>
> Date: Wed, 8 Apr 2009 11:41:49 +0200
> Subject: mx3fb: Fix compilation with CONFIG_PM
> 
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>

Acked-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

> ---
>  drivers/video/mx3fb.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
> index 21b3692..9894de1 100644
> --- a/drivers/video/mx3fb.c
> +++ b/drivers/video/mx3fb.c
> @@ -1152,11 +1152,11 @@ static struct fb_ops mx3fb_ops = {
>   */
>  static int mx3fb_suspend(struct platform_device *pdev, pm_message_t state)
>  {
> -	struct mx3fb_data *drv_data = platform_get_drvdata(pdev);
> -	struct mx3fb_info *mx3_fbi = drv_data->fbi->par;
> +	struct mx3fb_data *mx3fb = platform_get_drvdata(pdev);
> +	struct mx3fb_info *mx3_fbi = mx3fb->fbi->par;
>  
>  	acquire_console_sem();
> -	fb_set_suspend(drv_data->fbi, 1);
> +	fb_set_suspend(mx3fb->fbi, 1);
>  	release_console_sem();
>  
>  	if (mx3_fbi->blank == FB_BLANK_UNBLANK) {
> @@ -1172,16 +1172,16 @@ static int mx3fb_suspend(struct platform_device *pdev, pm_message_t state)
>   */
>  static int mx3fb_resume(struct platform_device *pdev)
>  {
> -	struct mx3fb_data *drv_data = platform_get_drvdata(pdev);
> -	struct mx3fb_info *mx3_fbi = drv_data->fbi->par;
> +	struct mx3fb_data *mx3fb = platform_get_drvdata(pdev);
> +	struct mx3fb_info *mx3_fbi = mx3fb->fbi->par;
>  
>  	if (mx3_fbi->blank == FB_BLANK_UNBLANK) {
>  		sdc_enable_channel(mx3_fbi);
> -		sdc_set_brightness(mx3fb, drv_data->backlight_level);
> +		sdc_set_brightness(mx3fb, mx3fb->backlight_level);
>  	}
>  
>  	acquire_console_sem();
> -	fb_set_suspend(drv_data->fbi, 0);
> +	fb_set_suspend(mx3fb->fbi, 0);
>  	release_console_sem();
>  
>  	return 0;
> -- 
> 1.6.2.1
> 
> -- 
> Pengutronix e.K.                           |                             |
> Industrial Linux Solutions                 | http://www.pengutronix.de/  |
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer

------------------------------------------------------------------------------
This SF.net email is sponsored by:
High Quality Requirements in a Collaborative Environment.
Download a free trial of Rational Requirements Composer Now!
http://p.sf.net/sfu/www-ibm-com
