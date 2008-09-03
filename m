From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: Re: [PATCH] i.MX Framebuffer: Use readl/writel
 instead of direct pointer deref
Date: Wed, 3 Sep 2008 21:06:58 +0200
Message-ID: <20080903210658.f9f34666.krzysztof.h1@poczta.fm>
References: <1220354697-13648-1-git-send-email-s.hauer@pengutronix.de>
	<1220354697-13648-4-git-send-email-s.hauer@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1KaxwT-0007Nd-Ge for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 12:23:01 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1KaxwO-0003kN-So
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 03 Sep 2008 12:23:01 -0700
In-Reply-To: <1220354697-13648-4-git-send-email-s.hauer@pengutronix.de>
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
Cc: Juergen Beisert <j.beisert@pengutronix.de>, linux-fbdev-devel@lists.sourceforge.net, Andrew Dyer <amdyer@gmail.com>

On Tue,  2 Sep 2008 13:24:46 +0200
Sascha Hauer <s.hauer@pengutronix.de> wrote:

> From: Juergen Beisert <j.beisert@pengutronix.de>
> 
> This patch prepares the current i.MX1 framebuffer driver for usage in the
> whole i.MX family. It switches to readl/writel for register accesses.
> Also it moves the register definitions to the driver where they belong.
> 
> Signed-off-by: Juergen Beisert <j.beisert@pengutronix.de>
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
>  arch/arm/mach-imx/include/mach/imxfb.h |   45 ++++++++
>  drivers/video/imxfb.c                  |  193 +++++++++++++++++++++-----------
>  drivers/video/imxfb.h                  |    3 +-
>  3 files changed, 175 insertions(+), 66 deletions(-)
> 

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

One comment only - see below.

> diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> index a990d43..1bccf5a 100644
> --- a/drivers/video/imxfb.c
> +++ b/drivers/video/imxfb.c
> @@ -506,23 +552,38 @@ static int __init imxfb_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, info);
>  
> -	ret = imxfb_init_fbinfo(&pdev->dev);
> +	ret = imxfb_init_fbinfo(pdev);
>  	if( ret < 0 )
>  		goto failed_init;
>  
> -	res = request_mem_region(res->start, res->end - res->start + 1, "IMXFB");
> +	res = request_mem_region(res->start, resource_size(res),
> +				DRIVER_NAME);
>  	if (!res) {
>  		ret = -EBUSY;
> -		goto failed_regs;
> +		goto failed_req;
> +	}
> +
> +	fbi->regs = ioremap(res->start, resource_size(res));
> +	if (fbi->regs == NULL) {
> +		printk(KERN_ERR"Cannot map frame buffer registers\n");
> +		goto failed_ioremap;
>  	}
>  
>  	if (!inf->fixed_screen_cpu) {
> -		ret = imxfb_map_video_memory(info);
> -		if (ret) {
> +		fbi->map_size = PAGE_ALIGN(info->fix.smem_len);
> +		fbi->map_cpu = dma_alloc_writecombine(&pdev->dev,
> +				fbi->map_size, &fbi->map_dma, GFP_KERNEL);
> +
> +		if (!fbi->map_cpu) {
>  			dev_err(&pdev->dev, "Failed to allocate video RAM: %d\n", ret);
>  			ret = -ENOMEM;
>  			goto failed_map;
>  		}
> +
> +		info->screen_base = fbi->map_cpu;
> +		fbi->screen_cpu = fbi->map_cpu;
> +		fbi->screen_dma = fbi->map_dma;
> +		info->fix.smem_start = fbi->screen_dma;

It seems that fbi->screen_cpu and fbi->screen_dma are redundant
as they are always equal to info->screen_base and info->fix.smem_start.

You can kill then in some next patch.

Regards,
Krzysztof

---------------------------------------------------------------
Nasilaja sie kradzieze.
Mieszkancy osiedli zaniepokojeni.
Prosimy o pomoc w tej sprawie >>> http://link.interia.pl/f1eef



-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
