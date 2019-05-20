From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Mon, 20 May 2019 08:21:50 +0000
Subject: [PATCH 07/33] fbdev/aty128fb: Remove dead code
Message-Id: <20190520082216.26273-8-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20190520082216.26273-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Intel Graphics Development <intel-gfx@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, Paul Mackerras <paulus@samba.org>, linux-fbdev@vger.kernel.org

Motivated because it contains a struct display, which is a fbcon
internal data structure that I want to rename. It seems to have been
formerly used in drivers, but that's very long time ago.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/fbdev/aty/aty128fb.c | 64 ------------------------------
 1 file changed, 64 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index 6cc46867ff57..c022ad7a49c2 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -2349,70 +2349,6 @@ static int aty128fb_ioctl(struct fb_info *info, u_int cmd, u_long arg)
 	return -EINVAL;
 }
 
-#if 0
-    /*
-     *  Accelerated functions
-     */
-
-static inline void aty128_rectcopy(int srcx, int srcy, int dstx, int dsty,
-				   u_int width, u_int height,
-				   struct fb_info_aty128 *par)
-{
-	u32 save_dp_datatype, save_dp_cntl, dstval;
-
-	if (!width || !height)
-		return;
-
-	dstval = depth_to_dst(par->current_par.crtc.depth);
-	if (dstval = DST_24BPP) {
-		srcx *= 3;
-		dstx *= 3;
-		width *= 3;
-	} else if (dstval = -EINVAL) {
-		printk("aty128fb: invalid depth or RGBA\n");
-		return;
-	}
-
-	wait_for_fifo(2, par);
-	save_dp_datatype = aty_ld_le32(DP_DATATYPE);
-	save_dp_cntl     = aty_ld_le32(DP_CNTL);
-
-	wait_for_fifo(6, par);
-	aty_st_le32(SRC_Y_X, (srcy << 16) | srcx);
-	aty_st_le32(DP_MIX, ROP3_SRCCOPY | DP_SRC_RECT);
-	aty_st_le32(DP_CNTL, DST_X_LEFT_TO_RIGHT | DST_Y_TOP_TO_BOTTOM);
-	aty_st_le32(DP_DATATYPE, save_dp_datatype | dstval | SRC_DSTCOLOR);
-
-	aty_st_le32(DST_Y_X, (dsty << 16) | dstx);
-	aty_st_le32(DST_HEIGHT_WIDTH, (height << 16) | width);
-
-	par->blitter_may_be_busy = 1;
-
-	wait_for_fifo(2, par);
-	aty_st_le32(DP_DATATYPE, save_dp_datatype);
-	aty_st_le32(DP_CNTL, save_dp_cntl);
-}
-
-
-    /*
-     * Text mode accelerated functions
-     */
-
-static void fbcon_aty128_bmove(struct display *p, int sy, int sx, int dy,
-			       int dx, int height, int width)
-{
-	sx     *= fontwidth(p);
-	sy     *= fontheight(p);
-	dx     *= fontwidth(p);
-	dy     *= fontheight(p);
-	width  *= fontwidth(p);
-	height *= fontheight(p);
-
-	aty128_rectcopy(sx, sy, dx, dy, width, height,
-			(struct fb_info_aty128 *)p->fb_info);
-}
-#endif /* 0 */
-
 static void aty128_set_suspend(struct aty128fb_par *par, int suspend)
 {
 	u32	pmgt;
-- 
2.20.1
