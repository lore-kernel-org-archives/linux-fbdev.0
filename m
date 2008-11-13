From: Dmitry Baryshkov <dbaryshkov@gmail.com>
Subject: Re: [PATCH] tmiofb: fix compilation with ACCEL
	disabled
Date: Thu, 13 Nov 2008 21:04:29 +0300
Message-ID: <20081113180429.GA28643@doriath.ww600.siemens.net>
References: <1225406749-18282-1-git-send-email-dbaryshkov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <dbaryshkov@gmail.com>) id 1L0gZS-00074Q-Vt
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Nov 2008 18:05:34 +0000
Received: from yw-out-1718.google.com ([74.125.46.152])
	by 72vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1L0gZP-0008CJ-39 for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 13 Nov 2008 18:05:34 +0000
Received: by yw-out-1718.google.com with SMTP id 6so428200ywa.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 13 Nov 2008 10:05:29 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1225406749-18282-1-git-send-email-dbaryshkov@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: linux-fbdev-devel@lists.sourceforge.net

On Fri, Oct 31, 2008 at 01:45:49AM +0300, Dmitry Baryshkov wrote:
> Restore support for compiling tmiofb with acceleration disabled.
> 
> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
> ---
>  drivers/video/tmiofb.c |   10 +++++++---
>  1 files changed, 7 insertions(+), 3 deletions(-)

What about this patch? Can it be merged either in 2.6.28 in the tree for
the next 2.6.29?

> 
> diff --git a/drivers/video/tmiofb.c b/drivers/video/tmiofb.c
> index 2a38001..7baf2dd 100644
> --- a/drivers/video/tmiofb.c
> +++ b/drivers/video/tmiofb.c
> @@ -222,6 +222,9 @@ static irqreturn_t tmiofb_irq(int irq, void *__info)
>  	unsigned int bbisc = tmio_ioread16(par->lcr + LCR_BBISC);
>  
>  
> +	tmio_iowrite16(bbisc, par->lcr + LCR_BBISC);
> +
> +#ifdef CONFIG_FB_TMIO_ACCELL
>  	/*
>  	 * We were in polling mode and now we got correct irq.
>  	 * Switch back to IRQ-based sync of command FIFO
> @@ -231,9 +234,6 @@ static irqreturn_t tmiofb_irq(int irq, void *__info)
>  		par->use_polling = false;
>  	}
>  
> -	tmio_iowrite16(bbisc, par->lcr + LCR_BBISC);
> -
> -#ifdef CONFIG_FB_TMIO_ACCELL
>  	if (bbisc & 1)
>  		wake_up(&par->wait_acc);
>  #endif
> @@ -938,7 +938,9 @@ static void tmiofb_dump_regs(struct platform_device *dev)
>  static int tmiofb_suspend(struct platform_device *dev, pm_message_t state)
>  {
>  	struct fb_info *info = platform_get_drvdata(dev);
> +#ifdef CONFIG_FB_TMIO_ACCELL
>  	struct tmiofb_par *par = info->par;
> +#endif
>  	struct mfd_cell *cell = dev->dev.platform_data;
>  	int retval = 0;
>  
> @@ -950,12 +952,14 @@ static int tmiofb_suspend(struct platform_device *dev, pm_message_t state)
>  		info->fbops->fb_sync(info);
>  
>  
> +#ifdef CONFIG_FB_TMIO_ACCELL
>  	/*
>  	 * The fb should be usable even if interrupts are disabled (and they are
>  	 * during suspend/resume). Switch temporary to forced polling.
>  	 */
>  	printk(KERN_INFO "tmiofb: switching to polling\n");
>  	par->use_polling = true;
> +#endif
>  	tmiofb_hw_stop(dev);
>  
>  	if (cell->suspend)
> -- 
> 1.5.6.5
> 

-- 
With best wishes
Dmitry


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
