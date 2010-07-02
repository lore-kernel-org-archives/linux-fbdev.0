From: Martin Fuzzey <mfuzzey@gmail.com>
Date: Fri, 02 Jul 2010 14:38:29 +0000
Subject: [PATCH] IMX framebuffer: Prevent clock being disabled multiple times
Message-Id: <20100702143828.26700.45721.stgit@srv002.fuzzey.net>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

When multiple successive types of blanking are used
(such as FB_BLANK_VSYNC_SUSPEND followed by FB_BLANK_POWERDOWN)
clk_disable() is called multiple times which causes a WARN
but more importantly the reference count to become negative
resulting in multiple unblank operations being required to
restore the display.

Furthermore the call to clk_disable() in imxfb_remove() is
unnecessary since it is already done by imxfb_disable_controller()

Signed-off-by: Martin Fuzzey <mfuzzey@gmail.com>

---

 drivers/video/imxfb.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/drivers/video/imxfb.c b/drivers/video/imxfb.c
index b4b6dec..d0771d0 100644
--- a/drivers/video/imxfb.c
+++ b/drivers/video/imxfb.c
@@ -175,6 +175,7 @@ struct imxfb_info {
 
 	struct imx_fb_videomode *mode;
 	int			num_modes;
+	bool			enabled;
 
 	void (*lcd_power)(int);
 	void (*backlight_power)(int);
@@ -451,6 +452,9 @@ static int imxfb_set_par(struct fb_info *info)
 
 static void imxfb_enable_controller(struct imxfb_info *fbi)
 {
+	if (fbi->enabled)
+		return;
+
 	pr_debug("Enabling LCD controller\n");
 
 	writel(fbi->screen_dma, fbi->regs + LCDC_SSA);
@@ -470,10 +474,13 @@ static void imxfb_enable_controller(struct imxfb_info *fbi)
 		fbi->backlight_power(1);
 	if (fbi->lcd_power)
 		fbi->lcd_power(1);
+	fbi->enabled = 1;
 }
 
 static void imxfb_disable_controller(struct imxfb_info *fbi)
 {
+	if (!fbi->enabled)
+		return;
 	pr_debug("Disabling LCD controller\n");
 
 	if (fbi->backlight_power)
@@ -484,6 +491,7 @@ static void imxfb_disable_controller(struct imxfb_info *fbi)
 	clk_disable(fbi->clk);
 
 	writel(0, fbi->regs + LCDC_RMCR);
+	fbi->enabled = 0;
 }
 
 static int imxfb_blank(int blank, struct fb_info *info)
@@ -828,7 +836,6 @@ static int __devexit imxfb_remove(struct platform_device *pdev)
 
 	iounmap(fbi->regs);
 	release_mem_region(res->start, resource_size(res));
-	clk_disable(fbi->clk);
 	clk_put(fbi->clk);
 
 	platform_set_drvdata(pdev, NULL);

