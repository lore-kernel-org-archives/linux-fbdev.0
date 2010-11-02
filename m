From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 02 Nov 2010 11:27:34 +0000
Subject: [PATCH 4/4 v2] ARM: mach-shmobile: optimize PLLC2 frequency for HDMI
Message-Id: <Pine.LNX.4.64.1011021225400.4552@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On ap4evb PLLC2 is only used as a parent of the HDMI clock, therefore it can
be reconfigured freely to improve HDMI clock precision.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: now using the generic sh clock-framework function

 arch/arm/mach-shmobile/board-ap4evb.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 46ca4d4..f01ba9f 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -631,9 +631,13 @@ static struct platform_device lcdc1_device = {
 	},
 };
 
+static long ap4evb_clk_optimize(unsigned long target, unsigned long *best_freq,
+				unsigned long *parent_freq);
+
 static struct sh_mobile_hdmi_info hdmi_info = {
 	.lcd_chan = &sh_mobile_lcdc1_info.ch[0],
 	.lcd_dev = &lcdc1_device.dev,
+	.clk_optimize_parent = ap4evb_clk_optimize,
 };
 
 static struct resource hdmi_resources[] = {
@@ -660,6 +664,25 @@ static struct platform_device hdmi_device = {
 	},
 };
 
+static long ap4evb_clk_optimize(unsigned long target, unsigned long *best_freq,
+				unsigned long *parent_freq)
+{
+	struct clk *hdmi_ick = clk_get(&hdmi_device.dev, "ick");
+	long error;
+
+	if (IS_ERR(hdmi_ick)) {
+		int ret = PTR_ERR(hdmi_ick);
+		pr_err("Cannot get HDMI ICK: %d\n", ret);
+		return ret;
+	}
+
+	error = clk_round_parent(hdmi_ick, target, best_freq, parent_freq, 1, 64);
+
+	clk_put(hdmi_ick);
+
+	return error;
+}
+
 static struct gpio_led ap4evb_leds[] = {
 	{
 		.name			= "led4",
-- 
1.7.2.3

