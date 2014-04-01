From: jon@ringle.org
Date: Tue, 01 Apr 2014 12:39:33 +0000
Subject: [PATCH v3 1/2] video: da8xx-fb: Add support for Densitron 84-0023-001T
Message-Id: <1396355974-2257-1-git-send-email-jon@ringle.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, Jon Ringle <jringle@gridpoint.com>

From: Jon Ringle <jringle@gridpoint.com>

Signed-off-by: Jon Ringle <jringle@gridpoint.com>
---
 drivers/video/da8xx-fb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index e030e17..233f65f 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -243,6 +243,20 @@ static struct fb_videomode known_lcd_panels[] = {
 		.sync           = FB_SYNC_HOR_HIGH_ACT | FB_SYNC_VERT_HIGH_ACT,
 		.flag           = 0,
 	},
+	[3] = {
+		/* Densitron 84-0023-001T */
+		.name           = "Densitron_84-0023-001T",
+		.xres           = 320,
+		.yres           = 240,
+		.pixclock       = KHZ2PICOS(6400),
+		.left_margin    = 0,
+		.right_margin   = 0,
+		.upper_margin   = 0,
+		.lower_margin   = 0,
+		.hsync_len      = 30,
+		.vsync_len      = 3,
+		.sync           = 0,
+	},
 };
 
 static bool da8xx_fb_is_raster_enabled(void)
-- 
1.8.5.4

