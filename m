From: Lee Jones <lee.jones@linaro.org>
Date: Wed, 01 Jul 2015 08:06:12 +0000
Subject: Re: [PATCH v2] backlight: lp8788: Deletion of a check before backlight_device_unregister()
Message-Id: <20150701080612.GG3210@x1>
List-Id: <linux-fbdev.vger.kernel.org>
References: <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <54720DEB.4060109@users.sourceforge.net>
 <20141124101006.GD4241@x1>
 <5473736F.8070705@users.sourceforge.net>
 <558FE386.7060704@users.sourceforge.net>
In-Reply-To: <558FE386.7060704@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: Bryan Wu <cooloney@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Jingoo Han <jg1.han@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>

On Sun, 28 Jun 2015, SF Markus Elfring wrote:

> > From: Markus Elfring <elfring@users.sourceforge.net>
> >=20
> > The backlight_device_unregister() function tests whether its argument i=
s NULL
> > and then returns immediately. Thus the test around the call is not need=
ed.
> >=20
> > This issue was detected by using the Coccinelle software.
> >=20
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> >  drivers/video/backlight/lp8788_bl.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/video/backlight/lp8788_bl.c b/drivers/video/backli=
ght/lp8788_bl.c
> > index d6c4f6a..24a055c 100644
> > --- a/drivers/video/backlight/lp8788_bl.c
> > +++ b/drivers/video/backlight/lp8788_bl.c
> > @@ -221,8 +221,7 @@ static void lp8788_backlight_unregister(struct lp87=
88_bl *bl)
> >  {
> >  	struct backlight_device *bl_dev =3D bl->bl_dev;
> > =20
> > -	if (bl_dev)
> > -		backlight_device_unregister(bl_dev);
> > +	backlight_device_unregister(bl_dev);
> >  }
> > =20
> >  static ssize_t lp8788_get_bl_ctl_mode(struct device *dev,
> >=20
>=20
> Would you like to integrate this update suggestion
> into another source code repository?

If this patch has not received any attention in some time, it's
possible that it may have slipped through the gaps.  Please
re-submit the set.

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
