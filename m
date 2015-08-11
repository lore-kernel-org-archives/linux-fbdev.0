From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 11 Aug 2015 07:22:43 +0000
Subject: Re: [PATCH v2 09/11] fbdev: Allow compile test of GPIO consumers if !GPIOLIB
Message-Id: <55C9A2C3.1060001@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="Td6xgp8lmISjJ7wdrEbp3LetmkO5VJI8B"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1438506475-31012-1-git-send-email-geert@linux-m68k.org> <1438506593-31845-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1438506593-31845-1-git-send-email-geert@linux-m68k.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, linux-gpio@vger.kernel.org

--Td6xgp8lmISjJ7wdrEbp3LetmkO5VJI8B
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 02/08/15 12:09, Geert Uytterhoeven wrote:
> The GPIO subsystem provides dummy GPIO consumer functions if GPIOLIB is=

> not enabled. Hence drivers that depend on GPIOLIB, but use GPIO consume=
r
> functionality only, can still be compiled if GPIOLIB is not enabled.
>=20
> Relax the dependency on GPIOLIB if COMPILE_TEST is enabled, where
> appropriate.
>=20
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> v2:
>   - Add Acked-by.
> ---
>  drivers/video/fbdev/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
> index 2d98de535e0f7374..569803f533d1a600 100644
> --- a/drivers/video/fbdev/Kconfig
> +++ b/drivers/video/fbdev/Kconfig
> @@ -2464,7 +2464,7 @@ config FB_SSD1307
>  	tristate "Solomon SSD1307 framebuffer support"
>  	depends on FB && I2C
>  	depends on OF
> -	depends on GPIOLIB
> +	depends on GPIOLIB || COMPILE_TEST
>  	select FB_SYS_FOPS
>  	select FB_SYS_FILLRECT
>  	select FB_SYS_COPYAREA
>=20

Applied to 4.3 fbdev.

I do wonder why this is needed, though... I understand COMPILE_TEST if
the dependency in question is difficult/impossible to enable with your
kernel config (say, enabling OMAP SoC support with x86 config), but
isn't GPIOLIB something that can be trivially enabled in any kernel confi=
g?

 Tomi


--Td6xgp8lmISjJ7wdrEbp3LetmkO5VJI8B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVyaLDAAoJEPo9qoy8lh71lb8P/ROFNdTB6oY+en6/V0idJxJa
FMv8Me7JwTrUGCqpj1VXFCO9z3Il3csj46uthQjCjzM12gbjiboUZ0jAbdLPCd+W
RrwJ3vEDQm8DqatRfVxC16UAr8k5ij/Jrh8KfQheRjMCkJ6XcO5fULuksaZhtaKT
SO3lsrwgWC8NlVxMpZ3qbhutZP+ifrj7A9AM8Y8vlFIXWSAwKk89orZIwL1oXap2
n6L82XJs8S7vWVGstbPSrKjzTNKqMJ2ysv1/tZQ8YolXlJTww4X88NxLOordzfWP
GLvHxiPajkFkVdfmdSvz8jLSentdEzWIBuiD0ZfrL0yGz4p+NZlOybI29Fc6sIN1
j/UfxZZqSB+HVyeUfd0oKXHU5IWowPlkS3pc6cJeG0pgWqA3qFUcIVSP0RJFN2/5
X/SqAvfjuFkUw6KZ+mocAATS2EljNbx/IiCHntba3X8zKaDZLSYUz9SQQ66sY0t+
OUmenpdS5urCXt5lD8r5mIm92fzSLUzVLXDoODtrqPQ5ivrPF4hybcWfScsJKv96
KjQ+0YaH07bBbdj/pUAxcmxUD6RHy+NrYAXrm7vB/znr1/Ef00l9UByBFEYz1Vj5
Gkb4Jeeft0tVx5IGAHP9Eo0xsek1DXB2kYxYSES6N+Vf5tD+C3czhpxjDUn7y52Q
f93Vm4aH+OCH8ZH6AsBT
=kqiJ
-----END PGP SIGNATURE-----

--Td6xgp8lmISjJ7wdrEbp3LetmkO5VJI8B--
