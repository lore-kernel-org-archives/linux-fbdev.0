From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Thu, 26 Mar 2015 22:26:04 +0000
Subject: [PATCH v2 07/12] staging: sm750: comment formating
Message-Id: <d09fcd9489d2785be313b0618b90e77d6a9a0113.1427406762.git.michel.von.czettritz@gmail.com>
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

v2:
* leaving space before */
* remove commented out code
---
 drivers/staging/sm750fb/sm750.c | 42 +++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 5d3ee44..e4cf08c 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -58,19 +58,19 @@ static char *g_option = NULL;
 
 
 static const struct fb_videomode lynx750_ext[] = {
-	/*  	1024x600-60 VESA 	[1.71:1]	*/
+	/*	1024x600-60 VESA	[1.71:1] */
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
 
@@ -82,7 +82,7 @@ static const struct fb_videomode lynx750_ext[] = {
 	{NULL, 60,  1280,  720,  13426, 162, 86, 22, 1,  136, 3,
 	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
-	/* 1280x768@60 */
+	/*	1280x768@60 */
 	{NULL, 60, 1280, 768, 12579, 192, 64, 20, 3, 128, 7,
 	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,FB_VMODE_NONINTERLACED},
 
@@ -97,7 +97,7 @@ static const struct fb_videomode lynx750_ext[] = {
 	{NULL, 60,  1368,  768,  11647, 216, 72, 23, 1,  144, 3,
 	 FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
-	/* 	1440 x 900		[16:10]	*/
+	/*	1440 x 900		[16:10]	*/
 	{NULL, 60, 1440, 900, 9392, 232, 80, 28, 1, 152, 3,
 	 FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED},
 
@@ -411,11 +411,11 @@ static int lynxfb_suspend(struct pci_dev *pdev, pm_message_t mesg)
 	if (mesg.event & PM_EVENT_SLEEP) {
 		info = share->fbinfo[0];
 		if (info)
-			/* 1 means do suspend*/
+			/* 1 means do suspend */
 			fb_set_suspend(info, 1);
 		info = share->fbinfo[1];
 		if (info)
-			/* 1 means do suspend*/
+			/* 1 means do suspend */
 			fb_set_suspend(info, 1);
 
 		ret = pci_save_state(pdev);
@@ -424,7 +424,7 @@ static int lynxfb_suspend(struct pci_dev *pdev, pm_message_t mesg)
 			return ret;
 		}
 
-		/* set chip to sleep mode*/
+		/* set chip to sleep mode */
 		if (share->suspend)
 			(*share->suspend)(share);
 
@@ -580,7 +580,7 @@ static int lynxfb_ops_check_var(struct fb_var_screeninfo *var, struct fb_info *i
 		break;
 	}
 	var->height = var->width = -1;
-	var->accel_flags = 0;/*FB_ACCELF_TEXT;*/
+	var->accel_flags = 0;/* FB_ACCELF_TEXT; */
 
 	/* check if current fb's video memory big enought to hold the onscreen */
 	request = var->xres_virtual * (var->bits_per_pixel >> 3);
@@ -615,7 +615,6 @@ static int lynxfb_ops_setcolreg(unsigned regno, unsigned red,
 	var = &info->var;
 	ret = 0;
 
-	//pr_debug("regno=%d,red=%d,green=%d,blue=%d\n",regno,red,green,blue);
 	if (regno > 256) {
 		pr_err("regno = %d\n", regno);
 		return -EINVAL;
@@ -688,7 +687,6 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 	crtc->proc_panDisplay = hw_sm750_pan_display;
 	crtc->clear = hw_sm750_crtc_clear;
 	crtc->line_pad = 16;
-	//crtc->xpanstep = crtc->ypanstep = crtc->ywrapstep = 0;
 	crtc->xpanstep = 8;
 	crtc->ypanstep = 1;
 	crtc->ywrapstep = 0;
@@ -723,7 +721,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_secondary;
-			/* not consider of padding stuffs for oScreen,need fix*/
+			/* not consider of padding stuffs for oScreen,need fix */
 			crtc->oScreen = (share->vidmem_size >> 1);
 			crtc->vScreen = share->pvMem + crtc->oScreen;
 		}
@@ -737,7 +735,7 @@ static int sm750fb_set_drv(struct lynxfb_par *par)
 		} else {
 			output->paths = sm750_crt;
 			crtc->channel = sm750_primary;
-			/* not consider of padding stuffs for oScreen,need fix*/
+			/* not consider of padding stuffs for oScreen,need fix */
 			crtc->oScreen = (share->vidmem_size >> 1);
 			crtc->vScreen = share->pvMem + crtc->oScreen;
 		}
@@ -863,7 +861,7 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 			break;
 		} else if (ret = 3) {
 			pr_warn("wanna use default mode\n");
-			//			break;
+			/*break;*/
 		} else if (ret = 4) {
 			pr_warn("fall back to any valid mode\n");
 		} else {
@@ -956,7 +954,6 @@ static int lynxfb_set_fbinfo(struct fb_info *info, int index)
 
 exit:
 	lynxfb_ops_check_var(var, info);
-	//    lynxfb_ops_set_par(info);
 	return ret;
 }
 
@@ -984,7 +981,7 @@ static void sm750fb_setup(struct lynx_share *share, char *src)
 	spec_share->state.initParm.setAllEngOff = 0;
 	spec_share->state.initParm.resetMemory = 1;
 
-	/*defaultly turn g_hwcursor on for both view */
+	/* defaultly turn g_hwcursor on for both view */
 	g_hwcursor = 3;
 
 	if (!src || !*src) {
@@ -1030,7 +1027,7 @@ static void sm750fb_setup(struct lynx_share *share, char *src)
 	}
 #ifdef CAP_EXPANSION
 	if (getExpRes(exp_res, &spec_share->state.xLCD, &spec_share->state.yLCD)) {
-		/* seems exp_res is not valid*/
+		/* seems exp_res is not valid */
 		spec_share->state.xLCD = spec_share->state.yLCD = 0;
 	}
 #endif
@@ -1051,7 +1048,7 @@ NO_PARAM:
 	} else {
 		/* SM750LE only have one crt channel */
 		spec_share->state.dataflow = sm750_simul_sec;
-		/* sm750le do not have complex attributes*/
+		/* sm750le do not have complex attributes */
 		spec_share->state.nocrt = 0;
 	}
 }
@@ -1176,7 +1173,7 @@ ALLOC_FB:
 				goto err_info1_set;
 		}
 
-		/* register frame buffer*/
+		/* register frame buffer */
 		pr_info("Ready to register framebuffer #%d.\n", fbidx);
 		errno = register_framebuffer(info[fbidx]);
 		if (errno < 0) {
@@ -1230,17 +1227,16 @@ static void __exit lynxfb_pci_remove(struct pci_dev *pdev)
 		par = info->par;
 
 		unregister_framebuffer(info);
-		/* clean crtc & output allocations*/
+		/* clean crtc & output allocations */
 		par->crtc.clear(&par->crtc);
 		par->output.clear(&par->output);
-		/* release frame buffer*/
+		/* release frame buffer */
 		framebuffer_release(info);
 	}
 #ifdef CONFIG_MTRR
 	if (share->mtrr.vram_added)
 		mtrr_del(share->mtrr.vram, share->vidmem_start, share->vidmem_size);
 #endif
-	//	pci_release_regions(pdev);
 
 	iounmap(share->pvReg);
 	iounmap(share->pvMem);
-- 
2.3.3

