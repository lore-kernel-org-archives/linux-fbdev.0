From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 14 Jun 2011 09:24:58 +0000
Subject: [PATCH v2 20/29] s3fb: use display information in info not in var for panning
Message-Id: <1308043507-11083-21-git-send-email-laurent.pinchart@ideasonboard.com>
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
index 4ca5d0c..0f9af1a 100644
--- a/drivers/video/s3fb.c
+++ b/drivers/video/s3fb.c
@@ -1019,12 +1019,13 @@ static int s3fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
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

