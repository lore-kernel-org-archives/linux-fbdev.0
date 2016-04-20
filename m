From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Wed, 20 Apr 2016 19:17:27 +0000
Subject: Re: [PATCH 2/3] video: fbdev: imxfb: enable lcd regulator in .probe
Message-Id: <20160420191727.GS29108@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1457380425-20244-3-git-send-email-u.kleine-koenig@pengutronix.de>
 <56E2AA80.4050908@ti.com>
In-Reply-To: <56E2AA80.4050908@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello Tomi,

On Fri, Mar 11, 2016 at 01:22:40PM +0200, Tomi Valkeinen wrote:
>=20
> On 07/03/16 21:53, Uwe Kleine-K=F6nig wrote:
> > This asserts that the display is on after the driver is initialized.
> > Otherwise, depending on how the boot loader handled the display, it is
> > either disabled as the regulator doesn't seem in use, or it stays off.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/video/fbdev/imxfb.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> >=20
> > diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
> > index c5fcedde2a60..3dd2824e6773 100644
> > --- a/drivers/video/fbdev/imxfb.c
> > +++ b/drivers/video/fbdev/imxfb.c
> > @@ -979,8 +979,17 @@ static int imxfb_probe(struct platform_device *pde=
v)
> >  	imxfb_enable_controller(fbi);
> >  	fbi->pdev =3D pdev;
> > =20
> > +	if (!IS_ERR(fbi->lcd_pwr)) {
> > +		ret =3D regulator_enable(fbi->lcd_pwr);
> > +		if (ret)
> > +			goto failed_regulator;
> > +	}
> > +
> >  	return 0;
> > =20
> > +failed_regulator:
> > +	imxfb_disable_controller(fbi);
> > +
> >  failed_lcd:
> >  	unregister_framebuffer(info);
>=20
> So I didn't go through the code in detail, but this doesn't look correct
> to me.
>=20
> Where is the regulator disabled which now gets enabled in probe?

It isn't, the display should be on after all :-)

> imxfb_lcd_set_power() handles the regulator enable/disable, so doesn't
> this mean the regulator would always be enabled? You first enable it in
> probe, then imxfb_lcd_set_power() enables it at some point (?), so the
> enable-count is two then.

imxfb_lcd_set_power isn't called during boot.

> To be honest, I've never used 'struct lcd_ops', but I think the enabling
> of the regulator should happen somehow via that. If the regulator needs
> to be enabled at probe time, then the probe should somehow cause
> lcd_ops->set_power to get called.
>=20
> Why does the regulator need to be enabled at probe? Or are you saying
> imxfb_lcd_set_power() is never called in your case?

Right. I just confirmed that with next-20160419 with this patch on top:

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 76b6a7784b06..93b803ebd61d 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -1,3 +1,4 @@
+#define DEBUG
 /*
  *  Freescale i.MX Frame Buffer device driver
  *
@@ -768,6 +769,7 @@ static int imxfb_lcd_set_power(struct lcd_device *lcdde=
v, int power)
 {
 	struct imxfb_info *fbi =3D dev_get_drvdata(&lcddev->dev);
=20
+	dev_dbg(&lcddev->dev, "%s(power=3D%d)\n", __func__, power);
 	if (!IS_ERR(fbi->lcd_pwr)) {
 		if (power)
 			return regulator_enable(fbi->lcd_pwr);

With that:

# dmesg | grep -iE '(lcd|fb|power)'
[    0.562633] backlight supply power not found, using dummy regulator
[    0.568246] imx-fb 53fbc000.lcdc: i.MX Framebuffer driver
[    0.568326] imxfb_init_fbinfo
[    0.576275] Enabling LCD controller
[    1.652166] sdhci-esdhc-imx 53fb4000.esdhc: Got CD GPIO
[    1.658109] sdhci-esdhc-imx 53fb4000.esdhc: Got WP GPIO
[    1.703638] mmc0: SDHCI controller on 53fb4000.esdhc [53fb4000.esdhc] us=
ing DMA
[    4.094923] lcd supply: disabling

The bootloader enables the lcd before booting into Linux, with the last
message the display gets disabled.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
