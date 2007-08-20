From: Ilya Yanok <ilya.yanok@gmail.com>
Subject: [PATCH] vfb: make virtual framebuffer mmapable
Date: Mon, 20 Aug 2007 21:44:09 +0000 (UTC)
Message-ID: <loom.20070820T234228-300@post.gmane.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1INFIG-0006MU-PZ for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Aug 2007 15:00:16 -0700
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1INFIG-0002RQ-58
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 20 Aug 2007 15:00:16 -0700
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1INFI2-0006Ht-6m for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 21 Aug 2007 00:00:02 +0200
Received: from pppoe-48.48.110.89-adsl.spbnit.ru ([89.110.48.48])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00 for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 21 Aug 2007 00:00:02 +0200
Received: from ilya.yanok by pppoe-48.48.110.89-adsl.spbnit.ru with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 21 Aug 2007 00:00:02 +0200
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
To: linux-fbdev-devel@lists.sourceforge.net

Changed things:
1. vmalloc()/vfree() replaced with rvmalloc()/rvfree() (taken from
drivers/media/video/se401.c)
2. mmap method implemented (mostly taken from drivers/media/video/se401.c)
3. smem_start and smem_len fields of struct fb_fix_screeninfo initialized.
(smem_start initialized with virtual address, don't know if it is really
bad...)
---
 drivers/video/vfb.c |   78 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 74 insertions(+), 4 deletions(-)

diff --git a/drivers/video/vfb.c b/drivers/video/vfb.c
index 64ee78c..7d8cdcb 100644
--- a/drivers/video/vfb.c
+++ b/drivers/video/vfb.c
@@ -38,6 +38,48 @@ static void *videomemory;
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
@@ -372,7 +414,33 @@ static int vfb_pan_display(struct fb_var_screeninfo *var,
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
@@ -407,7 +475,7 @@ static int __init vfb_probe(struct platform_device *dev)
 	/*
 	 * For real video cards we use ioremap.
 	 */
-	if (!(videomemory = vmalloc(videomemorysize)))
+	if (!(videomemory = rvmalloc(videomemorysize)))
 		return retval;
 
 	/*
@@ -430,6 +498,8 @@ static int __init vfb_probe(struct platform_device *dev)
 
 	if (!retval || (retval == 4))
 		info->var = vfb_default;
+	vfb_fix.smem_start = videomemory;
+	vfb_fix.smem_len = videomemorysize;
 	info->fix = vfb_fix;
 	info->pseudo_palette = info->par;
 	info->par = NULL;
@@ -453,7 +523,7 @@ err2:
 err1:
 	framebuffer_release(info);
 err:
-	vfree(videomemory);
+	rvfree(videomemory, videomemorysize);
 	return retval;
 }
 
@@ -463,7 +533,7 @@ static int vfb_remove(struct platform_device *dev)
 
 	if (info) {
 		unregister_framebuffer(info);
-		vfree(videomemory);
+		rvfree(videomemory, videomemorysize);
 		framebuffer_release(info);
 	}
 	return 0;
-- 
1.5.2.4



-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
