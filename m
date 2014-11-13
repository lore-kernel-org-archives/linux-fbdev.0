From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Thu, 13 Nov 2014 08:52:38 +0000
Subject: Re: [PATCH 3/4] simplefb: Change simplefb_init from module_init to fs_initcall
Message-Id: <20141113085238.GE20972@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="OZkY3AIuv2LYvjdk"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1415830124-28787-1-git-send-email-hdegoede@redhat.com>
 <1415830124-28787-3-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1415830124-28787-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--OZkY3AIuv2LYvjdk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2014 at 11:08:43PM +0100, Hans de Goede wrote:
> One of the reasons for having the simplefb nodes in /chosen, and doing
> explicit enumeration of the nodes there, is too allow enumerating them so=
oner,
> so that we get a console earlier on.
>=20
> Doing this earlier then fs_initcall is not useful, since the fb only turn=
s into
> a console when fbcon intializes, which is a fs_initcall too.
>=20
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/video/fbdev/simplefb.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplef=
b.c
> index be7d288..8c0c972 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -415,7 +415,11 @@ static void __exit simplefb_exit(void)
>  	platform_driver_unregister(&simplefb_driver);
>  }
> =20
> -module_init(simplefb_init);
> +/*
> + * While this can be a module, if builtin it's most likely the console
> + * So let's leave module_exit but move module_init to an earlier place
> + */

Not really related to this patch itself, but do we want to support
simplefb as a module? It seems like it's going to be most of the time
broken.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--OZkY3AIuv2LYvjdk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUZHFWAAoJEBx+YmzsjxAgwT0P/2SrQE4upowRwwn5NKq068Qz
AweVswy183+3DGHkOt1vTbserlCArNBAc4n4GgM/uyhtd4Um4l5jHT6eKPVNU6ZI
OCCv3m/BR9r+2Y89gaCtmRqKbbzVB2wP8tCGaijqBMaTe5OmvAqLJ6sWPJEfEJdn
UcvWQF7q9ple8xXwIhL8V/d1Kz/fdQT6NmoxepjEAozRKVypFUlkOtdSryTzBkHK
akAjpXz8zDjxLfnTuRSQJHoYa7BA8W/P6Wa6K8O2OYQ0ttNpkynwnjTtFkwhzFWC
xUtgq1LNFoSfZ1VS6PZIqcp90qsCjcD7KrfNxDc6xRCGeHvkKBypmJU4jMxxlcSp
6BJQrW/oz4Qe8T2XvTW60G+dNWEiPrCQiuh7x5isqHeBOqL4sHD2O1TXPV0nfTtA
RWra8EMxRFSjECuKtOakQtgH6nrO8vLWIxmbN+vRiP/1IsqOljd6oA1KIPGrjjgL
dkhaBkr0k2H6xQAE8EMo4IHTv2JlU4Kn1Aaw56YVXnNtkzsFNJwetJhIRGr/9AgD
M9+RBiFqxenkKN33o/ZFSjZ+IfJxRLwY+gRqucMrYdAABvGa1ptm9sQMDLcIVAa6
o5cQ3EkVGOazk7iUb/JduHJsJOjN3gtJtQ5GPNNLwf3DhimPYG6a4ZfnlbIx8n8V
4vNaCqAdn0QWCaChIc1I
=YD+W
-----END PGP SIGNATURE-----

--OZkY3AIuv2LYvjdk--
