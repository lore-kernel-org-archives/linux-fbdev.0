From: Jun Nie <niej0001@gmail.com>
Date: Thu, 19 Nov 2009 09:03:13 +0000
Subject: Re: [PATCH 7/8] pxa: add frame buffer on pxa168 aspenite platform
Message-Id: <7c34ac520911190103q4ba79c60w11dfc8255b69abfa@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0016e64b96de1333f70478b5a19e"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911160134k57023db1we74073a87a3dd454@mail.gmail.com>
	<f17812d70911162229s43ca6826k29c4c4a7e279144f@mail.gmail.com>
In-Reply-To: <f17812d70911162229s43ca6826k29c4c4a7e279144f@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--0016e64b96de1333f70478b5a19e
Content-Type: text/plain; charset=ISO-8859-1

2009/11/17 Eric Miao <eric.y.miao@gmail.com>:
> On Mon, Nov 16, 2009 at 3:34 AM, Jun Nie <niej0001@gmail.com> wrote:
>> From: Jun Nie <njun@marvell.com>
>> Date: Fri, 13 Nov 2009 15:12:19 +0800
>> Subject: [PATCH] pxa: add frame buffer on pxa168 aspenite platform
>>
>> Signed-off-by: Jun Nie <njun@marvell.com>
>
> Hi Jun,
>
> All previous patches have been merged in 'topic/pxa168fb' branch for
> testing purpose, and I'm having difficulties to merge these two. Could
> you take a look into my tree and rebase these two?
>
> Note - you need only reply these two mails instead of submitting
> another set of patches, and do remember to attach the patch esp.
> since you are using gmail web interface, which is going to mal-form
> the patch.
>
> Thanks.
> - eric
>

rebased
From: Jun Nie <njun@marvell.com>
Date: Tue, 17 Nov 2009 20:39:43 +0800
Subject: [PATCH] pxa: add frame buffer on pxa168 aspenite platform

Signed-off-by: Jun Nie <njun@marvell.com>
---
 arch/arm/configs/pxa168_defconfig       |   86 +++++++++++++++++++-
 arch/arm/mach-mmp/aspenite.c            |  136 +++++++++++++++++++++++++++++++
 arch/arm/mach-mmp/include/mach/pxa168.h |    8 ++
 arch/arm/mach-mmp/pxa168.c              |    4 +
 4 files changed, 232 insertions(+), 2 deletions(-)

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
index d1d4a0d..3bfe568 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -14,6 +14,7 @@
 #include <linux/platform_device.h>
 #include <linux/smc91x.h>
 #include <linux/i2c/pca953x.h>
+#include <linux/delay.h>

 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -61,6 +62,39 @@ static unsigned long common_pin_config[] __initdata = {
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
@@ -90,6 +124,105 @@ static struct platform_device smc91x_device = {
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
+	0x0c5e,		/* standby */
+};
+
+static int tpo_lcd_power(struct pxa168fb_info *fbi, unsigned int spi_gpio_cs,
+		unsigned int spi_gpio_reset, int on)
+{
+	int err = 0;
+	if (on) {
+		if (spi_gpio_reset != -1) {
+			err = gpio_request(spi_gpio_reset, "TPO_LCD_SPI_RESET");
+			if (err) {
+				printk(KERN_ERR "failed to request GPIO for TPO LCD RESET\n");
+				return err;
+			}
+			gpio_direction_output(spi_gpio_reset, 0);
+			msleep(100);
+			gpio_set_value(spi_gpio_reset, 1);
+			msleep(100);
+			gpio_free(spi_gpio_reset);
+		}
+		return pxa168fb_spi_send(fbi, tpo_spi_cmdon,
+				ARRAY_SIZE(tpo_spi_cmdon), spi_gpio_cs, 0, 1);
+	} else
+		return pxa168fb_spi_send(fbi, tpo_spi_cmdoff,
+				ARRAY_SIZE(tpo_spi_cmdoff), spi_gpio_cs, 0, 1);
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
+	.spi_ctrl		= CFG_SCLKCNT(2) | CFG_TXBITS(16) |
+		CFG_SPI_SEL(1) | CFG_SPI_3W4WB(1) | CFG_SPI_ENA(1),
+	.spi_gpio_cs		= GPIO_EXT1(14),
+	.spi_gpio_reset         = -1,
+	.invert_pixclock	= 1,
+	.pxa168fb_lcd_power     = tpo_lcd_power,
+};
+
+#endif
+
 static struct i2c_pxa_platform_data pwri2c_info __initdata = {
 	.use_pio		= 0,
 };
@@ -136,6 +269,9 @@ static void __init common_init(void)
 	pxa168_add_uart(1);
 	pxa168_add_twsi(0, &pwri2c_info,
 			ARRAY_AND_SIZE(aspenite_i2c_board_info));
+#ifdef CONFIG_FB_PXA168
+	pxa168_add_fb(&aspenite_lcd_info);
+#endif

 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h
b/arch/arm/mach-mmp/include/mach/pxa168.h
index 6bf1f0e..a2ca47b 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -4,6 +4,7 @@
 #include <linux/i2c.h>
 #include <mach/devices.h>
 #include <plat/i2c.h>
+#include <video/pxa168fb.h>

 extern struct pxa_device_desc pxa168_device_uart1;
 extern struct pxa_device_desc pxa168_device_uart2;
@@ -13,6 +14,7 @@ extern struct pxa_device_desc pxa168_device_pwm1;
 extern struct pxa_device_desc pxa168_device_pwm2;
 extern struct pxa_device_desc pxa168_device_pwm3;
 extern struct pxa_device_desc pxa168_device_pwm4;
+extern struct pxa_device_desc pxa168_device_fb;

 static inline int pxa168_add_uart(int id)
 {
@@ -64,4 +66,10 @@ static inline int pxa168_add_pwm(int id)

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
index 71b1ae3..07a12ce 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -19,6 +19,7 @@
 #include <mach/addr-map.h>
 #include <mach/cputype.h>
 #include <mach/regs-apbc.h>
+#include <mach/regs-apmu.h>
 #include <mach/irqs.h>
 #include <mach/gpio.h>
 #include <mach/dma.h>
@@ -71,6 +72,7 @@ static APBC_CLK(pwm1, PXA168_PWM1, 1, 13000000);
 static APBC_CLK(pwm2, PXA168_PWM2, 1, 13000000);
 static APBC_CLK(pwm3, PXA168_PWM3, 1, 13000000);
 static APBC_CLK(pwm4, PXA168_PWM4, 1, 13000000);
+static APMU_CLK(lcd, LCD, 0x003f, 312000000);

 /* device and clock bindings */
 static struct clk_lookup pxa168_clkregs[] = {
@@ -82,6 +84,7 @@ static struct clk_lookup pxa168_clkregs[] = {
 	INIT_CLKREG(&clk_pwm2, "pxa168-pwm.1", NULL),
 	INIT_CLKREG(&clk_pwm3, "pxa168-pwm.2", NULL),
 	INIT_CLKREG(&clk_pwm4, "pxa168-pwm.3", NULL),
+	INIT_CLKREG(&clk_lcd, "pxa168-fb", "LCDCLK"),
 };

 static int __init pxa168_init(void)
@@ -127,3 +130,4 @@ PXA168_DEVICE(pwm1, "pxa168-pwm", 0, NONE,
0xd401a000, 0x10);
 PXA168_DEVICE(pwm2, "pxa168-pwm", 1, NONE, 0xd401a400, 0x10);
 PXA168_DEVICE(pwm3, "pxa168-pwm", 2, NONE, 0xd401a800, 0x10);
 PXA168_DEVICE(pwm4, "pxa168-pwm", 3, NONE, 0xd401ac00, 0x10);
+PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
-- 
1.5.4.3

--0016e64b96de1333f70478b5a19e
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0007-pxa-add-frame-buffer-on-pxa168-aspenite-platform.patch"
Content-Disposition: attachment; 
	filename="0007-pxa-add-frame-buffer-on-pxa168-aspenite-platform.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g27am3if0

RnJvbSBhNzk5MmQwNDcxODk1YjRiYWY1NDIzNmE5MDk3MDBiNzU0ZjIyMmFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBUdWUs
IDE3IE5vdiAyMDA5IDIwOjM5OjQzICswODAwClN1YmplY3Q6IFtQQVRDSF0gcHhhOiBhZGQgZnJh
bWUgYnVmZmVyIG9uIHB4YTE2OCBhc3Blbml0ZSBwbGF0Zm9ybQoKU2lnbmVkLW9mZi1ieTogSnVu
IE5pZSA8bmp1bkBtYXJ2ZWxsLmNvbT4KLS0tCiBhcmNoL2FybS9jb25maWdzL3B4YTE2OF9kZWZj
b25maWcgICAgICAgfCAgIDg2ICsrKysrKysrKysrKysrKysrKystCiBhcmNoL2FybS9tYWNoLW1t
cC9hc3Blbml0ZS5jICAgICAgICAgICAgfCAgMTM2ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysKIGFyY2gvYXJtL21hY2gtbW1wL2luY2x1ZGUvbWFjaC9weGExNjguaCB8ICAgIDggKysK
IGFyY2gvYXJtL21hY2gtbW1wL3B4YTE2OC5jICAgICAgICAgICAgICB8ICAgIDQgKwogNCBmaWxl
cyBjaGFuZ2VkLCAyMzIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9hcmNoL2FybS9jb25maWdzL3B4YTE2OF9kZWZjb25maWcgYi9hcmNoL2FybS9jb25maWdzL3B4
YTE2OF9kZWZjb25maWcKaW5kZXggZGI1ZmFlYS4uYjczNjUxNyAxMDA2NDQKLS0tIGEvYXJjaC9h
cm0vY29uZmlncy9weGExNjhfZGVmY29uZmlnCisrKyBiL2FyY2gvYXJtL2NvbmZpZ3MvcHhhMTY4
X2RlZmNvbmZpZwpAQCAtNTA5LDcgKzUwOSw0OSBAQCBDT05GSUdfVU5JWDk4X1BUWVM9eQogIyBD
T05GSUdfUjM5NjQgaXMgbm90IHNldAogIyBDT05GSUdfUkFXX0RSSVZFUiBpcyBub3Qgc2V0CiAj
IENPTkZJR19UQ0dfVFBNIGlzIG5vdCBzZXQKLSMgQ09ORklHX0kyQyBpcyBub3Qgc2V0CitDT05G
SUdfSTJDPXkKK0NPTkZJR19JMkNfQk9BUkRJTkZPPXkKKyMgQ09ORklHX0kyQ19DSEFSREVWIGlz
IG5vdCBzZXQKK0NPTkZJR19JMkNfSEVMUEVSX0FVVE89eQorQ09ORklHX0kyQ19BTEdPQklUPXkK
KworIworIyBJMkMgSGFyZHdhcmUgQnVzIHN1cHBvcnQKKyMKKworIworIyBJMkMgc3lzdGVtIGJ1
cyBkcml2ZXJzIChtb3N0bHkgZW1iZWRkZWQgLyBzeXN0ZW0tb24tY2hpcCkKKyMKKyMgQ09ORklH
X0kyQ19ERVNJR05XQVJFIGlzIG5vdCBzZXQKK0NPTkZJR19JMkNfR1BJTz15CisjIENPTkZJR19J
MkNfT0NPUkVTIGlzIG5vdCBzZXQKK0NPTkZJR19JMkNfUFhBPXkKKyMgQ09ORklHX0kyQ19QWEFf
U0xBVkUgaXMgbm90IHNldAorIyBDT05GSUdfSTJDX1NJTVRFQyBpcyBub3Qgc2V0CisKKyMKKyMg
RXh0ZXJuYWwgSTJDL1NNQnVzIGFkYXB0ZXIgZHJpdmVycworIworIyBDT05GSUdfSTJDX1BBUlBP
UlRfTElHSFQgaXMgbm90IHNldAorIyBDT05GSUdfSTJDX1RBT1NfRVZNIGlzIG5vdCBzZXQKKwor
IworIyBPdGhlciBJMkMvU01CdXMgYnVzIGRyaXZlcnMKKyMKKyMgQ09ORklHX0kyQ19QQ0FfUExB
VEZPUk0gaXMgbm90IHNldAorIyBDT05GSUdfSTJDX1NUVUIgaXMgbm90IHNldAorCisjCisjIE1p
c2NlbGxhbmVvdXMgSTJDIENoaXAgc3VwcG9ydAorIworIyBDT05GSUdfRFMxNjgyIGlzIG5vdCBz
ZXQKKyMgQ09ORklHX1NFTlNPUlNfUENGODU3NCBpcyBub3Qgc2V0CisjIENPTkZJR19QQ0Y4NTc1
IGlzIG5vdCBzZXQKKyMgQ09ORklHX1NFTlNPUlNfVFNMMjU1MCBpcyBub3Qgc2V0CisjIENPTkZJ
R19JMkNfREVCVUdfQ09SRSBpcyBub3Qgc2V0CisjIENPTkZJR19JMkNfREVCVUdfQUxHTyBpcyBu
b3Qgc2V0CisjIENPTkZJR19JMkNfREVCVUdfQlVTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0kyQ19E
RUJVR19DSElQIGlzIG5vdCBzZXQKICMgQ09ORklHX1NQSSBpcyBub3Qgc2V0CiBDT05GSUdfQVJD
SF9SRVFVSVJFX0dQSU9MSUI9eQogQ09ORklHX0dQSU9MSUI9eQpAQCAtNTIzLDYgKzU2NSw5IEBA
IENPTkZJR19HUElPTElCPXkKICMKICMgSTJDIEdQSU8gZXhwYW5kZXJzOgogIworIyBDT05GSUdf
R1BJT19NQVg3MzJYIGlzIG5vdCBzZXQKK0NPTkZJR19HUElPX1BDQTk1M1g9eQorIyBDT05GSUdf
R1BJT19QQ0Y4NTdYIGlzIG5vdCBzZXQKIAogIwogIyBQQ0kgR1BJTyBleHBhbmRlcnM6CkBAIC01
NzgsNyArNjIzLDM0IEBAIENPTkZJR19TU0JfUE9TU0lCTEU9eQogIwogIyBDT05GSUdfVkdBU1RB
VEUgaXMgbm90IHNldAogIyBDT05GSUdfVklERU9fT1VUUFVUX0NPTlRST0wgaXMgbm90IHNldAot
IyBDT05GSUdfRkIgaXMgbm90IHNldAorQ09ORklHX0ZCPXkKKyMgQ09ORklHX0ZJUk1XQVJFX0VE
SUQgaXMgbm90IHNldAorIyBDT05GSUdfRkJfRERDIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX0JP
T1RfVkVTQV9TVVBQT1JUIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX0NGQl9GSUxMUkVDVCBpcyBu
b3Qgc2V0CisjIENPTkZJR19GQl9DRkJfQ09QWUFSRUEgaXMgbm90IHNldAorIyBDT05GSUdfRkJf
Q0ZCX0lNQUdFQkxJVCBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9DRkJfUkVWX1BJWEVMU19JTl9C
WVRFIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX1NZU19GSUxMUkVDVCBpcyBub3Qgc2V0CisjIENP
TkZJR19GQl9TWVNfQ09QWUFSRUEgaXMgbm90IHNldAorIyBDT05GSUdfRkJfU1lTX0lNQUdFQkxJ
VCBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9GT1JFSUdOX0VORElBTiBpcyBub3Qgc2V0CisjIENP
TkZJR19GQl9TWVNfRk9QUyBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9TVkdBTElCIGlzIG5vdCBz
ZXQKKyMgQ09ORklHX0ZCX01BQ01PREVTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX0JBQ0tMSUdI
VCBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9NT0RFX0hFTFBFUlMgaXMgbm90IHNldAorIyBDT05G
SUdfRkJfVElMRUJMSVRUSU5HIGlzIG5vdCBzZXQKKworIworIyBGcmFtZSBidWZmZXIgaGFyZHdh
cmUgZHJpdmVycworIworIyBDT05GSUdfRkJfUzFEMTNYWFggaXMgbm90IHNldAorQ09ORklHX0ZC
X1BYQTE2OD15CisjIENPTkZJR19GQl9WSVJUVUFMIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX01F
VFJPTk9NRSBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9NQjg2MlhYIGlzIG5vdCBzZXQKKyMgQ09O
RklHX0ZCX0JST0FEU0hFRVQgaXMgbm90IHNldAogIyBDT05GSUdfQkFDS0xJR0hUX0xDRF9TVVBQ
T1JUIGlzIG5vdCBzZXQKIAogIwpAQCAtNTkxLDYgKzY2MywxNiBAQCBDT05GSUdfU1NCX1BPU1NJ
QkxFPXkKICMKICMgQ09ORklHX1ZHQV9DT05TT0xFIGlzIG5vdCBzZXQKIENPTkZJR19EVU1NWV9D
T05TT0xFPXkKK0NPTkZJR19GUkFNRUJVRkZFUl9DT05TT0xFPXkKK0NPTkZJR19GUkFNRUJVRkZF
Ul9DT05TT0xFX0RFVEVDVF9QUklNQVJZPXkKKyMgQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEVf
Uk9UQVRJT04gaXMgbm90IHNldAorIyBDT05GSUdfRk9OVFMgaXMgbm90IHNldAorQ09ORklHX0ZP
TlRfOHg4PXkKK0NPTkZJR19GT05UXzh4MTY9eQorQ09ORklHX0xPR089eQorIyBDT05GSUdfTE9H
T19MSU5VWF9NT05PIGlzIG5vdCBzZXQKK0NPTkZJR19MT0dPX0xJTlVYX1ZHQTE2PXkKK0NPTkZJ
R19MT0dPX0xJTlVYX0NMVVQyMjQ9eQogIyBDT05GSUdfU09VTkQgaXMgbm90IHNldAogIyBDT05G
SUdfSElEX1NVUFBPUlQgaXMgbm90IHNldAogIyBDT05GSUdfVVNCX1NVUFBPUlQgaXMgbm90IHNl
dApkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1tbXAvYXNwZW5pdGUuYyBiL2FyY2gvYXJtL21h
Y2gtbW1wL2FzcGVuaXRlLmMKaW5kZXggZDFkNGEwZC4uM2JmZTU2OCAxMDA2NDQKLS0tIGEvYXJj
aC9hcm0vbWFjaC1tbXAvYXNwZW5pdGUuYworKysgYi9hcmNoL2FybS9tYWNoLW1tcC9hc3Blbml0
ZS5jCkBAIC0xNCw2ICsxNCw3IEBACiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2aWNlLmg+
CiAjaW5jbHVkZSA8bGludXgvc21jOTF4Lmg+CiAjaW5jbHVkZSA8bGludXgvaTJjL3BjYTk1M3gu
aD4KKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgogCiAjaW5jbHVkZSA8YXNtL21hY2gtdHlwZXMu
aD4KICNpbmNsdWRlIDxhc20vbWFjaC9hcmNoLmg+CkBAIC02MSw2ICs2MiwzOSBAQCBzdGF0aWMg
dW5zaWduZWQgbG9uZyBjb21tb25fcGluX2NvbmZpZ1tdIF9faW5pdGRhdGEgPSB7CiAJLyogVUFS
VDEgKi8KIAlHUElPMTA3X1VBUlQxX1JYRCwKIAlHUElPMTA4X1VBUlQxX1RYRCwKKworI2lmZGVm
IENPTkZJR19GQl9QWEExNjgKKwkvKiBMQ0QgKi8KKwlHUElPNTZfTENEX0ZDTEtfUkQsCisJR1BJ
TzU3X0xDRF9MQ0xLX0EwLAorCUdQSU81OF9MQ0RfUENMS19XUiwKKwlHUElPNTlfTENEX0RFTkFf
QklBUywKKwlHUElPNjBfTENEX0REMCwKKwlHUElPNjFfTENEX0REMSwKKwlHUElPNjJfTENEX0RE
MiwKKwlHUElPNjNfTENEX0REMywKKwlHUElPNjRfTENEX0RENCwKKwlHUElPNjVfTENEX0RENSwK
KwlHUElPNjZfTENEX0RENiwKKwlHUElPNjdfTENEX0RENywKKwlHUElPNjhfTENEX0REOCwKKwlH
UElPNjlfTENEX0REOSwKKwlHUElPNzBfTENEX0REMTAsCisJR1BJTzcxX0xDRF9ERDExLAorCUdQ
SU83Ml9MQ0RfREQxMiwKKwlHUElPNzNfTENEX0REMTMsCisJR1BJTzc0X0xDRF9ERDE0LAorCUdQ
SU83NV9MQ0RfREQxNSwKKworCUdQSU83Nl9MQ0RfREQxNiwKKwlHUElPNzdfTENEX0REMTcsCisJ
R1BJTzc4X0xDRF9ERDE4LAorCUdQSU83OV9MQ0RfREQxOSwKKwlHUElPODBfTENEX0REMjAsCisJ
R1BJTzgxX0xDRF9ERDIxLAorCUdQSU84Ml9MQ0RfREQyMiwKKwlHUElPODNfTENEX0REMjMsCisj
ZW5kaWYKIH07CiAKIHN0YXRpYyBzdHJ1Y3Qgc21jOTF4X3BsYXRkYXRhIHNtYzkxeF9pbmZvID0g
ewpAQCAtOTAsNiArMTI0LDEwNSBAQCBzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RldmljZSBzbWM5
MXhfZGV2aWNlID0gewogCS5yZXNvdXJjZQk9IHNtYzkxeF9yZXNvdXJjZXMsCiB9OwogCisjaWZk
ZWYgQ09ORklHX0ZCX1BYQTE2OAorc3RhdGljIHUxNiB0cG9fc3BpX2NtZG9uW10gPSB7CisJMHgw
ODBGLAorCTB4MEM1RiwKKwkweDEwMTcsCisJMHgxNDIwLAorCTB4MTgwOCwKKwkweDFjMjAsCisJ
MHgyMDIwLAorCTB4MjQyMCwKKwkweDI4MjAsCisJMHgyYzIwLAorCTB4MzAyMCwKKwkweDM0MjAs
CisJMHgzODEwLAorCTB4M2MxMCwKKwkweDQwMTAsCisJMHg0NDE1LAorCTB4NDhhYSwKKwkweDRj
ZmYsCisJMHg1MDg2LAorCTB4NTQ4ZCwKKwkweDU4ZDQsCisJMHg1Y2ZiLAorCTB4NjAyZSwKKwkw
eDY0NWEsCisJMHg2ODg5LAorCTB4NmNmZSwKKwkweDcwNWEsCisJMHg3NDliLAorCTB4NzhjNSwK
KwkweDdjZmYsCisJMHg4MGYwLAorCTB4ODRmMCwKKwkweDg4MDgsCit9OworCitzdGF0aWMgdTE2
IHRwb19zcGlfY21kb2ZmW10gPSB7CisJMHgwYzVlLAkJLyogc3RhbmRieSAqLworfTsKKworc3Rh
dGljIGludCB0cG9fbGNkX3Bvd2VyKHN0cnVjdCBweGExNjhmYl9pbmZvICpmYmksIHVuc2lnbmVk
IGludCBzcGlfZ3Bpb19jcywKKwkJdW5zaWduZWQgaW50IHNwaV9ncGlvX3Jlc2V0LCBpbnQgb24p
Cit7CisJaW50IGVyciA9IDA7CisJaWYgKG9uKSB7CisJCWlmIChzcGlfZ3Bpb19yZXNldCAhPSAt
MSkgeworCQkJZXJyID0gZ3Bpb19yZXF1ZXN0KHNwaV9ncGlvX3Jlc2V0LCAiVFBPX0xDRF9TUElf
UkVTRVQiKTsKKwkJCWlmIChlcnIpIHsKKwkJCQlwcmludGsoS0VSTl9FUlIgImZhaWxlZCB0byBy
ZXF1ZXN0IEdQSU8gZm9yIFRQTyBMQ0QgUkVTRVRcbiIpOworCQkJCXJldHVybiBlcnI7CisJCQl9
CisJCQlncGlvX2RpcmVjdGlvbl9vdXRwdXQoc3BpX2dwaW9fcmVzZXQsIDApOworCQkJbXNsZWVw
KDEwMCk7CisJCQlncGlvX3NldF92YWx1ZShzcGlfZ3Bpb19yZXNldCwgMSk7CisJCQltc2xlZXAo
MTAwKTsKKwkJCWdwaW9fZnJlZShzcGlfZ3Bpb19yZXNldCk7CisJCX0KKwkJcmV0dXJuIHB4YTE2
OGZiX3NwaV9zZW5kKGZiaSwgdHBvX3NwaV9jbWRvbiwKKwkJCQlBUlJBWV9TSVpFKHRwb19zcGlf
Y21kb24pLCBzcGlfZ3Bpb19jcywgMCwgMSk7CisJfSBlbHNlCisJCXJldHVybiBweGExNjhmYl9z
cGlfc2VuZChmYmksIHRwb19zcGlfY21kb2ZmLAorCQkJCUFSUkFZX1NJWkUodHBvX3NwaV9jbWRv
ZmYpLCBzcGlfZ3Bpb19jcywgMCwgMSk7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgZmJfdmlkZW9tb2Rl
IHZpZGVvX21vZGVzX2FzcGVuW10gPSB7CisJWzBdID0geworCQkucGl4Y2xvY2sgICAgICAgPSAz
MDEyMCwKKwkJLnJlZnJlc2ggICAgICAgID0gNjAsCisJCS54cmVzICAgICAgICAgICA9IDgwMCwK
KwkJLnlyZXMgICAgICAgICAgID0gNDgwLAorCQkuaHN5bmNfbGVuICAgICAgPSAxLAorCQkubGVm
dF9tYXJnaW4gICAgPSAyMTUsCisJCS5yaWdodF9tYXJnaW4gICA9IDQwLAorCQkudnN5bmNfbGVu
ICAgICAgPSAxLAorCQkudXBwZXJfbWFyZ2luICAgPSAzNCwKKwkJLmxvd2VyX21hcmdpbiAgID0g
MTAsCisJCS5zeW5jICAgICAgICAgICA9IDAsCisJfSwKK307CisKK3N0cnVjdCBweGExNjhmYl9t
YWNoX2luZm8gYXNwZW5pdGVfbGNkX2luZm8gX19pbml0ZGF0YSA9IHsKKwkuaWQgICAgICAgICAg
ICAgICAgICAgICA9ICJCYXNlLWFzcGVuIiwKKwkubW9kZXMgICAgICAgICAgICAgICAgICA9IHZp
ZGVvX21vZGVzX2FzcGVuLAorCS5udW1fbW9kZXMgICAgICAgICAgICAgID0gQVJSQVlfU0laRSh2
aWRlb19tb2Rlc19hc3BlbiksCisJLnBpeF9mbXQgICAgICAgICAgICAgICAgPSBQSVhfRk1UX1JH
QjU2NSwKKwkuaW9fcGluX2FsbG9jYXRpb25fbW9kZSA9IFBJTl9NT0RFX0RVTUJfMjQsCisJLmR1
bWJfbW9kZSAgICAgICAgICAgICAgPSBEVU1CX01PREVfUkdCODg4LAorCS5hY3RpdmUgICAgICAg
ICAgICAgICAgID0gMSwKKwkuc3BpX2N0cmwJCT0gQ0ZHX1NDTEtDTlQoMikgfCBDRkdfVFhCSVRT
KDE2KSB8CisJCUNGR19TUElfU0VMKDEpIHwgQ0ZHX1NQSV8zVzRXQigxKSB8IENGR19TUElfRU5B
KDEpLAorCS5zcGlfZ3Bpb19jcwkJPSBHUElPX0VYVDEoMTQpLAorCS5zcGlfZ3Bpb19yZXNldCAg
ICAgICAgID0gLTEsCisJLmludmVydF9waXhjbG9jawk9IDEsCisJLnB4YTE2OGZiX2xjZF9wb3dl
ciAgICAgPSB0cG9fbGNkX3Bvd2VyLAorfTsKKworI2VuZGlmCisKIHN0YXRpYyBzdHJ1Y3QgaTJj
X3B4YV9wbGF0Zm9ybV9kYXRhIHB3cmkyY19pbmZvIF9faW5pdGRhdGEgPSB7CiAJLnVzZV9waW8J
CT0gMCwKIH07CkBAIC0xMzYsNiArMjY5LDkgQEAgc3RhdGljIHZvaWQgX19pbml0IGNvbW1vbl9p
bml0KHZvaWQpCiAJcHhhMTY4X2FkZF91YXJ0KDEpOwogCXB4YTE2OF9hZGRfdHdzaSgwLCAmcHdy
aTJjX2luZm8sCiAJCQlBUlJBWV9BTkRfU0laRShhc3Blbml0ZV9pMmNfYm9hcmRfaW5mbykpOwor
I2lmZGVmIENPTkZJR19GQl9QWEExNjgKKwlweGExNjhfYWRkX2ZiKCZhc3Blbml0ZV9sY2RfaW5m
byk7CisjZW5kaWYKIAogCS8qIG9mZi1jaGlwIGRldmljZXMgKi8KIAlwbGF0Zm9ybV9kZXZpY2Vf
cmVnaXN0ZXIoJnNtYzkxeF9kZXZpY2UpOwpkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1tbXAv
aW5jbHVkZS9tYWNoL3B4YTE2OC5oIGIvYXJjaC9hcm0vbWFjaC1tbXAvaW5jbHVkZS9tYWNoL3B4
YTE2OC5oCmluZGV4IDZiZjFmMGUuLmEyY2E0N2IgMTAwNjQ0Ci0tLSBhL2FyY2gvYXJtL21hY2gt
bW1wL2luY2x1ZGUvbWFjaC9weGExNjguaAorKysgYi9hcmNoL2FybS9tYWNoLW1tcC9pbmNsdWRl
L21hY2gvcHhhMTY4LmgKQEAgLTQsNiArNCw3IEBACiAjaW5jbHVkZSA8bGludXgvaTJjLmg+CiAj
aW5jbHVkZSA8bWFjaC9kZXZpY2VzLmg+CiAjaW5jbHVkZSA8cGxhdC9pMmMuaD4KKyNpbmNsdWRl
IDx2aWRlby9weGExNjhmYi5oPgogCiBleHRlcm4gc3RydWN0IHB4YV9kZXZpY2VfZGVzYyBweGEx
NjhfZGV2aWNlX3VhcnQxOwogZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNlX2Rlc2MgcHhhMTY4X2Rl
dmljZV91YXJ0MjsKQEAgLTEzLDYgKzE0LDcgQEAgZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNlX2Rl
c2MgcHhhMTY4X2RldmljZV9wd20xOwogZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNlX2Rlc2MgcHhh
MTY4X2RldmljZV9wd20yOwogZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNlX2Rlc2MgcHhhMTY4X2Rl
dmljZV9wd20zOwogZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNlX2Rlc2MgcHhhMTY4X2RldmljZV9w
d200OworZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNlX2Rlc2MgcHhhMTY4X2RldmljZV9mYjsKIAog
c3RhdGljIGlubGluZSBpbnQgcHhhMTY4X2FkZF91YXJ0KGludCBpZCkKIHsKQEAgLTY0LDQgKzY2
LDEwIEBAIHN0YXRpYyBpbmxpbmUgaW50IHB4YTE2OF9hZGRfcHdtKGludCBpZCkKIAogCXJldHVy
biBweGFfcmVnaXN0ZXJfZGV2aWNlKGQsIE5VTEwsIDApOwogfQorCitzdGF0aWMgaW5saW5lIGlu
dCBweGExNjhfYWRkX2ZiKHN0cnVjdCBweGExNjhmYl9tYWNoX2luZm8gKm1pKQoreworCXJldHVy
biBweGFfcmVnaXN0ZXJfZGV2aWNlKCZweGExNjhfZGV2aWNlX2ZiLCBtaSwgc2l6ZW9mKCptaSkp
OworfQorCiAjZW5kaWYgLyogX19BU01fTUFDSF9QWEExNjhfSCAqLwpkaWZmIC0tZ2l0IGEvYXJj
aC9hcm0vbWFjaC1tbXAvcHhhMTY4LmMgYi9hcmNoL2FybS9tYWNoLW1tcC9weGExNjguYwppbmRl
eCA3MWIxYWUzLi4wN2ExMmNlIDEwMDY0NAotLS0gYS9hcmNoL2FybS9tYWNoLW1tcC9weGExNjgu
YworKysgYi9hcmNoL2FybS9tYWNoLW1tcC9weGExNjguYwpAQCAtMTksNiArMTksNyBAQAogI2lu
Y2x1ZGUgPG1hY2gvYWRkci1tYXAuaD4KICNpbmNsdWRlIDxtYWNoL2NwdXR5cGUuaD4KICNpbmNs
dWRlIDxtYWNoL3JlZ3MtYXBiYy5oPgorI2luY2x1ZGUgPG1hY2gvcmVncy1hcG11Lmg+CiAjaW5j
bHVkZSA8bWFjaC9pcnFzLmg+CiAjaW5jbHVkZSA8bWFjaC9ncGlvLmg+CiAjaW5jbHVkZSA8bWFj
aC9kbWEuaD4KQEAgLTcxLDYgKzcyLDcgQEAgc3RhdGljIEFQQkNfQ0xLKHB3bTEsIFBYQTE2OF9Q
V00xLCAxLCAxMzAwMDAwMCk7CiBzdGF0aWMgQVBCQ19DTEsocHdtMiwgUFhBMTY4X1BXTTIsIDEs
IDEzMDAwMDAwKTsKIHN0YXRpYyBBUEJDX0NMSyhwd20zLCBQWEExNjhfUFdNMywgMSwgMTMwMDAw
MDApOwogc3RhdGljIEFQQkNfQ0xLKHB3bTQsIFBYQTE2OF9QV000LCAxLCAxMzAwMDAwMCk7Citz
dGF0aWMgQVBNVV9DTEsobGNkLCBMQ0QsIDB4MDAzZiwgMzEyMDAwMDAwKTsKIAogLyogZGV2aWNl
IGFuZCBjbG9jayBiaW5kaW5ncyAqLwogc3RhdGljIHN0cnVjdCBjbGtfbG9va3VwIHB4YTE2OF9j
bGtyZWdzW10gPSB7CkBAIC04Miw2ICs4NCw3IEBAIHN0YXRpYyBzdHJ1Y3QgY2xrX2xvb2t1cCBw
eGExNjhfY2xrcmVnc1tdID0gewogCUlOSVRfQ0xLUkVHKCZjbGtfcHdtMiwgInB4YTE2OC1wd20u
MSIsIE5VTEwpLAogCUlOSVRfQ0xLUkVHKCZjbGtfcHdtMywgInB4YTE2OC1wd20uMiIsIE5VTEwp
LAogCUlOSVRfQ0xLUkVHKCZjbGtfcHdtNCwgInB4YTE2OC1wd20uMyIsIE5VTEwpLAorCUlOSVRf
Q0xLUkVHKCZjbGtfbGNkLCAicHhhMTY4LWZiIiwgIkxDRENMSyIpLAogfTsKIAogc3RhdGljIGlu
dCBfX2luaXQgcHhhMTY4X2luaXQodm9pZCkKQEAgLTEyNywzICsxMzAsNCBAQCBQWEExNjhfREVW
SUNFKHB3bTEsICJweGExNjgtcHdtIiwgMCwgTk9ORSwgMHhkNDAxYTAwMCwgMHgxMCk7CiBQWEEx
NjhfREVWSUNFKHB3bTIsICJweGExNjgtcHdtIiwgMSwgTk9ORSwgMHhkNDAxYTQwMCwgMHgxMCk7
CiBQWEExNjhfREVWSUNFKHB3bTMsICJweGExNjgtcHdtIiwgMiwgTk9ORSwgMHhkNDAxYTgwMCwg
MHgxMCk7CiBQWEExNjhfREVWSUNFKHB3bTQsICJweGExNjgtcHdtIiwgMywgTk9ORSwgMHhkNDAx
YWMwMCwgMHgxMCk7CitQWEExNjhfREVWSUNFKGZiLCAicHhhMTY4LWZiIiwgLTEsIExDRCwgMHhk
NDIwYjAwMCwgMHgxYzgpOwotLSAKMS41LjQuMwoK
--0016e64b96de1333f70478b5a19e--
