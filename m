From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Mon, 09 Mar 2015 07:47:03 +0000
Subject: [PATCH v2 1/4] staging: sm750fb: wrong type for print
Message-Id: <1425886506-8643-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CA+V-a8s65fCvd2cA6w2EwaJfaLgPqQ=Hme+m9_wv+y3Y=GxPiQ@mail.gmail.com>
In-Reply-To: <CA+V-a8s65fCvd2cA6w2EwaJfaLgPqQ=Hme+m9_wv+y3Y=GxPiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org

mention correct format specifier while printing.
fixes all the build warnings about incorrect argument type while
printing.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---

V2: Giedrius commented resource_size_t can be either u64 or u32
depending on if CONFIG_PHYS_ADDR_T_64BIT. based on his comments i
should have kept the datatype as resource_size_t and  used %pa as the
format specifier. But since this is a framebuffer device and it
should follow what the framebuffer layer is suggesting in
struct fb_fix_screeninfo at smem_start and mmio_start.
adding Tomi for his comments.

this patch will give checkpatch warnings about use of printk.
this patch was mainly to fix the build warnings. printk will be
converted to pr_* and dev_* in a later patch.

 drivers/staging/sm750fb/sm750.c    | 24 ++++++++++++------------
 drivers/staging/sm750fb/sm750.h    |  8 ++++----
 drivers/staging/sm750fb/sm750_hw.c |  4 ++--
 3 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 520c69e..753869e 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -530,20 +530,20 @@ static int lynxfb_ops_mmap(struct fb_info * info, struct vm_area_struct * vma)
 	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
 		return -EINVAL;
 	off = vma->vm_pgoff << PAGE_SHIFT;
-	printk("lynxfb mmap pgoff: %x\n", vma->vm_pgoff);
-	printk("lynxfb mmap off 1: %x\n", off);
+	printk("lynxfb mmap pgoff: %lx\n", vma->vm_pgoff);
+	printk("lynxfb mmap off 1: %lx\n", off);
 	
 	/* frame buffer memory */
 	start = info->fix.smem_start;
 	len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.smem_len);
 	
-	printk("lynxfb mmap start 1: %x\n", start);
+	printk("lynxfb mmap start 1: %lx\n", start);
 	printk("lynxfb mmap len 1: %x\n", len);
 	
 	if (off >= len) {
 		/* memory mapped io */
 		off -= len;
-		printk("lynxfb mmap off 2: %x\n", off);
+		printk("lynxfb mmap off 2: %lx\n", off);
 		if (info->var.accel_flags) {
 			printk("lynxfb mmap accel flags true");
 			return -EINVAL;
@@ -551,28 +551,28 @@ static int lynxfb_ops_mmap(struct fb_info * info, struct vm_area_struct * vma)
 		start = info->fix.mmio_start;
 		len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.mmio_len);
 		
-		printk("lynxfb mmap start 2: %x\n", start);
+		printk("lynxfb mmap start 2: %lx\n", start);
 		printk("lynxfb mmap len 2: %x\n", len);
 	}
 	start &= PAGE_MASK;
-	printk("lynxfb mmap start 3: %x\n", start);
-	printk("lynxfb mmap vm start: %x\n", vma->vm_start);
-	printk("lynxfb mmap vm end: %x\n", vma->vm_end);
+	printk("lynxfb mmap start 3: %lx\n", start);
+	printk("lynxfb mmap vm start: %lx\n", vma->vm_start);
+	printk("lynxfb mmap vm end: %lx\n", vma->vm_end);
 	printk("lynxfb mmap len: %x\n", len);
-	printk("lynxfb mmap off: %x\n", off);
+	printk("lynxfb mmap off: %lx\n", off);
 	if ((vma->vm_end - vma->vm_start + off) > len)
 	{
 		return -EINVAL;
 	}
 	off += start;
-	printk("lynxfb mmap off 3: %x\n", off);
+	printk("lynxfb mmap off 3: %lx\n", off);
 	vma->vm_pgoff = off >> PAGE_SHIFT;
 	/* This is an IO map - tell maydump to skip this VMA */
 	vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
 	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 	fb_pgprotect(file, vma, off);
-	printk("lynxfb mmap off 4: %x\n", off);
-	printk("lynxfb mmap pgprot: %x\n", vma->vm_page_prot);
+	printk("lynxfb mmap off 4: %lx\n", off);
+	printk("lynxfb mmap pgprot: %lx\n", (unsigned long) pgprot_val(vma->vm_page_prot));
 	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
 			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
 		return -EAGAIN;
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 711676c..d39968c 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -59,10 +59,10 @@ struct lynx_share{
 		}mtrr;
 #endif
 	/* all smi graphic adaptor got below attributes */
-	resource_size_t vidmem_start;
-	resource_size_t vidreg_start;
-	resource_size_t vidmem_size;
-	resource_size_t vidreg_size;
+	unsigned long vidmem_start;
+	unsigned long vidreg_start;
+	__u32 vidmem_size;
+	__u32 vidreg_size;
 	volatile unsigned char __iomem * pvReg;
 	unsigned char __iomem * pvMem;
 	/* locks*/
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index cd971bd..ec2d499 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -36,7 +36,7 @@ int hw_sm750_map(struct lynx_share* share,struct pci_dev* pdev)
 	share->vidreg_start  = pci_resource_start(pdev,1);
 	share->vidreg_size = MB(2);
 
-	pr_info("mmio phyAddr = %x\n",share->vidreg_start);
+	pr_info("mmio phyAddr = %lx\n", share->vidreg_start);
 
 	/* reserve the vidreg space of smi adaptor
 	 * if you do this, u need to add release region code
@@ -73,7 +73,7 @@ int hw_sm750_map(struct lynx_share* share,struct pci_dev* pdev)
 	 * @hw_sm750_getVMSize function can be safe.
 	 * */
 	share->vidmem_size = hw_sm750_getVMSize(share);
-	pr_info("video memory phyAddr = %x, size = %d bytes\n",
+	pr_info("video memory phyAddr = %lx, size = %u bytes\n",
 	share->vidmem_start,share->vidmem_size);
 
 	/* reserve the vidmem space of smi adaptor */
-- 
1.8.1.2

