From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 11 Mar 2020 09:32:29 +0000
Subject: [PATCH 2/3] video: omap2: Use scnprintf() for avoiding potential buffer overflow
Message-Id: <20200311093230.24900-3-tiwai@suse.de>
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
 drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c b/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
index 4a5db170ef59..2d39dbfa742e 100644
--- a/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
+++ b/drivers/video/fbdev/omap2/omapfb/omapfb-sysfs.c
@@ -147,11 +147,11 @@ static ssize_t show_overlays(struct device *dev,
 			if (ovl = fbdev->overlays[ovlnum])
 				break;
 
-		l += snprintf(buf + l, PAGE_SIZE - l, "%s%d",
+		l += scnprintf(buf + l, PAGE_SIZE - l, "%s%d",
 				t = 0 ? "" : ",", ovlnum);
 	}
 
-	l += snprintf(buf + l, PAGE_SIZE - l, "\n");
+	l += scnprintf(buf + l, PAGE_SIZE - l, "\n");
 
 	omapfb_unlock(fbdev);
 	unlock_fb_info(fbi);
@@ -328,11 +328,11 @@ static ssize_t show_overlays_rotate(struct device *dev,
 	lock_fb_info(fbi);
 
 	for (t = 0; t < ofbi->num_overlays; t++) {
-		l += snprintf(buf + l, PAGE_SIZE - l, "%s%d",
+		l += scnprintf(buf + l, PAGE_SIZE - l, "%s%d",
 				t = 0 ? "" : ",", ofbi->rotation[t]);
 	}
 
-	l += snprintf(buf + l, PAGE_SIZE - l, "\n");
+	l += scnprintf(buf + l, PAGE_SIZE - l, "\n");
 
 	unlock_fb_info(fbi);
 
-- 
2.16.4
