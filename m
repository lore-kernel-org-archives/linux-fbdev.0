From: Magnus Damm <magnus.damm@gmail.com>
Subject: [PATCH 03/05] video: deferred io with physically contiguous memory
Date: Fri, 19 Dec 2008 15:34:32 +0900
Message-ID: <20081219063432.2703.91443.sendpatchset@rx1.opensource.se>
References: <20081219063359.2703.85817.sendpatchset@rx1.opensource.se>
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20081219063359.2703.85817.sendpatchset@rx1.opensource.se>
Sender: linux-sh-owner@vger.kernel.org
List-ID: <fbdev-devel.lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Magnus Damm <magnus.damm@gmail.com>, lethal@linux-sh.org, adaplas@gmail.com, linux-sh@vger.kernel.org

From: Magnus Damm <damm@igel.co.jp>

Extend the deferred io code from only supporting vmalloc()ed frame
buffer memory to support both vmalloc()ed and physically contiguous
frame buffer memory.

The sh_mobile_lcdcfb hardware does not support scatter gather so
we need physically contiguous memory to back our frame buffer.

Signed-off-by: Magnus Damm <damm@igel.co.jp>
---

 drivers/video/fb_defio.c |   20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

--- 0003/drivers/video/fb_defio.c
+++ work/drivers/video/fb_defio.c	2008-12-19 14:29:45.000000000 +0900
@@ -24,6 +24,19 @@
 #include <linux/rmap.h>
 #include <linux/pagemap.h>
 
+struct page *fb_deferred_io_page(struct fb_info *info, unsigned long offs)
+{
+	void *screen_base = (void __force *) info->screen_base;
+	struct page *page;
+
+	if (is_vmalloc_addr(screen_base + offs))
+		page = vmalloc_to_page(screen_base + offs);
+	else
+		page = pfn_to_page((info->fix.smem_start + offs) >> PAGE_SHIFT);
+
+	return page;
+}
+
 /* this is to find and return the vmalloc-ed fb pages */
 static int fb_deferred_io_fault(struct vm_area_struct *vma,
 				struct vm_fault *vmf)
@@ -31,14 +44,12 @@ static int fb_deferred_io_fault(struct v
 	unsigned long offset;
 	struct page *page;
 	struct fb_info *info = vma->vm_private_data;
-	/* info->screen_base is virtual memory */
-	void *screen_base = (void __force *) info->screen_base;
 
 	offset = vmf->pgoff << PAGE_SHIFT;
 	if (offset >= info->fix.smem_len)
 		return VM_FAULT_SIGBUS;
 
-	page = vmalloc_to_page(screen_base + offset);
+	page = fb_deferred_io_page(info, offset);
 	if (!page)
 		return VM_FAULT_SIGBUS;
 
@@ -188,7 +199,6 @@ EXPORT_SYMBOL_GPL(fb_deferred_io_open);
 
 void fb_deferred_io_cleanup(struct fb_info *info)
 {
-	void *screen_base = (void __force *) info->screen_base;
 	struct fb_deferred_io *fbdefio = info->fbdefio;
 	struct page *page;
 	int i;
@@ -199,7 +209,7 @@ void fb_deferred_io_cleanup(struct fb_in
 
 	/* clear out the mapping that we setup */
 	for (i = 0 ; i < info->fix.smem_len; i += PAGE_SIZE) {
-		page = vmalloc_to_page(screen_base + i);
+		page = fb_deferred_io_page(info, i);
 		page->mapping = NULL;
 	}
 
