From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 20 Feb 2015 12:12:12 +0000
Subject: Re: [PATCH] video: ARM CLCD: Add missing error check for devm_kzalloc
Message-Id: <54E7249C.8050006@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="qow35mdNAIohDJv4JDGNgL2cVxCmF8L56"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423647406-858-1-git-send-email-kiran.padwal@smartplayin.com>
In-Reply-To: <1423647406-858-1-git-send-email-kiran.padwal@smartplayin.com>
To: Kiran Padwal <kiran.padwal@smartplayin.com>
Cc: Russell King <linux@arm.linux.org.uk>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Kiran Padwal <kiran.padwal21@gmail.com>

--qow35mdNAIohDJv4JDGNgL2cVxCmF8L56
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11/02/15 11:36, Kiran Padwal wrote:
> This patch add a missing check on the return value of devm_kzalloc,
> which would cause a NULL pointer dereference in a OOM situation.
>=20
> Signed-off-by: Kiran Padwal <kiran.padwal@smartplayin.com>
> ---
>  drivers/video/fbdev/amba-clcd.c |    3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/amba-clcd.c b/drivers/video/fbdev/amba=
-clcd.c
> index 32c0b6b..9362424 100644
> --- a/drivers/video/fbdev/amba-clcd.c
> +++ b/drivers/video/fbdev/amba-clcd.c
> @@ -599,6 +599,9 @@ static int clcdfb_of_get_mode(struct device *dev, s=
truct device_node *endpoint,
> =20
>  	len =3D clcdfb_snprintf_mode(NULL, 0, mode);
>  	name =3D devm_kzalloc(dev, len + 1, GFP_KERNEL);
> +	if (!name)
> +		return -ENOMEM;
> +
>  	clcdfb_snprintf_mode(name, len + 1, mode);
>  	mode->name =3D name;
> =20
>=20

Thanks, queued for 3.20.

 Tomi



--qow35mdNAIohDJv4JDGNgL2cVxCmF8L56
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU5yScAAoJEPo9qoy8lh71a/IP/1NujYjwom4a1xex8pPS92eC
VqGsyWxG6oD+fR50qzCzGWohNC+YrCYGJdtOGgXHR9tpgj0a4QCl4LqvozYuK64C
WZXyefvY73Ennj0Lfk01+lG5qekn3aqcXUkgBU5Y/d/WQyxFirGidc01XHSxnovM
xVA8OCkHXvxqEtj9Vuti4S+Yh7PBvPrv21ymXUK7UDPBBL6DTuRhgk7E815s4liO
nQUHI0c/syK7IkLuIyZLQ39SV+xCNnSzmbZBl0Z7cQIE9GKHi4qYx9aE4mjbPG3n
eReBxs7YIbnBF428SjwGtU7zST5aFvmKq3vDjIi0BR+vFLeJAWq3l1GGIXuT5giN
O0JdIywSN5Ic8YBebdIPoB5UZ3LbuhnTa0kbw6WDac9ZiIqPiXMg7lvqCgqBLtcx
2Admt6DvkmHRX7PE9lw85NzYz0V0u/vkLrduUokmT+Jh1j105oYZAgKrpR1/3lAP
o/jBlsgl5cFYPGNFXSovDm8JEfSyvipybe6tmF6Jppg6xLWTo71gOZZcGnGK9wMQ
3ck560MZiFMDc8CxOs6x2sRiv0OTCZwVGvI0uk6hdg0LIE5FkYGnNA2nwraQQuMi
9l0RVaVhUytDAaYMNqc519m2pIg0myMOW32AzMYeeOHvUQDtWZKdg2b1QdAzT/LW
Rex9Z25LkAWqrJUwMRiz
=DkPh
-----END PGP SIGNATURE-----

--qow35mdNAIohDJv4JDGNgL2cVxCmF8L56--
