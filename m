From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 11 Feb 2014 14:27:33 +0000
Subject: Re: [PATCH 1/2] video: exynos: Remove OF dependency for Exynos DP
Message-Id: <52FA3355.80700@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="PG0lXcAAn1oCqU903N4Gfw69XF8dx326c"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1389933172-22991-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--PG0lXcAAn1oCqU903N4Gfw69XF8dx326c
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 11/02/14 14:01, Sachin Kamat wrote:
> On 10 February 2014 17:48, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote=
:
>> On 17/01/14 06:32, Sachin Kamat wrote:
>>> Exynos is now a DT only platform. Hence there is no need
>>> for an explicit OF dependency. Remove it.
>>
>> But the driver still depends on OF, doesn't it? I don't think it's ver=
y
>> good for the driver Kconfig to make presumptions about what ARCH_*
>> depend on.
>=20
> Depending upon nested dependencies is redundant IMHO.

Well, a driver should be independent of the underlying arch. In
practice, we have ARCH dependencies, as many of the devices only exist
on that arch. But I think the drivers should still be designed to be
arch-independent, as far as possible (omapdss compiles fine on x86).

If the driver depends on OF, it should depend on OF in the Kconfig, no
matter if the arch also depends on OF.

I don't really care if the EXYNOS_LCD_S6E8AX0 has OF dependency or not,
but to me this just looks unneeded cleanup, cluttering git logs, and in
my opinion it's even going to the wrong direction.

 Tomi



--PG0lXcAAn1oCqU903N4Gfw69XF8dx326c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS+jNVAAoJEPo9qoy8lh71yYkP/A8Q/qOzXWVlC/5FyB+NCpit
7t1qqDxhNkbbAz5KwQ+DiNRJXl8AcRueR5xzLuP7scfo3goKx3ihZ/aHTtCsdHaF
xf7rAEZTQl60/dwHVI0LMlyFvzRKcliJPznZQ40Ec66QTjkn+Z6LbI7nnqYcSXI2
xD27cd9U0l9aTDc8J/BYB18PK8LGcLRDJoDH9SkSUi4PE/Mw/+m63+3EGvpAt3DN
3cPvLY2l5ddaNdQ0aovhQ2ITe7iIVgh1vAuuDT11YP57KU6FQLGwk6dcvyD5wgMC
mMu7HCxOHl/PWC/sgxv7fa4ljF46TXQ6fxGCSS23zcApqlu1zrac3EJhtdtMF84h
TQkc5x0UACxc/4+t8hq6z0PNTZ8tna1fb7MDp3Dkx2cJHjFyAdVLGq1U+Vf8NCQn
7Uo4bH4UjexwMnQmLRFRYPpc+RyRygU0IzUSGp4Wct7u2fpcw/AMz+9vlYN7ke15
STAwkd6uxN2SXz7a7wyb4WEgkIQGCwUzUaKUuo39NYYoWdpAfu8kf9h964DndBY/
4WIHDwoUZjF1iBjIR4rY3Ynw4xrE9cYgUA08x/lXbz5aWHjJDwEsfKLvDbQ3yj++
JqIQ3onaEjc0Qy7KPVoKCG7fl9EGpeGJBrHwJzVlWIf6ob+VjnINnAhsI86GfolH
SY74hLqhP8sGNHWLibvI
=BkVP
-----END PGP SIGNATURE-----

--PG0lXcAAn1oCqU903N4Gfw69XF8dx326c--
