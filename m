From: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Date: Fri, 25 Nov 2011 21:28:51 +0000
Subject: Re: [PATCH] video:da8xx-fb: Add 24bpp LCD configuration support
Message-Id: <4ED00893.2070809@gmx.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321358479-20390-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1321358479-20390-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On 11/25/2011 07:45 AM, Manjunathappa, Prakash wrote:
> Hi Florian Tobias Schandinat
> 
> On Sun, Nov 20, 2011 at 06:11:44, Florian Tobias Schandinat wrote:
>> On 11/15/2011 12:01 PM, Manjunathappa, Prakash wrote:
>>> LCD controller on am335x supports 24bpp raster configuration
>>> in addition to ones on da850. LCDC also supports 24bpp in unpacked
>>> format having ARGB:8888 32bpp format data in DDR, but it doesn't
>>> interpret Alpha component of the data.
>>>
>>> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
>>> ---
>>>  drivers/video/da8xx-fb.c |   57 +++++++++++++++++++++++++++++++++++++++++++++-
>>>  1 files changed, 56 insertions(+), 1 deletions(-)
>>>
>>> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
>>> index 55f91d9..e111971 100644
>>> --- a/drivers/video/da8xx-fb.c
>>> +++ b/drivers/video/da8xx-fb.c
>>> @@ -82,6 +82,8 @@
>>>  #define LCD_V2_LIDD_CLK_EN		BIT(1)
>>>  #define LCD_V2_CORE_CLK_EN		BIT(0)
>>>  #define LCD_V2_LPP_B10			26
>>> +#define LCD_V2_TFT_24BPP_MODE		BIT(25)
>>> +#define LCD_V2_TFT_24BPP_UNPACK		BIT(26)
>>>  
>>>  /* LCD Raster Timing 2 Register */
>>>  #define LCD_AC_BIAS_TRANSITIONS_PER_INT(x)	((x) << 16)
>>> @@ -151,7 +153,7 @@ struct da8xx_fb_par {
>>>  	unsigned int		dma_end;
>>>  	struct clk *lcdc_clk;
>>>  	int irq;
>>> -	unsigned short pseudo_palette[16];
>>> +	unsigned short pseudo_palette[32];
>>
>> This looks wrong, include/linux/fb.h says:
>> "void *pseudo_palette;           /* Fake palette of 16 colors */"
>> This will probably also simplify the code below to write to the pseudo palette.
>> But I think you have to increase the data type of the palette, maybe to u32?
>>
>>
> 
> Yes, I accept that data type has to be changed to u32. But how does it simplify updating of pseudo palette.

Your code is even buggier than I saw. Where did you get the information how to
write fb_setcolreg?
First, as I wrote in my last mail, the pseudo_palette has always exactly 16
colors, regardless of the color depth.
Second, the existing code is some sort of wrong to check for bpp the only thing
that really matters is whether it is Truecolor or not, the code for handling the
Truecolor case will very likely be always the same regardless of the bpp, just
the values in {red,green,blue}{length,offset} differ.
Third your patch is wrong in using 24 in things like
red >>= (24 - info->var.red.length);
skeletonfb.c: "The values supplied have a 16 bit magnitude which needs to be
scaled in this function for the hardware."
So it has to be 16, always.

Just have a look at drivers/video/skeletonfb.c, it contains much useful information.


Best regards,

Florian Tobias Schandinat

> 
> Thanks,
> Prakash
> 
>> Best regards,
>>
>> Florian Tobias Schandinat
>>
>>>  	unsigned int palette_sz;
>>>  	unsigned int pxl_clk;
>>>  	int blank;
>>> @@ -458,6 +460,9 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
>>>  {
>>>  	u32 reg;
>>>  
>>> +	if ((bpp > 16) && (lcd_revision = LCD_VERSION_1))
>>> +		return -EINVAL;
>>> +
>>>  	/* Set the Panel Width */
>>>  	/* Pixels per line = (PPL + 1)*16 */
>>>  	if (lcd_revision = LCD_VERSION_1) {
>>> @@ -501,6 +506,13 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
>>>  	reg = lcdc_read(LCD_RASTER_CTRL_REG) & ~(1 << 8);
>>>  	if (raster_order)
>>>  		reg |= LCD_RASTER_ORDER;
>>> +
>>> +	if (bpp = 24)
>>> +		reg |= (LCD_TFT_MODE | LCD_V2_TFT_24BPP_MODE);
>>> +	else if (bpp = 32)
>>> +		reg |= (LCD_TFT_MODE | LCD_V2_TFT_24BPP_MODE
>>> +				| LCD_V2_TFT_24BPP_UNPACK);
>>> +
>>>  	lcdc_write(reg, LCD_RASTER_CTRL_REG);
>>>  
>>>  	switch (bpp) {
>>> @@ -508,6 +520,8 @@ static int lcd_cfg_frame_buffer(struct da8xx_fb_par *par, u32 width, u32 height,
>>>  	case 2:
>>>  	case 4:
>>>  	case 16:
>>> +	case 24:
>>> +	case 32:
>>>  		par->palette_sz = 16 * 2;
>>>  		break;
>>>  
>>> @@ -537,6 +551,9 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
>>>  	if (info->fix.visual = FB_VISUAL_DIRECTCOLOR)
>>>  		return 1;
>>>  
>>> +	if ((info->var.bits_per_pixel > 16) && (lcd_revision = LCD_VERSION_1))
>>> +		return 1;
>>> +
>>>  	if (info->var.bits_per_pixel = 8) {
>>>  		red >>= 4;
>>>  		green >>= 8;
>>> @@ -566,6 +583,23 @@ static int fb_setcolreg(unsigned regno, unsigned red, unsigned green,
>>>  			update_hw = 1;
>>>  			palette[0] = 0x4000;
>>>  		}
>>> +	} else if (((info->var.bits_per_pixel = 32) && regno < 32) ||
>>> +		    ((info->var.bits_per_pixel = 24) && regno < 24)) {
>>> +		red >>= (24 - info->var.red.length);
>>> +		red <<= info->var.red.offset;
>>> +
>>> +		green >>= (24 - info->var.green.length);
>>> +		green <<= info->var.green.offset;
>>> +
>>> +		blue >>= (24 - info->var.blue.length);
>>> +		blue <<= info->var.blue.offset;
>>> +
>>> +		par->pseudo_palette[regno] = red | green | blue;
>>> +
>>> +		if (palette[0] != 0x4000) {
>>> +			update_hw = 1;
>>> +			palette[0] = 0x4000;
>>> +		}
>>>  	}
>>>  
>>>  	/* Update the palette in the h/w as needed. */
>>> @@ -777,6 +811,9 @@ static int fb_check_var(struct fb_var_screeninfo *var,
>>>  {
>>>  	int err = 0;
>>>  
>>> +	if ((var->bits_per_pixel > 16) && (lcd_revision = LCD_VERSION_1))
>>> +		return -EINVAL;
>>> +
>>>  	switch (var->bits_per_pixel) {
>>>  	case 1:
>>>  	case 8:
>>> @@ -809,6 +846,24 @@ static int fb_check_var(struct fb_var_screeninfo *var,
>>>  		var->transp.offset = 0;
>>>  		var->transp.length = 0;
>>>  		break;
>>> +	case 24:
>>> +		var->red.offset = 16;
>>> +		var->red.length = 8;
>>> +		var->green.offset = 8;
>>> +		var->green.length = 8;
>>> +		var->blue.offset = 0;
>>> +		var->blue.length = 8;
>>> +		break;
>>> +	case 32:
>>> +		var->transp.offset = 24;
>>> +		var->transp.length = 8;
>>> +		var->red.offset = 16;
>>> +		var->red.length = 8;
>>> +		var->green.offset = 8;
>>> +		var->green.length = 8;
>>> +		var->blue.offset = 0;
>>> +		var->blue.length = 8;
>>> +		break;
>>>  	default:
>>>  		err = -EINVAL;
>>>  	}
>>
>>
> 
> 

