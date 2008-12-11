From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH 1/2] pxa: introduce GPIOxx_LCD_* macros
	for easier pin configuration
Date: Thu, 11 Dec 2008 17:04:22 +0800
Message-ID: <f17812d70812110104y4b3d9b40i2f1c5d22e97988db@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <eric.y.miao@gmail.com>) id 1LAhT8-0004V3-3J
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Dec 2008 09:04:26 +0000
Received: from rv-out-0708.google.com ([209.85.198.248])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LAhT5-0003G4-LR for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 11 Dec 2008 09:04:26 +0000
Received: by rv-out-0708.google.com with SMTP id f25so782985rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Thu, 11 Dec 2008 01:04:22 -0800 (PST)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>
Cc: linux-fbdev-devel@lists.sourceforge.net, Ian Molton <spyro@f2s.com>, Marek Vasut <marek.vasut@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, pHilipp Zabel <philipp.zabel@gmail.com>, Marc Zyngier <maz@misterjones.org>, Juergen Schindele <linux@schindele.name>, Jaya Kumar <jayakumar.lkml@gmail.com>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, Stefan Schmidt <stefan@datenfreihafen.org>

From ed2c9a22a9653880fad7e22333c7d6155c45c399 Mon Sep 17 00:00:00 2001
From: Eric Miao <eric.miao@marvell.com>
Date: Thu, 11 Dec 2008 13:34:54 +0800
Subject: [PATCH] [ARM] pxa: introduce GPIOxx_LCD_* macros for easier
pin configuration

For those peripherals with only one possible pin configuration, introduce
handy macros of GPIOxx_*, it also avoids potential copy-and-paste errors.

Let's start from LCD for PXA25x/PXA27x, depending on the different mode
used: passive (STN), active (TFT) and LCD with internal framebuffer (i.e.
smart panel), and the actual number of pins used to connect to the LCD
panel, the configurations slightly differ.

Also, let's fix the issue of LCD pin configurations are missed from some
platforms (e.g. am200epd, cm-x270, e400)

NOTE: the 18bpp and smart panel are only available on PXA27x.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Mike Rapoport <mike@compulab.co.il>
Cc: Richard Purdie <rpurdie@rpsys.net>
Cc: Ian Molton <spyro@f2s.com>
Cc: Philipp Zabel <philipp.zabel@gmail.com>
Cc: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@pengutronix.de>
Cc: Marc Zyngier <marc.zyngier@altran.com>
Cc: Jrgen Schindele (linux@schindele.name)

---
 arch/arm/mach-pxa/am200epd.c                |    5 ++-
 arch/arm/mach-pxa/cm-x255.c                 |   21 +----------
 arch/arm/mach-pxa/cm-x270.c                 |   24 ++----------
 arch/arm/mach-pxa/e400.c                    |    3 ++
 arch/arm/mach-pxa/em-x270.c                 |   21 +----------
 arch/arm/mach-pxa/ezx.c                     |    6 +++
 arch/arm/mach-pxa/idp.c                     |   20 +----------
 arch/arm/mach-pxa/include/mach/mfp-pxa27x.h |   14 +++++++
 arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h |   51 +++++++++++++++++++++++++++
 arch/arm/mach-pxa/lpd270.c                  |   21 +----------
 arch/arm/mach-pxa/lubbock.c                 |   22 +----------
 arch/arm/mach-pxa/magician.c                |   21 +----------
 arch/arm/mach-pxa/mainstone.c               |   23 +-----------
 arch/arm/mach-pxa/mioa701.c                 |   20 +----------
 arch/arm/mach-pxa/palmtx.c                  |    3 ++
 arch/arm/mach-pxa/palmz72.c                 |    3 ++
 arch/arm/mach-pxa/pcm990-baseboard.c        |    3 ++
 arch/arm/mach-pxa/poodle.c                  |   21 +----------
 arch/arm/mach-pxa/spitz.c                   |   20 +----------
 arch/arm/mach-pxa/trizeps4.c                |   21 +----------
 arch/arm/mach-pxa/viper.c                   |    3 ++
 21 files changed, 107 insertions(+), 239 deletions(-)

diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
index 77ee80e..424fb2b 100644
--- a/arch/arm/mach-pxa/am200epd.c
+++ b/arch/arm/mach-pxa/am200epd.c
@@ -87,7 +87,7 @@ static struct pxafb_mode_info am200_fb_mode_6inch = {
 static struct pxafb_mach_info am200_fb_info = {
 	.modes		= &am200_fb_mode_6inch,
 	.num_modes	= 1,
-	.lcd_conn	= LCD_TYPE_COLOR_TFT | LCD_PCLK_EDGE_FALL |
+	.lcd_conn	= LCD_COLOR_TFT_16BPP | LCD_PCLK_EDGE_FALL |
 			  LCD_AC_BIAS_FREQ(24),
 };

@@ -336,6 +336,9 @@ static struct metronome_board am200_board = {
 };

 static unsigned long am200_pin_config[] __initdata = {
+	/* LCD */
+	GPIOxx_LCD_TFT_16BPP,
+
 	GPIO51_GPIO,
 	GPIO49_GPIO,
 	GPIO48_GPIO,
diff --git a/arch/arm/mach-pxa/cm-x255.c b/arch/arm/mach-pxa/cm-x255.c
index 83a4cdf..7ad7ba2 100644
--- a/arch/arm/mach-pxa/cm-x255.c
+++ b/arch/arm/mach-pxa/cm-x255.c
@@ -52,26 +52,7 @@ static unsigned long cmx255_pin_config[] = {
 	GPIO47_STUART_TXD,

 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,

 	/* SSP1 */
 	GPIO23_SSP1_SCLK,
diff --git a/arch/arm/mach-pxa/cm-x270.c b/arch/arm/mach-pxa/cm-x270.c
index df83b97..2fdc33a 100644
--- a/arch/arm/mach-pxa/cm-x270.c
+++ b/arch/arm/mach-pxa/cm-x270.c
@@ -53,6 +53,9 @@ static unsigned long cmx270_pin_config[] = {
 	GPIO46_STUART_RXD,
 	GPIO47_STUART_TXD,

+	/* LCD */
+	GPIOxx_LCD_TFT_16BPP,
+
 	/* MCI controller */
 	GPIO32_MMC_CLK,
 	GPIO112_MMC_CMD,
@@ -62,26 +65,7 @@ static unsigned long cmx270_pin_config[] = {
 	GPIO111_MMC_DAT_3,

 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,

 	/* I2C */
 	GPIO117_I2C_SCL,
diff --git a/arch/arm/mach-pxa/e400.c b/arch/arm/mach-pxa/e400.c
index ed8bb54..82c9ee5 100644
--- a/arch/arm/mach-pxa/e400.c
+++ b/arch/arm/mach-pxa/e400.c
@@ -61,6 +61,9 @@ static unsigned long e400_pin_config[] __initdata = {
 	/* Clocks */
 	GPIO12_32KHz,

+	/* LCD */
+	GPIOxx_LCD_TFT_16BPP,
+
 	/* BTUART */
 	GPIO42_BTUART_RXD,
 	GPIO43_BTUART_TXD,
diff --git a/arch/arm/mach-pxa/em-x270.c b/arch/arm/mach-pxa/em-x270.c
index f5ed803..3833a41 100644
--- a/arch/arm/mach-pxa/em-x270.c
+++ b/arch/arm/mach-pxa/em-x270.c
@@ -72,26 +72,7 @@ static unsigned long em_x270_pin_config[] = {
 	GPIO111_MMC_DAT_3,

 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,

 	/* QCI */
 	GPIO84_CIF_FV,
diff --git a/arch/arm/mach-pxa/ezx.c b/arch/arm/mach-pxa/ezx.c
index 4f212e1..051fc49 100644
--- a/arch/arm/mach-pxa/ezx.c
+++ b/arch/arm/mach-pxa/ezx.c
@@ -147,6 +147,9 @@ static unsigned long gen1_pin_config[] __initdata = {
 	/* flip / lockswitch */
 	GPIO12_GPIO,

+	/* LCD */
+	GPIOxx_LCD_TFT_16BPP,
+
 	/* bluetooth (bcm2035) */
 	GPIO14_GPIO | WAKEUP_ON_LEVEL_HIGH,	/* HOSTWAKE */
 	GPIO48_GPIO,				/* RESET */
@@ -205,6 +208,9 @@ static unsigned long gen2_pin_config[] __initdata = {
 	/* EOC */
 	GPIO10_GPIO,

+	/* LCD */
+	GPIOxx_LCD_TFT_18BPP,
+
 	/* bluetooth (bcm2045) */
 	GPIO13_GPIO | WAKEUP_ON_LEVEL_HIGH,	/* HOSTWAKE */
 	GPIO37_GPIO,				/* RESET */
diff --git a/arch/arm/mach-pxa/idp.c b/arch/arm/mach-pxa/idp.c
index 013b15b..b6f6f79 100644
--- a/arch/arm/mach-pxa/idp.c
+++ b/arch/arm/mach-pxa/idp.c
@@ -48,25 +48,7 @@

 static unsigned long idp_pin_config[] __initdata = {
 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
+	GPIOxx_LCD_DSTN_16BPP,

 	/* BTUART */
 	GPIO42_BTUART_RXD,
diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
b/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
index da4f85a..278a748 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
+++ b/arch/arm/mach-pxa/include/mach/mfp-pxa27x.h
@@ -435,5 +435,19 @@
 #define GPIO112_nMSINS		MFP_CFG_IN(GPIO112, AF2)
 #define GPIO32_MSSCLK		MFP_CFG_OUT(GPIO32, AF1, DRIVE_LOW)

+/* Handy macros for pxa27x
+ */
+#define GPIOxx_LCD_TFT_18BPP	\
+	GPIOxx_LCD_TFT_16BPP,	\
+	GPIO86_LCD_LDD_16,	\
+	GPIO87_LCD_LDD_17
+
+#define GPIOxx_LCD_SMARTPANEL	\
+	GPIOxx_LCD_8BPP,	\
+	GPIO74_LCD_FCLK,	\
+	GPIO75_LCD_LCLK,	\
+	GPIO76_LCD_PCLK,	\
+	GPIO19_LCD_CS
+
 extern int keypad_set_wake(unsigned int on);
 #endif /* __ASM_ARCH_MFP_PXA27X_H */
diff --git a/arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h
b/arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h
index 3e92115..c6d0020 100644
--- a/arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h
+++ b/arch/arm/mach-pxa/include/mach/mfp-pxa2xx.h
@@ -127,6 +127,57 @@
 #define GPIO83_GPIO	MFP_CFG_IN(GPIO83, AF0)
 #define GPIO84_GPIO	MFP_CFG_IN(GPIO84, AF0)

+/* Common handy macros for easier pin configuration - note this works
+ * only for those peripherals with one possible configuration
+ */
+#define GPIOxx_LCD_8BPP		\
+	GPIO58_LCD_LDD_0,	\
+	GPIO59_LCD_LDD_1,	\
+	GPIO60_LCD_LDD_2,	\
+	GPIO61_LCD_LDD_3,	\
+	GPIO62_LCD_LDD_4,	\
+	GPIO63_LCD_LDD_5,	\
+	GPIO64_LCD_LDD_6,	\
+	GPIO65_LCD_LDD_7
+
+#define GPIOxx_LCD_16BPP	\
+	GPIOxx_LCD_8BPP,	\
+	GPIO66_LCD_LDD_8,	\
+	GPIO67_LCD_LDD_9,	\
+	GPIO68_LCD_LDD_10,	\
+	GPIO69_LCD_LDD_11,	\
+	GPIO70_LCD_LDD_12,	\
+	GPIO71_LCD_LDD_13,	\
+	GPIO72_LCD_LDD_14,	\
+	GPIO73_LCD_LDD_15
+
+#define GPIOxx_LCD_TFT		\
+	GPIO74_LCD_FCLK,	\
+	GPIO75_LCD_LCLK,	\
+	GPIO76_LCD_PCLK,	\
+	GPIO77_LCD_BIAS
+
+#define GPIOxx_LCD_STN		\
+	GPIO74_LCD_FCLK,	\
+	GPIO75_LCD_LCLK,	\
+	GPIO76_LCD_PCLK
+
+#define GPIOxx_LCD_TFT_8BPP	\
+	GPIOxx_LCD_8BPP,	\
+	GPIOxx_LCD_TFT
+
+#define GPIOxx_LCD_TFT_16BPP	\
+	GPIOxx_LCD_16BPP,	\
+	GPIOxx_LCD_TFT
+
+#define GPIOxx_LCD_DSTN_16BPP	\
+	GPIOxx_LCD_16BPP,	\
+	GPIOxx_LCD_STN
+
+#define GPIOxx_LCD_STN_8BPP	\
+	GPIOxx_LCD_8BPP,	\
+	GPIOxx_LCD_STN
+
 extern void pxa2xx_mfp_config(unsigned long *mfp_cfgs, int num);
 extern void pxa2xx_mfp_set_lpm(int mfp, unsigned long lpm);
 extern int gpio_set_wake(unsigned int gpio, unsigned int on);
diff --git a/arch/arm/mach-pxa/lpd270.c b/arch/arm/mach-pxa/lpd270.c
index de3f67d..cc10818 100644
--- a/arch/arm/mach-pxa/lpd270.c
+++ b/arch/arm/mach-pxa/lpd270.c
@@ -57,26 +57,7 @@ static unsigned long lpd270_pin_config[] __initdata = {
 	GPIO78_nCS_2,	/* CPLD + Ethernet */

 	/* LCD - 16bpp Active TFT */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,
 	GPIO16_PWM0_OUT,	/* Backlight */

 	/* USB Host */
diff --git a/arch/arm/mach-pxa/lubbock.c b/arch/arm/mach-pxa/lubbock.c
index bff7043..2c4d419 100644
--- a/arch/arm/mach-pxa/lubbock.c
+++ b/arch/arm/mach-pxa/lubbock.c
@@ -66,26 +66,8 @@ static unsigned long lubbock_pin_config[] __initdata = {
 	GPIO25_SSP1_TXD,
 	GPIO26_SSP1_RXD,

-	/* LCD - 16bpp DSTN */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
+	/* LCD */
+	GPIOxx_LCD_DSTN_16BPP,

 	/* BTUART */
 	GPIO42_BTUART_RXD,
diff --git a/arch/arm/mach-pxa/magician.c b/arch/arm/mach-pxa/magician.c
index 21b821e..34b7ba8 100644
--- a/arch/arm/mach-pxa/magician.c
+++ b/arch/arm/mach-pxa/magician.c
@@ -81,26 +81,7 @@ static unsigned long magician_pin_config[] __initdata = {
 	GPIO112_MMC_CMD,

 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,

 	/* QCI */
 	GPIO12_CIF_DD_7,
diff --git a/arch/arm/mach-pxa/mainstone.c b/arch/arm/mach-pxa/mainstone.c
index 5f22496..eaa0d15 100644
--- a/arch/arm/mach-pxa/mainstone.c
+++ b/arch/arm/mach-pxa/mainstone.c
@@ -60,27 +60,8 @@ static unsigned long mainstone_pin_config[] = {
 	/* Chip Select */
 	GPIO15_nCS_1,

-	/* LCD - 16bpp Active TFT */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	/* LCD */
+	GPIOxx_LCD_TFT_16BPP,
 	GPIO16_PWM0_OUT,	/* Backlight */

 	/* MMC */
diff --git a/arch/arm/mach-pxa/mioa701.c b/arch/arm/mach-pxa/mioa701.c
index 9207f10..1da9574 100644
--- a/arch/arm/mach-pxa/mioa701.c
+++ b/arch/arm/mach-pxa/mioa701.c
@@ -82,25 +82,7 @@ static unsigned long mioa701_pin_config[] = {
 	MIO_CFG_OUT(GPIO22_USB_ENABLE, AF0, DRIVE_LOW),

 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
+	GPIOxx_LCD_TFT_16BPP,

 	/* QCI */
 	GPIO12_CIF_DD_7,
diff --git a/arch/arm/mach-pxa/palmtx.c b/arch/arm/mach-pxa/palmtx.c
index 4447711..c472dc7 100644
--- a/arch/arm/mach-pxa/palmtx.c
+++ b/arch/arm/mach-pxa/palmtx.c
@@ -57,6 +57,9 @@ static unsigned long palmtx_pin_config[] __initdata = {
 	GPIO111_MMC_DAT_3,
 	GPIO112_MMC_CMD,

+	/* LCD */
+	GPIOxx_LCD_TFT_16BPP,
+
 	/* AC97 */
 	GPIO28_AC97_BITCLK,
 	GPIO29_AC97_SDATA_IN_0,
diff --git a/arch/arm/mach-pxa/palmz72.c b/arch/arm/mach-pxa/palmz72.c
index 2f730da..c268f68 100644
--- a/arch/arm/mach-pxa/palmz72.c
+++ b/arch/arm/mach-pxa/palmz72.c
@@ -63,6 +63,9 @@ static unsigned long palmz72_pin_config[] __initdata = {
 	GPIO115_GPIO,	/* SD RO */
 	GPIO98_GPIO,	/* SD power */

+	/* LCD */
+	GPIOxx_LCD_TFT_16BPP,
+
 	/* AC97 */
 	GPIO28_AC97_BITCLK,
 	GPIO29_AC97_SDATA_IN_0,
diff --git a/arch/arm/mach-pxa/pcm990-baseboard.c
b/arch/arm/mach-pxa/pcm990-baseboard.c
index d2d2847..e7bb7ce 100644
--- a/arch/arm/mach-pxa/pcm990-baseboard.c
+++ b/arch/arm/mach-pxa/pcm990-baseboard.c
@@ -56,6 +56,9 @@ static unsigned long pcm990_pin_config[] __initdata = {
 	/* PWM0 */
 	GPIO16_PWM0_OUT,

+	/* LCD */
+	GPIOxx_LCD_TFT_16BPP,
+
 	/* I2C */
 	GPIO117_I2C_SCL,
 	GPIO118_I2C_SDA,
diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
index ae88855..7a5b7d9 100644
--- a/arch/arm/mach-pxa/poodle.c
+++ b/arch/arm/mach-pxa/poodle.c
@@ -91,26 +91,7 @@ static unsigned long poodle_pin_config[] __initdata = {
 	GPIO35_FFUART_CTS,

 	/* LCD */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,

 	/* PC Card */
 	GPIO48_nPOE,
diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 7299d87..1f9286d 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -72,25 +72,7 @@ static unsigned long spitz_pin_config[] __initdata = {
 	GPIO80_nCS_4,	/* SCOOP #1 */

 	/* LCD - 16bpp Active TFT */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
+	GPIOxx_LCD_TFT_16BPP,

 	/* PC Card */
 	GPIO48_nPOE,
diff --git a/arch/arm/mach-pxa/trizeps4.c b/arch/arm/mach-pxa/trizeps4.c
index a72e3ad..add9bfe 100644
--- a/arch/arm/mach-pxa/trizeps4.c
+++ b/arch/arm/mach-pxa/trizeps4.c
@@ -76,26 +76,7 @@ static unsigned long trizeps4_pin_config[] __initdata = {
 	GPIO0_GPIO | WAKEUP_ON_EDGE_RISE,	/* Logic irq */

 	/* LCD - 16bpp Active TFT */
-	GPIO58_LCD_LDD_0,
-	GPIO59_LCD_LDD_1,
-	GPIO60_LCD_LDD_2,
-	GPIO61_LCD_LDD_3,
-	GPIO62_LCD_LDD_4,
-	GPIO63_LCD_LDD_5,
-	GPIO64_LCD_LDD_6,
-	GPIO65_LCD_LDD_7,
-	GPIO66_LCD_LDD_8,
-	GPIO67_LCD_LDD_9,
-	GPIO68_LCD_LDD_10,
-	GPIO69_LCD_LDD_11,
-	GPIO70_LCD_LDD_12,
-	GPIO71_LCD_LDD_13,
-	GPIO72_LCD_LDD_14,
-	GPIO73_LCD_LDD_15,
-	GPIO74_LCD_FCLK,
-	GPIO75_LCD_LCLK,
-	GPIO76_LCD_PCLK,
-	GPIO77_LCD_BIAS,
+	GPIOxx_LCD_TFT_16BPP,

 	/* UART */
 	GPIO9_FFUART_CTS,
diff --git a/arch/arm/mach-pxa/viper.c b/arch/arm/mach-pxa/viper.c
index 4b3120d..609c33e 100644
--- a/arch/arm/mach-pxa/viper.c
+++ b/arch/arm/mach-pxa/viper.c
@@ -704,6 +704,9 @@ static mfp_cfg_t viper_pin_config[] __initdata = {
 	GPIO80_nCS_4,
 	GPIO33_nCS_5,

+	/* LCD */
+	GPIOxx_LCD_TFT_16BPP,
+
 	/* FP Backlight */
 	GPIO9_GPIO, 				/* VIPER_BCKLIGHT_EN_GPIO */
 	GPIO10_GPIO,				/* VIPER_LCD_EN_GPIO */
-- 
1.6.0.4

------------------------------------------------------------------------------
SF.Net email is Sponsored by MIX09, March 18-20, 2009 in Las Vegas, Nevada.
The future of the web can't happen without you.  Join us at MIX09 to help
pave the way to the Next Web now. Learn more and register at
http://ad.doubleclick.net/clk;208669438;13503038;i?http://2009.visitmix.com/
