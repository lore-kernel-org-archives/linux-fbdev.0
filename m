From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Sun, 15 Apr 2012 10:39:04 +0000
Subject: [PATCH] video: s3c-fb: s3c_fb_missing_pixclock() can't be __devinit
Message-Id: <1334486344-24073-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Since s3c_fb_missing_pixclock() is called from s3c_fb_set_rgb_timing()
which is used in the suspend/resume paths it can't be marked __devinit
as this could result in it being discarded after boot.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/video/s3c-fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/s3c-fb.c b/drivers/video/s3c-fb.c
index 18c84b8..d8f0018 100644
--- a/drivers/video/s3c-fb.c
+++ b/drivers/video/s3c-fb.c
@@ -1056,7 +1056,7 @@ static struct fb_ops s3c_fb_ops = {
  *
  * Calculate the pixel clock when none has been given through platform data.
  */
-static void __devinit s3c_fb_missing_pixclock(struct fb_videomode *mode)
+static void s3c_fb_missing_pixclock(struct fb_videomode *mode)
 {
 	u64 pixclk = 1000000000000ULL;
 	u32 div;
-- 
1.7.9.1

