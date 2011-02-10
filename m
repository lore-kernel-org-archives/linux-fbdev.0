From: Alexander Stein <alexander.stein@systec-electronic.com>
Date: Thu, 10 Feb 2011 10:05:30 +0000
Subject: [PATCH] mx3fb: Fix parameter to sdc_init_panel
Message-Id: <1297332330-21964-1-git-send-email-alexander.stein@systec-electronic.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

h_end_width and v_end_width should only contain the front porches.
Otherwise, SCREEN_WIDTH (pixel clocks between HSYNC) in SDC_HOR_CONF
and SCREEN_HEIGHT (rows between VSYNC) in SDC_VER_CONF get false values.

Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
---
 drivers/video/mx3fb.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index ef71e56..9040833 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -881,12 +881,11 @@ static int __set_par(struct fb_info *fbi, bool lock)
 				   IPU_PIX_FMT_BGR666 : IPU_PIX_FMT_RGB666,
 				   fbi->var.left_margin,
 				   fbi->var.hsync_len,
-				   fbi->var.right_margin +
-				   fbi->var.hsync_len,
+				   fbi->var.right_margin,
 				   fbi->var.upper_margin,
 				   fbi->var.vsync_len,
-				   fbi->var.lower_margin +
-				   fbi->var.vsync_len, sig_cfg) != 0) {
+				   fbi->var.lower_margin,
+				   sig_cfg) != 0) {
 			dev_err(fbi->device,
 				"mx3fb: Error initializing panel.\n");
 			return -EINVAL;
-- 
1.7.3.4

