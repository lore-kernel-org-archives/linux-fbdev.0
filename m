From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Thu, 26 Mar 2015 22:25:50 +0000
Subject: [PATCH v2 06/12] staging: sm750: no braces for single stmt if blocks
Message-Id: <9b7d1ab21e735024fec2d2586fb1e0550eaa6369.1427406762.git.michel.von.czettritz@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patches fixes checkpatch.pl warning:
"WARNING: braces {} are not necessary for single statement blocks"

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index d9a94d7..5d3ee44 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -131,9 +131,8 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	}
 
 	cursor->disable(cursor);
-	if (fbcursor->set & FB_CUR_SETSIZE) {
+	if (fbcursor->set & FB_CUR_SETSIZE)
 		cursor->setSize(cursor, fbcursor->image.width, fbcursor->image.height);
-	}
 
 	if (fbcursor->set & FB_CUR_SETPOS) {
 		cursor->setPos(cursor, fbcursor->image.dx - info->var.xoffset,
@@ -162,9 +161,8 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 				fbcursor->mask);
 	}
 
-	if (fbcursor->enable) {
+	if (fbcursor->enable)
 		cursor->enable(cursor);
-	}
 
 	return 0;
 }
@@ -176,9 +174,8 @@ static void lynxfb_ops_fillrect(struct fb_info *info, const struct fb_fillrect *
 	unsigned int base, pitch, Bpp, rop;
 	u32 color;
 
-	if (info->state != FBINFO_STATE_RUNNING) {
+	if (info->state != FBINFO_STATE_RUNNING)
 		return;
-	}
 
 	par = info->par;
 	share = par->share;
@@ -487,8 +484,8 @@ static int lynxfb_resume(struct pci_dev *pdev)
 		par = info->par;
 		crtc = &par->crtc;
 		cursor = &crtc->cursor;
-		memset_io(cursor->vstart, 0x0, cursor->size);
-		memset_io(crtc->vScreen, 0x0, crtc->vidmem_size);
+		memset(cursor->vstart, 0x0, cursor->size);
+		memset(crtc->vScreen, 0x0, crtc->vidmem_size);
 		lynxfb_ops_set_par(info);
 		fb_set_suspend(info, 0);
 	}
-- 
2.3.3

