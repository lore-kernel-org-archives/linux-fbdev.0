From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 14 Jun 2011 09:24:42 +0000
Subject: [PATCH v2 04/29] arkfb: use display information in info not in var for panning
Message-Id: <1308043507-11083-5-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ondrej Zajicek <santiago@crfreenet.org>
---
 drivers/video/arkfb.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/arkfb.c b/drivers/video/arkfb.c
index 8686429..555dd4c 100644
--- a/drivers/video/arkfb.c
+++ b/drivers/video/arkfb.c
@@ -908,13 +908,14 @@ static int arkfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info
 	unsigned int offset;
 
 	/* Calculate the offset */
-	if (var->bits_per_pixel = 0) {
-		offset = (var->yoffset / 16) * (var->xres_virtual / 2) + (var->xoffset / 2);
+	if (info->var.bits_per_pixel = 0) {
+		offset = (var->yoffset / 16) * (info->var.xres_virtual / 2)
+		       + (var->xoffset / 2);
 		offset = offset >> 2;
 	} else {
 		offset = (var->yoffset * info->fix.line_length) +
-			 (var->xoffset * var->bits_per_pixel / 8);
-		offset = offset >> ((var->bits_per_pixel = 4) ? 2 : 3);
+			 (var->xoffset * info->var.bits_per_pixel / 8);
+		offset = offset >> ((info->var.bits_per_pixel = 4) ? 2 : 3);
 	}
 
 	/* Set the offset */
-- 
1.7.3.4

