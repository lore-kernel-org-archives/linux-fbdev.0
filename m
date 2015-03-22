From: Michel von Czettritz <michel.von.czettritz@gmail.com>
Date: Sun, 22 Mar 2015 23:14:42 +0000
Subject: [PATCH 12/13] staging: sm750: fix whitspace for cast to pointer
Message-Id: <20150322231441.GA17306@x230-arch.club.entropia.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes the checkpatch.pl warning:
'ERROR: "(foo*)" should be "(foo *)"'

Signed-off-by: Michel von Czettritz <michel.von.czettritz@gmail.com>
---
 drivers/staging/sm750fb/sm750.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 917e4b4..c250882 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -220,7 +220,7 @@ static void lynxfb_ops_fillrect(struct fb_info *info,
 	pitch = info->fix.line_length;
 	Bpp = info->var.bits_per_pixel >> 3;
 
-	color = (Bpp = 1)?region->color:((u32*)info->pseudo_palette)[region->color];
+	color = (Bpp = 1)?region->color:((u32 *)info->pseudo_palette)[region->color];
 	rop = (region->rop != ROP_COPY) ? HW_ROP2_XOR:HW_ROP2_COPY;
 
 	myspin_lock(&share->slock);
@@ -275,8 +275,8 @@ static void lynxfb_ops_imageblit(struct fb_info *info,
 	if (image->depth = 1) {
 		if (info->fix.visual = FB_VISUAL_TRUECOLOR ||
 				info->fix.visual = FB_VISUAL_DIRECTCOLOR) {
-			fgcol = ((u32*)info->pseudo_palette)[image->fg_color];
-			bgcol = ((u32*)info->pseudo_palette)[image->bg_color];
+			fgcol = ((u32 *)info->pseudo_palette)[image->fg_color];
+			bgcol = ((u32 *)info->pseudo_palette)[image->bg_color];
 		} else {
 			fgcol = image->fg_color;
 			bgcol = image->bg_color;
-- 
2.3.3

