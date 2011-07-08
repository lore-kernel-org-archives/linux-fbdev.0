From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Fri, 08 Jul 2011 11:14:28 +0000
Subject: [PATCH v3 14/29] mb862xxfb: use display information in info not in var for panning
Message-Id: <1310123683-8064-15-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Anatolij Gustschin <agust@denx.de>
---
 drivers/video/mb862xx/mb862xxfbdrv.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/mb862xx/mb862xxfbdrv.c b/drivers/video/mb862xx/mb862xxfbdrv.c
index f70bd63..2191de0 100644
--- a/drivers/video/mb862xx/mb862xxfbdrv.c
+++ b/drivers/video/mb862xx/mb862xxfbdrv.c
@@ -278,7 +278,7 @@ static int mb862xxfb_pan(struct fb_var_screeninfo *var,
 	reg = pack(var->yoffset, var->xoffset);
 	outreg(disp, GC_L0WY_L0WX, reg);
 
-	reg = pack(var->yres_virtual, var->xres_virtual);
+	reg = pack(info->var.yres_virtual, info->var.xres_virtual);
 	outreg(disp, GC_L0WH_L0WW, reg);
 	return 0;
 }
-- 
1.7.3.4

