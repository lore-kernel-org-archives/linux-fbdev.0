From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Mon, 26 Jun 2017 22:05:18 +0000
Subject: [PATCH] video: fbdev: aty: remove useless variable assignments in aty_var_to_crtc()
Message-Id: <20170626220518.GA9369@embeddedgus>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>

Value assigned to variable vdisplay at line 990 is overwritten
at line 1039 before it can be used. Also, variable assignment
at line 987 is the same as at line 1039. This makes such
variable assignments useless.

Remove these variable assignments and the code related.

Addresses-Covertity-ID: 1226900
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/video/fbdev/aty/atyfb_base.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 11026e7..3142d7f 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -984,12 +984,6 @@ static int aty_var_to_crtc(const struct fb_info *info,
 		v_total <<= 1;
 	}
 
-	vdisplay = yres;
-#ifdef CONFIG_FB_ATY_GENERIC_LCD
-	if ((par->lcd_table != 0) && (crtc->lcd_gen_cntl & LCD_ON))
-		vdisplay  = par->lcd_height;
-#endif
-
 	v_disp--;
 	v_sync_strt--;
 	v_sync_end--;
-- 
2.5.0

