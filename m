From: npiggin@suse.de
Subject: [patch 08/18] fb: defio nopage
Date: Wed, 05 Dec 2007 18:15:55 +1100
Message-ID: <20071205071627.577776000@nick.local0.net>
References: <20071205071547.701344000@nick.local0.net>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754894AbXLEH5h@vger.kernel.org>
Content-Disposition: inline; filename=fb-defio-nopage.patch
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: akpm@linux-foundation.org
Cc: linux-fbdev-devel@lists.sourceforge.net, jayakumar.lkml@gmail.com, lethal@linux-sh.org, linux-kernel@vger.kernel.org

Convert fb defio from nopage to fault.
Switch from OOM to SIGBUS if the resource is not available.

Signed-off-by: Nick Piggin <npiggin@suse.de>
Cc: linux-fbdev-devel@lists.sourceforge.net
Cc: jayakumar.lkml@gmail.com
Cc: lethal@linux-sh.org
Cc: linux-kernel@vger.kernel.org
---
 Documentation/fb/deferred_io.txt |    6 +++---
 drivers/video/fb_defio.c         |   17 ++++++++---------
 2 files changed, 11 insertions(+), 12 deletions(-)

Index: linux-2.6/drivers/video/fb_defio.c
===================================================================
--- linux-2.6.orig/drivers/video/fb_defio.c
+++ linux-2.6/drivers/video/fb_defio.c
@@ -25,8 +25,8 @@
 #include <linux/pagemap.h>
 
 /* this is to find and return the vmalloc-ed fb pages */
-static struct page* fb_deferred_io_nopage(struct vm_area_struct *vma,
-					unsigned long vaddr, int *type)
+static int fb_deferred_io_fault(struct vm_area_struct *vma,
+				struct vm_fault *vmf)
 {
 	unsigned long offset;
 	struct page *page;
@@ -34,18 +34,17 @@ static struct page* fb_deferred_io_nopag
 	/* info->screen_base is in System RAM */
 	void *screen_base = (void __force *) info->screen_base;
 
-	offset = (vaddr - vma->vm_start) + (vma->vm_pgoff << PAGE_SHIFT);
+	offset = vmf->pgoff << PAGE_SHIFT;
 	if (offset >= info->fix.smem_len)
-		return NOPAGE_SIGBUS;
+		return VM_FAULT_SIGBUS;
 
 	page = vmalloc_to_page(screen_base + offset);
 	if (!page)
-		return NOPAGE_OOM;
+		return VM_FAULT_SIGBUS;
 
 	get_page(page);
-	if (type)
-		*type = VM_FAULT_MINOR;
-	return page;
+	vmf->page = page;
+	return 0;
 }
 
 int fb_deferred_io_fsync(struct file *file, struct dentry *dentry, int datasync)
@@ -84,7 +83,7 @@ static int fb_deferred_io_mkwrite(struct
 }
 
 static struct vm_operations_struct fb_deferred_io_vm_ops = {
-	.nopage   	= fb_deferred_io_nopage,
+	.fault		= fb_deferred_io_fault,
 	.page_mkwrite	= fb_deferred_io_mkwrite,
 };
 
Index: linux-2.6/Documentation/fb/deferred_io.txt
===================================================================
--- linux-2.6.orig/Documentation/fb/deferred_io.txt
+++ linux-2.6/Documentation/fb/deferred_io.txt
@@ -7,10 +7,10 @@ IO. The following example may be a usefu
 works:
 
 - userspace app like Xfbdev mmaps framebuffer
-- deferred IO and driver sets up nopage and page_mkwrite handlers
+- deferred IO and driver sets up fault and page_mkwrite handlers
 - userspace app tries to write to mmaped vaddress
-- we get pagefault and reach nopage handler
-- nopage handler finds and returns physical page
+- we get pagefault and reach fault handler
+- fault handler finds and returns physical page
 - we get page_mkwrite where we add this page to a list
 - schedule a workqueue task to be run after a delay
 - app continues writing to that page with no additional cost. this is

-- 

