From: "Chaithrika U S" <chaithrika-l0cyMroinI0@public.gmane.org>
Subject: RE: [PATCH] davinci: fb: Calculate the clock divider from pixel
	clock info
Date: Fri, 23 Oct 2009 10:41:07 +0530
Message-ID: <032201ca539f$3a879530$af96bf90$@com>
References: <1256033887-1582-1-git-send-email-chaithrika@ti.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
In-Reply-To: <1256033887-1582-1-git-send-email-chaithrika-l0cyMroinI0@public.gmane.org>
Content-Language: en-us
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/davinci-linux-open-source>
List-Post: <mailto:davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org>
List-Help: <mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=help>
List-Subscribe: <http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source>,
	<mailto:davinci-linux-open-source-request-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org?subject=subscribe>
Sender: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Errors-To: davinci-linux-open-source-bounces+gld-davinci-linux-open-source=gmane.org-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org
Content-Type: text/plain; charset="us-ascii"
To: 'Chaithrika U S' <chaithrika-l0cyMroinI0@public.gmane.org>, linux-fbdev-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Cc: davinci-linux-open-source-VycZQUHpC/PFrsHnngEfi1aTQe2KTcn/@public.gmane.org, akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org, krzysztof.h1-IjDXvh/HVVUAvxtiuMwx3w@public.gmane.org

All,

Any comments/suggestions on this patch?

Regards, 
Chaithrika

On Tue, Oct 20, 2009 at 15:48:07, Chaithrika U S wrote:
> The clock divider value can be calculated from the pixel clock
> value for the panel. This gives more flexiblity to the driver
> to change the divider value on the fly as in the case of cpufreq
> feature- support for which will be added shortly.
> 
> Signed-off-by: Chaithrika U S <chaithrika-l0cyMroinI0@public.gmane.org>
> ---
> This patch applies on Linus' kernel tree.
> Resending this patch as missed out marking fbdev list previously.
> 
>  drivers/video/da8xx-fb.c |   28 ++++++++++++++++++++--------
>  1 files changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index d065894..d9ab839 100644
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
> @@ -451,6 +452,18 @@ static void lcd_reset(struct da8xx_fb_par *par)
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
> @@ -459,9 +472,8 @@ static int lcd_init(struct da8xx_fb_par *par, const struct lcd_ctrl_config *cfg,
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
> @@ -721,6 +733,8 @@ static int __init fb_probe(struct platform_device *device)
>  	}
>  
>  	par = da8xx_fb_info->par;
> +	par->lcdc_clk = fb_clk;
> +	par->pxl_clk = lcdc_info->pxl_clk;
>  
>  	if (lcd_init(par, lcd_cfg, lcdc_info) < 0) {
>  		dev_err(&device->dev, "lcd_init failed\n");
> @@ -753,8 +767,6 @@ static int __init fb_probe(struct platform_device *device)
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
