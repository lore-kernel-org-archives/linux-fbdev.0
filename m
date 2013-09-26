From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 26 Sep 2013 12:34:08 +0000
Subject: Re: [PATCH] video: mxsfb: Add missing break
Message-Id: <524429C0.2020907@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="55go85ccXKt20AxIEuKb3HUWBX4xbrDBs"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1380194038-5148-1-git-send-email-marex@denx.de>
In-Reply-To: <1380194038-5148-1-git-send-email-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org

--55go85ccXKt20AxIEuKb3HUWBX4xbrDBs
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 26/09/13 14:13, Marek Vasut wrote:
> Add missing break into the restore function.
>=20
> Signed-off-by: Marek Vasut <marex@denx.de>
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
> ---
>  drivers/video/mxsfb.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/video/mxsfb.c b/drivers/video/mxsfb.c
> index d250ed0..27197a8 100644
> --- a/drivers/video/mxsfb.c
> +++ b/drivers/video/mxsfb.c
> @@ -620,6 +620,7 @@ static int mxsfb_restore_mode(struct mxsfb_info *ho=
st)
>  		break;
>  	case 3:
>  		bits_per_pixel =3D 32;
> +		break;
>  	case 1:
>  	default:
>  		return -EINVAL;
>=20

Thanks, queued for 3.12 fixes.

 Tomi



--55go85ccXKt20AxIEuKb3HUWBX4xbrDBs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSRCnAAAoJEPo9qoy8lh71lnUQAJBnLSu2gcJewvcGLG1Wa37+
5GmwG83bhVvGdU/GjA92wxnJiGJPiKaAFL8frY3MOhLAa9OjmV8OUA6d0duc/ksU
S6jLIfENvC0eF5t+cXJfwZhOekbB+NnLMN5ZbJyURN5BMu5liLc39tx4tHGRgnXY
akoYvUFM2BaYm6hbfcH+LEXXSaoFWD1YXdZIYszSvtBkxlvfN1p050L2DKPDIL1j
I80uIyj/LX2mzG8bcURRpu9gFZ6s4mYYmaOVICKG+u8VQ3fpf0SQD5N9C1i7hDfZ
EwtfIzMCt3MgTG+L5Nxec/6S1s4o30vfyoRz3zTqGEId1xKbhCEp2+io2YOmE3xb
RxFJyp7kt/IX8MYhXI0D9YmDkOYyDbTIvUTWmt4JU8MUuIcjeLLLZiCzUigrz2pz
4832diMpdEkhIXri9J9nT0wsFyz43uB+Rzw2ricKWxMIG0ouDvPvpTze4FPJ+VMS
83higLD7JHo/hoJZuV5NYl4bA51EUacMmv4A6DAPA+hnWuE6sUndiEDbLWjv3rR0
A5ir9v0xWnj2DJcaiIdJ8fZuHsBWKAr1wZ2W7C7BgwyeoYNUlILd26DVeU64exyX
CFuMwUTu+a4+7SnxD23zrHrfeh04oZNtq8PRjeuD+ntZJckbb4Y/8APMdKBMZZHF
SjxVwpn6VwRP+FgCsA+N
=/6mZ
-----END PGP SIGNATURE-----

--55go85ccXKt20AxIEuKb3HUWBX4xbrDBs--
