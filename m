From: Johan Hovold <jhovold@gmail.com>
Date: Wed, 30 Jan 2013 13:26:37 +0000
Subject: Re: [PATCH 1/3] atmel_lcdfb: fix 16-bpp modes on older SOCs
Message-Id: <20130130132637.GA29440@localhost>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1355142530-10366-1-git-send-email-jhovold@gmail.com>
 <1355142530-10366-2-git-send-email-jhovold@gmail.com>
 <20130129135435.GN7360@game.jcrosoft.org>
In-Reply-To: <20130129135435.GN7360@game.jcrosoft.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Tue, Jan 29, 2013 at 02:54:35PM +0100, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 13:28 Mon 10 Dec     , Johan Hovold wrote:
> > Fix regression introduced by commit 787f9fd23283 ("atmel_lcdfb: support
> > 16bit BGR:565 mode, remove unsupported 15bit modes") which broke 16-bpp
> > modes for older SOCs which use IBGR:555 (msb is intensity) rather
> > than BGR:565.
> > 
> > Use SOC-type to determine the pixel layout.
> > 
> > Tested on custom at91sam9263-board.
> > 
> > Cc: <stable@vger.kernel.org>
> > Signed-off-by: Johan Hovold <jhovold@gmail.com>
> > ---
> >  drivers/video/atmel_lcdfb.c | 22 +++++++++++++++-------
> >  include/video/atmel_lcdc.h  |  1 +
> >  2 files changed, 16 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> > index 1505539..1f68fa6 100644
> > --- a/drivers/video/atmel_lcdfb.c
> > +++ b/drivers/video/atmel_lcdfb.c
> > @@ -422,17 +422,22 @@ static int atmel_lcdfb_check_var(struct fb_var_screeninfo *var,
> >  			= var->bits_per_pixel;
> >  		break;
> >  	case 16:
> > +		/* Older SOCs use IBGR:555 rather than BGR:565. */
> > +		if (sinfo->have_intensity_bit)
> > +			var->green.length = 5;
> > +		else
> > +			var->green.length = 6;
> > +
> >  		if (sinfo->lcd_wiring_mode = ATMEL_LCDC_WIRING_RGB) {
> > -			/* RGB:565 mode */
> > -			var->red.offset = 11;
> > +			/* RGB:5X5 mode */
> > +			var->red.offset = var->green.length + 5;
> >  			var->blue.offset = 0;
> >  		} else {
> > -			/* BGR:565 mode */
> > +			/* BGR:5X5 mode */
> >  			var->red.offset = 0;
> > -			var->blue.offset = 11;
> > +			var->blue.offset = var->green.length + 5;
> >  		}
> >  		var->green.offset = 5;
> > -		var->green.length = 6;
> >  		var->red.length = var->blue.length = 5;
> >  		break;
> >  	case 32:
> > @@ -679,8 +684,7 @@ static int atmel_lcdfb_setcolreg(unsigned int regno, unsigned int red,
> >  
> >  	case FB_VISUAL_PSEUDOCOLOR:
> >  		if (regno < 256) {
> > -			if (cpu_is_at91sam9261() || cpu_is_at91sam9263()
> > -			    || cpu_is_at91sam9rl()) {
> > +			if (sinfo->have_intensity_bit) {
> >  				/* old style I+BGR:555 */
> >  				val  = ((red   >> 11) & 0x001f);
> >  				val |= ((green >>  6) & 0x03e0);
> > @@ -870,6 +874,10 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
> >  	}
> >  	sinfo->info = info;
> >  	sinfo->pdev = pdev;
> > +	if (cpu_is_at91sam9261() || cpu_is_at91sam9263() ||
> > +							cpu_is_at91sam9rl()) {
> > +		sinfo->have_intensity_bit = true;
> > +	}
> nack
> 
> you need to drop the cpu_is as this can only be use now for the core
> 
> use platform_device_id to indetify the IP as done on at91-i2c as we can not
> detect the IP version

If this was a new feature and not a regression, fix I'd fully agree. There
are however currently four places in atmel_lcdfb where cpu_is macros are
used, and my patch only refactors one of them.

I can submit a follow up patch which add platform_device_id support, but
such a patch will be quite invasive and thus not 3.8-rc or stable material.

How about accepting this patch as it is, considering that it fixes an
obvious regression and also facilitate the move to platform_device_id by
introducing the intensity-bit flag?

Thanks,
Johan
