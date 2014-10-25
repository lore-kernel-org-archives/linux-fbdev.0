From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 25 Oct 2014 13:28:47 +0000
Subject: [PATCH] fbdev: mxsfb: Add support for mx6sl and mx6sx
Message-Id: <1414243727-23447-1-git-send-email-festevam@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

mx6sl and mx6sx share the same LCD controller as mx23 and mx28.

Add support for it.

The basic difference is the number of clocks that are required:

- mx23/mx28: only one clock 
- mx6sl: two clocks
- mx6sx: three clocks

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since RFC:
- Simplified the clock handling as suggested by Tomi

 drivers/video/fbdev/Kconfig |  2 +-
 drivers/video/fbdev/mxsfb.c | 19 +++++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index c7bf606..025b439 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -2425,7 +2425,7 @@ config FB_JZ4740
 
 config FB_MXS
 	tristate "MXS LCD framebuffer support"
-	depends on FB && ARCH_MXS
+	depends on FB && (ARCH_MXS || ARCH_MXC)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
diff --git a/drivers/video/fbdev/mxsfb.c b/drivers/video/fbdev/mxsfb.c
index accf48a2..f8ac4a4 100644
--- a/drivers/video/fbdev/mxsfb.c
+++ b/drivers/video/fbdev/mxsfb.c
@@ -172,6 +172,8 @@ struct mxsfb_info {
 	struct fb_info fb_info;
 	struct platform_device *pdev;
 	struct clk *clk;
+	struct clk *clk_axi;
+	struct clk *clk_disp_axi;
 	void __iomem *base;	/* registers */
 	unsigned allocated_size;
 	int enabled;
@@ -331,6 +333,11 @@ static void mxsfb_enable_controller(struct fb_info *fb_info)
 		}
 	}
 
+	if (host->clk_axi)
+		clk_prepare_enable(host->clk_axi);
+
+	if (host->clk_disp_axi)
+		clk_prepare_enable(host->clk_disp_axi);
 	clk_prepare_enable(host->clk);
 	clk_set_rate(host->clk, PICOS2KHZ(fb_info->var.pixclock) * 1000U);
 
@@ -374,6 +381,10 @@ static void mxsfb_disable_controller(struct fb_info *fb_info)
 	writel(reg & ~VDCTRL4_SYNC_SIGNALS_ON, host->base + LCDC_VDCTRL4);
 
 	clk_disable_unprepare(host->clk);
+	if (host->clk_disp_axi)
+		clk_disable_unprepare(host->clk_disp_axi);
+	if (host->clk_axi)
+		clk_disable_unprepare(host->clk_axi);
 
 	host->enabled = 0;
 
@@ -867,6 +878,14 @@ static int mxsfb_probe(struct platform_device *pdev)
 		goto fb_release;
 	}
 
+	host->clk_axi = devm_clk_get(&host->pdev->dev, "axi");
+	if (IS_ERR(host->clk_axi))
+		host->clk_axi = NULL;
+
+	host->clk_disp_axi = devm_clk_get(&host->pdev->dev, "disp_axi");
+	if (IS_ERR(host->clk_disp_axi))
+		host->clk_disp_axi = NULL;
+
 	host->reg_lcd = devm_regulator_get(&pdev->dev, "lcd");
 	if (IS_ERR(host->reg_lcd))
 		host->reg_lcd = NULL;
-- 
1.9.1

