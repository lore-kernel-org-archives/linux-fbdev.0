From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Wed, 27 Oct 2010 16:24:26 +0000
Subject: [PATCH/RFC 3/3] ARM: mach-shmobile: implement parent clock optimization
Message-Id: <Pine.LNX.4.64.1010271821580.11687@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

On ap4evb PLLC2 is used as a parent clock for the HDMI clock. To configure the
HDMI clock with the highest precision this patch scans all available PLLC2
frequencies and picks up the best one.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 arch/arm/mach-shmobile/board-ap4evb.c |   60 +++++++++++++++++++++++++++++++++
 1 files changed, 60 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-shmobile/board-ap4evb.c b/arch/arm/mach-shmobile/board-ap4evb.c
index 7d0a8c4..8676e26 100644
--- a/arch/arm/mach-shmobile/board-ap4evb.c
+++ b/arch/arm/mach-shmobile/board-ap4evb.c
@@ -637,9 +637,69 @@ static struct platform_device lcdc1_device = {
 	},
 };
 
+#define MAX_DIVISOR 63
+
+static long ap4evb_clk_optimize(unsigned long target, unsigned long *best_freq,
+				unsigned long *parent_freq)
+{
+	struct cpufreq_frequency_table *freq, *best = NULL;
+	unsigned long error = ULONG_MAX, freq_high, freq_low, div;
+
+	for (freq = pllc2_clk.freq_table; freq->frequency != CPUFREQ_TABLE_END;
+	     freq++) {
+		if (freq->frequency < target) {
+			if (error > target - freq->frequency) {
+				error = target - freq->frequency;
+				best = freq;
+				if (best_freq)
+					*best_freq = freq->frequency;
+			}
+			continue;
+		}
+		div = freq->frequency / target;
+		if (div > MAX_DIVISOR)
+			div = MAX_DIVISOR;
+		freq_high = freq->frequency / div;
+		freq_low = freq->frequency / (div + 1);
+		if (freq_high - target < error) {
+			error = freq_high - target;
+			best = freq;
+			if (best_freq)
+				*best_freq = freq_high;
+		}
+		if (target - freq_low < error) {
+			error = target - freq_low;
+			best = freq;
+			if (best_freq)
+				*best_freq = freq_low;
+		}
+		pr_debug("%u / %lu = %lu, / %lu = %lu, best %lu, parent %u\n",
+			 freq->frequency, div, freq_high, div + 1, freq_low,
+			 *best_freq, best->frequency);
+		if (!error)
+			break;
+	}
+	if (parent_freq)
+		*parent_freq = best->frequency;
+	return error;
+}
+
+static int ap4evb_clk_set_rate(struct clk *clk, unsigned long rate)
+{
+	return clk_set_rate(clk->parent, rate);
+}
+
+static unsigned long ap4evb_clk_get_rate(struct clk *clk)
+{
+	return clk_get_rate(clk->parent);
+}
+
 static struct sh_mobile_hdmi_info hdmi_info = {
 	.lcd_chan = &sh_mobile_lcdc1_info.ch[0],
 	.lcd_dev = &lcdc1_device.dev,
+	.clk_optimize_parent = ap4evb_clk_optimize,
+	.clk_set_rate_parent = ap4evb_clk_set_rate,
+	.clk_get_rate_parent = ap4evb_clk_get_rate,
 };
 
 static struct resource hdmi_resources[] = {
-- 
1.7.1

