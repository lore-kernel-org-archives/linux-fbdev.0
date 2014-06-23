From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 23 Jun 2014 11:43:00 +0000
Subject: Re: [PATCH 1/1] video: omapdss: Fix potential null pointer dereference
Message-Id: <53A812C4.9020208@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Sp1HmKdeFCEwIOSLr9JfGnT9kagpoXwHJ"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1401445595-22884-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1401445595-22884-1-git-send-email-sachin.kamat@linaro.org>
To: linux-fbdev@vger.kernel.org

--Sp1HmKdeFCEwIOSLr9JfGnT9kagpoXwHJ
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 30/05/14 13:26, Sachin Kamat wrote:
> kmalloc can return null. Add a check to avoid potential null
> pointer dereference error when the pointer is accessed later.
>=20
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> ---
>  drivers/video/fbdev/omap2/dss/omapdss-boot-init.c |    8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c b/driver=
s/video/fbdev/omap2/dss/omapdss-boot-init.c
> index 99af9e88b2d8..2f0822ee3ff9 100644
> --- a/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c
> +++ b/drivers/video/fbdev/omap2/dss/omapdss-boot-init.c
> @@ -121,9 +121,11 @@ static void __init omapdss_add_to_list(struct devi=
ce_node *node, bool root)
>  {
>  	struct dss_conv_node *n =3D kmalloc(sizeof(struct dss_conv_node),
>  		GFP_KERNEL);
> -	n->node =3D node;
> -	n->root =3D root;
> -	list_add(&n->list, &dss_conv_list);
> +	if (n) {
> +		n->node =3D node;
> +		n->root =3D root;
> +		list_add(&n->list, &dss_conv_list);
> +	}
>  }
> =20
>  static bool __init omapdss_list_contains(const struct device_node *nod=
e)

Thanks, queued for 3.17.

 Tomi



--Sp1HmKdeFCEwIOSLr9JfGnT9kagpoXwHJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJTqBLEAAoJEPo9qoy8lh71S0wQAJt6NW0V/ZKvE/gClYEjJUvc
/X5xYsupPT2V4io3If8c3L/TIqanDUsBh+JoDZi/Taal3PwFH+eXiItm4PxPE34k
STMpMaRmM0qePh9KPSjw5wNhNS1Cu0IGi3NjZUlnX/Jn5FjD/0ZICoZAuuq/7CdB
7Hc9uYei2Bqw+kC1XIO+gxQeNMvCw8fbD218KCT+7dD8c6ND+26cVeSwoMmAmRgA
n2Z3Inm4W+xcLotVXnJjbpOfVGs9v/cnO+TDUUVRdRaESBvF15GXYDQelNquLGfB
Y4LLOBdaD6G9kb+1kWgsBYMp5myCD6X/GwpwGl5ee820Pz+rAWFOtdTW3UfK7mwQ
x9zC2AMQedWP3/fSzsUkNWNWWv9SPk3NmDsd8S/DlxpY3yftEFYe+MjMPnQOaXy7
q8ngNcvgSdTUEZbX3xkO7D02nmGPAnVqCzwzsCCpkdfuKGpC+HeZboj8mno0lDrj
ogIypaa+tHnVwYHCCvz9HPNJ5rDzh9QQWabP/YS7QT9GFt6sXxuneObgIKBADmu/
4yBundA3bnBZEG3O27KCF6CtTYMS9tbYSqhgDoshnr7L4/+dNXbF4Bi32hBJt/DA
TEjbkdvenkiijwoK6UpNR11VKFsqrbhyb69ZFCsSU+c6+2FwgMVZyUJwQO+RLeW4
RCsmB0OLjhSBgHM3rXRK
=2gtc
-----END PGP SIGNATURE-----

--Sp1HmKdeFCEwIOSLr9JfGnT9kagpoXwHJ--
