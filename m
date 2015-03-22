From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Sun, 22 Mar 2015 23:13:41 +0000
Subject: [PATCH 08/13] staging: sm750: comment formating
Message-Id: <20150322231340.GA17233@x230-arch.club.entropia.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes checkpatch.pl warnings / errors:

- "WARNING: please, no space before tabs"
- "ERROR: do not use C99 // comments"

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 54857ba..ab58987 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -74,19 +74,19 @@ static inline void myspin_unlock(spinlock_t *sl)
 		spin_unlock(sl);
 }
 static const struct fb_videomode lynx750_ext[] = {
-	/*  	1024x600-60 VESA 	[1.71:1]	*/
+	/*	1024x600-60 VESA	[1.71:1]*/
 	{NULL,  60, 1024, 600, 20423, 144,  40, 18, 1, 104, 3,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
-	/* 	1024x600-70 VESA */
+	/*	1024x600-70 VESA */
 	{NULL,  70, 1024, 600, 17211, 152,  48, 21, 1, 104, 3,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
-	/*  	1024x600-75 VESA */
+	/*	1024x600-75 VESA */
 	{NULL,  75, 1024, 600, 15822, 160,  56, 23, 1, 104, 3,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
-	/*  	1024x600-85 VESA */
+	/*	1024x600-85 VESA */
 	{NULL,  85, 1024, 600, 13730, 168,  56, 26, 1, 112, 3,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
@@ -98,7 +98,7 @@ static const struct fb_videomode lynx750_ext[] = {
 	{NULL, 60,  1280,  720,  13426, 162, 86, 22, 1,  136, 3,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
-	/* 1280x768@60 */
+	/*	1280x768@60 */
 	{NULL, 60, 1280, 768, 12579, 192, 64, 20, 3, 128, 7,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
@@ -113,7 +113,7 @@ static const struct fb_videomode lynx750_ext[] = {
 	{NULL, 60,  1368,  768,  11647, 216, 72, 23, 1,  144, 3,
 		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
-	/* 	1440 x 900		[16:10]	*/
+	/*	1440 x 900		[16:10]	*/
 	{NULL, 60, 1440, 900, 9392, 232, 80, 28, 1, 152, 3,
 		FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
@@ -610,7 +610,7 @@ static int lynxfb_ops_setcolreg(unsigned regno, unsigned red,
 	var = &info->var;
 	ret = 0;
 
-	//pr_debug("regno=%d,red=%d,green=%d,blue=%d\n",regno,red,green,blue);
+	/*pr_debug("regno=%d,red=%d,green=%d,blue=%d\n",regno,red,green,blue);*/
 	if (regno > 256) {
 		pr_err("regno = %d\n", regno);
 		return -EINVAL;
@@ -683,7 +683,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 	crtc->proc_panDisplay = hw_sm750_pan_display;
 	crtc->clear = hw_sm750_crtc_clear;
 	crtc->line_pad = 16;
-	//crtc->xpanstep = crtc->ypanstep = crtc->ywrapstep = 0;
+	/*crtc->xpanstep = crtc->ypanstep = crtc->ywrapstep = 0;*/
 	crtc->xpanstep = 8;
 	crtc->ypanstep = 1;
 	crtc->ywrapstep = 0;
@@ -858,7 +858,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 			break;
 		} else if (ret = 3) {
 			pr_warn("wanna use default mode\n");
-			//			break;
+			/*break;*/
 		} else if (ret = 4) {
 			pr_warn("fall back to any valid mode\n");
 		} else {
@@ -951,11 +951,11 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 
 exit:
 	lynxfb_ops_check_var(var, info);
-	//    lynxfb_ops_set_par(info);
+	/*	lynxfb_ops_set_par(info);*/
 	return ret;
 }
 
-/* 	chip specific g_option configuration routine */
+/*	chip specific g_option configuration routine */
 static void sm750fb_setup(struct lynx_share *share, char *src)
 {
 	struct sm750_share *spec_share;
@@ -1235,7 +1235,7 @@ static void __exit lynxfb_pci_remove(struct pci_dev *pdev)
 	if (share->mtrr.vram_added)
 		mtrr_del(share->mtrr.vram, share->vidmem_start, share->vidmem_size);
 #endif
-	//	pci_release_regions(pdev);
+	/*pci_release_regions(pdev);*/
 
 	iounmap(share->pvReg);
 	iounmap(share->pvMem);
@@ -1265,7 +1265,7 @@ static int __init lynxfb_setup(char *options)
 
 	tmp = g_settings;
 
-	/* 	Notes:
+	/*	Notes:
 		char * strsep(char **s,const char * ct);
 		@s: the string to be searched
 		@ct :the characters to search for
-- 
2.3.3

