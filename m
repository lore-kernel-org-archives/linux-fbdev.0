From: Jun Nie <niej0001@gmail.com>
Date: Thu, 12 Nov 2009 02:20:20 +0000
Subject: Re: [PATCH 8/8] pxa: add frame buffer on pxa910 ttc_dkb platform
Message-Id: <7c34ac520911111820y5581951dya17ab06b904ff63f@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0016e64cba5e5eb0e20478232ff8"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100012p7ff6d07dv7e37433f43757647@mail.gmail.com>
In-Reply-To: <7c34ac520911100012p7ff6d07dv7e37433f43757647@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--0016e64cba5e5eb0e20478232ff8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2009/11/10 Jun Nie <niej0001@gmail.com>:
> From beb28ecac687792ce01d19cdf022fc77948ac51f Mon Sep 17 00:00:00 2001
> From: Jun Nie <njun@marvell.com>
> Date: Tue, 10 Nov 2009 15:54:17 +0800
> Subject: [PATCH] pxa: add frame buffer on pxa910 ttc_dkb platform
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> =A0arch/arm/configs/pxa910_defconfig =A0 =A0 =A0 | =A0 39 ++++++++-
> =A0arch/arm/mach-mmp/include/mach/pxa910.h | =A0 =A08 ++
> =A0arch/arm/mach-mmp/pxa910.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 +
> =A0arch/arm/mach-mmp/ttc_dkb.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0140 +++++++++=
++++++++++++++++++++++
> =A04 files changed, 190 insertions(+), 1 deletions(-)
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
> index dbd8cfd..06abf37 100644
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
> @@ -54,8 +57,142 @@ static unsigned long ttc_dkb_pin_config[] __initdata =
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
> + =A0 =A0 =A0 0x07c9, =A0 =A0 =A0 =A0 //auto power on
> +};
> +
> +static u16 tpo_spi_cmdoff[] =3D {
> + =A0 =A0 =A0 0x07d9, =A0 =A0 =A0 =A0 //auto power off
> +};
> +
> +static int tpo_lcd_power(struct pxa168fb_info *fbi, unsigned int
> spi_gpio_cs, unsigned int spi_gpio_reset, int on)
> +{
> + =A0 =A0 =A0 int err =3D 0;
> +
> + =A0 =A0 =A0 if (on) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi_gpio_reset !=3D -1) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D gpio_request(spi_gp=
io_reset, "TPO_LCD_SPI_RESET");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk("fai=
led to request GPIO for TPO LCD RESET\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -1;
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
> ARRAY_SIZE(tpo_spi_cmdon), spi_gpio_cs, 0, 40);
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pxa168fb_spi_send(fbi, tpo_spi_cmdof=
f,
> ARRAY_SIZE(tpo_spi_cmdoff), spi_gpio_cs, 0, 0);
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .sync =A0 =A0 =A0 =A0 =A0 =3D FB_SYNC_VERT_=
HIGH_ACT | FB_SYNC_HOR_HIGH_ACT,
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
> CFG_SPI_SEL(1) | CFG_SPI_3W4WB(1) | CFG_SPI_ENA(1),
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
> @@ -123,6 +260,9 @@ static void __init ttc_dkb_init(void)
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

patch attached.

--0016e64cba5e5eb0e20478232ff8
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0008-pxa-add-frame-buffer-on-pxa910-ttc_dkb-platform.patch"
Content-Disposition: attachment; 
	filename="0008-pxa-add-frame-buffer-on-pxa910-ttc_dkb-platform.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g1ww5sjy0

RnJvbSBiZWIyOGVjYWM2ODc3OTJjZTAxZDE5Y2RmMDIyZmM3Nzk0OGFjNTFmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUdWUs
IDEwIE5vdiAyMDA5IDE1OjU0OjE3ICswODAwClN1YmplY3Q6IFtQQVRDSF0gcHhhOiBhZGQgZnJh
bWUgYnVmZmVyIG9uIHB4YTkxMCB0dGNfZGtiIHBsYXRmb3JtCgpTaWduZWQtb2ZmLWJ5OiBKdW4g
TmllIDxuanVuQG1hcnZlbGwuY29tPgotLS0KIGFyY2gvYXJtL2NvbmZpZ3MvcHhhOTEwX2RlZmNv
bmZpZyAgICAgICB8ICAgMzkgKysrKysrKystCiBhcmNoL2FybS9tYWNoLW1tcC9pbmNsdWRlL21h
Y2gvcHhhOTEwLmggfCAgICA4ICsrCiBhcmNoL2FybS9tYWNoLW1tcC9weGE5MTAuYyAgICAgICAg
ICAgICAgfCAgICA0ICsKIGFyY2gvYXJtL21hY2gtbW1wL3R0Y19ka2IuYyAgICAgICAgICAgICB8
ICAxNDAgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogNCBmaWxlcyBjaGFuZ2VkLCAx
OTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9j
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
aC9weGE5MTAuaAppbmRleCA2YWUxZWQ3Li43Njk4NzkzIDEwMDY0NAotLS0gYS9hcmNoL2FybS9t
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
ICs2NiwxMCBAQCBzdGF0aWMgaW5saW5lIGludCBweGE5MTBfYWRkX3B3bShpbnQgaWQpCiAKIAly
ZXR1cm4gcHhhX3JlZ2lzdGVyX2RldmljZShkLCBOVUxMLCAwKTsKIH0KKworc3RhdGljIGlubGlu
ZSBpbnQgcHhhOTEwX2FkZF9mYihzdHJ1Y3QgcHhhMTY4ZmJfbWFjaF9pbmZvICptaSkKK3sKKwly
ZXR1cm4gcHhhX3JlZ2lzdGVyX2RldmljZSgmcHhhOTEwX2RldmljZV9mYiwgbWksIHNpemVvZigq
bWkpKTsKK30KKwogI2VuZGlmIC8qIF9fQVNNX01BQ0hfUFhBOTEwX0ggKi8KZGlmZiAtLWdpdCBh
L2FyY2gvYXJtL21hY2gtbW1wL3B4YTkxMC5jIGIvYXJjaC9hcm0vbWFjaC1tbXAvcHhhOTEwLmMK
aW5kZXggNTg4MmNhNi4uNDgxNjJhMCAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1tbXAvcHhh
OTEwLmMKKysrIGIvYXJjaC9hcm0vbWFjaC1tbXAvcHhhOTEwLmMKQEAgLTExMCw2ICsxMTAsOCBA
QCBzdGF0aWMgQVBCQ19DTEsocHdtMiwgUFhBOTEwX1BXTTIsIDEsIDEzMDAwMDAwKTsKIHN0YXRp
YyBBUEJDX0NMSyhwd20zLCBQWEE5MTBfUFdNMywgMSwgMTMwMDAwMDApOwogc3RhdGljIEFQQkNf
Q0xLKHB3bTQsIFBYQTkxMF9QV000LCAxLCAxMzAwMDAwMCk7CiAKK3N0YXRpYyBBUE1VX0NMSyhs
Y2QsIExDRCwgMHgwMDNmLCAzMTIwMDAwMDApOworCiAvKiBkZXZpY2UgYW5kIGNsb2NrIGJpbmRp
bmdzICovCiBzdGF0aWMgc3RydWN0IGNsa19sb29rdXAgcHhhOTEwX2Nsa3JlZ3NbXSA9IHsKIAlJ
TklUX0NMS1JFRygmY2xrX3VhcnQxLCAicHhhMnh4LXVhcnQuMCIsIE5VTEwpLApAQCAtMTIwLDYg
KzEyMiw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2xrX2xvb2t1cCBweGE5MTBfY2xrcmVnc1tdID0gewog
CUlOSVRfQ0xLUkVHKCZjbGtfcHdtMiwgInB4YTkxMC1wd20uMSIsIE5VTEwpLAogCUlOSVRfQ0xL
UkVHKCZjbGtfcHdtMywgInB4YTkxMC1wd20uMiIsIE5VTEwpLAogCUlOSVRfQ0xLUkVHKCZjbGtf
cHdtNCwgInB4YTkxMC1wd20uMyIsIE5VTEwpLAorCUlOSVRfQ0xLUkVHKCZjbGtfbGNkLCAicHhh
OTEwLWZiIiwgIkxDRENMSyIpLAogfTsKIAogc3RhdGljIGludCBfX2luaXQgcHhhOTEwX2luaXQo
dm9pZCkKQEAgLTE3NCwzICsxNzcsNCBAQCBQWEE5MTBfREVWSUNFKHB3bTEsICJweGE5MTAtcHdt
IiwgMCwgTk9ORSwgMHhkNDAxYTAwMCwgMHgxMCk7CiBQWEE5MTBfREVWSUNFKHB3bTIsICJweGE5
MTAtcHdtIiwgMSwgTk9ORSwgMHhkNDAxYTQwMCwgMHgxMCk7CiBQWEE5MTBfREVWSUNFKHB3bTMs
ICJweGE5MTAtcHdtIiwgMiwgTk9ORSwgMHhkNDAxYTgwMCwgMHgxMCk7CiBQWEE5MTBfREVWSUNF
KHB3bTQsICJweGE5MTAtcHdtIiwgMywgTk9ORSwgMHhkNDAxYWMwMCwgMHgxMCk7CitQWEE5MTBf
REVWSUNFKGZiLCAicHhhOTEwLWZiIiwgLTEsIExDRCwgMHhkNDIwYjAwMCwgMHgxYzgpOwpkaWZm
IC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1tbXAvdHRjX2RrYi5jIGIvYXJjaC9hcm0vbWFjaC1tbXAv
dHRjX2RrYi5jCmluZGV4IGRiZDhjZmQuLjA2YWJmMzcgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21h
Y2gtbW1wL3R0Y19ka2IuYworKysgYi9hcmNoL2FybS9tYWNoLW1tcC90dGNfZGtiLmMKQEAgLTE0
LDYgKzE0LDggQEAKICNpbmNsdWRlIDxsaW51eC9tdGQvbXRkLmg+CiAjaW5jbHVkZSA8bGludXgv
bXRkL3BhcnRpdGlvbnMuaD4KICNpbmNsdWRlIDxsaW51eC9tdGQvb25lbmFuZC5oPgorI2luY2x1
ZGUgPGxpbnV4L2RlbGF5Lmg+CisjaW5jbHVkZSA8dmlkZW8vcHhhMTY4ZmIuaD4KIAogI2luY2x1
ZGUgPGFzbS9tYWNoLXR5cGVzLmg+CiAjaW5jbHVkZSA8YXNtL21hY2gvYXJjaC5oPgpAQCAtMjEs
NiArMjMsNyBAQAogI2luY2x1ZGUgPG1hY2gvYWRkci1tYXAuaD4KICNpbmNsdWRlIDxtYWNoL21m
cC1weGE5MTAuaD4KICNpbmNsdWRlIDxtYWNoL3B4YTkxMC5oPgorI2luY2x1ZGUgPG1hY2gvZ3Bp
by5oPgogCiAjaW5jbHVkZSAiY29tbW9uLmgiCiAKQEAgLTU0LDggKzU3LDE0MiBAQCBzdGF0aWMg
dW5zaWduZWQgbG9uZyB0dGNfZGtiX3Bpbl9jb25maWdbXSBfX2luaXRkYXRhID0gewogCURGX1dF
bl9ERl9XRW4sCiAJREZfUkVuX0RGX1JFbiwKIAlERl9SRFkwX0RGX1JEWTAsCisKKyNpZmRlZiBD
T05GSUdfRkJfUFhBMTY4CisJLyogTENEICovCisJR1BJTzgxX0xDRF9GQ0xLLAorCUdQSU84Ml9M
Q0RfTENMSywKKwlHUElPODNfTENEX1BDTEssCisJR1BJTzg0X0xDRF9ERU5BLAorCUdQSU84NV9M
Q0RfREQwLAorCUdQSU84Nl9MQ0RfREQxLAorCUdQSU84N19MQ0RfREQyLAorCUdQSU84OF9MQ0Rf
REQzLAorCUdQSU84OV9MQ0RfREQ0LAorCUdQSU85MF9MQ0RfREQ1LAorCUdQSU85MV9MQ0RfREQ2
LAorCUdQSU85Ml9MQ0RfREQ3LAorCUdQSU85M19MQ0RfREQ4LAorCUdQSU85NF9MQ0RfREQ5LAor
CUdQSU85NV9MQ0RfREQxMCwKKwlHUElPOTZfTENEX0REMTEsCisJR1BJTzk3X0xDRF9ERDEyLAor
CUdQSU85OF9MQ0RfREQxMywKKwlHUElPMTAwX0xDRF9ERDE0LAorCUdQSU8xMDFfTENEX0REMTUs
CisJR1BJTzEwMl9MQ0RfREQxNiwKKwlHUElPMTAzX0xDRF9ERDE3LAorCUdQSU8xMDRfTENEX1NQ
SURPVVQsCisJR1BJTzEwNV9MQ0RfU1BJRElOLAorCUdQSU8xMDdfTENEX0NTMSwKKwlHUElPMTA4
X0xDRF9EQ0xLLAorCUdQSU8xMDZfTENEX1JFU0VULAorI2VuZGlmCit9OworCisjaWZkZWYgQ09O
RklHX0ZCX1BYQTE2OAorc3RhdGljIHUxNiB0cG9fc3BpX2NtZG9uW10gPSB7CisJMHgwODAxLAor
CTB4MDgwMCwKKwkweDAyMDAsCisJMHgwMzA0LAorCTB4MDQwZSwKKwkweDA5MDMsCisJMHgwYjE4
LAorCTB4MGM1MywKKwkweDBkMDEsCisJMHgwZWUwLAorCTB4MGYwMSwKKwkweDEwNTgsCisJMHgy
MDFlLAorCTB4MjEwYSwKKwkweDIyMGEsCisJMHgyMzFlLAorCTB4MjQwMCwKKwkweDI1MzIsCisJ
MHgyNjAwLAorCTB4MjdhYywKKwkweDI5MDQsCisJMHgyYWEyLAorCTB4MmI0NSwKKwkweDJjNDUs
CisJMHgyZDE1LAorCTB4MmU1YSwKKwkweDJmZmYsCisJMHgzMDZiLAorCTB4MzEwZCwKKwkweDMy
NDgsCisJMHgzMzgyLAorCTB4MzRiZCwKKwkweDM1ZTcsCisJMHgzNjE4LAorCTB4Mzc5NCwKKwkw
eDM4MDEsCisJMHgzOTVkLAorCTB4M2FhZSwKKwkweDNiZmYsCisJMHgwN2M5LAkJLy9hdXRvIHBv
d2VyIG9uCit9OworCitzdGF0aWMgdTE2IHRwb19zcGlfY21kb2ZmW10gPSB7CisJMHgwN2Q5LAkJ
Ly9hdXRvIHBvd2VyIG9mZgorfTsKKworc3RhdGljIGludCB0cG9fbGNkX3Bvd2VyKHN0cnVjdCBw
eGExNjhmYl9pbmZvICpmYmksIHVuc2lnbmVkIGludCBzcGlfZ3Bpb19jcywgdW5zaWduZWQgaW50
IHNwaV9ncGlvX3Jlc2V0LCBpbnQgb24pCit7CisJaW50IGVyciA9IDA7CisKKwlpZiAob24pIHsK
KwkJaWYgKHNwaV9ncGlvX3Jlc2V0ICE9IC0xKSB7CisJCQllcnIgPSBncGlvX3JlcXVlc3Qoc3Bp
X2dwaW9fcmVzZXQsICJUUE9fTENEX1NQSV9SRVNFVCIpOworCQkJaWYgKGVycikgeworCQkJCXBy
aW50aygiZmFpbGVkIHRvIHJlcXVlc3QgR1BJTyBmb3IgVFBPIExDRCBSRVNFVFxuIik7CisJCQkJ
cmV0dXJuIC0xOworCQkJfQorCQkJZ3Bpb19kaXJlY3Rpb25fb3V0cHV0KHNwaV9ncGlvX3Jlc2V0
LCAwKTsKKwkJCW1zbGVlcCgxMDApOworCQkJZ3Bpb19zZXRfdmFsdWUoc3BpX2dwaW9fcmVzZXQs
IDEpOworCQkJbXNsZWVwKDEwMCk7CisJCQlncGlvX2ZyZWUoc3BpX2dwaW9fcmVzZXQpOworCQl9
CisJCXJldHVybiBweGExNjhmYl9zcGlfc2VuZChmYmksIHRwb19zcGlfY21kb24sIEFSUkFZX1NJ
WkUodHBvX3NwaV9jbWRvbiksIHNwaV9ncGlvX2NzLCAwLCA0MCk7CisJfSBlbHNlCisJCXJldHVy
biBweGExNjhmYl9zcGlfc2VuZChmYmksIHRwb19zcGlfY21kb2ZmLCBBUlJBWV9TSVpFKHRwb19z
cGlfY21kb2ZmKSwgc3BpX2dwaW9fY3MsIDAsIDApOworfQorCitzdGF0aWMgc3RydWN0IGZiX3Zp
ZGVvbW9kZSB2aWRlb19tb2Rlc1tdID0geworCS8qIGxwajAzMmwwMDFiIEhWR0EgbW9kZSBpbmZv
ICovCisJWzBdID0geworCQkucGl4Y2xvY2sgICAgICAgPSAxMDAwMDAsCisJCS5yZWZyZXNoICAg
ICAgICA9IDYwLAorCQkueHJlcyAgICAgICAgICAgPSAzMjAsCisJCS55cmVzICAgICAgICAgICA9
IDQ4MCwKKwkJLmhzeW5jX2xlbiAgICAgID0gMTAsCisJCS5sZWZ0X21hcmdpbiAgICA9IDE1LAor
CQkucmlnaHRfbWFyZ2luICAgPSAxMCwKKwkJLnZzeW5jX2xlbiAgICAgID0gMiwKKwkJLnVwcGVy
X21hcmdpbiAgID0gNCwKKwkJLmxvd2VyX21hcmdpbiAgID0gMiwKKwkJLnN5bmMgICAgICAgICAg
ID0gRkJfU1lOQ19WRVJUX0hJR0hfQUNUIHwgRkJfU1lOQ19IT1JfSElHSF9BQ1QsCisJfSwKIH07
CiAKK3N0YXRpYyBzdHJ1Y3QgcHhhMTY4ZmJfbWFjaF9pbmZvIHR0Y19ka2JfbGNkX2luZm8gX19p
bml0ZGF0YSA9IHsKKwkuaWQgICAgICAgICAgICAgICAgICAgICA9ICJCYXNlIiwKKwkubW9kZXMg
ICAgICAgICAgICAgICAgICA9IHZpZGVvX21vZGVzLAorCS5udW1fbW9kZXMgICAgICAgICAgICAg
ID0gQVJSQVlfU0laRSh2aWRlb19tb2RlcyksCisJLnBpeF9mbXQgICAgICAgICAgICAgICAgPSBQ
SVhfRk1UX1JHQjU2NSwKKwkuaW9fcGluX2FsbG9jYXRpb25fbW9kZSA9IFBJTl9NT0RFX0RVTUJf
MThfU1BJLAorCS5kdW1iX21vZGUgICAgICAgICAgICAgID0gRFVNQl9NT0RFX1JHQjY2NiwKKwku
YWN0aXZlICAgICAgICAgICAgICAgICA9IDEsCisJLnNwaV9jdHJsICAgICAgICAgICAgICAgPSBD
RkdfU0NMS0NOVCgxNikgfCBDRkdfVFhCSVRTKDE2KSB8IENGR19TUElfU0VMKDEpIHwgQ0ZHX1NQ
SV8zVzRXQigxKSB8IENGR19TUElfRU5BKDEpLAorCS5zcGlfZ3Bpb19jcyAgICAgICAgICAgID0g
LTEsCisJLnNwaV9ncGlvX3Jlc2V0CQk9IG1mcF90b19ncGlvKE1GUF9QSU5fR1BJTzEwNiksCisJ
LmludmVydF9waXhjbG9jawk9IDEsCisJLnB4YTE2OGZiX2xjZF9wb3dlcgk9IHRwb19sY2RfcG93
ZXIsCit9OworI2VuZGlmCisKICNpZiBkZWZpbmVkKENPTkZJR19NVERfT05FTkFORCkgfHwgZGVm
aW5lZChDT05GSUdfTVREX09ORU5BTkRfTU9EVUxFKQogc3RhdGljIHN0cnVjdCBtdGRfcGFydGl0
aW9uIHR0Y19ka2Jfb25lbmFuZF9wYXJ0aXRpb25zW10gPSB7CiAJewpAQCAtMTIzLDYgKzI2MCw5
IEBAIHN0YXRpYyB2b2lkIF9faW5pdCB0dGNfZGtiX2luaXQodm9pZCkKIAogCS8qIG9uLWNoaXAg
ZGV2aWNlcyAqLwogCXB4YTkxMF9hZGRfdWFydCgxKTsKKyNpZmRlZiBDT05GSUdfRkJfUFhBMTY4
CisJcHhhOTEwX2FkZF9mYigmdHRjX2RrYl9sY2RfaW5mbyk7CisjZW5kaWYKIAogCS8qIG9mZi1j
aGlwIGRldmljZXMgKi8KIAl0dGNfZGtiX2luaXRfb25lbmFuZCgpOwotLSAKMS41LjQuMwoK
--0016e64cba5e5eb0e20478232ff8--
