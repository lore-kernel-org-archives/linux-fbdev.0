From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] acornfb: remove fb_mmap function
Date: Wed, 20 May 2009 14:16:17 +0200
Message-ID: <20090520141617.df20bd72.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=unsubscribe>
List-Archive: <http://lists.arm.linux.org.uk/lurker/list/linux-arm-kernel.html>
List-Post: <mailto:linux-arm-kernel@lists.arm.linux.org.uk>
List-Help: <mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=help>
List-Subscribe: <http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.arm.linux.org.uk?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.arm.linux.org.uk
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.arm.linux.org.uk
To: linux-arm-kernel <linux-arm-kernel@lists.arm.linux.org.uk>, Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>, Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The driver's fb_mmap function is essentially the same
as a generic fb_mmap function. Delete driver's function
and use the generic one.

A difference is that generic function marks frame buffer
memory as VM_IO | VM_RESERVED. The driver's function marks
it as VM_IO only.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---

This patch is for the next kernel version (2.6.31).

 drivers/video/acornfb.c |   38 --------------------------------------
 1 files changed, 0 insertions(+), 38 deletions(-)

diff --git a/drivers/video/acornfb.c b/drivers/video/acornfb.c
index 6995fe1..0bcc59e 100644
--- a/drivers/video/acornfb.c
+++ b/drivers/video/acornfb.c
@@ -859,43 +859,6 @@ acornfb_pan_display(struct fb_var_screeninfo *var, struct fb_info *info)
 	return 0;
 }
 
-/*
- * Note that we are entered with the kernel locked.
- */
-static int
-acornfb_mmap(struct fb_info *info, struct vm_area_struct *vma)
-{
-	unsigned long off, start;
-	u32 len;
-
-	off = vma->vm_pgoff << PAGE_SHIFT;
-
-	start = info->fix.smem_start;
-	len = PAGE_ALIGN(start & ~PAGE_MASK) + info->fix.smem_len;
-	start &= PAGE_MASK;
-	if ((vma->vm_end - vma->vm_start + off) > len)
-		return -EINVAL;
-	off += start;
-	vma->vm_pgoff = off >> PAGE_SHIFT;
-
-	/* This is an IO map - tell maydump to skip this VMA */
-	vma->vm_flags |= VM_IO;
-
-	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
-
-	/*
-	 * Don't alter the page protection flags; we want to keep the area
-	 * cached for better performance.  This does mean that we may miss
-	 * some updates to the screen occasionally, but process switches
-	 * should cause the caches and buffers to be flushed often enough.
-	 */
-	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
-				vma->vm_end - vma->vm_start,
-				vma->vm_page_prot))
-		return -EAGAIN;
-	return 0;
-}
-
 static struct fb_ops acornfb_ops = {
 	.owner		= THIS_MODULE,
 	.fb_check_var	= acornfb_check_var,
@@ -905,7 +868,6 @@ static struct fb_ops acornfb_ops = {
 	.fb_fillrect	= cfb_fillrect,
 	.fb_copyarea	= cfb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
-	.fb_mmap	= acornfb_mmap,
 };
 
 /*
-- 
1.6.0.3


----------------------------------------------------------------------
Zrob sobie prezent. Wygraj nagrode!
Sprawdz >>  http://link.interia.pl/f2176 



-------------------------------------------------------------------
List admin: http://lists.arm.linux.org.uk/mailman/listinfo/linux-arm-kernel
FAQ:        http://www.arm.linux.org.uk/mailinglists/faq.php
Etiquette:  http://www.arm.linux.org.uk/mailinglists/etiquette.php
