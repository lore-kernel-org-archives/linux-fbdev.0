From: Sergei Shtylyov <sshtylyov@mvista.com>
Date: Wed, 08 Aug 2012 16:14:55 +0000
Subject: Re: [PATCH v4] da8xx-fb: add 24bpp LCD configuration support
Message-Id: <5022907F.8070400@mvista.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1344440145-27117-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1344440145-27117-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hello.

On 08-08-2012 19:35, Manjunathappa, Prakash wrote:

> LCD controller on am335x supports 24bpp raster configuration in addition
> to ones on da850. LCDC also supports 24bpp in unpacked format having
> ARGB:8888 32bpp format data in DDR, but it doesn't interpret alpha
> component of the data.

> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> Cc: Anatolij Gustschin <agust@denx.de>
[...]

> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 7ae9d53..1abcfa9 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
[...]
> @@ -499,6 +501,9 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
>   {
>   	u32 reg;
>
> +	if ((bpp > 16) && (lcd_revision = LCD_VERSION_1))

    Parens around operands of && not necessary.

> @@ -542,6 +547,12 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
>   	reg = lcdc_read(LCD_RASTER_CTRL_REG) & ~(1 << 8);
>   	if (raster_order)
>   		reg |= LCD_RASTER_ORDER;
> +
> +	if (bpp = 24)
> +		reg |= LCD_V2_TFT_24BPP_MODE;
> +	else if (bpp = 32)
> +		reg |= (LCD_V2_TFT_24BPP_MODE | LCD_V2_TFT_24BPP_UNPACK);
> +

    This asks to be a *switch* statement.

>   	lcdc_write(reg, LCD_RASTER_CTRL_REG);
>
>   	switch (bpp) {
> @@ -549,6 +560,8 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
>   	case 2:
>   	case 4:
>   	case 16:
> +	case 24:
> +	case 32:
>   		par->palette_sz = 16 * 2;
>   		break;
>
> @@ -578,13 +591,36 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
>   	if (info->fix.visual = FB_VISUAL_DIRECTCOLOR)
>   		return 1;
>
> -	if (info->var.bits_per_pixel = 4) {
> -		if (regno > 15)
> -			return 1;
> +	if ((info->var.bits_per_pixel > 16) && (lcd_revision = LCD_VERSION_1))

    Parens around operands of && not necessary.

> +	switch (info->fix.visual) {
> +	case FB_VISUAL_TRUECOLOR:
> +		red = CNVT_TOHW(red, info->var.red.length);
> +		green = CNVT_TOHW(green, info->var.green.length);
> +		blue = CNVT_TOHW(blue, info->var.blue.length);
> +		break;
> +	case FB_VISUAL_PSEUDOCOLOR:
> +		if (info->var.bits_per_pixel = 4) {
> +			if (regno > 15)
> +				return -EINVAL;
> +
> +			if (info->var.grayscale) {
> +				pal = regno;
> +			} else {
> +				red >>= 4;
> +				green >>= 8;
> +				blue >>= 12;
> +
> +				pal = (red & 0x0f00);
> +				pal |= (green & 0x00f0);
> +				pal |= (blue & 0x000f);

    Parens not needed.

> +			}
> +			if (regno = 0)
> +				pal |= 0x2000;
> +			palette[regno] = pal;
> +
> +		} else if (info->var.bits_per_pixel = 8) {

    This asks to be a *switch* statement.

> @@ -842,6 +877,9 @@ static int fb_check_var(struct fb_var_screeninfo *var,
>   {
>   	int err = 0;
>
> +	if ((var->bits_per_pixel > 16) && (lcd_revision = LCD_VERSION_1))

    Parens around operands of && not necessary.

WBR, Sergei

