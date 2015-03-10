From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 10 Mar 2015 17:28:52 +0000
Subject: [PATCH 1/6] staging: sm750fb: remove unused functions
Message-Id: <1426007817-1884-2-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426007817-1884-1-git-send-email-sudipm.mukherjee@gmail.com>
In-Reply-To: <1426007817-1884-1-git-send-email-sudipm.mukherjee@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-fbdev@vger.kernel.org, devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

removed the functions which were not used anywhere.
it has been build tested also confirmed with git grep that there is
no other reference of these functions.

Signed-off-by: Sudip Mukherjee <sudip@vectorindia.org>
---
 drivers/staging/sm750fb/ddk750_display.c | 11 ------
 drivers/staging/sm750fb/ddk750_swi2c.c   |  8 ----
 drivers/staging/sm750fb/sm750.c          | 65 --------------------------------
 3 files changed, 84 deletions(-)

diff --git a/drivers/staging/sm750fb/ddk750_display.c b/drivers/staging/sm750fb/ddk750_display.c
index 57192e5..a282a94 100644
--- a/drivers/staging/sm750fb/ddk750_display.c
+++ b/drivers/staging/sm750fb/ddk750_display.c
@@ -201,17 +201,6 @@ static void waitNextVerticalSync(int ctrl,int delay)
 	}
 }
 
-static void swPanelPowerSequence_sm750le(int disp,int delay)
-{
-	unsigned int reg;
-	reg = PEEK32(DISPLAY_CONTROL_750LE);
-	if(disp)
-		reg |= 0xf;
-	else
-		reg &= ~0xf;
-	POKE32(DISPLAY_CONTROL_750LE,reg);
-}
-
 static void swPanelPowerSequence(int disp,int delay)
 {
 	unsigned int reg;
diff --git a/drivers/staging/sm750fb/ddk750_swi2c.c b/drivers/staging/sm750fb/ddk750_swi2c.c
index cae6b9b..1249759 100644
--- a/drivers/staging/sm750fb/ddk750_swi2c.c
+++ b/drivers/staging/sm750fb/ddk750_swi2c.c
@@ -79,14 +79,6 @@ static unsigned long g_i2cDataGPIOMuxReg = GPIO_MUX;
 static unsigned long g_i2cDataGPIODataReg = GPIO_DATA;
 static unsigned long g_i2cDataGPIODataDirReg = GPIO_DATA_DIRECTION;
 
-static unsigned char peekIO(unsigned short port,unsigned short index)
-{
-#if defined(__i386__) || defined( __x86_64__)
-		outb_p(index,port);
-		return inb_p(port+1);
-#endif
-}
-
 /*
  *  This function puts a delay between command
  */
diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 8c260ee..87029b6 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -510,69 +510,6 @@ static int lynxfb_resume(struct pci_dev* pdev)
 }
 #endif
 
-static int lynxfb_ops_mmap(struct fb_info * info, struct vm_area_struct * vma)
-{
-	unsigned long off;
-	unsigned long start;
-	u32 len;
-	struct file *file;
-	
-	file = vma->vm_file;
-	
-	if (!info)
-		return -ENODEV;
-	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
-		return -EINVAL;
-	off = vma->vm_pgoff << PAGE_SHIFT;
-	printk("lynxfb mmap pgoff: %lx\n", vma->vm_pgoff);
-	printk("lynxfb mmap off 1: %lx\n", off);
-	
-	/* frame buffer memory */
-	start = info->fix.smem_start;
-	len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.smem_len);
-	
-	printk("lynxfb mmap start 1: %lx\n", start);
-	printk("lynxfb mmap len 1: %x\n", len);
-	
-	if (off >= len) {
-		/* memory mapped io */
-		off -= len;
-		printk("lynxfb mmap off 2: %lx\n", off);
-		if (info->var.accel_flags) {
-			printk("lynxfb mmap accel flags true");
-			return -EINVAL;
-		}
-		start = info->fix.mmio_start;
-		len = PAGE_ALIGN((start & ~PAGE_MASK) + info->fix.mmio_len);
-		
-		printk("lynxfb mmap start 2: %lx\n", start);
-		printk("lynxfb mmap len 2: %x\n", len);
-	}
-	start &= PAGE_MASK;
-	printk("lynxfb mmap start 3: %lx\n", start);
-	printk("lynxfb mmap vm start: %lx\n", vma->vm_start);
-	printk("lynxfb mmap vm end: %lx\n", vma->vm_end);
-	printk("lynxfb mmap len: %x\n", len);
-	printk("lynxfb mmap off: %lx\n", off);
-	if ((vma->vm_end - vma->vm_start + off) > len)
-	{
-		return -EINVAL;
-	}
-	off += start;
-	printk("lynxfb mmap off 3: %lx\n", off);
-	vma->vm_pgoff = off >> PAGE_SHIFT;
-	/* This is an IO map - tell maydump to skip this VMA */
-	vma->vm_flags |= VM_IO | VM_DONTEXPAND | VM_DONTDUMP;
-	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
-	fb_pgprotect(file, vma, off);
-	printk("lynxfb mmap off 4: %lx\n", off);
-	printk("lynxfb mmap pgprot: %lx\n", (unsigned long) pgprot_val(vma->vm_page_prot));
-	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
-			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
-		return -EAGAIN;
-	return 0;
-}
-
 static int lynxfb_ops_check_var(struct fb_var_screeninfo* var,struct fb_info* info)
 {
 	struct lynxfb_par * par;
@@ -824,8 +761,6 @@ static struct fb_ops lynxfb_ops={
 	.fb_set_par = lynxfb_ops_set_par,
 	.fb_setcolreg = lynxfb_ops_setcolreg,
 	.fb_blank = lynxfb_ops_blank,
-	/*.fb_mmap = lynxfb_ops_mmap,*/
-	/* will be hooked by hardware */
 	.fb_fillrect = cfb_fillrect,
 	.fb_imageblit = cfb_imageblit,
 	.fb_copyarea = cfb_copyarea,
-- 
1.8.1.2

