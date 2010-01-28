From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
Date: Thu, 28 Jan 2010 07:41:01 +0000
Subject: Re: [PATCH] imxfb: correct location of callbacks in suspend and
Message-Id: <20100128074101.GA13756@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1263226881-28008-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1264433854-878-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<20100127154818.de91e255.akpm@linux-foundation.org>
In-Reply-To: <20100127154818.de91e255.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello,

On Wed, Jan 27, 2010 at 03:48:18PM -0800, Andrew Morton wrote:
> On Mon, 25 Jan 2010 16:37:34 +0100
> Uwe Kleine-K__nig  <u.kleine-koenig@pengutronix.de> wrote:
>=20
> > The probe function passes a pointer to a struct fb_info to
> > platform_set_drvdata, so don't interpret the return value of
> > platform_get_drvdata as a pointer to struct imxfb_info.
> >=20
> > Signed-off-by: Uwe Kleine-K__nig <u.kleine-koenig@pengutronix.de>
> > Acked-by: Sascha Hauer <kernel@pengutronix.de>
> > Cc: linux-arm-kernel@lists.infradead.org
> > ---
> >  drivers/video/imxfb.c |    6 ++++--
> >  1 files changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
> > index 66358fa..b4b6dec 100644
> > --- a/drivers/video/imxfb.c
> > +++ b/drivers/video/imxfb.c
> > @@ -593,7 +593,8 @@ static int imxfb_activate_var(struct fb_var_screeni=
nfo *var, struct fb_info *inf
> >   */
> >  static int imxfb_suspend(struct platform_device *dev, pm_message_t sta=
te)
> >  {
> > -	struct imxfb_info *fbi =3D platform_get_drvdata(dev);
> > +	struct fb_info *info =3D platform_get_drvdata(dev);
> > +	struct imxfb_info *fbi =3D info->par;
> > =20
> >  	pr_debug("%s\n", __func__);
> > =20
> > @@ -603,7 +604,8 @@ static int imxfb_suspend(struct platform_device *de=
v, pm_message_t state)
> > =20
> >  static int imxfb_resume(struct platform_device *dev)
> >  {
> > -	struct imxfb_info *fbi =3D platform_get_drvdata(dev);
> > +	struct fb_info *info =3D platform_get_drvdata(dev);
> > +	struct imxfb_info *fbi =3D info->par;
> > =20
> >  	pr_debug("%s\n", __func__);
> > =20
>=20
> What were the runtime effects of this bug?
For me it was that in the original imxfb_info *fbi backlight_power was
NULL but in imxfb_suspend it was 4 resulting in an oops as imxfb_suspend
calls imxfb_disable_controller(fbi) which in turn has

	if (fbi->backlight_power)
		fbi->backlight_power(0);

.

Best regards
Uwe

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig         =
   |
Industrial Linux Solutions                    | http://www.pengutronix.de/ =
 |
