From: Fabio Estevam <fabio.estevam@freescale.com>
Date: Tue, 19 Aug 2014 18:23:07 +0000
Subject: [RFC] fbdev: mxsfb: Add support for mx6sl and mx6sx
Message-Id: <1408472587-4998-1-git-send-email-fabio.estevam@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

mx6sl and mx6sx share the same LCD controller as mx23 and mx28.

Add support for it.

The basic difference is the number of clocks that are required:

- mx23/mx28: only one clock
- mx6sl: two clocks
- mx6sx: three clocks

Tested on a mx28evk and mx6slevk.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
I am sending it as RFC because the scrolling is showing some artifacts when
I boot with console=tty0. The kernel messages are displayed correctly, but when
it scrolls I see some garbage.

Appreciate any comment/suggestion to improve this.

 drivers/video/fbdev/Kconfig |  2 +-
 drivers/video/fbdev/mxsfb.c | 47 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index e911b9c..fd28987 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2420,7 +2420,7 @@ config FB_JZ4740
 
 config FB_MXS
 	tristate "MXS LCD framebuffer support"
-	depends on FB && ARCH_MXS
+	depends on FB && (ARCH_MXS || ARCH_MXC)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
index accf48a2..a567cc6 100644
--- a/drivers/video/fbdev/mxsfb.c
+++ b/drivers/video/fbdev/mxsfb.c
@@ -172,6 +172,10 @@ struct mxsfb_info {
 	struct fb_info fb_info;
 	struct platform_device *pdev;
 	struct clk *clk;
+	struct clk *clk_axi;
+	struct clk *clk_disp_axi;
+	bool clk_axi_enabled;
+	bool clk_disp_axi_enabled;
 	void __iomem *base;	/* registers */
 	unsigned allocated_size;
 	int enabled;
@@ -185,6 +189,42 @@ struct mxsfb_info {
 #define mxsfb_is_v3(host) (host->devdata->ipversion = 3)
 #define mxsfb_is_v4(host) (host->devdata->ipversion = 4)
 
+/* Enable lcdif axi clock */
+static inline void clk_enable_axi(struct mxsfb_info *host)
+{
+	if (!host->clk_axi_enabled && (!IS_ERR(host->clk_axi))) {
+		clk_prepare_enable(host->clk_axi);
+		host->clk_axi_enabled = true;
+	}
+}
+
+/* Disable lcdif axi clock */
+static inline void clk_disable_axi(struct mxsfb_info *host)
+{
+	if (host->clk_axi_enabled && (!IS_ERR(host->clk_axi))) {
+		clk_disable_unprepare(host->clk_axi);
+		host->clk_axi_enabled = false;
+	}
+}
+
+/* Enable DISP axi clock */
+static inline void clk_enable_disp_axi(struct mxsfb_info *host)
+{
+	if (!host->clk_disp_axi_enabled && (!IS_ERR(host->clk_disp_axi))) {
+		clk_prepare_enable(host->clk_disp_axi);
+		host->clk_disp_axi_enabled = true;
+	}
+}
+
+/* Disable DISP axi clock */
+static inline void clk_disable_disp_axi(struct mxsfb_info *host)
+{
+	if (host->clk_disp_axi_enabled && (!IS_ERR(host->clk_disp_axi))) {
+		clk_disable_unprepare(host->clk_disp_axi);
+		host->clk_disp_axi_enabled = false;
+	}
+}
+
 static const struct mxsfb_devdata mxsfb_devdata[] = {
 	[MXSFB_V3] = {
 		.transfer_count = LCDC_V3_TRANSFER_COUNT,
@@ -331,6 +371,8 @@ static void mxsfb_enable_controller(struct fb_info *fb_info)
 		}
 	}
 
+	clk_enable_axi(host);
+	clk_enable_disp_axi(host);
 	clk_prepare_enable(host->clk);
 	clk_set_rate(host->clk, PICOS2KHZ(fb_info->var.pixclock) * 1000U);
 
@@ -374,6 +416,8 @@ static void mxsfb_disable_controller(struct fb_info *fb_info)
 	writel(reg & ~VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4);
 
 	clk_disable_unprepare(host->clk);
+	clk_disable_disp_axi(host);
+	clk_disable_axi(host);
 
 	host->enabled = 0;
 
@@ -867,6 +911,9 @@ static int mxsfb_probe(struct platform_device *pdev)
 		goto fb_release;
 	}
 
+	host->clk_axi = devm_clk_get(&host->pdev->dev, "axi");
+	host->clk_disp_axi = devm_clk_get(&host->pdev->dev, "disp_axi");
+
 	host->reg_lcd = devm_regulator_get(&pdev->dev, "lcd");
 	if (IS_ERR(host->reg_lcd))
 		host->reg_lcd = NULL;
-- 
1.9.1

