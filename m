From: "Manjunathappa, Prakash" <prakash.pm@ti.com>
Date: Tue, 13 Dec 2011 14:45:33 +0000
Subject: RE: [PATCH] video:da8xx-fb: Add 24bpp LCD configuration support
Message-Id: <A73F36158E33644199EB82C5EC81C7BC022B95@DBDE01.ent.ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1321358479-20390-1-git-send-email-prakash.pm@ti.com>
In-Reply-To: <1321358479-20390-1-git-send-email-prakash.pm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hi Florian Tobias Schandinat,

On Sat, Nov 26, 2011 at 02:58:51, Florian Tobias Schandinat wrote:
> On 11/25/2011 07:45 AM, Manjunathappa, Prakash wrote:
> > Hi Florian Tobias Schandinat
> > 
> > On Sun, Nov 20, 2011 at 06:11:44, Florian Tobias Schandinat wrote:
> >> On 11/15/2011 12:01 PM, Manjunathappa, Prakash wrote:
> >>> LCD controller on am335x supports 24bpp raster configuration
> >>> in addition to ones on da850. LCDC also supports 24bpp in unpacked
> >>> format having ARGB:8888 32bpp format data in DDR, but it doesn't
> >>> interpret Alpha component of the data.
> >>>
> >>> Signed-off-by: Manjunathappa, Prakash <prakash.pm@ti.com>
> >>> ---
> >>>  drivers/video/da8xx-fb.c |   57 +++++++++++++++++++++++++++++++++++++++++++++-
> >>>  1 files changed, 56 insertions(+), 1 deletions(-)
> >>>
> >>> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> >>> index 55f91d9..e111971 100644
> >>> --- a/drivers/video/da8xx-fb.c
> >>> +++ b/drivers/video/da8xx-fb.c
> >>> @@ -82,6 +82,8 @@
> >>>  #define LCD_V2_LIDD_CLK_EN		BIT(1)
> >>>  #define LCD_V2_CORE_CLK_EN		BIT(0)
> >>>  #define LCD_V2_LPP_B10			26
> >>> +#define LCD_V2_TFT_24BPP_MODE		BIT(25)
> >>> +#define LCD_V2_TFT_24BPP_UNPACK		BIT(26)
> >>>  
> >>>  /* LCD Raster Timing 2 Register */
> >>>  #define LCD_AC_BIAS_TRANSITIONS_PER_INT(x)	((x) << 16)
> >>> @@ -151,7 +153,7 @@ struct da8xx_fb_par {
> >>>  	unsigned int		dma_end;
> >>>  	struct clk *lcdc_clk;
> >>>  	int irq;
> >>> -	unsigned short pseudo_palette[16];
> >>> +	unsigned short pseudo_palette[32];
> >>
> >> This looks wrong, include/linux/fb.h says:
> >> "void *pseudo_palette;           /* Fake palette of 16 colors */"
> >> This will probably also simplify the code below to write to the pseudo palette.
> >> But I think you have to increase the data type of the palette, maybe to u32?
> >>
> >>
> > 
> > Yes, I accept that data type has to be changed to u32. But how does it simplify updating of pseudo palette.
> 
> Your code is even buggier than I saw. Where did you get the information how to
> write fb_setcolreg?
> First, as I wrote in my last mail, the pseudo_palette has always exactly 16
> colors, regardless of the color depth.
> Second, the existing code is some sort of wrong to check for bpp the only thing
> that really matters is whether it is Truecolor or not, the code for handling the
> Truecolor case will very likely be always the same regardless of the bpp, just
> the values in {red,green,blue}{length,offset} differ.
> Third your patch is wrong in using 24 in things like
> red >>= (24 - info->var.red.length);
> skeletonfb.c: "The values supplied have a 16 bit magnitude which needs to be
> scaled in this function for the hardware."
> So it has to be 16, always.
> 
> Just have a look at drivers/video/skeletonfb.c, it contains much useful information.
> 
> 
> Best regards,
> 
> Florian Tobias Schandinat
> 

Thanks for pointing out to skeletonfb.c. I will submit next version based on this.

Thanks,
Prakash

[...] 

