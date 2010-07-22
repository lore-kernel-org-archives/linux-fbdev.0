From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Thu, 22 Jul 2010 21:31:28 +0000
Subject: fbmem: VM_IO set, but not propagated.
Message-Id: <20100722213128.GA27012@phenom.dumpdata.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Hey,

This bug was found when Linux kernel was running under Xen.
In that scenario, any page that has VM_IO flag to it, means that it
MUST be a MMIO/VRAM backend memory , _not_ System RAM. That is what the
fbmem.c does: sets VM_IO, ioremaps the region - everything is peachy.

Well, not exactly. The vm_page_prot does not get the relevant
PTE flags set (_PAGE_IOMAP) which under Xen is a death-kneel to pages
that are referencing real physical devices but don't have that flag set.

Here is the patch:

Author: Daniel De Graaf <dgdegra@tycho.nsa.gov>
Date:   Wed Jul 21 16:52:46 2010 -0400

    fb: propagate VM_IO to VMA.
    
    When we setup up the VMA flags for the mmap flag and we end up using
    the fallback mmap functionality we set the vma->vm_flags |= VM_IO.
    However we neglect to propagate the flag to the vma->vm_page_prot.
    
    This patch fixes this.
    
    Tested-by: Eamon Walsh <ewalsh@tycho.nsa.gov>
    Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 99bbd28..057433a 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1362,6 +1362,7 @@ fb_mmap(struct file *file, struct vm_area_struct * vma)
 	vma->vm_pgoff = off >> PAGE_SHIFT;
 	/* This is an IO map - tell maydump to skip this VMA */
 	vma->vm_flags |= VM_IO | VM_RESERVED;
+	vma->vm_page_prot = vm_get_page_prot(vma->vm_flags);
 	fb_pgprotect(file, vma, off);
 	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
 			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
