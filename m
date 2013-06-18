From: Fabio Estevam <fabio.estevam@freescale.com>
Date: Tue, 18 Jun 2013 15:18:42 +0000
Subject: [PATCH v2 1/2] video: fbmem: Use 'const char' in fb_get_options()
Message-Id: <1371568723-27486-1-git-send-email-fabio.estevam@freescale.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org

Commit d20d31748 (drm: Constify the pretty-print functions) causes the following
build warning:

drivers/gpu/drm/drm_fb_helper.c:127:3: warning: passing argument 1 of 'fb_get_options' discards 'const' qualifier from pointer target type [enabled by default]

Let's change the first argument of fb_get_options from 'char *' to 'const char *' 
so that we can get rid of this warning.

Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
Changes since v1:
- None

 drivers/video/fbmem.c | 2 +-
 include/linux/fb.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 098bfc6..d8d5779 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1881,7 +1881,7 @@ static int ofonly __read_mostly;
  *
  * NOTE: Needed to maintain backwards compatibility
  */
-int fb_get_options(char *name, char **option)
+int fb_get_options(const char *name, char **option)
 {
 	char *opt, *options = NULL;
 	int retval = 0;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index d49c60f..ffac70a 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -624,7 +624,7 @@ extern void fb_pad_aligned_buffer(u8 *dst, u32 d_pitch, u8 *src, u32 s_pitch, u3
 extern void fb_set_suspend(struct fb_info *info, int state);
 extern int fb_get_color_depth(struct fb_var_screeninfo *var,
 			      struct fb_fix_screeninfo *fix);
-extern int fb_get_options(char *name, char **option);
+extern int fb_get_options(const char *name, char **option);
 extern int fb_new_modelist(struct fb_info *info);
 
 extern struct fb_info *registered_fb[FB_MAX];
-- 
1.8.1.2


