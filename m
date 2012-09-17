From: Thierry Reding <thierry.reding@avionic-design.de>
Date: Mon, 17 Sep 2012 06:16:29 +0000
Subject: Re: [PATCH] pwm-backlight: Use devm_pwm_get in pwm_bl.c
Message-Id: <20120917061629.GA1005@avionic-0098.mockup.avionic-design.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1347352949-17515-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1347352949-17515-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 17, 2012 at 11:43:11AM +0530, Sachin Kamat wrote:
> Hi Thierry,
>=20
> On 17 September 2012 11:34, Thierry Reding
> <thierry.reding@avionic-design.de> wrote:
> > On Wed, Sep 12, 2012 at 09:55:48AM +0900, Jingoo Han wrote:
> >> On Tuesday, September 11, 2012 5:42 PM Sachin Kamat wrote
> >> >
> >> > This file already makes use of device managed functions.
> >> > Convert pwm_get() too to use it.
> >> >
> >> > Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> >>
> >> CC'ed Thierry Reding.
> >>
> >> Acked-by: Jingoo Han <jg1.han@samsung.com>
> >
> > Hi Sachin,
> >
> > As discussed elsewhere I'm taking over maintenance of the pwm-backlight
> > driver as part of the PWM subsystem.
>=20
> That is really nice :)
>=20
>  I hadn't been Cc'ed on your first
> > send and I'm not subscribed to linux-fbdev so I didn't receive a copy of
> > the patch.
>=20
> Yes. I obtained the list from get_maintainers.pl, so missed out CCing you.
> I will re-send the patch with you in CC now.

Yes, I've contacted Richard to get his approval as the backlight
subsystem maintainer. If he's okay I'll send a patch shortly to add the
corresponding files to MAINTAINERS so that next time I'll wind up in
that list.

Thierry

--9amGYk9869ThD9tj
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQVsA9AAoJEN0jrNd/PrOhG84P/jVFlfDecgnQ6tAda5I9kinP
LJ2DXy4FHePyD2GvJsWmlF+Zz4Z7yLuCtx7SzWibq2gZioiEPmAKyzU78x3/FZ6x
O4+ZxNQgpIf9xviSzhUnwO5VBka08N/KVT2TJnCPWnjMnBQpnRtgb5lDt6PZoG6G
Xn1pDkk6C82hDFUpo5/GEDReGWXT97sghbT1gX2w9Ykyl52oa14+OIeGGAucjI6h
dxIcRwhF5tl1ruDPhe3WK7U06VtlbloWuLNrgSmoO1PlOiaBbdi2fWcPpiGNO66i
EULjVaMaruszNPZ7a3fMWu7DK57ZTuumZDjNIPEjgImew5sbO3eXx6uO7YSIRwOp
laMW5aKVgC5hyaUUYSlHjhB/010gx7oJKflDGlJdGRQ/sjg1f3ljjfzP4Cz0/FQp
lZlc/LCDgmvP/ii/caqg9B6ZScjDDzOvjJPdKszjkgCu0jSqtaV/ojIUhErfQ8ut
31MOmWCb1mMpX7S89WY5YZR07x0L/7YSpI2N5hLoIkmBMoCibfXwiv9a5lKVO8ZK
AAtuIP7uJRO9JWbNGUWmtePQ3gUf+0JMLBudvLfVz9UJDshiG1MqQyfau4Xp+KLs
0BldPkShL0vJvIiOA5woIJjoGJ5n0y5GrDI9wnlNOGg4YVamI+e3i6xcvrMl+qzT
cWf8vTZEcVdSozBb5VDG
=e//9
-----END PGP SIGNATURE-----

--9amGYk9869ThD9tj--
