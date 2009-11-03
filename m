From: Jun Nie <niej0001@gmail.com>
Subject: Re: [PATCH 6/6] pxa: add frame buffer support on pxa168 aspenite 
	platform
Date: Tue, 3 Nov 2009 15:31:24 +0800
Message-ID: <7c34ac520911022331s5bd9233enf3f54356bdd7baaa@mail.gmail.com>
References: <7c34ac520911022245n3dda1a12nc09694d80dc93a75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7c34ac520911022245n3dda1a12nc09694d80dc93a75@mail.gmail.com>
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
> pxa: add frame buffer support on pxa168 aspenite platform
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> =A0arch/arm/configs/pxa168_defconfig =A0 =A0 =A0 | =A0 86 +++++++++++++++=
+++++-
> =A0arch/arm/mach-mmp/aspenite.c =A0 =A0 =A0 =A0 =A0 =A0| =A0132 +++++++++=
++++++++++++++++++++++
> =A0arch/arm/mach-mmp/include/mach/pxa168.h | =A0 =A08 ++
> =A0arch/arm/mach-mmp/pxa168.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A03 +
> =A04 files changed, 227 insertions(+), 2 deletions(-)
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
> index b422bb5..76a57dc 100644
> --- a/arch/arm/mach-mmp/aspenite.c
> +++ b/arch/arm/mach-mmp/aspenite.c
> @@ -17,12 +17,14 @@
> =A0#include <linux/mtd/partitions.h>
> =A0#include <linux/mtd/nand.h>
> =A0#include <linux/i2c/pca953x.h>
> +#include <linux/delay.h>
>
> =A0#include <asm/mach-types.h>
> =A0#include <asm/mach/arch.h>
> =A0#include <mach/addr-map.h>
> =A0#include <mach/mfp-pxa168.h>
> =A0#include <mach/pxa168.h>
> +#include <mach/pxa168fb.h>
> =A0#include <mach/gpio.h>
> =A0#include <plat/pxa3xx_nand.h>
> =A0#include <video/pxa168fb.h>
> @@ -66,6 +68,39 @@ static unsigned long common_pin_config[] __initdata =
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
> @@ -95,6 +130,100 @@ static struct platform_device smc91x_device =3D {
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pxa168fb_spi_send(fbi, tpo_spi_cmdon,
> ARRAY_SIZE(tpo_spi_cmdon), spi_gpio_cs, 1);
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pxa168fb_spi_send(fbi, tpo_spi_cmdof=
f,
> ARRAY_SIZE(tpo_spi_cmdoff), spi_gpio_cs, 1);
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sync =A0 =A0 =A0 =A0 =A0 =3D 0,
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
> @@ -184,6 +313,9 @@ static void __init common_init(void)
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

add linux-fbdev@vger.kernel.org
