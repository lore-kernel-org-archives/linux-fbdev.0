From: Jani Nikula <jani.nikula@intel.com>
Date: Tue, 03 Dec 2019 16:38:43 +0000
Subject: [PATCH v3 01/12] video: fbdev: atyfb: modify the static fb_ops directly
Message-Id: <7dfbf1d47203157f5eb9a6f447f0095765d0b5e6.1575390740.git.jani.nikula@intel.com>
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
 drivers/video/fbdev/aty/atyfb.h         | 2 +-
 drivers/video/fbdev/aty/atyfb_base.c    | 6 +++---
 drivers/video/fbdev/aty/mach64_cursor.c | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb.h b/drivers/video/fbdev/aty/atyfb.h
index e5a347c58180..a7833bc98225 100644
--- a/drivers/video/fbdev/aty/atyfb.h
+++ b/drivers/video/fbdev/aty/atyfb.h
@@ -341,7 +341,7 @@ extern const u8 aty_postdividers[8];
      *  Hardware cursor support
      */
 
-extern int aty_init_cursor(struct fb_info *info);
+extern int aty_init_cursor(struct fb_info *info, struct fb_ops *atyfb_ops);
 
     /*
      *  Hardware acceleration
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 6dda5d885a03..bebc08505d94 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -1316,10 +1316,10 @@ static int atyfb_set_par(struct fb_info *info)
 	par->accel_flags = var->accel_flags; /* hack */
 
 	if (var->accel_flags) {
-		info->fbops->fb_sync = atyfb_sync;
+		atyfb_ops.fb_sync = atyfb_sync;
 		info->flags &= ~FBINFO_HWACCEL_DISABLED;
 	} else {
-		info->fbops->fb_sync = NULL;
+		atyfb_ops.fb_sync = NULL;
 		info->flags |= FBINFO_HWACCEL_DISABLED;
 	}
 
@@ -2702,7 +2702,7 @@ static int aty_init(struct fb_info *info)
 
 #ifdef CONFIG_FB_ATY_CT
 	if (!noaccel && M64_HAS(INTEGRATED))
-		aty_init_cursor(info);
+		aty_init_cursor(info, &atyfb_ops);
 #endif /* CONFIG_FB_ATY_CT */
 	info->var = var;
 
diff --git a/drivers/video/fbdev/aty/mach64_cursor.c b/drivers/video/fbdev/aty/mach64_cursor.c
index 4cde25eab8e8..b06fa6e42e6e 100644
--- a/drivers/video/fbdev/aty/mach64_cursor.c
+++ b/drivers/video/fbdev/aty/mach64_cursor.c
@@ -194,7 +194,7 @@ static int atyfb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 	return 0;
 }
 
-int aty_init_cursor(struct fb_info *info)
+int aty_init_cursor(struct fb_info *info, struct fb_ops *atyfb_ops)
 {
 	unsigned long addr;
 
@@ -219,7 +219,7 @@ int aty_init_cursor(struct fb_info *info)
 	info->sprite.buf_align = 16; 	/* and 64 lines tall. */
 	info->sprite.flags = FB_PIXMAP_IO;
 
-	info->fbops->fb_cursor = atyfb_cursor;
+	atyfb_ops->fb_cursor = atyfb_cursor;
 
 	return 0;
 }
-- 
2.20.1
