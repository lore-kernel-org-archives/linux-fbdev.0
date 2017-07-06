From: Thierry Reding <thierry.reding@gmail.com>
Date: Thu, 06 Jul 2017 06:42:15 +0000
Subject: Re: [PATCH] backlight: pwm_bl: make of_device_ids const
Message-Id: <20170706064215.GG16144@ulmo.fritz.box>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="S5HS5MvDw4DmbRmb"
List-Id: <linux-fbdev.vger.kernel.org>
References: <b9daeb15d40f6682803d8dafde3bc3dcb63909ff.1497940816.git.arvind.yadav.cs@gmail.com>
In-Reply-To: <b9daeb15d40f6682803d8dafde3bc3dcb63909ff.1497940816.git.arvind.yadav.cs@gmail.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: lee.jones@linaro.org, daniel.thompson@linaro.org, jingoohan1@gmail.com, b.zolnierkie@samsung.com, linux-pwm@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org


--S5HS5MvDw4DmbRmb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2017 at 01:22:15PM +0530, Arvind Yadav wrote:
> of_device_ids are not supposed to change at runtime. All functions
> working with of_device_ids provided by <linux/of.h> work with const
> of_device_ids. So mark the non-const structs as const.
>=20
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/video/backlight/pwm_bl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Acked-by: Thierry Reding <thierry.reding@gmail.com>

--S5HS5MvDw4DmbRmb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlld28cACgkQ3SOs138+
s6HWcQ//bcbYjBR/BpikStnKGl5UjCOgm/P1R9tBYEA7XvQdu8ga1WLZt7D4lO5a
yy1CGl9DOltfBp7wJOAUvgD1ZVlD+JaWRXoi6FODeZjUoJHpC/0F0lsQpzHsmANl
Ebg0DgBb4Abq9LsQkVRWdrZgeyXEOhqpkPZOSlmoMaJ0v5+ULXHy6Tm+z1wLTTRi
xkZSv1tVUxJSQfF706OHPoKK5X9d5kBbHrgMR9DYtc4aEDUflaN1gwIxq7My2vrY
3aLUzTNiuQJ3g0tYlxiWwlTAZIChn8cMQRbN5UxxpNAS5wvIRN1rkL6BzxCpIUS4
Joh1g23vpGmiGvTXzXxzHYpuoCC/8XvU1+gzLwbMy5ByVYBhDh3I4F5fI7fn+V99
xDbUAKBuxti578Kg8VXNI3acBH7euMGQeBTBMY5Kt1GxTLRX+PICu/g7Mh6UWTVZ
ahcLAorh+549LdtcoBVSYz/4xGBxFDAapk9lGotsYtIyb9v51prMmtIRsN0EofJc
7XQzuZu7quy77XJCRLwKBBSjoaOBKkt4j6s8Lse8/wKAN9ZjOrkjtVdynGoZ1+lt
BQq5Z/9lEWX/Lv0syZwd5P5BInB7Qo3GuEJW0b8AFW2Fa3VSm9uMMMPK/J/cGEnK
ff5/E0RJnbLiVmVMmLNzs90VE8Tevis9ylOdx3dtRMOULgFcSJo=
=wGob
-----END PGP SIGNATURE-----

--S5HS5MvDw4DmbRmb--
