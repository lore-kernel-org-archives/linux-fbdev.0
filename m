From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Wed, 21 Mar 2012 18:47:23 +0000
Subject: Re: [PATCH v2] fbdev: sh_mipi_dsi: add extra phyctrl for sh_mipi_dsi_info
Message-Id: <4F6A223B.3070606@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <87mx7awxdd.wl%kuninori.morimoto.gx@renesas.com>
In-Reply-To: <87mx7awxdd.wl%kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 03/21/2012 01:34 AM, Kuninori Morimoto wrote:
> sh_mipi uses some clocks, but the method of setup depends on CPU.
> 
> Current SuperH (like sh73a0) can control all of these clocks
> by CPG (Clock Pulse Generator).
> It means we can control it by clock framework only.
> But on sh7372, it needs CPG settings AND sh_mipi PHYCTRL::PLLDS,
> and only sh7372 has PHYCTRL::PLLDS.
> 
> But on current sh_mipi driver, PHYCTRL::PLLDS of sh7372 was
> overwrote since the callback timing of clock setting was changed
> by c2658b70f06108361aa5024798f9c1bf47c73374
> (fbdev: sh_mipi_dsi: fixup setup timing of sh_mipi_setup()).
> To solve this issue, this patch adds extra .phyctrl.
> 
> This patch adds detail explanation for unclear mipi settings
> and fixup wrong PHYCTRL::PLLDS value for ap4evb (0xb -> 0x6).
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Applied.


Thanks,

Florian Tobias Schandinat

> ---
> v1 -> v2
> 
> - fixup wrong MHz (321 -> 312)
> - Adds explain that this patch fixup wrong PLLDS value for ap4evb
> 
>  arch/arm/mach-shmobile/board-ap4evb.c |   12 +++++++++---
>  drivers/video/sh_mipi_dsi.c           |    2 +-
>  include/video/sh_mipi_dsi.h           |    1 +
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
> index eeb4d96..50fcf1b 100644
> --- a/arch/arm/mach-shmobile/board-ap4evb.c
> +++ b/arch/arm/mach-shmobile/board-ap4evb.c
> @@ -556,20 +556,25 @@ static struct platform_device keysc_device = {
>  };
>  
>  /* MIPI-DSI */
> -#define PHYCTRL		0x0070
>  static int sh_mipi_set_dot_clock(struct platform_device *pdev,
>  				 void __iomem *base,
>  				 int enable)
>  {
>  	struct clk *pck = clk_get(&pdev->dev, "dsip_clk");
> -	void __iomem *phy =  base + PHYCTRL;
>  
>  	if (IS_ERR(pck))
>  		return PTR_ERR(pck);
>  
>  	if (enable) {
> +		/*
> +		 * DSIPCLK	= 24MHz
> +		 * D-PHY	= DSIPCLK * ((0x6*2)+1) = 312MHz (see .phyctrl)
> +		 * HsByteCLK	= D-PHY/8 = 39MHz
> +		 *
> +		 *  X * Y * FPS > +		 * (544+72+600+16) * (961+8+8+2) * 30 = 36.1MHz
> +		 */
>  		clk_set_rate(pck, clk_round_rate(pck, 24000000));
> -		iowrite32(ioread32(phy) | (0xb << 8), phy);
>  		clk_enable(pck);
>  	} else {
>  		clk_disable(pck);
> @@ -598,6 +603,7 @@ static struct sh_mipi_dsi_info mipidsi0_info = {
>  	.lcd_chan	= &lcdc_info.ch[0],
>  	.lane		= 2,
>  	.vsynw_offset	= 17,
> +	.phyctrl	= 0x6 << 8,
>  	.flags		= SH_MIPI_DSI_SYNC_PULSES_MODE |
>  			  SH_MIPI_DSI_HSbyteCLK,
>  	.set_dot_clock	= sh_mipi_set_dot_clock,
> diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
> index 05151b8..214482c 100644
> --- a/drivers/video/sh_mipi_dsi.c
> +++ b/drivers/video/sh_mipi_dsi.c
> @@ -271,7 +271,7 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
>  	iowrite32(0x00000001, base + PHYCTRL);
>  	udelay(200);
>  	/* Deassert resets, power on */
> -	iowrite32(0x03070001, base + PHYCTRL);
> +	iowrite32(0x03070001 | pdata->phyctrl, base + PHYCTRL);
>  
>  	/*
>  	 * Default = ULPS enable |
> diff --git a/include/video/sh_mipi_dsi.h b/include/video/sh_mipi_dsi.h
> index 434d56b..06c67fb 100644
> --- a/include/video/sh_mipi_dsi.h
> +++ b/include/video/sh_mipi_dsi.h
> @@ -51,6 +51,7 @@ struct sh_mipi_dsi_info {
>  	int				lane;
>  	unsigned long			flags;
>  	u32				clksrc;
> +	u32				phyctrl; /* for extra setting */
>  	unsigned int			vsynw_offset;
>  	int	(*set_dot_clock)(struct platform_device *pdev,
>  				 void __iomem *base,

