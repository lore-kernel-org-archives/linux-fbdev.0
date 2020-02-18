From: Souptick Joarder <jrdr.linux@gmail.com>
Date: Tue, 18 Feb 2020 16:27:56 +0000
Subject: [PATCH] video: fbdev: radeon: Remove dead code
Message-Id: <1582042556-21555-1-git-send-email-jrdr.linux@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: benh@kernel.crashing.org, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Souptick Joarder <jrdr.linux@gmail.com>

This is dead code since 3.15 and can be removed if not
going to be useful further.

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 drivers/video/fbdev/aty/radeon_base.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 3af00e3..ccf888e 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -849,12 +849,6 @@ static int radeonfb_check_var (struct fb_var_screeninfo *var, struct fb_info *in
 		case 9 ... 16:
 			v.bits_per_pixel = 16;
 			break;
-		case 17 ... 24:
-#if 0 /* Doesn't seem to work */
-			v.bits_per_pixel = 24;
-			break;
-#endif			
-			return -EINVAL;
 		case 25 ... 32:
 			v.bits_per_pixel = 32;
 			break;
@@ -2548,16 +2542,6 @@ static void radeonfb_pci_unregister(struct pci_dev *pdev)
 	if (rinfo->mon2_EDID)
 		sysfs_remove_bin_file(&rinfo->pdev->dev.kobj, &edid2_attr);
 
-#if 0
-	/* restore original state
-	 * 
-	 * Doesn't quite work yet, I suspect if we come from a legacy
-	 * VGA mode (or worse, text mode), we need to do some VGA black
-	 * magic here that I know nothing about. --BenH
-	 */
-        radeon_write_mode (rinfo, &rinfo->init_state, 1);
- #endif
-
 	del_timer_sync(&rinfo->lvds_timer);
 	arch_phys_wc_del(rinfo->wc_cookie);
         unregister_framebuffer(info);
-- 
1.9.1
