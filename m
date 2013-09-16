From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 16 Sep 2013 09:39:51 +0000
Subject: Re: [PATCH 00/21] video: remove unnecessary pci_set_drvdata()
Message-Id: <5236D1E7.5030801@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="IsToKwFUenBKBlMWXadGSBrCDt7jc3UwW"
List-Id: <linux-fbdev.vger.kernel.org>
References: <001a01ceaf84$32c52d90$984f88b0$%han@samsung.com>
In-Reply-To: <001a01ceaf84$32c52d90$984f88b0$%han@samsung.com>
To: linux-fbdev@vger.kernel.org

--IsToKwFUenBKBlMWXadGSBrCDt7jc3UwW
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/09/13 09:49, Jingoo Han wrote:
> Since commit 0998d0631001288a5974afc0b2a5f568bcdecb4d
> (device-core: Ensure drvdata =3D NULL when no driver is bound),
> the driver core clears the driver data to NULL after device_release
> or on probe failure. Thus, it is not needed to manually clear the
> device driver data to NULL.
>=20
> ---
>  drivers/video/arkfb.c                  |    1 -
>  drivers/video/carminefb.c              |    1 -
>  drivers/video/cirrusfb.c               |    1 -
>  drivers/video/cyber2000fb.c            |    5 -----
>  drivers/video/geode/gx1fb_core.c       |    1 -
>  drivers/video/geode/gxfb_core.c        |    1 -
>  drivers/video/geode/lxfb_core.c        |    1 -
>  drivers/video/i740fb.c                 |    1 -
>  drivers/video/i810/i810_main.c         |    1 -
>  drivers/video/intelfb/intelfbdrv.c     |    2 --
>  drivers/video/kyro/fbdev.c             |    1 -
>  drivers/video/mb862xx/mb862xxfbdrv.c   |    1 -
>  drivers/video/neofb.c                  |    6 ------
>  drivers/video/pm2fb.c                  |    1 -
>  drivers/video/pm3fb.c                  |    1 -
>  drivers/video/s3fb.c                   |    1 -
>  drivers/video/savage/savagefb_driver.c |    6 ------
>  drivers/video/sis/sis_main.c           |    4 ----
>  drivers/video/tdfxfb.c                 |    1 -
>  drivers/video/tridentfb.c              |    1 -
>  drivers/video/vt8623fb.c               |    1 -
>  21 files changed, 39 deletions(-)
>=20

Thanks, applying for 3.13.

 Tomi



--IsToKwFUenBKBlMWXadGSBrCDt7jc3UwW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSNtHnAAoJEPo9qoy8lh71QdkP/Apu/3H+nC7yeBQW2lNKGyR+
8t///JUa8jMTwoMx6dYhdzS1TEmOFqt7+C4Rkt5NwuSFGNuWPwAyitzjyoTURz2i
kkf1ji44ojYDiMZJBR9yPgO/WTVf+5cqHCwMop/MmPbPFPxo4rd9ySEQ9KaHpk0g
EMPJeiLlu2veGd4gNsqr/g/xjwHaoDnHHtUftFvqUFtbrLhaLjDSws1PtiZvfw/z
DriWV6Ek7lDpLW0ctU0nHmcUEDhNE3RTj0xK89zTDQ15oGlokEntYcR4p0pqeEBJ
ammykViLdYlMnm9y9njiSPzsx+lkSXM9HtPrfEUJFMqRbgq1Afw5iDlPklDroPxH
KMj3LWrgYBSN+3MOpdCCKm0PsfK5p94sXXK6TltRsfxQKlmeFBKdVrnzFi4D+aXo
xHSI+AjB7HrHaN9I4aaxn5wLFU2MlhELEU9XrKxV6Q9OVOpcJvE2rTuN0fB6nIp9
40c4rLd3gNFGaGi55aQEgGkL3gMCcU+HJHUvUoAnEYbC71atKvAAhBdnQ9Wic0PH
eRjLC8O4A9zCI6dSQ4uxZRWwIvgi86I2qbIsGXKU0wQKAOg3LE2XTeNQYJjM4rYk
UqTX2g2CFbpWc30jeub+UlFApW2W/x8iediwkhzw59thdHWKHzuXsn64Nj2z3tnm
PFVLn4ZTJX60VvAcqQbt
=Fbof
-----END PGP SIGNATURE-----

--IsToKwFUenBKBlMWXadGSBrCDt7jc3UwW--
