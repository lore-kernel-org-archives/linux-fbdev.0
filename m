From: "Chaithrika U S" <chaithrika@ti.com>
Subject: Re: [PATCH] davinci: fb: Calculate the clock
	divider from pixel clock info
Date: Fri, 16 Oct 2009 16:36:20 +0530
Message-ID: <01d401ca4e50$b0c82f60$12588e20$@com>
References: <1255688822-23645-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <chaithrika@ti.com>) id 1Mykfm-0006ee-Bh
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Oct 2009 11:08:38 +0000
Received: from comal.ext.ti.com ([198.47.26.152])
	by 29vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1Mykfd-0003Nb-AN
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 16 Oct 2009 11:08:36 +0000
In-Reply-To: <1255688822-23645-1-git-send-email-chaithrika@ti.com>
Content-Language: en-us
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: 'Chaithrika U S' <chaithrika@ti.com>, linux-fbdev-devel@lists.sourceforge.net
Cc: davinci-linux-open-source@linux.davincidsp.com, akpm@linux-foundation.org

All,

Please ignore this patch, will post an updated version soon.

Regards, 
Chaithrika

On Fri, Oct 16, 2009 at 15:57:02, Chaithrika U S wrote:
> The clock divider value can be calculated from the pixel clock
> value for the panel. This gives more flexiblity to the driver
> to change the divider value on the fly as in the case of cpufreq
> feature- support for which will be added shortly.
> 
> Signed-off-by: Chaithrika U S <chaithrika@ti.com>
> ---
> This patch applies to Linus' kernel tree
> 
>  drivers/video/da8xx-fb.c |   29 +++++++++++++++++++++--------
>  1 files changed, 21 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index d065894..7615939 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -113,6 +113,7 @@ struct da8xx_fb_par {
>  	unsigned short pseudo_palette[16];
>  	unsigned int databuf_sz;
>  	unsigned int palette_sz;
> +	unsigned int pxl_clk;
>  };
>  
>  /* Variable Screen Information */
> @@ -155,7 +156,7 @@ struct da8xx_panel {
>  	int		vfp;		/* Vertical front porch */
>  	int		vbp;		/* Vertical back porch */
>  	int		vsw;		/* Vertical Sync Pulse Width */
> -	int		pxl_clk;	/* Pixel clock */
> +	unsigned int	pxl_clk;	/* Pixel clock */
>  	unsigned char	invert_pxl_clk;	/* Invert Pixel clock */
>  };
>  
> @@ -171,7 +172,7 @@ static struct da8xx_panel known_lcd_panels[] = {
>  		.vfp = 2,
>  		.vbp = 2,
>  		.vsw = 0,
> -		.pxl_clk = 0x10,
> +		.pxl_clk = 4608000,
>  		.invert_pxl_clk = 1,
>  	},
>  	/* Sharp LK043T1DG01 */
> @@ -185,7 +186,7 @@ static struct da8xx_panel known_lcd_panels[] = {
>  		.vfp = 2,
>  		.vbp = 2,
>  		.vsw = 10,
> -		.pxl_clk = 0x12,
> +		.pxl_clk = 7833600,
>  		.invert_pxl_clk = 0,
>  	},
>  };
> @@ -451,17 +452,29 @@ static void lcd_reset(struct da8xx_fb_par *par)
>  	lcdc_write(0, LCD_RASTER_CTRL_REG);
>  }
>  
> +static void lcd_calc_clk_divider(struct da8xx_fb_par *par)
> +{
> +	unsigned int lcd_clk, div;
> +
> +	lcd_clk = clk_get_rate(par->lcdc_clk);
> +	div = lcd_clk / par->pxl_clk;
> +
> +	/* Configure the LCD clock divisor. */
> +	lcdc_write(LCD_CLK_DIVISOR(div) |
> +			(LCD_RASTER_MODE & 0x1), LCD_CTRL_REG);
> +}
> +
>  static int lcd_init(struct da8xx_fb_par *par, const struct lcd_ctrl_config *cfg,
>  		struct da8xx_panel *panel)
>  {
>  	u32 bpp;
>  	int ret = 0;
> +	unsigned int lcd_clk, div;
>  
>  	lcd_reset(par);
>  
> -	/* Configure the LCD clock divisor. */
> -	lcdc_write(LCD_CLK_DIVISOR(panel->pxl_clk) |
> -			(LCD_RASTER_MODE & 0x1), LCD_CTRL_REG);
> +	/* Calculate the divider */
> +	lcd_calc_clk_divider(par);
>  
>  	if (panel->invert_pxl_clk)
>  		lcdc_write((lcdc_read(LCD_RASTER_TIMING_2_REG) |
> @@ -721,6 +734,8 @@ static int __init fb_probe(struct platform_device *device)
>  	}
>  
>  	par = da8xx_fb_info->par;
> +	par->lcdc_clk = fb_clk;
> +	par->pxl_clk = lcdc_info->pxl_clk;
>  
>  	if (lcd_init(par, lcd_cfg, lcdc_info) < 0) {
>  		dev_err(&device->dev, "lcd_init failed\n");
> @@ -753,8 +768,6 @@ static int __init fb_probe(struct platform_device *device)
>  	da8xx_fb_fix.smem_len = par->databuf_sz - par->palette_sz;
>  	da8xx_fb_fix.line_length = (lcdc_info->width * lcd_cfg->bpp) / 8;
>  
> -	par->lcdc_clk = fb_clk;
> -
>  	par->irq = platform_get_irq(device, 0);
>  	if (par->irq < 0) {
>  		ret = -ENOENT;
> -- 
> 1.5.6
> 





------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
