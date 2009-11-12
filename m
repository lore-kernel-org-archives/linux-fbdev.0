From: Jun Nie <niej0001@gmail.com>
Date: Thu, 12 Nov 2009 02:19:26 +0000
Subject: Re: [PATCH 7/8] pxa: add frame buffer on pxa168 aspenite platform
Message-Id: <7c34ac520911111819x7c0bd504n4104294e31320fb1@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0016e64cd53226489f0478232c17"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100012r6ae16be7ua999f8d287659e0e@mail.gmail.com>
In-Reply-To: <7c34ac520911100012r6ae16be7ua999f8d287659e0e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--0016e64cd53226489f0478232c17
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2009/11/10 Jun Nie <niej0001@gmail.com>:
> From 371f70316d6766c781a50818733bb39491a90200 Mon Sep 17 00:00:00 2001
> From: Jun Nie <njun@marvell.com>
> Date: Tue, 10 Nov 2009 15:58:28 +0800
> Subject: [PATCH] pxa: add frame buffer on pxa168 aspenite platform
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> =A0arch/arm/configs/pxa168_defconfig =A0 =A0 =A0 | =A0 86 +++++++++++++++=
+++++-
> =A0arch/arm/mach-mmp/aspenite.c =A0 =A0 =A0 =A0 =A0 =A0| =A0131 +++++++++=
++++++++++++++++++++++
> =A0arch/arm/mach-mmp/include/mach/pxa168.h | =A0 =A08 ++
> =A0arch/arm/mach-mmp/pxa168.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 +
> =A04 files changed, 226 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/configs/pxa168_defconfig
> b/arch/arm/configs/pxa168_defconfig
> index db5faea..b736517 100644
> --- a/arch/arm/configs/pxa168_defconfig
> +++ b/arch/arm/configs/pxa168_defconfig
> @@ -509,7 +509,49 @@ CONFIG_UNIX98_PTYS=3Dy
> =A0# CONFIG_R3964 is not set
> =A0# CONFIG_RAW_DRIVER is not set
> =A0# CONFIG_TCG_TPM is not set
> -# CONFIG_I2C is not set
> +CONFIG_I2C=3Dy
> +CONFIG_I2C_BOARDINFO=3Dy
> +# CONFIG_I2C_CHARDEV is not set
> +CONFIG_I2C_HELPER_AUTO=3Dy
> +CONFIG_I2C_ALGOBIT=3Dy
> +
> +#
> +# I2C Hardware Bus support
> +#
> +
> +#
> +# I2C system bus drivers (mostly embedded / system-on-chip)
> +#
> +# CONFIG_I2C_DESIGNWARE is not set
> +CONFIG_I2C_GPIO=3Dy
> +# CONFIG_I2C_OCORES is not set
> +CONFIG_I2C_PXA=3Dy
> +# CONFIG_I2C_PXA_SLAVE is not set
> +# CONFIG_I2C_SIMTEC is not set
> +
> +#
> +# External I2C/SMBus adapter drivers
> +#
> +# CONFIG_I2C_PARPORT_LIGHT is not set
> +# CONFIG_I2C_TAOS_EVM is not set
> +
> +#
> +# Other I2C/SMBus bus drivers
> +#
> +# CONFIG_I2C_PCA_PLATFORM is not set
> +# CONFIG_I2C_STUB is not set
> +
> +#
> +# Miscellaneous I2C Chip support
> +#
> +# CONFIG_DS1682 is not set
> +# CONFIG_SENSORS_PCF8574 is not set
> +# CONFIG_PCF8575 is not set
> +# CONFIG_SENSORS_TSL2550 is not set
> +# CONFIG_I2C_DEBUG_CORE is not set
> +# CONFIG_I2C_DEBUG_ALGO is not set
> +# CONFIG_I2C_DEBUG_BUS is not set
> +# CONFIG_I2C_DEBUG_CHIP is not set
> =A0# CONFIG_SPI is not set
> =A0CONFIG_ARCH_REQUIRE_GPIOLIB=3Dy
> =A0CONFIG_GPIOLIB=3Dy
> @@ -523,6 +565,9 @@ CONFIG_GPIOLIB=3Dy
> =A0#
> =A0# I2C GPIO expanders:
> =A0#
> +# CONFIG_GPIO_MAX732X is not set
> +CONFIG_GPIO_PCA953X=3Dy
> +# CONFIG_GPIO_PCF857X is not set
>
> =A0#
> =A0# PCI GPIO expanders:
> @@ -578,7 +623,34 @@ CONFIG_SSB_POSSIBLE=3Dy
> =A0#
> =A0# CONFIG_VGASTATE is not set
> =A0# CONFIG_VIDEO_OUTPUT_CONTROL is not set
> -# CONFIG_FB is not set
> +CONFIG_FB=3Dy
> +# CONFIG_FIRMWARE_EDID is not set
> +# CONFIG_FB_DDC is not set
> +# CONFIG_FB_BOOT_VESA_SUPPORT is not set
> +# CONFIG_FB_CFB_FILLRECT is not set
> +# CONFIG_FB_CFB_COPYAREA is not set
> +# CONFIG_FB_CFB_IMAGEBLIT is not set
> +# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
> +# CONFIG_FB_SYS_FILLRECT is not set
> +# CONFIG_FB_SYS_COPYAREA is not set
> +# CONFIG_FB_SYS_IMAGEBLIT is not set
> +# CONFIG_FB_FOREIGN_ENDIAN is not set
> +# CONFIG_FB_SYS_FOPS is not set
> +# CONFIG_FB_SVGALIB is not set
> +# CONFIG_FB_MACMODES is not set
> +# CONFIG_FB_BACKLIGHT is not set
> +# CONFIG_FB_MODE_HELPERS is not set
> +# CONFIG_FB_TILEBLITTING is not set
> +
> +#
> +# Frame buffer hardware drivers
> +#
> +# CONFIG_FB_S1D13XXX is not set
> +CONFIG_FB_PXA168=3Dy
> +# CONFIG_FB_VIRTUAL is not set
> +# CONFIG_FB_METRONOME is not set
> +# CONFIG_FB_MB862XX is not set
> +# CONFIG_FB_BROADSHEET is not set
> =A0# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
>
> =A0#
> @@ -591,6 +663,16 @@ CONFIG_SSB_POSSIBLE=3Dy
> =A0#
> =A0# CONFIG_VGA_CONSOLE is not set
> =A0CONFIG_DUMMY_CONSOLE=3Dy
> +CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> +CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
> +# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
> +# CONFIG_FONTS is not set
> +CONFIG_FONT_8x8=3Dy
> +CONFIG_FONT_8x16=3Dy
> +CONFIG_LOGO=3Dy
> +# CONFIG_LOGO_LINUX_MONO is not set
> +CONFIG_LOGO_LINUX_VGA16=3Dy
> +CONFIG_LOGO_LINUX_CLUT224=3Dy
> =A0# CONFIG_SOUND is not set
> =A0# CONFIG_HID_SUPPORT is not set
> =A0# CONFIG_USB_SUPPORT is not set
> diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
> index b422bb5..d0a1e37 100644
> --- a/arch/arm/mach-mmp/aspenite.c
> +++ b/arch/arm/mach-mmp/aspenite.c
> @@ -17,6 +17,7 @@
> =A0#include <linux/mtd/partitions.h>
> =A0#include <linux/mtd/nand.h>
> =A0#include <linux/i2c/pca953x.h>
> +#include <linux/delay.h>
>
> =A0#include <asm/mach-types.h>
> =A0#include <asm/mach/arch.h>
> @@ -66,6 +67,39 @@ static unsigned long common_pin_config[] __initdata =
=3D {
> =A0 =A0 =A0 =A0/* UART1 */
> =A0 =A0 =A0 =A0GPIO107_UART1_RXD,
> =A0 =A0 =A0 =A0GPIO108_UART1_TXD,
> +
> +#ifdef CONFIG_FB_PXA168
> + =A0 =A0 =A0 /* LCD */
> + =A0 =A0 =A0 GPIO56_LCD_FCLK_RD,
> + =A0 =A0 =A0 GPIO57_LCD_LCLK_A0,
> + =A0 =A0 =A0 GPIO58_LCD_PCLK_WR,
> + =A0 =A0 =A0 GPIO59_LCD_DENA_BIAS,
> + =A0 =A0 =A0 GPIO60_LCD_DD0,
> + =A0 =A0 =A0 GPIO61_LCD_DD1,
> + =A0 =A0 =A0 GPIO62_LCD_DD2,
> + =A0 =A0 =A0 GPIO63_LCD_DD3,
> + =A0 =A0 =A0 GPIO64_LCD_DD4,
> + =A0 =A0 =A0 GPIO65_LCD_DD5,
> + =A0 =A0 =A0 GPIO66_LCD_DD6,
> + =A0 =A0 =A0 GPIO67_LCD_DD7,
> + =A0 =A0 =A0 GPIO68_LCD_DD8,
> + =A0 =A0 =A0 GPIO69_LCD_DD9,
> + =A0 =A0 =A0 GPIO70_LCD_DD10,
> + =A0 =A0 =A0 GPIO71_LCD_DD11,
> + =A0 =A0 =A0 GPIO72_LCD_DD12,
> + =A0 =A0 =A0 GPIO73_LCD_DD13,
> + =A0 =A0 =A0 GPIO74_LCD_DD14,
> + =A0 =A0 =A0 GPIO75_LCD_DD15,
> +
> + =A0 =A0 =A0 GPIO76_LCD_DD16,
> + =A0 =A0 =A0 GPIO77_LCD_DD17,
> + =A0 =A0 =A0 GPIO78_LCD_DD18,
> + =A0 =A0 =A0 GPIO79_LCD_DD19,
> + =A0 =A0 =A0 GPIO80_LCD_DD20,
> + =A0 =A0 =A0 GPIO81_LCD_DD21,
> + =A0 =A0 =A0 GPIO82_LCD_DD22,
> + =A0 =A0 =A0 GPIO83_LCD_DD23,
> +#endif
> =A0};
>
> =A0static struct smc91x_platdata smc91x_info =3D {
> @@ -95,6 +129,100 @@ static struct platform_device smc91x_device =3D {
> =A0 =A0 =A0 =A0.resource =A0 =A0 =A0 =3D smc91x_resources,
> =A0};
>
> +#ifdef CONFIG_FB_PXA168
> +static u16 tpo_spi_cmdon[] =3D {
> + =A0 =A0 =A0 0x080F,
> + =A0 =A0 =A0 0x0C5F,
> + =A0 =A0 =A0 0x1017,
> + =A0 =A0 =A0 0x1420,
> + =A0 =A0 =A0 0x1808,
> + =A0 =A0 =A0 0x1c20,
> + =A0 =A0 =A0 0x2020,
> + =A0 =A0 =A0 0x2420,
> + =A0 =A0 =A0 0x2820,
> + =A0 =A0 =A0 0x2c20,
> + =A0 =A0 =A0 0x3020,
> + =A0 =A0 =A0 0x3420,
> + =A0 =A0 =A0 0x3810,
> + =A0 =A0 =A0 0x3c10,
> + =A0 =A0 =A0 0x4010,
> + =A0 =A0 =A0 0x4415,
> + =A0 =A0 =A0 0x48aa,
> + =A0 =A0 =A0 0x4cff,
> + =A0 =A0 =A0 0x5086,
> + =A0 =A0 =A0 0x548d,
> + =A0 =A0 =A0 0x58d4,
> + =A0 =A0 =A0 0x5cfb,
> + =A0 =A0 =A0 0x602e,
> + =A0 =A0 =A0 0x645a,
> + =A0 =A0 =A0 0x6889,
> + =A0 =A0 =A0 0x6cfe,
> + =A0 =A0 =A0 0x705a,
> + =A0 =A0 =A0 0x749b,
> + =A0 =A0 =A0 0x78c5,
> + =A0 =A0 =A0 0x7cff,
> + =A0 =A0 =A0 0x80f0,
> + =A0 =A0 =A0 0x84f0,
> + =A0 =A0 =A0 0x8808,
> +};
> +
> +static u16 tpo_spi_cmdoff[] =3D {
> + =A0 =A0 =A0 0x0c5e, =A0 =A0 =A0 =A0 //standby
> +};
> +
> +static int tpo_lcd_power(struct pxa168fb_info *fbi, unsigned int
> spi_gpio_cs, unsigned int spi_gpio_reset, int on)
> +{
> + =A0 =A0 =A0 int err =3D 0;
> + =A0 =A0 =A0 if (on) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi_gpio_reset !=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D gpio_request(spi_gp=
io_reset, "TPO_LCD_SPI_RESET");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("fai=
led to request GPIO for TPO LCD RESET\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(spi_g=
pio_reset, 0);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(100);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_set_value(spi_gpio_res=
et, 1);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(100);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_free(spi_gpio_reset);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pxa168fb_spi_send(fbi, tpo_spi_cmdon=
,
> ARRAY_SIZE(tpo_spi_cmdon), spi_gpio_cs, 0, 1);
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pxa168fb_spi_send(fbi, tpo_spi_cmdof=
f,
> ARRAY_SIZE(tpo_spi_cmdoff), spi_gpio_cs, 0, 1);
> +}
> +
> +static struct fb_videomode video_modes_aspen[] =3D {
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pixclock =A0 =A0 =A0 =3D 30120,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .refresh =A0 =A0 =A0 =A0=3D 60,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .xres =A0 =A0 =A0 =A0 =A0 =3D 800,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .yres =A0 =A0 =A0 =A0 =A0 =3D 480,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hsync_len =A0 =A0 =A0=3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .left_margin =A0 =A0=3D 215,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .right_margin =A0 =3D 40,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vsync_len =A0 =A0 =A0=3D 1,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .upper_margin =A0 =3D 34,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .lower_margin =A0 =3D 10,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sync =A0 =A0 =A0 =A0 =A0 =3D FB_SYNC_VERT_=
HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
> + =A0 =A0 =A0 },
> +};
> +
> +struct pxa168fb_mach_info aspenite_lcd_info __initdata =3D {
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "Base-aspen=
",
> + =A0 =A0 =A0 .modes =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D video_modes_a=
spen,
> + =A0 =A0 =A0 .num_modes =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ARRAY_SIZE(video_=
modes_aspen),
> + =A0 =A0 =A0 .pix_fmt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D PIX_FMT_RGB565,
> + =A0 =A0 =A0 .io_pin_allocation_mode =3D PIN_MODE_DUMB_24,
> + =A0 =A0 =A0 .dumb_mode =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D DUMB_MODE_RGB888,
> + =A0 =A0 =A0 .active =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 1,
> + =A0 =A0 =A0 .spi_ctrl =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D CFG_SCLKCNT(2) | =
CFG_TXBITS(16) | CFG_SPI_SEL(1) |
> CFG_SPI_3W4WB(1) | CFG_SPI_ENA(1),
> + =A0 =A0 =A0 .spi_gpio_cs =A0 =A0 =A0 =A0 =A0 =A0=3D GPIO_EXT1(14),
> + =A0 =A0 =A0 .spi_gpio_reset =A0 =A0 =A0 =A0 =3D -1,
> + =A0 =A0 =A0 .pxa168fb_lcd_power =A0 =A0 =3D tpo_lcd_power,
> +};
> +
> +#endif
> +
> =A0#if defined(CONFIG_MTD_NAND) || defined(CONFIG_MTD_NAND_MODULE)
> =A0static struct mtd_partition apn_nand_partitions[] =3D {
> =A0 =A0 =A0 =A0{
> @@ -184,6 +312,9 @@ static void __init common_init(void)
>
> =A0 =A0 =A0 =A0/* on-chip devices */
> =A0 =A0 =A0 =A0pxa168_add_uart(1);
> +#ifdef CONFIG_FB_PXA168
> + =A0 =A0 =A0 pxa168_add_fb(&aspenite_lcd_info);
> +#endif
>
> =A0 =A0 =A0 =A0apn_init_nand();
> =A0 =A0 =A0 =A0pxa168_add_twsi(0, &pwri2c_info, ARRAY_AND_SIZE(aspenite_i=
2c_board_info));
> diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h
> b/arch/arm/mach-mmp/include/mach/pxa168.h
> index d117ceb..d43fb13 100644
> --- a/arch/arm/mach-mmp/include/mach/pxa168.h
> +++ b/arch/arm/mach-mmp/include/mach/pxa168.h
> @@ -4,6 +4,7 @@
> =A0#include <linux/i2c.h>
> =A0#include <mach/devices.h>
> =A0#include <plat/i2c.h>
> +#include <video/pxa168fb.h>
>
> =A0extern struct pxa_device_desc pxa168_device_uart1;
> =A0extern struct pxa_device_desc pxa168_device_uart2;
> @@ -14,6 +15,7 @@ extern struct pxa_device_desc pxa168_device_pwm2;
> =A0extern struct pxa_device_desc pxa168_device_pwm3;
> =A0extern struct pxa_device_desc pxa168_device_pwm4;
> =A0extern struct pxa_device_desc pxa168_device_nand;
> +extern struct pxa_device_desc pxa168_device_fb;
>
> =A0static inline int pxa168_add_uart(int id)
> =A0{
> @@ -65,4 +67,10 @@ static inline int pxa168_add_pwm(int id)
>
> =A0 =A0 =A0 =A0return pxa_register_device(d, NULL, 0);
> =A0}
> +
> +static inline int pxa168_add_fb(struct pxa168fb_mach_info *mi)
> +{
> + =A0 =A0 =A0 return pxa_register_device(&pxa168_device_fb, mi, sizeof(*m=
i));
> +}
> +
> =A0#endif /* __ASM_MACH_PXA168_H */
> diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
> index 59b393e..8be1e46 100644
> --- a/arch/arm/mach-mmp/pxa168.c
> +++ b/arch/arm/mach-mmp/pxa168.c
> @@ -74,6 +74,7 @@ static APBC_CLK(pwm3, PXA168_PWM3, 1, 13000000);
> =A0static APBC_CLK(pwm4, PXA168_PWM4, 1, 13000000);
>
> =A0static APMU_CLK(nand, NAND, 0x1db, 208000000);
> +static APMU_CLK(lcd, LCD, 0x003f, 312000000);
>
> =A0/* device and clock bindings */
> =A0static struct clk_lookup pxa168_clkregs[] =3D {
> @@ -86,6 +87,7 @@ static struct clk_lookup pxa168_clkregs[] =3D {
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_pwm2, "pxa168-pwm.1", NULL),
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_pwm3, "pxa168-pwm.2", NULL),
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_pwm4, "pxa168-pwm.3", NULL),
> + =A0 =A0 =A0 INIT_CLKREG(&clk_lcd, "pxa168-fb", "LCDCLK"),
> =A0};
>
> =A0static int __init pxa168_init(void)
> @@ -132,3 +134,4 @@ PXA168_DEVICE(pwm2, "pxa168-pwm", 1, NONE,
> 0xd401a400, 0x10);
> =A0PXA168_DEVICE(pwm3, "pxa168-pwm", 2, NONE, 0xd401a800, 0x10);
> =A0PXA168_DEVICE(pwm4, "pxa168-pwm", 3, NONE, 0xd401ac00, 0x10);
> =A0PXA168_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x200, 97, 99=
);
> +PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
> --
> 1.5.4.3
>
patch attached.

--0016e64cd53226489f0478232c17
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0007-pxa-add-frame-buffer-on-pxa168-aspenite-platform.patch"
Content-Disposition: attachment; 
	filename="0007-pxa-add-frame-buffer-on-pxa168-aspenite-platform.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1ww4mjk0

RnJvbSAzNzFmNzAzMTZkNjc2NmM3ODFhNTA4MTg3MzNiYjM5NDkxYTkwMjAwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUdWUs
IDEwIE5vdiAyMDA5IDE1OjU4OjI4ICswODAwClN1YmplY3Q6IFtQQVRDSF0gcHhhOiBhZGQgZnJh
bWUgYnVmZmVyIG9uIHB4YTE2OCBhc3Blbml0ZSBwbGF0Zm9ybQoKU2lnbmVkLW9mZi1ieTogSnVu
IE5pZSA8bmp1bkBtYXJ2ZWxsLmNvbT4KLS0tCiBhcmNoL2FybS9jb25maWdzL3B4YTE2OF9kZWZj
b25maWcgICAgICAgfCAgIDg2ICsrKysrKysrKysrKysrKysrKysrLQogYXJjaC9hcm0vbWFjaC1t
bXAvYXNwZW5pdGUuYyAgICAgICAgICAgIHwgIDEzMSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrCiBhcmNoL2FybS9tYWNoLW1tcC9pbmNsdWRlL21hY2gvcHhhMTY4LmggfCAgICA4ICsr
CiBhcmNoL2FybS9tYWNoLW1tcC9weGExNjguYyAgICAgICAgICAgICAgfCAgICAzICsKIDQgZmls
ZXMgY2hhbmdlZCwgMjI2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvYXJjaC9hcm0vY29uZmlncy9weGExNjhfZGVmY29uZmlnIGIvYXJjaC9hcm0vY29uZmlncy9w
eGExNjhfZGVmY29uZmlnCmluZGV4IGRiNWZhZWEuLmI3MzY1MTcgMTAwNjQ0Ci0tLSBhL2FyY2gv
YXJtL2NvbmZpZ3MvcHhhMTY4X2RlZmNvbmZpZworKysgYi9hcmNoL2FybS9jb25maWdzL3B4YTE2
OF9kZWZjb25maWcKQEAgLTUwOSw3ICs1MDksNDkgQEAgQ09ORklHX1VOSVg5OF9QVFlTPXkKICMg
Q09ORklHX1IzOTY0IGlzIG5vdCBzZXQKICMgQ09ORklHX1JBV19EUklWRVIgaXMgbm90IHNldAog
IyBDT05GSUdfVENHX1RQTSBpcyBub3Qgc2V0Ci0jIENPTkZJR19JMkMgaXMgbm90IHNldAorQ09O
RklHX0kyQz15CitDT05GSUdfSTJDX0JPQVJESU5GTz15CisjIENPTkZJR19JMkNfQ0hBUkRFViBp
cyBub3Qgc2V0CitDT05GSUdfSTJDX0hFTFBFUl9BVVRPPXkKK0NPTkZJR19JMkNfQUxHT0JJVD15
CisKKyMKKyMgSTJDIEhhcmR3YXJlIEJ1cyBzdXBwb3J0CisjCisKKyMKKyMgSTJDIHN5c3RlbSBi
dXMgZHJpdmVycyAobW9zdGx5IGVtYmVkZGVkIC8gc3lzdGVtLW9uLWNoaXApCisjCisjIENPTkZJ
R19JMkNfREVTSUdOV0FSRSBpcyBub3Qgc2V0CitDT05GSUdfSTJDX0dQSU89eQorIyBDT05GSUdf
STJDX09DT1JFUyBpcyBub3Qgc2V0CitDT05GSUdfSTJDX1BYQT15CisjIENPTkZJR19JMkNfUFhB
X1NMQVZFIGlzIG5vdCBzZXQKKyMgQ09ORklHX0kyQ19TSU1URUMgaXMgbm90IHNldAorCisjCisj
IEV4dGVybmFsIEkyQy9TTUJ1cyBhZGFwdGVyIGRyaXZlcnMKKyMKKyMgQ09ORklHX0kyQ19QQVJQ
T1JUX0xJR0hUIGlzIG5vdCBzZXQKKyMgQ09ORklHX0kyQ19UQU9TX0VWTSBpcyBub3Qgc2V0CisK
KyMKKyMgT3RoZXIgSTJDL1NNQnVzIGJ1cyBkcml2ZXJzCisjCisjIENPTkZJR19JMkNfUENBX1BM
QVRGT1JNIGlzIG5vdCBzZXQKKyMgQ09ORklHX0kyQ19TVFVCIGlzIG5vdCBzZXQKKworIworIyBN
aXNjZWxsYW5lb3VzIEkyQyBDaGlwIHN1cHBvcnQKKyMKKyMgQ09ORklHX0RTMTY4MiBpcyBub3Qg
c2V0CisjIENPTkZJR19TRU5TT1JTX1BDRjg1NzQgaXMgbm90IHNldAorIyBDT05GSUdfUENGODU3
NSBpcyBub3Qgc2V0CisjIENPTkZJR19TRU5TT1JTX1RTTDI1NTAgaXMgbm90IHNldAorIyBDT05G
SUdfSTJDX0RFQlVHX0NPUkUgaXMgbm90IHNldAorIyBDT05GSUdfSTJDX0RFQlVHX0FMR08gaXMg
bm90IHNldAorIyBDT05GSUdfSTJDX0RFQlVHX0JVUyBpcyBub3Qgc2V0CisjIENPTkZJR19JMkNf
REVCVUdfQ0hJUCBpcyBub3Qgc2V0CiAjIENPTkZJR19TUEkgaXMgbm90IHNldAogQ09ORklHX0FS
Q0hfUkVRVUlSRV9HUElPTElCPXkKIENPTkZJR19HUElPTElCPXkKQEAgLTUyMyw2ICs1NjUsOSBA
QCBDT05GSUdfR1BJT0xJQj15CiAjCiAjIEkyQyBHUElPIGV4cGFuZGVyczoKICMKKyMgQ09ORklH
X0dQSU9fTUFYNzMyWCBpcyBub3Qgc2V0CitDT05GSUdfR1BJT19QQ0E5NTNYPXkKKyMgQ09ORklH
X0dQSU9fUENGODU3WCBpcyBub3Qgc2V0CiAKICMKICMgUENJIEdQSU8gZXhwYW5kZXJzOgpAQCAt
NTc4LDcgKzYyMywzNCBAQCBDT05GSUdfU1NCX1BPU1NJQkxFPXkKICMKICMgQ09ORklHX1ZHQVNU
QVRFIGlzIG5vdCBzZXQKICMgQ09ORklHX1ZJREVPX09VVFBVVF9DT05UUk9MIGlzIG5vdCBzZXQK
LSMgQ09ORklHX0ZCIGlzIG5vdCBzZXQKK0NPTkZJR19GQj15CisjIENPTkZJR19GSVJNV0FSRV9F
RElEIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX0REQyBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9C
T09UX1ZFU0FfU1VQUE9SVCBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9DRkJfRklMTFJFQ1QgaXMg
bm90IHNldAorIyBDT05GSUdfRkJfQ0ZCX0NPUFlBUkVBIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZC
X0NGQl9JTUFHRUJMSVQgaXMgbm90IHNldAorIyBDT05GSUdfRkJfQ0ZCX1JFVl9QSVhFTFNfSU5f
QllURSBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9TWVNfRklMTFJFQ1QgaXMgbm90IHNldAorIyBD
T05GSUdfRkJfU1lTX0NPUFlBUkVBIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX1NZU19JTUFHRUJM
SVQgaXMgbm90IHNldAorIyBDT05GSUdfRkJfRk9SRUlHTl9FTkRJQU4gaXMgbm90IHNldAorIyBD
T05GSUdfRkJfU1lTX0ZPUFMgaXMgbm90IHNldAorIyBDT05GSUdfRkJfU1ZHQUxJQiBpcyBub3Qg
c2V0CisjIENPTkZJR19GQl9NQUNNT0RFUyBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9CQUNLTElH
SFQgaXMgbm90IHNldAorIyBDT05GSUdfRkJfTU9ERV9IRUxQRVJTIGlzIG5vdCBzZXQKKyMgQ09O
RklHX0ZCX1RJTEVCTElUVElORyBpcyBub3Qgc2V0CisKKyMKKyMgRnJhbWUgYnVmZmVyIGhhcmR3
YXJlIGRyaXZlcnMKKyMKKyMgQ09ORklHX0ZCX1MxRDEzWFhYIGlzIG5vdCBzZXQKK0NPTkZJR19G
Ql9QWEExNjg9eQorIyBDT05GSUdfRkJfVklSVFVBTCBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9N
RVRST05PTUUgaXMgbm90IHNldAorIyBDT05GSUdfRkJfTUI4NjJYWCBpcyBub3Qgc2V0CisjIENP
TkZJR19GQl9CUk9BRFNIRUVUIGlzIG5vdCBzZXQKICMgQ09ORklHX0JBQ0tMSUdIVF9MQ0RfU1VQ
UE9SVCBpcyBub3Qgc2V0CiAKICMKQEAgLTU5MSw2ICs2NjMsMTYgQEAgQ09ORklHX1NTQl9QT1NT
SUJMRT15CiAjCiAjIENPTkZJR19WR0FfQ09OU09MRSBpcyBub3Qgc2V0CiBDT05GSUdfRFVNTVlf
Q09OU09MRT15CitDT05GSUdfRlJBTUVCVUZGRVJfQ09OU09MRT15CitDT05GSUdfRlJBTUVCVUZG
RVJfQ09OU09MRV9ERVRFQ1RfUFJJTUFSWT15CisjIENPTkZJR19GUkFNRUJVRkZFUl9DT05TT0xF
X1JPVEFUSU9OIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZPTlRTIGlzIG5vdCBzZXQKK0NPTkZJR19G
T05UXzh4OD15CitDT05GSUdfRk9OVF84eDE2PXkKK0NPTkZJR19MT0dPPXkKKyMgQ09ORklHX0xP
R09fTElOVVhfTU9OTyBpcyBub3Qgc2V0CitDT05GSUdfTE9HT19MSU5VWF9WR0ExNj15CitDT05G
SUdfTE9HT19MSU5VWF9DTFVUMjI0PXkKICMgQ09ORklHX1NPVU5EIGlzIG5vdCBzZXQKICMgQ09O
RklHX0hJRF9TVVBQT1JUIGlzIG5vdCBzZXQKICMgQ09ORklHX1VTQl9TVVBQT1JUIGlzIG5vdCBz
ZXQKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtbW1wL2FzcGVuaXRlLmMgYi9hcmNoL2FybS9t
YWNoLW1tcC9hc3Blbml0ZS5jCmluZGV4IGI0MjJiYjUuLmQwYTFlMzcgMTAwNjQ0Ci0tLSBhL2Fy
Y2gvYXJtL21hY2gtbW1wL2FzcGVuaXRlLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1tbXAvYXNwZW5p
dGUuYwpAQCAtMTcsNiArMTcsNyBAQAogI2luY2x1ZGUgPGxpbnV4L210ZC9wYXJ0aXRpb25zLmg+
CiAjaW5jbHVkZSA8bGludXgvbXRkL25hbmQuaD4KICNpbmNsdWRlIDxsaW51eC9pMmMvcGNhOTUz
eC5oPgorI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+CiAKICNpbmNsdWRlIDxhc20vbWFjaC10eXBl
cy5oPgogI2luY2x1ZGUgPGFzbS9tYWNoL2FyY2guaD4KQEAgLTY2LDYgKzY3LDM5IEBAIHN0YXRp
YyB1bnNpZ25lZCBsb25nIGNvbW1vbl9waW5fY29uZmlnW10gX19pbml0ZGF0YSA9IHsKIAkvKiBV
QVJUMSAqLwogCUdQSU8xMDdfVUFSVDFfUlhELAogCUdQSU8xMDhfVUFSVDFfVFhELAorCisjaWZk
ZWYgQ09ORklHX0ZCX1BYQTE2OAorCS8qIExDRCAqLworCUdQSU81Nl9MQ0RfRkNMS19SRCwKKwlH
UElPNTdfTENEX0xDTEtfQTAsCisJR1BJTzU4X0xDRF9QQ0xLX1dSLAorCUdQSU81OV9MQ0RfREVO
QV9CSUFTLAorCUdQSU82MF9MQ0RfREQwLAorCUdQSU82MV9MQ0RfREQxLAorCUdQSU82Ml9MQ0Rf
REQyLAorCUdQSU82M19MQ0RfREQzLAorCUdQSU82NF9MQ0RfREQ0LAorCUdQSU82NV9MQ0RfREQ1
LAorCUdQSU82Nl9MQ0RfREQ2LAorCUdQSU82N19MQ0RfREQ3LAorCUdQSU82OF9MQ0RfREQ4LAor
CUdQSU82OV9MQ0RfREQ5LAorCUdQSU83MF9MQ0RfREQxMCwKKwlHUElPNzFfTENEX0REMTEsCisJ
R1BJTzcyX0xDRF9ERDEyLAorCUdQSU83M19MQ0RfREQxMywKKwlHUElPNzRfTENEX0REMTQsCisJ
R1BJTzc1X0xDRF9ERDE1LAorCisJR1BJTzc2X0xDRF9ERDE2LAorCUdQSU83N19MQ0RfREQxNywK
KwlHUElPNzhfTENEX0REMTgsCisJR1BJTzc5X0xDRF9ERDE5LAorCUdQSU84MF9MQ0RfREQyMCwK
KwlHUElPODFfTENEX0REMjEsCisJR1BJTzgyX0xDRF9ERDIyLAorCUdQSU84M19MQ0RfREQyMywK
KyNlbmRpZgogfTsKIAogc3RhdGljIHN0cnVjdCBzbWM5MXhfcGxhdGRhdGEgc21jOTF4X2luZm8g
PSB7CkBAIC05NSw2ICsxMjksMTAwIEBAIHN0YXRpYyBzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlIHNt
YzkxeF9kZXZpY2UgPSB7CiAJLnJlc291cmNlCT0gc21jOTF4X3Jlc291cmNlcywKIH07CiAKKyNp
ZmRlZiBDT05GSUdfRkJfUFhBMTY4CitzdGF0aWMgdTE2IHRwb19zcGlfY21kb25bXSA9IHsKKwkw
eDA4MEYsCisJMHgwQzVGLAorCTB4MTAxNywKKwkweDE0MjAsCisJMHgxODA4LAorCTB4MWMyMCwK
KwkweDIwMjAsCisJMHgyNDIwLAorCTB4MjgyMCwKKwkweDJjMjAsCisJMHgzMDIwLAorCTB4MzQy
MCwKKwkweDM4MTAsCisJMHgzYzEwLAorCTB4NDAxMCwKKwkweDQ0MTUsCisJMHg0OGFhLAorCTB4
NGNmZiwKKwkweDUwODYsCisJMHg1NDhkLAorCTB4NThkNCwKKwkweDVjZmIsCisJMHg2MDJlLAor
CTB4NjQ1YSwKKwkweDY4ODksCisJMHg2Y2ZlLAorCTB4NzA1YSwKKwkweDc0OWIsCisJMHg3OGM1
LAorCTB4N2NmZiwKKwkweDgwZjAsCisJMHg4NGYwLAorCTB4ODgwOCwKK307CisKK3N0YXRpYyB1
MTYgdHBvX3NwaV9jbWRvZmZbXSA9IHsKKwkweDBjNWUsCQkvL3N0YW5kYnkKK307CisKK3N0YXRp
YyBpbnQgdHBvX2xjZF9wb3dlcihzdHJ1Y3QgcHhhMTY4ZmJfaW5mbyAqZmJpLCB1bnNpZ25lZCBp
bnQgc3BpX2dwaW9fY3MsIHVuc2lnbmVkIGludCBzcGlfZ3Bpb19yZXNldCwgaW50IG9uKQorewor
CWludCBlcnIgPSAwOworCWlmIChvbikgeworCQlpZiAoc3BpX2dwaW9fcmVzZXQgIT0gLTEpIHsK
KwkJCWVyciA9IGdwaW9fcmVxdWVzdChzcGlfZ3Bpb19yZXNldCwgIlRQT19MQ0RfU1BJX1JFU0VU
Iik7CisJCQlpZiAoZXJyKSB7CisJCQkJcHJpbnRrKCJmYWlsZWQgdG8gcmVxdWVzdCBHUElPIGZv
ciBUUE8gTENEIFJFU0VUXG4iKTsKKwkJCQlyZXR1cm4gZXJyOworCQkJfQorCQkJZ3Bpb19kaXJl
Y3Rpb25fb3V0cHV0KHNwaV9ncGlvX3Jlc2V0LCAwKTsKKwkJCW1zbGVlcCgxMDApOworCQkJZ3Bp
b19zZXRfdmFsdWUoc3BpX2dwaW9fcmVzZXQsIDEpOworCQkJbXNsZWVwKDEwMCk7CisJCQlncGlv
X2ZyZWUoc3BpX2dwaW9fcmVzZXQpOworCQl9CisJCXJldHVybiBweGExNjhmYl9zcGlfc2VuZChm
YmksIHRwb19zcGlfY21kb24sIEFSUkFZX1NJWkUodHBvX3NwaV9jbWRvbiksIHNwaV9ncGlvX2Nz
LCAwLCAxKTsKKwl9IGVsc2UKKwkJcmV0dXJuIHB4YTE2OGZiX3NwaV9zZW5kKGZiaSwgdHBvX3Nw
aV9jbWRvZmYsIEFSUkFZX1NJWkUodHBvX3NwaV9jbWRvZmYpLCBzcGlfZ3Bpb19jcywgMCwgMSk7
Cit9CisKK3N0YXRpYyBzdHJ1Y3QgZmJfdmlkZW9tb2RlIHZpZGVvX21vZGVzX2FzcGVuW10gPSB7
CisJWzBdID0geworCQkucGl4Y2xvY2sgICAgICAgPSAzMDEyMCwKKwkJLnJlZnJlc2ggICAgICAg
ID0gNjAsCisJCS54cmVzICAgICAgICAgICA9IDgwMCwKKwkJLnlyZXMgICAgICAgICAgID0gNDgw
LAorCQkuaHN5bmNfbGVuICAgICAgPSAxLAorCQkubGVmdF9tYXJnaW4gICAgPSAyMTUsCisJCS5y
aWdodF9tYXJnaW4gICA9IDQwLAorCQkudnN5bmNfbGVuICAgICAgPSAxLAorCQkudXBwZXJfbWFy
Z2luICAgPSAzNCwKKwkJLmxvd2VyX21hcmdpbiAgID0gMTAsCisJCS5zeW5jICAgICAgICAgICA9
IEZCX1NZTkNfVkVSVF9ISUdIX0FDVCB8IEZCX1NZTkNfSE9SX0hJR0hfQUNULAorCX0sCit9Owor
CitzdHJ1Y3QgcHhhMTY4ZmJfbWFjaF9pbmZvIGFzcGVuaXRlX2xjZF9pbmZvIF9faW5pdGRhdGEg
PSB7CisJLmlkICAgICAgICAgICAgICAgICAgICAgPSAiQmFzZS1hc3BlbiIsCisJLm1vZGVzICAg
ICAgICAgICAgICAgICAgPSB2aWRlb19tb2Rlc19hc3BlbiwKKwkubnVtX21vZGVzICAgICAgICAg
ICAgICA9IEFSUkFZX1NJWkUodmlkZW9fbW9kZXNfYXNwZW4pLAorCS5waXhfZm10ICAgICAgICAg
ICAgICAgID0gUElYX0ZNVF9SR0I1NjUsCisJLmlvX3Bpbl9hbGxvY2F0aW9uX21vZGUgPSBQSU5f
TU9ERV9EVU1CXzI0LAorCS5kdW1iX21vZGUgICAgICAgICAgICAgID0gRFVNQl9NT0RFX1JHQjg4
OCwKKwkuYWN0aXZlICAgICAgICAgICAgICAgICA9IDEsCisJLnNwaV9jdHJsCQk9IENGR19TQ0xL
Q05UKDIpIHwgQ0ZHX1RYQklUUygxNikgfCBDRkdfU1BJX1NFTCgxKSB8IENGR19TUElfM1c0V0Io
MSkgfCBDRkdfU1BJX0VOQSgxKSwKKwkuc3BpX2dwaW9fY3MJCT0gR1BJT19FWFQxKDE0KSwKKwku
c3BpX2dwaW9fcmVzZXQgICAgICAgICA9IC0xLAorCS5weGExNjhmYl9sY2RfcG93ZXIgICAgID0g
dHBvX2xjZF9wb3dlciwKK307CisKKyNlbmRpZgorCiAjaWYgZGVmaW5lZChDT05GSUdfTVREX05B
TkQpIHx8IGRlZmluZWQoQ09ORklHX01URF9OQU5EX01PRFVMRSkKIHN0YXRpYyBzdHJ1Y3QgbXRk
X3BhcnRpdGlvbiBhcG5fbmFuZF9wYXJ0aXRpb25zW10gPSB7CiAJewpAQCAtMTg0LDYgKzMxMiw5
IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBjb21tb25faW5pdCh2b2lkKQogCiAJLyogb24tY2hpcCBk
ZXZpY2VzICovCiAJcHhhMTY4X2FkZF91YXJ0KDEpOworI2lmZGVmIENPTkZJR19GQl9QWEExNjgK
KwlweGExNjhfYWRkX2ZiKCZhc3Blbml0ZV9sY2RfaW5mbyk7CisjZW5kaWYKIAogCWFwbl9pbml0
X25hbmQoKTsKIAlweGExNjhfYWRkX3R3c2koMCwgJnB3cmkyY19pbmZvLCBBUlJBWV9BTkRfU0la
RShhc3Blbml0ZV9pMmNfYm9hcmRfaW5mbykpOwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1t
bXAvaW5jbHVkZS9tYWNoL3B4YTE2OC5oIGIvYXJjaC9hcm0vbWFjaC1tbXAvaW5jbHVkZS9tYWNo
L3B4YTE2OC5oCmluZGV4IGQxMTdjZWIuLmQ0M2ZiMTMgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21h
Y2gtbW1wL2luY2x1ZGUvbWFjaC9weGExNjguaAorKysgYi9hcmNoL2FybS9tYWNoLW1tcC9pbmNs
dWRlL21hY2gvcHhhMTY4LmgKQEAgLTQsNiArNCw3IEBACiAjaW5jbHVkZSA8bGludXgvaTJjLmg+
CiAjaW5jbHVkZSA8bWFjaC9kZXZpY2VzLmg+CiAjaW5jbHVkZSA8cGxhdC9pMmMuaD4KKyNpbmNs
dWRlIDx2aWRlby9weGExNjhmYi5oPgogCiBleHRlcm4gc3RydWN0IHB4YV9kZXZpY2VfZGVzYyBw
eGExNjhfZGV2aWNlX3VhcnQxOwogZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNlX2Rlc2MgcHhhMTY4
X2RldmljZV91YXJ0MjsKQEAgLTE0LDYgKzE1LDcgQEAgZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNl
X2Rlc2MgcHhhMTY4X2RldmljZV9wd20yOwogZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNlX2Rlc2Mg
cHhhMTY4X2RldmljZV9wd20zOwogZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNlX2Rlc2MgcHhhMTY4
X2RldmljZV9wd200OwogZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNlX2Rlc2MgcHhhMTY4X2Rldmlj
ZV9uYW5kOworZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNlX2Rlc2MgcHhhMTY4X2RldmljZV9mYjsK
IAogc3RhdGljIGlubGluZSBpbnQgcHhhMTY4X2FkZF91YXJ0KGludCBpZCkKIHsKQEAgLTY1LDQg
KzY3LDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50IHB4YTE2OF9hZGRfcHdtKGludCBpZCkKIAogCXJl
dHVybiBweGFfcmVnaXN0ZXJfZGV2aWNlKGQsIE5VTEwsIDApOwogfQorCitzdGF0aWMgaW5saW5l
IGludCBweGExNjhfYWRkX2ZiKHN0cnVjdCBweGExNjhmYl9tYWNoX2luZm8gKm1pKQoreworCXJl
dHVybiBweGFfcmVnaXN0ZXJfZGV2aWNlKCZweGExNjhfZGV2aWNlX2ZiLCBtaSwgc2l6ZW9mKCpt
aSkpOworfQorCiAjZW5kaWYgLyogX19BU01fTUFDSF9QWEExNjhfSCAqLwpkaWZmIC0tZ2l0IGEv
YXJjaC9hcm0vbWFjaC1tbXAvcHhhMTY4LmMgYi9hcmNoL2FybS9tYWNoLW1tcC9weGExNjguYwpp
bmRleCA1OWIzOTNlLi44YmUxZTQ2IDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW1tcC9weGEx
NjguYworKysgYi9hcmNoL2FybS9tYWNoLW1tcC9weGExNjguYwpAQCAtNzQsNiArNzQsNyBAQCBz
dGF0aWMgQVBCQ19DTEsocHdtMywgUFhBMTY4X1BXTTMsIDEsIDEzMDAwMDAwKTsKIHN0YXRpYyBB
UEJDX0NMSyhwd200LCBQWEExNjhfUFdNNCwgMSwgMTMwMDAwMDApOwogCiBzdGF0aWMgQVBNVV9D
TEsobmFuZCwgTkFORCwgMHgxZGIsIDIwODAwMDAwMCk7CitzdGF0aWMgQVBNVV9DTEsobGNkLCBM
Q0QsIDB4MDAzZiwgMzEyMDAwMDAwKTsKIAogLyogZGV2aWNlIGFuZCBjbG9jayBiaW5kaW5ncyAq
Lwogc3RhdGljIHN0cnVjdCBjbGtfbG9va3VwIHB4YTE2OF9jbGtyZWdzW10gPSB7CkBAIC04Niw2
ICs4Nyw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2xrX2xvb2t1cCBweGExNjhfY2xrcmVnc1tdID0gewog
CUlOSVRfQ0xLUkVHKCZjbGtfcHdtMiwgInB4YTE2OC1wd20uMSIsIE5VTEwpLAogCUlOSVRfQ0xL
UkVHKCZjbGtfcHdtMywgInB4YTE2OC1wd20uMiIsIE5VTEwpLAogCUlOSVRfQ0xLUkVHKCZjbGtf
cHdtNCwgInB4YTE2OC1wd20uMyIsIE5VTEwpLAorCUlOSVRfQ0xLUkVHKCZjbGtfbGNkLCAicHhh
MTY4LWZiIiwgIkxDRENMSyIpLAogfTsKIAogc3RhdGljIGludCBfX2luaXQgcHhhMTY4X2luaXQo
dm9pZCkKQEAgLTEzMiwzICsxMzQsNCBAQCBQWEExNjhfREVWSUNFKHB3bTIsICJweGExNjgtcHdt
IiwgMSwgTk9ORSwgMHhkNDAxYTQwMCwgMHgxMCk7CiBQWEExNjhfREVWSUNFKHB3bTMsICJweGEx
NjgtcHdtIiwgMiwgTk9ORSwgMHhkNDAxYTgwMCwgMHgxMCk7CiBQWEExNjhfREVWSUNFKHB3bTQs
ICJweGExNjgtcHdtIiwgMywgTk9ORSwgMHhkNDAxYWMwMCwgMHgxMCk7CiBQWEExNjhfREVWSUNF
KG5hbmQsICJweGEzeHgtbmFuZCIsIC0xLCBOQU5ELCAweGQ0MjgzMDAwLCAweDIwMCwgOTcsIDk5
KTsKK1BYQTE2OF9ERVZJQ0UoZmIsICJweGExNjgtZmIiLCAtMSwgTENELCAweGQ0MjBiMDAwLCAw
eDFjOCk7Ci0tIAoxLjUuNC4zCgo=
--0016e64cd53226489f0478232c17--
