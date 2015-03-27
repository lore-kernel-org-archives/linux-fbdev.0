From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Fri, 27 Mar 2015 18:42:48 +0000
Subject: [PATCH v3 06/11] staging: sm750: no braces for single stmt if blocks
Message-Id: <18b0d0362209fa2607d3bea2f642a0ec68feb98a.1427481390.git.michel.von.czettritz@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patches fixes checkpatch.pl warning:
"WARNING: braces {} are not necessary for single statement blocks"

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---
v3: fix wrong merging
---
 drivers/staging/sm750fb/sm750.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index d9a94d7..786679d 100644
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
-- 
2.3.3

