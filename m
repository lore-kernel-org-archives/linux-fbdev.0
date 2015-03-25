From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Wed, 25 Mar 2015 22:00:59 +0000
Subject: Re: [PATCHv5 11/11] fbdev: ssd1307fb: Add blank mode
Message-Id: <20150325220059.GP23664@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="aMDdG8xNveJz2ruI"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1427232238-21099-1-git-send-email-niederp@physik.uni-kl.de>
 <1427232238-21099-12-git-send-email-niederp@physik.uni-kl.de>
 <5512D92D.3020809@schinagl.nl>
In-Reply-To: <5512D92D.3020809@schinagl.nl>
To: Olliver Schinagl <oliver@schinagl.nl>
Cc: Thomas =?iso-8859-1?Q?Niederpr=FCm?= <niederp@physik.uni-kl.de>, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--aMDdG8xNveJz2ruI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 25, 2015 at 04:50:05PM +0100, Olliver Schinagl wrote:
> Hey Thomas,
>=20
> On 24-03-15 22:23, Thomas Niederpr=FCm wrote:
> >This patch adds ssd1307fb_blank() to make the framebuffer capable
> >of blanking.
> >
> >Signed-off-by: Thomas Niederpr=FCm <niederp@physik.uni-kl.de>
> >---
> >  drivers/video/fbdev/ssd1307fb.c | 13 +++++++++++++
> >  1 file changed, 13 insertions(+)
> >
> >diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd13=
07fb.c
> >index 061cc95..9101b27 100644
> >--- a/drivers/video/fbdev/ssd1307fb.c
> >+++ b/drivers/video/fbdev/ssd1307fb.c
> >@@ -238,6 +238,18 @@ static ssize_t ssd1307fb_write(struct fb_info *info=
, const char __user *buf,
> >  	return count;
> >  }
> >
> >+static int ssd1307fb_blank(int blank_mode, struct fb_info *info)
> >+{
> >+	struct ssd1307fb_par *par =3D info->par;
> >+	int ret;
> >+
> >+	if (blank_mode !=3D FB_BLANK_UNBLANK)
> >+		ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_OFF);
> >+	else
> >+		ret =3D ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_ON);
> I'd probably add an extra return, or drop the ret var at all and just ret=
urn
> the function.
>=20
> or even shorter :)
> return sd1307fb_write_cmd(par->client, (blank_mode !=3D FB_BLANK_UNBLANK)=
 ?
> SSD1307FB_DISPLAY_OFF : SSD1307FB_DISPLAY_ON;

In some domains, shorter is not better ;)

This is one of these cases. It's much clearer as it is.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--aMDdG8xNveJz2ruI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEzAbAAoJEBx+YmzsjxAgNRcP/ip8jkT3xUD+aorLeZQ1cbni
VWeVcWCT8FeMej0+fVpajEyZpIotqFtn/FnELalLqvvVl6Cv5tFF4mvZKDafls2m
pG54NXG2mFJ5/48mu5JwhW6jntNK3/+gwLezFvEA6F2uwieU41Xh1zfh4Cse2Vn+
+VCE9vB6sWZVqcCvykjAdaGUi+n2aPqsr5B2dZwoooP92ps0by2BfKiHO4420Hpi
Sz5cB2KoCT3vqeEKhDtcOEpqjf2zTt2xOF/+d2/ZRlcRA56+xXDbVKt4IzGJkYg2
L0ltO4906RORhtzMvb5KBQuyXIh1xQ7Y/b7geh000A5mfBQDunQkZ2eoHbS++Lae
QKvUhGTJ7Rr/ukfEPhlgEAyFd8H2bf6ALn00k2nGIuNqJcAkCtZcZ5JDmjT+wdnO
g76dE+0Vtiulzf0v901MNGIgcfI7IF9sB+E+EwixNLjJ3ynwMwwaXrxTfbYTBRCr
tsl/fU7wnPjxW/DCMWRiguNUT1/j5Ho/sNMsWVNp+KCMMarlGjkkMImMe+SWJlzb
F9uiQK1JOOgbDFhNOQRLTtTzmRDyxXGsMbKZiMFnZNCcY/VPU+pbSzpugPb+vB7C
yVLiM+6Le5HLXP/glr0+odzakZYGbDmsFG6jLt5uTv2hkIGhe6I23SQamCIZAn4y
eeiNZysKLuax3nEAISWw
=OJmZ
-----END PGP SIGNATURE-----

--aMDdG8xNveJz2ruI--
