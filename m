From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Mon, 14 Oct 2019 14:04:02 +0000
Subject: [PATCH v2 01/15] fbdev: Export fb_check_foreignness()
Message-Id: <20191014140416.28517-2-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20191014140416.28517-1-tzimmermann@suse.de>
In-Reply-To: <20191014140416.28517-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org, sean@poorly.run, b.zolnierkie@samsung.com, ajax@redhat.com, ville.syrjala@linux.intel.com, malat@debian.org, michel@daenzer.net
Cc: gregkh@linuxfoundation.org, linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org, corbet@lwn.net

This function is required by DRM's fbdev conversion helpers. Export it
from the module.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbmem.c | 3 ++-
 include/linux/fb.h               | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 95c32952fa8a..e828fcccce40 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1481,7 +1481,7 @@ static const struct file_operations fb_fops = {
 struct class *fb_class;
 EXPORT_SYMBOL(fb_class);
 
-static int fb_check_foreignness(struct fb_info *fi)
+int fb_check_foreignness(struct fb_info *fi)
 {
 	const bool foreign_endian = fi->flags & FBINFO_FOREIGN_ENDIAN;
 
@@ -1505,6 +1505,7 @@ static int fb_check_foreignness(struct fb_info *fi)
 
 	return 0;
 }
+EXPORT_SYMBOL(fb_check_foreignness);
 
 static bool apertures_overlap(struct aperture *gen, struct aperture *hw)
 {
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 41e0069eca0a..372f1f6ae42e 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -622,6 +622,7 @@ extern int fb_get_color_depth(struct fb_var_screeninfo *var,
 			      struct fb_fix_screeninfo *fix);
 extern int fb_get_options(const char *name, char **option);
 extern int fb_new_modelist(struct fb_info *info);
+extern int fb_check_foreignness(struct fb_info *fi);
 
 extern struct fb_info *registered_fb[FB_MAX];
 extern int num_registered_fb;
-- 
2.23.0
