From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 1/2] atmel_lcdfb: Fix oops in rmmod
 when framebuffer fail to register
Date: Fri, 05 Sep 2008 09:24:00 +0200
Message-ID: <48C0DE90.5060505@atmel.com>
References: <200809031536.50390.stf_xl@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KbVgO-000358-34 for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 00:24:40 -0700
Received: from mail.atmel.fr ([81.80.104.162] helo=atmel-es2.atmel.fr)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KbVgM-0005mv-DA
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 00:24:40 -0700
In-Reply-To: <200809031536.50390.stf_xl@wp.pl>
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
To: Stanislaw Gruszka <stf_xl@wp.pl>, Andrew Morton <akpm@linux-foundation.org>
Cc: krzysztof.h1@wp.pl, linux-fbdev-devel@lists.sourceforge.net, Haavard Skinnemoen <hskinnemoen@atmel.com>

Stanislaw Gruszka :
> If framebuffer registration failed in platform driver ->probe() callback,
> dev_get_drvdata() points to freed memory region, but ->remove()
> function try to use it and the following oops occurs:

[..]

> This patch fix oops.
> 
> Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
> CC: Nicolas Ferre <nicolas.ferre@atmel.com>

Feel free to add :
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  drivers/video/atmel_lcdfb.c |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index a471a60..3376f35 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -939,7 +939,7 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
>  	ret = register_framebuffer(info);
>  	if (ret < 0) {
>  		dev_err(dev, "failed to register framebuffer device: %d\n", ret);
> -		goto free_cmap;
> +		goto reset_drvdata;
>  	}
>  
>  	/* add selected videomode to modelist */
> @@ -955,7 +955,8 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
>  
>  	return 0;
>  
> -
> +reset_drvdata:
> +	dev_set_drvdata(dev, NULL);
>  free_cmap:
>  	fb_dealloc_cmap(&info->cmap);
>  unregister_irqs:
> @@ -992,10 +993,11 @@ static int __exit atmel_lcdfb_remove(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct fb_info *info = dev_get_drvdata(dev);
> -	struct atmel_lcdfb_info *sinfo = info->par;
> +	struct atmel_lcdfb_info *sinfo;
>  
> -	if (!sinfo)
> +	if (!info || !info->par)
>  		return 0;
> +	sinfo = info->par;
>  
>  	cancel_work_sync(&sinfo->task);
>  	exit_backlight(sinfo);


-- 
Nicolas Ferre


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
