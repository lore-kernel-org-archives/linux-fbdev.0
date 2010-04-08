From: Roger Quadros <roger.quadros@nokia.com>
Date: Thu, 08 Apr 2010 12:21:05 +0000
Subject: [PATCHv2 3/5] OMAP: RX51: Add Touch Controller in SPI board info
Message-Id: <1270729267-27553-4-git-send-email-roger.quadros@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1270729267-27553-1-git-send-email-roger.quadros@nokia.com>
 <1270729267-27553-2-git-send-email-roger.quadros@nokia.com>
 <1270729267-27553-3-git-send-email-roger.quadros@nokia.com>
In-Reply-To: <1270729267-27553-3-git-send-email-roger.quadros@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi.Valkeinen@nokia.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

From: Roger Quadros <roger.quadros@nokia.com>

The Touch controller and LCD Panel share the same SPI bus 1.
So, we need to define the touch controller in the SPI board info
else, the SPI bus will be contended due to invalid state of
Touch controller's Chip Select thus preventing the LCD panel
from working.

Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index 3ef805e..020f354 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -46,6 +46,7 @@
 enum {
 	RX51_SPI_WL1251,
 	RX51_SPI_MIPID,		/* LCD panel */
+	RX51_SPI_TSC2005,	/* Touch Controller */
 };
 
 static struct wl12xx_platform_data wl1251_pdata;
@@ -60,6 +61,11 @@ static struct omap2_mcspi_device_config mipid_mcspi_config = {
 	.single_channel	= 1,
 };
 
+static struct omap2_mcspi_device_config tsc2005_mcspi_config = {
+	.turbo_mode	= 0,
+	.single_channel	= 1,
+};
+
 static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
 	[RX51_SPI_WL1251] = {
 		.modalias		= "wl1251",
@@ -77,6 +83,15 @@ static struct spi_board_info rx51_peripherals_spi_board_info[] __initdata = {
 		.max_speed_hz		= 6000000,
 		.controller_data	= &mipid_mcspi_config,
 	},
+	[RX51_SPI_TSC2005] = {
+		.modalias		= "tsc2005",
+		.bus_num		= 1,
+		.chip_select		= 0,
+		/* .irq = OMAP_GPIO_IRQ(RX51_TSC2005_IRQ_GPIO),*/
+		.max_speed_hz		= 6000000,
+		.controller_data	= &tsc2005_mcspi_config,
+		/* .platform_data = &tsc2005_config,*/
+	},
 };
 
 #if defined(CONFIG_KEYBOARD_GPIO) || defined(CONFIG_KEYBOARD_GPIO_MODULE)
-- 
1.6.0.4

