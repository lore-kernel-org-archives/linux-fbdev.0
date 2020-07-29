From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Wed, 29 Jul 2020 13:41:45 +0000
Subject: [PATCH 2/5] fbdev/core: Export framebuffer read and write code as cfb_ function
Message-Id: <20200729134148.6855-3-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200729134148.6855-1-tzimmermann@suse.de>
In-Reply-To: <20200729134148.6855-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@redhat.com, daniel@ffwll.ch, sam@ravnborg.org, kraxel@redhat.com, b.zolnierkie@samsung.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org, jani.nikula@intel.com, peda@axentia.se, dan.carpenter@oracle.com, natechancellor@gmail.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

DRM fb helpers require read and write functions for framebuffer
memory. Export the existing code from fbdev.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/video/fbdev/core/fbmem.c | 53 ++++++++++++++++++++++----------
 include/linux/fb.h               |  5 +++
 2 files changed, 41 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index dd0ccf35f7b7..b496ff90db3e 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -759,25 +759,18 @@ static struct fb_info *file_fb_info(struct file *file)
 	return info;
 }
 
-static ssize_t
-fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
+ssize_t fb_cfb_read(struct fb_info *info, char __user *buf, size_t count,
+		    loff_t *ppos)
 {
 	unsigned long p = *ppos;
-	struct fb_info *info = file_fb_info(file);
 	u8 *buffer, *dst;
 	u8 __iomem *src;
 	int c, cnt = 0, err = 0;
 	unsigned long total_size;
 
-	if (!info || ! info->screen_base)
-		return -ENODEV;
-
 	if (info->state != FBINFO_STATE_RUNNING)
 		return -EPERM;
 
-	if (info->fbops->fb_read)
-		return info->fbops->fb_read(info, buf, count, ppos);
-
 	total_size = info->screen_size;
 
 	if (total_size = 0)
@@ -823,16 +816,12 @@ fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 
 	return (err) ? err : cnt;
 }
+EXPORT_SYMBOL(fb_cfb_read);
 
 static ssize_t
-fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+fb_read(struct file *file, char __user *buf, size_t count, loff_t *ppos)
 {
-	unsigned long p = *ppos;
 	struct fb_info *info = file_fb_info(file);
-	u8 *buffer, *src;
-	u8 __iomem *dst;
-	int c, cnt = 0, err = 0;
-	unsigned long total_size;
 
 	if (!info || !info->screen_base)
 		return -ENODEV;
@@ -840,8 +829,20 @@ fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 	if (info->state != FBINFO_STATE_RUNNING)
 		return -EPERM;
 
-	if (info->fbops->fb_write)
-		return info->fbops->fb_write(info, buf, count, ppos);
+	if (info->fbops->fb_read)
+		return info->fbops->fb_read(info, buf, count, ppos);
+	else
+		return fb_cfb_read(info, buf, count, ppos);
+}
+
+ssize_t fb_cfb_write(struct fb_info *info, const char __user *buf,
+		     size_t count, loff_t *ppos)
+{
+	unsigned long p = *ppos;
+	u8 *buffer, *src;
+	u8 __iomem *dst;
+	int c, cnt = 0, err = 0;
+	unsigned long total_size;
 
 	total_size = info->screen_size;
 
@@ -895,6 +896,24 @@ fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
 
 	return (cnt) ? cnt : err;
 }
+EXPORT_SYMBOL(fb_cfb_write);
+
+static ssize_t
+fb_write(struct file *file, const char __user *buf, size_t count, loff_t *ppos)
+{
+	struct fb_info *info = file_fb_info(file);
+
+	if (!info || !info->screen_base)
+		return -ENODEV;
+
+	if (info->state != FBINFO_STATE_RUNNING)
+		return -EPERM;
+
+	if (info->fbops->fb_write)
+		return info->fbops->fb_write(info, buf, count, ppos);
+	else
+		return fb_cfb_write(info, buf, count, ppos);
+}
 
 int
 fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var)
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 714187bc13ac..12ad83963db5 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -593,6 +593,11 @@ extern int fb_blank(struct fb_info *info, int blank);
 extern void cfb_fillrect(struct fb_info *info, const struct fb_fillrect *rect);
 extern void cfb_copyarea(struct fb_info *info, const struct fb_copyarea *area);
 extern void cfb_imageblit(struct fb_info *info, const struct fb_image *image);
+extern ssize_t fb_cfb_read(struct fb_info *info, char __user *buf,
+			   size_t count, loff_t *ppos);
+extern ssize_t fb_cfb_write(struct fb_info *info, const char __user *buf,
+			    size_t count, loff_t *ppos);
+
 /*
  * Drawing operations where framebuffer is in system RAM
  */
-- 
2.27.0
