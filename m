From: Juergen Beisert <jbe@pengutronix.de>
Date: Thu, 29 Nov 2012 13:50:00 +0000
Subject: Re: [BUGFIX PATCH] video: mxsfb: fix crash when unblanking the display
Message-Id: <201211291450.00886.jbe@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1353588555-13168-1-git-send-email-LW@KARO-electronics.de>
 <20663.19785.221750.909491@ipc1.ka-ro>
In-Reply-To: <20663.19785.221750.909491@ipc1.ka-ro>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Hi Lothar,

Lothar Waßmann wrote:
> > The VDCTRL4 register does not provide the MXS SET/CLR/TOGGLE feature.
> > The write in mxsfb_disable_controller() sets the data_cnt for the LCD
> > DMA to 0 which obviously means the max. count for the LCD DMA and
> > leads to overwriting arbitrary memory when the display is unblanked.

Overwriting? It should be a reading DMA unit, shouldn't it?

> > Note: I already sent this patch in December 2011 but noone picked it up
> > obviously.
> >
> > Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
> > ---
> >  drivers/video/mxsfb.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> > index 49619b4..f2a49ef 100644
> > --- a/drivers/video/mxsfb.c
> > +++ b/drivers/video/mxsfb.c
> > @@ -369,7 +369,8 @@ static void mxsfb_disable_controller(struct fb_info
> > *fb_info) loop--;
> >  	}
> >
> > -	writel(VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4 + REG_CLR);
> > +	reg = readl(host->base + LCDC_VDCTRL4);
> > +	writel(reg & ~VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4);
> >
> >  	clk_disable_unprepare(host->clk);
> >
> > --
> > 1.7.2.5
>
> ping? 

I'm not sure if the missing SET/CLR feature for this register is a typo in the 
i.MX23/i.MX28 data sheets or if it is intended. Lets assume its the truth 
what they have written:

Acked-by: Juergen Beisert <jbe@pengutronix.de>

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
