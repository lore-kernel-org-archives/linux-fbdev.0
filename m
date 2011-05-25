From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 May 2011 22:58:12 +0000
Subject: [PATCH 20/29] s3c-fb: use display information in info not in var for panning
Message-Id: <1306364301-8195-21-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ondrej Zary <linux@rainbow-software.org>
---
 drivers/video/s3fb.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/video/s3fb.c b/drivers/video/s3fb.c
index c4482f2..a625e5a 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -894,12 +894,13 @@ static int s3fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
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
+			 (var->xoffset * info->var.bits_per_pixel / 8);
 		offset = offset >> 2;
 	}
 
-- 
1.7.3.4

