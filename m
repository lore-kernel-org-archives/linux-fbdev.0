From: Andrea Merello <andrea.merello@gmail.com>
Date: Tue, 22 Dec 2015 12:26:11 +0000
Subject: [PATCH] ocfb: fix tgdel and tvdel timing parameters
Message-Id: <1450787171-22429-1-git-send-email-andrea.merello@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

According to the ocfb documentation:
Fix tgdel HW param should be left margin, not right.
Fix tvdel HW param should upper margin, not lower.

This seems to fix lock issues on certain monitors (tested on a
slightly customized IP, but the FPGA guy said that it should
be the same wrt this changes).

Signed-off-by: Andrea Merello <andrea.merello@gmail.com>

diff --git a/drivers/video/fbdev/ocfb.c b/drivers/video/fbdev/ocfb.c
index c9293ae..a970edc2 100644
--- a/drivers/video/fbdev/ocfb.c
+++ b/drivers/video/fbdev/ocfb.c
@@ -123,11 +123,11 @@ static int ocfb_setupfb(struct ocfb_dev *fbdev)
 
 	/* Horizontal timings */
 	ocfb_writereg(fbdev, OCFB_HTIM, (var->hsync_len - 1) << 24 |
-		      (var->right_margin - 1) << 16 | (var->xres - 1));
+		      (var->left_margin - 1) << 16 | (var->xres - 1));
 
 	/* Vertical timings */
 	ocfb_writereg(fbdev, OCFB_VTIM, (var->vsync_len - 1) << 24 |
-		      (var->lower_margin - 1) << 16 | (var->yres - 1));
+		      (var->upper_margin - 1) << 16 | (var->yres - 1));
 
 	/* Total length of frame */
 	hlen = var->left_margin + var->right_margin + var->hsync_len +
-- 
1.9.1

