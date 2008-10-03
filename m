From: Samuel Ortiz <sameo@openedhand.com>
Subject: Re: [RESEND][PATCH 2/2] mfd: support tmiofb
	cell on tc6393xb
Date: Sat, 4 Oct 2008 00:56:49 +0200
Message-ID: <20081003225648.GA4878@localdomain>
References: <1222763910-22816-1-git-send-email-dbaryshkov@gmail.com>
	<1222763910-22816-2-git-send-email-dbaryshkov@gmail.com>
Reply-To: Samuel Ortiz <sameo@openedhand.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Klta2-0000CX-OQ for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 03 Oct 2008 22:57:02 +0000
Received: from 3a.49.1343.static.theplanet.com ([67.19.73.58]
	helo=pug.o-hand.com)
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1KltZx-0002eo-HQ
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 03 Oct 2008 22:57:02 +0000
Content-Disposition: inline
In-Reply-To: <1222763910-22816-2-git-send-email-dbaryshkov@gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Dmitry Baryshkov <dbaryshkov@gmail.com>
Cc: Ian Molton <spyro@f2s.com>, linux-fbdev-devel@lists.sourceforge.net

Hi Dmitry,

On Tue, Sep 30, 2008 at 12:38:30PM +0400, Dmitry Baryshkov wrote:
> Add support for tmiofb cell found in tc6393xb chip.
> 
> Signed-off-by: Dmitry Baryshkov <dbaryshkov@gmail.com>
> Cc: Ian Molton <spyro@f2s.com>
> Cc: Samuel Ortiz <sameo@openedhand.com>
I also pushed this one to mfd-next.
It was conflicting with the OHCI one you sent me earlier, so I fixed the
merge issues and applied it to my tree.
If the fb people want both patches to go through their way, they should let
me know.

Cheers,
Samuel.


> ---
>  drivers/mfd/tc6393xb.c       |  113 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/tc6393xb.h |    6 ++
>  2 files changed, 119 insertions(+), 0 deletions(-)
> 
> diff --git a/drivers/mfd/tc6393xb.c b/drivers/mfd/tc6393xb.c
> index e4c1c78..fc11e65 100644
> --- a/drivers/mfd/tc6393xb.c
> +++ b/drivers/mfd/tc6393xb.c
> @@ -113,6 +113,7 @@ struct tc6393xb {
>  enum {
>  	TC6393XB_CELL_NAND,
>  	TC6393XB_CELL_MMC,
> +	TC6393XB_CELL_FB,
>  };
>  
>  /*--------------------------------------------------------------------------*/
> @@ -170,6 +171,104 @@ static struct resource __devinitdata tc6393xb_mmc_resources[] = {
>  	},
>  };
>  
> +static struct resource __devinitdata tc6393xb_fb_resources[] = {
> +	{
> +		.start	= 0x5000,
> +		.end	= 0x51ff,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	{
> +		.start	= 0x0500,
> +		.end	= 0x05ff,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	{
> +		.start	= 0x100000,
> +		.end	= 0x1fffff,
> +		.flags	= IORESOURCE_MEM,
> +	},
> +	{
> +		.start	= IRQ_TC6393_FB,
> +		.end	= IRQ_TC6393_FB,
> +		.flags	= IORESOURCE_IRQ,
> +	},
> +};
> +
> +static int tc6393xb_fb_enable(struct platform_device *dev)
> +{
> +	struct tc6393xb *tc6393xb = dev_get_drvdata(dev->dev.parent);
> +	unsigned long flags;
> +	u16 ccr;
> +
> +	spin_lock_irqsave(&tc6393xb->lock, flags);
> +
> +	ccr = tmio_ioread16(tc6393xb->scr + SCR_CCR);
> +	ccr &= ~SCR_CCR_MCLK_MASK;
> +	ccr |= SCR_CCR_MCLK_48;
> +	tmio_iowrite16(ccr, tc6393xb->scr + SCR_CCR);
> +
> +	spin_unlock_irqrestore(&tc6393xb->lock, flags);
> +
> +	return 0;
> +}
> +
> +static int tc6393xb_fb_disable(struct platform_device *dev)
> +{
> +	struct tc6393xb *tc6393xb = dev_get_drvdata(dev->dev.parent);
> +	unsigned long flags;
> +	u16 ccr;
> +
> +	spin_lock_irqsave(&tc6393xb->lock, flags);
> +
> +	ccr = tmio_ioread16(tc6393xb->scr + SCR_CCR);
> +	ccr &= ~SCR_CCR_MCLK_MASK;
> +	ccr |= SCR_CCR_MCLK_OFF;
> +	tmio_iowrite16(ccr, tc6393xb->scr + SCR_CCR);
> +
> +	spin_unlock_irqrestore(&tc6393xb->lock, flags);
> +
> +	return 0;
> +}
> +
> +int tc6393xb_lcd_set_power(struct platform_device *fb, bool on)
> +{
> +	struct platform_device *dev = to_platform_device(fb->dev.parent);
> +	struct tc6393xb *tc6393xb = platform_get_drvdata(dev);
> +	u8 fer;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&tc6393xb->lock, flags);
> +
> +	fer = ioread8(tc6393xb->scr + SCR_FER);
> +	if (on)
> +		fer |= SCR_FER_SLCDEN;
> +	else
> +		fer &= ~SCR_FER_SLCDEN;
> +	iowrite8(fer, tc6393xb->scr + SCR_FER);
> +
> +	spin_unlock_irqrestore(&tc6393xb->lock, flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(tc6393xb_lcd_set_power);
> +
> +int tc6393xb_lcd_mode(struct platform_device *fb,
> +					const struct fb_videomode *mode) {
> +	struct platform_device *dev = to_platform_device(fb->dev.parent);
> +	struct tc6393xb *tc6393xb = platform_get_drvdata(dev);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&tc6393xb->lock, flags);
> +
> +	iowrite16(mode->pixclock, tc6393xb->scr + SCR_PLL1CR + 0);
> +	iowrite16(mode->pixclock >> 16, tc6393xb->scr + SCR_PLL1CR + 2);
> +
> +	spin_unlock_irqrestore(&tc6393xb->lock, flags);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL(tc6393xb_lcd_mode);
> +
>  static struct mfd_cell __devinitdata tc6393xb_cells[] = {
>  	[TC6393XB_CELL_NAND] = {
>  		.name = "tmio-nand",
> @@ -182,6 +281,15 @@ static struct mfd_cell __devinitdata tc6393xb_cells[] = {
>  		.num_resources = ARRAY_SIZE(tc6393xb_mmc_resources),
>  		.resources = tc6393xb_mmc_resources,
>  	},
> +	[TC6393XB_CELL_FB] = {
> +		.name = "tmio-fb",
> +		.num_resources = ARRAY_SIZE(tc6393xb_fb_resources),
> +		.resources = tc6393xb_fb_resources,
> +		.enable = tc6393xb_fb_enable,
> +		.suspend = tc6393xb_fb_disable,
> +		.resume = tc6393xb_fb_enable,
> +		.disable = tc6393xb_fb_disable,
> +	},
>  };
>  
>  /*--------------------------------------------------------------------------*/
> @@ -498,6 +606,11 @@ static int __devinit tc6393xb_probe(struct platform_device *dev)
>  	tc6393xb_cells[TC6393XB_CELL_MMC].data_size =
>  		sizeof(tc6393xb_cells[TC6393XB_CELL_MMC]);
>  
> +	tc6393xb_cells[TC6393XB_CELL_FB].driver_data = tcpd->fb_data;
> +	tc6393xb_cells[TC6393XB_CELL_FB].platform_data =
> +		&tc6393xb_cells[TC6393XB_CELL_FB];
> +	tc6393xb_cells[TC6393XB_CELL_FB].data_size =
> +		sizeof(tc6393xb_cells[TC6393XB_CELL_FB]);
>  
>  	ret = mfd_add_devices(&dev->dev, dev->id,
>  			tc6393xb_cells, ARRAY_SIZE(tc6393xb_cells),
> diff --git a/include/linux/mfd/tc6393xb.h b/include/linux/mfd/tc6393xb.h
> index fec7b3f..28a80a2 100644
> --- a/include/linux/mfd/tc6393xb.h
> +++ b/include/linux/mfd/tc6393xb.h
> @@ -33,13 +33,19 @@ struct tc6393xb_platform_data {
>  	int	gpio_base;
>  
>  	struct tmio_nand_data	*nand_data;
> +	struct tmio_fb_data	*fb_data;
>  };
>  
> +extern int tc6393xb_lcd_mode(struct platform_device *fb,
> +					const struct fb_videomode *mode);
> +extern int tc6393xb_lcd_set_power(struct platform_device *fb, bool on);
> +
>  /*
>   * Relative to irq_base
>   */
>  #define	IRQ_TC6393_NAND		0
>  #define	IRQ_TC6393_MMC		1
> +#define	IRQ_TC6393_FB		4
>  
>  #define	TC6393XB_NR_IRQS	8
>  
> -- 
> 1.5.6.5
> 

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
