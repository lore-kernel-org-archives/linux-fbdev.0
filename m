From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 29 Feb 2016 16:12:45 +0000
Subject: Re: [PATCH v2] video: exynos: fix modular build
Message-Id: <56D46DFD.6090706@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="cmpMNOOl0mkiQVIMi5SrmjX9GsRAQ1JqX"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1456490307-823812-1-git-send-email-arnd@arndb.de>
In-Reply-To: <1456490307-823812-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org

--cmpMNOOl0mkiQVIMi5SrmjX9GsRAQ1JqX
Content-Type: multipart/mixed; boundary="3DGaVpHrLiXEvAJ6BLRw6RarGVMtiASkf"
From: Tomi Valkeinen <tomi.valkeinen@ti.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-arm-kernel@lists.infradead.org, Paul Bolle <pebolle@tiscali.nl>,
 Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>,
 Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski
 <k.kozlowski@samsung.com>, Inki Dae <inki.dae@samsung.com>,
 Donghwa Lee <dh09.lee@samsung.com>, Kyungmin Park
 <kyungmin.park@samsung.com>, linux-fbdev@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Message-ID: <56D46DFD.6090706@ti.com>
Subject: Re: [PATCH v2] video: exynos: fix modular build
References: <1456490307-823812-1-git-send-email-arnd@arndb.de>
In-Reply-To: <1456490307-823812-1-git-send-email-arnd@arndb.de>

--3DGaVpHrLiXEvAJ6BLRw6RarGVMtiASkf
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 26/02/16 14:38, Arnd Bergmann wrote:
> The s6e8ax0 driver has a dependency on BACKLIGHT_CLASS_DEVICE,
> which can be configured as a loadable module, so we have to
> make the driver a tristate symbol as well, to avoid this error:
>=20
> drivers/built-in.o: In function `s6e8ax0_probe':
> :(.text+0x23a48): undefined reference to `devm_backlight_device_registe=
r'

If a 'bool' Kconfig option depends on BACKLIGHT_CLASS_DEVICE, shouldn't
the Kconfig dependency take care of having BACKLIGHT_CLASS_DEVICE as
built-in?

> This also means we get another error from a missing export, which
> this fixes as well:
>=20
> ERROR: "exynos_mipi_dsi_register_lcd_driver" [drivers/video/fbdev/exyno=
s/s6e8ax0.ko] undefined!
>=20
> The drivers are all written to be loadable modules already,
> except the Kconfig options for that are missing, which makes
> the patch really easy.

Looks and sound fine, except doesn't this tell that the drivers have
never been tested as modules? Did you or someone else actually test these=
?

> diff --git a/drivers/video/fbdev/exynos/Makefile b/drivers/video/fbdev/=
exynos/Makefile
> index b5b1bd228abb..02d8dc522fea 100644
> --- a/drivers/video/fbdev/exynos/Makefile
> +++ b/drivers/video/fbdev/exynos/Makefile
> @@ -2,6 +2,8 @@
>  # Makefile for the exynos video drivers.
>  #
> =20
> -obj-$(CONFIG_EXYNOS_MIPI_DSI)		+=3D exynos_mipi_dsi.o exynos_mipi_dsi_=
common.o \
> -				     	exynos_mipi_dsi_lowlevel.o
> +obj-$(CONFIG_EXYNOS_MIPI_DSI)		+=3D exynos-mipi-dsi-mod.o
> +
> +exynos-mipi-dsi-mod-objs		+=3D exynos_mipi_dsi.o exynos_mipi_dsi_commo=
n.o \
> +					   exynos_mipi_dsi_lowlevel.o

Hmm, why is this makefile change needed?

 Tomi


--3DGaVpHrLiXEvAJ6BLRw6RarGVMtiASkf--

--cmpMNOOl0mkiQVIMi5SrmjX9GsRAQ1JqX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1G39AAoJEPo9qoy8lh712JgP/jYTWjUEW3L6dDEiIXtE2PMZ
dWfLn9sv0wCobfT9p7fnAPd3rJXKQxDZt7tAUx22jyZKi1W1HpyPYxKvOhWL0nyA
DU3sWF+6AGM+yGl1pZdXTRT3hNQbFUpmVWYQY7Be9okW5KWnXvaFeSFlEiYooZc1
1wZUiRIvI94RjrfZP/oszM34nqn/v/eQfontrmceyDFhJ656EdciCwCKXhNt6pYP
yDoOFYkQke9Vn3q0nkZh9RwS5n+lzOiMKuL21Ko9rNgEKoPQ1cMbw65ibnr/f77B
dqENn44pjMDmBP0ryn0/fZgA/HtlR0oZqh3AJa0EJbEWvk4E1kCB/QDGGZlLZFIr
YVaZ/Zm9F4lM/gbdM2LP/MPArxZ60U8cF3hFXRs34vdRQEkfF5Ijidn0aDALs9ki
DA7M/q/lCsVtGrmyG7c7VJmpMbvAjFulNDTJ9xKN/b8uNLLQkwwgRUq4V/7MUJd+
ljFYl5jyShhEQkET+bTJx1TxKFkJShFW+h92Rg77epltJ6BKQCM/5TIOePbKj1nK
ToRxtxZM35IcuEszbI8dnDGEdIOFI+7r7lO17IF+dGICVR0Rd9splxeubTstG+MT
WxmiuDbORw05q2ispnHvThQsNgG63RDNn6qs3yWl15TBJI9e7jFUY58OEzX/rth5
F6+bR+iCDaBggwCbnG08
=zXn8
-----END PGP SIGNATURE-----

--cmpMNOOl0mkiQVIMi5SrmjX9GsRAQ1JqX--
