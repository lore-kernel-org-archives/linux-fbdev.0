From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Tue, 14 Jun 2011 09:24:51 +0000
Subject: [PATCH v2 13/29] intelfb: use display information in info not in var for panning
Message-Id: <1308043507-11083-14-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Maik Broemme <mbroemme@plusserver.de>
---
 drivers/video/intelfb/intelfbhw.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/intelfb/intelfbhw.c b/drivers/video/intelfb/intelfbhw.c
index 38065cf..fbad61d 100644
--- a/drivers/video/intelfb/intelfbhw.c
+++ b/drivers/video/intelfb/intelfbhw.c
@@ -390,12 +390,12 @@ int intelfbhw_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 	xoffset = ROUND_DOWN_TO(var->xoffset, 8);
 	yoffset = var->yoffset;
 
-	if ((xoffset + var->xres > var->xres_virtual) ||
-	    (yoffset + var->yres > var->yres_virtual))
+	if ((xoffset + info->var.xres > info->var.xres_virtual) ||
+	    (yoffset + info->var.yres > info->var.yres_virtual))
 		return -EINVAL;
 
 	offset = (yoffset * dinfo->pitch) +
-		 (xoffset * var->bits_per_pixel) / 8;
+		 (xoffset * info->var.bits_per_pixel) / 8;
 
 	offset += dinfo->fb.offset << 12;
 
-- 
1.7.3.4

