From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 20 Aug 2015 11:02:01 +0000
Subject: Re: [RFC] fbdev/riva:change to use generice function to implement reverse_order()
Message-Id: <55D5B3A9.6040901@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Qmbadipqd1E4IBI1aK5URLUlXsdSEf4FH"
List-Id: <linux-fbdev.vger.kernel.org>
References: <C21B8761-0447-45A6-B833-742E3B4C13DE@gmail.com>
In-Reply-To: <C21B8761-0447-45A6-B833-742E3B4C13DE@gmail.com>
To: yalin wang <yalin.wang2010@gmail.com>, adaplas@gmail.com, plagnioj@jcrosoft.com, linux-fbdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

--Qmbadipqd1E4IBI1aK5URLUlXsdSEf4FH
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable


On 10/08/15 13:12, yalin wang wrote:
> This change to use swab32(bitrev32()) to implement reverse_order()
> function, have better performance on some platforms.

Which platforms? Presuming you tested this, roughly how much better
performance? If you didn't, how do you know it's faster?

> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
> ---
>  drivers/video/fbdev/riva/fbdev.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riv=
a/fbdev.c
> index f1ad274..4803901 100644
> --- a/drivers/video/fbdev/riva/fbdev.c
> +++ b/drivers/video/fbdev/riva/fbdev.c
> @@ -40,6 +40,7 @@
>  #include <linux/init.h>
>  #include <linux/pci.h>
>  #include <linux/backlight.h>
> +#include <linux/swab.h>
>  #include <linux/bitrev.h>
>  #ifdef CONFIG_PMAC_BACKLIGHT
>  #include <asm/machdep.h>
> @@ -84,6 +85,7 @@
>  #define SetBit(n)		(1<<(n))
>  #define Set8Bits(value)		((value)&0xff)
> =20
> +#define reverse_order(v) swab32(bitrev32(v))
>  /* HW cursor parameters */
>  #define MAX_CURS		32
> =20
> @@ -451,15 +453,6 @@ static inline unsigned char MISCin(struct riva_par=
 *par)
>  	return (VGA_RD08(par->riva.PVIO, 0x3cc));
>  }
> =20
> -static inline void reverse_order(u32 *l)

I would suggest to do the work in the inline function, instead of a
macro. And if you keep the function prototype the same, then the changes
to each reverse_order call site are not needed.

 Tomi


--Qmbadipqd1E4IBI1aK5URLUlXsdSEf4FH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV1bOpAAoJEPo9qoy8lh715eIQAK/0hFs/HNCLddA763S6Z62d
cFPwUOw0uHy8KP99rWGssKIxwI26kTJ6zTQOxoPmEIQta3H8bu5UvwvIhQ0qkuHw
fRgqgo4vbQWHaPvpaFKYhiLq3omSqUHRXP/wiuC/N+yf6eJmRWwzd6MUJdDnH4Nz
1HyhOgk5dy6vyN6zGV+A2jLFPalct2yGT2TqqRa2M0v4CL6a+4rjjaLdjN/kbPTs
VwqF30CO/GAPqYEp2rVBkjNYng0SgLS8ne+6hkxH+BDolStT9fR3O6DqWZfJ5KUk
NEfHFiJ3p10+oF/NBuZnvNBaqz68VrHbCTHUBjna05iL5gcXbUCfTUK/zwxZuEwJ
ICiSUwfIJSqv9FkhMHhBG6RfutZovHj5brQ20RpLvHO+sRAOWYLyezxB3Go3K26k
jCy45lcGo1NCYlnBsf+atzDyQrWxTC/NoBY/o2KM+DSER5YPWCZPof4xAgkeL0jd
DrtP3o4L4U2eFexDriPYwaQWl4szg1FuBBA2qglIIofXF6+ThiO6F4Cw7Kfr3rwQ
4VUOkH3PtWiR2k8YTFaaiUDs1FDQ68K4YrFUomk2WdfmExCkd6G4BZtyOuvkR3sh
A0mkoevCYa0m4p5nwlgkUCfca/PdiZPC+gEoSI0vmUdXtYP5mRMrqFIuYdY4KVAJ
jBbtQxizSLhJ6Nj1ii27
=lZOM
-----END PGP SIGNATURE-----

--Qmbadipqd1E4IBI1aK5URLUlXsdSEf4FH--
