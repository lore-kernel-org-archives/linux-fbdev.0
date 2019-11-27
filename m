From: Jani Nikula <jani.nikula@intel.com>
Date: Wed, 27 Nov 2019 16:31:57 +0000
Subject: [PATCH 01/13] video: fb_defio: preserve user fb_ops
Message-Id: <448995ffd954e0cd2287089cb686e351cc095834.1574871797.git.jani.nikula@intel.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1574871797.git.jani.nikula@intel.com>
In-Reply-To: <cover.1574871797.git.jani.nikula@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: jani.nikula@intel.com, intel-gfx@lists.freedesktop.org, Jaya Kumar <jayalk@intworks.biz>

Modifying fb_ops directly to override fb_mmap with fb_deferred_io_mmap
and then resetting it to NULL afterwards causes problems all over the
place. First, it prevents making the fbops member of struct fb_info a
const pointer, which means we can't make struct fb_ops const
anywhere. Second, a few places have to go out of their way to restore
the original fb_mmap pointer that gets reset to NULL.

Preserve the passed in fb_ops by making a copy of it and modifying that
instead. Add a deferred_io_private member to struct fb_info to store the
pointer to the old fb_ops, and restore that at cleanup.

Cc: Jaya Kumar <jayalk@intworks.biz>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

---

Note: If the approach is acceptable, we'll also need to handle the error
returns on memory allocation failures at fb_deferred_io_init() call
sites. There are 13.
---
 drivers/video/fbdev/core/fb_defio.c | 25 ++++++++++++++++++++++---
 include/linux/fb.h                  |  3 ++-
 2 files changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/video/fbdev/core/fb_defio.c b/drivers/video/fbdev/core/fb_defio.c
index 82c20c6047b0..36697844c1e0 100644
--- a/drivers/video/fbdev/core/fb_defio.c
+++ b/drivers/video/fbdev/core/fb_defio.c
@@ -200,13 +200,23 @@ static void fb_deferred_io_work(struct work_struct *work)
 	mutex_unlock(&fbdefio->lock);
 }
 
-void fb_deferred_io_init(struct fb_info *info)
+int fb_deferred_io_init(struct fb_info *info)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct fb_ops *fbops;
 
 	BUG_ON(!fbdefio);
+
+	fbops = kmemdup(info->fbops, sizeof(*fbops), GFP_KERNEL);
+	if (!fbops)
+		return -ENOMEM;
+
+	fbops->fb_mmap = fb_deferred_io_mmap;
+	info->deferred_io_private = info->fbops;
+	info->fbops = fbops;
+
 	mutex_init(&fbdefio->lock);
-	info->fbops->fb_mmap = fb_deferred_io_mmap;
+
 	INIT_DELAYED_WORK(&info->deferred_work, fb_deferred_io_work);
 	INIT_LIST_HEAD(&fbdefio->pagelist);
 	if (fbdefio->delay = 0) /* set a default of 1 s */
@@ -229,6 +239,12 @@ void fb_deferred_io_cleanup(struct fb_info *info)
 	int i;
 
 	BUG_ON(!fbdefio);
+
+	/* sanity check against misuse */
+	if (WARN_ON(!info->deferred_io_private ||
+		    info->fbops->fb_mmap != fb_deferred_io_mmap))
+		return;
+
 	cancel_delayed_work_sync(&info->deferred_work);
 
 	/* clear out the mapping that we setup */
@@ -237,7 +253,10 @@ void fb_deferred_io_cleanup(struct fb_info *info)
 		page->mapping = NULL;
 	}
 
-	info->fbops->fb_mmap = NULL;
+	kfree(info->fbops);
+	info->fbops = info->deferred_io_private;
+	info->deferred_io_private = NULL;
+
 	mutex_destroy(&fbdefio->lock);
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index a6ad528990de..65f2abd47745 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -470,6 +470,7 @@ struct fb_info {
 #ifdef CONFIG_FB_DEFERRED_IO
 	struct delayed_work deferred_work;
 	struct fb_deferred_io *fbdefio;
+	void *deferred_io_private;
 #endif
 
 	struct fb_ops *fbops;
@@ -658,7 +659,7 @@ static inline void __fb_pad_aligned_buffer(u8 *dst, u32 d_pitch,
 
 /* drivers/video/fb_defio.c */
 int fb_deferred_io_mmap(struct fb_info *info, struct vm_area_struct *vma);
-extern void fb_deferred_io_init(struct fb_info *info);
+extern int fb_deferred_io_init(struct fb_info *info);
 extern void fb_deferred_io_open(struct fb_info *info,
 				struct inode *inode,
 				struct file *file);
-- 
2.20.1
