From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Fri, 20 Aug 2010 06:48:36 +0000
Subject: [PATCH] fbdev: add a function to parse further EDID Detailed Timing
Message-Id: <Pine.LNX.4.64.1008200847020.6103@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Currently a function is available to parse the first EDID Detailed Timing
Descriptor (DTD) block. However, EDID can contain up to four DTDs. Add a
function to parse further DTDs.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/fbmon.c |   74 ++++++++++++++++++++++++++++++++++++------------
 include/linux/fb.h    |    2 +
 2 files changed, 57 insertions(+), 19 deletions(-)

diff --git a/drivers/video/fbmon.c b/drivers/video/fbmon.c
index 563a98b..03de586 100644
--- a/drivers/video/fbmon.c
+++ b/drivers/video/fbmon.c
@@ -866,6 +866,29 @@ static void get_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 	}
 }
 
+static void fb_edid_to_var(unsigned char *block, struct fb_var_screeninfo *var)
+{
+	var->xres = var->xres_virtual = H_ACTIVE;
+	var->yres = var->yres_virtual = V_ACTIVE;
+	var->height = var->width = 0;
+	var->right_margin = H_SYNC_OFFSET;
+	var->left_margin = (H_ACTIVE + H_BLANKING) -
+		(H_ACTIVE + H_SYNC_OFFSET + H_SYNC_WIDTH);
+	var->upper_margin = V_BLANKING - V_SYNC_OFFSET -
+		V_SYNC_WIDTH;
+	var->lower_margin = V_SYNC_OFFSET;
+	var->hsync_len = H_SYNC_WIDTH;
+	var->vsync_len = V_SYNC_WIDTH;
+	var->pixclock = PIXEL_CLOCK;
+	var->pixclock /= 1000;
+	var->pixclock = KHZ2PICOS(var->pixclock);
+
+	if (HSYNC_POSITIVE)
+		var->sync |= FB_SYNC_HOR_HIGH_ACT;
+	if (VSYNC_POSITIVE)
+		var->sync |= FB_SYNC_VERT_HIGH_ACT;
+}
+
 int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
 {
 	int i;
@@ -884,31 +907,38 @@ int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
 
 	for (i = 0; i < 4; i++, block += DETAILED_TIMING_DESCRIPTION_SIZE) {
 		if (edid_is_timing_block(block)) {
-			var->xres = var->xres_virtual = H_ACTIVE;
-			var->yres = var->yres_virtual = V_ACTIVE;
-			var->height = var->width = 0;
-			var->right_margin = H_SYNC_OFFSET;
-			var->left_margin = (H_ACTIVE + H_BLANKING) -
-				(H_ACTIVE + H_SYNC_OFFSET + H_SYNC_WIDTH);
-			var->upper_margin = V_BLANKING - V_SYNC_OFFSET -
-				V_SYNC_WIDTH;
-			var->lower_margin = V_SYNC_OFFSET;
-			var->hsync_len = H_SYNC_WIDTH;
-			var->vsync_len = V_SYNC_WIDTH;
-			var->pixclock = PIXEL_CLOCK;
-			var->pixclock /= 1000;
-			var->pixclock = KHZ2PICOS(var->pixclock);
-
-			if (HSYNC_POSITIVE)
-				var->sync |= FB_SYNC_HOR_HIGH_ACT;
-			if (VSYNC_POSITIVE)
-				var->sync |= FB_SYNC_VERT_HIGH_ACT;
+			fb_edid_to_var(block, var);
 			return 0;
 		}
 	}
 	return 1;
 }
 
+int fb_parse_edid_index(unsigned char *edid, struct fb_var_screeninfo *var,
+			unsigned int idx)
+{
+	unsigned char *block;
+
+	if (edid = NULL || var = NULL || idx > 3)
+		return 1;
+
+	if (!(edid_checksum(edid)))
+		return 1;
+
+	if (!(edid_check_header(edid)))
+		return 1;
+
+	block = edid + DETAILED_TIMING_DESCRIPTIONS_START +
+		idx * DETAILED_TIMING_DESCRIPTION_SIZE;
+
+	if (edid_is_timing_block(block)) {
+		fb_edid_to_var(block, var);
+		return 0;
+	}
+
+	return 1;
+}
+
 void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 {
 	unsigned char *block;
@@ -1285,6 +1315,11 @@ int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var)
 {
 	return 1;
 }
+int fb_parse_edid_index(unsigned char *edid, struct fb_var_screeninfo *var,
+			unsigned int idx)
+{
+	return 1;
+}
 void fb_edid_to_monspecs(unsigned char *edid, struct fb_monspecs *specs)
 {
 	specs = NULL;
@@ -1395,6 +1430,7 @@ const unsigned char *fb_firmware_edid(struct device *device)
 EXPORT_SYMBOL(fb_firmware_edid);
 
 EXPORT_SYMBOL(fb_parse_edid);
+EXPORT_SYMBOL(fb_parse_edid_index);
 EXPORT_SYMBOL(fb_edid_to_monspecs);
 EXPORT_SYMBOL(fb_get_mode);
 EXPORT_SYMBOL(fb_validate_mode);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index f0268de..3649c47 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -1083,6 +1083,8 @@ extern int fb_get_mode(int flags, u32 val, struct fb_var_screeninfo *var,
 extern int fb_validate_mode(const struct fb_var_screeninfo *var,
 			    struct fb_info *info);
 extern int fb_parse_edid(unsigned char *edid, struct fb_var_screeninfo *var);
+extern int fb_parse_edid_index(unsigned char *edid, struct fb_var_screeninfo *var,
+			       unsigned int idx);
 extern const unsigned char *fb_firmware_edid(struct device *device);
 extern void fb_edid_to_monspecs(unsigned char *edid,
 				struct fb_monspecs *specs);
-- 
1.7.2

