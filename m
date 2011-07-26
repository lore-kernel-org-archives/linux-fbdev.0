From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Tue, 26 Jul 2011 04:32:12 +0000
Subject: RE: [PATCH v3] video: da8xx-fb: Increased resolution configuration
Message-Id: <B85A65D85D7EB246BE421B3FB0FBB593024DD2CFCF@dbde02.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1310963333-29806-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1310963333-29806-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Paul,

Could you please accept this patch as there are no comments?

Thanks,
Prakash
On Mon, Jul 18, 2011 at 09:58:53, Manjunathappa, Prakash wrote:
> Revised LCD controller in upcoming TI SoC which is an updated version of
> LCDC IP that was found on TI's DA850 SoC supports 2048*2048 resolution.
> Below are the encoding details:
> Width:
> Pixels Per Line = {pplmsb, ppllsb, 4'b1111} + 1
> Where pplmsb:1bit=>Raster Timing0[3], ppllsb:6bits=>Raster Timing0[9:4].
> And encoded value can range from 16 to 2048 in multiples of 16.
> 
> Height:
> Lines Per Panel = {lpp_b10, lpp}
> Where lpp:10bits=>Raster Timing1[9:0], lpp_b10:1bit=>Raster Timing2[26].
> And encoded value can range from 1 to 2048, programmable range is 0 to
> 2047.
> 
> Patch is verified on emulation platform of upcoming SoC for updated
> feature and on DA850 platform to make sure nothing existing breaks.
> 
> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> ---
> Since v2:
> Corrected comment describing horizontal resolution bits and removed unnecessary
> outer parenthesis.
> Since v1:
> 1)Fixed the bug in configuration of lpp_b10 in Raster Timing2[26] register.
> 2)Reframed commit message.
> 
>  drivers/video/da8xx-fb.c |   31 ++++++++++++++++++++++++++++---
>  1 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index 620f1c3..94b611a 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -460,18 +460,43 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
>  
>  	/* Set the Panel Width */
>  	/* Pixels per line = (PPL + 1)*16 */
> -	/*0x3F in bits 4..9 gives max horisontal resolution = 1024 pixels*/
> -	width &= 0x3f0;
> +	if (lcd_revision = LCD_VERSION_1) {
> +		/*
> +		 * 0x3F in bits 4..9 gives max horizontal resolution = 1024
> +		 * pixels.
> +		 */
> +		width &= 0x3f0;
> +	} else {
> +		/*
> +		 * 0x7F in bits 4..10 gives max horizontal resolution = 2048
> +		 * pixels.
> +		 */
> +		width &= 0x7f0;
> +	}
> +
>  	reg = lcdc_read(LCD_RASTER_TIMING_0_REG);
>  	reg &= 0xfffffc00;
> -	reg |= ((width >> 4) - 1) << 4;
> +	if (lcd_revision = LCD_VERSION_1) {
> +		reg |= ((width >> 4) - 1) << 4;
> +	} else {
> +		width = (width >> 4) - 1;
> +		reg |= ((width & 0x3f) << 4) | ((width & 0x40) >> 3);
> +	}
>  	lcdc_write(reg, LCD_RASTER_TIMING_0_REG);
>  
>  	/* Set the Panel Height */
> +	/* Set bits 9:0 of Lines Per Pixel */
>  	reg = lcdc_read(LCD_RASTER_TIMING_1_REG);
>  	reg = ((height - 1) & 0x3ff) | (reg & 0xfffffc00);
>  	lcdc_write(reg, LCD_RASTER_TIMING_1_REG);
>  
> +	/* Set bit 10 of Lines Per Pixel */
> +	if (lcd_revision = LCD_VERSION_2) {
> +		reg = lcdc_read(LCD_RASTER_TIMING_2_REG);
> +		reg |= ((height - 1) & 0x400) << 16;
> +		lcdc_write(reg, LCD_RASTER_TIMING_2_REG);
> +	}
> +
>  	/* Set the Raster Order of the Frame Buffer */
>  	reg = lcdc_read(LCD_RASTER_CTRL_REG) & ~(1 << 8);
>  	if (raster_order)
> -- 
> 1.7.1
> 
> 

