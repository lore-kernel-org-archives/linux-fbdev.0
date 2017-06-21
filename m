From: Bhushan Shah <bshah@kde.org>
Date: Wed, 21 Jun 2017 11:04:30 +0000
Subject: Re: [PATCH v2] backlight: lm3630a: bump REG_MAX value to 0x50 instead of 0x1F
Message-Id: <20170621105230.GA13390@archbox>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="YZ5djTAD1cGYuMQK"
List-Id: <linux-fbdev.vger.kernel.org>
In-Reply-To: <1eda1c22-5a40-74f0-3a79-41e827828a32@linaro.org>
References: <20170621053152.3008-1-bshah@kde.org>
In-Reply-To: <20170621053152.3008-1-bshah@kde.org>
To: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Lee Jones <lee.jones@linaro.org>, Jingoo Han <jingoohan1@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bhushan Shah <bshah@kde.org>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--YZ5djTAD1cGYuMQK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 21, 2017 at 10:37:43AM +0100, Daniel Thompson wrote:
> On 21/06/17 06:31, Bhushan Shah wrote:
> > In the lm3630a_chip_init we try to write to 0x50 register, which is
> > higher value then the max_register value, this resulted in regmap_write
> > return -EIO.
> >=20
> > Fix this by bumping REG_MAX value to 0x50. >
> > Signed-off-by: Bhushan Shah <bshah@kde.org>
> > Suggested-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>=20
> Can we get a "Fixes" on this? It looks to me like it has been broken since
> 2a0c316bf3cc ("fix signedness bug in lm3630a_chip_init()").

I don't think 2a0c316bf3cc is the right commit to mention in Fixes tag?
Because it was broken since the introduction of chip revision in commit
28e64a68a2ef ("backlight: lm3630: apply chip revision").

commit 2a0c316bf3cc just made it error out correctly instead of failing
silently.

What do you think?

>=20
> Also I assume you find this by trying to use the driver on real hardware?=
 If
> so can you confirm what you tested on in the patch description. As far as=
 I
> can tell the code to set the filter strength has never worked, so you'll =
be
> the first user of it!

Yes I hit this problem by trying it on LGE Nexus 5 (hammerhead). I will
mention this in the v3 revision of patch.

>=20
> > ---
> >=20
> > Changes since v1:
> >      - Fix the lm3630a_write call to use proper value (sent worng patch=
 earlier)
> >=20
> >   drivers/video/backlight/lm3630a_bl.c | 5 +++--
> >   1 file changed, 3 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/video/backlight/lm3630a_bl.c b/drivers/video/backl=
ight/lm3630a_bl.c
> > index 60d6c2ac87aa..b641f706dbc9 100644
> > --- a/drivers/video/backlight/lm3630a_bl.c
> > +++ b/drivers/video/backlight/lm3630a_bl.c
> > @@ -31,7 +31,8 @@
> >   #define REG_FAULT	0x0B
> >   #define REG_PWM_OUTLOW	0x12
> >   #define REG_PWM_OUTHIGH	0x13
> > -#define REG_MAX		0x1F
> > +#define REG_FLTR_STR	0x50
>=20
> Can we expand this to REG_FILTER_STRENGTH?

Sure, will include in Patch v3.

>=20
> Daniel.
>=20
> > +#define REG_MAX		0x50
> >   #define INT_DEBOUNCE_MSEC	10
> >   struct lm3630a_chip {
> > @@ -80,7 +81,7 @@ static int lm3630a_chip_init(struct lm3630a_chip *pch=
ip)
> >   	usleep_range(1000, 2000);
> >   	/* set Filter Strength Register */
> > -	rval =3D lm3630a_write(pchip, 0x50, 0x03);
> > +	rval =3D lm3630a_write(pchip, REG_FLTR_STR, 0x03);
> >   	/* set Cofig. register */
> >   	rval |=3D lm3630a_update(pchip, REG_CONFIG, 0x07, pdata->pwm_ctrl);
> >   	/* set boost control */
> >=20
>=20

--=20
Bhushan Shah
http://blog.bshah.in
IRC Nick : bshah on Freenode
GPG key fingerprint : 0AAC 775B B643 7A8D 9AF7 A3AC FE07 8411 7FBC E11D

--YZ5djTAD1cGYuMQK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEECqx3W7ZDeo2a96Os/geEEX+84R0FAllKT+gACgkQ/geEEX+8
4R3HIwf/ZEgwrDlypLMAv0ylreK8HR8HfertSxh8MbsIuD40tZB7VUDCC9ZB/hLl
KhSCwX0B0ibccgWtPWC5QkjtUTV1a2sZn2CjFHzVBQZ0jqlHYTH2eRWShPVLn7ct
Qsqxs48+pf2x+dS8jmUCCspWYQU0ToozqDDc6P5+TQSGe6Dz7gfT6QCgvy0OtVZP
v/DyVN7lOQO959rZ6JgHKpT05URyVQVZqN9vK8aCAriARQxLXZDYatru6p/TIYDT
GgY9aEuCZQQzdrWJQkIpvOiYUKxF5+qeDeXeYs2b9leYDDFH11kRm59SN/gYwwfx
VbKyKdzxXX8k87TUE3693RcfgffPYQ==
=Mobd
-----END PGP SIGNATURE-----

--YZ5djTAD1cGYuMQK--
