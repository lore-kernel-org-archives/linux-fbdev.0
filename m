From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.27 1/1] fb_defio: generic write support
Date: Fri, 26 Dec 2008 03:49:11 +0800
Message-ID: <12302345513642-git-send-email-jayakumar.lkml@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Jaya Kumar <jayakumar.lkml@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, linux-fbdev-devel@lists.sourceforge.net, aliguori@us.ibm.com, adaplas@gmail.com, linux-sh@vger.kernel.org, armbru@redhat.com, lethal@linux-sh.org

This patch implements generic write support that can be used by deferred IO
client drivers. It reuses the same deferred IO callback mechanism in existing
client drivers and uses the pagelist to inform the client driver which pages
were modified in the write call. It should be possible to extend this same
method to imageblit/copyarea/fillrect as well. metronomefb's write has been
removed in favour of using this mechanism. This patch depends on Magnus'
patchset to add defio support for dma/kmalloc-ed memory.

Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: linux-fbdev-devel@lists.sourceforge.net
Cc: aliguori@us.ibm.com
Cc: adaplas@gmail.com
Cc: linux-sh@vger.kernel.org
Cc: armbru@redhat.com
Cc: lethal@linux-sh.org
---
 drivers/video/Kconfig       |    4 ++
 drivers/video/fb_defio.c    |  116 +++++++++++++++++++++++++++++++++---------
 drivers/video/metronomefb.c |   48 +-----------------
 include/linux/fb.h          |    2 +
 4 files changed, 98 insertions(+), 72 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 3f3ce13..a96f62e 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -179,6 +179,10 @@ config FB_SYS_FOPS
 config FB_DEFERRED_IO
 	bool
 	depends on FB
+	select FB_SYS_FILLRECT
+	select FB_SYS_COPYAREA
+	select FB_SYS_IMAGEBLIT
+	select FB_SYS_FOPS
 
 config FB_HECUBA
 	tristate
diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
index ed49981..bcc3175 100644
--- a/drivers/video/fb_defio.c
+++ b/drivers/video/fb_defio.c
@@ -19,8 +19,6 @@
 #include <linux/interrupt.h>
 #include <linux/fb.h>
 #include <linux/list.h>
-
-/* to support deferred IO */
 #include <linux/rmap.h>
 #include <linux/pagemap.h>
 
@@ -37,7 +35,7 @@ static struct page *fb_deferred_io_page(struct fb_info *info, unsigned long offs
 	return page;
 }
 
-/* this is to find and return the vmalloc-ed fb pages */
+/* This is to find and return the fb pages */
 static int fb_deferred_io_fault(struct vm_area_struct *vma,
 				struct vm_fault *vmf)
 {
@@ -83,31 +81,29 @@ int fb_deferred_io_fsync(struct file *file, struct dentry *dentry, int datasync)
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_fsync);
 
-/* vm_ops->page_mkwrite handler */
-static int fb_deferred_io_mkwrite(struct vm_area_struct *vma,
-				  struct page *page)
+/*
+ * Adds page to list of dirty pages, keeps it in sorted order and handles
+ * checking for duplicates.
+ */
+static void fb_defio_pagelist_add(struct fb_deferred_io *fbdefio,
+					struct page *page)
 {
-	struct fb_info *info = vma->vm_private_data;
-	struct fb_deferred_io *fbdefio = info->fbdefio;
 	struct page *cur;
-
-	/* this is a callback we get when userspace first tries to
-	write to the page. we schedule a workqueue. that workqueue
-	will eventually mkclean the touched pages and execute the
-	deferred framebuffer IO. then if userspace touches a page
-	again, we repeat the same scheme */
-
 	/* protect against the workqueue changing the page list */
 	mutex_lock(&fbdefio->lock);
 
-	/* we loop through the pagelist before adding in order
-	to keep the pagelist sorted */
+	/*
+	 * We loop through the pagelist before adding in order
+	 * to keep the pagelist sorted.
+	 */
 	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
-		/* this check is to catch the case where a new
-		process could start writing to the same page
-		through a new pte. this new access can cause the
-		mkwrite even when the original ps's pte is marked
-		writable */
+		/*
+		 * This check is to catch the case where a new
+		 * process could start writing to the same page
+		 * through a new pte. This new access will cause the
+		 * mkwrite even when the original ps's pte is marked
+		 * writable.
+		 */
 		if (unlikely(cur == page))
 			goto page_already_added;
 		else if (cur->index > page->index)
@@ -118,8 +114,26 @@ static int fb_deferred_io_mkwrite(struct vm_area_struct *vma,
 
 page_already_added:
 	mutex_unlock(&fbdefio->lock);
+}
+
+/* vm_ops->page_mkwrite handler */
+static int fb_deferred_io_mkwrite(struct vm_area_struct *vma,
+				  struct page *page)
+{
+	struct fb_info *info = vma->vm_private_data;
+	struct fb_deferred_io *fbdefio = info->fbdefio;
+
+	/*
+	 * This is a callback we get when userspace first tries to
+	 * write to the page. We schedule a workqueue. That workqueue
+	 * will eventually mkclean the touched pages and execute the
+	 * deferred framebuffer IO. Then, if userspace touches a page
+	 * again, we repeat the same scheme
+	 */
 
-	/* come back after delay to process the deferred IO */
+	fb_defio_pagelist_add(fbdefio, page);
+
+	/* Come back after delay to process the deferred IO */
 	schedule_delayed_work(&info->deferred_work, fbdefio->delay);
 	return 0;
 }
@@ -157,7 +171,7 @@ static void fb_deferred_io_work(struct work_struct *work)
 	struct page *cur;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
 
-	/* here we mkclean the pages, then do all deferred IO */
+	/* Here we mkclean the pages, then do all deferred IO */
 	mutex_lock(&fbdefio->lock);
 	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
 		lock_page(cur);
@@ -168,7 +182,7 @@ static void fb_deferred_io_work(struct work_struct *work)
 	/* driver's callback with pagelist */
 	fbdefio->deferred_io(info, &fbdefio->pagelist);
 
-	/* clear the list */
+	/* Clear the list */
 	list_for_each_safe(node, next, &fbdefio->pagelist) {
 		list_del(node);
 	}
@@ -218,4 +232,56 @@ void fb_deferred_io_cleanup(struct fb_info *info)
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
 
+ssize_t fb_defio_write(struct fb_info *info, const char __user *buf,
+				size_t count, loff_t *ppos)
+{
+	ssize_t wr_count;
+	unsigned long i;
+	struct fb_deferred_io *fbdefio;
+	struct page *page;
+	unsigned long orig_p = *ppos;
+
+	/*
+	 * fb_sys_write can return err but have completed some portion
+	 * of a write. In such a scenario, we just leave that data since
+	 * it is incomplete and its a fb so a subsequent write should
+	 * clear things up.
+	 */
+	wr_count = fb_sys_write(info, buf, count, ppos);
+	if (wr_count <= 0)
+		return wr_count;
+
+	/* if not using defio, we're done here. */
+	fbdefio = info->fbdefio;
+	if (!fbdefio)
+		return wr_count;
+
+	/* now we must list the pages fb_sys_write has written. */
+	for (i = orig_p ; i < (orig_p + wr_count) ; i += PAGE_SIZE) {
+
+		/* get the right page */
+		page = fb_deferred_io_page(info, i);
+
+		/*
+		 * It is ok if user mappings haven't been setup, the only
+		 * requirement is that index is setup for the user. The
+		 * reasoning is that, if there is a user mapping, we are
+		 * already in good shape, if there isn't than mkclean
+		 * will just fail but this should have no ill impact on us
+		 * or the client driver.
+		 */
+		if (!page->index)
+			page->index = i >> PAGE_SHIFT;
+
+		/* add it to our touched list */
+		fb_defio_pagelist_add(fbdefio, page);
+	}
+
+	/* now we schedule our deferred work */
+	schedule_delayed_work(&info->deferred_work, fbdefio->delay);
+
+	return wr_count;
+}
+EXPORT_SYMBOL_GPL(fb_defio_write);
+
 MODULE_LICENSE("GPL");
diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index df1f757..1de2081 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -511,55 +511,9 @@ static void metronomefb_imageblit(struct fb_info *info,
 	metronomefb_dpy_update(par);
 }
 
-/*
- * this is the slow path from userspace. they can seek and write to
- * the fb. it is based on fb_sys_write
- */
-static ssize_t metronomefb_write(struct fb_info *info, const char __user *buf,
-				size_t count, loff_t *ppos)
-{
-	struct metronomefb_par *par = info->par;
-	unsigned long p = *ppos;
-	void *dst;
-	int err = 0;
-	unsigned long total_size;
-
-	if (info->state != FBINFO_STATE_RUNNING)
-		return -EPERM;
-
-	total_size = info->fix.smem_len;
-
-	if (p > total_size)
-		return -EFBIG;
-
-	if (count > total_size) {
-		err = -EFBIG;
-		count = total_size;
-	}
-
-	if (count + p > total_size) {
-		if (!err)
-			err = -ENOSPC;
-
-		count = total_size - p;
-	}
-
-	dst = (void __force *)(info->screen_base + p);
-
-	if (copy_from_user(dst, buf, count))
-		err = -EFAULT;
-
-	if  (!err)
-		*ppos += count;
-
-	metronomefb_dpy_update(par);
-
-	return (err) ? err : count;
-}
-
 static struct fb_ops metronomefb_ops = {
 	.owner		= THIS_MODULE,
-	.fb_write	= metronomefb_write,
+	.fb_write	= fb_defio_write,
 	.fb_fillrect	= metronomefb_fillrect,
 	.fb_copyarea	= metronomefb_copyarea,
 	.fb_imageblit	= metronomefb_imageblit,
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 75a81ea..59e4f32 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -983,6 +983,8 @@ extern void fb_deferred_io_open(struct fb_info *info,
 extern void fb_deferred_io_cleanup(struct fb_info *info);
 extern int fb_deferred_io_fsync(struct file *file, struct dentry *dentry,
 				int datasync);
+ssize_t fb_defio_write(struct fb_info *info, const char __user *buf,
+				size_t count, loff_t *ppos);
 
 static inline bool fb_be_math(struct fb_info *info)
 {
-- 
1.5.2.3

