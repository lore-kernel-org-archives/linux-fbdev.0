From: Roger Quadros <roger.quadros@nokia.com>
Date: Thu, 15 Apr 2010 12:06:18 +0000
Subject: [PATCHv3 2/5] OMAP: RX51: Add "vdds_sdi" supply voltage for SDI
Message-Id: <1271333181-23609-3-git-send-email-roger.quadros@nokia.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1271333181-23609-1-git-send-email-roger.quadros@nokia.com>
 <1271333181-23609-2-git-send-email-roger.quadros@nokia.com>
In-Reply-To: <1271333181-23609-2-git-send-email-roger.quadros@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi.Valkeinen@nokia.com
Cc: tony@atomide.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

From: Roger Quadros <roger.quadros@nokia.com>

The SDI Display subsystem needs access to the vdds_sdi supply
regulator. This is TWL4030's VAUX1 supply on RX-51.

Signed-off-by: Roger Quadros <roger.quadros@nokia.com>
---
 arch/arm/mach-omap2/board-rx51-peripherals.c |   15 +++++++++++++++
 1 files changed, 15 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-omap2/board-rx51-peripherals.c b/arch/arm/mach-omap2/board-rx51-peripherals.c
index f404537..3ef805e 100644
--- a/arch/arm/mach-omap2/board-rx51-peripherals.c
+++ b/arch/arm/mach-omap2/board-rx51-peripherals.c
@@ -300,6 +300,19 @@ static struct regulator_consumer_supply rx51_vsim_supply = {
 	.dev_name = "mmci-omap-hs.1",
 };
 
+#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
+extern struct platform_device rx51_display_device;
+#endif
+
+static struct regulator_consumer_supply rx51_vaux1_consumers[] = {
+#if defined(CONFIG_FB_OMAP2) || defined(CONFIG_FB_OMAP2_MODULE)
+	{
+		.supply	= "vdds_sdi",
+		.dev	= &rx51_display_device.dev,
+	},
+#endif
+};
+
 static struct regulator_init_data rx51_vaux1 = {
 	.constraints = {
 		.name			= "V28",
@@ -310,6 +323,8 @@ static struct regulator_init_data rx51_vaux1 = {
 		.valid_ops_mask		= REGULATOR_CHANGE_MODE
 					| REGULATOR_CHANGE_STATUS,
 	},
+	.num_consumer_supplies	= ARRAY_SIZE(rx51_vaux1_consumers),
+	.consumer_supplies	= rx51_vaux1_consumers,
 };
 
 static struct regulator_init_data rx51_vaux2 = {
-- 
1.6.0.4

