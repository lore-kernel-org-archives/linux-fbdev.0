From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Date: Wed, 11 Feb 2015 18:01:59 +0000
Subject: Odp: [PATCH 1/4] tridentfb: fix hang on Blade3D with CONFIG_CC_OPTIMIZE_FOR_SIZE
Message-Id: <54db991773b425.52528287@wp.pl>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Ondrej Zary <linux@rainbow-software.org>
Cc: linux-fbdev@vger.kernel.org, Kernel development list <linux-kernel@vger.kernel.org>

Acked-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Dnia Sobota, 7 Lutego 2015 21:53 Ondrej Zary <linux@rainbow-software.org> n=
apisa=B3(a)=20
> When the kernel is compiled with -Os (CONFIG_CC_OPTIMIZE_FOR_SIZE), tride=
ntfb
> hangs the machine upon load with Blade3D cards unless acceleration is dis=
abled.
>=20
> This is caused by memcpy() which copies data byte-by-byte (rep movsb) when
> compiled with -Os. The card does not like that - it requires 32-bit acces=
s.
>=20
> Use iowrite_32() instead.
>=20
> Signed-off-by: Ondrej Zary <linux@rainbow-software.org>
> ---
>  drivers/video/fbdev/tridentfb.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/tridentfb.c b/drivers/video/fbdev/triden=
tfb.c
> index 7ed9a22..7429713 100644
> --- a/drivers/video/fbdev/tridentfb.c
> +++ b/drivers/video/fbdev/tridentfb.c
> @@ -226,7 +226,7 @@ static void blade_image_blit(struct tridentfb_par *pa=
r, const char *data,
>  	writemmr(par, DST1, point(x, y));
>  	writemmr(par, DST2, point(x + w - 1, y + h - 1));
> =20
> -	memcpy(par->io_virt + 0x10000, data, 4 * size);
> +	iowrite32_rep(par->io_virt + 0x10000, data, size);
>  }
> =20
>  static void blade_copy_rect(struct tridentfb_par *par,
> --=20
> Ondrej Zary



