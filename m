From: Jun Nie <niej0001@gmail.com>
Subject: Re: [PATCH 5/6] pxa: add gpio expander on pxa168 aspenite platform
Date: Tue, 3 Nov 2009 15:30:54 +0800
Message-ID: <7c34ac520911022330i37cd4460j64b749267f4cbac7@mail.gmail.com>
References: <7c34ac520911022245l758dabfah85c6d68eae15e5c7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7c34ac520911022245l758dabfah85c6d68eae15e5c7@mail.gmail.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org, linux-fbdev-devel@lists.sourceforge.net, linux-fbdev@vger.kernel.org

2009/11/3 Jun Nie <niej0001@gmail.com>:
> pxa: add gpio expander on pxa168 aspenite platform
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> =A0arch/arm/mach-mmp/aspenite.c | =A0 45 ++++++++++++++++++++++++++++++++=
++++++++++
> =A0drivers/gpio/pca953x.c =A0 =A0 =A0 | =A0 =A01 +
> =A02 files changed, 46 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
> index 115f728..b422bb5 100644
> --- a/arch/arm/mach-mmp/aspenite.c
> +++ b/arch/arm/mach-mmp/aspenite.c
> @@ -16,6 +16,7 @@
> =A0#include <linux/mtd/mtd.h>
> =A0#include <linux/mtd/partitions.h>
> =A0#include <linux/mtd/nand.h>
> +#include <linux/i2c/pca953x.h>
>
> =A0#include <asm/mach-types.h>
> =A0#include <asm/mach/arch.h>
> @@ -24,9 +25,14 @@
> =A0#include <mach/pxa168.h>
> =A0#include <mach/gpio.h>
> =A0#include <plat/pxa3xx_nand.h>
> +#include <video/pxa168fb.h>
>
> =A0#include "common.h"
>
> +/*used by expander max7312, 16 pins gpio expander */
> +#define GPIO_EXT0(x) =A0 =A0 =A0 =A0 =A0 (NR_BUILTIN_GPIO + (x))
> +#define GPIO_EXT1(x) =A0 =A0 =A0 =A0 =A0 (NR_BUILTIN_GPIO + 16 + (x))
> +
> =A0static unsigned long common_pin_config[] __initdata =3D {
> =A0 =A0 =A0 =A0/* Data Flash Interface */
> =A0 =A0 =A0 =A0GPIO0_DFI_D15,
> @@ -134,6 +140,44 @@ static void __init apn_init_nand(void)
> =A0static void __init apn_init_nand(void) {}
> =A0#endif
>
> +static struct i2c_pxa_platform_data pwri2c_info __initdata =3D {
> + =A0 =A0 =A0 .use_pio =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D 1,
> +};
> +
> +#if defined(CONFIG_GPIO_PCA953X)
> +/* GPIO expander max7312 could reuse PCA953X */
> +static struct pca953x_platform_data max7312_data[] =3D {
> + =A0 =A0 =A0 /* two max7312 in system */
> +
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio_base =A0 =A0 =A0=3D GPIO_EXT0(0),
> + =A0 =A0 =A0 },
> +
> + =A0 =A0 =A0 [1] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .gpio_base =A0 =A0 =A0=3D GPIO_EXT1(0),
> + =A0 =A0 =A0 },
> +};
> +#endif
> +
> +static struct i2c_board_info aspenite_i2c_board_info[] =3D {
> +
> +#if defined(CONFIG_GPIO_PCA953X)
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D "max7312",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D 0x10, =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* 0x20/0x21 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .irq =A0 =A0 =A0 =A0 =A0 =A0=3D IRQ_GPIO(12=
2),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =A0=3D &max7312_data[0],
> + =A0 =A0 =A0 },
> +
> + =A0 =A0 =A0 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .type =A0 =A0 =A0 =A0 =A0 =3D "max7312",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .addr =A0 =A0 =A0 =A0 =A0 =3D 0x20, =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 /* 0x40/0x41 */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .irq =A0 =A0 =A0 =A0 =A0 =A0=3D IRQ_GPIO(12=
0),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .platform_data =A0=3D &max7312_data[1],
> + =A0 =A0 =A0 },
> +#endif
> +};
> +
> =A0static void __init common_init(void)
> =A0{
> =A0 =A0 =A0 =A0mfp_config(ARRAY_AND_SIZE(common_pin_config));
> @@ -142,6 +186,7 @@ static void __init common_init(void)
> =A0 =A0 =A0 =A0pxa168_add_uart(1);
>
> =A0 =A0 =A0 =A0apn_init_nand();
> + =A0 =A0 =A0 pxa168_add_twsi(0, &pwri2c_info, ARRAY_AND_SIZE(aspenite_i2=
c_board_info));
>
> =A0 =A0 =A0 =A0/* off-chip devices */
> =A0 =A0 =A0 =A0platform_device_register(&smc91x_device);
> diff --git a/drivers/gpio/pca953x.c b/drivers/gpio/pca953x.c
> index 6a2fb3f..7822684 100644
> --- a/drivers/gpio/pca953x.c
> +++ b/drivers/gpio/pca953x.c
> @@ -39,6 +39,7 @@ static const struct i2c_device_id pca953x_id[] =3D {
> =A0 =A0 =A0 =A0{ "pca9557", 8, },
>
> =A0 =A0 =A0 =A0{ "max7310", 8, },
> + =A0 =A0 =A0 { "max7312", 16, },
> =A0 =A0 =A0 =A0{ "max7315", 8, },
> =A0 =A0 =A0 =A0{ "pca6107", 8, },
> =A0 =A0 =A0 =A0{ "tca6408", 8, },
> --
> 1.5.4.3
>
add linux-fbdev@vger.kernel.org
