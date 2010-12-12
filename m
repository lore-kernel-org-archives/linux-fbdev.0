From: Liu Ying <liu.y.victor@gmail.com>
Date: Sun, 12 Dec 2010 01:37:38 +0000
Subject: Re: [PATCH 9/9] ARM i.MX51 babbage: Add framebuffer support
Message-Id: <AANLkTi=vT8pX1QQ6DjzQatceO-tQb3Zu90CRAVi2DcpZ@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1291902441-24712-1-git-send-email-s.hauer@pengutronix.de>
	<1291902441-24712-10-git-send-email-s.hauer@pengutronix.de>
In-Reply-To: <1291902441-24712-10-git-send-email-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Hello, Sascha,

I have following 3 comments to this patch:
1) I think DISP1_DATx pins need not be set specially, as they keep the
default register values.
2) Please define 'MX51_PAD_DI_GP4__IPU_DI2_PIN15' in
arch/arm/plat-mxc/include/mach/iomux-mx51.h, and rename the pin to be
'MX51_PAD_DI_GP4__DI2_PIN15', as we name it according to the MX51
iomux reference manual.
3) It is better to exchange the following two lines or just remove the
first line:
+       gpio_set_value(GPIO_DVI_RESET, 0);
+       gpio_direction_output(GPIO_DVI_RESET, 0);

Best Regards,
Liu Ying

2010/12/9 Sascha Hauer <s.hauer@pengutronix.de>:
> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> ---
> =A0arch/arm/mach-mx5/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A01 +
> =A0arch/arm/mach-mx5/board-mx51_babbage.c | =A0 74 ++++++++++++++++++++++=
++++++++++
> =A02 files changed, 75 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-mx5/Kconfig b/arch/arm/mach-mx5/Kconfig
> index 5011f42..2a936b7 100644
> --- a/arch/arm/mach-mx5/Kconfig
> +++ b/arch/arm/mach-mx5/Kconfig
> @@ -22,6 +22,7 @@ config MACH_MX51_BABBAGE
> =A0 =A0 =A0 =A0select IMX_HAVE_PLATFORM_IMX_UART
> =A0 =A0 =A0 =A0select IMX_HAVE_PLATFORM_SDHCI_ESDHC_IMX
> =A0 =A0 =A0 =A0select IMX_HAVE_PLATFORM_SPI_IMX
> + =A0 =A0 =A0 select IMX_HAVE_PLATFORM_IMX_IPUV3
> =A0 =A0 =A0 =A0help
> =A0 =A0 =A0 =A0 =A0Include support for MX51 Babbage platform, also known =
as MX51EVK in
> =A0 =A0 =A0 =A0 =A0u-boot. This includes specific configurations for the =
board and its
> diff --git a/arch/arm/mach-mx5/board-mx51_babbage.c b/arch/arm/mach-mx5/b=
oard-mx51_babbage.c
> index a896f84..169c48c 100644
> --- a/arch/arm/mach-mx5/board-mx51_babbage.c
> +++ b/arch/arm/mach-mx5/board-mx51_babbage.c
> @@ -22,11 +22,13 @@
> =A0#include <linux/input.h>
> =A0#include <linux/spi/flash.h>
> =A0#include <linux/spi/spi.h>
> +#include <linux/mfd/imx-ipu-v3.h>
>
> =A0#include <mach/common.h>
> =A0#include <mach/hardware.h>
> =A0#include <mach/iomux-mx51.h>
> =A0#include <mach/mxc_ehci.h>
> +#include <mach/ipu-v3.h>
>
> =A0#include <asm/irq.h>
> =A0#include <asm/setup.h>
> @@ -158,6 +160,41 @@ static iomux_v3_cfg_t mx51babbage_pads[] =3D {
> =A0 =A0 =A0 =A0MX51_PAD_CSPI1_SCLK__ECSPI1_SCLK,
> =A0 =A0 =A0 =A0MX51_PAD_CSPI1_SS0__GPIO_4_24,
> =A0 =A0 =A0 =A0MX51_PAD_CSPI1_SS1__GPIO_4_25,
> +
> + =A0 =A0 =A0 /* Display */
> + =A0 =A0 =A0 MX51_PAD_DISPB2_SER_DIN__GPIO_3_5,
> + =A0 =A0 =A0 MX51_PAD_DISPB2_SER_DIO__GPIO_3_6,
> + =A0 =A0 =A0 MX51_PAD_NANDF_D12__GPIO_3_28,
> +
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT0__DISP1_DAT0,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT1__DISP1_DAT1,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT2__DISP1_DAT2,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT3__DISP1_DAT3,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT4__DISP1_DAT4,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT5__DISP1_DAT5,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT6__DISP1_DAT6,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT7__DISP1_DAT7,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT8__DISP1_DAT8,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT9__DISP1_DAT9,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT10__DISP1_DAT10,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT11__DISP1_DAT11,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT12__DISP1_DAT12,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT13__DISP1_DAT13,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT14__DISP1_DAT14,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT15__DISP1_DAT15,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT16__DISP1_DAT16,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT17__DISP1_DAT17,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT18__DISP1_DAT18,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT19__DISP1_DAT19,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT20__DISP1_DAT20,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT21__DISP1_DAT21,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT22__DISP1_DAT22,
> + =A0 =A0 =A0 MX51_PAD_DISP1_DAT23__DISP1_DAT23,
> +#define MX51_PAD_DI_GP4__IPU_DI2_PIN15 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 I=
OMUX_PAD(0x758, 0x350, 4, 0x0, =A0 0, NO_PAD_CTRL)
> + =A0 =A0 =A0 MX51_PAD_DI_GP4__IPU_DI2_PIN15,
> +
> + =A0 =A0 =A0 /* I2C DVI enable */
> + =A0 =A0 =A0 MX51_PAD_CSI2_HSYNC__GPIO_4_14,
> =A0};
>
> =A0/* Serial ports */
> @@ -342,6 +379,21 @@ static const struct spi_imx_master mx51_babbage_spi_=
pdata __initconst =3D {
> =A0 =A0 =A0 =A0.num_chipselect =3D ARRAY_SIZE(mx51_babbage_spi_cs),
> =A0};
>
> +static struct ipuv3_fb_platform_data babbage_fb0_data =3D {
> + =A0 =A0 =A0 .interface_pix_fmt =3D IPU_PIX_FMT_RGB24,
> + =A0 =A0 =A0 .flags =3D IMX_IPU_FB_USE_MODEDB | IMX_IPU_FB_USE_OVERLAY,
> +};
> +
> +static struct ipuv3_fb_platform_data babbage_fb1_data =3D {
> + =A0 =A0 =A0 .interface_pix_fmt =3D IPU_PIX_FMT_RGB565,
> + =A0 =A0 =A0 .flags =3D IMX_IPU_FB_USE_MODEDB,
> +};
> +
> +static struct imx_ipuv3_platform_data ipu_data =3D {
> + =A0 =A0 =A0 .fb0_platform_data =3D &babbage_fb0_data,
> + =A0 =A0 =A0 .fb1_platform_data =3D &babbage_fb1_data,
> +};
> +
> =A0/*
> =A0* Board specific initialization.
> =A0*/
> @@ -388,6 +440,28 @@ static void __init mxc_board_init(void)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ARRAY_SIZE(mx51_babbage_spi_board_info));
> =A0 =A0 =A0 =A0imx51_add_ecspi(0, &mx51_babbage_spi_pdata);
> =A0 =A0 =A0 =A0imx51_add_imx2_wdt(0, NULL);
> +
> +#define GPIO_DVI_DETECT =A0 =A0 =A0 =A0(2 * 32 + 28)
> +#define GPIO_DVI_RESET (2 * 32 + 5)
> +#define GPIO_DVI_PWRDN (2 * 32 + 6)
> +#define GPIO_DVI_I2C =A0 (3 * 32 + 14)
> +
> + =A0 =A0 =A0 /* DVI Detect */
> + =A0 =A0 =A0 gpio_request(GPIO_DVI_DETECT, "dvi detect");
> + =A0 =A0 =A0 gpio_direction_input(GPIO_DVI_DETECT);
> + =A0 =A0 =A0 /* DVI Reset - Assert for i2c disabled mode */
> + =A0 =A0 =A0 gpio_request(GPIO_DVI_RESET, "dvi reset");
> + =A0 =A0 =A0 gpio_set_value(GPIO_DVI_RESET, 0);
> + =A0 =A0 =A0 gpio_direction_output(GPIO_DVI_RESET, 0);
> + =A0 =A0 =A0 /* DVI Power-down */
> + =A0 =A0 =A0 gpio_request(GPIO_DVI_PWRDN, "dvi pwdn");
> + =A0 =A0 =A0 gpio_direction_output(GPIO_DVI_PWRDN, 0);
> + =A0 =A0 =A0 gpio_set_value(GPIO_DVI_PWRDN, 1);
> +
> + =A0 =A0 =A0 gpio_request(GPIO_DVI_I2C, "dvi i2c");
> + =A0 =A0 =A0 gpio_direction_output(GPIO_DVI_I2C, 0);
> +
> + =A0 =A0 =A0 imx51_add_ipuv3(&ipu_data);
> =A0}
>
> =A0static void __init mx51_babbage_timer_init(void)
> --
> 1.7.2.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =A0http://www.tux.org/lkml/
>
