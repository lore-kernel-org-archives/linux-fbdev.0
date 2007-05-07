From: Haavard Skinnemoen <hskinnemoen@atmel.com>
Subject: [PATCH] fbdev: Add support for AVR32
Date: Mon,  7 May 2007 17:20:33 +0200
Message-ID: <11785512332033-git-send-email-hskinnemoen@atmel.com>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S934334AbXEGPVl@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>, akpm@linux-foundation.org, Haavard Skinnemoen <hskinnemoen@atmel.com>

Provide framebuffer page protection flags and definitions of
fb_readl/fb_writel for AVR32.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>
---
Please let me know if you want me to push this myself through the
AVR32 tree.

 drivers/video/fbmem.c |    4 ++++
 include/linux/fb.h    |    2 +-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 2822526..babf8a9 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1198,6 +1198,10 @@ fb_mmap(struct file *file, struct vm_area_struct * vma)
 	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
 #elif defined(__arm__) || defined(__sh__) || defined(__m32r__)
 	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+#elif defined(__avr32__)
+	vma->vm_page_prot = __pgprot((pgprot_val(vma->vm_page_prot)
+				      & ~_PAGE_CACHABLE)
+				     | (_PAGE_BUFFER | _PAGE_DIRTY));
 #elif defined(__ia64__)
 	if (efi_range_is_wc(vma->vm_start, vma->vm_end - vma->vm_start))
 		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
diff --git a/include/linux/fb.h b/include/linux/fb.h
index be913ec..deb2365 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -833,7 +833,7 @@ struct fb_info {
 #define fb_writeq sbus_writeq
 #define fb_memset sbus_memset_io
 
-#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) || defined(__hppa__) || (defined(__sh__) && !defined(__SH5__)) || defined(__powerpc__)
+#elif defined(__i386__) || defined(__alpha__) || defined(__x86_64__) || defined(__hppa__) || (defined(__sh__) && !defined(__SH5__)) || defined(__powerpc__) || defined(__avr32__)
 
 #define fb_readb __raw_readb
 #define fb_readw __raw_readw
-- 
1.4.4.4
