From: Jaya Kumar <jayakumar.lkml@gmail.com>
Subject: [RFC 2.6.28 1/1] fbdev: defio pagelist to
	pagemap
Date: Mon, 26 Jan 2009 10:15:43 +0800
Message-ID: <12329361431140-git-send-email-jayakumar.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by h25xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <jayakumar.lkml@gmail.com>) id 1LRH7x-0001HE-G0
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Jan 2009 02:23:05 +0000
Received: from rv-out-0708.google.com ([209.85.198.241])
	by 3b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1LRH7o-0007T9-G3 for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 26 Jan 2009 02:23:05 +0000
Received: by rv-out-0708.google.com with SMTP id f25so5830542rvb.22
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 25 Jan 2009 18:22:55 -0800 (PST)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
Cc: linux-fbdev-devel@lists.sourceforge.net, adaplas@gmail.com, Magnus Damm <magnus.damm@gmail.com>, armbru@redhat.com, lethal@linux-sh.org, Geert Uytterhoeven <geert@linux-m68k.org>, Jaya Kumar <jayakumar.lkml@gmail.com>

Hi Magnus, fbdev friends,

As discussed previously, this is version 2 of converting pagelist use
in defio over to pagemap. Thanks to Magnus for ideas and discussion.
The primary change is the use of bitmap ops rather than manual setting
of bits. If everyone is okay with the idea, then we will also need to
convert xen-pvfb, sh and any other drivers using defio. Let me know
your thoughts.

Thanks,
jaya

The defio implementation was using a list structure in order to
track which pages had been written to. Basically, that was a poor
choice and this had been correctly raised as an issue by Tony
a while back and Magnus more recently. This patch is an attempt to
rectify the issue. These changes aren't tested yet, just compiles.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Krzysztof Helt <krzysztof.h1@poczta.fm>
Cc: Magnus Damm <magnus.damm@gmail.com>
Cc: armbru@redhat.com
Cc: lethal@linux-sh.org
Cc: adaplas@gmail.com
Cc: linux-fbdev-devel@lists.sourceforge.net
Signed-off-by: Jaya Kumar <jayakumar.lkml@gmail.com>
---
 drivers/video/broadsheetfb.c |   24 ++++++++-------
 drivers/video/fb_defio.c     |   69 +++++++++++++++++-------------------------
 drivers/video/hecubafb.c     |    3 +-
 drivers/video/metronomefb.c  |   21 +++++++------
 include/linux/fb.h           |    7 ++--
 5 files changed, 57 insertions(+), 67 deletions(-)

diff --git a/drivers/video/broadsheetfb.c b/drivers/video/broadsheetfb.c
index 83fa537..c698935 100644
--- a/drivers/video/broadsheetfb.c
+++ b/drivers/video/broadsheetfb.c
@@ -381,17 +381,16 @@ finish:
 
 
 /* this is called back from the deferred io workqueue */
-static void broadsheetfb_dpy_deferred_io(struct fb_info *info,
-				struct list_head *pagelist)
+static void broadsheetfb_dpy_deferred_io(struct fb_info *info)
 {
 	u16 y1 = 0, h = 0;
 	int prev_index = -1;
-	struct page *cur;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
 	int h_inc;
 	u16 yres = info->var.yres;
 	u16 xres = info->var.xres;
 	int ret;
+	int i;
 
 	/* if we have damage data then use it exclusively */
 	ret = broadsheetfb_process_damage(info);
@@ -403,26 +402,29 @@ static void broadsheetfb_dpy_deferred_io(struct fb_info *info,
 	/* height increment is fixed per page */
 	h_inc = DIV_ROUND_UP(PAGE_SIZE , xres);
 
-	/* walk the written page list and swizzle the data */
-	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
+	for (i = find_first_bit(fbdefio->pagemap, fbdefio->pagecount);
+		i < fbdefio->pagecount;
+		i = find_next_bit(fbdefio->pagemap, fbdefio->pagecount, i),
+		i++) {
 		if (prev_index < 0) {
 			/* just starting so assign first page */
-			y1 = (cur->index << PAGE_SHIFT) / xres;
+			y1 = (i << PAGE_SHIFT) / xres;
 			h = h_inc;
-		} else if ((prev_index + 1) == cur->index) {
+		} else if ((prev_index + 1) == i) {
 			/* this page is consecutive so increase our height */
 			h += h_inc;
 		} else {
 			/* page not consecutive, issue previous update first */
-			broadsheetfb_dpy_update_pages(info->par, y1,
-							min(y1 + h, yres));
+			broadsheetfb_dpy_update_pages(info->par,
+					y1, min((u16) (y1 + h), yres));
 			/* start over with our non consecutive page */
-			y1 = (cur->index << PAGE_SHIFT) / xres;
+			y1 = (i << PAGE_SHIFT) / xres;
 			h = h_inc;
 		}
-		prev_index = cur->index;
+		prev_index = i;
 	}
 
+
 	/* if we still have any pages to update we do so now */
 	if (h >= yres) {
 		/* its a full screen update, just do it */
diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
index bcc3175..dbe9f32 100644
--- a/drivers/video/fb_defio.c
+++ b/drivers/video/fb_defio.c
@@ -18,9 +18,9 @@
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/fb.h>
-#include <linux/list.h>
 #include <linux/rmap.h>
 #include <linux/pagemap.h>
+#include <linux/bitops.h>
 
 static struct page *fb_deferred_io_page(struct fb_info *info, unsigned long offs)
 {
@@ -82,37 +82,14 @@ int fb_deferred_io_fsync(struct file *file, struct dentry *dentry, int datasync)
 EXPORT_SYMBOL_GPL(fb_deferred_io_fsync);
 
 /*
- * Adds page to list of dirty pages, keeps it in sorted order and handles
- * checking for duplicates.
+ * Set page to mark it dirty in our pagemap
  */
-static void fb_defio_pagelist_add(struct fb_deferred_io *fbdefio,
+static void fb_defio_set_pagemap(struct fb_deferred_io *fbdefio,
 					struct page *page)
 {
-	struct page *cur;
-	/* protect against the workqueue changing the page list */
+	/* protect against the workqueue changing the pagemap */
 	mutex_lock(&fbdefio->lock);
-
-	/*
-	 * We loop through the pagelist before adding in order
-	 * to keep the pagelist sorted.
-	 */
-	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
-		/*
-		 * This check is to catch the case where a new
-		 * process could start writing to the same page
-		 * through a new pte. This new access will cause the
-		 * mkwrite even when the original ps's pte is marked
-		 * writable.
-		 */
-		if (unlikely(cur == page))
-			goto page_already_added;
-		else if (cur->index > page->index)
-			break;
-	}
-
-	list_add_tail(&page->lru, &cur->lru);
-
-page_already_added:
+	set_bit(page->index, fbdefio->pagemap);
 	mutex_unlock(&fbdefio->lock);
 }
 
@@ -131,7 +108,7 @@ static int fb_deferred_io_mkwrite(struct vm_area_struct *vma,
 	 * again, we repeat the same scheme
 	 */
 
-	fb_defio_pagelist_add(fbdefio, page);
+	fb_defio_set_pagemap(fbdefio, page);
 
 	/* Come back after delay to process the deferred IO */
 	schedule_delayed_work(&info->deferred_work, fbdefio->delay);
@@ -167,37 +144,44 @@ static void fb_deferred_io_work(struct work_struct *work)
 {
 	struct fb_info *info = container_of(work, struct fb_info,
 						deferred_work.work);
-	struct list_head *node, *next;
 	struct page *cur;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	int i;
 
 	/* Here we mkclean the pages, then do all deferred IO */
 	mutex_lock(&fbdefio->lock);
-	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
+
+	/* walk the pagemap to find written pages and then clean them */
+	for (i = find_first_bit(fbdefio->pagemap, fbdefio->pagecount);
+		i < fbdefio->pagecount;
+		i = find_next_bit(fbdefio->pagemap, fbdefio->pagecount, i),
+		i++) {
+		cur = fb_deferred_io_page(info, i * PAGE_SIZE);
 		lock_page(cur);
 		page_mkclean(cur);
 		unlock_page(cur);
 	}
 
-	/* driver's callback with pagelist */
-	fbdefio->deferred_io(info, &fbdefio->pagelist);
+	/* now do driver's callback to pass them the pagemap */
+	fbdefio->deferred_io(info);
 
-	/* Clear the list */
-	list_for_each_safe(node, next, &fbdefio->pagelist) {
-		list_del(node);
-	}
+	/* Clear the pagemap */
+	bitmap_zero(fbdefio->pagemap, fbdefio->pagecount);
 	mutex_unlock(&fbdefio->lock);
 }
 
 void fb_deferred_io_init(struct fb_info *info)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	int pmap_bytes;
 
 	BUG_ON(!fbdefio);
 	mutex_init(&fbdefio->lock);
 	info->fbops->fb_mmap = fb_deferred_io_mmap;
 	INIT_DELAYED_WORK(&info->deferred_work, fb_deferred_io_work);
-	INIT_LIST_HEAD(&fbdefio->pagelist);
+	fbdefio->pagecount = DIV_ROUND_UP(info->fix.smem_len, PAGE_SIZE);
+	pmap_bytes = DIV_ROUND_UP(fbdefio->pagecount, sizeof(u32));
+	fbdefio->pagemap = kzalloc(pmap_bytes, GFP_KERNEL);
 	if (fbdefio->delay == 0) /* set a default of 1 s */
 		fbdefio->delay = HZ;
 }
@@ -224,11 +208,14 @@ void fb_deferred_io_cleanup(struct fb_info *info)
 	/* clear out the mapping that we setup */
 	for (i = 0 ; i < info->fix.smem_len; i += PAGE_SIZE) {
 		page = fb_deferred_io_page(info, i);
+		lock_page(page);
 		page->mapping = NULL;
+		unlock_page(page);
 	}
 
 	info->fbops->fb_mmap = NULL;
 	mutex_destroy(&fbdefio->lock);
+	kfree(fbdefio->pagemap);
 }
 EXPORT_SYMBOL_GPL(fb_deferred_io_cleanup);
 
@@ -256,7 +243,7 @@ ssize_t fb_defio_write(struct fb_info *info, const char __user *buf,
 	if (!fbdefio)
 		return wr_count;
 
-	/* now we must list the pages fb_sys_write has written. */
+	/* now we must walk the pages fb_sys_write has written. */
 	for (i = orig_p ; i < (orig_p + wr_count) ; i += PAGE_SIZE) {
 
 		/* get the right page */
@@ -273,8 +260,8 @@ ssize_t fb_defio_write(struct fb_info *info, const char __user *buf,
 		if (!page->index)
 			page->index = i >> PAGE_SHIFT;
 
-		/* add it to our touched list */
-		fb_defio_pagelist_add(fbdefio, page);
+		/* set it in our pagemap */
+		fb_defio_set_pagemap(fbdefio, page);
 	}
 
 	/* now we schedule our deferred work */
diff --git a/drivers/video/hecubafb.c b/drivers/video/hecubafb.c
index 0b4bffb..7d2a80b 100644
--- a/drivers/video/hecubafb.c
+++ b/drivers/video/hecubafb.c
@@ -116,8 +116,7 @@ static void hecubafb_dpy_update(struct hecubafb_par *par)
 }
 
 /* this is called back from the deferred io workqueue */
-static void hecubafb_dpy_deferred_io(struct fb_info *info,
-				struct list_head *pagelist)
+static void hecubafb_dpy_deferred_io(struct fb_info *info)
 {
 	hecubafb_dpy_update(info->par);
 }
diff --git a/drivers/video/metronomefb.c b/drivers/video/metronomefb.c
index 1de2081..cc29711 100644
--- a/drivers/video/metronomefb.c
+++ b/drivers/video/metronomefb.c
@@ -30,7 +30,6 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
-#include <linux/list.h>
 #include <linux/firmware.h>
 #include <linux/dma-mapping.h>
 #include <linux/uaccess.h>
@@ -464,20 +463,22 @@ static u16 metronomefb_dpy_update_page(struct metronomefb_par *par, int index)
 }
 
 /* this is called back from the deferred io workqueue */
-static void metronomefb_dpy_deferred_io(struct fb_info *info,
-				struct list_head *pagelist)
+static void metronomefb_dpy_deferred_io(struct fb_info *info)
 {
 	u16 cksum;
-	struct page *cur;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
 	struct metronomefb_par *par = info->par;
+	int i;
+
+	/* walk the written page map and swizzle the data */
+	for (i = find_first_bit(fbdefio->pagemap, fbdefio->pagecount);
+		i < fbdefio->pagecount;
+		i = find_next_bit(fbdefio->pagemap, fbdefio->pagecount, i),
+		i++) {
 
-	/* walk the written page list and swizzle the data */
-	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
-		cksum = metronomefb_dpy_update_page(par,
-					(cur->index << PAGE_SHIFT));
-		par->metromem_img_csum -= par->csum_table[cur->index];
-		par->csum_table[cur->index] = cksum;
+		cksum = metronomefb_dpy_update_page(par, (i << PAGE_SHIFT));
+		par->metromem_img_csum -= par->csum_table[i];
+		par->csum_table[i] = cksum;
 		par->metromem_img_csum += cksum;
 	}
 
diff --git a/include/linux/fb.h b/include/linux/fb.h
index a92ed07..d1e849a 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -600,10 +600,11 @@ struct fb_pixmap {
 struct fb_deferred_io {
 	/* delay between mkwrite and deferred handler */
 	unsigned long delay;
-	struct mutex lock; /* mutex that protects the page list */
-	struct list_head pagelist; /* list of touched pages */
+	struct mutex lock; /* mutex that protects the pagemap */
+	int pagecount; /* count of pages */
+	unsigned long *pagemap; /* bitmap of touched pages */
 	/* callback */
-	void (*deferred_io)(struct fb_info *info, struct list_head *pagelist);
+	void (*deferred_io)(struct fb_info *info);
 };
 #endif
 
-- 
1.5.2.3


------------------------------------------------------------------------------
This SF.net email is sponsored by:
SourcForge Community
SourceForge wants to tell your story.
http://p.sf.net/sfu/sf-spreadtheword
