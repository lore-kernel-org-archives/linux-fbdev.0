From: Vladimir Murzin <vladimir.murzin@arm.com>
Date: Mon, 15 Aug 2016 10:10:32 +0000
Subject: [RESEND PATCH 3/3] fbdev: vfb: simplify memory management
Message-Id: <1471255832-44793-4-git-send-email-vladimir.murzin@arm.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Substitute home-brewed memory management for framebuffer memory with what
core mm provide us: vmalloc_32_user() and remap_vmalloc_range()

The former is designed to allocate virtually contiguous area which is
32bit addressable and zeroed so it can be mapped to userspace without
leaking data. The latter does the similar job to remap_pfn_range() but
additionally validate vmalloc'ed area and it's size.

Signed-off-by: Vladimir Murzin <vladimir.murzin@arm.com>
---
 drivers/video/fbdev/vfb.c |   86 +++------------------------------------------
 1 file changed, 5 insertions(+), 81 deletions(-)

diff --git a/drivers/video/fbdev/vfb.c b/drivers/video/fbdev/vfb.c
index 2645875..1a9b8af 100644
--- a/drivers/video/fbdev/vfb.c
+++ b/drivers/video/fbdev/vfb.c
@@ -41,55 +41,6 @@ static char *mode_option = NULL;
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Preferred video mode (e.g. 640x480-8@60)");
 
-/**********************************************************************
- *
- * Memory management
- *
- **********************************************************************/
-static void *rvmalloc(unsigned long size)
-{
-	void *mem;
-	unsigned long adr;
-
-	size = PAGE_ALIGN(size);
-	mem = vmalloc_32(size);
-	if (!mem)
-		return NULL;
-
-	/*
-	 * VFB must clear memory to prevent kernel info
-	 * leakage into userspace
-	 * VGA-based drivers MUST NOT clear memory if
-	 * they want to be able to take over vgacon
-	 */
-
-	memset(mem, 0, size);
-	adr = (unsigned long) mem;
-	while (size > 0) {
-		SetPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-
-	return mem;
-}
-
-static void rvfree(void *mem, unsigned long size)
-{
-	unsigned long adr;
-
-	if (!mem)
-		return;
-
-	adr = (unsigned long) mem;
-	while ((long) size > 0) {
-		ClearPageReserved(vmalloc_to_page((void *)adr));
-		adr += PAGE_SIZE;
-		size -= PAGE_SIZE;
-	}
-	vfree(mem);
-}
-
 static struct fb_videomode vfb_default = {
 	.xres =		640,
 	.yres =		480,
@@ -418,35 +369,7 @@ static int vfb_pan_display(struct fb_var_screeninfo *var,
 static int vfb_mmap(struct fb_info *info,
 		    struct vm_area_struct *vma)
 {
-	unsigned long start = vma->vm_start;
-	unsigned long size = vma->vm_end - vma->vm_start;
-	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
-	unsigned long page, pos;
-
-	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
-		return -EINVAL;
-	if (size > info->fix.smem_len)
-		return -EINVAL;
-	if (offset > info->fix.smem_len - size)
-		return -EINVAL;
-
-	pos = (unsigned long)info->fix.smem_start + offset;
-
-	while (size > 0) {
-		page = vmalloc_to_pfn((void *)pos);
-		if (remap_pfn_range(vma, start, page, PAGE_SIZE, PAGE_SHARED)) {
-			return -EAGAIN;
-		}
-		start += PAGE_SIZE;
-		pos += PAGE_SIZE;
-		if (size > PAGE_SIZE)
-			size -= PAGE_SIZE;
-		else
-			size = 0;
-	}
-
-	return 0;
-
+	return remap_vmalloc_range(vma, (void *)info->fix.smem_start, vma->vm_pgoff);
 }
 
 #ifndef MODULE
@@ -488,12 +411,13 @@ static int __init vfb_setup(char *options)
 static int vfb_probe(struct platform_device *dev)
 {
 	struct fb_info *info;
+	unsigned int size = PAGE_ALIGN(videomemorysize);
 	int retval = -ENOMEM;
 
 	/*
 	 * For real video cards we use ioremap.
 	 */
-	if (!(videomemory = rvmalloc(videomemorysize)))
+	if (!(videomemory = vmalloc_32_user(size)))
 		return retval;
 
 	info = framebuffer_alloc(sizeof(u32) * 256, &dev->dev);
@@ -534,7 +458,7 @@ err2:
 err1:
 	framebuffer_release(info);
 err:
-	rvfree(videomemory, videomemorysize);
+	vfree(videomemory);
 	return retval;
 }
 
@@ -544,7 +468,7 @@ static int vfb_remove(struct platform_device *dev)
 
 	if (info) {
 		unregister_framebuffer(info);
-		rvfree(videomemory, videomemorysize);
+		vfree(videomemory);
 		fb_dealloc_cmap(&info->cmap);
 		framebuffer_release(info);
 	}
-- 
1.7.9.5

