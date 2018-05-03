From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Thu, 03 May 2018 18:04:23 +0000
Subject: [PATCH v1] video: fbdev: pxafb: Convert to use match_string() helper
Message-Id: <20180503180423.21710-1-andriy.shevchenko@linux.intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The new helper returns index of the matching string in an array.
We are going to use it here.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/video/fbdev/pxafb.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index c3d49e13643c..0c013f1efe81 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -2099,7 +2099,7 @@ static void pxafb_check_options(struct device *dev, struct pxafb_mach_info *inf)
 
 #if defined(CONFIG_OF)
 static const char * const lcd_types[] = {
-	"unknown", "mono-stn", "mono-dstn", "color-stn", "color-dstn",
+	"mono-stn", "mono-dstn", "color-stn", "color-dstn",
 	"color-tft", "smart-panel", NULL
 };
 
@@ -2115,12 +2115,10 @@ static int of_get_pxafb_display(struct device *dev, struct device_node *disp,
 	if (ret)
 		s = "color-tft";
 
-	for (i = 0; lcd_types[i]; i++)
-		if (!strcmp(s, lcd_types[i]))
-			break;
-	if (!i || !lcd_types[i]) {
+	i = match_string(lcd_types, -1, s);
+	if (i < 0) {
 		dev_err(dev, "lcd-type %s is unknown\n", s);
-		return -EINVAL;
+		return i;
 	}
 	info->lcd_conn |= LCD_CONN_TYPE(i);
 	info->lcd_conn |= LCD_CONN_WIDTH(bus_width);
-- 
2.17.0

