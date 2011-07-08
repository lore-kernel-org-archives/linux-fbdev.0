From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 08 Jul 2011 11:14:20 +0000
Subject: [PATCH v3 06/29] radeonfb: use display information in info not in var for panning
Message-Id: <1310123683-8064-7-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it. Also use the
aligned fix.line_length and not the (possible) unaligned xres_virtual.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/video/aty/radeon_base.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
index 32f8cf6..1506848 100644
--- a/drivers/video/aty/radeon_base.c
+++ b/drivers/video/aty/radeon_base.c
@@ -845,16 +845,16 @@ static int radeonfb_pan_display (struct fb_var_screeninfo *var,
 {
         struct radeonfb_info *rinfo = info->par;
 
-        if ((var->xoffset + var->xres > var->xres_virtual)
-	    || (var->yoffset + var->yres > var->yres_virtual))
-               return -EINVAL;
+	if ((var->xoffset + info->var.xres > info->var.xres_virtual)
+	    || (var->yoffset + info->var.yres > info->var.yres_virtual))
+		return -EINVAL;
                 
         if (rinfo->asleep)
         	return 0;
 
 	radeon_fifo_wait(2);
-        OUTREG(CRTC_OFFSET, ((var->yoffset * var->xres_virtual + var->xoffset)
-			     * var->bits_per_pixel / 8) & ~7);
+	OUTREG(CRTC_OFFSET, (var->yoffset * info->fix.line_length +
+			     var->xoffset * info->var.bits_per_pixel / 8) & ~7);
         return 0;
 }
 
-- 
1.7.3.4

