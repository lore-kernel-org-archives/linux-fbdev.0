From: Jun Nie <niej0001@gmail.com>
Date: Mon, 23 Nov 2009 05:52:42 +0000
Subject: Re: [PATCH 7/8] pxa: add frame buffer on pxa168 aspenite platform
Message-Id: <7c34ac520911222152x5d96abe3u1fa663a10dd7b3dd@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="00504502f6231ecd450479036f28"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911160134k57023db1we74073a87a3dd454@mail.gmail.com>
	<f17812d70911162229s43ca6826k29c4c4a7e279144f@mail.gmail.com>
	<7c34ac520911190103q4ba79c60w11dfc8255b69abfa@mail.gmail.com>
	<f17812d70911190829u6831a176j7caae7e0bee3fa53@mail.gmail.com>
	<7c34ac520911191838k45fa4708vd8b606e9ad6a8d7@mail.gmail.com>
	<f17812d70911192056m64b31c62hd050c0567e098cb@mail.gmail.com>
In-Reply-To: <f17812d70911192056m64b31c62hd050c0567e098cb@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org

--00504502f6231ecd450479036f28
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2009/11/20 Eric Miao <eric.y.miao@gmail.com>:
> On Thu, Nov 19, 2009 at 8:38 PM, Jun Nie <niej0001@gmail.com> wrote:
>> 2009/11/20 Eric Miao <eric.y.miao@gmail.com>:
>>>> + =A0 =A0 =A0 int err =3D 0;
>>>> + =A0 =A0 =A0 if (on) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (spi_gpio_reset !=3D -1) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D gpio_request(spi=
_gpio_reset, "TPO_LCD_SPI_RESET");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (err) {
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 printk(K=
ERN_ERR "failed to request GPIO for TPO LCD RESET\n");
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return e=
rr;
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 gpio_direction_output(sp=
i_gpio_reset, 0);
>>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 msleep(100);
>>>
>>> This is really a loooong delay, there any specific reason for such a lo=
ng
>>> delay, I'm seeing this to slow down the boot up significantly?
>>>
>>> Otherwise looks OK to me, and I prefer the defconfig file change to
>>> be a separate patch please.
>>>
>>
>> Actually, This is just an example for other real products. There is no
>> such spi_reset pin on Aspenite , so machine info set it spi_gpio_reset
>> =3D=3D -1. Or do you think we should delete these lines?
>>
>
> I see no reason for it to stay there then, please remove.
>

rebased to topic/pxa168fb branch of pxa git repository. changes include:
1. Delete redundant gpio operation in aspenite.c
2. change to include <linux/gpio.h>

From 6915f1d1abe0e0fe42c162f1392a00d722c5eccd Mon Sep 17 00:00:00 2001
From: Jun Nie <njun@marvell.com>
Date: Mon, 23 Nov 2009 09:56:07 +0800
Subject: [PATCH] pxa: add frame buffer on pxa168 aspenite platform

Signed-off-by: Jun Nie <njun@marvell.com>
---
 arch/arm/configs/pxa168_defconfig       |   86 +++++++++++++++++++++-
 arch/arm/mach-mmp/aspenite.c            |  125 +++++++++++++++++++++++++++=
++++
 arch/arm/mach-mmp/include/mach/pxa168.h |    7 ++
 arch/arm/mach-mmp/pxa168.c              |    3 +
 4 files changed, 219 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/pxa168_defconfig
b/arch/arm/configs/pxa168_defconfig
index db5faea..b736517 100644
--- a/arch/arm/configs/pxa168_defconfig
+++ b/arch/arm/configs/pxa168_defconfig
@@ -509,7 +509,49 @@ CONFIG_UNIX98_PTYS=3Dy
 # CONFIG_R3964 is not set
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
-# CONFIG_I2C is not set
+CONFIG_I2C=3Dy
+CONFIG_I2C_BOARDINFO=3Dy
+# CONFIG_I2C_CHARDEV is not set
+CONFIG_I2C_HELPER_AUTO=3Dy
+CONFIG_I2C_ALGOBIT=3Dy
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+# CONFIG_I2C_DESIGNWARE is not set
+CONFIG_I2C_GPIO=3Dy
+# CONFIG_I2C_OCORES is not set
+CONFIG_I2C_PXA=3Dy
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
 CONFIG_ARCH_REQUIRE_GPIOLIB=3Dy
 CONFIG_GPIOLIB=3Dy
@@ -523,6 +565,9 @@ CONFIG_GPIOLIB=3Dy
 #
 # I2C GPIO expanders:
 #
+# CONFIG_GPIO_MAX732X is not set
+CONFIG_GPIO_PCA953X=3Dy
+# CONFIG_GPIO_PCF857X is not set

 #
 # PCI GPIO expanders:
@@ -578,7 +623,34 @@ CONFIG_SSB_POSSIBLE=3Dy
 #
 # CONFIG_VGASTATE is not set
 # CONFIG_VIDEO_OUTPUT_CONTROL is not set
-# CONFIG_FB is not set
+CONFIG_FB=3Dy
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
+CONFIG_FB_PXA168=3Dy
+# CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
+# CONFIG_FB_MB862XX is not set
+# CONFIG_FB_BROADSHEET is not set
 # CONFIG_BACKLIGHT_LCD_SUPPORT is not set

 #
@@ -591,6 +663,16 @@ CONFIG_SSB_POSSIBLE=3Dy
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
diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index c7990b2..e101042 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -17,6 +17,8 @@
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/nand.h>
 #include <linux/i2c/pca953x.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>

 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
@@ -66,6 +68,39 @@ static unsigned long common_pin_config[] __initdata =3D =
{
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

 static struct smc91x_platdata smc91x_info =3D {
@@ -95,6 +130,93 @@ static struct platform_device smc91x_device =3D {
 	.resource	=3D smc91x_resources,
 };

+#ifdef CONFIG_FB_PXA168
+static u16 tpo_spi_cmdon[] =3D {
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
+static u16 tpo_spi_cmdoff[] =3D {
+	0x0c5e,		/* standby */
+};
+
+static int tpo_lcd_power(struct pxa168fb_info *fbi, unsigned int spi_gpio_=
cs,
+		unsigned int spi_gpio_reset, int on)
+{
+	int err =3D 0;
+	if (on) {
+		return pxa168fb_spi_send(fbi, tpo_spi_cmdon,
+				ARRAY_SIZE(tpo_spi_cmdon), spi_gpio_cs, 0, 1);
+	} else
+		return pxa168fb_spi_send(fbi, tpo_spi_cmdoff,
+				ARRAY_SIZE(tpo_spi_cmdoff), spi_gpio_cs, 0, 1);
+}
+
+static struct fb_videomode video_modes_aspen[] =3D {
+	[0] =3D {
+		.pixclock       =3D 30120,
+		.refresh        =3D 60,
+		.xres           =3D 800,
+		.yres           =3D 480,
+		.hsync_len      =3D 1,
+		.left_margin    =3D 215,
+		.right_margin   =3D 40,
+		.vsync_len      =3D 1,
+		.upper_margin   =3D 34,
+		.lower_margin   =3D 10,
+		.sync           =3D 0,
+	},
+};
+
+struct pxa168fb_mach_info aspenite_lcd_info __initdata =3D {
+	.id                     =3D "Base-aspen",
+	.modes                  =3D video_modes_aspen,
+	.num_modes              =3D ARRAY_SIZE(video_modes_aspen),
+	.pix_fmt                =3D PIX_FMT_RGB565,
+	.io_pin_allocation_mode =3D PIN_MODE_DUMB_24,
+	.dumb_mode              =3D DUMB_MODE_RGB888,
+	.active                 =3D 1,
+	.spi_ctrl		=3D CFG_SCLKCNT(2) | CFG_TXBITS(16) |
+		CFG_SPI_SEL(1) | CFG_SPI_3W4WB(1) | CFG_SPI_ENA(1),
+	.spi_gpio_cs		=3D GPIO_EXT1(14),
+	.spi_gpio_reset         =3D -1,
+	.invert_pixclock	=3D 1,
+	.pxa168fb_lcd_power     =3D tpo_lcd_power,
+};
+
+#endif
+
 #if defined(CONFIG_MTD_NAND) || defined(CONFIG_MTD_NAND_MODULE)
 static struct mtd_partition aspenite_nand_partitions[] =3D {
 	{
@@ -179,6 +301,9 @@ static void __init common_init(void)
 	pxa168_add_nand(&aspenite_nand_info);
 	pxa168_add_twsi(0, &pwri2c_info,
 		ARRAY_AND_SIZE(aspenite_i2c_board_info));
+#ifdef CONFIG_FB_PXA168
+	pxa168_add_fb(&aspenite_lcd_info);
+#endif

 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
diff --git a/arch/arm/mach-mmp/include/mach/pxa168.h
b/arch/arm/mach-mmp/include/mach/pxa168.h
index 3ad612c..6c10c9e 100644
--- a/arch/arm/mach-mmp/include/mach/pxa168.h
+++ b/arch/arm/mach-mmp/include/mach/pxa168.h
@@ -5,6 +5,7 @@
 #include <mach/devices.h>
 #include <plat/i2c.h>
 #include <plat/pxa3xx_nand.h>
+#include <video/pxa168fb.h>

 extern struct pxa_device_desc pxa168_device_uart1;
 extern struct pxa_device_desc pxa168_device_uart2;
@@ -15,6 +16,7 @@ extern struct pxa_device_desc pxa168_device_pwm2;
 extern struct pxa_device_desc pxa168_device_pwm3;
 extern struct pxa_device_desc pxa168_device_pwm4;
 extern struct pxa_device_desc pxa168_device_nand;
+extern struct pxa_device_desc pxa168_device_fb;

 static inline int pxa168_add_uart(int id)
 {
@@ -71,4 +73,9 @@ static inline int pxa168_add_nand(struct
pxa3xx_nand_platform_data *info)
 {
 	return pxa_register_device(&pxa168_device_nand, info, sizeof(*info));
 }
+
+static inline int pxa168_add_fb(struct pxa168fb_mach_info *mi)
+{
+	return pxa_register_device(&pxa168_device_fb, mi, sizeof(*mi));
+}
 #endif /* __ASM_MACH_PXA168_H */
diff --git a/arch/arm/mach-mmp/pxa168.c b/arch/arm/mach-mmp/pxa168.c
index 37dbdde..a5f9c7d 100644
--- a/arch/arm/mach-mmp/pxa168.c
+++ b/arch/arm/mach-mmp/pxa168.c
@@ -74,6 +74,7 @@ static APBC_CLK(pwm3, PXA168_PWM3, 1, 13000000);
 static APBC_CLK(pwm4, PXA168_PWM4, 1, 13000000);

 static APMU_CLK(nand, NAND, 0x01db, 208000000);
+static APMU_CLK(lcd, LCD, 0x003f, 312000000);

 /* device and clock bindings */
 static struct clk_lookup pxa168_clkregs[] =3D {
@@ -86,6 +87,7 @@ static struct clk_lookup pxa168_clkregs[] =3D {
 	INIT_CLKREG(&clk_pwm3, "pxa168-pwm.2", NULL),
 	INIT_CLKREG(&clk_pwm4, "pxa168-pwm.3", NULL),
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
+	INIT_CLKREG(&clk_lcd, "pxa168-fb", "LCDCLK"),
 };

 static int __init pxa168_init(void)
@@ -132,3 +134,4 @@ PXA168_DEVICE(pwm2, "pxa168-pwm", 1, NONE,
0xd401a400, 0x10);
 PXA168_DEVICE(pwm3, "pxa168-pwm", 2, NONE, 0xd401a800, 0x10);
 PXA168_DEVICE(pwm4, "pxa168-pwm", 3, NONE, 0xd401ac00, 0x10);
 PXA168_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x80, 97, 99);
+PXA168_DEVICE(fb, "pxa168-fb", -1, LCD, 0xd420b000, 0x1c8);
--=20
1.5.4.3

--00504502f6231ecd450479036f28
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0001-pxa-add-frame-buffer-on-pxa168-aspenite-platform.patch"
Content-Disposition: attachment; 
	filename="0001-pxa-add-frame-buffer-on-pxa168-aspenite-platform.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g2ctjpzz0

RnJvbSA2OTE1ZjFkMWFiZTBlMGZlNDJjMTYyZjEzOTJhMDBkNzIyYzVlY2NkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBNb24s
IDIzIE5vdiAyMDA5IDA5OjU2OjA3ICswODAwClN1YmplY3Q6IFtQQVRDSF0gcHhhOiBhZGQgZnJh
bWUgYnVmZmVyIG9uIHB4YTE2OCBhc3Blbml0ZSBwbGF0Zm9ybQoKU2lnbmVkLW9mZi1ieTogSnVu
IE5pZSA8bmp1bkBtYXJ2ZWxsLmNvbT4KLS0tCiBhcmNoL2FybS9jb25maWdzL3B4YTE2OF9kZWZj
b25maWcgICAgICAgfCAgIDg2ICsrKysrKysrKysrKysrKysrKysrKy0KIGFyY2gvYXJtL21hY2gt
bW1wL2FzcGVuaXRlLmMgICAgICAgICAgICB8ICAxMjUgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKwogYXJjaC9hcm0vbWFjaC1tbXAvaW5jbHVkZS9tYWNoL3B4YTE2OC5oIHwgICAgNyAr
KwogYXJjaC9hcm0vbWFjaC1tbXAvcHhhMTY4LmMgICAgICAgICAgICAgIHwgICAgMyArCiA0IGZp
bGVzIGNoYW5nZWQsIDIxOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdp
dCBhL2FyY2gvYXJtL2NvbmZpZ3MvcHhhMTY4X2RlZmNvbmZpZyBiL2FyY2gvYXJtL2NvbmZpZ3Mv
cHhhMTY4X2RlZmNvbmZpZwppbmRleCBkYjVmYWVhLi5iNzM2NTE3IDEwMDY0NAotLS0gYS9hcmNo
L2FybS9jb25maWdzL3B4YTE2OF9kZWZjb25maWcKKysrIGIvYXJjaC9hcm0vY29uZmlncy9weGEx
NjhfZGVmY29uZmlnCkBAIC01MDksNyArNTA5LDQ5IEBAIENPTkZJR19VTklYOThfUFRZUz15CiAj
IENPTkZJR19SMzk2NCBpcyBub3Qgc2V0CiAjIENPTkZJR19SQVdfRFJJVkVSIGlzIG5vdCBzZXQK
ICMgQ09ORklHX1RDR19UUE0gaXMgbm90IHNldAotIyBDT05GSUdfSTJDIGlzIG5vdCBzZXQKK0NP
TkZJR19JMkM9eQorQ09ORklHX0kyQ19CT0FSRElORk89eQorIyBDT05GSUdfSTJDX0NIQVJERVYg
aXMgbm90IHNldAorQ09ORklHX0kyQ19IRUxQRVJfQVVUTz15CitDT05GSUdfSTJDX0FMR09CSVQ9
eQorCisjCisjIEkyQyBIYXJkd2FyZSBCdXMgc3VwcG9ydAorIworCisjCisjIEkyQyBzeXN0ZW0g
YnVzIGRyaXZlcnMgKG1vc3RseSBlbWJlZGRlZCAvIHN5c3RlbS1vbi1jaGlwKQorIworIyBDT05G
SUdfSTJDX0RFU0lHTldBUkUgaXMgbm90IHNldAorQ09ORklHX0kyQ19HUElPPXkKKyMgQ09ORklH
X0kyQ19PQ09SRVMgaXMgbm90IHNldAorQ09ORklHX0kyQ19QWEE9eQorIyBDT05GSUdfSTJDX1BY
QV9TTEFWRSBpcyBub3Qgc2V0CisjIENPTkZJR19JMkNfU0lNVEVDIGlzIG5vdCBzZXQKKworIwor
IyBFeHRlcm5hbCBJMkMvU01CdXMgYWRhcHRlciBkcml2ZXJzCisjCisjIENPTkZJR19JMkNfUEFS
UE9SVF9MSUdIVCBpcyBub3Qgc2V0CisjIENPTkZJR19JMkNfVEFPU19FVk0gaXMgbm90IHNldAor
CisjCisjIE90aGVyIEkyQy9TTUJ1cyBidXMgZHJpdmVycworIworIyBDT05GSUdfSTJDX1BDQV9Q
TEFURk9STSBpcyBub3Qgc2V0CisjIENPTkZJR19JMkNfU1RVQiBpcyBub3Qgc2V0CisKKyMKKyMg
TWlzY2VsbGFuZW91cyBJMkMgQ2hpcCBzdXBwb3J0CisjCisjIENPTkZJR19EUzE2ODIgaXMgbm90
IHNldAorIyBDT05GSUdfU0VOU09SU19QQ0Y4NTc0IGlzIG5vdCBzZXQKKyMgQ09ORklHX1BDRjg1
NzUgaXMgbm90IHNldAorIyBDT05GSUdfU0VOU09SU19UU0wyNTUwIGlzIG5vdCBzZXQKKyMgQ09O
RklHX0kyQ19ERUJVR19DT1JFIGlzIG5vdCBzZXQKKyMgQ09ORklHX0kyQ19ERUJVR19BTEdPIGlz
IG5vdCBzZXQKKyMgQ09ORklHX0kyQ19ERUJVR19CVVMgaXMgbm90IHNldAorIyBDT05GSUdfSTJD
X0RFQlVHX0NISVAgaXMgbm90IHNldAogIyBDT05GSUdfU1BJIGlzIG5vdCBzZXQKIENPTkZJR19B
UkNIX1JFUVVJUkVfR1BJT0xJQj15CiBDT05GSUdfR1BJT0xJQj15CkBAIC01MjMsNiArNTY1LDkg
QEAgQ09ORklHX0dQSU9MSUI9eQogIwogIyBJMkMgR1BJTyBleHBhbmRlcnM6CiAjCisjIENPTkZJ
R19HUElPX01BWDczMlggaXMgbm90IHNldAorQ09ORklHX0dQSU9fUENBOTUzWD15CisjIENPTkZJ
R19HUElPX1BDRjg1N1ggaXMgbm90IHNldAogCiAjCiAjIFBDSSBHUElPIGV4cGFuZGVyczoKQEAg
LTU3OCw3ICs2MjMsMzQgQEAgQ09ORklHX1NTQl9QT1NTSUJMRT15CiAjCiAjIENPTkZJR19WR0FT
VEFURSBpcyBub3Qgc2V0CiAjIENPTkZJR19WSURFT19PVVRQVVRfQ09OVFJPTCBpcyBub3Qgc2V0
Ci0jIENPTkZJR19GQiBpcyBub3Qgc2V0CitDT05GSUdfRkI9eQorIyBDT05GSUdfRklSTVdBUkVf
RURJRCBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9EREMgaXMgbm90IHNldAorIyBDT05GSUdfRkJf
Qk9PVF9WRVNBX1NVUFBPUlQgaXMgbm90IHNldAorIyBDT05GSUdfRkJfQ0ZCX0ZJTExSRUNUIGlz
IG5vdCBzZXQKKyMgQ09ORklHX0ZCX0NGQl9DT1BZQVJFQSBpcyBub3Qgc2V0CisjIENPTkZJR19G
Ql9DRkJfSU1BR0VCTElUIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX0NGQl9SRVZfUElYRUxTX0lO
X0JZVEUgaXMgbm90IHNldAorIyBDT05GSUdfRkJfU1lTX0ZJTExSRUNUIGlzIG5vdCBzZXQKKyMg
Q09ORklHX0ZCX1NZU19DT1BZQVJFQSBpcyBub3Qgc2V0CisjIENPTkZJR19GQl9TWVNfSU1BR0VC
TElUIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX0ZPUkVJR05fRU5ESUFOIGlzIG5vdCBzZXQKKyMg
Q09ORklHX0ZCX1NZU19GT1BTIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX1NWR0FMSUIgaXMgbm90
IHNldAorIyBDT05GSUdfRkJfTUFDTU9ERVMgaXMgbm90IHNldAorIyBDT05GSUdfRkJfQkFDS0xJ
R0hUIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX01PREVfSEVMUEVSUyBpcyBub3Qgc2V0CisjIENP
TkZJR19GQl9USUxFQkxJVFRJTkcgaXMgbm90IHNldAorCisjCisjIEZyYW1lIGJ1ZmZlciBoYXJk
d2FyZSBkcml2ZXJzCisjCisjIENPTkZJR19GQl9TMUQxM1hYWCBpcyBub3Qgc2V0CitDT05GSUdf
RkJfUFhBMTY4PXkKKyMgQ09ORklHX0ZCX1ZJUlRVQUwgaXMgbm90IHNldAorIyBDT05GSUdfRkJf
TUVUUk9OT01FIGlzIG5vdCBzZXQKKyMgQ09ORklHX0ZCX01CODYyWFggaXMgbm90IHNldAorIyBD
T05GSUdfRkJfQlJPQURTSEVFVCBpcyBub3Qgc2V0CiAjIENPTkZJR19CQUNLTElHSFRfTENEX1NV
UFBPUlQgaXMgbm90IHNldAogCiAjCkBAIC01OTEsNiArNjYzLDE2IEBAIENPTkZJR19TU0JfUE9T
U0lCTEU9eQogIwogIyBDT05GSUdfVkdBX0NPTlNPTEUgaXMgbm90IHNldAogQ09ORklHX0RVTU1Z
X0NPTlNPTEU9eQorQ09ORklHX0ZSQU1FQlVGRkVSX0NPTlNPTEU9eQorQ09ORklHX0ZSQU1FQlVG
RkVSX0NPTlNPTEVfREVURUNUX1BSSU1BUlk9eQorIyBDT05GSUdfRlJBTUVCVUZGRVJfQ09OU09M
RV9ST1RBVElPTiBpcyBub3Qgc2V0CisjIENPTkZJR19GT05UUyBpcyBub3Qgc2V0CitDT05GSUdf
Rk9OVF84eDg9eQorQ09ORklHX0ZPTlRfOHgxNj15CitDT05GSUdfTE9HTz15CisjIENPTkZJR19M
T0dPX0xJTlVYX01PTk8gaXMgbm90IHNldAorQ09ORklHX0xPR09fTElOVVhfVkdBMTY9eQorQ09O
RklHX0xPR09fTElOVVhfQ0xVVDIyND15CiAjIENPTkZJR19TT1VORCBpcyBub3Qgc2V0CiAjIENP
TkZJR19ISURfU1VQUE9SVCBpcyBub3Qgc2V0CiAjIENPTkZJR19VU0JfU1VQUE9SVCBpcyBub3Qg
c2V0CmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW1tcC9hc3Blbml0ZS5jIGIvYXJjaC9hcm0v
bWFjaC1tbXAvYXNwZW5pdGUuYwppbmRleCBjNzk5MGIyLi5lMTAxMDQyIDEwMDY0NAotLS0gYS9h
cmNoL2FybS9tYWNoLW1tcC9hc3Blbml0ZS5jCisrKyBiL2FyY2gvYXJtL21hY2gtbW1wL2FzcGVu
aXRlLmMKQEAgLTE3LDYgKzE3LDggQEAKICNpbmNsdWRlIDxsaW51eC9tdGQvcGFydGl0aW9ucy5o
PgogI2luY2x1ZGUgPGxpbnV4L210ZC9uYW5kLmg+CiAjaW5jbHVkZSA8bGludXgvaTJjL3BjYTk1
M3guaD4KKyNpbmNsdWRlIDxsaW51eC9kZWxheS5oPgorI2luY2x1ZGUgPGxpbnV4L2dwaW8uaD4K
IAogI2luY2x1ZGUgPGFzbS9tYWNoLXR5cGVzLmg+CiAjaW5jbHVkZSA8YXNtL21hY2gvYXJjaC5o
PgpAQCAtNjYsNiArNjgsMzkgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgY29tbW9uX3Bpbl9jb25m
aWdbXSBfX2luaXRkYXRhID0gewogCS8qIFVBUlQxICovCiAJR1BJTzEwN19VQVJUMV9SWEQsCiAJ
R1BJTzEwOF9VQVJUMV9UWEQsCisKKyNpZmRlZiBDT05GSUdfRkJfUFhBMTY4CisJLyogTENEICov
CisJR1BJTzU2X0xDRF9GQ0xLX1JELAorCUdQSU81N19MQ0RfTENMS19BMCwKKwlHUElPNThfTENE
X1BDTEtfV1IsCisJR1BJTzU5X0xDRF9ERU5BX0JJQVMsCisJR1BJTzYwX0xDRF9ERDAsCisJR1BJ
TzYxX0xDRF9ERDEsCisJR1BJTzYyX0xDRF9ERDIsCisJR1BJTzYzX0xDRF9ERDMsCisJR1BJTzY0
X0xDRF9ERDQsCisJR1BJTzY1X0xDRF9ERDUsCisJR1BJTzY2X0xDRF9ERDYsCisJR1BJTzY3X0xD
RF9ERDcsCisJR1BJTzY4X0xDRF9ERDgsCisJR1BJTzY5X0xDRF9ERDksCisJR1BJTzcwX0xDRF9E
RDEwLAorCUdQSU83MV9MQ0RfREQxMSwKKwlHUElPNzJfTENEX0REMTIsCisJR1BJTzczX0xDRF9E
RDEzLAorCUdQSU83NF9MQ0RfREQxNCwKKwlHUElPNzVfTENEX0REMTUsCisKKwlHUElPNzZfTENE
X0REMTYsCisJR1BJTzc3X0xDRF9ERDE3LAorCUdQSU83OF9MQ0RfREQxOCwKKwlHUElPNzlfTENE
X0REMTksCisJR1BJTzgwX0xDRF9ERDIwLAorCUdQSU84MV9MQ0RfREQyMSwKKwlHUElPODJfTENE
X0REMjIsCisJR1BJTzgzX0xDRF9ERDIzLAorI2VuZGlmCiB9OwogCiBzdGF0aWMgc3RydWN0IHNt
YzkxeF9wbGF0ZGF0YSBzbWM5MXhfaW5mbyA9IHsKQEAgLTk1LDYgKzEzMCw5MyBAQCBzdGF0aWMg
c3RydWN0IHBsYXRmb3JtX2RldmljZSBzbWM5MXhfZGV2aWNlID0gewogCS5yZXNvdXJjZQk9IHNt
YzkxeF9yZXNvdXJjZXMsCiB9OwogCisjaWZkZWYgQ09ORklHX0ZCX1BYQTE2OAorc3RhdGljIHUx
NiB0cG9fc3BpX2NtZG9uW10gPSB7CisJMHgwODBGLAorCTB4MEM1RiwKKwkweDEwMTcsCisJMHgx
NDIwLAorCTB4MTgwOCwKKwkweDFjMjAsCisJMHgyMDIwLAorCTB4MjQyMCwKKwkweDI4MjAsCisJ
MHgyYzIwLAorCTB4MzAyMCwKKwkweDM0MjAsCisJMHgzODEwLAorCTB4M2MxMCwKKwkweDQwMTAs
CisJMHg0NDE1LAorCTB4NDhhYSwKKwkweDRjZmYsCisJMHg1MDg2LAorCTB4NTQ4ZCwKKwkweDU4
ZDQsCisJMHg1Y2ZiLAorCTB4NjAyZSwKKwkweDY0NWEsCisJMHg2ODg5LAorCTB4NmNmZSwKKwkw
eDcwNWEsCisJMHg3NDliLAorCTB4NzhjNSwKKwkweDdjZmYsCisJMHg4MGYwLAorCTB4ODRmMCwK
KwkweDg4MDgsCit9OworCitzdGF0aWMgdTE2IHRwb19zcGlfY21kb2ZmW10gPSB7CisJMHgwYzVl
LAkJLyogc3RhbmRieSAqLworfTsKKworc3RhdGljIGludCB0cG9fbGNkX3Bvd2VyKHN0cnVjdCBw
eGExNjhmYl9pbmZvICpmYmksIHVuc2lnbmVkIGludCBzcGlfZ3Bpb19jcywKKwkJdW5zaWduZWQg
aW50IHNwaV9ncGlvX3Jlc2V0LCBpbnQgb24pCit7CisJaW50IGVyciA9IDA7CisJaWYgKG9uKSB7
CisJCXJldHVybiBweGExNjhmYl9zcGlfc2VuZChmYmksIHRwb19zcGlfY21kb24sCisJCQkJQVJS
QVlfU0laRSh0cG9fc3BpX2NtZG9uKSwgc3BpX2dwaW9fY3MsIDAsIDEpOworCX0gZWxzZQorCQly
ZXR1cm4gcHhhMTY4ZmJfc3BpX3NlbmQoZmJpLCB0cG9fc3BpX2NtZG9mZiwKKwkJCQlBUlJBWV9T
SVpFKHRwb19zcGlfY21kb2ZmKSwgc3BpX2dwaW9fY3MsIDAsIDEpOworfQorCitzdGF0aWMgc3Ry
dWN0IGZiX3ZpZGVvbW9kZSB2aWRlb19tb2Rlc19hc3BlbltdID0geworCVswXSA9IHsKKwkJLnBp
eGNsb2NrICAgICAgID0gMzAxMjAsCisJCS5yZWZyZXNoICAgICAgICA9IDYwLAorCQkueHJlcyAg
ICAgICAgICAgPSA4MDAsCisJCS55cmVzICAgICAgICAgICA9IDQ4MCwKKwkJLmhzeW5jX2xlbiAg
ICAgID0gMSwKKwkJLmxlZnRfbWFyZ2luICAgID0gMjE1LAorCQkucmlnaHRfbWFyZ2luICAgPSA0
MCwKKwkJLnZzeW5jX2xlbiAgICAgID0gMSwKKwkJLnVwcGVyX21hcmdpbiAgID0gMzQsCisJCS5s
b3dlcl9tYXJnaW4gICA9IDEwLAorCQkuc3luYyAgICAgICAgICAgPSAwLAorCX0sCit9OworCitz
dHJ1Y3QgcHhhMTY4ZmJfbWFjaF9pbmZvIGFzcGVuaXRlX2xjZF9pbmZvIF9faW5pdGRhdGEgPSB7
CisJLmlkICAgICAgICAgICAgICAgICAgICAgPSAiQmFzZS1hc3BlbiIsCisJLm1vZGVzICAgICAg
ICAgICAgICAgICAgPSB2aWRlb19tb2Rlc19hc3BlbiwKKwkubnVtX21vZGVzICAgICAgICAgICAg
ICA9IEFSUkFZX1NJWkUodmlkZW9fbW9kZXNfYXNwZW4pLAorCS5waXhfZm10ICAgICAgICAgICAg
ICAgID0gUElYX0ZNVF9SR0I1NjUsCisJLmlvX3Bpbl9hbGxvY2F0aW9uX21vZGUgPSBQSU5fTU9E
RV9EVU1CXzI0LAorCS5kdW1iX21vZGUgICAgICAgICAgICAgID0gRFVNQl9NT0RFX1JHQjg4OCwK
KwkuYWN0aXZlICAgICAgICAgICAgICAgICA9IDEsCisJLnNwaV9jdHJsCQk9IENGR19TQ0xLQ05U
KDIpIHwgQ0ZHX1RYQklUUygxNikgfAorCQlDRkdfU1BJX1NFTCgxKSB8IENGR19TUElfM1c0V0Io
MSkgfCBDRkdfU1BJX0VOQSgxKSwKKwkuc3BpX2dwaW9fY3MJCT0gR1BJT19FWFQxKDE0KSwKKwku
c3BpX2dwaW9fcmVzZXQgICAgICAgICA9IC0xLAorCS5pbnZlcnRfcGl4Y2xvY2sJPSAxLAorCS5w
eGExNjhmYl9sY2RfcG93ZXIgICAgID0gdHBvX2xjZF9wb3dlciwKK307CisKKyNlbmRpZgorCiAj
aWYgZGVmaW5lZChDT05GSUdfTVREX05BTkQpIHx8IGRlZmluZWQoQ09ORklHX01URF9OQU5EX01P
RFVMRSkKIHN0YXRpYyBzdHJ1Y3QgbXRkX3BhcnRpdGlvbiBhc3Blbml0ZV9uYW5kX3BhcnRpdGlv
bnNbXSA9IHsKIAl7CkBAIC0xNzksNiArMzAxLDkgQEAgc3RhdGljIHZvaWQgX19pbml0IGNvbW1v
bl9pbml0KHZvaWQpCiAJcHhhMTY4X2FkZF9uYW5kKCZhc3Blbml0ZV9uYW5kX2luZm8pOwogCXB4
YTE2OF9hZGRfdHdzaSgwLCAmcHdyaTJjX2luZm8sCiAJCUFSUkFZX0FORF9TSVpFKGFzcGVuaXRl
X2kyY19ib2FyZF9pbmZvKSk7CisjaWZkZWYgQ09ORklHX0ZCX1BYQTE2OAorCXB4YTE2OF9hZGRf
ZmIoJmFzcGVuaXRlX2xjZF9pbmZvKTsKKyNlbmRpZgogCiAJLyogb2ZmLWNoaXAgZGV2aWNlcyAq
LwogCXBsYXRmb3JtX2RldmljZV9yZWdpc3Rlcigmc21jOTF4X2RldmljZSk7CmRpZmYgLS1naXQg
YS9hcmNoL2FybS9tYWNoLW1tcC9pbmNsdWRlL21hY2gvcHhhMTY4LmggYi9hcmNoL2FybS9tYWNo
LW1tcC9pbmNsdWRlL21hY2gvcHhhMTY4LmgKaW5kZXggM2FkNjEyYy4uNmMxMGM5ZSAxMDA2NDQK
LS0tIGEvYXJjaC9hcm0vbWFjaC1tbXAvaW5jbHVkZS9tYWNoL3B4YTE2OC5oCisrKyBiL2FyY2gv
YXJtL21hY2gtbW1wL2luY2x1ZGUvbWFjaC9weGExNjguaApAQCAtNSw2ICs1LDcgQEAKICNpbmNs
dWRlIDxtYWNoL2RldmljZXMuaD4KICNpbmNsdWRlIDxwbGF0L2kyYy5oPgogI2luY2x1ZGUgPHBs
YXQvcHhhM3h4X25hbmQuaD4KKyNpbmNsdWRlIDx2aWRlby9weGExNjhmYi5oPgogCiBleHRlcm4g
c3RydWN0IHB4YV9kZXZpY2VfZGVzYyBweGExNjhfZGV2aWNlX3VhcnQxOwogZXh0ZXJuIHN0cnVj
dCBweGFfZGV2aWNlX2Rlc2MgcHhhMTY4X2RldmljZV91YXJ0MjsKQEAgLTE1LDYgKzE2LDcgQEAg
ZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNlX2Rlc2MgcHhhMTY4X2RldmljZV9wd20yOwogZXh0ZXJu
IHN0cnVjdCBweGFfZGV2aWNlX2Rlc2MgcHhhMTY4X2RldmljZV9wd20zOwogZXh0ZXJuIHN0cnVj
dCBweGFfZGV2aWNlX2Rlc2MgcHhhMTY4X2RldmljZV9wd200OwogZXh0ZXJuIHN0cnVjdCBweGFf
ZGV2aWNlX2Rlc2MgcHhhMTY4X2RldmljZV9uYW5kOworZXh0ZXJuIHN0cnVjdCBweGFfZGV2aWNl
X2Rlc2MgcHhhMTY4X2RldmljZV9mYjsKIAogc3RhdGljIGlubGluZSBpbnQgcHhhMTY4X2FkZF91
YXJ0KGludCBpZCkKIHsKQEAgLTcxLDQgKzczLDkgQEAgc3RhdGljIGlubGluZSBpbnQgcHhhMTY4
X2FkZF9uYW5kKHN0cnVjdCBweGEzeHhfbmFuZF9wbGF0Zm9ybV9kYXRhICppbmZvKQogewogCXJl
dHVybiBweGFfcmVnaXN0ZXJfZGV2aWNlKCZweGExNjhfZGV2aWNlX25hbmQsIGluZm8sIHNpemVv
ZigqaW5mbykpOwogfQorCitzdGF0aWMgaW5saW5lIGludCBweGExNjhfYWRkX2ZiKHN0cnVjdCBw
eGExNjhmYl9tYWNoX2luZm8gKm1pKQoreworCXJldHVybiBweGFfcmVnaXN0ZXJfZGV2aWNlKCZw
eGExNjhfZGV2aWNlX2ZiLCBtaSwgc2l6ZW9mKCptaSkpOworfQogI2VuZGlmIC8qIF9fQVNNX01B
Q0hfUFhBMTY4X0ggKi8KZGlmZiAtLWdpdCBhL2FyY2gvYXJtL21hY2gtbW1wL3B4YTE2OC5jIGIv
YXJjaC9hcm0vbWFjaC1tbXAvcHhhMTY4LmMKaW5kZXggMzdkYmRkZS4uYTVmOWM3ZCAxMDA2NDQK
LS0tIGEvYXJjaC9hcm0vbWFjaC1tbXAvcHhhMTY4LmMKKysrIGIvYXJjaC9hcm0vbWFjaC1tbXAv
cHhhMTY4LmMKQEAgLTc0LDYgKzc0LDcgQEAgc3RhdGljIEFQQkNfQ0xLKHB3bTMsIFBYQTE2OF9Q
V00zLCAxLCAxMzAwMDAwMCk7CiBzdGF0aWMgQVBCQ19DTEsocHdtNCwgUFhBMTY4X1BXTTQsIDEs
IDEzMDAwMDAwKTsKIAogc3RhdGljIEFQTVVfQ0xLKG5hbmQsIE5BTkQsIDB4MDFkYiwgMjA4MDAw
MDAwKTsKK3N0YXRpYyBBUE1VX0NMSyhsY2QsIExDRCwgMHgwMDNmLCAzMTIwMDAwMDApOwogCiAv
KiBkZXZpY2UgYW5kIGNsb2NrIGJpbmRpbmdzICovCiBzdGF0aWMgc3RydWN0IGNsa19sb29rdXAg
cHhhMTY4X2Nsa3JlZ3NbXSA9IHsKQEAgLTg2LDYgKzg3LDcgQEAgc3RhdGljIHN0cnVjdCBjbGtf
bG9va3VwIHB4YTE2OF9jbGtyZWdzW10gPSB7CiAJSU5JVF9DTEtSRUcoJmNsa19wd20zLCAicHhh
MTY4LXB3bS4yIiwgTlVMTCksCiAJSU5JVF9DTEtSRUcoJmNsa19wd200LCAicHhhMTY4LXB3bS4z
IiwgTlVMTCksCiAJSU5JVF9DTEtSRUcoJmNsa19uYW5kLCAicHhhM3h4LW5hbmQiLCBOVUxMKSwK
KwlJTklUX0NMS1JFRygmY2xrX2xjZCwgInB4YTE2OC1mYiIsICJMQ0RDTEsiKSwKIH07CiAKIHN0
YXRpYyBpbnQgX19pbml0IHB4YTE2OF9pbml0KHZvaWQpCkBAIC0xMzIsMyArMTM0LDQgQEAgUFhB
MTY4X0RFVklDRShwd20yLCAicHhhMTY4LXB3bSIsIDEsIE5PTkUsIDB4ZDQwMWE0MDAsIDB4MTAp
OwogUFhBMTY4X0RFVklDRShwd20zLCAicHhhMTY4LXB3bSIsIDIsIE5PTkUsIDB4ZDQwMWE4MDAs
IDB4MTApOwogUFhBMTY4X0RFVklDRShwd200LCAicHhhMTY4LXB3bSIsIDMsIE5PTkUsIDB4ZDQw
MWFjMDAsIDB4MTApOwogUFhBMTY4X0RFVklDRShuYW5kLCAicHhhM3h4LW5hbmQiLCAtMSwgTkFO
RCwgMHhkNDI4MzAwMCwgMHg4MCwgOTcsIDk5KTsKK1BYQTE2OF9ERVZJQ0UoZmIsICJweGExNjgt
ZmIiLCAtMSwgTENELCAweGQ0MjBiMDAwLCAweDFjOCk7Ci0tIAoxLjUuNC4zCgo=
--00504502f6231ecd450479036f28--
