From: Jingoo Han <jg1.han@samsung.com>
Date: Fri, 27 Jan 2012 05:47:55 +0000
Subject: [PATCH 2/2] video: s3c-fb: add video clock running at data under-flow
Message-Id: <007e01ccdcb7$37c0cd50$a74267f0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch adds video clock running at data under-flow.
It means that the pixel clock is continuously provided
to lcd module, even when under-run occurs.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 arch/arm/plat-samsung/include/plat/regs-fb.h |    3 +++
 drivers/video/s3c-fb.c                       |   23 +++++++++++++++++++++++
 2 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/arch/arm/plat-samsung/include/plat/regs-fb.h b/arch/arm/plat-samsung/include/plat/regs-fb.h
index 6bf68ed..bbb16e0 100644
--- a/arch/arm/plat-samsung/include/plat/regs-fb.h
+++ b/arch/arm/plat-samsung/include/plat/regs-fb.h
@@ -91,6 +91,9 @@
 #define VIDCON1_VSTATUS_BACKPORCH		(0x1 << 13)
 #define VIDCON1_VSTATUS_ACTIVE			(0x2 << 13)
 #define VIDCON1_VSTATUS_FRONTPORCH		(0x0 << 13)
+#define VIDCON1_VCLK_MASK			(0x3 << 9)
+#define VIDCON1_VCLK_HOLD			(0x0 << 9)
+#define VIDCON1_VCLK_RUN			(0x1 << 9)
 
 #define VIDCON1_INV_VCLK			(1 << 7)
 #define VIDCON1_INV_HSYNC			(1 << 6)
diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index e92be55..71902cb 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -83,6 +83,7 @@ struct s3c_fb;
  * @has_shadowcon: Set if has SHADOWCON register.
  * @has_blendcon: Set if has BLENDCON register.
  * @has_clksel: Set if VIDCON0 register has CLKSEL bit.
+ * @has_fixvclk: Set if VIDCON1 register has FIXVCLK bits.
  */
 struct s3c_fb_variant {
 	unsigned int	is_2443:1;
@@ -102,6 +103,7 @@ struct s3c_fb_variant {
 	unsigned int	has_shadowcon:1;
 	unsigned int	has_blendcon:1;
 	unsigned int	has_clksel:1;
+	unsigned int	has_fixvclk:1;
 };
 
 /**
@@ -1359,6 +1361,7 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 	struct resource *res;
 	int win;
 	int ret = 0;
+	u32 reg;
 
 	platid = platform_get_device_id(pdev);
 	fbdrv = (struct s3c_fb_driverdata *)platid->driver_data;
@@ -1457,6 +1460,14 @@ static int __devinit s3c_fb_probe(struct platform_device *pdev)
 
 	writel(pd->vidcon1, sfb->regs + VIDCON1);
 
+	/* set video clock running at under-run */
+	if (sfb->variant.has_fixvclk) {
+		reg = readl(sfb->regs + VIDCON1);
+		reg &= ~VIDCON1_VCLK_MASK;
+		reg |= VIDCON1_VCLK_RUN;
+		writel(reg, sfb->regs + VIDCON1);
+	}
+
 	/* zero all windows before we do anything */
 
 	for (win = 0; win < fbdrv->variant.nr_windows; win++)
@@ -1592,6 +1603,7 @@ static int s3c_fb_resume(struct device *dev)
 	struct s3c_fb_platdata *pd = sfb->pdata;
 	struct s3c_fb_win *win;
 	int win_no;
+	u32 reg;
 
 	clk_enable(sfb->bus_clk);
 
@@ -1602,6 +1614,14 @@ static int s3c_fb_resume(struct device *dev)
 	pd->setup_gpio();
 	writel(pd->vidcon1, sfb->regs + VIDCON1);
 
+	/* set video clock running at under-run */
+	if (sfb->variant.has_fixvclk) {
+		reg = readl(sfb->regs + VIDCON1);
+		reg &= ~VIDCON1_VCLK_MASK;
+		reg |= VIDCON1_VCLK_RUN;
+		writel(reg, sfb->regs + VIDCON1);
+	}
+
 	/* zero all windows before we do anything */
 	for (win_no = 0; win_no < sfb->variant.nr_windows; win_no++)
 		s3c_fb_clear_win(sfb, win_no);
@@ -1866,6 +1886,7 @@ static struct s3c_fb_driverdata s3c_fb_data_s5pv210 = {
 		.has_shadowcon	= 1,
 		.has_blendcon	= 1,
 		.has_clksel	= 1,
+		.has_fixvclk	= 1,
 	},
 	.win[0]	= &s3c_fb_data_s5p_wins[0],
 	.win[1]	= &s3c_fb_data_s5p_wins[1],
@@ -1897,6 +1918,7 @@ static struct s3c_fb_driverdata s3c_fb_data_exynos4 = {
 
 		.has_shadowcon	= 1,
 		.has_blendcon	= 1,
+		.has_fixvclk	= 1,
 	},
 	.win[0]	= &s3c_fb_data_s5p_wins[0],
 	.win[1]	= &s3c_fb_data_s5p_wins[1],
@@ -1962,6 +1984,7 @@ static struct s3c_fb_driverdata s3c_fb_data_s5p64x0 = {
 		},
 
 		.has_blendcon	= 1,
+		.has_fixvclk	= 1,
 	},
 	.win[0] = &s3c_fb_data_s5p_wins[0],
 	.win[1] = &s3c_fb_data_s5p_wins[1],
-- 
1.7.1


