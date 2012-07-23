From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Mon, 23 Jul 2012 08:26:43 +0000
Subject: RE: [PATCH v3] video: da8xx-fb: add 24bpp LCD configuration support
Message-Id: <A73F36158E33644199EB82C5EC81C7BC3E99C283@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1342712266-4381-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1342712266-4381-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi,

On Thu, Jul 19, 2012 at 21:07:46, Manjunathappa, Prakash wrote:
> LCD controller on am335x supports 24bpp raster configuration in addition
> to ones on da850. LCDC also supports 24bpp in unpacked format having
> ARGB:8888 32bpp format data in DDR, but it doesn't interpret alpha
> component of the data.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> Cc: Anatolij Gustschin <agust@denx.de>
> ---
> Since v2:
> Fixed additional configurations for 24bpp support.
> Since v1:
> Simplified calculation of pseudopalette for FB_VISUAL_TRUECOLOR type.
> 
>  drivers/video/da8xx-fb.c |  127 ++++++++++++++++++++++++++++++++++------------
>  1 files changed, 94 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 47118c7..3d2d0d1 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -83,6 +83,8 @@
>  #define LCD_V2_LIDD_CLK_EN		BIT(1)
>  #define LCD_V2_CORE_CLK_EN		BIT(0)
>  #define LCD_V2_LPP_B10			26
> +#define LCD_V2_TFT_24BPP_MODE		BIT(25)
> +#define LCD_V2_TFT_24BPP_UNPACK		BIT(26)
>  
>  /* LCD Raster Timing 2 Register */
>  #define LCD_AC_BIAS_TRANSITIONS_PER_INT(x)	((x) << 16)
> @@ -153,7 +155,7 @@ struct da8xx_fb_par {
>  	unsigned int		dma_end;
>  	struct clk *lcdc_clk;
>  	int irq;
> -	unsigned short pseudo_palette[16];
> +	unsigned long pseudo_palette[16];

I am still not convinced as sizes of "unsigned long" and "unsigned int" are not
guaranteed to be 32bit across platforms and compilers, so planning to retain u32.

Florian Tobias Schandinat,
Can you please comment?

Here is the history:
http://marc.info/?l=linux-fbdev&m4259216714719&w=2

>  	unsigned int palette_sz;
>  	unsigned int pxl_clk;
>  	int blank;
> @@ -482,6 +484,9 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
>  {
>  	u32 reg;
>  
> +	if ((bpp > 16) && (lcd_revision = LCD_VERSION_1))
> +		return -EINVAL;
> +
>  	/* Set the Panel Width */
>  	/* Pixels per line = (PPL + 1)*16 */
>  	if (lcd_revision = LCD_VERSION_1) {
> @@ -525,6 +530,12 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
>  	reg = lcdc_read(LCD_RASTER_CTRL_REG) & ~(1 << 8);
>  	if (raster_order)
>  		reg |= LCD_RASTER_ORDER;
> +
> +	if (bpp = 24)
> +		reg |= LCD_V2_TFT_24BPP_MODE;
> +	else if (bpp = 32)
> +		reg |= (LCD_V2_TFT_24BPP_MODE | LCD_V2_TFT_24BPP_UNPACK);
> +
>  	lcdc_write(reg, LCD_RASTER_CTRL_REG);
>  
>  	switch (bpp) {
> @@ -532,6 +543,8 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
>  	case 2:
>  	case 4:
>  	case 16:
> +	case 24:
> +	case 32:
>  		par->palette_sz = 16 * 2;
>  		break;
>  
> @@ -546,6 +559,8 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
>  	return 0;
>  }
>  
> +
> +#define CNVT_TOHW(val, width) ((((val)<<(width))+0x7FFF-(val))>>16)

since multiple FB drivers have re-defined this macro, I will move this to common place(linux/fb.h) and
convert it as inline function.

Thanks,
Prakash

>  static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
[...]
