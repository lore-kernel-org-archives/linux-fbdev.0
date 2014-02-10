From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 10 Feb 2014 12:05:37 +0000
Subject: Re: [PATCH] video: imxfb: Use regulator API with LCD class for powering
Message-Id: <52F8C091.50704@ti.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="E35IiM21jvwfwRI5paXla5katMaacGvVB"
List-Id: <linux-fbdev.vger.kernel.org>
References: <1387624080-15312-1-git-send-email-shc_work@mail.ru>
In-Reply-To: <1387624080-15312-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org

--E35IiM21jvwfwRI5paXla5katMaacGvVB
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 21/12/13 13:08, Alexander Shiyan wrote:
> This patch replaces custom lcd_power() callback with
> regulator API over LCD class.
>=20
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
> ---
>  .../devicetree/bindings/video/fsl,imx-fb.txt       |  1 +
>  arch/arm/mach-imx/mach-mx27ads.c                   | 55 ++++++++++++++=
+--
>  drivers/video/imxfb.c                              | 71 ++++++++++++++=
+++++---
>  include/linux/platform_data/video-imxfb.h          |  1 -
>  4 files changed, 114 insertions(+), 14 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt b/D=
ocumentation/devicetree/bindings/video/fsl,imx-fb.txt
> index 46da08d..e6b1ee9 100644
> --- a/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> +++ b/Documentation/devicetree/bindings/video/fsl,imx-fb.txt
> @@ -15,6 +15,7 @@ Required nodes:
>  	- fsl,pcr: LCDC PCR value
> =20
>  Optional properties:
> +- lcd-supply: Regulator for LCD supply voltage.
>  - fsl,dmacr: DMA Control Register value. This is optional. By default,=
 the
>  	register is not modified as recommended by the datasheet.
>  - fsl,lscr1: LCDC Sharp Configuration Register value.
> diff --git a/arch/arm/mach-imx/mach-mx27ads.c b/arch/arm/mach-imx/mach-=
mx27ads.c
> index 9821b824..a7a4a9c 100644
> --- a/arch/arm/mach-imx/mach-mx27ads.c
> +++ b/arch/arm/mach-imx/mach-mx27ads.c
> @@ -21,6 +21,10 @@
>  #include <linux/mtd/physmap.h>
>  #include <linux/i2c.h>
>  #include <linux/irq.h>
> +
> +#include <linux/regulator/fixed.h>
> +#include <linux/regulator/machine.h>
> +
>  #include <asm/mach-types.h>
>  #include <asm/mach/arch.h>
>  #include <asm/mach/time.h>
> @@ -195,14 +199,58 @@ static const struct imxi2c_platform_data mx27ads_=
i2c1_data __initconst =3D {
>  static struct i2c_board_info mx27ads_i2c_devices[] =3D {
>  };
> =20
> -void lcd_power(int on)
> +static void vgpio_set(struct gpio_chip *chip, unsigned offset, int val=
ue)
>  {
> -	if (on)
> +	if (value)
>  		__raw_writew(PBC_BCTRL1_LCDON, PBC_BCTRL1_SET_REG);
>  	else
>  		__raw_writew(PBC_BCTRL1_LCDON, PBC_BCTRL1_CLEAR_REG);
>  }
> =20
> +static int vgpio_dir_out(struct gpio_chip *chip, unsigned offset, int =
value)
> +{
> +	return 0;
> +}
> +
> +#define MX27ADS_LCD_GPIO	(6 * 32)
> +
> +static struct regulator_consumer_supply mx27ads_lcd_regulator_consumer=
 =3D
> +	REGULATOR_SUPPLY("lcd", "imx-fb.0");
> +
> +static struct regulator_init_data mx27ads_lcd_regulator_init_data =3D =
{
> +	.constraints	=3D {
> +		.valid_ops_mask	=3D REGULATOR_CHANGE_STATUS,
> +},
> +	.consumer_supplies	=3D &mx27ads_lcd_regulator_consumer,
> +	.num_consumer_supplies	=3D 1,
> +};
> +
> +static struct fixed_voltage_config mx27ads_lcd_regulator_pdata =3D {
> +	.supply_name	=3D "LCD",
> +	.microvolts	=3D 3300000,
> +	.gpio		=3D MX27ADS_LCD_GPIO,
> +	.init_data	=3D &mx27ads_lcd_regulator_init_data,
> +};
> +
> +static void __init mx27ads_regulator_init(void)
> +{
> +	struct gpio_chip *vchip;
> +
> +	vchip =3D kzalloc(sizeof(*vchip), GFP_KERNEL);
> +	vchip->owner		=3D THIS_MODULE;
> +	vchip->label		=3D "LCD";
> +	vchip->base		=3D MX27ADS_LCD_GPIO;
> +	vchip->ngpio		=3D 1;
> +	vchip->direction_output	=3D vgpio_dir_out;
> +	vchip->set		=3D vgpio_set;
> +	gpiochip_add(vchip);
> +
> +	platform_device_register_data(&platform_bus, "reg-fixed-voltage",
> +				      PLATFORM_DEVID_AUTO,
> +				      &mx27ads_lcd_regulator_pdata,
> +				      sizeof(mx27ads_lcd_regulator_pdata));
> +}
> +

Hmm, isn't all this something that should be in the board's .dts?

 Tomi



--E35IiM21jvwfwRI5paXla5katMaacGvVB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBAgAGBQJS+MCRAAoJEPo9qoy8lh71JvgP/RoSrqXsgTGDqqb2jgdqZGWE
iyI3o4tYidCgYEQlQRMo7Nl+67+8gmpsNXu64EM9Hy0uhYeeDIo5exwbBLiCZYC8
svSm1QYIxvuqss1jovJ8ftKuDkENmi8eda5B6mgWWr7kadWmTAQ7wXsiQcR/Xv5k
l7XPTw5Ylq/4wnemvwRhtQHrzdEkym7X0XYB4N22CBtLOPHV9liGvGZPlqA08W5L
l6RuugFRrslDN5oZiBkfqlQNPafxuCeuK1VF9ZTOZ6v3beMxGRu2vlOwit2qtwCC
n0XqwDaHDeOU4rAA0Laohvg2WRtI0lzHsr7h3ZwgvNwp2Yhk8IoYwMTEFY3R1hrD
XVqDIjE++cQIBISjPI3gvXmsfn3PBxAbwkb34nyLZgm4hflKcRo2oDcs4W7m/ntO
p49bzIufF28XG+8NPYJk4offbmtDscpcIR8JJkpFJ+xOyRlbM24QAhDyVPrryLYa
UCbEEmhZm25FXsIKNFm3xuOoyTAU0/MvcciYTfW0ihxVudcO6yoJcCJdPWivUCPG
Yj9CpofT2uyS6FJtCePZklbs0GJPZLzoZ+ERwXQ6ejRNRHnCuyB93WdvoZ6ii4C9
NxzyNtQfS0M+l//poxGZpd2wPSJvvbrGz09VDejPQs0a+1tXYPQHEcYrWHawL/4e
BjgFhFetsPuATEXnPlNz
=hS66
-----END PGP SIGNATURE-----

--E35IiM21jvwfwRI5paXla5katMaacGvVB--
