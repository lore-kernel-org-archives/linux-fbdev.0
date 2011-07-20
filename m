From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 20 Jul 2011 10:25:55 +0000
Subject: [PATCH] atmel_lcdfb: Fix compilation
Message-Id: <1311157555-10618-1-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

A typo in the "atmel_lcdfb: use display information in info not in var
for panning" patch broke compilation. Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/atmel_lcdfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

Paul,

This patch applies on top of the fbdev/panning-fixes branch in
git://git.kernel.org/pub/scm/linux/kernel/git/lethal/fbdev-3.x.git

You can apply it, squash it with patch "atmel_lcdfb: use display information
in info not in var for panning" in that branch, or replace the whole branch
with my "[PATCH v3 00/29] Use display information in info not in var for
panning" patch series posted to the linux-fbdev list.

Do you plan to push the result for v3.1 ?

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 8b5d755..5f1de1f 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -59,7 +59,7 @@ static void atmel_lcdfb_update_dma2d(struct atmel_lcdfb_info *sinfo,
 
 	pixeloff = (var->xoffset * info->var.bits_per_pixel) & 0x1f;
 
-	dma2dcfg = (info-var.xres_virtual - info->var.xres)
+	dma2dcfg = (info->var.xres_virtual - info->var.xres)
 		 * info->var.bits_per_pixel / 8;
 	dma2dcfg |= pixeloff << ATMEL_LCDC_PIXELOFF_OFFSET;
 	lcdc_writel(sinfo, ATMEL_LCDC_DMA2DCFG, dma2dcfg);
-- 
Regards,

Laurent Pinchart

