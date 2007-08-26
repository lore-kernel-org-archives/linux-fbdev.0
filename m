From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 20/20] vfb: make virtual framebuffer
	mmapable
Date: Sun, 26 Aug 2007 22:19:16 +0800
Message-ID: <46D18BE4.5000604@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IPJBr-0006FA-So for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:34:11 -0700
Received: from nz-out-0506.google.com ([64.233.162.237])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1IPJ2v-00088d-9v
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 26 Aug 2007 07:24:57 -0700
Received: by nz-out-0506.google.com with SMTP id f1so2918589nzc
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 26 Aug 2007 07:24:57 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Ilya Yanok <ilya.yanok@gmail.com>

From: Ilya Yanok <ilya.yanok@gmail.com>

Changed things:
1. vmalloc()/vfree() replaced with rvmalloc()/rvfree() (taken from
drivers/media/video/se401.c)
2. mmap method implemented (mostly taken from drivers/media/video/se401.c)
3. smem_start and smem_len fields of struct fb_fix_screeninfo initialized.
(smem_start initialized with virtual address, don't know if it is really
bad...)

[adaplas: sparse warning fix]

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/vfb.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
index 02cfc6a..072638a 100644
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -37,6 +37,48 @@ static void *videomemory;
 static u_long videomemorysize = VIDEOMEMSIZE;
 module_param(videomemorysize, ulong, 0);
 
+/**********************************************************************
+ *
+ * Memory management
+ *
+ **********************************************************************/
+static void *rvmalloc(unsigned long size)
+{
+	void *mem;
+	unsigned long adr;
+
+	size = PAGE_ALIGN(size);
+	mem = vmalloc_32(size);
+	if (!mem)
+		return NULL;
+
+	memset(mem, 0, size); /* Clear the ram out, no junk to the user */
+	adr = (unsigned long) mem;
+	while (size > 0) {
+		SetPageReserved(vmalloc_to_page((void *)adr));
+		adr += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	}
+
+	return mem;
+}
+
+static void rvfree(void *mem, unsigned long size)
+{
+	unsigned long adr;
+
+	if (!mem)
+		return;
+
+	adr = (unsigned long) mem;
+	while ((long) size > 0) {
+		ClearPageReserved(vmalloc_to_page((void *)adr));
+		adr += PAGE_SIZE;
+		size -= PAGE_SIZE;
+	}
+	vfree(mem);
+}
+
 static struct fb_var_screeninfo vfb_default __initdata = {
 	.xres =		640,
 	.yres =		480,
@@ -371,7 +413,33 @@ static int vfb_pan_display(struct fb_var
 static int vfb_mmap(struct fb_info *info,
 		    struct vm_area_struct *vma)
 {
-	return -EINVAL;
+	unsigned long start = vma->vm_start;
+	unsigned long size = vma->vm_end - vma->vm_start;
+	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
+	unsigned long page, pos;
+
+	if (offset + size > info->fix.smem_len) {
+		return -EINVAL;
+	}
+
+	pos = (unsigned long)info->fix.smem_start + offset;
+
+	while (size > 0) {
+		page = vmalloc_to_pfn((void *)pos);
+		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
+			return -EAGAIN;
+		}
+		start += PAGE_SIZE;
+		pos += PAGE_SIZE;
+		if (size > PAGE_SIZE)
+			size -= PAGE_SIZE;
+		else
+			size = 0;
+	}
+
+	vma->vm_flags |= VM_RESERVED;	/* avoid to swap out this VMA */
+	return 0;
+
 }
 
 #ifndef MODULE
@@ -406,7 +474,7 @@ static int __init vfb_probe(struct platf
 	/*
 	 * For real video cards we use ioremap.
 	 */
-	if (!(videomemory = vmalloc(videomemorysize)))
+	if (!(videomemory = rvmalloc(videomemorysize)))
 		return retval;
 
 	/*
@@ -429,6 +497,8 @@ static int __init vfb_probe(struct platf
 
 	if (!retval || (retval == 4))
 		info->var = vfb_default;
+	vfb_fix.smem_start = (unsigned long) videomemory;
+	vfb_fix.smem_len = videomemorysize;
 	info->fix = vfb_fix;
 	info->pseudo_palette = info->par;
 	info->par = NULL;
@@ -452,7 +522,7 @@ err2:
 err1:
 	framebuffer_release(info);
 err:
-	vfree(videomemory);
+	rvfree(videomemory, videomemorysize);
 	return retval;
 }
 
@@ -462,7 +532,7 @@ static int vfb_remove(struct platform_de
 
 	if (info) {
 		unregister_framebuffer(info);
-		vfree(videomemory);
+		rvfree(videomemory, videomemorysize);
 		framebuffer_release(info);
 	}
 	return 0;


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
