From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Wed, 25 May 2011 22:58:04 +0000
Subject: [PATCH 12/29] imsttfb: use display information in info not in var for panning
Message-Id: <1306364301-8195-13-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

We must not use any information in the passed var besides xoffset,
yoffset and vmode as otherwise applications might abuse it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/imsttfb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
index efb2c10..8149356 100644
--- a/drivers/video/imsttfb.c
+++ b/drivers/video/imsttfb.c
@@ -749,7 +749,7 @@ set_offset (struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	struct imstt_par *par = info->par;
 	__u32 off = var->yoffset * (info->fix.line_length >> 3)
-		    + ((var->xoffset * (var->bits_per_pixel >> 3)) >> 3);
+		    + ((var->xoffset * (info->var.bits_per_pixel >> 3)) >> 3);
 	write_reg_le32(par->dc_regs, SSR, off);
 }
 
-- 
1.7.3.4

