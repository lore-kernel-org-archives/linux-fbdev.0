From: Daniel Vetter <daniel.vetter@ffwll.ch>
Date: Thu, 06 Jul 2017 12:57:33 +0000
Subject: [PATCH 2/4] fbdev: Nuke FBINFO_MODULE
Message-Id: <20170706125735.28299-3-daniel.vetter@ffwll.ch>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20170706125735.28299-1-daniel.vetter@ffwll.ch>
In-Reply-To: <20170706125735.28299-1-daniel.vetter@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: DRI Development <dri-devel@lists.freedesktop.org>
Cc: Daniel Vetter <daniel.vetter@intel.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, linux-fbdev@vger.kernel.org, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Instead check info->ops->owner, which amounts to the same.

Spotted because I want to remove the pile of broken and cargo-culted
fb_info->flags assignments in drm drivers.

Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/video/fbdev/core/fbcon.c | 2 +-
 drivers/video/fbdev/core/fbmem.c | 4 ++--
 include/linux/fb.h               | 7 +------
 3 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 86b3bcbd01a8..431a1533a2fe 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -564,7 +564,7 @@ static void fbcon_prepare_logo(struct vc_data *vc, struct fb_info *info,
 	unsigned short *save = NULL, *r, *q;
 	int logo_height;
 
-	if (info->flags & FBINFO_MODULE) {
+	if (info->fbops->owner) {
 		logo_shown = FBCON_LOGO_DONTSHOW;
 		return;
 	}
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 283d57cf8526..2636f192e8c9 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -463,7 +463,7 @@ static int fb_show_logo_line(struct fb_info *info, int rotate,
 
 	/* Return if the frame buffer is not mapped or suspended */
 	if (logo = NULL || info->state != FBINFO_STATE_RUNNING ||
-	    info->flags & FBINFO_MODULE)
+	    info->fbops->owner)
 		return 0;
 
 	image.depth = 8;
@@ -601,7 +601,7 @@ int fb_prepare_logo(struct fb_info *info, int rotate)
 	memset(&fb_logo, 0, sizeof(struct logo_data));
 
 	if (info->flags & FBINFO_MISC_TILEBLITTING ||
-	    info->flags & FBINFO_MODULE)
+	    info->fbops->owner)
 		return 0;
 
 	if (info->fix.visual = FB_VISUAL_DIRECTCOLOR) {
diff --git a/include/linux/fb.h b/include/linux/fb.h
index a964d076b4dc..40b767fa622f 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -400,7 +400,7 @@ struct fb_tile_ops {
 #endif /* CONFIG_FB_TILEBLITTING */
 
 /* FBINFO_* = fb_info.flags bit flags */
-#define FBINFO_MODULE		0x0001	/* Low-level driver is a module */
+#define FBINFO_DEFAULT		0
 #define FBINFO_HWACCEL_DISABLED	0x0002
 	/* When FBINFO_HWACCEL_DISABLED is set:
 	 *  Hardware acceleration is turned off.  Software implementations
@@ -533,11 +533,6 @@ static inline struct apertures_struct *alloc_apertures(unsigned int max_num) {
 	return a;
 }
 
-#ifdef MODULE
-#define FBINFO_DEFAULT	FBINFO_MODULE
-#else
-#define FBINFO_DEFAULT	0
-#endif
 
 // This will go away
 #define FBINFO_FLAG_MODULE	FBINFO_MODULE
-- 
2.13.2

