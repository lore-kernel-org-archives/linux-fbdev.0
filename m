From: Thomas Weber <weber@corscience.de>
Date: Mon, 10 Jan 2011 15:34:32 +0000
Subject: [PATCH] Drivers: video: Add modes for Devkit8000 displays
Message-Id: <1294673672-30924-1-git-send-email-weber@corscience.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Thomas Weber <weber@corscience.de>

This patch adds the video modes for the 4.3, 5.6 and 7 inch panels that
are sold with the devkit8000.

Signed-off-by: Thomas Weber <weber@corscience.de>
---
 drivers/video/modedb.c |   14 +++++++++++++-
 1 files changed, 13 insertions(+), 1 deletions(-)

diff --git a/drivers/video/modedb.c b/drivers/video/modedb.c
index de450c1..7b2581c 100644
--- a/drivers/video/modedb.c
+++ b/drivers/video/modedb.c
@@ -274,7 +274,19 @@ static const struct fb_videomode modedb[] = {
        /* 800x520i @ 50 Hz, 15.625 kHz hsync (PAL RGB) */
        NULL, 50, 800, 520, 58823, 144, 64, 72, 28, 80, 5,
        0, FB_VMODE_INTERLACED
-    },
+    }, {
+       /* 480x272 @ 60 Hz */
+       NULL, 60, 480, 272, KHZ2PICOS(10164), 2, 2, 2, 2, 41, 10,
+       0, FB_VMODE_NONINTERLACED
+    }, {
+       /* 640x480 @ 60 Hz */
+       NULL, 60, 640, 480, KHZ2PICOS(25000), 16, 134, 32, 11, 10, 2,
+       0, FB_VMODE_NONINTERLACED
+    }, {
+       /* 800x480 @ 60 Hz */
+       NULL, 60, 800, 480, KHZ2PICOS(30000), 40, 40, 13, 29, 48, 3,
+       0, FB_VMODE_NONINTERLACED
+    }
 };
 
 #ifdef CONFIG_FB_MODE_HELPERS
-- 
1.7.4.rc1

