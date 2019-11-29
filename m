From: Jani Nikula <jani.nikula@intel.com>
Date: Fri, 29 Nov 2019 10:29:31 +0000
Subject: [PATCH v2 01/14] video: fb_defio: preserve user fb_ops
Message-Id: <022c82429da15d6450ff9ac1a897322ec3124db4.1575022735.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1575022735.git.jani.nikula@intel.com>
In-Reply-To: <cover.1575022735.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Cc: jani.nikula@intel.com, intel-gfx@lists.freedesktop.org, Jaya Kumar <jayalk@intworks.biz>

Modifying fb_ops directly to override fb_mmap with fb_deferred_io_mmap
and then resetting it to NULL afterwards causes problems all over the
place. First, it prevents making the fbops member of struct fb_info a
const pointer, which means we can't make struct fb_ops const
anywhere. Second, a few places have to go out of their way to restore
the original fb_mmap pointer that gets reset to NULL.

Since the only user of the fbops->fb_mmap hook is fb_mmap() in fbmem.c,
call fb_deferred_io_mmap() directly when deferred IO is enabled, and
avoid modifying fb_ops altogether.

Simply use info->fbdefio to determine whether deferred IO should be used
or not. This should be accurate enough for all use cases, although
perhaps not pedantically correct.

v2: Simplify considerably by calling fb_deferred_io_mmap() directly
    (Daniel, Ville)

Cc: Jaya Kumar <jayalk@intworks.biz>
Cc: linux-fbdev@vger.kernel.org
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/video/fbdev/core/fb_defio.c |  3 ---
 drivers/video/fbdev/core/fbmem.c    | 15 +++++++++++----
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 82c20c6047b0..a591d291b231 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -171,7 +171,6 @@ int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma)
 	vma->vm_private_data = info;
 	return 0;
 }
-EXPORT_SYMBOL(fb_deferred_io_mmap);
 
 /* workqueue callback */
 static void fb_deferred_io_work(struct work_struct *work)
@@ -206,7 +205,6 @@ void fb_deferred_io_init(struct fb_info *info)
 
 	BUG_ON(!fbdefio);
 	mutex_init(&fbdefio->lock);
-	info->fbops->fb_mmap = fb_deferred_io_mmap;
 	INIT_DELAYED_WORK(&info->deferred_work, fb_deferred_io_work);
 	INIT_LIST_HEAD(&fbdefio->pagelist);
 	if (fbdefio->delay = 0) /* set a default of 1 s */
@@ -237,7 +235,6 @@ void fb_deferred_io_cleanup(struct fb_info *info)
 		page->mapping = NULL;
 	}
 
-	info->fbops->fb_mmap = NULL;
 	mutex_destroy(&fbdefio->lock);
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 86b06a599f96..990550930a8e 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -1332,16 +1332,23 @@ static int
 fb_mmap(struct file *file, struct vm_area_struct * vma)
 {
 	struct fb_info *info = file_fb_info(file);
-	struct fb_ops *fb;
+	int (*fb_mmap_fn)(struct fb_info *info, struct vm_area_struct *vma);
 	unsigned long mmio_pgoff;
 	unsigned long start;
 	u32 len;
 
 	if (!info)
 		return -ENODEV;
-	fb = info->fbops;
 	mutex_lock(&info->mm_lock);
-	if (fb->fb_mmap) {
+
+	fb_mmap_fn = info->fbops->fb_mmap;
+
+#if IS_ENABLED(CONFIG_FB_DEFERRED_IO)
+	if (info->fbdefio)
+		fb_mmap_fn = fb_deferred_io_mmap;
+#endif
+
+	if (fb_mmap_fn) {
 		int res;
 
 		/*
@@ -1349,7 +1356,7 @@ fb_mmap(struct file *file, struct vm_area_struct * vma)
 		 * SME protection is removed ahead of the call
 		 */
 		vma->vm_page_prot = pgprot_decrypted(vma->vm_page_prot);
-		res = fb->fb_mmap(info, vma);
+		res = fb_mmap_fn(info, vma);
 		mutex_unlock(&info->mm_lock);
 		return res;
 	}
-- 
2.20.1
