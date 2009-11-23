From: Jun Nie <niej0001@gmail.com>
Date: Mon, 23 Nov 2009 05:55:22 +0000
Subject: Re: [PATCH 8/8] pxa: add frame buffer on pxa910 ttc_dkb platform
Message-Id: <7c34ac520911222155w18cfe43ft819af146357d67f2@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0016e648d096a337a404790378a7"
List-Id: <linux-fbdev.vger.kernel.org>
References: <7c34ac520911160135x2133c734ub15db7abc64b22a3@mail.gmail.com>
	<7c34ac520911190104n664ae2a2u31a4fdb63385da7c@mail.gmail.com>
	<20091119091323.GD13376@n2100.arm.linux.org.uk>
In-Reply-To: <20091119091323.GD13376@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org

--0016e648d096a337a404790378a7
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

2009/11/19 Russell King - ARM Linux <linux@arm.linux.org.uk>:
> On Thu, Nov 19, 2009 at 05:04:14PM +0800, Jun Nie wrote:
>> > diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
>> > index dbd8cfd..15e64b4 100644
>> > --- a/arch/arm/mach-mmp/ttc_dkb.c
>> > +++ b/arch/arm/mach-mmp/ttc_dkb.c
>> > @@ -14,6 +14,8 @@
>> > =A0#include <linux/mtd/mtd.h>
>> > =A0#include <linux/mtd/partitions.h>
>> > =A0#include <linux/mtd/onenand.h>
>> > +#include <linux/delay.h>
>> > +#include <video/pxa168fb.h>
>> >
>> > =A0#include <asm/mach-types.h>
>> > =A0#include <asm/mach/arch.h>
>> > @@ -21,6 +23,7 @@
>> > =A0#include <mach/addr-map.h>
>> > =A0#include <mach/mfp-pxa910.h>
>> > =A0#include <mach/pxa910.h>
>> > +#include <mach/gpio.h>
>
> linux/gpio.h please.
>

Rebased to topic/pxa168fb branch of pxa git repository. Change is
minimize LCD reset time of gpio operation.

From 91479fe76e31686747b016d6667a14d3aec3b074 Mon Sep 17 00:00:00 2001
From: Jun Nie <njun@marvell.com>
Date: Mon, 23 Nov 2009 10:32:51 +0800
Subject: [PATCH] pxa: add frame buffer on pxa910 ttc_dkb platform

Signed-off-by: Jun Nie <njun@marvell.com>
---
 arch/arm/configs/pxa910_defconfig       |   39 ++++++++-
 arch/arm/mach-mmp/include/mach/pxa910.h |    7 ++
 arch/arm/mach-mmp/pxa910.c              |    3 +
 arch/arm/mach-mmp/ttc_dkb.c             |  144 +++++++++++++++++++++++++++=
++++
 4 files changed, 192 insertions(+), 1 deletions(-)

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
index 4f0b4ec..0236182 100644
--- a/arch/arm/mach-mmp/include/mach/pxa910.h
+++ b/arch/arm/mach-mmp/include/mach/pxa910.h
@@ -5,6 +5,7 @@
 #include <mach/devices.h>
 #include <plat/i2c.h>
 #include <plat/pxa3xx_nand.h>
+#include <video/pxa168fb.h>

 extern struct pxa_device_desc pxa910_device_uart1;
 extern struct pxa_device_desc pxa910_device_uart2;
@@ -15,6 +16,7 @@ extern struct pxa_device_desc pxa910_device_pwm2;
 extern struct pxa_device_desc pxa910_device_pwm3;
 extern struct pxa_device_desc pxa910_device_pwm4;
 extern struct pxa_device_desc pxa910_device_nand;
+extern struct pxa_device_desc pxa910_device_fb;

 static inline int pxa910_add_uart(int id)
 {
@@ -71,4 +73,9 @@ static inline int pxa910_add_nand(struct
pxa3xx_nand_platform_data *info)
 {
 	return pxa_register_device(&pxa910_device_nand, info, sizeof(*info));
 }
+
+static inline int pxa910_add_fb(struct pxa168fb_mach_info *mi)
+{
+	return pxa_register_device(&pxa910_device_fb, mi, sizeof(*mi));
+}
 #endif /* __ASM_MACH_PXA910_H */
diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index d404950..7b91ea6 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -111,6 +111,7 @@ static APBC_CLK(pwm3, PXA910_PWM3, 1, 13000000);
 static APBC_CLK(pwm4, PXA910_PWM4, 1, 13000000);

 static APMU_CLK(nand, NAND, 0x01db, 208000000);
+static APMU_CLK(lcd, LCD, 0x003f, 312000000);

 /* device and clock bindings */
 static struct clk_lookup pxa910_clkregs[] =3D {
@@ -123,6 +124,7 @@ static struct clk_lookup pxa910_clkregs[] =3D {
 	INIT_CLKREG(&clk_pwm3, "pxa910-pwm.2", NULL),
 	INIT_CLKREG(&clk_pwm4, "pxa910-pwm.3", NULL),
 	INIT_CLKREG(&clk_nand, "pxa3xx-nand", NULL),
+	INIT_CLKREG(&clk_lcd, "pxa910-fb", "LCDCLK"),
 };

 static int __init pxa910_init(void)
@@ -178,3 +180,4 @@ PXA910_DEVICE(pwm2, "pxa910-pwm", 1, NONE,
0xd401a400, 0x10);
 PXA910_DEVICE(pwm3, "pxa910-pwm", 2, NONE, 0xd401a800, 0x10);
 PXA910_DEVICE(pwm4, "pxa910-pwm", 3, NONE, 0xd401ac00, 0x10);
 PXA910_DEVICE(nand, "pxa3xx-nand", -1, NAND, 0xd4283000, 0x80, 97, 99);
+PXA910_DEVICE(fb, "pxa910-fb", -1, LCD, 0xd420b000, 0x1c8);
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index bb26cb5..d3e7e1f 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -14,7 +14,10 @@
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
 #include <linux/mtd/onenand.h>
+#include <linux/delay.h>
+#include <linux/gpio.h>

+#include <video/pxa168fb.h>
 #include <asm/mach-types.h>
 #include <asm/mach/arch.h>
 #include <asm/mach/flash.h>
@@ -31,6 +34,37 @@ static unsigned long ttc_dkb_pin_config[] __initdata =3D=
 {
 	GPIO47_UART2_RXD,
 	GPIO48_UART2_TXD,

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
+
 	/* DFI */
 	DF_IO0_ND_IO0,
 	DF_IO1_ND_IO1,
@@ -56,6 +90,113 @@ static unsigned long ttc_dkb_pin_config[] __initdata =
=3D {
 	DF_RDY0_DF_RDY0,
 };

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
+			msleep(1);
+			gpio_set_value(spi_gpio_reset, 1);
+			msleep(11);
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
+};
+#endif
+
 static struct mtd_partition ttc_dkb_onenand_partitions[] =3D {
 	{
 		.name		=3D "bootloader",
@@ -118,6 +259,9 @@ static void __init ttc_dkb_init(void)

 	/* on-chip devices */
 	pxa910_add_uart(1);
+#ifdef CONFIG_FB_PXA168
+	pxa910_add_fb(&ttc_dkb_lcd_info);
+#endif

 	/* off-chip devices */
 	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
--=20
1.5.4.3

--0016e648d096a337a404790378a7
Content-Type: text/x-diff; charset=US-ASCII; 
	name="0002-pxa-add-frame-buffer-on-pxa910-ttc_dkb-platform.patch"
Content-Disposition: attachment; 
	filename="0002-pxa-add-frame-buffer-on-pxa910-ttc_dkb-platform.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_g2cton4l0

RnJvbSA5MTQ3OWZlNzZlMzE2ODY3NDdiMDE2ZDY2NjdhMTRkM2FlYzNiMDc0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKdW4gTmllIDxuanVuQG1hcnZlbGwuY29tPgpEYXRlOiBNb24s
IDIzIE5vdiAyMDA5IDEwOjMyOjUxICswODAwClN1YmplY3Q6IFtQQVRDSF0gcHhhOiBhZGQgZnJh
bWUgYnVmZmVyIG9uIHB4YTkxMCB0dGNfZGtiIHBsYXRmb3JtCgpTaWduZWQtb2ZmLWJ5OiBKdW4g
TmllIDxuanVuQG1hcnZlbGwuY29tPgotLS0KIGFyY2gvYXJtL2NvbmZpZ3MvcHhhOTEwX2RlZmNv
bmZpZyAgICAgICB8ICAgMzkgKysrKysrKystCiBhcmNoL2FybS9tYWNoLW1tcC9pbmNsdWRlL21h
Y2gvcHhhOTEwLmggfCAgICA3ICsrCiBhcmNoL2FybS9tYWNoLW1tcC9weGE5MTAuYyAgICAgICAg
ICAgICAgfCAgICAzICsKIGFyY2gvYXJtL21hY2gtbW1wL3R0Y19ka2IuYyAgICAgICAgICAgICB8
ICAxNDQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogNCBmaWxlcyBjaGFuZ2VkLCAx
OTIgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9hcmNoL2FybS9j
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
aC9weGE5MTAuaAppbmRleCA0ZjBiNGVjLi4wMjM2MTgyIDEwMDY0NAotLS0gYS9hcmNoL2FybS9t
YWNoLW1tcC9pbmNsdWRlL21hY2gvcHhhOTEwLmgKKysrIGIvYXJjaC9hcm0vbWFjaC1tbXAvaW5j
bHVkZS9tYWNoL3B4YTkxMC5oCkBAIC01LDYgKzUsNyBAQAogI2luY2x1ZGUgPG1hY2gvZGV2aWNl
cy5oPgogI2luY2x1ZGUgPHBsYXQvaTJjLmg+CiAjaW5jbHVkZSA8cGxhdC9weGEzeHhfbmFuZC5o
PgorI2luY2x1ZGUgPHZpZGVvL3B4YTE2OGZiLmg+CiAKIGV4dGVybiBzdHJ1Y3QgcHhhX2Rldmlj
ZV9kZXNjIHB4YTkxMF9kZXZpY2VfdWFydDE7CiBleHRlcm4gc3RydWN0IHB4YV9kZXZpY2VfZGVz
YyBweGE5MTBfZGV2aWNlX3VhcnQyOwpAQCAtMTUsNiArMTYsNyBAQCBleHRlcm4gc3RydWN0IHB4
YV9kZXZpY2VfZGVzYyBweGE5MTBfZGV2aWNlX3B3bTI7CiBleHRlcm4gc3RydWN0IHB4YV9kZXZp
Y2VfZGVzYyBweGE5MTBfZGV2aWNlX3B3bTM7CiBleHRlcm4gc3RydWN0IHB4YV9kZXZpY2VfZGVz
YyBweGE5MTBfZGV2aWNlX3B3bTQ7CiBleHRlcm4gc3RydWN0IHB4YV9kZXZpY2VfZGVzYyBweGE5
MTBfZGV2aWNlX25hbmQ7CitleHRlcm4gc3RydWN0IHB4YV9kZXZpY2VfZGVzYyBweGE5MTBfZGV2
aWNlX2ZiOwogCiBzdGF0aWMgaW5saW5lIGludCBweGE5MTBfYWRkX3VhcnQoaW50IGlkKQogewpA
QCAtNzEsNCArNzMsOSBAQCBzdGF0aWMgaW5saW5lIGludCBweGE5MTBfYWRkX25hbmQoc3RydWN0
IHB4YTN4eF9uYW5kX3BsYXRmb3JtX2RhdGEgKmluZm8pCiB7CiAJcmV0dXJuIHB4YV9yZWdpc3Rl
cl9kZXZpY2UoJnB4YTkxMF9kZXZpY2VfbmFuZCwgaW5mbywgc2l6ZW9mKCppbmZvKSk7CiB9CisK
K3N0YXRpYyBpbmxpbmUgaW50IHB4YTkxMF9hZGRfZmIoc3RydWN0IHB4YTE2OGZiX21hY2hfaW5m
byAqbWkpCit7CisJcmV0dXJuIHB4YV9yZWdpc3Rlcl9kZXZpY2UoJnB4YTkxMF9kZXZpY2VfZmIs
IG1pLCBzaXplb2YoKm1pKSk7Cit9CiAjZW5kaWYgLyogX19BU01fTUFDSF9QWEE5MTBfSCAqLwpk
aWZmIC0tZ2l0IGEvYXJjaC9hcm0vbWFjaC1tbXAvcHhhOTEwLmMgYi9hcmNoL2FybS9tYWNoLW1t
cC9weGE5MTAuYwppbmRleCBkNDA0OTUwLi43YjkxZWE2IDEwMDY0NAotLS0gYS9hcmNoL2FybS9t
YWNoLW1tcC9weGE5MTAuYworKysgYi9hcmNoL2FybS9tYWNoLW1tcC9weGE5MTAuYwpAQCAtMTEx
LDYgKzExMSw3IEBAIHN0YXRpYyBBUEJDX0NMSyhwd20zLCBQWEE5MTBfUFdNMywgMSwgMTMwMDAw
MDApOwogc3RhdGljIEFQQkNfQ0xLKHB3bTQsIFBYQTkxMF9QV000LCAxLCAxMzAwMDAwMCk7CiAK
IHN0YXRpYyBBUE1VX0NMSyhuYW5kLCBOQU5ELCAweDAxZGIsIDIwODAwMDAwMCk7CitzdGF0aWMg
QVBNVV9DTEsobGNkLCBMQ0QsIDB4MDAzZiwgMzEyMDAwMDAwKTsKIAogLyogZGV2aWNlIGFuZCBj
bG9jayBiaW5kaW5ncyAqLwogc3RhdGljIHN0cnVjdCBjbGtfbG9va3VwIHB4YTkxMF9jbGtyZWdz
W10gPSB7CkBAIC0xMjMsNiArMTI0LDcgQEAgc3RhdGljIHN0cnVjdCBjbGtfbG9va3VwIHB4YTkx
MF9jbGtyZWdzW10gPSB7CiAJSU5JVF9DTEtSRUcoJmNsa19wd20zLCAicHhhOTEwLXB3bS4yIiwg
TlVMTCksCiAJSU5JVF9DTEtSRUcoJmNsa19wd200LCAicHhhOTEwLXB3bS4zIiwgTlVMTCksCiAJ
SU5JVF9DTEtSRUcoJmNsa19uYW5kLCAicHhhM3h4LW5hbmQiLCBOVUxMKSwKKwlJTklUX0NMS1JF
RygmY2xrX2xjZCwgInB4YTkxMC1mYiIsICJMQ0RDTEsiKSwKIH07CiAKIHN0YXRpYyBpbnQgX19p
bml0IHB4YTkxMF9pbml0KHZvaWQpCkBAIC0xNzgsMyArMTgwLDQgQEAgUFhBOTEwX0RFVklDRShw
d20yLCAicHhhOTEwLXB3bSIsIDEsIE5PTkUsIDB4ZDQwMWE0MDAsIDB4MTApOwogUFhBOTEwX0RF
VklDRShwd20zLCAicHhhOTEwLXB3bSIsIDIsIE5PTkUsIDB4ZDQwMWE4MDAsIDB4MTApOwogUFhB
OTEwX0RFVklDRShwd200LCAicHhhOTEwLXB3bSIsIDMsIE5PTkUsIDB4ZDQwMWFjMDAsIDB4MTAp
OwogUFhBOTEwX0RFVklDRShuYW5kLCAicHhhM3h4LW5hbmQiLCAtMSwgTkFORCwgMHhkNDI4MzAw
MCwgMHg4MCwgOTcsIDk5KTsKK1BYQTkxMF9ERVZJQ0UoZmIsICJweGE5MTAtZmIiLCAtMSwgTENE
LCAweGQ0MjBiMDAwLCAweDFjOCk7CmRpZmYgLS1naXQgYS9hcmNoL2FybS9tYWNoLW1tcC90dGNf
ZGtiLmMgYi9hcmNoL2FybS9tYWNoLW1tcC90dGNfZGtiLmMKaW5kZXggYmIyNmNiNS4uZDNlN2Ux
ZiAxMDA2NDQKLS0tIGEvYXJjaC9hcm0vbWFjaC1tbXAvdHRjX2RrYi5jCisrKyBiL2FyY2gvYXJt
L21hY2gtbW1wL3R0Y19ka2IuYwpAQCAtMTQsNyArMTQsMTAgQEAKICNpbmNsdWRlIDxsaW51eC9t
dGQvbXRkLmg+CiAjaW5jbHVkZSA8bGludXgvbXRkL3BhcnRpdGlvbnMuaD4KICNpbmNsdWRlIDxs
aW51eC9tdGQvb25lbmFuZC5oPgorI2luY2x1ZGUgPGxpbnV4L2RlbGF5Lmg+CisjaW5jbHVkZSA8
bGludXgvZ3Bpby5oPgogCisjaW5jbHVkZSA8dmlkZW8vcHhhMTY4ZmIuaD4KICNpbmNsdWRlIDxh
c20vbWFjaC10eXBlcy5oPgogI2luY2x1ZGUgPGFzbS9tYWNoL2FyY2guaD4KICNpbmNsdWRlIDxh
c20vbWFjaC9mbGFzaC5oPgpAQCAtMzEsNiArMzQsMzcgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcg
dHRjX2RrYl9waW5fY29uZmlnW10gX19pbml0ZGF0YSA9IHsKIAlHUElPNDdfVUFSVDJfUlhELAog
CUdQSU80OF9VQVJUMl9UWEQsCiAKKyNpZmRlZiBDT05GSUdfRkJfUFhBMTY4CisJLyogTENEICov
CisJR1BJTzgxX0xDRF9GQ0xLLAorCUdQSU84Ml9MQ0RfTENMSywKKwlHUElPODNfTENEX1BDTEss
CisJR1BJTzg0X0xDRF9ERU5BLAorCUdQSU84NV9MQ0RfREQwLAorCUdQSU84Nl9MQ0RfREQxLAor
CUdQSU84N19MQ0RfREQyLAorCUdQSU84OF9MQ0RfREQzLAorCUdQSU84OV9MQ0RfREQ0LAorCUdQ
SU85MF9MQ0RfREQ1LAorCUdQSU85MV9MQ0RfREQ2LAorCUdQSU85Ml9MQ0RfREQ3LAorCUdQSU85
M19MQ0RfREQ4LAorCUdQSU85NF9MQ0RfREQ5LAorCUdQSU85NV9MQ0RfREQxMCwKKwlHUElPOTZf
TENEX0REMTEsCisJR1BJTzk3X0xDRF9ERDEyLAorCUdQSU85OF9MQ0RfREQxMywKKwlHUElPMTAw
X0xDRF9ERDE0LAorCUdQSU8xMDFfTENEX0REMTUsCisJR1BJTzEwMl9MQ0RfREQxNiwKKwlHUElP
MTAzX0xDRF9ERDE3LAorCUdQSU8xMDRfTENEX1NQSURPVVQsCisJR1BJTzEwNV9MQ0RfU1BJRElO
LAorCUdQSU8xMDdfTENEX0NTMSwKKwlHUElPMTA4X0xDRF9EQ0xLLAorCUdQSU8xMDZfTENEX1JF
U0VULAorI2VuZGlmCisKIAkvKiBERkkgKi8KIAlERl9JTzBfTkRfSU8wLAogCURGX0lPMV9ORF9J
TzEsCkBAIC01Niw2ICs5MCwxMTMgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgdHRjX2RrYl9waW5f
Y29uZmlnW10gX19pbml0ZGF0YSA9IHsKIAlERl9SRFkwX0RGX1JEWTAsCiB9OwogCisjaWZkZWYg
Q09ORklHX0ZCX1BYQTE2OAorc3RhdGljIHUxNiB0cG9fc3BpX2NtZG9uW10gPSB7CisJMHgwODAx
LAorCTB4MDgwMCwKKwkweDAyMDAsCisJMHgwMzA0LAorCTB4MDQwZSwKKwkweDA5MDMsCisJMHgw
YjE4LAorCTB4MGM1MywKKwkweDBkMDEsCisJMHgwZWUwLAorCTB4MGYwMSwKKwkweDEwNTgsCisJ
MHgyMDFlLAorCTB4MjEwYSwKKwkweDIyMGEsCisJMHgyMzFlLAorCTB4MjQwMCwKKwkweDI1MzIs
CisJMHgyNjAwLAorCTB4MjdhYywKKwkweDI5MDQsCisJMHgyYWEyLAorCTB4MmI0NSwKKwkweDJj
NDUsCisJMHgyZDE1LAorCTB4MmU1YSwKKwkweDJmZmYsCisJMHgzMDZiLAorCTB4MzEwZCwKKwkw
eDMyNDgsCisJMHgzMzgyLAorCTB4MzRiZCwKKwkweDM1ZTcsCisJMHgzNjE4LAorCTB4Mzc5NCwK
KwkweDM4MDEsCisJMHgzOTVkLAorCTB4M2FhZSwKKwkweDNiZmYsCisJMHgwN2M5LAkJLyogYXV0
byBwb3dlciBvbiAqLworfTsKKworc3RhdGljIHUxNiB0cG9fc3BpX2NtZG9mZltdID0geworCTB4
MDdkOSwJCS8qIGF1dG8gcG93ZXIgb2ZmICovCit9OworCitzdGF0aWMgaW50IHRwb19sY2RfcG93
ZXIoc3RydWN0IHB4YTE2OGZiX2luZm8gKmZiaSwgdW5zaWduZWQgaW50IHNwaV9ncGlvX2NzLAor
CQl1bnNpZ25lZCBpbnQgc3BpX2dwaW9fcmVzZXQsIGludCBvbikKK3sKKwlpbnQgZXJyID0gMDsK
KworCWlmIChvbikgeworCQlpZiAoc3BpX2dwaW9fcmVzZXQgIT0gLTEpIHsKKwkJCWVyciA9IGdw
aW9fcmVxdWVzdChzcGlfZ3Bpb19yZXNldCwgIlRQT19MQ0RfU1BJX1JFU0VUIik7CisJCQlpZiAo
ZXJyKSB7CisJCQkJcHJpbnRrKEtFUk5fRVJSICJmYWlsZWQgdG8gcmVxdWVzdCBHUElPIGZvciBU
UE8gTENEIFJFU0VUXG4iKTsKKwkJCQlyZXR1cm4gLUVJTzsKKwkJCX0KKwkJCWdwaW9fZGlyZWN0
aW9uX291dHB1dChzcGlfZ3Bpb19yZXNldCwgMCk7CisJCQltc2xlZXAoMSk7CisJCQlncGlvX3Nl
dF92YWx1ZShzcGlfZ3Bpb19yZXNldCwgMSk7CisJCQltc2xlZXAoMTEpOworCQkJZ3Bpb19mcmVl
KHNwaV9ncGlvX3Jlc2V0KTsKKwkJfQorCQlyZXR1cm4gcHhhMTY4ZmJfc3BpX3NlbmQoZmJpLCB0
cG9fc3BpX2NtZG9uLAorCQkJCUFSUkFZX1NJWkUodHBvX3NwaV9jbWRvbiksIHNwaV9ncGlvX2Nz
LCAwLCA0MCk7CisJfSBlbHNlCisJCXJldHVybiBweGExNjhmYl9zcGlfc2VuZChmYmksIHRwb19z
cGlfY21kb2ZmLAorCQkJCUFSUkFZX1NJWkUodHBvX3NwaV9jbWRvZmYpLCBzcGlfZ3Bpb19jcywg
MCwgMCk7Cit9CisKK3N0YXRpYyBzdHJ1Y3QgZmJfdmlkZW9tb2RlIHZpZGVvX21vZGVzW10gPSB7
CisJLyogbHBqMDMybDAwMWIgSFZHQSBtb2RlIGluZm8gKi8KKwlbMF0gPSB7CisJCS5waXhjbG9j
ayAgICAgICA9IDEwMDAwMCwKKwkJLnJlZnJlc2ggICAgICAgID0gNjAsCisJCS54cmVzICAgICAg
ICAgICA9IDMyMCwKKwkJLnlyZXMgICAgICAgICAgID0gNDgwLAorCQkuaHN5bmNfbGVuICAgICAg
PSAxMCwKKwkJLmxlZnRfbWFyZ2luICAgID0gMTUsCisJCS5yaWdodF9tYXJnaW4gICA9IDEwLAor
CQkudnN5bmNfbGVuICAgICAgPSAyLAorCQkudXBwZXJfbWFyZ2luICAgPSA0LAorCQkubG93ZXJf
bWFyZ2luICAgPSAyLAorCQkuc3luYyAgICAgICAgICAgPSAwLAorCX0sCit9OworCitzdGF0aWMg
c3RydWN0IHB4YTE2OGZiX21hY2hfaW5mbyB0dGNfZGtiX2xjZF9pbmZvIF9faW5pdGRhdGEgPSB7
CisJLmlkICAgICAgICAgICAgICAgICAgICAgPSAiQmFzZSIsCisJLm1vZGVzICAgICAgICAgICAg
ICAgICAgPSB2aWRlb19tb2RlcywKKwkubnVtX21vZGVzICAgICAgICAgICAgICA9IEFSUkFZX1NJ
WkUodmlkZW9fbW9kZXMpLAorCS5waXhfZm10ICAgICAgICAgICAgICAgID0gUElYX0ZNVF9SR0I1
NjUsCisJLmlvX3Bpbl9hbGxvY2F0aW9uX21vZGUgPSBQSU5fTU9ERV9EVU1CXzE4X1NQSSwKKwku
ZHVtYl9tb2RlICAgICAgICAgICAgICA9IERVTUJfTU9ERV9SR0I2NjYsCisJLmFjdGl2ZSAgICAg
ICAgICAgICAgICAgPSAxLAorCS5zcGlfY3RybCAgICAgICAgICAgICAgID0gQ0ZHX1NDTEtDTlQo
MTYpIHwgQ0ZHX1RYQklUUygxNikgfAorCQlDRkdfU1BJX1NFTCgxKSB8IENGR19TUElfM1c0V0Io
MSkgfCBDRkdfU1BJX0VOQSgxKSwKKwkuc3BpX2dwaW9fY3MgICAgICAgICAgICA9IC0xLAorCS5z
cGlfZ3Bpb19yZXNldAkJPSBtZnBfdG9fZ3BpbyhNRlBfUElOX0dQSU8xMDYpLAorCS5pbnZlcnRf
cGl4Y2xvY2sJPSAxLAorCS5weGExNjhmYl9sY2RfcG93ZXIJPSB0cG9fbGNkX3Bvd2VyLAorfTsK
KyNlbmRpZgorCiBzdGF0aWMgc3RydWN0IG10ZF9wYXJ0aXRpb24gdHRjX2RrYl9vbmVuYW5kX3Bh
cnRpdGlvbnNbXSA9IHsKIAl7CiAJCS5uYW1lCQk9ICJib290bG9hZGVyIiwKQEAgLTExOCw2ICsy
NTksOSBAQCBzdGF0aWMgdm9pZCBfX2luaXQgdHRjX2RrYl9pbml0KHZvaWQpCiAKIAkvKiBvbi1j
aGlwIGRldmljZXMgKi8KIAlweGE5MTBfYWRkX3VhcnQoMSk7CisjaWZkZWYgQ09ORklHX0ZCX1BY
QTE2OAorCXB4YTkxMF9hZGRfZmIoJnR0Y19ka2JfbGNkX2luZm8pOworI2VuZGlmCiAKIAkvKiBv
ZmYtY2hpcCBkZXZpY2VzICovCiAJcGxhdGZvcm1fYWRkX2RldmljZXMoQVJSQVlfQU5EX1NJWkUo
dHRjX2RrYl9kZXZpY2VzKSk7Ci0tIAoxLjUuNC4zCgo=
--0016e648d096a337a404790378a7--
