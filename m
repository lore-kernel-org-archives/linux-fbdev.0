From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 16 Feb 2016 13:01:55 +0000
Subject: Re: [PATCH v2 2/3] fbdev: omap2: panel-dpi: make (limited) use of a reset gpio
Message-Id: <56C31DC3.3050605@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="lGQWi1BaEctv3xJiQtS8f8Hb0iQoh9ir3"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1450610002-10531-3-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1450610002-10531-3-git-send-email-u.kleine-koenig@pengutronix.de>
To: linux-fbdev@vger.kernel.org

--lGQWi1BaEctv3xJiQtS8f8Hb0iQoh9ir3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 20/12/15 13:13, Uwe Kleine-K=C3=B6nig wrote:
> Some displays have a reset input. To assert that the display is
> functional the reset gpio must be deasserted.
>=20
> Teach the driver to get and drive such a gpio accordingly.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> --
> Changes since (implicit) v1, sent with
> Message-Id: 1449753107-11410-4-git-send-email-uwe@kleine-koenig.org :
>=20
>  - never assert reset because there are too many different panels with
>    too many different needs for their reset.
>  - split out dt binding changes
>  - reword commit log

Please add these extra texts below the --- line below. Otherwise they
end up in the commit description.

> ---
>  drivers/video/fbdev/omap2/displays-new/panel-dpi.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>=20
> diff --git a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c b/drive=
rs/video/fbdev/omap2/displays-new/panel-dpi.c
> index e780fd4f8b46..201a1c1a6f42 100644
> --- a/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> +++ b/drivers/video/fbdev/omap2/displays-new/panel-dpi.c
> @@ -213,6 +213,16 @@ static int panel_dpi_probe_of(struct platform_devi=
ce *pdev)
> =20
>  	ddata->enable_gpio =3D gpio;
> =20
> +	/*
> +	 * Many different panels are supported by this driver and there are
> +	 * probably very different needs for their reset pins in regards to
> +	 * timing and order relative to the enable gpio. So for now it's just=

> +	 * ensured that the reset line isn't active.
> +	 */
> +	gpio =3D devm_gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);=

> +	if (IS_ERR(gpio))
> +		return PTR_ERR(gpio);
> +
>  	ddata->backlight_gpio =3D -ENOENT;
> =20
>  	r =3D of_get_display_timing(node, "panel-timing", &timing);
>=20


--lGQWi1BaEctv3xJiQtS8f8Hb0iQoh9ir3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWwx3DAAoJEPo9qoy8lh71Ho4QAK2HfS109lDZTpdvenhJ2zzH
5XOBgRB/4xTrhqBbvdYxscvtdVX1lND82lWzKx8IvVvSHdbP31LJ+rf4PcMGyvnA
oojxO91wk46JKR/hlriFLPUAbHMMrRN19xzsdWgm15+kioGbfOuizQYwPynm8IrW
1NMiCLtcbvWYYmSSueZ8G57NzhY3Wr2iVVPlOtpgnNi5ZuF54rDWGSvFgUjnZL4Q
OKv58DbVv7faaIzhXmikCNtrUKn3US4q5+cEYTQFN4+jIQliHpOebPHP6je+eapj
x70Qx1Z+16V2UglKSswEqN73YYbk+zTaKZZDf+Mw0ljjkuItXIP3zXBs6/Fk5Dmq
FfUDD/L7MNoA06xltVaVRemKS8aZu4bt53Z/aFg1/TcMypQ0EC+2Lw4AbsBd0eHX
XiZk3EGh9nZonn8rfqzCHAptauOlFyVf8S4VZ8Gpx8btkBw4RMuqbmUKmGWX+jNh
F25I25PubPJxaiPo+7yvVtttj2beigGXq/LEWV0i9Z1tLrpaZkV2oSsntsuPhFZT
OyqPlXMU/BmskMrqxUPWb3l7tiTPTkT8SPhFvGgRnvw5TATqfaNv0fspkGRE2iTI
6ksgeYTr2Tz3J8nAF9/aKh6LE9i/UwIKuB/tCo+e0W+iv/AAMZAGJdY+5O7vCtNY
oxEj0ofc9JFX4fTFCIva
=2uBc
-----END PGP SIGNATURE-----

--lGQWi1BaEctv3xJiQtS8f8Hb0iQoh9ir3--
