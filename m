From: Jun Nie <niej0001@gmail.com>
Subject: Re: [PATCH 4/6] pxa: support frame buffer on pxa910 ttc_dkb platform
Date: Tue, 3 Nov 2009 15:30:20 +0800
Message-ID: <7c34ac520911022330q529c17cer874d76c5f21d9915@mail.gmail.com>
References: <7c34ac520911022245t2b810b9an26a58a59ee5b727c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <7c34ac520911022245t2b810b9an26a58a59ee5b727c@mail.gmail.com>
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
> pxa: support frame buffer on pxa910 ttc_dkb platform
>
> Signed-off-by: Jun Nie <njun@marvell.com>
> ---
> =A0arch/arm/configs/pxa910_defconfig =A0 =A0 =A0 | =A0 39 ++++++++-
> =A0arch/arm/mach-mmp/include/mach/pxa910.h | =A0 =A08 ++
> =A0arch/arm/mach-mmp/pxa910.c =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04 +
> =A0arch/arm/mach-mmp/ttc_dkb.c =A0 =A0 =A0 =A0 =A0 =A0 | =A0141 +++++++++=
++++++++++++++++++++++
> =A04 files changed, 191 insertions(+), 1 deletions(-)
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
> index dbd8cfd..dc04b0d 100644
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
> @@ -21,6 +23,8 @@
> =A0#include <mach/addr-map.h>
> =A0#include <mach/mfp-pxa910.h>
> =A0#include <mach/pxa910.h>
> +#include <mach/gpio.h>
> +#include <mach/pxa168fb.h>
>
> =A0#include "common.h"
>
> @@ -54,8 +58,142 @@ static unsigned long ttc_dkb_pin_config[] __initdata =
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
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pxa168fb_spi_send(fbi, tpo_spi_cmdon,
> ARRAY_SIZE(tpo_spi_cmdon), spi_gpio_cs, 20);
> + =A0 =A0 =A0 } else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return pxa168fb_spi_send(fbi, tpo_spi_cmdof=
f,
> ARRAY_SIZE(tpo_spi_cmdoff), spi_gpio_cs, 0);
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
> CFG_SPI_SEL(1) | CFG_SPI_3W4WB(1) | CFG_SPI_ENA(1),
> + =A0 =A0 =A0 .spi_gpio_cs =A0 =A0 =A0 =A0 =A0 =A0=3D -1,
> + =A0 =A0 =A0 .spi_gpio_reset =A0 =A0 =A0 =A0 =3D mfp_to_gpio(MFP_PIN_GPI=
O106),
> + =A0 =A0 =A0 .panel_rbswap =A0 =A0 =A0 =A0 =A0 =3D 1,
> + =A0 =A0 =A0 .pxa168fb_lcd_power =A0 =A0 =3D tpo_lcd_power,
> +};
> +#endif
> +
> =A0#if defined(CONFIG_MTD_ONENAND) || defined(CONFIG_MTD_ONENAND_MODULE)
> =A0static struct mtd_partition ttc_dkb_onenand_partitions[] =3D {
> =A0 =A0 =A0 =A0{
> @@ -123,6 +261,9 @@ static void __init ttc_dkb_init(void)
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
add linux-fbdev@vger.kernel.org
