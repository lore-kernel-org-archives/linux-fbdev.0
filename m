From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 May 2011 22:57:59 +0000
Subject: [PATCH 07/29] fbdev: da8xx: use display information in info not in var for panning
Message-Id: <1306364301-8195-8-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Sudhakar Rajashekhara <sudhakar.raj@ti.com>
Cc: Martin Ambrose <martin@ti.com>
---
 drivers/video/da8xx-fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 8b7d473..3470217 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -877,8 +877,8 @@ static int da8xx_pan_display(struct fb_var_screeninfo *var,
 
 			start	= fix->smem_start +
 				new_var.yoffset * fix->line_length +
-				new_var.xoffset * var->bits_per_pixel / 8;
-			end	= start + var->yres * fix->line_length - 1;
+				new_var.xoffset * fbi->var.bits_per_pixel / 8;
+			end	= start + fbi->var.yres * fix->line_length - 1;
 			par->dma_start	= start;
 			par->dma_end	= end;
 		}
-- 
1.7.3.4

