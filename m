From: "H Hartley Sweeten" <hartleys@visionengravers.com>
Subject: Re: [RFC PATCH 2/2] ep93xx framebuffer driver
Date: Tue, 26 May 2009 12:29:26 -0400
Message-ID: <BD79186B4FD85F4B8E60E381CAEE1909017FF7FC@mi8nycmail19.Mi8.com>
References: <4A1A2ABD.8000104@bluewatersys.com>
	<4A1A2DB7.1050500@bluewatersys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <hartleys@visionengravers.com>) id 1M8zXK-0004HS-Lt
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 May 2009 16:29:58 +0000
Received: from exprod6ob113.obsmtp.com ([64.18.1.30] helo=psmtp.com)
	by 3b2kzd1.ch3.sourceforge.com with smtp (Exim 4.69)
	id 1M8zXH-0003qp-EB for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 26 May 2009 16:29:58 +0000
Content-class: urn:content-classes:message
In-Reply-To: <4A1A2DB7.1050500@bluewatersys.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Ryan Mallon <ryan@bluewatersys.com>, arm kernel <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net

On Sunday, May 24, 2009 10:34 PM, Ryan Mallon wrote:
> This patch adds support for the ep93xx framebuffer. Patch is against
> arm ep93xx branch.
>
> Can anybody with ep93xx hardware please test, specifically with regard
> to the physical address bit 27 bug. My hardware has the bug, but I'm
> not sure about other ep93xx chips.

I have not seen the address bit 27 bug on my custom hardware with
EP9307 Rev E0 silicon.

> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> 
> ---
> 
> diff --git a/arch/arm/mach-ep93xx/core.c b/arch/arm/mach-ep93xx/core.c
> index c535e88..885786c 100644
> --- a/arch/arm/mach-ep93xx/core.c
> +++ b/arch/arm/mach-ep93xx/core.c
> @@ -53,6 +53,7 @@
>  
>  #include <asm/hardware/vic.h>
>  
> +#include <mach/fb.h>
>  
>  /*************************************************************************
>   * Static I/O mappings that are needed for all EP93xx platforms
> @@ -546,6 +547,34 @@ void __init ep93xx_register_i2c(struct i2c_board_info *devices, int num)
>  	platform_device_register(&ep93xx_i2c_device);
>  }
>  
> +/*************************************************************************
> + * EP93xx video peripheral handling
> + *************************************************************************/
> +static struct ep93xxfb_mach_info ep93xxfb_data;
> +
> +static struct resource ep93xx_fb_resource[] = {
> +	{
> +		.start		= EP93XX_RASTER_PHYS_BASE,
> +		.end		= EP93XX_RASTER_PHYS_BASE + 0x800 - 1,
> +		.flags		= IORESOURCE_MEM,
> +	},
> +};
> +
> +static struct platform_device ep93xx_fb_device = {
> +	.name			= "ep93xxfb",
> +	.id			= 0,

Since there can only be one framebuffer device how about using
.id = -1?  This will change the clk dev_id to "ep93xxfb".  Also,
maybe change the name to "ep93xx-fb", that's how the usb host is
named.

> +	.dev.platform_data	= &ep93xxfb_data,
> +	.dev.coherent_dma_mask	= 0xf7ffffff,

I think this is supposed to be

	.dev.coherent_dma_mask	= DMA_BIT_MASK(32),

Or is the missing bit due to the address bit 27 bug?

> +	.num_resources		= ARRAY_SIZE(ep93xx_fb_resource),
> +	.resource		= ep93xx_fb_resource,
> +};
> +
> +void __init ep93xx_register_fb(struct ep93xxfb_mach_info *data)
> +{
> +	ep93xxfb_data = *data;
> +	platform_device_register(&ep93xx_fb_device);
> +}
> +
>  extern void ep93xx_gpio_init(void);
>  
>  void __init ep93xx_init_devices(void)

I will test the remainder of this patch later this week and comment then.

Regards,
Hartley

------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT 
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp as they present alongside digital heavyweights like Barbarian 
Group, R/GA, & Big Spaceship. http://p.sf.net/sfu/creativitycat-com 
