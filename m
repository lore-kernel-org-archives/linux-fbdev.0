From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Fri, 30 Aug 2013 07:18:12 +0000
Subject: Re: [PATCH v4 3/5] at91/avr32/atmel_lcdfb: prepare clk before calling enable
Message-Id: <52204734.3010603@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="WuI5vojmVFllWfuWGQHGawOUioAwiW00F"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1374132753-15206-1-git-send-email-b.brezillon@overkiz.com>
 <1374133225-19141-1-git-send-email-b.brezillon@overkiz.com>
In-Reply-To: <1374133225-19141-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org

--WuI5vojmVFllWfuWGQHGawOUioAwiW00F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 18/07/13 10:40, Boris BREZILLON wrote:
> Replace clk_enable/disable with clk_prepare_enable/disable_unprepare to=

> avoid common clk framework warnings.
>=20
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
> ---
>  drivers/video/atmel_lcdfb.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
> index ece49d5..bf9c5d0 100644
> --- a/drivers/video/atmel_lcdfb.c
> +++ b/drivers/video/atmel_lcdfb.c
> @@ -954,14 +954,14 @@ static int __init atmel_lcdfb_init_fbinfo(struct =
atmel_lcdfb_info *sinfo)
> =20
>  static void atmel_lcdfb_start_clock(struct atmel_lcdfb_info *sinfo)
>  {
> -	clk_enable(sinfo->bus_clk);
> -	clk_enable(sinfo->lcdc_clk);
> +	clk_prepare_enable(sinfo->bus_clk);
> +	clk_prepare_enable(sinfo->lcdc_clk);
>  }
> =20
>  static void atmel_lcdfb_stop_clock(struct atmel_lcdfb_info *sinfo)
>  {
> -	clk_disable(sinfo->bus_clk);
> -	clk_disable(sinfo->lcdc_clk);
> +	clk_disable_unprepare(sinfo->bus_clk);
> +	clk_disable_unprepare(sinfo->lcdc_clk);
>  }
> =20
>  #ifdef CONFIG_OF

Thanks, queued this for 3.12.

 Tomi




--WuI5vojmVFllWfuWGQHGawOUioAwiW00F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJSIEc0AAoJEPo9qoy8lh71PXUP/3Ge1kHOLDgMqeJDR1f/Nuxz
kGFfyHEEpol2A+wvWq0B7TmllmOFqAjobcjibEWDcvOz3unP/tT8tkCTdkWknqRc
QDEg7dFNuDWIRXEc9rYZPd98UOQ3GC/Q9hY3HJwF2dHCZRG4LReb4OB97vL7Pkvs
2fo3yheAfUKc/WvQdIyiYQpw7bNWEJNk/dB4LN+y8CcdgpU+H24P6IFY0IkR5Cve
BQAyDv/Pnv9+15NhDX6Y5crvfxpA3PXVWMhl6o1upKh4qGfm6BlGTcII1Qa/QRKQ
baFgpFj7xBvl3PguX1AbyEjdIYeNtsU6vRjUwt+jYxhT14sXuBXITRrrheHpLslj
lnhSQwVMimoavLRI9Z69VhJJ19Ln784V3Czzt55AD4ehAT8GD+PlYSqu3FKK7blB
bw4jizgaTTtQVBEwxirGF4Sp2Jl2rHDQr/hd3axNSPjWfoUWqTcTwvorLasg1P4y
Ot5LsjK3/p+rMiwF8WtH+di1UL/ygwtec7iXBwoSLgPDjg6QtnKy9HVyko96DWPK
BU4gIN7wwNuqBtPJKiOYXJLmxHF1Fj/xu0qrSb5KocY3yT/w2ojxNS1R2wR1X6Rb
ffMpSgPNL5pQfVGitpViblr63iwLjW0Zj7IWPgYKWEyxWVjJMLk4fQcwYt7ovWlE
Kd4cx6kXlhoFmBHvO2qo
=59U/
-----END PGP SIGNATURE-----

--WuI5vojmVFllWfuWGQHGawOUioAwiW00F--
