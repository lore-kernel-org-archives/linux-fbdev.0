From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 May 2011 22:58:07 +0000
Subject: [PATCH 15/29] mx3fb: use display information in info not in var for panning
Message-Id: <1306364301-8195-16-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it. Also use the
aligned fix.line_length and not the (possible) unaligned xres_virtual.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/mx3fb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index 7e3a490..759e244 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -1062,15 +1062,15 @@ static int mx3fb_pan_display(struct fb_var_screeninfo *var,
 	y_bottom = var->yoffset;
 
 	if (!(var->vmode & FB_VMODE_YWRAP))
-		y_bottom += var->yres;
+		y_bottom += fbi->var.yres;
 
 	if (y_bottom > fbi->var.yres_virtual)
 		return -EINVAL;
 
 	mutex_lock(&mx3_fbi->mutex);
 
-	offset = (var->yoffset * var->xres_virtual + var->xoffset) *
-		(var->bits_per_pixel / 8);
+	offset = var->yoffset * fbi->fix.line_length
+	       + var->xoffset * (var->bits_per_pixel / 8);
 	base = fbi->fix.smem_start + offset;
 
 	dev_dbg(fbi->device, "Updating SDC BG buf %d address=0x%08lX\n",
-- 
1.7.3.4

