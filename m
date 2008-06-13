From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [RFC 2.6.26-rc3 04/10] pxafb: add exit and
	remove handlers
Date: Fri, 13 Jun 2008 09:24:50 +0800
Message-ID: <4851CC62.8000008@gmail.com>
References: <1213289961-1562-1-git-send-email-jayakumar.lkml@gmail.com>
	<1213289961-1562-5-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K6y2F-0008Ed-TX for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 18:24:59 -0700
Received: from ti-out-0910.google.com ([209.85.142.189])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1K6y2C-0005wX-BV
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 18:24:59 -0700
Received: by ti-out-0910.google.com with SMTP id y6so1392790tia.18
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 12 Jun 2008 18:24:54 -0700 (PDT)
In-Reply-To: <1213289961-1562-5-git-send-email-jayakumar.lkml@gmail.com>
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
To: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: ymiao3@marvell.com, linux-fbdev-devel@lists.sourceforge.net, linux-arm-kernel@lists.arm.linux.org.uk

Jaya Kumar wrote:
> This patch adds exit and remove handlers to pxafb so that it can be loaded
> and unloaded as a module.
> 
> Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>

Acked-by: Eric Miao <eric.miao@marvell.com>

> ---
>  drivers/video/pxafb.c |   44 ++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 44 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/video/pxafb.c b/drivers/video/pxafb.c
> index b891aac..89f1b48 100644
> --- a/drivers/video/pxafb.c
> +++ b/drivers/video/pxafb.c
> @@ -1790,11 +1790,49 @@ failed:
>  	return ret;
>  }
>  
> +static int __devexit pxafb_remove(struct platform_device *dev)
> +{
> +	struct pxafb_info *fbi = platform_get_drvdata(dev);
> +	struct resource *r;
> +	int irq;
> +	struct fb_info *info;
> +
> +	if (!fbi)
> +		return 0;
> +
> +	info = &fbi->fb;
> +
> +	unregister_framebuffer(info);
> +
> +	pxafb_disable_controller(fbi);
> +
> +	if (fbi->fb.cmap.len)
> +		fb_dealloc_cmap(&fbi->fb.cmap);
> +
> +	irq = platform_get_irq(dev, 0);
> +	free_irq(irq, fbi);
> +
> +	dma_free_writecombine(&dev->dev, fbi->map_size,
> +					fbi->map_cpu, fbi->map_dma);
> +
> +	iounmap(fbi->mmio_base);
> +
> +	r = platform_get_resource(dev, IORESOURCE_MEM, 0);
> +	release_mem_region(r->start, r->end - r->start + 1);
> +
> +	clk_put(fbi->clk);
> +	kfree(fbi);
> +
> +	return 0;
> +}
> +
>  static struct platform_driver pxafb_driver = {
>  	.probe		= pxafb_probe,
> +	.remove 	= pxafb_remove,
>  	.suspend	= pxafb_suspend,
>  	.resume		= pxafb_resume,
>  	.driver		= {
> +		.owner	= THIS_MODULE,
>  		.name	= "pxa2xx-fb",
>  	},
>  };
> @@ -1807,7 +1845,13 @@ static int __init pxafb_init(void)
>  	return platform_driver_register(&pxafb_driver);
>  }
>  
> +static void __exit pxafb_exit(void)
> +{
> +	platform_driver_unregister(&pxafb_driver);
> +}
> +
>  module_init(pxafb_init);
> +module_exit(pxafb_exit);
>  
>  MODULE_DESCRIPTION("loadable framebuffer driver for PXA");
>  MODULE_LICENSE("GPL");


-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
