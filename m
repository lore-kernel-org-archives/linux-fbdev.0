From: Anatolij Gustschin <agust@denx.de>
Date: Wed, 26 May 2010 09:57:43 +0000
Subject: [PATCH 2/2] sm501fb.c: support mmap on PPC440SPe/PPC440EPx
Message-Id: <1274867863-4238-2-git-send-email-agust@denx.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Add driver specific mmap function to be able to mmap
frame buffer on PPC440SPe/PPC440EPx platforms. This
is needed because mmaping of the 36-bit physical
address of the frame buffer or MMIO is not supported
in generic fb_mmap().

Signed-off-by: Anatolij Gustschin <agust@denx.de>
Cc: Ben Dooks <ben@simtec.co.uk>
Cc: Simtec Linux Team <linux@simtec.co.uk>
---
 drivers/video/sm501fb.c |   52 +++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/drivers/video/sm501fb.c b/drivers/video/sm501fb.c
index 0b59112..9cdc298 100644
--- a/drivers/video/sm501fb.c
+++ b/drivers/video/sm501fb.c
@@ -1426,6 +1426,52 @@ static void sm501fb_fillrect(struct fb_info *info, const struct fb_fillrect *rec
 	writel(0x800100cc, fbi->regs2d + SM501_2D_CONTROL);
 }
 
+#if defined(CONFIG_440EPX) || defined(CONFIG_440SPe)
+static int sm501fb_mmap(struct fb_info *info,
+			struct vm_area_struct *vma)
+{
+	struct sm501fb_par *par = info->par;
+	struct sm501fb_info *fbi = par->info;
+	unsigned long long start;
+	unsigned long len, off, map_off;
+
+	off = vma->vm_pgoff << PAGE_SHIFT;
+	/*
+	 * Get 36-bit base address of the frame buffer memory.
+	 * Since it was previously truncated while assigning to
+	 * fix.smem_start, we retrieve correct address here.
+	 */
+	start = (fbi->fbmem_res->start & 0xf00000000ULL) +
+		info->fix.smem_start;
+	len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.smem_len);
+
+	if (off >= len) {
+		/* memory mapped io */
+		off -= len;
+		if (info->var.accel_flags)
+			return -EINVAL;
+		start = fbi->regs_res->start;
+		len = PAGE_ALIGN((start & ~PAGE_MASK) +
+				 resource_size(fbi->regs_res));
+	}
+
+	start &= PAGE_MASK;
+	if ((vma->vm_end - vma->vm_start + off) > len)
+		return -EINVAL;
+
+	map_off = (unsigned long)((off + start) >> PAGE_SHIFT);
+	vma->vm_pgoff = map_off;
+
+	vma->vm_flags |= VM_IO | VM_RESERVED;
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+	if (io_remap_pfn_range(vma, vma->vm_start, map_off,
+			       vma->vm_end - vma->vm_start,
+			       vma->vm_page_prot))
+		return -EAGAIN;
+
+	return 0;
+}
+#endif
 
 static struct fb_ops sm501fb_ops_crt = {
 	.owner		= THIS_MODULE,
@@ -1439,6 +1485,9 @@ static struct fb_ops sm501fb_ops_crt = {
 	.fb_copyarea	= sm501fb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 	.fb_sync	= sm501fb_sync,
+#if defined(CONFIG_440EPX) || defined(CONFIG_440SPe)
+	.fb_mmap	= sm501fb_mmap,
+#endif
 };
 
 static struct fb_ops sm501fb_ops_pnl = {
@@ -1453,6 +1502,9 @@ static struct fb_ops sm501fb_ops_pnl = {
 	.fb_copyarea	= sm501fb_copyarea,
 	.fb_imageblit	= cfb_imageblit,
 	.fb_sync	= sm501fb_sync,
+#if defined(CONFIG_440EPX) || defined(CONFIG_440SPe)
+	.fb_mmap	= sm501fb_mmap,
+#endif
 };
 
 /* sm501_init_cursor
-- 
1.6.2.5

