From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Fri, 26 Feb 2016 12:10:08 +0000
Subject: Re: [PATCH v2 3/3] fbdev: omap2: panel-dpi: implement support for a vcc regulator
Message-Id: <20160226121008.GV15189@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1450610002-10531-4-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1450610002-10531-4-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Hello,

Cc +=3D Liam Girdwood, Mark Brown

On Fri, Feb 26, 2016 at 12:13:07PM +0200, Tomi Valkeinen wrote:
> On 16/02/16 15:48, Uwe Kleine-K=F6nig wrote:
> > Hello Tomi,
> >=20
> > On Tue, Feb 16, 2016 at 03:00:00PM +0200, Tomi Valkeinen wrote:
> >> On 20/12/15 13:13, Uwe Kleine-K=F6nig wrote:
> >>> @@ -223,6 +232,10 @@ static int panel_dpi_probe_of(struct platform_de=
vice *pdev)
> >>>  	if (IS_ERR(gpio))
> >>>  		return PTR_ERR(gpio);
> >>> =20
> >>> +	ddata->vcc_supply =3D devm_regulator_get(&pdev->dev, "vcc");
> >>> +	if (IS_ERR(ddata->vcc_supply))
> >>> +		return PTR_ERR(ddata->vcc_supply);
> >>
> >> devm_regulator_get_optional()?
> >=20
> > That would make the specification of a vcc supply obligatory IIUC. (Yes,
> > the semantic difference between regulator_get vs. regulator_get_optional
> > is reversed when comparing to gpio_get vs. gpio_get_optional.)
>=20
> This is a bit confusing...
>=20
> So, is regulator_get_optional() meant for cases where the device can
> truly function without the supply in question? And regulator_get()
> should be used when the device needs the supply, even if the supply
> cannot be controlled via SW, and thus we may not even have the supply
> visible in the SW side (leading to using dummy regulator)?

Yeah, I think this is the right picture.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
