From: Thomas Zimmermann <tzimmermann@suse.de>
Date: Tue, 26 Mar 2019 09:17:37 +0000
Subject: [PATCH 04/11] drm/fbdevdrm: Add file operations
Message-Id: <20190326091744.11542-5-tzimmermann@suse.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20190326091744.11542-1-tzimmermann@suse.de>
In-Reply-To: <20190326091744.11542-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: airlied@linux.ie, daniel@ffwll.ch, b.zolnierkie@samsung.com
Cc: linux-fbdev@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>, dri-devel@lists.freedesktop.org

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c | 29 ++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c b/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
index 5be902094dc6..4a6ba6c85c5c 100644
--- a/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
+++ b/drivers/gpu/drm/fbdevdrm/fbdevdrm_drv.c
@@ -11,6 +11,8 @@
  */
 
 #include <drm/drm_drv.h>
+#include <drm/drm_file.h>
+#include <drm/drm_ioctl.h>
 #include <drm/drm_print.h>
 #include <linux/console.h> /* for console_{un/lock}() */
 #include <linux/fb.h>
@@ -38,6 +40,30 @@
  * DRM driver
  */
 
+static int driver_fops_mmap(struct file *filp, struct vm_area_struct *vma)
+{
+	struct drm_file *file_priv = filp->private_data;
+	struct fbdevdrm_device *fdev = file_priv->minor->dev->dev_private;
+
+	if (unlikely(vma->vm_pgoff < DRM_FILE_PAGE_OFFSET))
+		return -EINVAL;
+
+	return ttm_bo_mmap(filp, vma, &fdev->ttm.bdev);
+}
+
+static const struct file_operations driver_fops = {
+	.owner = THIS_MODULE,
+	.open = drm_open,
+	.release = drm_release,
+	.unlocked_ioctl = drm_ioctl,
+	.mmap = driver_fops_mmap,
+	.poll = drm_poll,
+#ifdef CONFIG_COMPAT
+	.compat_ioctl = drm_compat_ioctl,
+#endif
+	.read = drm_read
+};
+
 static struct drm_driver fbdevdrm_drv = {
 	/* data fields */
 	.major = DRIVER_MAJOR,
@@ -45,7 +71,8 @@ static struct drm_driver fbdevdrm_drv = {
 	.patchlevel = DRIVER_PATCHLEVEL,
 	.name = DRIVER_NAME,
 	.desc = DRIVER_DESCRIPTION,
-	.date = DRIVER_DATE
+	.date = DRIVER_DATE,
+	.fops = &driver_fops
 };
 
 /* Device list */
-- 
2.21.0
