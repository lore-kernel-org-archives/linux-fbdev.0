From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 24 Sep 2015 11:07:08 +0000
Subject: Re: [PATCH 2/4] [resend #2] tridentfb: Fix set_lwidth on TGUI9440 and CYBER9320
Message-Id: <5603D95C.7030006@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6HV4PRL1FSita09fUjID7Aj6S8OAfjASk"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1440445048-24694-1-git-send-email-linux@rainbow-software.org>
 <1440445048-24694-2-git-send-email-linux@rainbow-software.org>
In-Reply-To: <1440445048-24694-2-git-send-email-linux@rainbow-software.org>
To: Ondrej Zary <linux@rainbow-software.org>, Krzysztof Helt <krzysztof.h1@wp.pl>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

--6HV4PRL1FSita09fUjID7Aj6S8OAfjASk
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 24/08/15 22:37, Ondrej Zary wrote:
> According to X.Org driver, chips older than TGUI9660 have only 1 width =
bit
> in AddColReg. Touching the 2nd one causes I2C/DDC to fail on TGUI9440.
>=20
> Set only 1 bit of width in AddColReg on TGUI9440 and CYBER9320.
>=20
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> ---
>  drivers/video/fbdev/tridentfb.c |   10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/trid=
entfb.c
> index 7429713..01b43e9 100644
> --- a/drivers/video/fbdev/tridentfb.c
> +++ b/drivers/video/fbdev/tridentfb.c
> @@ -673,8 +673,14 @@ static int get_nativex(struct tridentfb_par *par)
>  static inline void set_lwidth(struct tridentfb_par *par, int width)
>  {
>  	write3X4(par, VGA_CRTC_OFFSET, width & 0xFF);
> -	write3X4(par, AddColReg,
> -		 (read3X4(par, AddColReg) & 0xCF) | ((width & 0x300) >> 4));
> +	/* chips older than TGUI9660 have only 1 width bit in AddColReg */
> +	/* touching the other one breaks I2C/DDC */
> +	if (par->chip_id =3D=3D TGUI9440 || par->chip_id =3D=3D CYBER9320)
> +		write3X4(par, AddColReg,
> +		     (read3X4(par, AddColReg) & 0xEF) | ((width & 0x100) >> 4));
> +	else
> +		write3X4(par, AddColReg,
> +		     (read3X4(par, AddColReg) & 0xCF) | ((width & 0x300) >> 4));
>  }
> =20
>  /* For resolutions smaller than FP resolution stretch */
>=20

Thanks, queued for 4.3 fixes.

Tomi


--6HV4PRL1FSita09fUjID7Aj6S8OAfjASk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWA9lcAAoJEPo9qoy8lh71kPoQAKfaNN++IiDegey5PPi4ChZa
3NqZlobwuYRxLrIsQBDkNXvf1bvOn761hWFZKcdm9Ev+1GrM6Lt7RhMnY1aFZDwr
uNerLU0rrgBFGR4A6ie9WDLiTjKI1F4aWAWUSQYG0cFkX7rEwRb/flQamZgdIajz
z5bUD4EYegrAIP5ULAGDKdkZY5WzlTV+EVOOYd8Gp2gr0gMgnC14l/uEpKuv0qlH
Xhtmkg1/52ivEmekRciPaol9FYCvEcAbKZiFqdgi7riUBdyTz9UBknFhcA9RVif0
FzVCocxMqN3bd3byq3/llWhAkqTinSpRZqJQBeeGSBQ6Ry8RmKqVqaBT0X4t/6he
l1OdtBqvVzs0oLD+0f7QgzU29XJAx1E8TdDQLDakPSY8MbyYafjeVZVqAC61WaRl
hEeERQxGgAOYxe2YZQi4V3JeJVtmcPKhabhxDeWG1nd1HzWVEoxFa/1CIjeyy2Jy
xfyib5esMSuTHuJaeR7u+iT3c8KDO+F7gm+65VivOin8IlbXHne0t0j3NRXpc+3B
a6MNRaV7vMNCTizCLZmgjucQu2SygquSwJha3fHaBz4G9uxMaBaZCq51gP9ZH5Tq
xsaj55f2zEkN/tlsQoaKBCFrXyKrFWS7IAxq/Xn1PuzNVTKUIluFCAyhowgJQ2Pp
Af+0ObV9I4jkn5fDbSS6
=cVeI
-----END PGP SIGNATURE-----

--6HV4PRL1FSita09fUjID7Aj6S8OAfjASk--
