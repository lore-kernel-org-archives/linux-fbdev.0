From: Darren Etheridge <detheridge@ti.com>
Date: Fri, 23 Aug 2013 21:52:53 +0000
Subject: [PATCH 4/4] video: da8xx-fb: fix the polarities of the hsync/vsync pulse
Message-Id: <1377294773-25678-5-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The polarities were being set to active low when fbdev was requesting active
high.  This patch reverses it so that what is set into the LCD controller is
correct.

Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 drivers/video/da8xx-fb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 278b7d7..f768791 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -494,12 +494,12 @@ static int lcd_cfg_display(const struct lcd_ctrl_config *cfg,
 	else
 		reg &= ~LCD_SYNC_EDGE;
 
-	if (panel->sync & FB_SYNC_HOR_HIGH_ACT)
+	if ((panel->sync & FB_SYNC_HOR_HIGH_ACT) = 0)
 		reg |= LCD_INVERT_LINE_CLOCK;
 	else
 		reg &= ~LCD_INVERT_LINE_CLOCK;
 
-	if (panel->sync & FB_SYNC_VERT_HIGH_ACT)
+	if ((panel->sync & FB_SYNC_VERT_HIGH_ACT) = 0)
 		reg |= LCD_INVERT_FRAME_CLOCK;
 	else
 		reg &= ~LCD_INVERT_FRAME_CLOCK;
-- 
1.7.0.4

