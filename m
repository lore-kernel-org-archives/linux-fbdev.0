From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Date: Thu, 19 Jul 2012 00:39:21 +0000
Subject: [PATCH 8/9] fbdev: sh_mobile_lcdc: Fix overlay registers update during pan operation
Message-Id: <1342658362-19491-9-git-send-email-laurent.pinchart@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Updating overlay registers require switching to overlay update mode.
This was correctly done when configuring the overlay format and size,
but not when updating the base address registers during pan operation.
Fix it.

Signed-off-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
---
 drivers/video/sh_mobile_lcdcfb.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index aeb7585..5c26c44 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -1539,9 +1539,14 @@ static int sh_mobile_lcdc_overlay_pan(struct fb_var_screeninfo *var,
 		ovl->base_addr_c = base_addr_c;
 	}
 
+	lcdc_write(ovl->channel->lcdc, LDBCR, LDBCR_UPC(ovl->index));
+
 	lcdc_write_overlay(ovl, LDBnBSAYR(ovl->index), ovl->base_addr_y);
 	lcdc_write_overlay(ovl, LDBnBSACR(ovl->index), ovl->base_addr_c);
 
+	lcdc_write(ovl->channel->lcdc, LDBCR,
+		   LDBCR_UPF(ovl->index) | LDBCR_UPD(ovl->index));
+
 	ovl->pan_offset = pan_offset;
 
 	return 0;
-- 
1.7.8.6

