From: Maxime Ripard <maxime.ripard@free-electrons.com>
Date: Mon, 06 Oct 2014 08:55:36 +0000
Subject: Re: [PATCH v2 5/5] simplefb: add clock handling code
Message-Id: <20141006085536.GD4090@lukather>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="tEFtbjk+mNEviIIX"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1412337125-14388-1-git-send-email-hdegoede@redhat.com>
 <1412337125-14388-6-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1412337125-14388-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Oct 03, 2014 at 01:52:05PM +0200, Hans de Goede wrote:
> From: Luc Verhaegen <libv@skynet.be>
>=20
> This claims and enables clocks listed in the simple framebuffer dt node.
> This is needed so that the display engine, in case the required clocks
> are known by the kernel code and are described in the dt, will remain
> properly enabled.
>=20
> Signed-off-by: Luc Verhaegen <libv@skynet.be>
> [hdegoede@redhat.com: drop dev_err on kzalloc failure]
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> ---
>  drivers/video/fbdev/simplefb.c | 100 +++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 98 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplef=
b.c
> index b7d5c08..f329cc1 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -26,6 +26,7 @@
>  #include <linux/module.h>
>  #include <linux/platform_data/simplefb.h>
>  #include <linux/platform_device.h>
> +#include <linux/clk-provider.h>
> =20
>  static struct fb_fix_screeninfo simplefb_fix =3D {
>  	.id		=3D "simple",
> @@ -165,8 +166,98 @@ static int simplefb_parse_pd(struct platform_device =
*pdev,
>  	return 0;
>  }
> =20
> +/*
> + * Clock handling code.
> + *
> + * Here we handle the clocks property of our "simple-framebuffer" dt nod=
e.
> + * This is necessary so that we can make sure that any clocks needed by
> + * the display engine that the bootloader set up for us (and for which it
> + * provided a simplefb dt node), stay up, for the life of the simplefb
> + * driver.
> + *
> + * When the driver unloads, we cleanly disable, and then release the clo=
cks.
> + */
> +struct simplefb_clock {
> +	struct list_head list;
> +	struct clk *clock;
> +};
> +
> +/*
> + * We only complain about errors here, no action is taken as the most li=
kely
> + * error can only happen due to a mismatch between the bootloader which =
set
> + * up simplefb, and the clock definitions in the device tree. Chances are
> + * that there are no adverse effects, and if there are, a clean teardown=
 of
> + * the fb probe will not help us much either. So just complain and carry=
 on,
> + * and hope that the user actually gets a working fb at the end of thing=
s.
> + */
> +static void
> +simplefb_clocks_init(struct platform_device *pdev, struct list_head *lis=
t)
> +{
> +	struct device_node *np =3D pdev->dev.of_node;
> +	int clock_count, i;
> +
> +	INIT_LIST_HEAD(list);
> +
> +	if (dev_get_platdata(&pdev->dev) || !np)
> +		return;
> +
> +	clock_count =3D of_clk_get_parent_count(np);

This looks like it does what you expect, but its name and the fact
that it's in the clk-provider.h file makes me wonder if you're not
using the wrong side of the abstraction.

> +	for (i =3D 0; i < clock_count; i++) {
> +		struct simplefb_clock *entry;
> +		struct clk *clock =3D of_clk_get(np, i);

devm_clk_get?

> +		int ret;
> +
> +		if (IS_ERR(clock)) {
> +			dev_err(&pdev->dev, "%s: clock %d not found: %ld\n",
> +			       __func__, i, PTR_ERR(clock));
> +			continue;
> +		}
> +
> +		ret =3D clk_prepare_enable(clock);
> +		if (ret) {
> +			dev_err(&pdev->dev,
> +				"%s: failed to enable clock %d: %d\n",
> +			       __func__, i, ret);
> +			clk_put(clock);
> +			continue;
> +		}
> +
> +		entry =3D kzalloc(sizeof(struct simplefb_clock), GFP_KERNEL);
> +		if (!entry) {
> +			clk_disable_unprepare(clock);
> +			clk_put(clock);
> +			continue;
> +		}
> +
> +		entry->clock =3D clock;
> +		/*
> +		 * add to the front of the list, so we disable clocks in the
> +		 * correct order.
> +		 */
> +		list_add(&entry->list, list);

I really don't think this whole list dance is necessary, especially
after reading this comment.=20

It doesn't make any sense to release the clock in a particular order,
when you don't even know in what order the bootloader actually set
them (and you haven't set any requirement on the order in the binding
either). For all you know, this could be a purely random order,
without any meaning, and it would be fine, so let's just not worry
about that.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJUMlkIAAoJEBx+YmzsjxAgXxQP+wbX0ldu5pJbKLFNpqrfpFf6
ACMHtyqcEt1g62X9UdploY+Yw9fIBl2G8rTGK2CEc3F1RwZ2mApRrDDJxXjsonu8
WZU5DxoX1ti1VF9dO6ajfHYrnfw4StEr6HJ2rvt83zkEhveOfyIK3rjNAfMLiBFP
G0wJeqlLyXklU2FumJc9Hh174OAaZk26Xp6r/62+gsSIUr7cjUs23mOp+DRWu6Wh
WPwqtMB7H6/xH4RG46enG6WUJ6jJSj2qHsqWCxL1aIrq4TqZ8ZSS9Z0/G/WTNGZj
MQXgkAaFHI86tt7yYjlO+GR1FJhWQwnlDg9CJ1z4Nif8PSf5ZB82ndFV4pCjdzWJ
9Mbz/4R4JELjM7jsGzLJ4Gm31/E02DcrmOoTDmKCghmF9ogL6VVB0e3Wt4gM5vj5
WwstA+wlefKAjkXIEk/ek5CEcVBlELKrsJviFTTbcmY61paybnfDkmw2AE08LKe1
6Kf6xa4W6VPRCVcG0J+cuiblrPO2/D0KCNlrLVIABqqAjDXWHG3UzCu9VC9oS1dA
q8DVggA2zoqKj+NolYJgZxy8RvbCynLz8oO40cJ2J+WIRCXVNU7xCbaRw+gipn4e
Dp9eLls92cDrnD6D21rj+QL8QaZYzi+1KEe2B+c1NerBc+8HpKXzo5bTezmLwrpA
C8zCZ3RZSldXhxQoVf7S
=bhS5
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
