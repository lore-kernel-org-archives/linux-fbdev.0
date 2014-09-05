From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Fri, 05 Sep 2014 14:47:35 +0000
Subject: [PATCH] video: fbdev: use %*ph specifier to dump small buffers
Message-Id: <1409928455-31086-1-git-send-email-andriy.shevchenko@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Instead of dereference each byte let's use %*ph specifier in the printk()
calls.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/fbdev/core/fbsysfs.c | 12 ++----------
 drivers/video/fbdev/udlfb.c        |  7 ++-----
 2 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index 53444ac..60c3f0a 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -485,16 +485,8 @@ static ssize_t show_bl_curve(struct device *device,
 
 	mutex_lock(&fb_info->bl_curve_mutex);
 	for (i = 0; i < FB_BACKLIGHT_LEVELS; i += 8)
-		len += snprintf(&buf[len], PAGE_SIZE,
-				"%02x %02x %02x %02x %02x %02x %02x %02x\n",
-				fb_info->bl_curve[i + 0],
-				fb_info->bl_curve[i + 1],
-				fb_info->bl_curve[i + 2],
-				fb_info->bl_curve[i + 3],
-				fb_info->bl_curve[i + 4],
-				fb_info->bl_curve[i + 5],
-				fb_info->bl_curve[i + 6],
-				fb_info->bl_curve[i + 7]);
+		len += snprintf(&buf[len], PAGE_SIZE, "%8ph\n",
+				fb_info->bl_curve + i);
 	mutex_unlock(&fb_info->bl_curve_mutex);
 
 	return len;
diff --git a/drivers/video/fbdev/udlfb.c b/drivers/video/fbdev/udlfb.c
index 77b890e..046d51d 100644
--- a/drivers/video/fbdev/udlfb.c
+++ b/drivers/video/fbdev/udlfb.c
@@ -1528,11 +1528,8 @@ static int dlfb_parse_vendor_descriptor(struct dlfb_data *dev,
 	}
 
 	if (total_len > 5) {
-		pr_info("vendor descriptor length:%x data:%02x %02x %02x %02x" \
-			"%02x %02x %02x %02x %02x %02x %02x\n",
-			total_len, desc[0],
-			desc[1], desc[2], desc[3], desc[4], desc[5], desc[6],
-			desc[7], desc[8], desc[9], desc[10]);
+		pr_info("vendor descriptor length:%x data:%11ph\n", total_len,
+			desc);
 
 		if ((desc[0] != total_len) || /* descriptor length */
 		    (desc[1] != 0x5f) ||   /* vendor descriptor type */
-- 
2.1.0

