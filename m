From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 21 Aug 2015 08:53:02 +0000
Subject: [patch] fbdev: fix snprintf() limit in show_bl_curve()
Message-Id: <20150821085302.GE25369@mwanda>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The limit should be "PAGE_SIZE - len" instead of PAGE_SIZE.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 60c3f0a..827098d 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -485,7 +485,7 @@ static ssize_t show_bl_curve(struct device *device,
 
 	mutex_lock(&fb_info->bl_curve_mutex);
 	for (i = 0; i < FB_BACKLIGHT_LEVELS; i += 8)
-		len += snprintf(&buf[len], PAGE_SIZE, "%8ph\n",
+		len += snprintf(&buf[len], PAGE_SIZE - len, "%8ph\n",
 				fb_info->bl_curve + i);
 	mutex_unlock(&fb_info->bl_curve_mutex);
 
