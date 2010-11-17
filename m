From: Arnd Hannemann <arnd@arndnet.de>
Date: Wed, 17 Nov 2010 21:06:19 +0000
Subject: [PATCH] fbdev: modedb: fix CEA modes
Message-Id: <1290027979-23272-1-git-send-email-arnd@arndnet.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Some of the modes were missing the correct sync polarities.
This was causing a corrupt or left shifted picture on my TV.
Additionally format #35 had a wrong refresh rate and pixel clock.

This patch fixes those issues.

Signed-off-by: Arnd Hannemann <arnd@arndnet.de>
---
 drivers/video/modedb.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index 9a0ae6c..08b1c21 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -305,19 +305,22 @@ const struct fb_videomode cea_modes[64] = {
 	},
 	/* #19: 1280x720p@50Hz */
 	[19] = {
-		NULL, 50, 1280, 720, 13468, 220, 440, 20, 5, 40, 5, 0, FB_VMODE_NONINTERLACED, 0,
+		NULL, 50, 1280, 720, 13468, 220, 440, 20, 5, 40, 5,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, 0,
 	},
 	/* #20: 1920x1080i@50Hz */
 	[20] = {
-		NULL, 50, 1920, 1080, 13480, 148, 528, 15, 5, 528, 5, 0, FB_VMODE_INTERLACED, 0,
+		NULL, 50, 1920, 1080, 13480, 148, 528, 15, 5, 528, 5,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_INTERLACED, 0,
 	},
 	/* #32: 1920x1080p@23.98/24Hz */
 	[32] = {
-		NULL, 24, 1920, 1080, 13468, 148, 638, 36, 4, 44, 5, 0, FB_VMODE_NONINTERLACED, 0,
+		NULL, 24, 1920, 1080, 13468, 148, 638, 36, 4, 44, 5,
+		FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT, FB_VMODE_NONINTERLACED, 0,
 	},
 	/* #35: (2880)x480p4x@59.94/60Hz */
 	[35] = {
-		NULL, 50, 2880, 480, 11100, 240, 64, 30, 9, 248, 6, 0, FB_VMODE_NONINTERLACED, 0,
+		NULL, 60, 2880, 480, 9250, 240, 64, 30, 9, 248, 6, 0, FB_VMODE_NONINTERLACED, 0,
 	},
 };
 
-- 
1.7.0.4

