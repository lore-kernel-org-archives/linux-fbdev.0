From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 10 Jul 2017 11:12:46 +0000
Subject: [PATCH] atyfb: hide unused variable
Message-Id: <20170710111312.747154-1-arnd@arndb.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Arnd Bergmann <arnd@arndb.de>, "Gustavo A. R. Silva" <garsilva@embeddedor.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org

The vdisplay variable is now only accessed inside of an #ifdef, producing
a harmless warning:

drivers/video/fbdev/aty/atyfb_base.c: In function 'aty_var_to_crtc':
drivers/video/fbdev/aty/atyfb_base.c:805:19: error: unused variable 'vdisplay' [-Werror=unused-variable]

This moves the declaration into the ifdef as well.

Fixes: dd7d958ae912 ("video: fbdev: aty: remove useless variable assignments in aty_var_to_crtc()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/video/fbdev/aty/atyfb_base.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index ae5535ca3496..18c9b1467197 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -802,7 +802,7 @@ static int aty_var_to_crtc(const struct fb_info *info,
 {
 	struct atyfb_par *par = (struct atyfb_par *) info->par;
 	u32 xres, yres, vxres, vyres, xoffset, yoffset, bpp;
-	u32 sync, vmode, vdisplay;
+	u32 sync, vmode;
 	u32 h_total, h_disp, h_sync_strt, h_sync_end, h_sync_dly, h_sync_wid, h_sync_pol;
 	u32 v_total, v_disp, v_sync_strt, v_sync_end, v_sync_wid, v_sync_pol, c_sync;
 	u32 pix_width, dp_pix_width, dp_chain_mask;
@@ -1030,7 +1030,7 @@ static int aty_var_to_crtc(const struct fb_info *info,
 		crtc->gen_cntl |= CRTC_INTERLACE_EN;
 #ifdef CONFIG_FB_ATY_GENERIC_LCD
 	if (par->lcd_table != 0) {
-		vdisplay = yres;
+		u32 vdisplay = yres;
 		if (vmode & FB_VMODE_DOUBLE)
 			vdisplay <<= 1;
 		crtc->gen_cntl &= ~(CRTC2_EN | CRTC2_PIX_WIDTH);
-- 
2.9.0

