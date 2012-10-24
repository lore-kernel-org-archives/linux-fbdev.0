From: Zhou Zhu <zzhu3@marvell.com>
Date: Wed, 24 Oct 2012 06:58:38 +0000
Subject: [PATCHv4 7/9] ARM: mmp: add lcd clock support
Message-Id: <1351061918-6522-1-git-send-email-zzhu3@marvell.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

added lcd clock support

Signed-off-by: Zhou Zhu <zzhu3@marvell.com>
---
 arch/arm/mach-mmp/pxa910.c |   32 +++++++++++++++++++++++++++++++-
 1 files changed, 31 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-mmp/pxa910.c b/arch/arm/mach-mmp/pxa910.c
index 7d7c43b..78c6eb8 100644
--- a/arch/arm/mach-mmp/pxa910.c
+++ b/arch/arm/mach-mmp/pxa910.c
@@ -82,6 +82,35 @@ void __init pxa910_init_irq(void)
 	icu_init_irq();
 }
 
+static void lcd_clk_enable(struct clk *clk)
+{
+	writel_relaxed(clk->enable_val, clk->clk_rst);
+}
+static void lcd_clk_disable(struct clk *clk)
+{
+	u32 tmp = readl_relaxed(clk->clk_rst);
+	tmp &= ~0x38;   /* release from reset to keep register setting */
+	writel_relaxed(tmp, clk->clk_rst);
+}
+
+static int lcd_clk_setrate(struct clk *clk, unsigned long val)
+{
+	writel_relaxed(val, clk->clk_rst);
+	return 0;
+}
+static unsigned long lcd_clk_getrate(struct clk *clk)
+{
+	unsigned long rate = clk->rate;
+	return rate;
+}
+
+struct clkops lcd_pn1_clk_ops = {
+	.enable		= lcd_clk_enable,
+	.disable	= lcd_clk_disable,
+	.setrate	= lcd_clk_setrate,
+	.getrate	= lcd_clk_getrate,
+};
+
 /* APB peripheral clocks */
 static APBC_CLK(uart1, PXA910_UART0, 1, 14745600);
 static APBC_CLK(uart2, PXA910_UART1, 1, 14745600);
@@ -93,7 +122,7 @@ static APBC_CLK(pwm3, PXA910_PWM3, 1, 13000000);
 static APBC_CLK(pwm4, PXA910_PWM4, 1, 13000000);
 static APBC_CLK(gpio, PXA910_GPIO, 0, 13000000);
 static APBC_CLK(rtc, PXA910_RTC, 8, 32768);
-
+static APMU_CLK_OPS(lcd, LCD, 0x003f, 312000000, &lcd_pn1_clk_ops);
 static APMU_CLK(nand, NAND, 0x19b, 156000000);
 static APMU_CLK(u2o, USB, 0x1b, 480000000);
 
@@ -111,6 +140,7 @@ static struct clk_lookup pxa910_clkregs[] = {
 	INIT_CLKREG(&clk_gpio, "pxa-gpio", NULL),
 	INIT_CLKREG(&clk_u2o, NULL, "U2OCLK"),
 	INIT_CLKREG(&clk_rtc, "sa1100-rtc", NULL),
+	INIT_CLKREG(&clk_lcd, NULL, "LCDCLK"),
 };
 
 static int __init pxa910_init(void)
-- 
1.7.0.4

