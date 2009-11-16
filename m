From: Jun Nie <niej0001@gmail.com>
Date: Mon, 16 Nov 2009 09:35:02 +0000
Subject: [PATCH 8/8] pxa: add frame buffer on pxa910 ttc_dkb platform
Message-Id: <7c34ac520911160135x2133c734ub15db7abc64b22a3@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911100012p7ff6d07dv7e37433f43757647@mail.gmail.com>
In-Reply-To: <7c34ac520911100012p7ff6d07dv7e37433f43757647@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

From: Jun Nie <njun@marvell.com>
Date: Fri, 13 Nov 2009 15:07:45 +0800
Subject: [PATCH] pxa: add frame buffer on pxa910 ttc_dkb platform

Signed-off-by: Jun Nie <njun@marvell.com>
---
 arch/arm/configs/pxa910_defconfig       |   39 ++++++++-
 arch/arm/mach-mmp/include/mach/pxa910.h |    8 ++
 arch/arm/mach-mmp/pxa910.c              |    4 +
 arch/arm/mach-mmp/ttc_dkb.c             |  144 +++++++++++++++++++++++++++++++
 4 files changed, 194 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/pxa910_defconfig
b/arch/arm/configs/pxa910_defconfig
index 8c7e299..b9b1a85 100644
--- a/arch/arm/configs/pxa910_defconfig
+++ b/arch/arm/configs/pxa910_defconfig
@@ -578,7 +578,34 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
+CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
+CONFIG_FB_CFB_FILLRECT=y
+CONFIG_FB_CFB_COPYAREA=y
+CONFIG_FB_CFB_IMAGEBLIT=y
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
+CONFIG_FB_PXA168=y
+# CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
+# CONFIG_FB_MB862XX is not set
+# CONFIG_FB_BROADSHEET is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set

 #
@@ -591,6 +618,16 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+# CONFIG_FONTS is not set
+CONFIG_FONT_8x8=y
+CONFIG_FONT_8x16=y
+CONFIG_LOGO=y
+# CONFIG_LOGO_LINUX_MONO is not set
+CONFIG_LOGO_LINUX_VGA16=y
+CONFIG_LOGO_LINUX_CLUT224=y
 # CONFIG_SOUND is not set
 # CONFIG_HID_SUPPORT is not set
 # CONFIG_USB_SUPPORT is not set
diff --git a/arch/arm/mach-mmp/include/mach/pxa910.h
b/arch/arm/mach-mmp/include/mach/pxa910.h
index 6ae1ed7..7698793 100644
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
@@ -64,4 +66,10 @@ static inline int pxa910_add_pwm(int id)

 	return pxa_register_device(d, NULL, 0);
 }
+
+static inline int pxa910_add_fb(struct pxa168fb_mach_info *mi)
+{
+	return pxa_register_device(&pxa910_device_fb, mi, sizeof(*mi));
+}
+
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
 static struct clk_lookup pxa910_clkregs[] = {
 	INIT_CLKREG(&clk_uart1, "pxa2xx-uart.0", NULL),
@@ -120,6 +122,7 @@ static struct clk_lookup pxa910_clkregs[] = {
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
index dbd8cfd..15e64b4 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -14,6 +14,8 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/onenand.h>
+#include <linux/delay.h>
+#include <video/pxa168fb.h>

 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -21,6 +23,7 @@
 #include <mach/addr-map.h>
 #include <mach/mfp-pxa910.h>
 #include <mach/pxa910.h>
+#include <mach/gpio.h>

 #include "common.h"

@@ -54,8 +57,146 @@ static unsigned long ttc_dkb_pin_config[] __initdata = {
 	DF_WEn_DF_WEn,
 	DF_REn_DF_REn,
 	DF_RDY0_DF_RDY0,
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
+static u16 tpo_spi_cmdon[] = {
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
+static u16 tpo_spi_cmdoff[] = {
+	0x07d9,		/* auto power off */
+};
+
+static int tpo_lcd_power(struct pxa168fb_info *fbi, unsigned int spi_gpio_cs,
+		unsigned int spi_gpio_reset, int on)
+{
+	int err = 0;
+
+	if (on) {
+		if (spi_gpio_reset != -1) {
+			err = gpio_request(spi_gpio_reset, "TPO_LCD_SPI_RESET");
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
+static struct fb_videomode video_modes[] = {
+	/* lpj032l001b HVGA mode info */
+	[0] = {
+		.pixclock       = 100000,
+		.refresh        = 60,
+		.xres           = 320,
+		.yres           = 480,
+		.hsync_len      = 10,
+		.left_margin    = 15,
+		.right_margin   = 10,
+		.vsync_len      = 2,
+		.upper_margin   = 4,
+		.lower_margin   = 2,
+		.sync           = 0,
+	},
 };

+static struct pxa168fb_mach_info ttc_dkb_lcd_info __initdata = {
+	.id                     = "Base",
+	.modes                  = video_modes,
+	.num_modes              = ARRAY_SIZE(video_modes),
+	.pix_fmt                = PIX_FMT_RGB565,
+	.io_pin_allocation_mode = PIN_MODE_DUMB_18_SPI,
+	.dumb_mode              = DUMB_MODE_RGB666,
+	.active                 = 1,
+	.spi_ctrl               = CFG_SCLKCNT(16) | CFG_TXBITS(16) |
+		CFG_SPI_SEL(1) | CFG_SPI_3W4WB(1) | CFG_SPI_ENA(1),
+	.spi_gpio_cs            = -1,
+	.spi_gpio_reset		= mfp_to_gpio(MFP_PIN_GPIO106),
+	.invert_pixclock	= 1,
+	.pxa168fb_lcd_power	= tpo_lcd_power,
+};
+#endif
+
 #if defined(CONFIG_MTD_ONENAND) || defined(CONFIG_MTD_ONENAND_MODULE)
 static struct mtd_partition ttc_dkb_onenand_partitions[] = {
 	{
@@ -123,6 +264,9 @@ static void __init ttc_dkb_init(void)

 	/* on-chip devices */
 	pxa910_add_uart(1);
+#ifdef CONFIG_FB_PXA168
+	pxa910_add_fb(&ttc_dkb_lcd_info);
+#endif

 	/* off-chip devices */
 	ttc_dkb_init_onenand();
-- 
1.5.4.3
