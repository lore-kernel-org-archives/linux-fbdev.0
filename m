From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Sun, 22 Mar 2015 23:14:17 +0000
Subject: [PATCH 10/13] staging: sm750: blank line after declaration
Message-Id: <20150322231416.GA17270@x230-arch.club.entropia.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes "WARNING: Missing a blank line after declaration"
checkpatch.pl warnings.

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 90dc801..870bf6f 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -61,6 +61,7 @@ static char *g_option = NULL;
 static inline void myspin_lock(spinlock_t *sl)
 {
 	struct lynx_share *share;
+	
 	share = container_of(sl, struct lynx_share, slock);
 	if (share->dual)
 		spin_lock(sl);
@@ -69,6 +70,7 @@ static inline void myspin_lock(spinlock_t *sl)
 static inline void myspin_unlock(spinlock_t *sl)
 {
 	struct lynx_share *share;
+	
 	share = container_of(sl, struct lynx_share, slock);
 	if (share->dual)
 		spin_unlock(sl);
@@ -172,6 +174,7 @@ static int lynxfb_ops_cursor(struct fb_info *info, struct fb_cursor *fbcursor)
 	if (fbcursor->set & FB_CUR_SETCMAP) {
 		/* get the 16bit color of kernel means */
 		u16 fg, bg;
+		
 		fg = ((info->cmap.red[fbcursor->image.fg_color] & 0xf800))|
 			((info->cmap.green[fbcursor->image.fg_color] & 0xfc00) >> 5)|
 			((info->cmap.blue[fbcursor->image.fg_color] & 0xf800) >> 11);
@@ -650,6 +653,7 @@ static int lynxfb_ops_setcolreg(unsigned regno, unsigned red,
 
 	if (info->fix.visual = FB_VISUAL_TRUECOLOR && regno < 256) {
 		u32 val;
+		
 		if (var->bits_per_pixel = 16 ||
 				var->bits_per_pixel = 32 ||
 				var->bits_per_pixel = 24) {
@@ -1187,6 +1191,7 @@ ALLOC_FB:
 	} else {
 		struct lynxfb_par *par;
 		int errno;
+		
 		pr_info("framebuffer #%d alloc okay\n", fbidx);
 		share->fbinfo[fbidx] = info[fbidx];
 		par = info[fbidx]->par;
-- 
2.3.3

