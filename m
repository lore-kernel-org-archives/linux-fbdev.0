From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Tue, 23 Apr 2013 06:36:48 +0000
Subject: [PATCH 01/11] fbdev/fbmem: use vm_iomap_memory()
Message-Id: <1366699018-5439-1-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

Use vm_iomap_memory() instead of [io_]remap_pfn_range().
vm_iomap_memory() gives us much simpler API to map memory to userspace,
and reduces possibilities for bugs.

Original patch from Linus Torvalds <torvalds@linux-foundation.org>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbmem.c |   36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 7c25408..0598aa9 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1373,15 +1373,12 @@ fb_mmap(struct file *file, struct vm_area_struct * vma)
 {
 	struct fb_info *info = file_fb_info(file);
 	struct fb_ops *fb;
-	unsigned long off;
+	unsigned long mmio_pgoff;
 	unsigned long start;
 	u32 len;
 
 	if (!info)
 		return -ENODEV;
-	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
-		return -EINVAL;
-	off = vma->vm_pgoff << PAGE_SHIFT;
 	fb = info->fbops;
 	if (!fb)
 		return -ENODEV;
@@ -1393,32 +1390,23 @@ fb_mmap(struct file *file, struct vm_area_struct * vma)
 		return res;
 	}
 
-	/* frame buffer memory */
+	/* Map mmio if pgoff points past the fb */
 	start = info->fix.smem_start;
-	len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.smem_len);
-	if (off >= len) {
-		/* memory mapped io */
-		off -= len;
-		if (info->var.accel_flags) {
-			mutex_unlock(&info->mm_lock);
+	len = info->fix.smem_len;
+	mmio_pgoff = PAGE_ALIGN((start & ~PAGE_MASK) + len) >> PAGE_SHIFT;
+	if (vma->vm_pgoff >= mmio_pgoff) {
+		if (info->var.accel_flags)
 			return -EINVAL;
-		}
+		vma->vm_pgoff -= mmio_pgoff;
 		start = info->fix.mmio_start;
-		len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.mmio_len);
+		len = info->fix.mmio_len;
 	}
 	mutex_unlock(&info->mm_lock);
-	start &= PAGE_MASK;
-	if ((vma->vm_end - vma->vm_start + off) > len)
-		return -EINVAL;
-	off += start;
-	vma->vm_pgoff = off >> PAGE_SHIFT;
-	/* VM_IO | VM_DONTEXPAND | VM_DONTDUMP are set by io_remap_pfn_range()*/
+
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
-	fb_pgprotect(file, vma, off);
-	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
-			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
-		return -EAGAIN;
-	return 0;
+	fb_pgprotect(file, vma, start);
+
+	return vm_iomap_memory(vma, start, len);
 }
 
 static int
-- 
1.7.10.4

