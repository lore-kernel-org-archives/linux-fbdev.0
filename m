From: "Eric Miao" <eric.y.miao@gmail.com>
Subject: [PATCH 2/2] pxa/littleton: add support for
	SPI-based TDO24M LCD panel driver
Date: Mon, 1 Sep 2008 14:11:24 +0800
Message-ID: <f17812d70808312311x494027bfwb6b42efd462270e7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ka2dJ-0003TU-KB for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 31 Aug 2008 23:11:25 -0700
Received: from yx-out-1718.google.com ([74.125.44.152])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Ka2dJ-0006os-4t
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 31 Aug 2008 23:11:25 -0700
Received: by yx-out-1718.google.com with SMTP id 3so784774yxi.82
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 31 Aug 2008 23:11:24 -0700 (PDT)
Content-Disposition: inline
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: ARM Linux <linux-arm-kernel@lists.arm.linux.org.uk>, linux-fbdev-devel@lists.sourceforge.net

Signed-off-by: Eric Miao <eric.miao@marvell.com>
---
 arch/arm/mach-pxa/include/mach/littleton.h |    2 +
 arch/arm/mach-pxa/littleton.c              |  205 +++++++---------------------
 2 files changed, 51 insertions(+), 156 deletions(-)

diff --git a/arch/arm/mach-pxa/include/mach/littleton.h
b/arch/arm/mach-pxa/include/mach/littleton.h
index 79d209b..5c4e320 100644
--- a/arch/arm/mach-pxa/include/mach/littleton.h
+++ b/arch/arm/mach-pxa/include/mach/littleton.h
@@ -3,4 +3,6 @@

 #define LITTLETON_ETH_PHYS	0x30000000

+#define LITTLETON_GPIO_LCD_CS	(17)
+
 #endif /* __ASM_ARCH_ZYLONITE_H */
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 58f3402..b4d00ab 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -20,6 +20,7 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/clk.h>
+#include <linux/spi/spi.h>
 #include <linux/smc91x.h>

 #include <asm/types.h>
@@ -38,6 +39,7 @@
 #include <mach/gpio.h>
 #include <mach/pxafb.h>
 #include <mach/ssp.h>
+#include <mach/pxa2xx_spi.h>
 #include <mach/pxa27x_keypad.h>
 #include <mach/pxa3xx_nand.h>
 #include <mach/littleton.h>
@@ -72,8 +74,8 @@ static mfp_cfg_t littleton_mfp_cfg[] __initdata = {

 	/* SSP2 */
 	GPIO25_SSP2_SCLK,
-	GPIO17_SSP2_FRM,
 	GPIO27_SSP2_TXD,
+	GPIO17_GPIO,	/* SFRM as chip-select */

 	/* Debug Ethernet */
 	GPIO90_GPIO,
@@ -123,160 +125,6 @@ static struct platform_device smc91x_device = {
 };

 #if defined(CONFIG_FB_PXA) || defined(CONFIG_FB_PXA_MODULE)
-/* use bit 30, 31 as the indicator of command parameter number */
-#define CMD0(x)		((0x00000000) | ((x) << 9))
-#define CMD1(x, x1)	((0x40000000) | ((x) << 9) | 0x100 | (x1))
-#define CMD2(x, x1, x2)	((0x80000000) | ((x) << 18) | 0x20000 |\
-			 ((x1) << 9) | 0x100 | (x2))
-
-static uint32_t lcd_panel_reset[] = {
-	CMD0(0x1), /* reset */
-	CMD0(0x0), /* nop */
-	CMD0(0x0), /* nop */
-	CMD0(0x0), /* nop */
-};
-
-static uint32_t lcd_panel_on[] = {
-	CMD0(0x29),		/* Display ON */
-	CMD2(0xB8, 0xFF, 0xF9),	/* Output Control */
-	CMD0(0x11),		/* Sleep out */
-	CMD1(0xB0, 0x16),	/* Wake */
-};
-
-static uint32_t lcd_panel_off[] = {
-	CMD0(0x28),		/* Display OFF */
-	CMD2(0xB8, 0x80, 0x02),	/* Output Control */
-	CMD0(0x10),		/* Sleep in */
-	CMD1(0xB0, 0x00),	/* Deep stand by in */
-};
-
-static uint32_t lcd_vga_pass_through[] = {
-	CMD1(0xB0, 0x16),
-	CMD1(0xBC, 0x80),
-	CMD1(0xE1, 0x00),
-	CMD1(0x36, 0x50),
-	CMD1(0x3B, 0x00),
-};
-
-static uint32_t lcd_qvga_pass_through[] = {
-	CMD1(0xB0, 0x16),
-	CMD1(0xBC, 0x81),
-	CMD1(0xE1, 0x00),
-	CMD1(0x36, 0x50),
-	CMD1(0x3B, 0x22),
-};
-
-static uint32_t lcd_vga_transfer[] = {
-	CMD1(0xcf, 0x02), 	/* Blanking period control (1) */
-	CMD2(0xd0, 0x08, 0x04),	/* Blanking period control (2) */
-	CMD1(0xd1, 0x01),	/* CKV timing control on/off */
-	CMD2(0xd2, 0x14, 0x00),	/* CKV 1,2 timing control */
-	CMD2(0xd3, 0x1a, 0x0f),	/* OEV timing control */
-	CMD2(0xd4, 0x1f, 0xaf),	/* ASW timing control (1) */
-	CMD1(0xd5, 0x14),	/* ASW timing control (2) */
-	CMD0(0x21),		/* Invert for normally black display */
-	CMD0(0x29),		/* Display on */
-};
-
-static uint32_t lcd_qvga_transfer[] = {
-	CMD1(0xd6, 0x02),	/* Blanking period control (1) */
-	CMD2(0xd7, 0x08, 0x04),	/* Blanking period control (2) */
-	CMD1(0xd8, 0x01),	/* CKV timing control on/off */
-	CMD2(0xd9, 0x00, 0x08),	/* CKV 1,2 timing control */
-	CMD2(0xde, 0x05, 0x0a),	/* OEV timing control */
-	CMD2(0xdf, 0x0a, 0x19),	/* ASW timing control (1) */
-	CMD1(0xe0, 0x0a),	/* ASW timing control (2) */
-	CMD0(0x21),		/* Invert for normally black display */
-	CMD0(0x29),		/* Display on */
-};
-
-static uint32_t lcd_panel_config[] = {
-	CMD2(0xb8, 0xff, 0xf9),	/* Output control */
-	CMD0(0x11),		/* sleep out */
-	CMD1(0xba, 0x01),	/* Display mode (1) */
-	CMD1(0xbb, 0x00),	/* Display mode (2) */
-	CMD1(0x3a, 0x60),	/* Display mode 18-bit RGB */
-	CMD1(0xbf, 0x10),	/* Drive system change control */
-	CMD1(0xb1, 0x56),	/* Booster operation setup */
-	CMD1(0xb2, 0x33),	/* Booster mode setup */
-	CMD1(0xb3, 0x11),	/* Booster frequency setup */
-	CMD1(0xb4, 0x02),	/* Op amp/system clock */
-	CMD1(0xb5, 0x35),	/* VCS voltage */
-	CMD1(0xb6, 0x40),	/* VCOM voltage */
-	CMD1(0xb7, 0x03),	/* External display signal */
-	CMD1(0xbd, 0x00),	/* ASW slew rate */
-	CMD1(0xbe, 0x00),	/* Dummy data for QuadData operation */
-	CMD1(0xc0, 0x11),	/* Sleep out FR count (A) */
-	CMD1(0xc1, 0x11),	/* Sleep out FR count (B) */
-	CMD1(0xc2, 0x11),	/* Sleep out FR count (C) */
-	CMD2(0xc3, 0x20, 0x40),	/* Sleep out FR count (D) */
-	CMD2(0xc4, 0x60, 0xc0),	/* Sleep out FR count (E) */
-	CMD2(0xc5, 0x10, 0x20),	/* Sleep out FR count (F) */
-	CMD1(0xc6, 0xc0),	/* Sleep out FR count (G) */
-	CMD2(0xc7, 0x33, 0x43),	/* Gamma 1 fine tuning (1) */
-	CMD1(0xc8, 0x44),	/* Gamma 1 fine tuning (2) */
-	CMD1(0xc9, 0x33),	/* Gamma 1 inclination adjustment */
-	CMD1(0xca, 0x00),	/* Gamma 1 blue offset adjustment */
-	CMD2(0xec, 0x01, 0xf0),	/* Horizontal clock cycles */
-};
-
-static void ssp_reconfig(struct ssp_dev *dev, int nparam)
-{
-	static int last_nparam = -1;
-
-	/* check if it is necessary to re-config SSP */
-	if (nparam == last_nparam)
-		return;
-
-	ssp_disable(dev);
-	ssp_config(dev, (nparam == 2) ? 0x0010058a : 0x00100581, 0x18, 0, 0);
-
-	last_nparam = nparam;
-}
-
-static void ssp_send_cmd(uint32_t *cmd, int num)
-{
-	static int ssp_initialized;
-	static struct ssp_dev ssp2;
-
-	int i;
-
-	if (!ssp_initialized) {
-		ssp_init(&ssp2, 2, SSP_NO_IRQ);
-		ssp_initialized = 1;
-	}
-
-	clk_enable(ssp2.ssp->clk);
-	for (i = 0; i < num; i++, cmd++) {
-		ssp_reconfig(&ssp2, (*cmd >> 30) & 0x3);
-		ssp_write_word(&ssp2, *cmd & 0x3fffffff);
-
-		/* FIXME: ssp_flush() is mandatory here to work */
-		ssp_flush(&ssp2);
-	}
-	clk_disable(ssp2.ssp->clk);
-}
-
-static void littleton_lcd_power(int on, struct fb_var_screeninfo *var)
-{
-	if (on) {
-		ssp_send_cmd(ARRAY_AND_SIZE(lcd_panel_on));
-		ssp_send_cmd(ARRAY_AND_SIZE(lcd_panel_reset));
-		if (var->xres > 240) {
-			/* VGA */
-			ssp_send_cmd(ARRAY_AND_SIZE(lcd_vga_pass_through));
-			ssp_send_cmd(ARRAY_AND_SIZE(lcd_panel_config));
-			ssp_send_cmd(ARRAY_AND_SIZE(lcd_vga_transfer));
-		} else {
-			/* QVGA */
-			ssp_send_cmd(ARRAY_AND_SIZE(lcd_qvga_pass_through));
-			ssp_send_cmd(ARRAY_AND_SIZE(lcd_panel_config));
-			ssp_send_cmd(ARRAY_AND_SIZE(lcd_qvga_transfer));
-		}
-	} else
-		ssp_send_cmd(ARRAY_AND_SIZE(lcd_panel_off));
-}
-
 static struct pxafb_mode_info tpo_tdo24mtea1_modes[] = {
 	[0] = {
 		/* VGA */
@@ -312,7 +160,6 @@ static struct pxafb_mach_info littleton_lcd_info = {
 	.modes			= tpo_tdo24mtea1_modes,
 	.num_modes		= 2,
 	.lcd_conn		= LCD_COLOR_TFT_16BPP,
-	.pxafb_lcd_power	= littleton_lcd_power,
 };

 static void littleton_init_lcd(void)
@@ -323,6 +170,51 @@ static void littleton_init_lcd(void)
 static inline void littleton_init_lcd(void) {};
 #endif /* CONFIG_FB_PXA || CONFIG_FB_PXA_MODULE */

+#if defined(CONFIG_SPI_PXA2XX) || defined(CONFIG_SPI_PXA2XX_MODULE)
+static struct pxa2xx_spi_master littleton_spi_info = {
+	.num_chipselect		= 1,
+};
+
+static void littleton_tdo24m_cs(u32 cmd)
+{
+	gpio_set_value(LITTLETON_GPIO_LCD_CS, !(cmd == PXA2XX_CS_ASSERT));
+}
+
+static struct pxa2xx_spi_chip littleton_tdo24m_chip = {
+	.rx_threshold	= 1,
+	.tx_threshold	= 1,
+	.cs_control	= littleton_tdo24m_cs,
+};
+
+static struct spi_board_info littleton_spi_devices[] __initdata = {
+	{
+		.modalias	= "tdo24m",
+		.max_speed_hz	= 1000000,
+		.bus_num	= 2,
+		.chip_select	= 0,
+		.controller_data= &littleton_tdo24m_chip,
+	},
+};
+
+static void __init littleton_init_spi(void)
+{
+	int err;
+
+	err = gpio_request(LITTLETON_GPIO_LCD_CS, "LCD_CS");
+	if (err) {
+		pr_warning("failed to request GPIO for LCS CS\n");
+		return;
+	}
+
+	gpio_direction_output(LITTLETON_GPIO_LCD_CS, 1);
+
+	pxa2xx_set_spi_info(2, &littleton_spi_info);
+	spi_register_board_info(ARRAY_AND_SIZE(littleton_spi_devices));
+}
+#else
+static inline void littleton_init_spi(void) {}
+#endif
+
 #if defined(CONFIG_KEYBOARD_PXA27x) || defined(CONFIG_KEYBOARD_PXA27x_MODULE)
 static unsigned int littleton_matrix_key_map[] = {
 	/* KEY(row, col, key_code) */
@@ -433,6 +325,7 @@ static void __init littleton_init(void)
 	 */
 	platform_device_register(&smc91x_device);

+	littleton_init_spi();
 	littleton_init_lcd();
 	littleton_init_keypad();
 	littleton_init_nand();
-- 
1.5.4.3

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
