From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 16 Feb 2016 13:36:12 +0000
Subject: Re: [PATCH 6/7] fbdev: exynos: fix IS_ERR_VALUE usage
Message-Id: <56C325CC.60808@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="LSM5hSrLrrvuQTACgqBJgEcX3uxEmu9Ec"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1455546925-22119-1-git-send-email-a.hajda@samsung.com>
 <1455546925-22119-7-git-send-email-a.hajda@samsung.com>
In-Reply-To: <1455546925-22119-7-git-send-email-a.hajda@samsung.com>
To: Andrzej Hajda <a.hajda@samsung.com>, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Inki Dae <inki.dae@samsung.com>, Donghwa Lee <dh09.lee@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, linux-fbdev@vger.kernel.org, linux-samsung-soc@vger.kernel.org

--LSM5hSrLrrvuQTACgqBJgEcX3uxEmu9Ec
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 15/02/16 16:35, Andrzej Hajda wrote:
> IS_ERR_VALUE macro should be used only with unsigned long type.
> For signed types comparison 'ret < 0' should be used.
>=20
> The patch follows conclusion from discussion on LKML [1][2].
>=20
> [1]: http://permalink.gmane.org/gmane.linux.kernel/2120927
> [2]: http://permalink.gmane.org/gmane.linux.kernel/2150581
>=20
> Signed-off-by: Andrzej Hajda <a.hajda@samsung.com>
> ---
>  drivers/video/fbdev/exynos/exynos_mipi_dsi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/exynos/exynos_mipi_dsi.c b/drivers/vid=
eo/fbdev/exynos/exynos_mipi_dsi.c
> index b527fe4..951b592 100644
> --- a/drivers/video/fbdev/exynos/exynos_mipi_dsi.c
> +++ b/drivers/video/fbdev/exynos/exynos_mipi_dsi.c
> @@ -402,12 +402,12 @@ static int exynos_mipi_dsi_probe(struct platform_=
device *pdev)
>  		goto error;
>  	}
> =20
> -	dsim->irq =3D platform_get_irq(pdev, 0);
> -	if (IS_ERR_VALUE(dsim->irq)) {
> +	ret =3D platform_get_irq(pdev, 0);
> +	if (ret < 0) {
>  		dev_err(&pdev->dev, "failed to request dsim irq resource\n");
> -		ret =3D -EINVAL;
>  		goto error;
>  	}
> +	dsim->irq =3D ret;
> =20
>  	init_completion(&dsim_wr_comp);
>  	init_completion(&dsim_rd_comp);
>=20

Thanks, queued for 4.6.

 Tomi


--LSM5hSrLrrvuQTACgqBJgEcX3uxEmu9Ec
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWwyXMAAoJEPo9qoy8lh71dJsP/i4pMtBpWtY1AyNrZjJ/zVcH
t22ClJkJ/4DTKiZPvKisGMEpF48hfxgWPzUkktypyqOY7rX6hag928rv2/VLqULb
WC3DXdvsdZ8R+jq7GmHd6bY7fx7qU9w51CkOcvsCKHCjo3qrHqaXfi15FPeKrNVZ
+47PqlPlccr03PQP6x4b0/d7wk0cUX4j2ANnxxQ+DhaTBQ3dGC7wF2X6v9rFl2XV
1BJR8yoOjXSNp0Znk5U5pjUhJnFRZ/JmoJVjniwD39FZRg9/st8KzPZ4EB7wmFJ5
GpX2iQFYwePvtImV8LSuXjEtt7j5oIcPKnT//9U+D9B2l7/gx6XGdnurnb8nQ5ie
+4Wgt/FavzSjWeZ//q31FfvKdi3VVs2QSZqb0CQSQ6QR0cAWoNZiMGyk5csWks/O
sco0eeENYTGG/JXHVtDk4K2LYdYfguS+rAtEG/TahaCn840t5Ob66lEO0avVZB9T
HTkWNrIHvbd2uPJkVNwWS9Rb2Q9G9fpqc250S6jtnIS0SWeODcJt/iIXyW2v+SG9
GDGY+KboA9Jyy7at/BfkXEINIMHiowQfF6HoyQmT6wePDpbif4vznnOedF9vYFGD
DqioeRXsPyXRgQGuVfYm1L+Dkxgux/0WwGoTTtbGOwWPf3gAD8rBq1oS29nhnY8g
rzH7Y3MEDfci8m8wH/GU
=Mcyz
-----END PGP SIGNATURE-----

--LSM5hSrLrrvuQTACgqBJgEcX3uxEmu9Ec--
