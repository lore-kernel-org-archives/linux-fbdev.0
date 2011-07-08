From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 08 Jul 2011 11:14:24 +0000
Subject: [PATCH v3 10/29] gxt4500: use display information in info not in var for panning
Message-Id: <1310123683-8064-11-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Paul Mackerras <paulus@samba.org>
---
 drivers/video/gxt4500.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/gxt4500.c b/drivers/video/gxt4500.c
index 896e53d..0fad23f 100644
--- a/drivers/video/gxt4500.c
+++ b/drivers/video/gxt4500.c
@@ -543,8 +543,8 @@ static int gxt4500_pan_display(struct fb_var_screeninfo *var,
 
 	if (var->xoffset & 7)
 		return -EINVAL;
-	if (var->xoffset + var->xres > var->xres_virtual ||
-	    var->yoffset + var->yres > var->yres_virtual)
+	if (var->xoffset + info->var.xres > info->var.xres_virtual ||
+	    var->yoffset + info->var.yres > info->var.yres_virtual)
 		return -EINVAL;
 
 	writereg(par, REFRESH_START, (var->xoffset << 16) | var->yoffset);
-- 
1.7.3.4

