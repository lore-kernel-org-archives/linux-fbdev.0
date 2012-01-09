From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 09 Jan 2012 12:13:22 +0000
Subject: Re: [PATCH] atmel_lcdfb: support 16bit BGR:565 mode, remove
Message-Id: <20120109121322.GM21765@n2100.arm.linux.org.uk>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1318517570-28459-1-git-send-email-jacmet@sunsite.dk>
 <4F0AC2B1.8010601@atmel.com>
In-Reply-To: <4F0AC2B1.8010601@atmel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, Jan 09, 2012 at 11:34:25AM +0100, Nicolas Ferre wrote:
> On 10/13/2011 04:52 PM, Peter Korsgaard :
> > Allow framebuffer to be configured in 16bit mode when panel is wired in
> > (the default) BGR configuration, and don't claim to support 15bit input
> > modes, which the LCD controller cannot handle.
> > 
> > Signed-off-by: Peter Korsgaard <jacmet@sunsite.dk>
> 
> Hi Peter,
> 
> Sorry for not having more responsive concerning the two patches that you
> posted about atmel_lcdfb driver.
> 
> 
> I have a question though about this one...
> 
> 
> > ---
> >  drivers/video/atmel_lcdfb.c |   12 +++---------
> >  1 files changed, 3 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> > index 7ca3eaf..143f6d9 100644
> > --- a/drivers/video/atmel_lcdfb.c
> > +++ b/drivers/video/atmel_lcdfb.c
> > @@ -418,24 +418,18 @@ static int atmel_lcdfb_check_var(struct fb_var_screeninfo *var,
> >  		var->red.length = var->green.length = var->blue.length
> >  			= var->bits_per_pixel;
> >  		break;
> > -	case 15:
> >  	case 16:
> >  		if (sinfo->lcd_wiring_mode = ATMEL_LCDC_WIRING_RGB) {
> >  			/* RGB:565 mode */
> >  			var->red.offset = 11;
> >  			var->blue.offset = 0;
> > -			var->green.length = 6;
> > -		} else if (sinfo->lcd_wiring_mode = ATMEL_LCDC_WIRING_RGB555) {
> > -			var->red.offset = 10;
> > -			var->blue.offset = 0;
> > -			var->green.length = 5;
> 
> Maybe I have missed something but I do not know why you are removing
> this part of the configuration? A board at least is using this wiring
> mode...

Oh, this old gem.

var->bits_per_pixel represents the number of bits in the framebuffer per
pixel, and '15' for this means that your frame buffer is organized as:

 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
----+-----------------------------+-----------------------------+
  A |           B                 |            C                |
----+-----------------------------+-----------------------------+

whereas what you actually have is:

 3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
+-------------------------------+-------------------------------+
|            B                  |              C                |
+-------------------------------+-------------------------------+

and one bit in each pixel remains unused.

This is because bytes_per_line = xres * 8 / bits_per_pixel.

You describe the RGB555 vs RGB565 via the bitfield values in var->red,
var->green and var->blue.  So, RGB(or BGR)565 has var->green.length
with 6, and RGB(or BGR)555 has this as 5.  In both cases, bits_per_pixel
is 16 as that's the width of a pixel in the frame buffer.

If the bitfield can't be interpreted by the driver as identifying one
of these combinations, then you're supposed to chose one (and in the
case where it's fixed by hardware, you set the bitfields according to
what the hardware supports.)
