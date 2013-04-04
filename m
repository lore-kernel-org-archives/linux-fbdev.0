From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 04 Apr 2013 10:19:18 +0000
Subject: Re: [PATCH] drivers/video: fsl-diu-fb: add hardware cursor support
Message-Id: <515D53A6.4000106@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------enig01BC8AA7D33D65CF9E6C3BFA"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1358281046-31552-1-git-send-email-timur@tabi.org>
In-Reply-To: <1358281046-31552-1-git-send-email-timur@tabi.org>
To: linux-fbdev@vger.kernel.org

--------------enig01BC8AA7D33D65CF9E6C3BFA
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 2013-03-30 02:36, Timur Tabi wrote:
> The Freescale DIU supports a 32x32 color hardware cursor.  Framebuffer
> cursors are monochrome, so the driver converts the image data to the
> format that the DIU expects and then programs to hardware accordingly.
>=20
> The support cursor enabling/disabling, we provide two cursor image buff=
ers.
> One is always blank (all zeroes), and the other contains the real curso=
r
> image data.  To disable the cursor (used typically for cursor blinking)=
,
> we just tell the hardware to use the blank cursor data.
>=20
> Signed-off-by: Timur Tabi <timur@tabi.org>
> ---
>  drivers/video/fsl-diu-fb.c | 157 +++++++++++++++++++++++++++++++++++++=
+++++++-
>  1 file changed, 155 insertions(+), 2 deletions(-)

I'll add this to fbdev patches for 3.10.

 Tomi



--------------enig01BC8AA7D33D65CF9E6C3BFA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBAgAGBQJRXVOmAAoJEPo9qoy8lh71zQgP/3mwV5ZrLjhN5P1YT5bmDyKp
rPLFeGlIKI18fQOPkSc/LHJummVfaQ1ChfgRtftI3wX1oDk07AWyfthPCwhji75o
w5EFHXZplmvcn27XE1ewaEYXQ4QDwGiwj9OkWtexeHo48R8HgLmpVIghGiDw6qj0
ULcvoTBLKmcFFRNX4CwURUVEbrnB5tBpRbGj71FudQjQcRIiFj6Q+l4gMV+sq9s2
1hlIivU2Z67EfF6JMZ81TAOFwR+f93672dg3yo0+Ly+f5x/z4WEoW5fT1dbrTDY8
qGvZxEJ9Umc1y39V0QhLYmJBM5xzHv37xVOFYccjPOH31dPXGACiKUu46y1JjJ5D
qZxy3OqcODR09pPqSorCvR0XUqImTI8BOMh6LcX9fRkyKjmYu5PtvnwsAu5bJPYt
VQXo0UKxdheEKoshFfmtuV6cu45tV12LLCA00CZPiwAGh9/7+WDtB9UFOQea0Wop
LDQCVsUmS0mQUT5B0B1f0SaWbt52CchWxJel6ySu9+UqiK2gopwSFQ/KlsqtaqD5
HY54ZqpT+myj1sqUvmmdp5IgtnPhVJlxmRBROI+kKTXmStW993j+Kr08VFcYeZI8
7zi1HZuVxy5speKLJfkDpAkw/2oPMyvN9neQdCnuA02ERN2+zzfUFiL9z49nOTme
4hImqa/3Tuf6HGVU8kw3
=xnxh
-----END PGP SIGNATURE-----

--------------enig01BC8AA7D33D65CF9E6C3BFA--
