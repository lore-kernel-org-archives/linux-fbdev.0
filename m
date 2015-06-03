From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 03 Jun 2015 11:59:57 +0000
Subject: Re: [PATCH] fbdev: radeon: Remove 'struct timeval' usage
Message-Id: <556EEC3D.4010608@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="6cvFbg09gjlswpd1SBsxMcwKpv6LdJ3Eu"
List-Id: <linux-fbdev.vger.kernel.org>
References: <20150525040716.GA4448@tinar>
In-Reply-To: <20150525040716.GA4448@tinar>
To: Tina Ruchandani <ruchandani.tina@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: y2038@lists.linaro.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

--6cvFbg09gjlswpd1SBsxMcwKpv6LdJ3Eu
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 25/05/15 07:07, Tina Ruchandani wrote:
> 'struct timeval' uses a 32-bit representation for the
> seconds field which will overflow in the year 2038 and beyond.
> This patch replaces the usage of 'struct timeval' with
> ktime_t which uses a 64-bit time representation and does not
> suffer from the y2038 problem. This patch is part of a larger
> effort to remove all instances of 'struct timeval', 'struct
> timespec', time_t and other 32-bit timekeeping variables
> from the kernel.
> The patch also replaces the use of real time (do_gettimeofday)
> with monotonic time (ktime_get).
>=20
> Signed-off-by: Tina Ruchandani <ruchandani.tina@gmail.com>
> ---
>  drivers/video/fbdev/aty/radeon_base.c | 29 ++++++++++++++-------------=
--
>  1 file changed, 14 insertions(+), 15 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbde=
v/aty/radeon_base.c
> index 01237c8..9747e9e 100644
> --- a/drivers/video/fbdev/aty/radeon_base.c
> +++ b/drivers/video/fbdev/aty/radeon_base.c
> @@ -64,6 +64,7 @@
>  #include <linux/slab.h>
>  #include <linux/delay.h>
>  #include <linux/time.h>
> +#include <linux/ktime.h>
>  #include <linux/fb.h>
>  #include <linux/ioport.h>
>  #include <linux/init.h>
> @@ -461,8 +462,8 @@ static int radeon_probe_pll_params(struct radeonfb_=
info *rinfo)
>  	int hTotal, vTotal, num, denom, m, n;
>  	unsigned long long hz, vclk;
>  	long xtal;
> -	struct timeval start_tv, stop_tv;
> -	long total_secs, total_usecs;
> +	ktime_t start, stop;
> +	s64 delta;
>  	int i;
> =20
>  	/* Ugh, we cut interrupts, bad bad bad, but we want some precision
> @@ -478,7 +479,7 @@ static int radeon_probe_pll_params(struct radeonfb_=
info *rinfo)
>  		if (((INREG(CRTC_VLINE_CRNT_VLINE) >> 16) & 0x3ff) =3D=3D 0)
>  			break;
> =20
> -	do_gettimeofday(&start_tv);
> +	start =3D ktime_get();
> =20
>  	for(i=3D0; i<1000000; i++)
>  		if (((INREG(CRTC_VLINE_CRNT_VLINE) >> 16) & 0x3ff) !=3D 0)
> @@ -487,20 +488,18 @@ static int radeon_probe_pll_params(struct radeonf=
b_info *rinfo)
>  	for(i=3D0; i<1000000; i++)
>  		if (((INREG(CRTC_VLINE_CRNT_VLINE) >> 16) & 0x3ff) =3D=3D 0)
>  			break;
> -=09
> -	do_gettimeofday(&stop_tv);
> -=09
> +
> +	stop =3D ktime_get();
> +
>  	local_irq_enable();
> =20
> -	total_secs =3D stop_tv.tv_sec - start_tv.tv_sec;
> -	if (total_secs > 10)
> +	delta =3D ktime_us_delta(stop, start);
> +
> +	/* Return -1 if more than 10 seconds have elapsed */
> +	if (delta > (10*1000000))
>  		return -1;
> -	total_usecs =3D stop_tv.tv_usec - start_tv.tv_usec;
> -	total_usecs +=3D total_secs * 1000000;
> -	if (total_usecs < 0)
> -		total_usecs =3D -total_usecs;
> -	hz =3D 1000000/total_usecs;
> -=20
> +	hz =3D 1000000/delta;
> +
>  	hTotal =3D ((INREG(CRTC_H_TOTAL_DISP) & 0x1ff) + 1) * 8;
>  	vTotal =3D ((INREG(CRTC_V_TOTAL_DISP) & 0x3ff) + 1);
>  	vclk =3D (long long)hTotal * (long long)vTotal * hz;
> @@ -548,7 +547,7 @@ static int radeon_probe_pll_params(struct radeonfb_=
info *rinfo)
>  		denom *=3D 3;
>  		break;
>  	case 6:
> -		denom *=3D 6;  =20
> +		denom *=3D 6;
>  		break;
>  	case 7:
>  		denom *=3D 12;

The above change was extra. I removed it, and queued this for 4.2.

 Tomi


--6cvFbg09gjlswpd1SBsxMcwKpv6LdJ3Eu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVbuw9AAoJEPo9qoy8lh71Lm4P/3sSW7PaF2iQ44W2SU3kugaP
RJd2lDPZE33hyVfp3rsybsOFamkBlY4zkrjyi2toH6KhW9AIuGywR7GurW1QBJSh
m+OQYh/JnxyrX0xg34XQxrJ2cWboqHp5wWmAhRMjnDIctLGL2g/NDPT0piQMJoiB
iF4RQyHoJCYyrZthHJMRsvdhslMApdwT0w6abE8bTEYD/zqqoLc1saA8Ie+l4oJc
MyzaJquwzAcsQF/gZtraXgVHlF8RbR5Y0HNcFzluwySdgJPI45TipD3K/PiFq8ZC
xdAXJTcMbdCdF9b7v5ebBmgRoh7ToBZD3keXMkWMGkzHrWs75QCAguHootH4ZFb7
N78w6fX1sAyEwopS6QiLX4PsTkYt7NiwNCgjqH13EBUH4+y4qqieUb+z6eUMbp4b
QFk05gMCVaq87gZXlcdL9G8fPB66hUvp48MNM7+xXAsM1HN8nTa9QLtzXqWu5zGN
bdUZ/9carVIXklC1KEczwBWA5PK7nynGKg++Qv2JElF+d245wQwoY/+zzs5gyc+6
UfD78u27qsYFpdUb25CI/rnQETM0Sob0IGJJfKOlBWeqkUVH93RYUCKk/OO3U4Yq
0FHaKpsa2YLiBxCcMOAbPusgXsYBW6yFJrRU6T3TcXWPKOtatd3imia/Lkbs/kqs
I7PF/DoXzJcE9+UqGzfS
=uI5w
-----END PGP SIGNATURE-----

--6cvFbg09gjlswpd1SBsxMcwKpv6LdJ3Eu--
