From: Albert Herranz <albert_herranz@yahoo.es>
Date: Wed, 12 May 2010 20:51:45 +0000
Subject: [PATCH] fb_defio: fix for non-dirty ptes
Message-Id: <1273697505-23421-1-git-send-email-albert_herranz@yahoo.es>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes a problem observed while using fb_defio with a short
delay on a PowerPC platform.

It is possible that page_mkclean() is invoked in the deferred io work
function _before_ a PTE has been marked dirty. In this case, the page
is removed from the defio pagelist but page_mkclean() does not
write-protect the page again. The end result is that defio ignores all
subsequent writes to the page and the corresponding portions of the
framebuffer never get updated.

The fix consists in keeping track of the pages with non-dirty PTEs,
re-checking them again on the next deferred io work iteration.
Note that those pages are not passed to the defio callback as they are
not written by userspace yet.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 drivers/video/fb_defio.c |   40 ++++++++++++++++++++++++++++++++--------
 1 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fb_defio.c b/drivers/video/fb_defio.c
index 6113c47..1105a59 100644
--- a/drivers/video/fb_defio.c
+++ b/drivers/video/fb_defio.c
@@ -155,25 +155,41 @@ static void fb_deferred_io_work(struct work_struct *work)
 {
 	struct fb_info *info = container_of(work, struct fb_info,
 						deferred_work.work);
-	struct list_head *node, *next;
-	struct page *cur;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct page *page, *tmp_page;
+	struct list_head *node, *tmp_node;
+	struct list_head non_dirty;
+
+	INIT_LIST_HEAD(&non_dirty);
 
 	/* here we mkclean the pages, then do all deferred IO */
 	mutex_lock(&fbdefio->lock);
-	list_for_each_entry(cur, &fbdefio->pagelist, lru) {
-		lock_page(cur);
-		page_mkclean(cur);
-		unlock_page(cur);
+	list_for_each_entry_safe(page, tmp_page, &fbdefio->pagelist, lru) {
+		lock_page(page);
+		/*
+		 * The workqueue callback can be triggered after a
+		 * ->page_mkwrite() call but before the PTE has been marked
+		 * dirty. In this case page_mkclean() won't "rearm" the page.
+		 *
+		 * To avoid this, remove those "non-dirty" pages from the
+		 * pagelist before calling the driver's callback, then add
+		 * them back to get processed on the next work iteration.
+		 * At that time, their PTEs will hopefully be dirty for real.
+		 */
+		if (!page_mkclean(page))
+			list_move_tail(&page->lru, &non_dirty);
+		unlock_page(page);
 	}
 
 	/* driver's callback with pagelist */
 	fbdefio->deferred_io(info, &fbdefio->pagelist);
 
-	/* clear the list */
-	list_for_each_safe(node, next, &fbdefio->pagelist) {
+	/* clear the list... */
+	list_for_each_safe(node, tmp_node, &fbdefio->pagelist) {
 		list_del(node);
 	}
+	/* ... and add back the "non-dirty" pages to the list */
+	list_splice_tail(&non_dirty, &fbdefio->pagelist);
 	mutex_unlock(&fbdefio->lock);
 }
 
@@ -202,6 +218,7 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_open);
 void fb_deferred_io_cleanup(struct fb_info *info)
 {
 	struct fb_deferred_io *fbdefio = info->fbdefio;
+	struct list_head *node, *tmp_node;
 	struct page *page;
 	int i;
 
@@ -209,6 +226,13 @@ void fb_deferred_io_cleanup(struct fb_info *info)
 	cancel_delayed_work(&info->deferred_work);
 	flush_scheduled_work();
 
+	/*  the list may have still some non-dirty pages at this point */
+	mutex_lock(&fbdefio->lock);
+	list_for_each_safe(node, tmp_node, &fbdefio->pagelist) {
+		list_del(node);
+	}
+	mutex_unlock(&fbdefio->lock);
+
 	/* clear out the mapping that we setup */
 	for (i = 0 ; i < info->fix.smem_len; i += PAGE_SIZE) {
 		page = fb_deferred_io_page(info, i);
-- 
1.6.3.3

