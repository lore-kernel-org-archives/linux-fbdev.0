From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 29 Oct 2010 12:42:16 +0000
Subject: [PATCH/RFC 3/3 v2] ARM: mach-shmobile: implement parent clock
Message-Id: <Pine.LNX.4.64.1010291436210.25084@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This new function allows to select a parent frequency, which provides the 
best matching child clock rate.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---

Paul, something like this? I know, this is against an "old" kernel, only 
compile tested so far, so, this is even more of an RFC than the previous 
version, just to ask your opinion, if this is the direction you were 
thinking about. Unfortunately, I don't think re-using 
clk_rate_round_helper() would be wise here, but we can discuss that too. 

Thanks
Guennadi

diff --git a/drivers/sh/clk.c b/drivers/sh/clk.c
index 5d84ada..412620b 100644
--- a/drivers/sh/clk.c
+++ b/drivers/sh/clk.c
@@ -390,6 +390,79 @@ long clk_round_rate(struct clk *clk, unsigned long rate)
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
+		if (unlikely(freq->frequency <= target * div_min)) {
+			unsigned long freq_max = (freq->frequency + div_min / 2) / div_min;
+			if (error > target - freq_max) {
+				error = target - freq_max;
+				best = freq;
+				if (best_freq)
+					*best_freq = freq_max;
+			}
+			if (!error)
+				break;
+			continue;
+		}
+
+		if (unlikely(freq->frequency >= target * div_max)) {
+			unsigned long freq_min = (freq->frequency + div_max / 2) / div_max;
+			if (error > target - freq_min) {
+				error = freq_min - target;
+				best = freq;
+				if (best_freq)
+					*best_freq = freq_min;
+			}
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
index 875ce50..d370057 100644
--- a/include/linux/sh_clk.h
+++ b/include/linux/sh_clk.h
@@ -111,6 +111,10 @@ int clk_rate_table_find(struct clk *clk,
 			struct cpufreq_frequency_table *freq_table,
 			unsigned long rate);
 
+long clk_round_parent(struct clk *clk, unsigned long target,
+		      unsigned long *best_freq, unsigned long *parent_freq,
+		      unsigned int div_min, unsigned int div_max);
+
 #define SH_CLK_MSTP32(_parent, _enable_reg, _enable_bit, _flags)	\
 {									\
 	.parent		= _parent,					\
