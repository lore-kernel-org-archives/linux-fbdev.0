From: Jun Nie <niej0001@gmail.com>
Subject: [PATCH 6/6] pxa: add frame buffer support on pxa168 aspenite platform
Date: Tue, 3 Nov 2009 14:45:50 +0800
Message-ID: <7c34ac520911022245n3dda1a12nc09694d80dc93a75@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
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
To: linux-arm-kernel@lists.infradead.org, linux-fbdev-devel@lists.sourceforge.net

pxa: add frame buffer support on pxa168 aspenite platform

Signed-off-by: Jun Nie <njun@marvell.com>
---
 arch/arm/configs/pxa168_defconfig       |   86 ++++++++++++++++++++-
 arch/arm/mach-mmp/aspenite.c            |  132 +++++++++++++++++++++++++++++++
 arch/arm/mach-mmp/include/mach/pxa168.h |    8 ++
 arch/arm/mach-mmp/pxa168.c              |    3 +
 4 files changed, 227 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/pxa168_defconfig
b/arch/arm/configs/pxa168_defconfig
index db5faea..b736517 100644
--- a/arch/arm/configs/pxa168_defconfig
+++ b/arch/arm/configs/pxa168_defconfig
@@ -509,7 +509,49 @@ CONFIG_UNIX98_PTYS=y
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
-# CONFIG_I2C is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+# CONFIG_I2C_CHARDEV is not set
+CONFIG_I2C_HELPER_AUTO=y
+CONFIG_I2C_ALGOBIT=y
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+# CONFIG_I2C_DESIGNWARE is not set
+CONFIG_I2C_GPIO=y
+# CONFIG_I2C_OCORES is not set
+CONFIG_I2C_PXA=y
+# CONFIG_I2C_PXA_SLAVE is not set
+# CONFIG_I2C_SIMTEC is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_STUB is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_PCF8575 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
 # CONFIG_SPI is not set
 CONFIG_ARCH_REQUIRE_GPIOLIB=y
 CONFIG_GPIOLIB=y
@@ -523,6 +565,9 @@ CONFIG_GPIOLIB=y
 #
 # I2C GPIO expanders:
 #
+# CONFIG_GPIO_MAX732X is not set
+CONFIG_GPIO_PCA953X=y
+# CONFIG_GPIO_PCF857X is not set

 #
 # PCI GPIO expanders:
@@ -578,7 +623,34 @@ CONFIG_SSB_POSSIBLE=y
 #
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
+CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
+# CONFIG_FB_CFB_FILLRECT is not set
+# CONFIG_FB_CFB_COPYAREA is not set
+# CONFIG_FB_CFB_IMAGEBLIT is not set
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
@@ -591,6 +663,16 @@ CONFIG_SSB_POSSIBLE=y
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
diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index b422bb5..76a57dc 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -17,12 +17,14 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
 #include <linux/i2c/pca953x.h>
+#include <linux/delay.h>

 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <mach/addr-map.h>
 #include <mach/mfp-pxa168.h>
 #include <mach/pxa168.h>
+#include <mach/pxa168fb.h>
 #include <mach/gpio.h>
 #include <plat/pxa3xx_nand.h>
 #include <video/pxa168fb.h>
@@ -66,6 +68,39 @@ static unsigned long common_pin_config[] __initdata = {
 	/* UART1 */
 	GPIO107_UART1_RXD,
 	GPIO108_UART1_TXD,
+
+#ifdef CONFIG_FB_PXA168
+	/* LCD */
+	GPIO56_LCD_FCLK_RD,
+	GPIO57_LCD_LCLK_A0,
+	GPIO58_LCD_PCLK_WR,
+	GPIO59_LCD_DENA_BIAS,
+	GPIO60_LCD_DD0,
+	GPIO61_LCD_DD1,
+	GPIO62_LCD_DD2,
+	GPIO63_LCD_DD3,
+	GPIO64_LCD_DD4,
+	GPIO65_LCD_DD5,
+	GPIO66_LCD_DD6,
+	GPIO67_LCD_DD7,
+	GPIO68_LCD_DD8,
+	GPIO69_LCD_DD9,
+	GPIO70_LCD_DD10,
+	GPIO71_LCD_DD11,
+	GPIO72_LCD_DD12,
+	GPIO73_LCD_DD13,
+	GPIO74_LCD_DD14,
+	GPIO75_LCD_DD15,
+
+	GPIO76_LCD_DD16,
+	GPIO77_LCD_DD17,
+	GPIO78_LCD_DD18,
+	GPIO79_LCD_DD19,
+	GPIO80_LCD_DD20,
+	GPIO81_LCD_DD21,
+	GPIO82_LCD_DD22,
+	GPIO83_LCD_DD23,
+#endif
 };

 static struct smc91x_platdata smc91x_info = {
@@ -95,6 +130,100 @@ static struct platform_device smc91x_device = {
 	.resource	= smc91x_resources,
 };

+#ifdef CONFIG_FB_PXA168
+static u16 tpo_spi_cmdon[] = {
+	0x080F,
+	0x0C5F,
+	0x1017,
+	0x1420,
+	0x1808,
+	0x1c20,
+	0x2020,
+	0x2420,
+	0x2820,
+	0x2c20,
+	0x3020,
+	0x3420,
+	0x3810,
+	0x3c10,
+	0x4010,
+	0x4415,
+	0x48aa,
+	0x4cff,
+	0x5086,
+	0x548d,
+	0x58d4,
+	0x5cfb,
+	0x602e,
+	0x645a,
+	0x6889,
+	0x6cfe,
+	0x705a,
+	0x749b,
+	0x78c5,
+	0x7cff,
+	0x80f0,
+	0x84f0,
+	0x8808,
+};
+
+static u16 tpo_spi_cmdoff[] = {
+	0x0c5e,		//standby
+};
+
+static int tpo_lcd_power(struct pxa168fb_info *fbi, unsigned int
spi_gpio_cs, unsigned int spi_gpio_reset, int on)
+{
+	int err = 0;
+	if (on) {
+		if (spi_gpio_reset != -1) {
+			err = gpio_request(spi_gpio_reset, "TPO_LCD_SPI_RESET");
+			if (err) {
+				printk("failed to request GPIO for TPO LCD RESET\n");
+				return err;
+			}
+			gpio_direction_output(spi_gpio_reset, 0);
+			msleep(100);
+			gpio_set_value(spi_gpio_reset, 1);
+			msleep(100);
+			gpio_free(spi_gpio_reset);
+		}
+		return pxa168fb_spi_send(fbi, tpo_spi_cmdon,
ARRAY_SIZE(tpo_spi_cmdon), spi_gpio_cs, 1);
+	} else
+		return pxa168fb_spi_send(fbi, tpo_spi_cmdoff,
ARRAY_SIZE(tpo_spi_cmdoff), spi_gpio_cs, 1);
+}
+
+static struct fb_videomode video_modes_aspen[] = {
+	[0] = {
+		.pixclock       = 30120,
+		.refresh        = 60,
+		.xres           = 800,
+		.yres           = 480,
+		.hsync_len      = 1,
+		.left_margin    = 215,
+		.right_margin   = 40,
+		.vsync_len      = 1,
+		.upper_margin   = 34,
+		.lower_margin   = 10,
+		.sync           = 0,
+	},
+};
+
+struct pxa168fb_mach_info aspenite_lcd_info __initdata = {
+	.id                     = "Base-aspen",
+	.modes                  = video_modes_aspen,
+	.num_modes              = ARRAY_SIZE(video_modes_aspen),
+	.pix_fmt                = PIX_FMT_RGB565,
+	.io_pin_allocation_mode = PIN_MODE_DUMB_24,
+	.dumb_mode              = DUMB_MODE_RGB888,
+	.active                 = 1,
+	.spi_ctrl		= CFG_SCLKCNT(2) | CFG_TXBITS(16) | CFG_SPI_SEL(1) |
CFG_SPI_3W4WB(1) | CFG_SPI_ENA(1),
+	.spi_gpio_cs		= GPIO_EXT1(14),
+	.spi_gpio_reset         = -1,
+	.pxa168fb_lcd_power     = tpo_lcd_power,
+};
+
+#endif
+
 #if defined(CONFIG_MTD_NAND) || defined(CONFIG_MTD_NAND_MODULE)
 static struct mtd_partition apn_nand_partitions[] = {
 	{
@@ -184,6 +313,9 @@ static void __init common_init(void)

 	/* on-chip devices */
 	pxa168_add_uart(1);
+#ifdef CONFIG_FB_PXA168
+	pxa168_add_fb(&aspenite_lcd_info);
+#endif

 	apn_init_nand();
 	pxa168_add_twsi(0, &pwri2c_info, ARRAY_AND_SIZE(aspenite_i2c_board_info));
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h
b/arch/arm/mach-mmp/include/mach/pxa168.h
index d117ceb..d43fb13 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -4,6 +4,7 @@
 #include <linux/i2c.h>
 #include <mach/devices.h>
 #include <plat/i2c.h>
+#include <video/pxa168fb.h>

 extern struct pxa_device_desc pxa168_device_uart1;
 extern struct pxa_device_desc pxa168_device_uart2;
@@ -14,6 +15,7 @@ extern struct pxa_device_desc pxa168_device_pwm2;
 extern struct pxa_device_desc pxa168_device_pwm3;
 extern struct pxa_device_desc pxa168_device_pwm4;
 extern struct pxa_device_desc pxa168_device_nand;
+extern struct pxa_device_desc pxa168_device_fb;

 static inline int pxa168_add_uart(int id)
 {
@@ -65,4 +67,10 @@ static inline int pxa168_add_pwm(int id)

 	return pxa_register_device(d, NULL, 0);
 }
+
+static inline int pxa168_add_fb(struct pxa168fb_mach_info *mi)
+{
+	return pxa_register_device(&pxa168_device_fb, mi, sizeof(*mi));
+}
+
 #endif /* __ASM_MACH_PXA168_H */
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 59b393e..8be1e46 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -74,6 +74,7 @@ static APBC_CLK(pwm3, PXA168_PWM3, 1, 13000000);
 static APBC_CLK(pwm4, PXA168_PWM4, 1, 13000000);

 static APMU_CLK(nand, NAND, 0x1db, 208000000);
+static APMU_CLK(lcd, LCD, 0x003f, 312000000);

 /* device and clock bindings */
 static struct clk_lookup pxa168_clkregs[] = {
@@ -86,6 +87,7 @@ static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_pwm2, "pxa168-pwm.1", NULL),
 	INIT_CLKREG(&clk_pwm3, "pxa168-pwm.2", NULL),
 	INIT_CLKREG(&clk_pwm4, "pxa168-pwm.3", NULL),
+	INIT_CLKREG(&clk_lcd, "pxa168-fb", "LCDCLK"),
 };

 static int __init pxa168_init(void)
@@ -132,3 +134,4 @@ PXA168_DEVICE(pwm2, "pxa168-pwm", 1, NONE,
0xd401a400, 0x10);
 PXA168_DEVICE(pwm3, "pxa168-pwm", 2, NONE, 0xd401a800, 0x10);
 PXA168_DEVICE(pwm4, "pxa168-pwm", 3, NONE, 0xd401ac00, 0x10);
 PXA168_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x200, 97, 99);
+PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
-- 
1.5.4.3
