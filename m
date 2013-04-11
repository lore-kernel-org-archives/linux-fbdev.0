From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Date: Thu, 11 Apr 2013 15:00:15 +0000
Subject: [PATCH 1/8] video: atmel_lcdfb: fix platform data struct
Message-Id: <1365692422-9565-1-git-send-email-plagnioj@jcrosoft.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20130411145741.GB25242@game.jcrosoft.org>
In-Reply-To: <20130411145741.GB25242@game.jcrosoft.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Today we mix pdata and drivers data in the struct atmel_lcdfb_info
Fix it and introduce a new struct atmel_lcdfb_pdata for platform data only

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: linux-fbdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
---
 arch/arm/mach-at91/at91sam9261_devices.c    |    6 +-
 arch/arm/mach-at91/at91sam9263_devices.c    |    6 +-
 arch/arm/mach-at91/at91sam9g45_devices.c    |    6 +-
 arch/arm/mach-at91/at91sam9rl_devices.c     |    6 +-
 arch/arm/mach-at91/board-sam9261ek.c        |    6 +-
 arch/arm/mach-at91/board-sam9263ek.c        |    4 +-
 arch/arm/mach-at91/board-sam9m10g45ek.c     |    4 +-
 arch/arm/mach-at91/board-sam9rlek.c         |    4 +-
 arch/arm/mach-at91/board.h                  |    4 +-
 arch/avr32/boards/atngw100/evklcd10x.c      |    6 +-
 arch/avr32/boards/atngw100/mrmt.c           |    4 +-
 arch/avr32/boards/atstk1000/atstk1000.h     |    2 +-
 arch/avr32/boards/atstk1000/setup.c         |    2 +-
 arch/avr32/boards/favr-32/setup.c           |    2 +-
 arch/avr32/boards/hammerhead/setup.c        |    2 +-
 arch/avr32/boards/merisc/display.c          |    2 +-
 arch/avr32/boards/mimc200/setup.c           |    4 +-
 arch/avr32/mach-at32ap/at32ap700x.c         |    8 +--
 arch/avr32/mach-at32ap/include/mach/board.h |    4 +-
 drivers/video/atmel_lcdfb.c                 |  104 +++++++++++++++++----------
 include/video/atmel_lcdc.h                  |   24 +------
 21 files changed, 109 insertions(+), 101 deletions(-)

diff --git a/arch/arm/mach-at91/at91sam9261_devices.c b/arch/arm/mach-at91/at91sam9261_devices.c
index 629ea5f..b2a3474 100644
--- a/arch/arm/mach-at91/at91sam9261_devices.c
+++ b/arch/arm/mach-at91/at91sam9261_devices.c
@@ -465,7 +465,7 @@ void __init at91_add_device_spi(struct spi_board_info *devices, int nr_devices)
 
 #if defined(CONFIG_FB_ATMEL) || defined(CONFIG_FB_ATMEL_MODULE)
 static u64 lcdc_dmamask = DMA_BIT_MASK(32);
-static struct atmel_lcdfb_info lcdc_data;
+static struct atmel_lcdfb_pdata lcdc_data;
 
 static struct resource lcdc_resources[] = {
 	[0] = {
@@ -498,7 +498,7 @@ static struct platform_device at91_lcdc_device = {
 	.num_resources	= ARRAY_SIZE(lcdc_resources),
 };
 
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
+void __init at91_add_device_lcdc(struct atmel_lcdfb_pdata *data)
 {
 	if (!data) {
 		return;
@@ -559,7 +559,7 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
 	platform_device_register(&at91_lcdc_device);
 }
 #else
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
+void __init at91_add_device_lcdc(struct atmel_lcdfb_pdata *data) {}
 #endif
 
 
diff --git a/arch/arm/mach-at91/at91sam9263_devices.c b/arch/arm/mach-at91/at91sam9263_devices.c
index 858c8aa..4aeaddd 100644
--- a/arch/arm/mach-at91/at91sam9263_devices.c
+++ b/arch/arm/mach-at91/at91sam9263_devices.c
@@ -832,7 +832,7 @@ void __init at91_add_device_can(struct at91_can_data *data) {}
 
 #if defined(CONFIG_FB_ATMEL) || defined(CONFIG_FB_ATMEL_MODULE)
 static u64 lcdc_dmamask = DMA_BIT_MASK(32);
-static struct atmel_lcdfb_info lcdc_data;
+static struct atmel_lcdfb_pdata lcdc_data;
 
 static struct resource lcdc_resources[] = {
 	[0] = {
@@ -859,7 +859,7 @@ static struct platform_device at91_lcdc_device = {
 	.num_resources	= ARRAY_SIZE(lcdc_resources),
 };
 
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
+void __init at91_add_device_lcdc(struct atmel_lcdfb_pdata *data)
 {
 	if (!data)
 		return;
@@ -891,7 +891,7 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
 	platform_device_register(&at91_lcdc_device);
 }
 #else
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
+void __init at91_add_device_lcdc(struct atmel_lcdfb_pdata *data) {}
 #endif
 
 
diff --git a/arch/arm/mach-at91/at91sam9g45_devices.c b/arch/arm/mach-at91/at91sam9g45_devices.c
index fe626d4..82636c7 100644
--- a/arch/arm/mach-at91/at91sam9g45_devices.c
+++ b/arch/arm/mach-at91/at91sam9g45_devices.c
@@ -965,7 +965,7 @@ void __init at91_add_device_isi(struct isi_platform_data *data,
 
 #if defined(CONFIG_FB_ATMEL) || defined(CONFIG_FB_ATMEL_MODULE)
 static u64 lcdc_dmamask = DMA_BIT_MASK(32);
-static struct atmel_lcdfb_info lcdc_data;
+static struct atmel_lcdfb_pdata lcdc_data;
 
 static struct resource lcdc_resources[] = {
 	[0] = {
@@ -991,7 +991,7 @@ static struct platform_device at91_lcdc_device = {
 	.num_resources	= ARRAY_SIZE(lcdc_resources),
 };
 
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
+void __init at91_add_device_lcdc(struct atmel_lcdfb_pdata *data)
 {
 	if (!data)
 		return;
@@ -1037,7 +1037,7 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
 	platform_device_register(&at91_lcdc_device);
 }
 #else
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
+void __init at91_add_device_lcdc(struct atmel_lcdfb_pdata *data) {}
 #endif
 
 
diff --git a/arch/arm/mach-at91/at91sam9rl_devices.c b/arch/arm/mach-at91/at91sam9rl_devices.c
index 352468f..a698bda 100644
--- a/arch/arm/mach-at91/at91sam9rl_devices.c
+++ b/arch/arm/mach-at91/at91sam9rl_devices.c
@@ -498,7 +498,7 @@ void __init at91_add_device_ac97(struct ac97c_platform_data *data) {}
 
 #if defined(CONFIG_FB_ATMEL) || defined(CONFIG_FB_ATMEL_MODULE)
 static u64 lcdc_dmamask = DMA_BIT_MASK(32);
-static struct atmel_lcdfb_info lcdc_data;
+static struct atmel_lcdfb_pdata lcdc_data;
 
 static struct resource lcdc_resources[] = {
 	[0] = {
@@ -525,7 +525,7 @@ static struct platform_device at91_lcdc_device = {
 	.num_resources	= ARRAY_SIZE(lcdc_resources),
 };
 
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
+void __init at91_add_device_lcdc(struct atmel_lcdfb_pdata *data)
 {
 	if (!data) {
 		return;
@@ -557,7 +557,7 @@ void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data)
 	platform_device_register(&at91_lcdc_device);
 }
 #else
-void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data) {}
+void __init at91_add_device_lcdc(struct atmel_lcdfb_pdata *data) {}
 #endif
 
 
diff --git a/arch/arm/mach-at91/board-sam9261ek.c b/arch/arm/mach-at91/board-sam9261ek.c
index b446645..c819e29 100644
--- a/arch/arm/mach-at91/board-sam9261ek.c
+++ b/arch/arm/mach-at91/board-sam9261ek.c
@@ -405,7 +405,7 @@ static void at91_lcdc_stn_power_control(int on)
 	}
 }
 
-static struct atmel_lcdfb_info __initdata ek_lcdc_data = {
+static struct atmel_lcdfb_pdata __initdata ek_lcdc_data = {
 	.default_bpp			= 1,
 	.default_dmacon			= ATMEL_LCDC_DMAEN,
 	.default_lcdcon2		= AT91SAM9261_DEFAULT_STN_LCDCON2,
@@ -460,7 +460,7 @@ static void at91_lcdc_tft_power_control(int on)
 		at91_set_gpio_value(AT91_PIN_PA12, 1);	/* power down */
 }
 
-static struct atmel_lcdfb_info __initdata ek_lcdc_data = {
+static struct atmel_lcdfb_pdata __initdata ek_lcdc_data = {
 	.lcdcon_is_backlight		= true,
 	.default_bpp			= 16,
 	.default_dmacon			= ATMEL_LCDC_DMAEN,
@@ -475,7 +475,7 @@ static struct atmel_lcdfb_info __initdata ek_lcdc_data = {
 #endif
 
 #else
-static struct atmel_lcdfb_info __initdata ek_lcdc_data;
+static struct atmel_lcdfb_pdata __initdata ek_lcdc_data;
 #endif
 
 
diff --git a/arch/arm/mach-at91/board-sam9263ek.c b/arch/arm/mach-at91/board-sam9263ek.c
index 3284df0..0fdae3f 100644
--- a/arch/arm/mach-at91/board-sam9263ek.c
+++ b/arch/arm/mach-at91/board-sam9263ek.c
@@ -281,7 +281,7 @@ static void at91_lcdc_power_control(int on)
 }
 
 /* Driver datas */
-static struct atmel_lcdfb_info __initdata ek_lcdc_data = {
+static struct atmel_lcdfb_pdata __initdata ek_lcdc_data = {
 	.lcdcon_is_backlight		= true,
 	.default_bpp			= 16,
 	.default_dmacon			= ATMEL_LCDC_DMAEN,
@@ -292,7 +292,7 @@ static struct atmel_lcdfb_info __initdata ek_lcdc_data = {
 };
 
 #else
-static struct atmel_lcdfb_info __initdata ek_lcdc_data;
+static struct atmel_lcdfb_pdata __initdata ek_lcdc_data;
 #endif
 
 
diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
index 2a94896..ef39078 100644
--- a/arch/arm/mach-at91/board-sam9m10g45ek.c
+++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
@@ -284,7 +284,7 @@ static struct fb_monspecs at91fb_default_monspecs = {
 					| ATMEL_LCDC_CLKMOD_ALWAYSACTIVE)
 
 /* Driver datas */
-static struct atmel_lcdfb_info __initdata ek_lcdc_data = {
+static struct atmel_lcdfb_pdata __initdata ek_lcdc_data = {
 	.lcdcon_is_backlight		= true,
 	.default_bpp			= 32,
 	.default_dmacon			= ATMEL_LCDC_DMAEN,
@@ -295,7 +295,7 @@ static struct atmel_lcdfb_info __initdata ek_lcdc_data = {
 };
 
 #else
-static struct atmel_lcdfb_info __initdata ek_lcdc_data;
+static struct atmel_lcdfb_pdata __initdata ek_lcdc_data;
 #endif
 
 
diff --git a/arch/arm/mach-at91/board-sam9rlek.c b/arch/arm/mach-at91/board-sam9rlek.c
index aa265dc..b77d7a9 100644
--- a/arch/arm/mach-at91/board-sam9rlek.c
+++ b/arch/arm/mach-at91/board-sam9rlek.c
@@ -179,7 +179,7 @@ static void at91_lcdc_power_control(int on)
 }
 
 /* Driver datas */
-static struct atmel_lcdfb_info __initdata ek_lcdc_data = {
+static struct atmel_lcdfb_pdata __initdata ek_lcdc_data = {
 	.lcdcon_is_backlight            = true,
 	.default_bpp			= 16,
 	.default_dmacon			= ATMEL_LCDC_DMAEN,
@@ -191,7 +191,7 @@ static struct atmel_lcdfb_info __initdata ek_lcdc_data = {
 };
 
 #else
-static struct atmel_lcdfb_info __initdata ek_lcdc_data;
+static struct atmel_lcdfb_pdata __initdata ek_lcdc_data;
 #endif
 
 
diff --git a/arch/arm/mach-at91/board.h b/arch/arm/mach-at91/board.h
index 4a234fb..6c08b34 100644
--- a/arch/arm/mach-at91/board.h
+++ b/arch/arm/mach-at91/board.h
@@ -107,8 +107,8 @@ extern void __init at91_add_device_pwm(u32 mask);
 extern void __init at91_add_device_ssc(unsigned id, unsigned pins);
 
  /* LCD Controller */
-struct atmel_lcdfb_info;
-extern void __init at91_add_device_lcdc(struct atmel_lcdfb_info *data);
+struct atmel_lcdfb_pdata;
+extern void __init at91_add_device_lcdc(struct atmel_lcdfb_pdata *data);
 
  /* AC97 */
 extern void __init at91_add_device_ac97(struct ac97c_platform_data *data);
diff --git a/arch/avr32/boards/atngw100/evklcd10x.c b/arch/avr32/boards/atngw100/evklcd10x.c
index 2038875..dc42804 100644
--- a/arch/avr32/boards/atngw100/evklcd10x.c
+++ b/arch/avr32/boards/atngw100/evklcd10x.c
@@ -58,7 +58,7 @@ static struct fb_monspecs __initdata atevklcd10x_default_monspecs = {
 	.dclkmax		= 28330000,
 };
 
-static struct atmel_lcdfb_info __initdata atevklcd10x_lcdc_data = {
+static struct atmel_lcdfb_pdata __initdata atevklcd10x_lcdc_data = {
 	.default_bpp		= 16,
 	.default_dmacon		= ATMEL_LCDC_DMAEN | ATMEL_LCDC_DMA2DEN,
 	.default_lcdcon2	= (ATMEL_LCDC_DISTYPE_TFT
@@ -96,7 +96,7 @@ static struct fb_monspecs __initdata atevklcd10x_default_monspecs = {
 	.dclkmax		= 7000000,
 };
 
-static struct atmel_lcdfb_info __initdata atevklcd10x_lcdc_data = {
+static struct atmel_lcdfb_pdata __initdata atevklcd10x_lcdc_data = {
 	.default_bpp		= 16,
 	.default_dmacon		= ATMEL_LCDC_DMAEN | ATMEL_LCDC_DMA2DEN,
 	.default_lcdcon2	= (ATMEL_LCDC_DISTYPE_TFT
@@ -134,7 +134,7 @@ static struct fb_monspecs __initdata atevklcd10x_default_monspecs = {
 	.dclkmax		= 6400000,
 };
 
-static struct atmel_lcdfb_info __initdata atevklcd10x_lcdc_data = {
+static struct atmel_lcdfb_pdata __initdata atevklcd10x_lcdc_data = {
 	.default_bpp		= 16,
 	.default_dmacon		= ATMEL_LCDC_DMAEN | ATMEL_LCDC_DMA2DEN,
 	.default_lcdcon2	= (ATMEL_LCDC_DISTYPE_TFT
diff --git a/arch/avr32/boards/atngw100/mrmt.c b/arch/avr32/boards/atngw100/mrmt.c
index f914319..ccc9599 100644
--- a/arch/avr32/boards/atngw100/mrmt.c
+++ b/arch/avr32/boards/atngw100/mrmt.c
@@ -83,7 +83,7 @@ static struct fb_monspecs __initdata lcd_fb_default_monspecs = {
 	.dclkmax		= 9260000,
 };
 
-static struct atmel_lcdfb_info __initdata rmt_lcdc_data = {
+static struct atmel_lcdfb_pdata __initdata rmt_lcdc_data = {
 	.default_bpp		= 24,
 	.default_dmacon		= ATMEL_LCDC_DMAEN | ATMEL_LCDC_DMA2DEN,
 	.default_lcdcon2	= (ATMEL_LCDC_DISTYPE_TFT
@@ -126,7 +126,7 @@ static struct fb_monspecs __initdata lcd_fb_default_monspecs = {
 	.dclkmax		= 9260000,
 };
 
-static struct atmel_lcdfb_info __initdata rmt_lcdc_data = {
+static struct atmel_lcdfb_pdata __initdata rmt_lcdc_data = {
 	.default_bpp		= 24,
 	.default_dmacon		= ATMEL_LCDC_DMAEN | ATMEL_LCDC_DMA2DEN,
 	.default_lcdcon2	= (ATMEL_LCDC_DISTYPE_TFT
diff --git a/arch/avr32/boards/atstk1000/atstk1000.h b/arch/avr32/boards/atstk1000/atstk1000.h
index 9392d32..653cc09 100644
--- a/arch/avr32/boards/atstk1000/atstk1000.h
+++ b/arch/avr32/boards/atstk1000/atstk1000.h
@@ -10,7 +10,7 @@
 #ifndef __ARCH_AVR32_BOARDS_ATSTK1000_ATSTK1000_H
 #define __ARCH_AVR32_BOARDS_ATSTK1000_ATSTK1000_H
 
-extern struct atmel_lcdfb_info atstk1000_lcdc_data;
+extern struct atmel_lcdfb_pdata atstk1000_lcdc_data;
 
 void atstk1000_setup_j2_leds(void);
 
diff --git a/arch/avr32/boards/atstk1000/setup.c b/arch/avr32/boards/atstk1000/setup.c
index 2d6b560..b6b88f5 100644
--- a/arch/avr32/boards/atstk1000/setup.c
+++ b/arch/avr32/boards/atstk1000/setup.c
@@ -55,7 +55,7 @@ static struct fb_monspecs __initdata atstk1000_default_monspecs = {
 	.dclkmax		= 30000000,
 };
 
-struct atmel_lcdfb_info __initdata atstk1000_lcdc_data = {
+struct atmel_lcdfb_pdata __initdata atstk1000_lcdc_data = {
 	.default_bpp		= 24,
 	.default_dmacon		= ATMEL_LCDC_DMAEN | ATMEL_LCDC_DMA2DEN,
 	.default_lcdcon2	= (ATMEL_LCDC_DISTYPE_TFT
diff --git a/arch/avr32/boards/favr-32/setup.c b/arch/avr32/boards/favr-32/setup.c
index 27bd6fb..7b1f2cd 100644
--- a/arch/avr32/boards/favr-32/setup.c
+++ b/arch/avr32/boards/favr-32/setup.c
@@ -125,7 +125,7 @@ static struct fb_monspecs __initdata favr32_default_monspecs = {
 	.dclkmax		= 28000000,
 };
 
-struct atmel_lcdfb_info __initdata favr32_lcdc_data = {
+struct atmel_lcdfb_pdata __initdata favr32_lcdc_data = {
 	.default_bpp		= 16,
 	.default_dmacon		= ATMEL_LCDC_DMAEN | ATMEL_LCDC_DMA2DEN,
 	.default_lcdcon2	= (ATMEL_LCDC_DISTYPE_TFT
diff --git a/arch/avr32/boards/hammerhead/setup.c b/arch/avr32/boards/hammerhead/setup.c
index 9d1efd1..dc0e317 100644
--- a/arch/avr32/boards/hammerhead/setup.c
+++ b/arch/avr32/boards/hammerhead/setup.c
@@ -77,7 +77,7 @@ static struct fb_monspecs __initdata hammerhead_hda350t_monspecs = {
 	.dclkmax		= 10000000,
 };
 
-struct atmel_lcdfb_info __initdata hammerhead_lcdc_data = {
+struct atmel_lcdfb_pdata __initdata hammerhead_lcdc_data = {
 	.default_bpp		= 24,
 	.default_dmacon		= ATMEL_LCDC_DMAEN | ATMEL_LCDC_DMA2DEN,
 	.default_lcdcon2	= (ATMEL_LCDC_DISTYPE_TFT
diff --git a/arch/avr32/boards/merisc/display.c b/arch/avr32/boards/merisc/display.c
index 85a543c..e7683ee 100644
--- a/arch/avr32/boards/merisc/display.c
+++ b/arch/avr32/boards/merisc/display.c
@@ -45,7 +45,7 @@ static struct fb_monspecs merisc_fb_monspecs = {
 	.dclkmax	= 30000000,
 };
 
-struct atmel_lcdfb_info merisc_lcdc_data = {
+struct atmel_lcdfb_pdata merisc_lcdc_data = {
 	.default_bpp		= 24,
 	.default_dmacon		= ATMEL_LCDC_DMAEN | ATMEL_LCDC_DMA2DEN,
 	.default_lcdcon2	= (ATMEL_LCDC_DISTYPE_TFT
diff --git a/arch/avr32/boards/mimc200/setup.c b/arch/avr32/boards/mimc200/setup.c
index 05358aa..1cb8e9c 100644
--- a/arch/avr32/boards/mimc200/setup.c
+++ b/arch/avr32/boards/mimc200/setup.c
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  */
 
-extern struct atmel_lcdfb_info mimc200_lcdc_data;
+extern struct atmel_lcdfb_pdata mimc200_lcdc_data;
 
 #include <linux/clk.h>
 #include <linux/etherdevice.h>
@@ -71,7 +71,7 @@ static struct fb_monspecs __initdata mimc200_default_monspecs = {
 	.dclkmax		= 25200000,
 };
 
-struct atmel_lcdfb_info __initdata mimc200_lcdc_data = {
+struct atmel_lcdfb_pdata __initdata mimc200_lcdc_data = {
 	.default_bpp		= 16,
 	.default_dmacon		= ATMEL_LCDC_DMAEN | ATMEL_LCDC_DMA2DEN,
 	.default_lcdcon2	= (ATMEL_LCDC_DISTYPE_TFT
diff --git a/arch/avr32/mach-at32ap/at32ap700x.c b/arch/avr32/mach-at32ap/at32ap700x.c
index 7c2f668..0badb05 100644
--- a/arch/avr32/mach-at32ap/at32ap700x.c
+++ b/arch/avr32/mach-at32ap/at32ap700x.c
@@ -1437,7 +1437,7 @@ fail:
  *  LCDC
  * -------------------------------------------------------------------- */
 #if defined(CONFIG_CPU_AT32AP7000) || defined(CONFIG_CPU_AT32AP7002)
-static struct atmel_lcdfb_info atmel_lcdfb0_data;
+static struct atmel_lcdfb_pdata atmel_lcdfb0_data;
 static struct resource atmel_lcdfb0_resource[] = {
 	{
 		.start		= 0xff000000,
@@ -1465,12 +1465,12 @@ static struct clk atmel_lcdfb0_pixclk = {
 };
 
 struct platform_device *__init
-at32_add_device_lcdc(unsigned int id, struct atmel_lcdfb_info *data,
+at32_add_device_lcdc(unsigned int id, struct atmel_lcdfb_pdata *data,
 		     unsigned long fbmem_start, unsigned long fbmem_len,
 		     u64 pin_mask)
 {
 	struct platform_device *pdev;
-	struct atmel_lcdfb_info *info;
+	struct atmel_lcdfb_pdata *info;
 	struct fb_monspecs *monspecs;
 	struct fb_videomode *modedb;
 	unsigned int modedb_size;
@@ -1527,7 +1527,7 @@ at32_add_device_lcdc(unsigned int id, struct atmel_lcdfb_info *data,
 	}
 
 	info = pdev->dev.platform_data;
-	memcpy(info, data, sizeof(struct atmel_lcdfb_info));
+	memcpy(info, data, sizeof(struct atmel_lcdfb_pdata));
 	info->default_monspecs = monspecs;
 
 	pdev->name = "at32ap-lcdfb";
diff --git a/arch/avr32/mach-at32ap/include/mach/board.h b/arch/avr32/mach-at32ap/include/mach/board.h
index d485b03..f1a316d 100644
--- a/arch/avr32/mach-at32ap/include/mach/board.h
+++ b/arch/avr32/mach-at32ap/include/mach/board.h
@@ -44,9 +44,9 @@ struct platform_device *
 at32_add_device_spi(unsigned int id, struct spi_board_info *b, unsigned int n);
 void at32_spi_setup_slaves(unsigned int bus_num, struct spi_board_info *b, unsigned int n);
 
-struct atmel_lcdfb_info;
+struct atmel_lcdfb_pdata;
 struct platform_device *
-at32_add_device_lcdc(unsigned int id, struct atmel_lcdfb_info *data,
+at32_add_device_lcdc(unsigned int id, struct atmel_lcdfb_pdata *data,
 		     unsigned long fbmem_start, unsigned long fbmem_len,
 		     u64 pin_mask);
 
diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index c1a2914..98733cd4 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -20,12 +20,45 @@
 #include <linux/gfp.h>
 #include <linux/module.h>
 #include <linux/platform_data/atmel.h>
+#include <video/of_display_timing.h>
 
 #include <mach/cpu.h>
 #include <asm/gpio.h>
 
 #include <video/atmel_lcdc.h>
 
+struct atmel_lcdfb_config {
+	bool have_alt_pixclock;
+	bool have_hozval;
+	bool have_intensity_bit;
+};
+
+ /* LCD Controller info data structure, stored in device platform_data */
+struct atmel_lcdfb_info {
+	spinlock_t		lock;
+	struct fb_info		*info;
+	void __iomem		*mmio;
+	int			irq_base;
+	struct work_struct	task;
+
+	unsigned int		smem_len;
+	struct platform_device	*pdev;
+	struct clk		*bus_clk;
+	struct clk		*lcdc_clk;
+
+	struct backlight_device	*backlight;
+	u8			bl_power;
+	bool			lcdcon_pol_negative;
+	u8			saved_lcdcon;
+
+	u32			pseudo_palette[16];
+	bool			have_intensity_bit;
+
+	struct atmel_lcdfb_pdata pdata;
+
+	struct atmel_lcdfb_config *config;
+};
+
 #define lcdc_readl(sinfo, reg)		__raw_readl((sinfo)->mmio+(reg))
 #define lcdc_writel(sinfo, reg, val)	__raw_writel((val), (sinfo)->mmio+(reg))
 
@@ -34,12 +67,6 @@
 #define ATMEL_LCDC_DMA_BURST_LEN	8	/* words */
 #define ATMEL_LCDC_FIFO_SIZE		512	/* words */
 
-struct atmel_lcdfb_config {
-	bool have_alt_pixclock;
-	bool have_hozval;
-	bool have_intensity_bit;
-};
-
 static struct atmel_lcdfb_config at91sam9261_config = {
 	.have_hozval		= true,
 	.have_intensity_bit	= true,
@@ -242,6 +269,8 @@ static void exit_backlight(struct atmel_lcdfb_info *sinfo)
 
 static void init_contrast(struct atmel_lcdfb_info *sinfo)
 {
+	struct atmel_lcdfb_pdata *pdata = &sinfo->pdata;
+
 	/* contrast pwm can be 'inverted' */
 	if (sinfo->lcdcon_pol_negative)
 			contrast_ctr &= ~(ATMEL_LCDC_POL_POSITIVE);
@@ -250,7 +279,7 @@ static void init_contrast(struct atmel_lcdfb_info *sinfo)
 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, contrast_ctr);
 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_VAL, ATMEL_LCDC_CVAL_DEFAULT);
 
-	if (sinfo->lcdcon_is_backlight)
+	if (pdata->lcdcon_is_backlight)
 		init_backlight(sinfo);
 }
 
@@ -293,9 +322,11 @@ static unsigned long compute_hozval(struct atmel_lcdfb_info *sinfo,
 
 static void atmel_lcdfb_stop_nowait(struct atmel_lcdfb_info *sinfo)
 {
+	struct atmel_lcdfb_pdata *pdata = &sinfo->pdata;
+
 	/* Turn off the LCD controller and the DMA controller */
 	lcdc_writel(sinfo, ATMEL_LCDC_PWRCON,
-			sinfo->guard_time << ATMEL_LCDC_GUARDT_OFFSET);
+			pdata->guard_time << ATMEL_LCDC_GUARDT_OFFSET);
 
 	/* Wait for the LCDC core to become idle */
 	while (lcdc_readl(sinfo, ATMEL_LCDC_PWRCON) & ATMEL_LCDC_BUSY)
@@ -315,9 +346,11 @@ static void atmel_lcdfb_stop(struct atmel_lcdfb_info *sinfo)
 
 static void atmel_lcdfb_start(struct atmel_lcdfb_info *sinfo)
 {
-	lcdc_writel(sinfo, ATMEL_LCDC_DMACON, sinfo->default_dmacon);
+	struct atmel_lcdfb_pdata *pdata = &sinfo->pdata;
+
+	lcdc_writel(sinfo, ATMEL_LCDC_DMACON, pdata->default_dmacon);
 	lcdc_writel(sinfo, ATMEL_LCDC_PWRCON,
-		(sinfo->guard_time << ATMEL_LCDC_GUARDT_OFFSET)
+		(pdata->guard_time << ATMEL_LCDC_GUARDT_OFFSET)
 		| ATMEL_LCDC_PWR);
 }
 
@@ -418,6 +451,7 @@ static int atmel_lcdfb_check_var(struct fb_var_screeninfo *var,
 {
 	struct device *dev = info->device;
 	struct atmel_lcdfb_info *sinfo = info->par;
+	struct atmel_lcdfb_pdata *pdata = &sinfo->pdata;
 	unsigned long clk_value_khz;
 
 	clk_value_khz = clk_get_rate(sinfo->lcdc_clk) / 1000;
@@ -501,7 +535,7 @@ static int atmel_lcdfb_check_var(struct fb_var_screeninfo *var,
 		else
 			var->green.length = 6;
 
-		if (sinfo->lcd_wiring_mode = ATMEL_LCDC_WIRING_RGB) {
+		if (pdata->lcd_wiring_mode = ATMEL_LCDC_WIRING_RGB) {
 			/* RGB:5X5 mode */
 			var->red.offset = var->green.length + 5;
 			var->blue.offset = 0;
@@ -518,7 +552,7 @@ static int atmel_lcdfb_check_var(struct fb_var_screeninfo *var,
 		var->transp.length = 8;
 		/* fall through */
 	case 24:
-		if (sinfo->lcd_wiring_mode = ATMEL_LCDC_WIRING_RGB) {
+		if (pdata->lcd_wiring_mode = ATMEL_LCDC_WIRING_RGB) {
 			/* RGB:888 mode */
 			var->red.offset = 16;
 			var->blue.offset = 0;
@@ -567,6 +601,7 @@ static void atmel_lcdfb_reset(struct atmel_lcdfb_info *sinfo)
 static int atmel_lcdfb_set_par(struct fb_info *info)
 {
 	struct atmel_lcdfb_info *sinfo = info->par;
+	struct atmel_lcdfb_pdata *pdata = &sinfo->pdata;
 	unsigned long hozval_linesz;
 	unsigned long value;
 	unsigned long clk_value_khz;
@@ -628,7 +663,7 @@ static int atmel_lcdfb_set_par(struct fb_info *info)
 
 
 	/* Initialize control register 2 */
-	value = sinfo->default_lcdcon2;
+	value = pdata->default_lcdcon2;
 
 	if (!(info->var.sync & FB_SYNC_HOR_HIGH_ACT))
 		value |= ATMEL_LCDC_INVLINE_INVERTED;
@@ -732,6 +767,7 @@ static int atmel_lcdfb_setcolreg(unsigned int regno, unsigned int red,
 			     unsigned int transp, struct fb_info *info)
 {
 	struct atmel_lcdfb_info *sinfo = info->par;
+	struct atmel_lcdfb_pdata *pdata = &sinfo->pdata;
 	unsigned int val;
 	u32 *pal;
 	int ret = 1;
@@ -768,8 +804,7 @@ static int atmel_lcdfb_setcolreg(unsigned int regno, unsigned int red,
 				 */
 			} else {
 				/* new style BGR:565 / RGB:565 */
-				if (sinfo->lcd_wiring_mode =
-				    ATMEL_LCDC_WIRING_RGB) {
+				if (pdata->lcd_wiring_mode = ATMEL_LCDC_WIRING_RGB) {
 					val  = ((blue >> 11) & 0x001f);
 					val |= ((red  >>  0) & 0xf800);
 				} else {
@@ -909,7 +944,7 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct fb_info *info;
 	struct atmel_lcdfb_info *sinfo;
-	struct atmel_lcdfb_info *pdata_sinfo;
+	struct atmel_lcdfb_pdata *pdata;
 	struct fb_videomode fbmode;
 	struct resource *regs = NULL;
 	struct resource *map = NULL;
@@ -927,17 +962,8 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 	sinfo = info->par;
 
 	if (dev->platform_data) {
-		pdata_sinfo = (struct atmel_lcdfb_info *)dev->platform_data;
-		sinfo->default_bpp = pdata_sinfo->default_bpp;
-		sinfo->default_dmacon = pdata_sinfo->default_dmacon;
-		sinfo->default_lcdcon2 = pdata_sinfo->default_lcdcon2;
-		sinfo->default_monspecs = pdata_sinfo->default_monspecs;
-		sinfo->atmel_lcdfb_power_control = pdata_sinfo->atmel_lcdfb_power_control;
-		sinfo->guard_time = pdata_sinfo->guard_time;
-		sinfo->smem_len = pdata_sinfo->smem_len;
-		sinfo->lcdcon_is_backlight = pdata_sinfo->lcdcon_is_backlight;
-		sinfo->lcdcon_pol_negative = pdata_sinfo->lcdcon_pol_negative;
-		sinfo->lcd_wiring_mode = pdata_sinfo->lcd_wiring_mode;
+		pdata = (struct atmel_lcdfb_pdata *)dev->platform_data;
+		sinfo->pdata = *pdata;
 	} else {
 		dev_err(dev, "cannot get default configuration\n");
 		goto free_info;
@@ -953,7 +979,7 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 	info->pseudo_palette = sinfo->pseudo_palette;
 	info->fbops = &atmel_lcdfb_ops;
 
-	memcpy(&info->monspecs, sinfo->default_monspecs, sizeof(info->monspecs));
+	memcpy(&info->monspecs, pdata->default_monspecs, sizeof(info->monspecs));
 	info->fix = atmel_lcdfb_fix;
 
 	/* Enable LCDC Clocks */
@@ -971,7 +997,7 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 
 	ret = fb_find_mode(&info->var, info, NULL, info->monspecs.modedb,
 			info->monspecs.modedb_len, info->monspecs.modedb,
-			sinfo->default_bpp);
+			pdata->default_bpp);
 	if (!ret) {
 		dev_err(dev, "no suitable video mode found\n");
 		goto stop_clk;
@@ -1088,8 +1114,8 @@ static int __init atmel_lcdfb_probe(struct platform_device *pdev)
 	fb_add_videomode(&fbmode, &info->modelist);
 
 	/* Power up the LCDC screen */
-	if (sinfo->atmel_lcdfb_power_control)
-		sinfo->atmel_lcdfb_power_control(1);
+	if (pdata->atmel_lcdfb_power_control)
+		pdata->atmel_lcdfb_power_control(1);
 
 	dev_info(dev, "fb%d: Atmel LCDC at 0x%08lx (mapped at %p), irq %d\n",
 		       info->node, info->fix.mmio_start, sinfo->mmio, sinfo->irq_base);
@@ -1134,15 +1160,17 @@ static int __exit atmel_lcdfb_remove(struct platform_device *pdev)
 	struct device *dev = &pdev->dev;
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct atmel_lcdfb_info *sinfo;
+	struct atmel_lcdfb_pdata *pdata;
 
 	if (!info || !info->par)
 		return 0;
 	sinfo = info->par;
+	pdata = &sinfo->pdata;
 
 	cancel_work_sync(&sinfo->task);
 	exit_backlight(sinfo);
-	if (sinfo->atmel_lcdfb_power_control)
-		sinfo->atmel_lcdfb_power_control(0);
+	if (pdata->atmel_lcdfb_power_control)
+		pdata->atmel_lcdfb_power_control(0);
 	unregister_framebuffer(info);
 	atmel_lcdfb_stop_clock(sinfo);
 	clk_put(sinfo->lcdc_clk);
@@ -1170,6 +1198,7 @@ static int atmel_lcdfb_suspend(struct platform_device *pdev, pm_message_t mesg)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 	struct atmel_lcdfb_info *sinfo = info->par;
+	struct atmel_lcdfb_pdata *pdata = &sinfo->pdata;
 
 	/*
 	 * We don't want to handle interrupts while the clock is
@@ -1179,8 +1208,8 @@ static int atmel_lcdfb_suspend(struct platform_device *pdev, pm_message_t mesg)
 
 	sinfo->saved_lcdcon = lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_CTR);
 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, 0);
-	if (sinfo->atmel_lcdfb_power_control)
-		sinfo->atmel_lcdfb_power_control(0);
+	if (pdata->atmel_lcdfb_power_control)
+		pdata->atmel_lcdfb_power_control(0);
 
 	atmel_lcdfb_stop(sinfo);
 	atmel_lcdfb_stop_clock(sinfo);
@@ -1192,11 +1221,12 @@ static int atmel_lcdfb_resume(struct platform_device *pdev)
 {
 	struct fb_info *info = platform_get_drvdata(pdev);
 	struct atmel_lcdfb_info *sinfo = info->par;
+	struct atmel_lcdfb_pdata *pdata = &sinfo->pdata;
 
 	atmel_lcdfb_start_clock(sinfo);
 	atmel_lcdfb_start(sinfo);
-	if (sinfo->atmel_lcdfb_power_control)
-		sinfo->atmel_lcdfb_power_control(1);
+	if (pdata->atmel_lcdfb_power_control)
+		pdata->atmel_lcdfb_power_control(1);
 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, sinfo->saved_lcdcon);
 
 	/* Enable FIFO & DMA errors */
diff --git a/include/video/atmel_lcdc.h b/include/video/atmel_lcdc.h
index 0f5a2fc..2eb601c 100644
--- a/include/video/atmel_lcdc.h
+++ b/include/video/atmel_lcdc.h
@@ -31,39 +31,17 @@
 #define ATMEL_LCDC_WIRING_BGR	0
 #define ATMEL_LCDC_WIRING_RGB	1
 
-struct atmel_lcdfb_config;
 
  /* LCD Controller info data structure, stored in device platform_data */
-struct atmel_lcdfb_info {
-	spinlock_t		lock;
-	struct fb_info		*info;
-	void __iomem		*mmio;
-	int			irq_base;
-	struct work_struct	task;
-
+struct atmel_lcdfb_pdata {
 	unsigned int		guard_time;
-	unsigned int 		smem_len;
-	struct platform_device	*pdev;
-	struct clk		*bus_clk;
-	struct clk		*lcdc_clk;
-
-#ifdef CONFIG_BACKLIGHT_ATMEL_LCDC
-	struct backlight_device	*backlight;
-	u8			bl_power;
-#endif
 	bool			lcdcon_is_backlight;
-	bool			lcdcon_pol_negative;
-	u8			saved_lcdcon;
-
 	u8			default_bpp;
 	u8			lcd_wiring_mode;
 	unsigned int		default_lcdcon2;
 	unsigned int		default_dmacon;
 	void (*atmel_lcdfb_power_control)(int on);
 	struct fb_monspecs	*default_monspecs;
-	u32			pseudo_palette[16];
-
-	struct atmel_lcdfb_config *config;
 };
 
 #define ATMEL_LCDC_DMABADDR1	0x00
-- 
1.7.10.4

