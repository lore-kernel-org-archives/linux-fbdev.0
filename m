From: Sascha Hauer <s.hauer@pengutronix.de>
Date: Fri, 06 Dec 2013 09:30:17 +0000
Subject: Re: [PATCHv13][ 2/4] video: imxfb: Also add pwmr for the device tree.
Message-Id: <20131206093017.GB24559@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1386258219-26437-1-git-send-email-denis@eukrea.com>
 <1386317034.190941796@f354.i.mail.ru>
 <20131206081640.GZ24559@pengutronix.de>
 <1386318910.581671226@f322.i.mail.ru>
In-Reply-To: <1386318910.581671226@f322.i.mail.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Fri, Dec 06, 2013 at 12:35:10PM +0400, Alexander Shiyan wrote:
> > On Fri, Dec 06, 2013 at 12:03:54PM +0400, Alexander Shiyan wrote:
> ...
> > > > >  - fsl,dmacr: DMA Control Register value. This is optional. By default, the
> > > > >  	register is not modified as recommended by the datasheet.
> > > > > +- fsl,pwmr:  LCDC PWM Contrast Control Register value. That property is
> > > > > +	optional, but defining it is necessary to get the backlight working. If that
> > > > > +	property is ommited, the register is zeroed.
> > > > 
> > > > Why isn't this implemented as a backlight driver? Static devicetree
> > > > provided values is very limiting.
> > > 
> > > Let's understand the terminology.
> > > This register should be renamed according to the datasheet, i.e. LPCCR.
> > > As I pointed out earlier, it is NOT control the backlight, this is a contrast control.
> > > Yes, it works as PWM, but nothing do with the backlight subsystem.
> > > Yes, we can make a driver for this PWM, but how are we going to control it?
> > > I misunderstood something?
> > 
> > I stumbled upon 'get the backlight working' which implied for me that it
> > should be a backlight driver. But you're right and now I remember we
> > talked about this already.
> 
> Hallelujah.
> 
> > I still think this should be something adjustable, not static data.
> > Maybe we could change the wording to something like "This property
> > provides the default value for the contrast control register" since even
> > if we add driver support for controlling the contrast we still want
> > to have a sane default.
> 
> Sounds good.
> 
> > BTW the contrast could be controlled with a lcd_device (see
> > lcd_device_register) which seems to be very easy to implement.
> 
> Address of register is placed within LCD area, so we cannot use this
> memory region, I think is no so easy as you say....

We do not need a separate driver for this. Look for example at
drivers/video/bf537-lq035.c, it just calls lcd_device_register()
in its probe function.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
