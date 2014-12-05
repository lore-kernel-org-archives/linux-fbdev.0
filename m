From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 05 Dec 2014 12:02:19 +0000
Subject: Re: [PATCH 2/3] video: fbdev: Check Standard Timing against DMT
Message-Id: <54819ECB.1090607@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="NWs72P1dlGaXvuw7egkqQAedo0huMRfm3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1417643369-20603-2-git-send-email-davidu@nvidia.com>
In-Reply-To: <1417643369-20603-2-git-send-email-davidu@nvidia.com>
To: linux-fbdev@vger.kernel.org

--NWs72P1dlGaXvuw7egkqQAedo0huMRfm3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/12/14 23:49, David Ung wrote:
> Add the VESA Display Monitor Timing (DMT) table.
> During parsing of Standard Timings, it compare the 2 byte STD code
> with DMT to see what the VESA mode should be.  If there is no entry
> in the vesa_modes table or no match found, it fallsback to the
> GTF timings.
>=20
> Signed-off-by: David Ung <davidu@nvidia.com>
> ---
>  drivers/video/fbdev/core/fbmon.c  | 20 ++++++----
>  drivers/video/fbdev/core/modedb.c | 84 +++++++++++++++++++++++++++++++=
++++++++
>  include/linux/fb.h                | 10 +++++
>  3 files changed, 107 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/cor=
e/fbmon.c
> index 5b0e313..aa1110a 100644
> --- a/drivers/video/fbdev/core/fbmon.c
> +++ b/drivers/video/fbdev/core/fbmon.c
> @@ -526,16 +526,22 @@ static int get_std_timing(unsigned char *block, s=
truct fb_videomode *mode,
>  	refresh =3D (block[1] & 0x3f) + 60;
> =20
>  	DPRINTK("      %dx%d@%dHz\n", xres, yres, refresh);
> -	for (i =3D 0; i < VESA_MODEDB_SIZE; i++) {
> -		if (vesa_modes[i].xres =3D=3D xres &&
> -		    vesa_modes[i].yres =3D=3D yres &&
> -		    vesa_modes[i].refresh =3D=3D refresh) {
> -			*mode =3D vesa_modes[i];
> +	for (i =3D 0; i < DMT_SIZE; i++) {
> +		u32 std_2byte_code =3D block[0] << 8 | block[1];
> +
> +		if (std_2byte_code =3D=3D dmt_modes[i].std_2byte_code) {
> +			if (!dmt_modes[i].mode)
> +				break;
> +			*mode =3D *dmt_modes[i].mode;
>  			mode->flag |=3D FB_MODE_IS_STANDARD;
> -			return 1;
> +			DPRINTK("        DMT id=3D%d\n", dmt_modes[i].dmt_id);
> +			break;
>  		}
>  	}
> -	calc_mode_timings(xres, yres, refresh, mode);
> +
> +	if (i =3D=3D DMT_SIZE || !dmt_modes[i].mode)
> +		calc_mode_timings(xres, yres, refresh, mode);
> +
>  	return 1;
>  }

I think this could be made a bit cleaner.

The xres/yres/refresh calculation in get_std_timing doesn't matter for
the DMT code above. So in get_std_timing() you could first do the search
for the DMT mode, and if found, return from the function. After that the
code would do the GTF calculation.

 Tomi



--NWs72P1dlGaXvuw7egkqQAedo0huMRfm3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUgZ7LAAoJEPo9qoy8lh71S5MP/0CIzp7cWHgmu38eiyQOwkWY
3jILrXYBO5O1qT3z9aWT36XSxOxVKfLmZ/9VBFH2hvvgZxiCqEfvOZkMo+VYgC5I
CobLKKUNG+noaoOg3a5RgYXRu5f11ddbnbfImVgOMGS9VbrmmLECRXaetWdPuIuM
yimbCmEkLptoMlI/0Hr1GkpJt4q7EiNcACBGTh80q4RzCtXEHdYpUN00kHGhYqA0
joCiPiJ5upKveklIE6uB+29ugAwJnxAquGbZqy1qcOZKacwO9yTt2RL5dCIyIEos
FVPQvWdGzgu8Am6/cM/JT3AkgmwGu+UFGzitzvb3wIGu1dtqrflDtsAikdDNm0T8
Q14UJBCL4LnF98aYdWZNbZsWZmh7Mqek7HOCmHT23Ni1PJ48/zpTZqc6TCZDtwrn
mRZcZa91ZWoEBUB17FE6StwRiHGMd9iD+XGOaVzbOb7cMPRGssTcC6Zo/FDIICRB
JZ1/ARDwDVaje7B57J1hAnukoI4El85fqnqQW+SVcqOEcWIB4mLMSWPyMpUvHuTW
o9i9mlkiN6IoHQh7cJ00i7sXQggA0pvXs3crYVuw3vVIV82JIB9XxC5P9XQ9Vb3O
4QAMesmjaWUbBIATWCVJ5WzfgGYbUvHTiKNfxXCrh/0DZ+10WN3Cr20k0a2OY3z3
cyF5/lo/ake60jbK3FM2
=Fr3H
-----END PGP SIGNATURE-----

--NWs72P1dlGaXvuw7egkqQAedo0huMRfm3--
