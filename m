From: Jani Nikula <jani.nikula@intel.com>
Date: Tue, 03 Dec 2019 16:38:45 +0000
Subject: [PATCH v3 03/12] video: fbdev: nvidia: modify the static fb_ops directly
Message-Id: <9639e2305fd4d03311bf909b8914277b221ca582.1575390740.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575390740.git.jani.nikula@intel.com>
In-Reply-To: <cover.1575390740.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: jani.nikula@intel.com, intel-gfx@lists.freedesktop.org

Avoid modifying the fb_ops via info->fbops to let us make the pointer
const in the future.

Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/video/fbdev/nvidia/nvidia.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index fbeeed5afe35..c583c018304d 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -607,6 +607,8 @@ static int nvidiafb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	return 0;
 }
 
+static struct fb_ops nvidia_fb_ops;
+
 static int nvidiafb_set_par(struct fb_info *info)
 {
 	struct nvidia_par *par = info->par;
@@ -660,19 +662,19 @@ static int nvidiafb_set_par(struct fb_info *info)
 	info->fix.line_length = (info->var.xres_virtual *
 				 info->var.bits_per_pixel) >> 3;
 	if (info->var.accel_flags) {
-		info->fbops->fb_imageblit = nvidiafb_imageblit;
-		info->fbops->fb_fillrect = nvidiafb_fillrect;
-		info->fbops->fb_copyarea = nvidiafb_copyarea;
-		info->fbops->fb_sync = nvidiafb_sync;
+		nvidia_fb_ops.fb_imageblit = nvidiafb_imageblit;
+		nvidia_fb_ops.fb_fillrect = nvidiafb_fillrect;
+		nvidia_fb_ops.fb_copyarea = nvidiafb_copyarea;
+		nvidia_fb_ops.fb_sync = nvidiafb_sync;
 		info->pixmap.scan_align = 4;
 		info->flags &= ~FBINFO_HWACCEL_DISABLED;
 		info->flags |= FBINFO_READS_FAST;
 		NVResetGraphics(info);
 	} else {
-		info->fbops->fb_imageblit = cfb_imageblit;
-		info->fbops->fb_fillrect = cfb_fillrect;
-		info->fbops->fb_copyarea = cfb_copyarea;
-		info->fbops->fb_sync = NULL;
+		nvidia_fb_ops.fb_imageblit = cfb_imageblit;
+		nvidia_fb_ops.fb_fillrect = cfb_fillrect;
+		nvidia_fb_ops.fb_copyarea = cfb_copyarea;
+		nvidia_fb_ops.fb_sync = NULL;
 		info->pixmap.scan_align = 1;
 		info->flags |= FBINFO_HWACCEL_DISABLED;
 		info->flags &= ~FBINFO_READS_FAST;
@@ -1165,7 +1167,7 @@ static int nvidia_set_fbinfo(struct fb_info *info)
 	info->pixmap.flags = FB_PIXMAP_SYSTEM;
 
 	if (!hwcur)
-	    info->fbops->fb_cursor = NULL;
+	    nvidia_fb_ops.fb_cursor = NULL;
 
 	info->var.accel_flags = (!noaccel);
 
-- 
2.20.1
