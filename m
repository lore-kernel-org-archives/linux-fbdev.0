From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: Re: [PATCH] atmel_lcdfb: backlight control
Date: Wed, 23 Jan 2008 18:27:34 +0100
Message-ID: <20080123182734.45a84e82@dhcp-252-066.norway.atmel.com>
References: <4790BB53.3080407@atmel.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JHjOU-0002in-Gw for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Jan 2008 09:28:10 -0800
Received: from nat-132.atmel.no ([80.232.32.132] helo=relay.atmel.no)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JHjOR-0003Th-GB
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 23 Jan 2008 09:28:09 -0800
In-Reply-To: <4790BB53.3080407@atmel.com>
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
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: David Brownell <david-b@pacbell.net>, ARM Linux Mailing List <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net, Linux Kernel list <linux-kernel@vger.kernel.org>, Andrew Victor <linux@maxim.org.za>

On Fri, 18 Jan 2008 15:44:35 +0100
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> On the sam9 EK boards, the LCD backlight is hooked up to a PWM output
> from the LCD controller.  It's controlled by "contrast" registers though.
> 
> This patch lets boards declare that they have that kind of backlight
> control.  The driver can then export this control, letting screenblank
> and other operations actually take effect ... reducing the typically
> substantial power drain from the backlight.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>

Looks good to me. It won't affect any current AVR32 boards, although
that may change in the future.

A couple of minor comments below.

> +static struct backlight_ops atmel_lcdc_bl_ops = {
> +	.update_status = atmel_bl_update_status,
> +	.get_brightness = atmel_bl_get_brightness,
> +};

This can be const, no?

No it can't, since backlight_device_register() takes a non-const
pointer for some reason...

> +#else
> +
> +static inline void init_backlight(struct atmel_lcdfb_info *sinfo)
> +{
> +	dev_warn(&sinfo->pdev->dev, "backlight control is not available\n");
> +}
> +
> +static inline void exit_contrast(struct atmel_lcdfb_info *sinfo)
> +{
> +}
> +
> +#endif

This looks a bit asymmetric...

> +static inline void init_contrast(struct atmel_lcdfb_info *sinfo)
> +{
> +	/* have some default contrast/backlight settings */
> +	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, contrast_ctr);
> +	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_VAL, ATMEL_LCDC_CVAL_DEFAULT);
> +
> +	if (sinfo->lcdcon_is_backlight)
> +		init_backlight(sinfo);
> +}
> +
>  
>  static struct fb_fix_screeninfo atmel_lcdfb_fix __initdata = {
>  	.type		= FB_TYPE_PACKED_PIXELS,
> @@ -370,10 +472,6 @@ static int atmel_lcdfb_set_par(struct fb
>  	/* Disable all interrupts */
>  	lcdc_writel(sinfo, ATMEL_LCDC_IDR, ~0UL);
>  
> -	/* Set contrast */
> -	value = ATMEL_LCDC_PS_DIV8 | ATMEL_LCDC_POL_POSITIVE | ATMEL_LCDC_ENA_PWMENABLE;
> -	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, value);
> -	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_VAL, ATMEL_LCDC_CVAL_DEFAULT);
>  	/* ...wait for DMA engine to become idle... */
>  	while (lcdc_readl(sinfo, ATMEL_LCDC_DMACON) & ATMEL_LCDC_DMABUSY)
>  		msleep(10);
> @@ -577,6 +675,7 @@ static int __init atmel_lcdfb_probe(stru
>  		sinfo->default_monspecs = pdata_sinfo->default_monspecs;
>  		sinfo->atmel_lcdfb_power_control = pdata_sinfo->atmel_lcdfb_power_control;
>  		sinfo->guard_time = pdata_sinfo->guard_time;
> +		sinfo->lcdcon_is_backlight = pdata_sinfo->lcdcon_is_backlight;
>  	} else {
>  		dev_err(dev, "cannot get default configuration\n");
>  		goto free_info;
> @@ -670,6 +769,9 @@ static int __init atmel_lcdfb_probe(stru
>  		goto release_mem;
>  	}
>  
> +	/* Initialize PWM for contrast or backlight ("off") */
> +	init_contrast(sinfo);
> +
>  	/* interrupt */
>  	ret = request_irq(sinfo->irq_base, atmel_lcdfb_interrupt, 0, pdev->name, info);
>  	if (ret) {
> @@ -755,6 +857,7 @@ static int __exit atmel_lcdfb_remove(str
>  	if (!sinfo)
>  		return 0;
>  
> +	exit_contrast(sinfo);

Missing exit_contrast() in probe() error path?

Haavard

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
