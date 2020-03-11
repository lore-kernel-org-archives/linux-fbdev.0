From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 11 Mar 2020 09:32:28 +0000
Subject: [PATCH 1/3] video: omapfb: Use scnprintf() for avoiding potential buffer overflow
Message-Id: <20200311093230.24900-2-tiwai@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/video/fbdev/omap/omapfb_main.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/omap/omapfb_main.c b/drivers/video/fbdev/omap/omapfb_main.c
index e8a304f84ea8..1a9d6242916e 100644
--- a/drivers/video/fbdev/omap/omapfb_main.c
+++ b/drivers/video/fbdev/omap/omapfb_main.c
@@ -1247,7 +1247,7 @@ static ssize_t omapfb_show_caps_num(struct device *dev,
 	size = 0;
 	while (size < PAGE_SIZE && plane < OMAPFB_PLANE_NUM) {
 		omapfb_get_caps(fbdev, plane, &caps);
-		size += snprintf(&buf[size], PAGE_SIZE - size,
+		size += scnprintf(&buf[size], PAGE_SIZE - size,
 			"plane#%d %#010x %#010x %#010x\n",
 			plane, caps.ctrl, caps.plane_color, caps.wnd_color);
 		plane++;
@@ -1268,28 +1268,28 @@ static ssize_t omapfb_show_caps_text(struct device *dev,
 	size = 0;
 	while (size < PAGE_SIZE && plane < OMAPFB_PLANE_NUM) {
 		omapfb_get_caps(fbdev, plane, &caps);
-		size += snprintf(&buf[size], PAGE_SIZE - size,
+		size += scnprintf(&buf[size], PAGE_SIZE - size,
 				 "plane#%d:\n", plane);
 		for (i = 0; i < ARRAY_SIZE(ctrl_caps) &&
 		     size < PAGE_SIZE; i++) {
 			if (ctrl_caps[i].flag & caps.ctrl)
-				size += snprintf(&buf[size], PAGE_SIZE - size,
+				size += scnprintf(&buf[size], PAGE_SIZE - size,
 					" %s\n", ctrl_caps[i].name);
 		}
-		size += snprintf(&buf[size], PAGE_SIZE - size,
+		size += scnprintf(&buf[size], PAGE_SIZE - size,
 				 " plane colors:\n");
 		for (i = 0; i < ARRAY_SIZE(color_caps) &&
 		     size < PAGE_SIZE; i++) {
 			if (color_caps[i].flag & caps.plane_color)
-				size += snprintf(&buf[size], PAGE_SIZE - size,
+				size += scnprintf(&buf[size], PAGE_SIZE - size,
 					"  %s\n", color_caps[i].name);
 		}
-		size += snprintf(&buf[size], PAGE_SIZE - size,
+		size += scnprintf(&buf[size], PAGE_SIZE - size,
 				 " window colors:\n");
 		for (i = 0; i < ARRAY_SIZE(color_caps) &&
 		     size < PAGE_SIZE; i++) {
 			if (color_caps[i].flag & caps.wnd_color)
-				size += snprintf(&buf[size], PAGE_SIZE - size,
+				size += scnprintf(&buf[size], PAGE_SIZE - size,
 					"  %s\n", color_caps[i].name);
 		}
 
-- 
2.16.4
