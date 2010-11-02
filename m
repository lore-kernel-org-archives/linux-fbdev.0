From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 02 Nov 2010 11:27:24 +0000
Subject: [PATCH 3/4 v2] sh: add clk_round_parent() to optimize parent clock
Message-Id: <Pine.LNX.4.64.1011021223100.4552@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Sometimes it is possible and reasonable to adjust the parent clock rate to
improve precision of the child clock, e.g., if the child clock has no siblings.
clk_round_parent() is a new addition to the SH clock-framework API, that
implements such an optimization for child clocks with divisors, taking all
integer values in a range.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

v2: As suggested by Paul (thanks), this has been converted to a generic sh 
clk-framework function, which is then used by ap4evb call-back in the next 
patch

 drivers/sh/clk/core.c  |   75 ++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/sh_clk.h |    4 ++
 2 files changed, 79 insertions(+), 0 deletions(-)

diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
index fd0d1b9..358db1b 100644
--- a/drivers/sh/clk/core.c
+++ b/drivers/sh/clk/core.c
@@ -541,6 +541,81 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(clk_round_rate);
 
+long clk_round_parent(struct clk *clk, unsigned long target,
+		      unsigned long *best_freq, unsigned long *parent_freq,
+		      unsigned int div_min, unsigned int div_max)
+{
+	struct cpufreq_frequency_table *freq, *best = NULL;
+	unsigned long error = ULONG_MAX, freq_high, freq_low, div;
+	struct clk *parent = clk_get_parent(clk);
+
+	if (!parent) {
+		*parent_freq = 0;
+		*best_freq = clk_round_rate(clk, target);
+		return abs(target - *best_freq);
+	}
+
+	for (freq = parent->freq_table; freq->frequency != CPUFREQ_TABLE_END;
+	     freq++) {
+		if (freq->frequency = CPUFREQ_ENTRY_INVALID)
+			continue;
+
+		if (unlikely(freq->frequency / target <= div_min - 1)) {
+			unsigned long freq_max = (freq->frequency + div_min / 2) / div_min;
+			if (error > target - freq_max) {
+				error = target - freq_max;
+				best = freq;
+				if (best_freq)
+					*best_freq = freq_max;
+			}
+			pr_debug("too low freq %lu, error %lu\n", freq->frequency, target - freq_max);
+			if (!error)
+				break;
+			continue;
+		}
+
+		if (unlikely(freq->frequency / target >= div_max)) {
+			unsigned long freq_min = (freq->frequency + div_max / 2) / div_max;
+			if (error > freq_min - target) {
+				error = freq_min - target;
+				best = freq;
+				if (best_freq)
+					*best_freq = freq_min;
+			}
+			pr_debug("too high freq %lu, error %lu\n", freq->frequency, freq_min - target);
+			if (!error)
+				break;
+			continue;
+		}
+
+		
+		div = freq->frequency / target;
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
+EXPORT_SYMBOL_GPL(clk_round_parent);
+
 #ifdef CONFIG_PM
 static int clks_sysdev_suspend(struct sys_device *dev, pm_message_t state)
 {
diff --git a/include/linux/sh_clk.h b/include/linux/sh_clk.h
index 4dca992..cea0c38 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -122,6 +122,10 @@ int clk_rate_table_find(struct clk *clk,
 long clk_rate_div_range_round(struct clk *clk, unsigned int div_min,
 			      unsigned int div_max, unsigned long rate);
 
+long clk_round_parent(struct clk *clk, unsigned long target,
+		      unsigned long *best_freq, unsigned long *parent_freq,
+		      unsigned int div_min, unsigned int div_max);
+
 #define SH_CLK_MSTP32(_parent, _enable_reg, _enable_bit, _flags)	\
 {									\
 	.parent		= _parent,					\
-- 
1.7.2.3

