From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Sun, 22 Mar 2015 23:13:18 +0000
Subject: [PATCH 07/13] staging: sm750: no braces for single stmt if blocks
Message-Id: <20150322231318.GA17203@x230-arch.club.entropia.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patches fixes checkpatch.pl warning:
"WARNING: braces {} are not necessary for single statement blocks"

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index a0a8db7..54857ba 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -62,18 +62,16 @@ static inline void myspin_lock(spinlock_t *sl)
 {
 	struct lynx_share *share;
 	share = container_of(sl, struct lynx_share, slock);
-	if (share->dual) {
+	if (share->dual)
 		spin_lock(sl);
-	}
 }
 
 static inline void myspin_unlock(spinlock_t *sl)
 {
 	struct lynx_share *share;
 	share = container_of(sl, struct lynx_share, slock);
-	if (share->dual) {
+	if (share->dual)
 		spin_unlock(sl);
-	}
 }
 static const struct fb_videomode lynx750_ext[] = {
 	/*  	1024x600-60 VESA 	[1.71:1]	*/
@@ -149,9 +147,8 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	}
 
 	cursor->disable(cursor);
-	if (fbcursor->set & FB_CUR_SETSIZE) {
+	if (fbcursor->set & FB_CUR_SETSIZE)
 		cursor->setSize(cursor, fbcursor->image.width, fbcursor->image.height);
-	}
 
 	if (fbcursor->set & FB_CUR_SETPOS) {
 		cursor->setPos(cursor, fbcursor->image.dx - info->var.xoffset,
@@ -180,9 +177,8 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 				fbcursor->mask);
 	}
 
-	if (fbcursor->enable) {
+	if (fbcursor->enable)
 		cursor->enable(cursor);
-	}
 
 	return 0;
 }
@@ -194,9 +190,8 @@ static void lynxfb_ops_fillrect(struct fb_info *info, const struct fb_fillrect *
 	unsigned int base, pitch, Bpp, rop;
 	u32 color;
 
-	if (info->state != FBINFO_STATE_RUNNING) {
+	if (info->state != FBINFO_STATE_RUNNING)
 		return;
-	}
 
 	par = info->par;
 	share = par->share;
-- 
2.3.3

