From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 May 2011 22:58:15 +0000
Subject: [PATCH 23/29] sm501fb: use display information in info not in var for panning
Message-Id: <1306364301-8195-24-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Ben Dooks <ben@simtec.co.uk>
---
 drivers/video/sm501fb.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index 56ef6b3..53bc35e 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -582,7 +582,7 @@ static int sm501fb_pan_crt(struct fb_var_screeninfo *var,
 {
 	struct sm501fb_par  *par = info->par;
 	struct sm501fb_info *fbi = par->info;
-	unsigned int bytes_pixel = var->bits_per_pixel / 8;
+	unsigned int bytes_pixel = info->var.bits_per_pixel / 8;
 	unsigned long reg;
 	unsigned long xoffs;
 
@@ -614,10 +614,10 @@ static int sm501fb_pan_pnl(struct fb_var_screeninfo *var,
 	struct sm501fb_info *fbi = par->info;
 	unsigned long reg;
 
-	reg = var->xoffset | (var->xres_virtual << 16);
+	reg = var->xoffset | (info->var.xres_virtual << 16);
 	smc501_writel(reg, fbi->regs + SM501_DC_PANEL_FB_WIDTH);
 
-	reg = var->yoffset | (var->yres_virtual << 16);
+	reg = var->yoffset | (info->var.yres_virtual << 16);
 	smc501_writel(reg, fbi->regs + SM501_DC_PANEL_FB_HEIGHT);
 
 	sm501fb_sync_regs(fbi);
-- 
1.7.3.4

