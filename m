From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 09 May 2014 10:06:44 +0000
Subject: Re: [PATCH] uvesafb: abort initialization if video=uvesafb is not set
Message-Id: <536CA8B4.6020202@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Tb1aok9802nFlesASsrNFxIx5vewXhdkg"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1396791873-22606-1-git-send-email-lxnay@sabayon.org>
In-Reply-To: <1396791873-22606-1-git-send-email-lxnay@sabayon.org>
To: linux-fbdev@vger.kernel.org

--Tb1aok9802nFlesASsrNFxIx5vewXhdkg
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 06/04/14 16:44, lxnay@sabayon.org wrote:
> From: Fabio Erculiani <lxnay@sabayon.org>
>=20
> This patch makes possible to ship kernels with both vesafb and uvesafb
> in order to guarantee a smooth transition to uvesafb and cope with
> potential incompatibiles introduced by uvesafb making possible to disab=
le
> it via cmdline.
>=20
> In case both vesafb and uvesafb are built-in, the kernel will try to
> initialize both, which makes possible to select the wanted one using
> either video=3Dvesafb:... or video=3Duvesafb:....
> In this way, old distro installations will keep working as before while=

> new ones can adopt video=3Duvesafb.
>=20
> The behaviour does not change if uvesafb is built as a module.
> ---
>  drivers/video/uvesafb.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/drivers/video/uvesafb.c b/drivers/video/uvesafb.c
> index d428445..04c4742 100644
> --- a/drivers/video/uvesafb.c
> +++ b/drivers/video/uvesafb.c
> @@ -1957,6 +1957,10 @@ static int uvesafb_init(void)
> =20
>  	if (fb_get_options("uvesafb", &option))
>  		return -ENODEV;
> +	if (!option || !*option)
> +		/* if vesafb is enabled, this will make possible to fallback to it *=
/
> +		return -ENODEV;
> +
>  	uvesafb_setup(option);
>  #endif
>  	err =3D cn_add_callback(&uvesafb_cn_id, "uvesafb", uvesafb_cn_callbac=
k);
>=20

I'm not familiar with vesa fbs, so I'd like to hear from other people if
this change is ok. Cc'd a bunch of random people from git log.
Reviewed-by, tested-by, acked-by from anyone?

 Tomi



--Tb1aok9802nFlesASsrNFxIx5vewXhdkg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTbKi0AAoJEPo9qoy8lh71mIEP/iOJPjovPmaK9r+P1Lj32hyZ
HXT0XWsbFEwmu8YeQ/mpmnM64E6STyja+r1SxN2UPxwoJItmI3WLIO6GIKLloR6N
vTx/NvkE3o78VYtZLpljpP96S89cRUpRR6rE3nMAObO+8MVm14IKH6MJoL5Cf66L
DeGkI2K40lu3+cNLkn3QzI9ayUb60EWQfjZC87wGepf1zBo9EkVlW/iOnUz1ngOC
PJb4i8Ey3ICOyo9WfVMrqF+4vDcf6Qec2h5fOHca7ccq2jVQIfsBq7QI/+qz4uBB
dXbst7WAHg8CG2menIltjiPSulloN5qXgK25Gk/IGM6pbXR9nsvoJ6c+rS9IWhZs
yvWzvxoQ19Lc2YzMR5NP8z/j6NMiK7N0Ev0Fppf2boegnIpsnSg44pWbm3waX64L
aN8CU/hA2meE3N/0bpsAza8IzjH55llZoxNlFRjHgkunG0bBhevaMYUTyVhQbDvj
IjthE56UlkfNW79FoehhvTiXhC2dUUNzoGrMlcZ7IatgDjdNdELQu+Qnla/5XHFG
8gfsbAg8d6ZfaERErdowvIxbYe3r3TdBbwA1qmvUCTGP9KNJAuL3QTH7EVS3FaTT
AeD+/NRtddJGEmHk88GE+C9kU9ChsUf6xqf8sy1m/ocfi+ztlQmgFqNTW5FTzzzs
8akos3yApuYrgHbl7n3t
=NdaZ
-----END PGP SIGNATURE-----

--Tb1aok9802nFlesASsrNFxIx5vewXhdkg--
