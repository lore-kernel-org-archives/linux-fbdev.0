From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
Date: Tue, 05 Jul 2016 12:08:38 +0000
Subject: Re: [PATCH 2/3] video: fbdev: imxfb: enable lcd regulator in .probe
Message-Id: <20160705140838.52014e4b@ipc1.ka-ro>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457380425-20244-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <56E2AA80.4050908@ti.com> <20160420191727.GS29108@pengutronix.de>
 <20160705100902.GM16643@pengutronix.de>
In-Reply-To: <20160705100902.GM16643@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-arm-kernel@lists.infradead.org

Hi,

On Tue, 5 Jul 2016 12:09:02 +0200 Uwe Kleine-König wrote:
> Hello Tomi, hello Jean-Christophe,
> 
> On Wed, Apr 20, 2016 at 09:17:27PM +0200, Uwe Kleine-König wrote:
> > On Fri, Mar 11, 2016 at 01:22:40PM +0200, Tomi Valkeinen wrote:
> > > 
> > > On 07/03/16 21:53, Uwe Kleine-König wrote:
> > > > This asserts that the display is on after the driver is initialized.
> > > > Otherwise, depending on how the boot loader handled the display, it is
> > > > either disabled as the regulator doesn't seem in use, or it stays off.
> > > > 
> > > > Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> > > > ---
> > > >  drivers/video/fbdev/imxfb.c | 9 +++++++++
> > > >  1 file changed, 9 insertions(+)
> > > > 
> > > > diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> > > > index c5fcedde2a60..3dd2824e6773 100644
> > > > --- a/drivers/video/fbdev/imxfb.c
> > > > +++ b/drivers/video/fbdev/imxfb.c
> > > > @@ -979,8 +979,17 @@ static int imxfb_probe(struct platform_device *pdev)
> > > >  	imxfb_enable_controller(fbi);
> > > >  	fbi->pdev = pdev;
> > > >  
> > > > +	if (!IS_ERR(fbi->lcd_pwr)) {
> > > > +		ret = regulator_enable(fbi->lcd_pwr);
> > > > +		if (ret)
> > > > +			goto failed_regulator;
> > > > +	}
> > > > +
> > > >  	return 0;
> > > >  
> > > > +failed_regulator:
> > > > +	imxfb_disable_controller(fbi);
> > > > +
> > > >  failed_lcd:
> > > >  	unregister_framebuffer(info);
> > > 
> > > So I didn't go through the code in detail, but this doesn't look correct
> > > to me.
> > > 
> > > Where is the regulator disabled which now gets enabled in probe?
> > 
> > It isn't, the display should be on after all :-)
> > 
> > > imxfb_lcd_set_power() handles the regulator enable/disable, so doesn't
> > > this mean the regulator would always be enabled? You first enable it in
> > > probe, then imxfb_lcd_set_power() enables it at some point (?), so the
> > > enable-count is two then.
> > 
> > imxfb_lcd_set_power isn't called during boot.
> > 
> > > To be honest, I've never used 'struct lcd_ops', but I think the enabling
> > > of the regulator should happen somehow via that. If the regulator needs
> > > to be enabled at probe time, then the probe should somehow cause
> > > lcd_ops->set_power to get called.
> > > 
> > > Why does the regulator need to be enabled at probe? Or are you saying
> > > imxfb_lcd_set_power() is never called in your case?
> > 
> > Right. I just confirmed that with next-20160419 with this patch on top:
> 
> And now I also checked the code. The driver's lcd_ops is only used in
> 
> 	lcd = devm_lcd_device_register(&pdev->dev, "imxfb-lcd", &pdev->dev, fbi, &imxfb_lcd_ops);
> 
> (i.e. the last argument). The only thing that happes with the lcd_ops is
> that it is assigned to a newly allocated struct lcd_device's .ops. There
> imxfb_lcd_set_power is only used for some sysfs attributes (for the lcd)
> and the function fb_blank which is in turn not called automatically,
> only by some sysfs attributes and ioctls.
> 
> So as of now regulator_init_complete disables the (unused) power
> regulator before userspace is up.
> 
> To reach my goal to keep the display on (showing whatever the bootloader
> initialized the display with) until the application starts caring for
> the display some driver must enable the regulator. The only candidates
> are the lcd driver (i.e. the patch under discussion) or some mechanism
> in the fb core. As there doesn't seem to be code in the core (and the
> core is dead?) what do you suggest me to do?
> 
The simplefb driver (CONFIG_FB_SIMPLE) is designed for exactly this
purpose. If you rely on the bootloader's framebuffer being preserved
until your application starts without any driver that reserves the
corresponding memory, the framebuffer contents may be corrupted by the
booting kernel.


Lothar Waßmann
