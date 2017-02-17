From: Joe Perches <joe@perches.com>
Date: Fri, 17 Feb 2017 07:11:45 +0000
Subject: [PATCH 32/35] drivers/video: Convert remaining uses of pr_warning to pr_warn
Message-Id: <e216f8cba5b81587b0c8300e9384e8efc12aa22b.1487314667.git.joe@perches.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1487314666.git.joe@perches.com>
In-Reply-To: <cover.1487314666.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

To enable eventual removal of pr_warning

This makes pr_warn use consistent for drivers/video

Prior to this patch, there were 6 uses of pr_warning and
25 uses of pr_warn in drivers/video

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/video/fbdev/aty/radeon_base.c | 4 ++--
 drivers/video/fbdev/core/fbmon.c      | 4 ++--
 drivers/video/fbdev/pxafb.c           | 7 +++----
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 218339a4edaa..6b4c7872b375 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -2453,8 +2453,8 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 		err |= sysfs_create_bin_file(&rinfo->pdev->dev.kobj,
 						&edid2_attr);
 	if (err)
-		pr_warning("%s() Creating sysfs files failed, continuing\n",
-			   __func__);
+		pr_warn("%s() Creating sysfs files failed, continuing\n",
+			__func__);
 
 	/* save current mode regs before we switch into the new one
 	 * so we can restore this upon __exit
diff --git a/drivers/video/fbdev/core/fbmon.c b/drivers/video/fbdev/core/fbmon.c
index 62c0cf79674f..687ebb053438 100644
--- a/drivers/video/fbdev/core/fbmon.c
+++ b/drivers/video/fbdev/core/fbmon.c
@@ -1073,9 +1073,9 @@ void fb_edid_add_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 	for (i = specs->modedb_len + num; i < specs->modedb_len + num + svd_n; i++) {
 		int idx = svd[i - specs->modedb_len - num];
 		if (!idx || idx >= ARRAY_SIZE(cea_modes)) {
-			pr_warning("Reserved SVD code %d\n", idx);
+			pr_warn("Reserved SVD code %d\n", idx);
 		} else if (!cea_modes[idx].xres) {
-			pr_warning("Unimplemented SVD code %d\n", idx);
+			pr_warn("Unimplemented SVD code %d\n", idx);
 		} else {
 			memcpy(&m[i], cea_modes + idx, sizeof(m[i]));
 			pr_debug("Adding SVD #%d: %ux%u@%u\n", idx,
diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index ef73f14d7ba0..b21a89b03fb4 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -645,7 +645,7 @@ static void overlay1fb_disable(struct pxafb_layer *ofb)
 	lcd_writel(ofb->fbi, FBR1, ofb->fbi->fdadr[DMA_OV1] | 0x3);
 
 	if (wait_for_completion_timeout(&ofb->branch_done, 1 * HZ) = 0)
-		pr_warning("%s: timeout disabling overlay1\n", __func__);
+		pr_warn("%s: timeout disabling overlay1\n", __func__);
 
 	lcd_writel(ofb->fbi, LCCR5, lccr5);
 }
@@ -710,7 +710,7 @@ static void overlay2fb_disable(struct pxafb_layer *ofb)
 	lcd_writel(ofb->fbi, FBR4, ofb->fbi->fdadr[DMA_OV2_Cr] | 0x3);
 
 	if (wait_for_completion_timeout(&ofb->branch_done, 1 * HZ) = 0)
-		pr_warning("%s: timeout disabling overlay2\n", __func__);
+		pr_warn("%s: timeout disabling overlay2\n", __func__);
 }
 
 static struct pxafb_layer_ops ofb_ops[] = {
@@ -1187,8 +1187,7 @@ int pxafb_smart_flush(struct fb_info *info)
 	lcd_writel(fbi, LCCR0, fbi->reg_lccr0 | LCCR0_ENB);
 
 	if (wait_for_completion_timeout(&fbi->command_done, HZ/2) = 0) {
-		pr_warning("%s: timeout waiting for command done\n",
-				__func__);
+		pr_warn("%s: timeout waiting for command done\n", __func__);
 		ret = -ETIMEDOUT;
 	}
 
-- 
2.10.0.rc2.1.g053435c

