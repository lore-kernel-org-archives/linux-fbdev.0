From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 26 Jul 2013 08:41:47 +0000
Subject: Re: [PATCH] drivers/video: remove unused parameter in Kconfig
Message-Id: <51F2364B.6090605@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="treXOS30gad8uCb8lSsdtPSqMDUbI0mpg"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1373259806-23067-1-git-send-email-michael.opdenacker@free-electrons.com>
In-Reply-To: <1373259806-23067-1-git-send-email-michael.opdenacker@free-electrons.com>
To: Michael Opdenacker <michael.opdenacker@free-electrons.com>
Cc: plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--treXOS30gad8uCb8lSsdtPSqMDUbI0mpg
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/07/13 08:03, Michael Opdenacker wrote:
> This patch proposes to remove the FB_NUC900_DEBUG kernel configuration
> parameter defined in drivers/video/Kconfig, but used nowhere
> in the makefiles and source code.
>=20
> Signed-off-by: Michael Opdenacker <michael.opdenacker@free-electrons.co=
m>
> ---
>  drivers/video/Kconfig | 7 -------
>  1 file changed, 7 deletions(-)
>=20
> diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
> index 2e937bd..a9c0964 100644
> --- a/drivers/video/Kconfig
> +++ b/drivers/video/Kconfig
> @@ -2098,13 +2098,6 @@ config GPM1040A0_320X240
>          bool "Giantplus Technology GPM1040A0 320x240 Color TFT LCD"
>          depends on FB_NUC900
> =20
> -config FB_NUC900_DEBUG
> -        bool "NUC900 lcd debug messages"
> -        depends on FB_NUC900
> -        help
> -          Turn on debugging messages. Note that you can set/unset at r=
un time
> -          through sysfs
> -
>  config FB_SM501
>  	tristate "Silicon Motion SM501 framebuffer support"
>  	depends on FB && MFD_SM501
>=20

Thanks, I've applied this into my 3.12/fbdev branch.

 Tomi



--treXOS30gad8uCb8lSsdtPSqMDUbI0mpg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJR8jZLAAoJEPo9qoy8lh71rBoP/jB8Aed2jSL9QS+/VMH3RaW9
J1ncszrcpXdinFRGPDcqgOZBGCMD87L1t0y1OhLDDhYnYbMdFSg91c8TvH5qY8DB
v4vPrR+zsmX2M531hlUj+s2OQvWpS5KIcez8TFLyvOB4DvoTo2UksBLqQlvDU1XJ
G5bDkUseJxTN5REiCloFEZDwdJF3v+Rb+VfI7qFEeUR8hgMJ4pfpiGF9NbueMdwZ
5Nw9Zud2Td/ET5j4eBWHBqHNdXVP3wdF6OzsoVeJN3Ly7OSEK+VYoHDrmxa7uQaX
EVeZmYnKniJ15/OZVi0gdJ1jQ6/xUm1PR/jCM+vAKSTqHor/A9NM00sDxdWiqNfh
We59E9W0xdnFNWGA2PUyEklNRaNFYZRIo1jkCuyexaWGFGuwB6/2SOwsQWrVjw8r
F8/dPUX5F27ra7ORTjUpCnU5Ht1Sy08QWf0PzGH/zxlvXl7EEo+xJih1nlGzeNMu
MUU0bDip1EpgLJ758CNdyzD4oj9xJtvKV8FBAMN8W98vFjWUge3B5O40Jv2ovds5
92/f3S8WvQ8YNeeIqB8fOoJ1BUfD+apMycuopu99pTKvRIhotSNW9ZDmkZpEM3Rd
TvWkbNsVd0/iK6vMs3W7gmSc0iy33lIV5z/koO3kLo6RQSJynqiaAP1OosAZjWB6
Hh5MXd1nOy+mJbyhGoL/
=A8EW
-----END PGP SIGNATURE-----

--treXOS30gad8uCb8lSsdtPSqMDUbI0mpg--
