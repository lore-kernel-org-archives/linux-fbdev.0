From: Tony Lindgren <tony@atomide.com>
Date: Thu, 18 Jul 2013 07:02:20 +0000
Subject: Re: [PATCH 04/15] ARM: OMAP: USB: Add phy binding information
Message-Id: <20130718070219.GM7656@atomide.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1374129984-765-1-git-send-email-kishon@ti.com>
 <1374129984-765-5-git-send-email-kishon@ti.com>
In-Reply-To: <1374129984-765-5-git-send-email-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

* Kishon Vijay Abraham I <kishon@ti.com> [130717 23:53]:
> In order for controllers to get PHY in case of non dt boot, the phy
> binding information (phy device name) should be added in the platform
> data of the controller.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Reviewed-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> Acked-by: Felipe Balbi <balbi@ti.com>
> ---
>  arch/arm/mach-omap2/usb-musb.c |    3 +++
>  include/linux/usb/musb.h       |    3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/arch/arm/mach-omap2/usb-musb.c b/arch/arm/mach-omap2/usb-musb.c
> index 8c4de27..6aa7cbf 100644
> --- a/arch/arm/mach-omap2/usb-musb.c
> +++ b/arch/arm/mach-omap2/usb-musb.c
> @@ -85,6 +85,9 @@ void __init usb_musb_init(struct omap_musb_board_data *musb_board_data)
>  	musb_plat.mode = board_data->mode;
>  	musb_plat.extvbus = board_data->extvbus;
>  
> +	if (cpu_is_omap34xx())
> +		musb_plat.phy_label = "twl4030";
> +
>  	if (soc_is_am35xx()) {
>  		oh_name = "am35x_otg_hs";
>  		name = "musb-am35x";

I don't think there's a USB PHY on non-twl4030 chips, so this should
be OK:

Acked-by: Tony Lindgren <tony@atomide.com>


> diff --git a/include/linux/usb/musb.h b/include/linux/usb/musb.h
> index 053c268..596f8c8 100644
> --- a/include/linux/usb/musb.h
> +++ b/include/linux/usb/musb.h
> @@ -104,6 +104,9 @@ struct musb_hdrc_platform_data {
>  	/* for clk_get() */
>  	const char	*clock;
>  
> +	/* phy label */
> +	const char	*phy_label;
> +
>  	/* (HOST or OTG) switch VBUS on/off */
>  	int		(*set_vbus)(struct device *dev, int is_on);
>  
> -- 
> 1.7.10.4
> 
