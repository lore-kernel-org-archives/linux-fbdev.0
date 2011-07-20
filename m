From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 20 Jul 2011 11:24:29 +0000
Subject: [PATCH v2 6/6] fbdev: sh_mobile_lcdc: Restart LCDC in runtime PM resume handler
Message-Id: <1311161069-11918-7-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Instead of restoring registers blindly, restart the LCDC by going
through the startup sequence when resuming from runtime PM suspend. All
registers are now correctly initialized in the right order.

As a side effect, this also gets rid fo a possible panning restore issue
caused by always saving the frame buffer base address registers from set
A instead of the currently active set.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |   49 ++++----------------------------------
 drivers/video/sh_mobile_lcdcfb.h |    1 -
 2 files changed, 5 insertions(+), 45 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index f0a3d54..d0f768e 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -32,17 +32,6 @@
 #define SIDE_B_OFFSET 0x1000
 #define MIRROR_OFFSET 0x2000
 
-/* shared registers and their order for context save/restore */
-static int lcdc_shared_regs[] = {
-	_LDDCKR,
-	_LDDCKSTPR,
-	_LDINTR,
-	_LDDDSR,
-	_LDCNT1R,
-	_LDCNT2R,
-};
-#define NR_SHARED_REGS ARRAY_SIZE(lcdc_shared_regs)
-
 #define MAX_XRES 1920
 #define MAX_YRES 1080
 
@@ -111,7 +100,6 @@ struct sh_mobile_lcdc_priv {
 	unsigned long lddckr;
 	struct sh_mobile_lcdc_chan ch[2];
 	struct notifier_block notifier;
-	unsigned long saved_shared_regs[NR_SHARED_REGS];
 	int started;
 	int forced_bpp; /* 2 channel LCDC must share bpp setting */
 	struct sh_mobile_meram_info *meram_dev;
@@ -1289,47 +1277,20 @@ static int sh_mobile_lcdc_resume(struct device *dev)
 static int sh_mobile_lcdc_runtime_suspend(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_mobile_lcdc_priv *p = platform_get_drvdata(pdev);
-	struct sh_mobile_lcdc_chan *ch;
-	int k, n;
-
-	/* save per-channel registers */
-	for (k = 0; k < ARRAY_SIZE(p->ch); k++) {
-		ch = &p->ch[k];
-		if (!ch->enabled)
-			continue;
-		for (n = 0; n < NR_CH_REGS; n++)
-			ch->saved_ch_regs[n] = lcdc_read_chan(ch, n);
-	}
-
-	/* save shared registers */
-	for (n = 0; n < NR_SHARED_REGS; n++)
-		p->saved_shared_regs[n] = lcdc_read(p, lcdc_shared_regs[n]);
+	struct sh_mobile_lcdc_priv *priv = platform_get_drvdata(pdev);
 
 	/* turn off LCDC hardware */
-	lcdc_write(p, _LDCNT1R, 0);
+	lcdc_write(priv, _LDCNT1R, 0);
+
 	return 0;
 }
 
 static int sh_mobile_lcdc_runtime_resume(struct device *dev)
 {
 	struct platform_device *pdev = to_platform_device(dev);
-	struct sh_mobile_lcdc_priv *p = platform_get_drvdata(pdev);
-	struct sh_mobile_lcdc_chan *ch;
-	int k, n;
-
-	/* restore per-channel registers */
-	for (k = 0; k < ARRAY_SIZE(p->ch); k++) {
-		ch = &p->ch[k];
-		if (!ch->enabled)
-			continue;
-		for (n = 0; n < NR_CH_REGS; n++)
-			lcdc_write_chan(ch, n, ch->saved_ch_regs[n]);
-	}
+	struct sh_mobile_lcdc_priv *priv = platform_get_drvdata(pdev);
 
-	/* restore shared registers */
-	for (n = 0; n < NR_SHARED_REGS; n++)
-		lcdc_write(p, lcdc_shared_regs[n], p->saved_shared_regs[n]);
+	__sh_mobile_lcdc_start(priv);
 
 	return 0;
 }
diff --git a/drivers/video/sh_mobile_lcdcfb.h b/drivers/video/sh_mobile_lcdcfb.h
index a06219b..a58a0f3 100644
--- a/drivers/video/sh_mobile_lcdcfb.h
+++ b/drivers/video/sh_mobile_lcdcfb.h
@@ -32,7 +32,6 @@ struct sh_mobile_lcdc_chan {
 	unsigned long enabled; /* ME and SE in LDCNT2R */
 	struct sh_mobile_lcdc_chan_cfg cfg;
 	u32 pseudo_palette[PALETTE_NR];
-	unsigned long saved_ch_regs[NR_CH_REGS];
 	struct fb_info *info;
 	struct backlight_device *bl;
 	dma_addr_t dma_handle;
-- 
1.7.3.4

