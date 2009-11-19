From: Jun Nie <niej0001@gmail.com>
Date: Thu, 19 Nov 2009 09:04:14 +0000
Subject: Re: [PATCH 8/8] pxa: add frame buffer on pxa910 ttc_dkb platform
Message-Id: <7c34ac520911190104n664ae2a2u31a4fdb63385da7c@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0016e64dbbd0bbb8ff0478b5a498"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911160135x2133c734ub15db7abc64b22a3@mail.gmail.com>
In-Reply-To: <7c34ac520911160135x2133c734ub15db7abc64b22a3@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--0016e64dbbd0bbb8ff0478b5a498
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2009/11/16 Jun Nie <niej0001@gmail.com>:
> From: Jun Nie <njun@marvell.com>
> Date: Fri, 13 Nov 2009 15:07:45 +0800
> Subject: [PATCH] pxa: add frame buffer on pxa910 ttc_dkb platform
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> =A0arch/arm/configs/pxa910_defconfig =A0 =A0 =A0 | =A0 39 ++++++++-
> =A0arch/arm/mach-mmp/include/mach/pxa910.h | =A0 =A08 ++
> =A0arch/arm/mach-mmp/pxa910.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 +
> =A0arch/arm/mach-mmp/ttc_dkb.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0144 +++++++++=
++++++++++++++++++++++
> =A04 files changed, 194 insertions(+), 1 deletions(-)
>
> diff --git a/arch/arm/configs/pxa910_defconfig
> b/arch/arm/configs/pxa910_defconfig
> index 8c7e299..b9b1a85 100644
> --- a/arch/arm/configs/pxa910_defconfig
> +++ b/arch/arm/configs/pxa910_defconfig
> @@ -578,7 +578,34 @@ CONFIG_SSB_POSSIBLE=3Dy
> =A0#
> =A0# CONFIG_VGASTATE is not set
> =A0# CONFIG_VIDEO_OUTPUT_CONTROL is not set
> -# CONFIG_FB is not set
> +CONFIG_FB=3Dy
> +# CONFIG_FIRMWARE_EDID is not set
> +# CONFIG_FB_DDC is not set
> +# CONFIG_FB_BOOT_VESA_SUPPORT is not set
> +CONFIG_FB_CFB_FILLRECT=3Dy
> +CONFIG_FB_CFB_COPYAREA=3Dy
> +CONFIG_FB_CFB_IMAGEBLIT=3Dy
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
> @@ -591,6 +618,16 @@ CONFIG_SSB_POSSIBLE=3Dy
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
> diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h
> b/arch/arm/mach-mmp/include/mach/pxa910.h
> index 6ae1ed7..7698793 100644
> --- a/arch/arm/mach-mmp/include/mach/pxa910.h
> +++ b/arch/arm/mach-mmp/include/mach/pxa910.h
> @@ -4,6 +4,7 @@
> =A0#include <linux/i2c.h>
> =A0#include <mach/devices.h>
> =A0#include <plat/i2c.h>
> +#include <video/pxa168fb.h>
>
> =A0extern struct pxa_device_desc pxa910_device_uart1;
> =A0extern struct pxa_device_desc pxa910_device_uart2;
> @@ -13,6 +14,7 @@ extern struct pxa_device_desc pxa910_device_pwm1;
> =A0extern struct pxa_device_desc pxa910_device_pwm2;
> =A0extern struct pxa_device_desc pxa910_device_pwm3;
> =A0extern struct pxa_device_desc pxa910_device_pwm4;
> +extern struct pxa_device_desc pxa910_device_fb;
>
> =A0static inline int pxa910_add_uart(int id)
> =A0{
> @@ -64,4 +66,10 @@ static inline int pxa910_add_pwm(int id)
>
> =A0 =A0 =A0 =A0return pxa_register_device(d, NULL, 0);
> =A0}
> +
> +static inline int pxa910_add_fb(struct pxa168fb_mach_info *mi)
> +{
> + =A0 =A0 =A0 return pxa_register_device(&pxa910_device_fb, mi, sizeof(*m=
i));
> +}
> +
> =A0#endif /* __ASM_MACH_PXA910_H */
> diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
> index 5882ca6..48162a0 100644
> --- a/arch/arm/mach-mmp/pxa910.c
> +++ b/arch/arm/mach-mmp/pxa910.c
> @@ -110,6 +110,8 @@ static APBC_CLK(pwm2, PXA910_PWM2, 1, 13000000);
> =A0static APBC_CLK(pwm3, PXA910_PWM3, 1, 13000000);
> =A0static APBC_CLK(pwm4, PXA910_PWM4, 1, 13000000);
>
> +static APMU_CLK(lcd, LCD, 0x003f, 312000000);
> +
> =A0/* device and clock bindings */
> =A0static struct clk_lookup pxa910_clkregs[] =3D {
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
> @@ -120,6 +122,7 @@ static struct clk_lookup pxa910_clkregs[] =3D {
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_pwm2, "pxa910-pwm.1", NULL),
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_pwm3, "pxa910-pwm.2", NULL),
> =A0 =A0 =A0 =A0INIT_CLKREG(&clk_pwm4, "pxa910-pwm.3", NULL),
> + =A0 =A0 =A0 INIT_CLKREG(&clk_lcd, "pxa910-fb", "LCDCLK"),
> =A0};
>
> =A0static int __init pxa910_init(void)
> @@ -174,3 +177,4 @@ PXA910_DEVICE(pwm1, "pxa910-pwm", 0, NONE,
> 0xd401a000, 0x10);
> =A0PXA910_DEVICE(pwm2, "pxa910-pwm", 1, NONE, 0xd401a400, 0x10);
> =A0PXA910_DEVICE(pwm3, "pxa910-pwm", 2, NONE, 0xd401a800, 0x10);
> =A0PXA910_DEVICE(pwm4, "pxa910-pwm", 3, NONE, 0xd401ac00, 0x10);
> +PXA910_DEVICE(fb, "pxa910-fb", -1, LCD, 0xd420b000, 0x1c8);
> diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
> index dbd8cfd..15e64b4 100644
> --- a/arch/arm/mach-mmp/ttc_dkb.c
> +++ b/arch/arm/mach-mmp/ttc_dkb.c
> @@ -14,6 +14,8 @@
> =A0#include <linux/mtd/mtd.h>
> =A0#include <linux/mtd/partitions.h>
> =A0#include <linux/mtd/onenand.h>
> +#include <linux/delay.h>
> +#include <video/pxa168fb.h>
>
> =A0#include <asm/mach-types.h>
> =A0#include <asm/mach/arch.h>
> @@ -21,6 +23,7 @@
> =A0#include <mach/addr-map.h>
> =A0#include <mach/mfp-pxa910.h>
> =A0#include <mach/pxa910.h>
> +#include <mach/gpio.h>
>
> =A0#include "common.h"
>
> @@ -54,8 +57,146 @@ static unsigned long ttc_dkb_pin_config[] __initdata =
=3D {
> =A0 =A0 =A0 =A0DF_WEn_DF_WEn,
> =A0 =A0 =A0 =A0DF_REn_DF_REn,
> =A0 =A0 =A0 =A0DF_RDY0_DF_RDY0,
> +
> +#ifdef CONFIG_FB_PXA168
> + =A0 =A0 =A0 /* LCD */
> + =A0 =A0 =A0 GPIO81_LCD_FCLK,
> + =A0 =A0 =A0 GPIO82_LCD_LCLK,
> + =A0 =A0 =A0 GPIO83_LCD_PCLK,
> + =A0 =A0 =A0 GPIO84_LCD_DENA,
> + =A0 =A0 =A0 GPIO85_LCD_DD0,
> + =A0 =A0 =A0 GPIO86_LCD_DD1,
> + =A0 =A0 =A0 GPIO87_LCD_DD2,
> + =A0 =A0 =A0 GPIO88_LCD_DD3,
> + =A0 =A0 =A0 GPIO89_LCD_DD4,
> + =A0 =A0 =A0 GPIO90_LCD_DD5,
> + =A0 =A0 =A0 GPIO91_LCD_DD6,
> + =A0 =A0 =A0 GPIO92_LCD_DD7,
> + =A0 =A0 =A0 GPIO93_LCD_DD8,
> + =A0 =A0 =A0 GPIO94_LCD_DD9,
> + =A0 =A0 =A0 GPIO95_LCD_DD10,
> + =A0 =A0 =A0 GPIO96_LCD_DD11,
> + =A0 =A0 =A0 GPIO97_LCD_DD12,
> + =A0 =A0 =A0 GPIO98_LCD_DD13,
> + =A0 =A0 =A0 GPIO100_LCD_DD14,
> + =A0 =A0 =A0 GPIO101_LCD_DD15,
> + =A0 =A0 =A0 GPIO102_LCD_DD16,
> + =A0 =A0 =A0 GPIO103_LCD_DD17,
> + =A0 =A0 =A0 GPIO104_LCD_SPIDOUT,
> + =A0 =A0 =A0 GPIO105_LCD_SPIDIN,
> + =A0 =A0 =A0 GPIO107_LCD_CS1,
> + =A0 =A0 =A0 GPIO108_LCD_DCLK,
> + =A0 =A0 =A0 GPIO106_LCD_RESET,
> +#endif
> +};
> +
> +#ifdef CONFIG_FB_PXA168
> +static u16 tpo_spi_cmdon[] =3D {
> + =A0 =A0 =A0 0x0801,
> + =A0 =A0 =A0 0x0800,
> + =A0 =A0 =A0 0x0200,
> + =A0 =A0 =A0 0x0304,
> + =A0 =A0 =A0 0x040e,
> + =A0 =A0 =A0 0x0903,
> + =A0 =A0 =A0 0x0b18,
> + =A0 =A0 =A0 0x0c53,
> + =A0 =A0 =A0 0x0d01,
> + =A0 =A0 =A0 0x0ee0,
> + =A0 =A0 =A0 0x0f01,
> + =A0 =A0 =A0 0x1058,
> + =A0 =A0 =A0 0x201e,
> + =A0 =A0 =A0 0x210a,
> + =A0 =A0 =A0 0x220a,
> + =A0 =A0 =A0 0x231e,
> + =A0 =A0 =A0 0x2400,
> + =A0 =A0 =A0 0x2532,
> + =A0 =A0 =A0 0x2600,
> + =A0 =A0 =A0 0x27ac,
> + =A0 =A0 =A0 0x2904,
> + =A0 =A0 =A0 0x2aa2,
> + =A0 =A0 =A0 0x2b45,
> + =A0 =A0 =A0 0x2c45,
> + =A0 =A0 =A0 0x2d15,
> + =A0 =A0 =A0 0x2e5a,
> + =A0 =A0 =A0 0x2fff,
> + =A0 =A0 =A0 0x306b,
> + =A0 =A0 =A0 0x310d,
> + =A0 =A0 =A0 0x3248,
> + =A0 =A0 =A0 0x3382,
> + =A0 =A0 =A0 0x34bd,
> + =A0 =A0 =A0 0x35e7,
> + =A0 =A0 =A0 0x3618,
> + =A0 =A0 =A0 0x3794,
> + =A0 =A0 =A0 0x3801,
> + =A0 =A0 =A0 0x395d,
> + =A0 =A0 =A0 0x3aae,
> + =A0 =A0 =A0 0x3bff,
> + =A0 =A0 =A0 0x07c9, =A0 =A0 =A0 =A0 /* auto power on */
> +};
> +
> +static u16 tpo_spi_cmdoff[] =3D {
> + =A0 =A0 =A0 0x07d9, =A0 =A0 =A0 =A0 /* auto power off */
> +};
> +
> +static int tpo_lcd_power(struct pxa168fb_info *fbi, unsigned int spi_gpi=
o_cs,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigned int spi_gpio_reset, int on)
> +{
> + =A0 =A0 =A0 int err =3D 0;
> +
> + =A0 =A0 =A0 if (on) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi_gpio_reset !=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D gpio_request(spi_gp=
io_reset, "TPO_LCD_SPI_RESET");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN=
_ERR "failed to request GPIO for TPO LCD RESET\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EIO=
;
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(=
tpo_spi_cmdon), spi_gpio_cs, 0, 40);
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pxa168fb_spi_send(fbi, tpo_spi_cmdof=
f,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ARRAY_SIZE(=
tpo_spi_cmdoff), spi_gpio_cs, 0, 0);
> +}
> +
> +static struct fb_videomode video_modes[] =3D {
> + =A0 =A0 =A0 /* lpj032l001b HVGA mode info */
> + =A0 =A0 =A0 [0] =3D {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .pixclock =A0 =A0 =A0 =3D 100000,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .refresh =A0 =A0 =A0 =A0=3D 60,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .xres =A0 =A0 =A0 =A0 =A0 =3D 320,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .yres =A0 =A0 =A0 =A0 =A0 =3D 480,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .hsync_len =A0 =A0 =A0=3D 10,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .left_margin =A0 =A0=3D 15,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .right_margin =A0 =3D 10,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .vsync_len =A0 =A0 =A0=3D 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .upper_margin =A0 =3D 4,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .lower_margin =A0 =3D 2,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sync =A0 =A0 =A0 =A0 =A0 =3D 0,
> + =A0 =A0 =A0 },
> =A0};
>
> +static struct pxa168fb_mach_info ttc_dkb_lcd_info __initdata =3D {
> + =A0 =A0 =A0 .id =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D "Base",
> + =A0 =A0 =A0 .modes =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D video_modes,
> + =A0 =A0 =A0 .num_modes =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D ARRAY_SIZE(video_=
modes),
> + =A0 =A0 =A0 .pix_fmt =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D PIX_FMT_RGB565,
> + =A0 =A0 =A0 .io_pin_allocation_mode =3D PIN_MODE_DUMB_18_SPI,
> + =A0 =A0 =A0 .dumb_mode =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D DUMB_MODE_RGB666,
> + =A0 =A0 =A0 .active =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 1,
> + =A0 =A0 =A0 .spi_ctrl =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D CFG_SCLKCNT(16) |=
 CFG_TXBITS(16) |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 CFG_SPI_SEL(1) | CFG_SPI_3W4WB(1) | CFG_SPI=
_ENA(1),
> + =A0 =A0 =A0 .spi_gpio_cs =A0 =A0 =A0 =A0 =A0 =A0=3D -1,
> + =A0 =A0 =A0 .spi_gpio_reset =A0 =A0 =A0 =A0 =3D mfp_to_gpio(MFP_PIN_GPI=
O106),
> + =A0 =A0 =A0 .invert_pixclock =A0 =A0 =A0 =A0=3D 1,
> + =A0 =A0 =A0 .pxa168fb_lcd_power =A0 =A0 =3D tpo_lcd_power,
> +};
> +#endif
> +
> =A0#if defined(CONFIG_MTD_ONENAND) || defined(CONFIG_MTD_ONENAND_MODULE)
> =A0static struct mtd_partition ttc_dkb_onenand_partitions[] =3D {
> =A0 =A0 =A0 =A0{
> @@ -123,6 +264,9 @@ static void __init ttc_dkb_init(void)
>
> =A0 =A0 =A0 =A0/* on-chip devices */
> =A0 =A0 =A0 =A0pxa910_add_uart(1);
> +#ifdef CONFIG_FB_PXA168
> + =A0 =A0 =A0 pxa910_add_fb(&ttc_dkb_lcd_info);
> +#endif
>
> =A0 =A0 =A0 =A0/* off-chip devices */
> =A0 =A0 =A0 =A0ttc_dkb_init_onenand();
> --
> 1.5.4.3
>

rebased
From 5dc9fd01c311d4f263f8a1c67f03c569f6dd2b81 Mon Sep 17 00:00:00 2001
From: Jun Nie <njun@marvell.com>
Date: Tue, 17 Nov 2009 20:14:01 +0800
Subject: [PATCH] pxa: add frame buffer on pxa910 ttc_dkb platform

Signed-off-by: Jun Nie <njun@marvell.com>
---
 arch/arm/configs/pxa910_defconfig       |   39 ++++++++-
 arch/arm/mach-mmp/include/mach/pxa910.h |    7 ++
 arch/arm/mach-mmp/pxa910.c              |    4 +
 arch/arm/mach-mmp/ttc_dkb.c             |  144 +++++++++++++++++++++++++++=
++++
 4 files changed, 193 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/pxa910_defconfig
b/arch/arm/configs/pxa910_defconfig
index 8c7e299..b9b1a85 100644
--- a/arch/arm/configs/pxa910_defconfig
+++ b/arch/arm/configs/pxa910_defconfig
@@ -578,7 +578,34 @@ CONFIG_SSB_POSSIBLE=3Dy
 #
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
+CONFIG_FB=3Dy
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
+CONFIG_FB_CFB_FILLRECT=3Dy
+CONFIG_FB_CFB_COPYAREA=3Dy
+CONFIG_FB_CFB_IMAGEBLIT=3Dy
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
+# CONFIG_FB_SVGALIB is not set
+# CONFIG_FB_MACMODES is not set
+# CONFIG_FB_BACKLIGHT is not set
+# CONFIG_FB_MODE_HELPERS is not set
+# CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
+# CONFIG_FB_S1D13XXX is not set
+CONFIG_FB_PXA168=3Dy
+# CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
+# CONFIG_FB_MB862XX is not set
+# CONFIG_FB_BROADSHEET is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set

 #
@@ -591,6 +618,16 @@ CONFIG_SSB_POSSIBLE=3Dy
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=3Dy
+CONFIG_FRAMEBUFFER_CONSOLE=3Dy
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=3Dy
+CONFIG_FONT_8x16=3Dy
+CONFIG_LOGO=3Dy
+# CONFIG_LOGO_LINUX_MONO is not set
+CONFIG_LOGO_LINUX_VGA16=3Dy
+CONFIG_LOGO_LINUX_CLUT224=3Dy
 # CONFIG_SOUND is not set
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h
b/arch/arm/mach-mmp/include/mach/pxa910.h
index 6ae1ed7..64148f2 100644
--- a/arch/arm/mach-mmp/include/mach/pxa910.h
+++ b/arch/arm/mach-mmp/include/mach/pxa910.h
@@ -4,6 +4,7 @@
 #include <linux/i2c.h>
 #include <mach/devices.h>
 #include <plat/i2c.h>
+#include <video/pxa168fb.h>

 extern struct pxa_device_desc pxa910_device_uart1;
 extern struct pxa_device_desc pxa910_device_uart2;
@@ -13,6 +14,7 @@ extern struct pxa_device_desc pxa910_device_pwm1;
 extern struct pxa_device_desc pxa910_device_pwm2;
 extern struct pxa_device_desc pxa910_device_pwm3;
 extern struct pxa_device_desc pxa910_device_pwm4;
+extern struct pxa_device_desc pxa910_device_fb;

 static inline int pxa910_add_uart(int id)
 {
@@ -64,4 +66,9 @@ static inline int pxa910_add_pwm(int id)

 	return pxa_register_device(d, NULL, 0);
 }
+
+static inline int pxa910_add_fb(struct pxa168fb_mach_info *mi)
+{
+	return pxa_register_device(&pxa910_device_fb, mi, sizeof(*mi));
+}
 #endif /* __ASM_MACH_PXA910_H */
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 5882ca6..48162a0 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -110,6 +110,8 @@ static APBC_CLK(pwm2, PXA910_PWM2, 1, 13000000);
 static APBC_CLK(pwm3, PXA910_PWM3, 1, 13000000);
 static APBC_CLK(pwm4, PXA910_PWM4, 1, 13000000);

+static APMU_CLK(lcd, LCD, 0x003f, 312000000);
+
 /* device and clock bindings */
 static struct clk_lookup pxa910_clkregs[] =3D {
 	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
@@ -120,6 +122,7 @@ static struct clk_lookup pxa910_clkregs[] =3D {
 	INIT_CLKREG(&clk_pwm2, "pxa910-pwm.1", NULL),
 	INIT_CLKREG(&clk_pwm3, "pxa910-pwm.2", NULL),
 	INIT_CLKREG(&clk_pwm4, "pxa910-pwm.3", NULL),
+	INIT_CLKREG(&clk_lcd, "pxa910-fb", "LCDCLK"),
 };

 static int __init pxa910_init(void)
@@ -174,3 +177,4 @@ PXA910_DEVICE(pwm1, "pxa910-pwm", 0, NONE,
0xd401a000, 0x10);
 PXA910_DEVICE(pwm2, "pxa910-pwm", 1, NONE, 0xd401a400, 0x10);
 PXA910_DEVICE(pwm3, "pxa910-pwm", 2, NONE, 0xd401a800, 0x10);
 PXA910_DEVICE(pwm4, "pxa910-pwm", 3, NONE, 0xd401ac00, 0x10);
+PXA910_DEVICE(fb, "pxa910-fb", -1, LCD, 0xd420b000, 0x1c8);
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 08cfef6..ac429cd 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -11,7 +11,10 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/platform_device.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>

+#include <video/pxa168fb.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/addr-map.h>
@@ -26,11 +29,152 @@ static unsigned long ttc_dkb_pin_config[] __initdata =
=3D {
 	/* UART2 */
 	GPIO47_UART2_RXD,
 	GPIO48_UART2_TXD,
+
+#ifdef CONFIG_FB_PXA168
+	/* LCD */
+	GPIO81_LCD_FCLK,
+	GPIO82_LCD_LCLK,
+	GPIO83_LCD_PCLK,
+	GPIO84_LCD_DENA,
+	GPIO85_LCD_DD0,
+	GPIO86_LCD_DD1,
+	GPIO87_LCD_DD2,
+	GPIO88_LCD_DD3,
+	GPIO89_LCD_DD4,
+	GPIO90_LCD_DD5,
+	GPIO91_LCD_DD6,
+	GPIO92_LCD_DD7,
+	GPIO93_LCD_DD8,
+	GPIO94_LCD_DD9,
+	GPIO95_LCD_DD10,
+	GPIO96_LCD_DD11,
+	GPIO97_LCD_DD12,
+	GPIO98_LCD_DD13,
+	GPIO100_LCD_DD14,
+	GPIO101_LCD_DD15,
+	GPIO102_LCD_DD16,
+	GPIO103_LCD_DD17,
+	GPIO104_LCD_SPIDOUT,
+	GPIO105_LCD_SPIDIN,
+	GPIO107_LCD_CS1,
+	GPIO108_LCD_DCLK,
+	GPIO106_LCD_RESET,
+#endif
+};
+
+#ifdef CONFIG_FB_PXA168
+static u16 tpo_spi_cmdon[] =3D {
+	0x0801,
+	0x0800,
+	0x0200,
+	0x0304,
+	0x040e,
+	0x0903,
+	0x0b18,
+	0x0c53,
+	0x0d01,
+	0x0ee0,
+	0x0f01,
+	0x1058,
+	0x201e,
+	0x210a,
+	0x220a,
+	0x231e,
+	0x2400,
+	0x2532,
+	0x2600,
+	0x27ac,
+	0x2904,
+	0x2aa2,
+	0x2b45,
+	0x2c45,
+	0x2d15,
+	0x2e5a,
+	0x2fff,
+	0x306b,
+	0x310d,
+	0x3248,
+	0x3382,
+	0x34bd,
+	0x35e7,
+	0x3618,
+	0x3794,
+	0x3801,
+	0x395d,
+	0x3aae,
+	0x3bff,
+	0x07c9,		/* auto power on */
+};
+
+static u16 tpo_spi_cmdoff[] =3D {
+	0x07d9,		/* auto power off */
+};
+
+static int tpo_lcd_power(struct pxa168fb_info *fbi, unsigned int spi_gpio_=
cs,
+		unsigned int spi_gpio_reset, int on)
+{
+	int err =3D 0;
+
+	if (on) {
+		if (spi_gpio_reset !=3D -1) {
+			err =3D gpio_request(spi_gpio_reset, "TPO_LCD_SPI_RESET");
+			if (err) {
+				printk(KERN_ERR "failed to request GPIO for TPO LCD RESET\n");
+				return -EIO;
+			}
+			gpio_direction_output(spi_gpio_reset, 0);
+			msleep(100);
+			gpio_set_value(spi_gpio_reset, 1);
+			msleep(100);
+			gpio_free(spi_gpio_reset);
+		}
+		return pxa168fb_spi_send(fbi, tpo_spi_cmdon,
+				ARRAY_SIZE(tpo_spi_cmdon), spi_gpio_cs, 0, 40);
+	} else
+		return pxa168fb_spi_send(fbi, tpo_spi_cmdoff,
+				ARRAY_SIZE(tpo_spi_cmdoff), spi_gpio_cs, 0, 0);
+}
+
+static struct fb_videomode video_modes[] =3D {
+	/* lpj032l001b HVGA mode info */
+	[0] =3D {
+		.pixclock       =3D 100000,
+		.refresh        =3D 60,
+		.xres           =3D 320,
+		.yres           =3D 480,
+		.hsync_len      =3D 10,
+		.left_margin    =3D 15,
+		.right_margin   =3D 10,
+		.vsync_len      =3D 2,
+		.upper_margin   =3D 4,
+		.lower_margin   =3D 2,
+		.sync           =3D 0,
+	},
+};
+
+static struct pxa168fb_mach_info ttc_dkb_lcd_info __initdata =3D {
+	.id                     =3D "Base",
+	.modes                  =3D video_modes,
+	.num_modes              =3D ARRAY_SIZE(video_modes),
+	.pix_fmt                =3D PIX_FMT_RGB565,
+	.io_pin_allocation_mode =3D PIN_MODE_DUMB_18_SPI,
+	.dumb_mode              =3D DUMB_MODE_RGB666,
+	.active                 =3D 1,
+	.spi_ctrl               =3D CFG_SCLKCNT(16) | CFG_TXBITS(16) |
+		CFG_SPI_SEL(1) | CFG_SPI_3W4WB(1) | CFG_SPI_ENA(1),
+	.spi_gpio_cs            =3D -1,
+	.spi_gpio_reset		=3D mfp_to_gpio(MFP_PIN_GPIO106),
+	.invert_pixclock	=3D 1,
+	.pxa168fb_lcd_power	=3D tpo_lcd_power,
 };
+#endif

 static void __init ttc_dkb_init(void)
 {
 	mfp_config(ARRAY_AND_SIZE(ttc_dkb_pin_config));
+#ifdef CONFIG_FB_PXA168
+	pxa910_add_fb(&ttc_dkb_lcd_info);
+#endif

 	/* on-chip devices */
 	pxa910_add_uart(1);
--=20
1.5.4.3

--0016e64dbbd0bbb8ff0478b5a498
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0008-pxa-add-frame-buffer-on-pxa910-ttc_dkb-platform.patch"
Content-Disposition: attachment; 
	filename="0008-pxa-add-frame-buffer-on-pxa910-ttc_dkb-platform.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g27anuzs0

RnJvbSA1ZGM5ZmQwMWMzMTFkNGYyNjNmOGExYzY3ZjAzYzU2OWY2ZGQyYjgxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUdWUs
IDE3IE5vdiAyMDA5IDIwOjE0OjAxICswODAwClN1YmplY3Q6IFtQQVRDSF0gcHhhOiBhZGQgZnJh
bWUgYnVmZmVyIG9uIHB4YTkxMCB0dGNfZGtiIHBsYXRmb3JtCgpTaWduZWQtb2ZmLWJ5OiBKdW4g
TmllIDxuanVuQG1hcnZlbGwuY29tPgotLS0KIGFyY2gvYXJtL2NvbmZpZ3MvcHhhOTEwX2RlZmNv
bmZpZyAgICAgICB8ICAgMzkgKysrKysrKystCiBhcmNoL2FybS9tYWNoLW1tcC9pbmNsdWRlL21h
Y2gvcHhhOTEwLmggfCAgICA3ICsrCiBhcmNoL2FybS9tYWNoLW1tcC9weGE5MTAuYyAgICAgICAg
ICAgICAgfCAgICA0ICsKIGFyY2gvYXJtL21hY2gtbW1wL3R0Y19ka2IuYyAgICAgICAgICAgICB8
ICAxNDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogNCBmaWxlcyBjaGFuZ2VkLCAx
OTMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9j
b25maWdzL3B4YTkxMF9kZWZjb25maWcgYi9hcmNoL2FybS9jb25maWdzL3B4YTkxMF9kZWZjb25m
aWcKaW5kZXggOGM3ZTI5OS4uYjliMWE4NSAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vY29uZmlncy9w
eGE5MTBfZGVmY29uZmlnCisrKyBiL2FyY2gvYXJtL2NvbmZpZ3MvcHhhOTEwX2RlZmNvbmZpZwpA
QCAtNTc4LDcgKzU3OCwzNCBAQCBDT05GSUdfU1NCX1BPU1NJQkxFPXkKICMKICMgQ09ORklHX1ZH
QVNUQVRFIGlzIG5vdCBzZXQKICMgQ09ORklHX1ZJREVPX09VVFBVVF9DT05UUk9MIGlzIG5vdCBz
ZXQKLSMgQ09ORklHX0ZCIGlzIG5vdCBzZXQKK0NPTkZJR19GQj15CisjIENPTkZJR19GSVJNV0FS
RV9FRElEIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX0REQyBpcyBub3Qgc2V0CisjIENPTkZJR19G
Ql9CT09UX1ZFU0FfU1VQUE9SVCBpcyBub3Qgc2V0CitDT05GSUdfRkJfQ0ZCX0ZJTExSRUNUPXkK
K0NPTkZJR19GQl9DRkJfQ09QWUFSRUE9eQorQ09ORklHX0ZCX0NGQl9JTUFHRUJMSVQ9eQorIyBD
T05GSUdfRkJfQ0ZCX1JFVl9QSVhFTFNfSU5fQllURSBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9T
WVNfRklMTFJFQ1QgaXMgbm90IHNldAorIyBDT05GSUdfRkJfU1lTX0NPUFlBUkVBIGlzIG5vdCBz
ZXQKKyMgQ09ORklHX0ZCX1NZU19JTUFHRUJMSVQgaXMgbm90IHNldAorIyBDT05GSUdfRkJfRk9S
RUlHTl9FTkRJQU4gaXMgbm90IHNldAorIyBDT05GSUdfRkJfU1lTX0ZPUFMgaXMgbm90IHNldAor
IyBDT05GSUdfRkJfU1ZHQUxJQiBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9NQUNNT0RFUyBpcyBu
b3Qgc2V0CisjIENPTkZJR19GQl9CQUNLTElHSFQgaXMgbm90IHNldAorIyBDT05GSUdfRkJfTU9E
RV9IRUxQRVJTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX1RJTEVCTElUVElORyBpcyBub3Qgc2V0
CisKKyMKKyMgRnJhbWUgYnVmZmVyIGhhcmR3YXJlIGRyaXZlcnMKKyMKKyMgQ09ORklHX0ZCX1Mx
RDEzWFhYIGlzIG5vdCBzZXQKK0NPTkZJR19GQl9QWEExNjg9eQorIyBDT05GSUdfRkJfVklSVFVB
TCBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9NRVRST05PTUUgaXMgbm90IHNldAorIyBDT05GSUdf
RkJfTUI4NjJYWCBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9CUk9BRFNIRUVUIGlzIG5vdCBzZXQK
ICMgQ09ORklHX0JBQ0tMSUdIVF9MQ0RfU1VQUE9SVCBpcyBub3Qgc2V0CiAKICMKQEAgLTU5MSw2
ICs2MTgsMTYgQEAgQ09ORklHX1NTQl9QT1NTSUJMRT15CiAjCiAjIENPTkZJR19WR0FfQ09OU09M
RSBpcyBub3Qgc2V0CiBDT05GSUdfRFVNTVlfQ09OU09MRT15CitDT05GSUdfRlJBTUVCVUZGRVJf
Q09OU09MRT15CitDT05GSUdfRlJBTUVCVUZGRVJfQ09OU09MRV9ERVRFQ1RfUFJJTUFSWT15Cisj
IENPTkZJR19GUkFNRUJVRkZFUl9DT05TT0xFX1JPVEFUSU9OIGlzIG5vdCBzZXQKKyMgQ09ORklH
X0ZPTlRTIGlzIG5vdCBzZXQKK0NPTkZJR19GT05UXzh4OD15CitDT05GSUdfRk9OVF84eDE2PXkK
K0NPTkZJR19MT0dPPXkKKyMgQ09ORklHX0xPR09fTElOVVhfTU9OTyBpcyBub3Qgc2V0CitDT05G
SUdfTE9HT19MSU5VWF9WR0ExNj15CitDT05GSUdfTE9HT19MSU5VWF9DTFVUMjI0PXkKICMgQ09O
RklHX1NPVU5EIGlzIG5vdCBzZXQKICMgQ09ORklHX0hJRF9TVVBQT1JUIGlzIG5vdCBzZXQKICMg
Q09ORklHX1VTQl9TVVBQT1JUIGlzIG5vdCBzZXQKZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gt
bW1wL2luY2x1ZGUvbWFjaC9weGE5MTAuaCBiL2FyY2gvYXJtL21hY2gtbW1wL2luY2x1ZGUvbWFj
aC9weGE5MTAuaAppbmRleCA2YWUxZWQ3Li42NDE0OGYyIDEwMDY0NAotLS0gYS9hcmNoL2FybS9t
YWNoLW1tcC9pbmNsdWRlL21hY2gvcHhhOTEwLmgKKysrIGIvYXJjaC9hcm0vbWFjaC1tbXAvaW5j
bHVkZS9tYWNoL3B4YTkxMC5oCkBAIC00LDYgKzQsNyBAQAogI2luY2x1ZGUgPGxpbnV4L2kyYy5o
PgogI2luY2x1ZGUgPG1hY2gvZGV2aWNlcy5oPgogI2luY2x1ZGUgPHBsYXQvaTJjLmg+CisjaW5j
bHVkZSA8dmlkZW8vcHhhMTY4ZmIuaD4KIAogZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNlX2Rlc2Mg
cHhhOTEwX2RldmljZV91YXJ0MTsKIGV4dGVybiBzdHJ1Y3QgcHhhX2RldmljZV9kZXNjIHB4YTkx
MF9kZXZpY2VfdWFydDI7CkBAIC0xMyw2ICsxNCw3IEBAIGV4dGVybiBzdHJ1Y3QgcHhhX2Rldmlj
ZV9kZXNjIHB4YTkxMF9kZXZpY2VfcHdtMTsKIGV4dGVybiBzdHJ1Y3QgcHhhX2RldmljZV9kZXNj
IHB4YTkxMF9kZXZpY2VfcHdtMjsKIGV4dGVybiBzdHJ1Y3QgcHhhX2RldmljZV9kZXNjIHB4YTkx
MF9kZXZpY2VfcHdtMzsKIGV4dGVybiBzdHJ1Y3QgcHhhX2RldmljZV9kZXNjIHB4YTkxMF9kZXZp
Y2VfcHdtNDsKK2V4dGVybiBzdHJ1Y3QgcHhhX2RldmljZV9kZXNjIHB4YTkxMF9kZXZpY2VfZmI7
CiAKIHN0YXRpYyBpbmxpbmUgaW50IHB4YTkxMF9hZGRfdWFydChpbnQgaWQpCiB7CkBAIC02NCw0
ICs2Niw5IEBAIHN0YXRpYyBpbmxpbmUgaW50IHB4YTkxMF9hZGRfcHdtKGludCBpZCkKIAogCXJl
dHVybiBweGFfcmVnaXN0ZXJfZGV2aWNlKGQsIE5VTEwsIDApOwogfQorCitzdGF0aWMgaW5saW5l
IGludCBweGE5MTBfYWRkX2ZiKHN0cnVjdCBweGExNjhmYl9tYWNoX2luZm8gKm1pKQoreworCXJl
dHVybiBweGFfcmVnaXN0ZXJfZGV2aWNlKCZweGE5MTBfZGV2aWNlX2ZiLCBtaSwgc2l6ZW9mKCpt
aSkpOworfQogI2VuZGlmIC8qIF9fQVNNX01BQ0hfUFhBOTEwX0ggKi8KZGlmZiAtLWdpdCBhL2Fy
Y2gvYXJtL21hY2gtbW1wL3B4YTkxMC5jIGIvYXJjaC9hcm0vbWFjaC1tbXAvcHhhOTEwLmMKaW5k
ZXggNTg4MmNhNi4uNDgxNjJhMCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1tbXAvcHhhOTEw
LmMKKysrIGIvYXJjaC9hcm0vbWFjaC1tbXAvcHhhOTEwLmMKQEAgLTExMCw2ICsxMTAsOCBAQCBz
dGF0aWMgQVBCQ19DTEsocHdtMiwgUFhBOTEwX1BXTTIsIDEsIDEzMDAwMDAwKTsKIHN0YXRpYyBB
UEJDX0NMSyhwd20zLCBQWEE5MTBfUFdNMywgMSwgMTMwMDAwMDApOwogc3RhdGljIEFQQkNfQ0xL
KHB3bTQsIFBYQTkxMF9QV000LCAxLCAxMzAwMDAwMCk7CiAKK3N0YXRpYyBBUE1VX0NMSyhsY2Qs
IExDRCwgMHgwMDNmLCAzMTIwMDAwMDApOworCiAvKiBkZXZpY2UgYW5kIGNsb2NrIGJpbmRpbmdz
ICovCiBzdGF0aWMgc3RydWN0IGNsa19sb29rdXAgcHhhOTEwX2Nsa3JlZ3NbXSA9IHsKIAlJTklU
X0NMS1JFRygmY2xrX3VhcnQxLCAicHhhMnh4LXVhcnQuMCIsIE5VTEwpLApAQCAtMTIwLDYgKzEy
Miw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2xrX2xvb2t1cCBweGE5MTBfY2xrcmVnc1tdID0gewogCUlO
SVRfQ0xLUkVHKCZjbGtfcHdtMiwgInB4YTkxMC1wd20uMSIsIE5VTEwpLAogCUlOSVRfQ0xLUkVH
KCZjbGtfcHdtMywgInB4YTkxMC1wd20uMiIsIE5VTEwpLAogCUlOSVRfQ0xLUkVHKCZjbGtfcHdt
NCwgInB4YTkxMC1wd20uMyIsIE5VTEwpLAorCUlOSVRfQ0xLUkVHKCZjbGtfbGNkLCAicHhhOTEw
LWZiIiwgIkxDRENMSyIpLAogfTsKIAogc3RhdGljIGludCBfX2luaXQgcHhhOTEwX2luaXQodm9p
ZCkKQEAgLTE3NCwzICsxNzcsNCBAQCBQWEE5MTBfREVWSUNFKHB3bTEsICJweGE5MTAtcHdtIiwg
MCwgTk9ORSwgMHhkNDAxYTAwMCwgMHgxMCk7CiBQWEE5MTBfREVWSUNFKHB3bTIsICJweGE5MTAt
cHdtIiwgMSwgTk9ORSwgMHhkNDAxYTQwMCwgMHgxMCk7CiBQWEE5MTBfREVWSUNFKHB3bTMsICJw
eGE5MTAtcHdtIiwgMiwgTk9ORSwgMHhkNDAxYTgwMCwgMHgxMCk7CiBQWEE5MTBfREVWSUNFKHB3
bTQsICJweGE5MTAtcHdtIiwgMywgTk9ORSwgMHhkNDAxYWMwMCwgMHgxMCk7CitQWEE5MTBfREVW
SUNFKGZiLCAicHhhOTEwLWZiIiwgLTEsIExDRCwgMHhkNDIwYjAwMCwgMHgxYzgpOwpkaWZmIC0t
Z2l0IGEvYXJjaC9hcm0vbWFjaC1tbXAvdHRjX2RrYi5jIGIvYXJjaC9hcm0vbWFjaC1tbXAvdHRj
X2RrYi5jCmluZGV4IDA4Y2ZlZjYuLmFjNDI5Y2QgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gt
bW1wL3R0Y19ka2IuYworKysgYi9hcmNoL2FybS9tYWNoLW1tcC90dGNfZGtiLmMKQEAgLTExLDcg
KzExLDEwIEBACiAjaW5jbHVkZSA8bGludXgvaW5pdC5oPgogI2luY2x1ZGUgPGxpbnV4L2tlcm5l
bC5oPgogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPgorI2luY2x1ZGUgPGxpbnV4
L2RlbGF5Lmg+CisjaW5jbHVkZSA8bGludXgvZ3Bpby5oPgogCisjaW5jbHVkZSA8dmlkZW8vcHhh
MTY4ZmIuaD4KICNpbmNsdWRlIDxhc20vbWFjaC10eXBlcy5oPgogI2luY2x1ZGUgPGFzbS9tYWNo
L2FyY2guaD4KICNpbmNsdWRlIDxtYWNoL2FkZHItbWFwLmg+CkBAIC0yNiwxMSArMjksMTUyIEBA
IHN0YXRpYyB1bnNpZ25lZCBsb25nIHR0Y19ka2JfcGluX2NvbmZpZ1tdIF9faW5pdGRhdGEgPSB7
CiAJLyogVUFSVDIgKi8KIAlHUElPNDdfVUFSVDJfUlhELAogCUdQSU80OF9VQVJUMl9UWEQsCisK
KyNpZmRlZiBDT05GSUdfRkJfUFhBMTY4CisJLyogTENEICovCisJR1BJTzgxX0xDRF9GQ0xLLAor
CUdQSU84Ml9MQ0RfTENMSywKKwlHUElPODNfTENEX1BDTEssCisJR1BJTzg0X0xDRF9ERU5BLAor
CUdQSU84NV9MQ0RfREQwLAorCUdQSU84Nl9MQ0RfREQxLAorCUdQSU84N19MQ0RfREQyLAorCUdQ
SU84OF9MQ0RfREQzLAorCUdQSU84OV9MQ0RfREQ0LAorCUdQSU85MF9MQ0RfREQ1LAorCUdQSU85
MV9MQ0RfREQ2LAorCUdQSU85Ml9MQ0RfREQ3LAorCUdQSU85M19MQ0RfREQ4LAorCUdQSU85NF9M
Q0RfREQ5LAorCUdQSU85NV9MQ0RfREQxMCwKKwlHUElPOTZfTENEX0REMTEsCisJR1BJTzk3X0xD
RF9ERDEyLAorCUdQSU85OF9MQ0RfREQxMywKKwlHUElPMTAwX0xDRF9ERDE0LAorCUdQSU8xMDFf
TENEX0REMTUsCisJR1BJTzEwMl9MQ0RfREQxNiwKKwlHUElPMTAzX0xDRF9ERDE3LAorCUdQSU8x
MDRfTENEX1NQSURPVVQsCisJR1BJTzEwNV9MQ0RfU1BJRElOLAorCUdQSU8xMDdfTENEX0NTMSwK
KwlHUElPMTA4X0xDRF9EQ0xLLAorCUdQSU8xMDZfTENEX1JFU0VULAorI2VuZGlmCit9OworCisj
aWZkZWYgQ09ORklHX0ZCX1BYQTE2OAorc3RhdGljIHUxNiB0cG9fc3BpX2NtZG9uW10gPSB7CisJ
MHgwODAxLAorCTB4MDgwMCwKKwkweDAyMDAsCisJMHgwMzA0LAorCTB4MDQwZSwKKwkweDA5MDMs
CisJMHgwYjE4LAorCTB4MGM1MywKKwkweDBkMDEsCisJMHgwZWUwLAorCTB4MGYwMSwKKwkweDEw
NTgsCisJMHgyMDFlLAorCTB4MjEwYSwKKwkweDIyMGEsCisJMHgyMzFlLAorCTB4MjQwMCwKKwkw
eDI1MzIsCisJMHgyNjAwLAorCTB4MjdhYywKKwkweDI5MDQsCisJMHgyYWEyLAorCTB4MmI0NSwK
KwkweDJjNDUsCisJMHgyZDE1LAorCTB4MmU1YSwKKwkweDJmZmYsCisJMHgzMDZiLAorCTB4MzEw
ZCwKKwkweDMyNDgsCisJMHgzMzgyLAorCTB4MzRiZCwKKwkweDM1ZTcsCisJMHgzNjE4LAorCTB4
Mzc5NCwKKwkweDM4MDEsCisJMHgzOTVkLAorCTB4M2FhZSwKKwkweDNiZmYsCisJMHgwN2M5LAkJ
LyogYXV0byBwb3dlciBvbiAqLworfTsKKworc3RhdGljIHUxNiB0cG9fc3BpX2NtZG9mZltdID0g
eworCTB4MDdkOSwJCS8qIGF1dG8gcG93ZXIgb2ZmICovCit9OworCitzdGF0aWMgaW50IHRwb19s
Y2RfcG93ZXIoc3RydWN0IHB4YTE2OGZiX2luZm8gKmZiaSwgdW5zaWduZWQgaW50IHNwaV9ncGlv
X2NzLAorCQl1bnNpZ25lZCBpbnQgc3BpX2dwaW9fcmVzZXQsIGludCBvbikKK3sKKwlpbnQgZXJy
ID0gMDsKKworCWlmIChvbikgeworCQlpZiAoc3BpX2dwaW9fcmVzZXQgIT0gLTEpIHsKKwkJCWVy
ciA9IGdwaW9fcmVxdWVzdChzcGlfZ3Bpb19yZXNldCwgIlRQT19MQ0RfU1BJX1JFU0VUIik7CisJ
CQlpZiAoZXJyKSB7CisJCQkJcHJpbnRrKEtFUk5fRVJSICJmYWlsZWQgdG8gcmVxdWVzdCBHUElP
IGZvciBUUE8gTENEIFJFU0VUXG4iKTsKKwkJCQlyZXR1cm4gLUVJTzsKKwkJCX0KKwkJCWdwaW9f
ZGlyZWN0aW9uX291dHB1dChzcGlfZ3Bpb19yZXNldCwgMCk7CisJCQltc2xlZXAoMTAwKTsKKwkJ
CWdwaW9fc2V0X3ZhbHVlKHNwaV9ncGlvX3Jlc2V0LCAxKTsKKwkJCW1zbGVlcCgxMDApOworCQkJ
Z3Bpb19mcmVlKHNwaV9ncGlvX3Jlc2V0KTsKKwkJfQorCQlyZXR1cm4gcHhhMTY4ZmJfc3BpX3Nl
bmQoZmJpLCB0cG9fc3BpX2NtZG9uLAorCQkJCUFSUkFZX1NJWkUodHBvX3NwaV9jbWRvbiksIHNw
aV9ncGlvX2NzLCAwLCA0MCk7CisJfSBlbHNlCisJCXJldHVybiBweGExNjhmYl9zcGlfc2VuZChm
YmksIHRwb19zcGlfY21kb2ZmLAorCQkJCUFSUkFZX1NJWkUodHBvX3NwaV9jbWRvZmYpLCBzcGlf
Z3Bpb19jcywgMCwgMCk7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgZmJfdmlkZW9tb2RlIHZpZGVvX21v
ZGVzW10gPSB7CisJLyogbHBqMDMybDAwMWIgSFZHQSBtb2RlIGluZm8gKi8KKwlbMF0gPSB7CisJ
CS5waXhjbG9jayAgICAgICA9IDEwMDAwMCwKKwkJLnJlZnJlc2ggICAgICAgID0gNjAsCisJCS54
cmVzICAgICAgICAgICA9IDMyMCwKKwkJLnlyZXMgICAgICAgICAgID0gNDgwLAorCQkuaHN5bmNf
bGVuICAgICAgPSAxMCwKKwkJLmxlZnRfbWFyZ2luICAgID0gMTUsCisJCS5yaWdodF9tYXJnaW4g
ICA9IDEwLAorCQkudnN5bmNfbGVuICAgICAgPSAyLAorCQkudXBwZXJfbWFyZ2luICAgPSA0LAor
CQkubG93ZXJfbWFyZ2luICAgPSAyLAorCQkuc3luYyAgICAgICAgICAgPSAwLAorCX0sCit9Owor
CitzdGF0aWMgc3RydWN0IHB4YTE2OGZiX21hY2hfaW5mbyB0dGNfZGtiX2xjZF9pbmZvIF9faW5p
dGRhdGEgPSB7CisJLmlkICAgICAgICAgICAgICAgICAgICAgPSAiQmFzZSIsCisJLm1vZGVzICAg
ICAgICAgICAgICAgICAgPSB2aWRlb19tb2RlcywKKwkubnVtX21vZGVzICAgICAgICAgICAgICA9
IEFSUkFZX1NJWkUodmlkZW9fbW9kZXMpLAorCS5waXhfZm10ICAgICAgICAgICAgICAgID0gUElY
X0ZNVF9SR0I1NjUsCisJLmlvX3Bpbl9hbGxvY2F0aW9uX21vZGUgPSBQSU5fTU9ERV9EVU1CXzE4
X1NQSSwKKwkuZHVtYl9tb2RlICAgICAgICAgICAgICA9IERVTUJfTU9ERV9SR0I2NjYsCisJLmFj
dGl2ZSAgICAgICAgICAgICAgICAgPSAxLAorCS5zcGlfY3RybCAgICAgICAgICAgICAgID0gQ0ZH
X1NDTEtDTlQoMTYpIHwgQ0ZHX1RYQklUUygxNikgfAorCQlDRkdfU1BJX1NFTCgxKSB8IENGR19T
UElfM1c0V0IoMSkgfCBDRkdfU1BJX0VOQSgxKSwKKwkuc3BpX2dwaW9fY3MgICAgICAgICAgICA9
IC0xLAorCS5zcGlfZ3Bpb19yZXNldAkJPSBtZnBfdG9fZ3BpbyhNRlBfUElOX0dQSU8xMDYpLAor
CS5pbnZlcnRfcGl4Y2xvY2sJPSAxLAorCS5weGExNjhmYl9sY2RfcG93ZXIJPSB0cG9fbGNkX3Bv
d2VyLAogfTsKKyNlbmRpZgogCiBzdGF0aWMgdm9pZCBfX2luaXQgdHRjX2RrYl9pbml0KHZvaWQp
CiB7CiAJbWZwX2NvbmZpZyhBUlJBWV9BTkRfU0laRSh0dGNfZGtiX3Bpbl9jb25maWcpKTsKKyNp
ZmRlZiBDT05GSUdfRkJfUFhBMTY4CisJcHhhOTEwX2FkZF9mYigmdHRjX2RrYl9sY2RfaW5mbyk7
CisjZW5kaWYKIAogCS8qIG9uLWNoaXAgZGV2aWNlcyAqLwogCXB4YTkxMF9hZGRfdWFydCgxKTsK
LS0gCjEuNS40LjMKCg==
--0016e64dbbd0bbb8ff0478b5a498--
