From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 26 Jun 2013 09:39:24 +0000
Subject: Re: [PATCH 06/23] video: da8xx-fb: store clk rate even if !CPUFREQ
Message-Id: <51CAB6CC.1050707@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----enig2OQQWIOFLMDAHUXMAVDUH"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1372170171-9561-7-git-send-email-detheridge@ti.com>
In-Reply-To: <1372170171-9561-7-git-send-email-detheridge@ti.com>
To: linux-fbdev@vger.kernel.org

------enig2OQQWIOFLMDAHUXMAVDUH
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 25/06/13 17:22, Darren Etheridge wrote:
> From: Afzal Mohammed <afzal@ti.com>
>=20
> store lcd clk rate always, i.e. irrespective of whether CPUFREQ is
> enabled or not. This can be used to get clk rate directly instead of
> enquiring with clock framework with clk handle every time.
>=20
> Signed-off-by: Afzal Mohammed <afzal@ti.com>
> Signed-off-by: Darren Etheridge <detheridge@ti.com>
> ---
>  drivers/video/da8xx-fb.c |    4 +---
>  1 files changed, 1 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
> index d060f14..f1d88ac 100644
> --- a/drivers/video/da8xx-fb.c
> +++ b/drivers/video/da8xx-fb.c
> @@ -174,8 +174,8 @@ struct da8xx_fb_par {
>  	unsigned int		which_dma_channel_done;
>  #ifdef CONFIG_CPU_FREQ
>  	struct notifier_block	freq_transition;
> -	unsigned int		lcd_fck_rate;
>  #endif
> +	unsigned int		lcd_fck_rate;

The naming related to this clock is quite confusing. There's
lcd_fck_rate, fb_clk and lcdc_clk, all of which refer to the same clock
as far as I understand.

 Tomi



------enig2OQQWIOFLMDAHUXMAVDUH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJRyrbPAAoJEPo9qoy8lh71yqcP/2gwItilPRAEIRVrhaDzSnWz
q49h/V41ZRFnHEsjIRsSK3ufFeJ2gjvmKyG6JxRBr8Vbpa0VqqkeBRMAr77jHvma
6kfZkKJncfsGTayjV7IN2l2fFermkTyu9Aewdsol2KCNjQxBndP/loRrzZs6k1NL
oe2Y2+ylwbeXWcL8azrKBorMQVr83107oSMO1jDP1MmuSHst1gsk9kUBuqkmM40z
C3njNVKDCUI9vFTf4lV0nl+ZPU4M9T7yG55aHdAhZ7FOwoMZpKxAT8oIfbm+NHbG
ppk1X1zUjTCwt2RWcl6zEk4WdFN5vloHf+9bHI/YPujSPeUq/FyiyPBYdOSZ2hAU
VHzR8jNHdqbFi2wQHm7okG72i6z5tkNuGJQHQug/QCyDDTmvEIsmPiRiAwB57RgS
FPprL0bV4b1IbVXQUY0QruocZApJsxZ4uQmfZldjMr3Tqv0VXWiq1yMUuUbSCP7B
bWrvJ1WXJy2a4C60+rHeSao5AMw0inn0cywpmS2/RSY3mgKjOePFwRqXrLK3OCb7
cUQuGIcR8H3iUPCekj2rs70EEyjgxl+8U6jXNA6lB3nsNPMxXRtSKnOmcyuxJBqZ
M97z0vCaXjmenuIJm+JU9S0VsmS4BoX4uUMMqAf/f5sI8Rcf97Fur1MX3byv/8yZ
AnY6Sl/kpRRsp6hNnO4x
=Z4Hx
-----END PGP SIGNATURE-----

------enig2OQQWIOFLMDAHUXMAVDUH--
