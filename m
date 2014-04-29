From: Masanari Iida <standby24x7@gmail.com>
Date: Tue, 29 Apr 2014 12:21:54 +0000
Subject: [PATCH 1/2] video: fbdev: Fix format string mismatch in wm8505fb.c
Message-Id: <1398774115-15353-1-git-send-email-standby24x7@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Masanari Iida <standby24x7@gmail.com>

Fix format string mismatch in contrast_show().

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/video/fbdev/wm8505fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/wm8505fb.c b/drivers/video/fbdev/wm8505fb.c
index 537d199..d2fafbb 100644
--- a/drivers/video/fbdev/wm8505fb.c
+++ b/drivers/video/fbdev/wm8505fb.c
@@ -162,7 +162,7 @@ static ssize_t contrast_show(struct device *dev,
 	struct fb_info *info = dev_get_drvdata(dev);
 	struct wm8505fb_info *fbi = to_wm8505fb_info(info);
 
-	return sprintf(buf, "%d\n", fbi->contrast);
+	return sprintf(buf, "%u\n", fbi->contrast);
 }
 
 static ssize_t contrast_store(struct device *dev,
-- 
2.0.0.rc1

