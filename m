From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 May 2011 22:58:20 +0000
Subject: [PATCH 28/29] vt8623fb: use display information in info not in var for panning
Message-Id: <1306364301-8195-29-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ondrej Zajicek <santiago@crfreenet.org>
Cc: David S. Miller <davem@davemloft.net>
---
 drivers/video/vt8623fb.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/video/vt8623fb.c b/drivers/video/vt8623fb.c
index f9b3e3d..4e74d26 100644
--- a/drivers/video/vt8623fb.c
+++ b/drivers/video/vt8623fb.c
@@ -620,13 +620,14 @@ static int vt8623fb_pan_display(struct fb_var_screeninfo *var, struct fb_info *i
 	unsigned int offset;
 
 	/* Calculate the offset */
-	if (var->bits_per_pixel = 0) {
-		offset = (var->yoffset / 16) * var->xres_virtual + var->xoffset;
+	if (info->var.bits_per_pixel = 0) {
+		offset = (var->yoffset / 16) * info->var.xres_virtual
+		       + var->xoffset;
 		offset = offset >> 3;
 	} else {
 		offset = (var->yoffset * info->fix.line_length) +
-			 (var->xoffset * var->bits_per_pixel / 8);
-		offset = offset >> ((var->bits_per_pixel = 4) ? 2 : 1);
+			 (var->xoffset * info->var.bits_per_pixel / 8);
+		offset = offset >> ((info->var.bits_per_pixel = 4) ? 2 : 1);
 	}
 
 	/* Set the offset */
-- 
1.7.3.4

