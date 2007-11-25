From: Ville Syrjala <syrjala@sci.fi>
Subject: [PATCH 7/7] sm501: Add support for the SM502
	programmable PLL
Date: Sun, 25 Nov 2007 22:01:32 +0200
Message-ID: <11960208931213-git-send-email-syrjala@sci.fi>
References: <1196020892591-git-send-email-syrjala@sci.fi>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IwNff-0002Rn-KU for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 12:01:39 -0800
Received: from smtp5.pp.htv.fi ([213.243.153.39])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IwNfd-00072K-Ip
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 25 Nov 2007 12:01:39 -0800
In-Reply-To: <1196020892591-git-send-email-syrjala@sci.fi>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: ben@simtec.co.uk, vince@simtec.co.uk, Ville Syrjala <syrjala@sci.fi>

SM502 has a programmable PLL which can provide the panel pixel clock
instead of the 288MHz and 336MHz PLLs.

Signed-off-by: Ville Syrjala <syrjala@sci.fi>
---
 drivers/mfd/sm501.c        |  163 ++++++++++++++++++++++++++++++++++----------
 include/linux/sm501-regs.h |    3 +
 include/linux/sm501.h      |    3 +-
 3 files changed, 133 insertions(+), 36 deletions(-)

diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index 4de8d46..42265dc 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -48,6 +48,7 @@ struct sm501_devdata {
 	unsigned int			 pdev_id;
 	unsigned int			 irq;
 	void __iomem			*regs;
+	unsigned int			 rev;
 };
 
 #define MHZ (1000 * 1000)
@@ -417,46 +418,108 @@ struct sm501_clock {
 	unsigned long mclk;
 	int divider;
 	int shift;
+	unsigned int m, n, k;
 };
 
+/* sm501_calc_clock
+ *
+ * Calculates the nearest discrete clock frequency that
+ * can be achieved with the specified input clock.
+ *   the maximum divisor is 3 or 5
+ */
+
+static int sm501_calc_clock(unsigned long freq,
+			    struct sm501_clock *clock,
+			    int max_div,
+			    unsigned long mclk,
+			    long *best_diff)
+{
+	int ret = 0;
+	int divider;
+	int shift;
+	long diff;
+
+	/* try dividers 1 and 3 for CRT and for panel,
+	   try divider 5 for panel only.*/
+
+	for (divider = 1; divider <= max_div; divider += 2) {
+		/* try all 8 shift values.*/
+		for (shift = 0; shift < 8; shift++) {
+			/* Calculate difference to requested clock */
+			diff = sm501fb_round_div(mclk, divider << shift) - freq;
+			if (diff < 0)
+				diff = -diff;
+
+			/* If it is less than the current, use it */
+			if (diff < *best_diff) {
+				*best_diff = diff;
+
+				clock->mclk = mclk;
+				clock->divider = divider;
+				clock->shift = shift;
+				ret = 1;
+			}
+		}
+	}
+
+	return ret;
+}
+
+/* sm501_calc_pll
+ *
+ * Calculates the nearest discrete clock frequency that can be
+ * achieved using the programmable PLL.
+ *   the maximum divisor is 3 or 5
+ */
+
+static unsigned long sm501_calc_pll(unsigned long freq,
+					struct sm501_clock *clock,
+					int max_div)
+{
+	unsigned long mclk;
+	unsigned int m, n, k;
+	long best_diff = 999999999;
+
+	/*
+	 * The SM502 datasheet doesn't specify the min/max values for M and N.
+	 * N = 1 at least doesn't work in practice.
+	 */
+	for (m = 2; m <= 255; m++) {
+		for (n = 2; n <= 127; n++) {
+			for (k = 0; k <= 1; k++) {
+				mclk = (24000000UL * m / n) >> k;
+
+				if (sm501_calc_clock(freq, clock, max_div,
+						     mclk, &best_diff)) {
+					clock->m = m;
+					clock->n = n;
+					clock->k = k;
+				}
+			}
+		}
+	}
+
+	/* Return best clock. */
+	return clock->mclk / (clock->divider << clock->shift);
+}
+
 /* sm501_select_clock
  *
- * selects nearest discrete clock frequency the SM501 can achive
+ * Calculates the nearest discrete clock frequency that can be
+ * achieved using the 288MHz and 336MHz PLLs.
  *   the maximum divisor is 3 or 5
  */
+
 static unsigned long sm501_select_clock(unsigned long freq,
 					struct sm501_clock *clock,
 					int max_div)
 {
 	unsigned long mclk;
-	int divider;
-	int shift;
-	long diff;
 	long best_diff = 999999999;
 
 	/* Try 288MHz and 336MHz clocks. */
 	for (mclk = 288000000; mclk <= 336000000; mclk += 48000000) {
-		/* try dividers 1 and 3 for CRT and for panel,
-		   try divider 5 for panel only.*/
-
-		for (divider = 1; divider <= max_div; divider += 2) {
-			/* try all 8 shift values.*/
-			for (shift = 0; shift < 8; shift++) {
-				/* Calculate difference to requested clock */
-				diff = sm501fb_round_div(mclk, divider << shift) - freq;
-				if (diff < 0)
-					diff = -diff;
-
-				/* If it is less than the current, use it */
-				if (diff < best_diff) {
-					best_diff = diff;
-
-					clock->mclk = mclk;
-					clock->divider = divider;
-					clock->shift = shift;
-				}
-			}
-		}
+		sm501_calc_clock(freq, clock, max_div, mclk, &best_diff);
 	}
 
 	/* Return best clock. */
@@ -478,6 +541,7 @@ unsigned long sm501_set_clock(struct device *dev,
 	unsigned long gate = readl(sm->regs + SM501_CURRENT_GATE);
 	unsigned long clock = readl(sm->regs + SM501_CURRENT_CLOCK);
 	unsigned char reg;
+	unsigned int pll_reg = 0;
 	unsigned long sm501_freq; /* the actual frequency acheived */
 
 	struct sm501_clock to;
@@ -492,14 +556,28 @@ unsigned long sm501_set_clock(struct device *dev,
 		 * requested frequency the value must be multiplied by
 		 * 2. This clock also has an additional pre divisor */
 
-		sm501_freq = (sm501_select_clock(2 * req_freq, &to, 5) / 2);
-		reg=to.shift & 0x07;/* bottom 3 bits are shift */
-		if (to.divider == 3)
-			reg |= 0x08; /* /3 divider required */
-		else if (to.divider == 5)
-			reg |= 0x10; /* /5 divider required */
-		if (to.mclk != 288000000)
-			reg |= 0x20; /* which mclk pll is source */
+		if (sm->rev >= 0xC0) {
+			/* SM502 -> use the programmable PLL */
+			sm501_freq = (sm501_calc_pll(2 * req_freq,
+						     &to, 5) / 2);
+			reg=to.shift & 0x07;/* bottom 3 bits are shift */
+			if (to.divider == 3)
+				reg |= 0x08; /* /3 divider required */
+			else if (to.divider == 5)
+				reg |= 0x10; /* /5 divider required */
+			reg |= 0x40; /* select the programmable PLL */
+			pll_reg = 0x20000 | (to.k << 15) | (to.n << 8) | to.m;
+		} else {
+			sm501_freq = (sm501_select_clock(2 * req_freq,
+							 &to, 5) / 2);
+			reg=to.shift & 0x07;/* bottom 3 bits are shift */
+			if (to.divider == 3)
+				reg |= 0x08; /* /3 divider required */
+			else if (to.divider == 5)
+				reg |= 0x10; /* /5 divider required */
+			if (to.mclk != 288000000)
+				reg |= 0x20; /* which mclk pll is source */
+		}
 		break;
 
 	case SM501_CLOCK_V2XCLK:
@@ -560,6 +638,10 @@ unsigned long sm501_set_clock(struct device *dev,
 	}
 
 	writel(mode, sm->regs + SM501_POWER_MODE_CONTROL);
+
+	if (pll_reg)
+		writel(pll_reg, sm->regs + SM501_PROGRAMMABLE_PLL_CONTROL);
+
 	sm501_sync_regs(sm);
 
 	dev_info(sm->dev, "gate %08lx, clock %08lx, mode %08lx\n",
@@ -580,15 +662,24 @@ EXPORT_SYMBOL_GPL(sm501_set_clock);
  * finds the closest available frequency for a given clock
 */
 
-unsigned long sm501_find_clock(int clksrc,
+unsigned long sm501_find_clock(struct device *dev,
+			       int clksrc,
 			       unsigned long req_freq)
 {
+	struct sm501_devdata *sm = dev_get_drvdata(dev);
 	unsigned long sm501_freq; /* the frequency achiveable by the 501 */
 	struct sm501_clock to;
 
 	switch (clksrc) {
 	case SM501_CLOCK_P2XCLK:
-		sm501_freq = (sm501_select_clock(2 * req_freq, &to, 5) / 2);
+		if (sm->rev >= 0xC0) {
+			/* SM502 -> use the programmable PLL */
+			sm501_freq = (sm501_calc_pll(2 * req_freq,
+						     &to, 5) / 2);
+		} else {
+			sm501_freq = (sm501_select_clock(2 * req_freq,
+							 &to, 5) / 2);
+		}
 		break;
 
 	case SM501_CLOCK_V2XCLK:
@@ -895,6 +986,8 @@ static int sm501_init_dev(struct sm501_devdata *sm)
 	dev_info(sm->dev, "SM501 At %p: Version %08lx, %ld Mb, IRQ %d\n",
 		 sm->regs, devid, (unsigned long)mem_avail >> 20, sm->irq);
 
+	sm->rev = devid & SM501_DEVICEID_REVMASK;
+
 	sm501_dump_gate(sm);
 
 	ret = device_create_file(sm->dev, &dev_attr_dbg_regs);
diff --git a/include/linux/sm501-regs.h b/include/linux/sm501-regs.h
index df7620d..a9961d4 100644
--- a/include/linux/sm501-regs.h
+++ b/include/linux/sm501-regs.h
@@ -129,11 +129,14 @@
 
 #define SM501_DEVICEID_SM501		(0x05010000)
 #define SM501_DEVICEID_IDMASK		(0xffff0000)
+#define SM501_DEVICEID_REVMASK		(0x000000ff)
 
 #define SM501_PLLCLOCK_COUNT		(0x000064)
 #define SM501_MISC_TIMING		(0x000068)
 #define SM501_CURRENT_SDRAM_CLOCK	(0x00006C)
 
+#define SM501_PROGRAMMABLE_PLL_CONTROL	(0x000074)
+
 /* GPIO base */
 #define SM501_GPIO			(0x010000)
 #define SM501_GPIO_DATA_LOW		(0x00)
diff --git a/include/linux/sm501.h b/include/linux/sm501.h
index 9e3aaad..8b6e6c8 100644
--- a/include/linux/sm501.h
+++ b/include/linux/sm501.h
@@ -24,7 +24,8 @@ extern int sm501_unit_power(struct device *dev,
 extern unsigned long sm501_set_clock(struct device *dev,
 				     int clksrc, unsigned long freq);
 
-extern unsigned long sm501_find_clock(int clksrc, unsigned long req_freq);
+extern unsigned long sm501_find_clock(struct device *dev,
+				      int clksrc, unsigned long req_freq);
 
 /* sm501_misc_control
  *
-- 
1.5.2.5


-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
