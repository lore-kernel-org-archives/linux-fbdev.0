From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 7/9] [TRY 2] fbdev: Move arch-specific
 bits to their respective subdirectories
Date: Sun, 27 May 2007 17:44:46 +0800
Message-ID: <4659530E.40102@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HsFQ6-0001wT-WC for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 02:52:15 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HsFQ5-0003fW-J9
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 02:52:14 -0700
Received: by py-out-1112.google.com with SMTP id u77so2302792pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 27 May 2007 02:52:13 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Linux Kernel Development <linux-kernel@vger.kernel.org>

Move arch-specific bits of fb_mmap() to their respective subdirectories

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---
This version addresses some of the concerns raised on the first attempt except for the 2 points raised by Christoph Hellwig:

1. Make fb_mmap() required for all drivers.

This may entail more work as it will require that the prototype be changed to accept struct file. 

2. A more generic name for fb_pgprotect().

Tony

 drivers/video/fbmem.c      |   62 +++-----------------------------------------
 include/asm-alpha/fb.h     |    7 +++++
 include/asm-arm/fb.h       |   13 +++++++++
 include/asm-arm26/fb.h     |    6 ++++
 include/asm-avr32/fb.h     |   15 +++++++++++
 include/asm-blackfin/fb.h  |    6 ++++
 include/asm-cris/fb.h      |    6 ++++
 include/asm-frv/fb.h       |    6 ++++
 include/asm-h8300/fb.h     |    6 ++++
 include/asm-i386/fb.h      |   14 ++++++++++
 include/asm-ia64/fb.h      |   16 +++++++++++
 include/asm-m32r/fb.h      |   13 +++++++++
 include/asm-m68k/fb.h      |   27 +++++++++++++++++++
 include/asm-m68knommu/fb.h |    6 ++++
 include/asm-mips/fb.h      |   13 +++++++++
 include/asm-parisc/fb.h    |   13 +++++++++
 include/asm-powerpc/fb.h   |   15 +++++++++++
 include/asm-s390/fb.h      |    6 ++++
 include/asm-sh/fb.h        |   13 +++++++++
 include/asm-sh64/fb.h      |   13 +++++++++
 include/asm-sparc/fb.h     |    6 ++++
 include/asm-sparc64/fb.h   |   12 +++++++++
 include/asm-v850/fb.h      |    6 ++++
 include/asm-x86_64/fb.h    |   14 ++++++++++
 include/asm-xtensa/fb.h    |    6 ++++
 25 files changed, 262 insertions(+), 58 deletions(-)

diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 38c2e25..8d6dbe8 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -33,17 +33,10 @@ #endif
 #include <linux/err.h>
 #include <linux/device.h>
 #include <linux/efi.h>
+#include <linux/fb.h>
 
-#if defined(__mc68000__) || defined(CONFIG_APUS)
-#include <asm/setup.h>
-#endif
-
-#include <asm/io.h>
-#include <asm/uaccess.h>
-#include <asm/page.h>
-#include <asm/pgtable.h>
+#include <asm/fb.h>
 
-#include <linux/fb.h>
 
     /*
      *  Frame buffer device initialization and setup routines
@@ -1155,17 +1148,15 @@ fb_compat_ioctl(struct file *file, unsig
 }
 #endif
 
-static int 
+static int
 fb_mmap(struct file *file, struct vm_area_struct * vma)
 {
 	int fbidx = iminor(file->f_path.dentry->d_inode);
 	struct fb_info *info = registered_fb[fbidx];
 	struct fb_ops *fb = info->fbops;
 	unsigned long off;
-#if !defined(__sparc__) || defined(__sparc_v9__)
 	unsigned long start;
 	u32 len;
-#endif
 
 	if (vma->vm_pgoff > (~0UL >> PAGE_SHIFT))
 		return -EINVAL;
@@ -1180,12 +1171,6 @@ #endif
 		return res;
 	}
 
-#if defined(__sparc__) && !defined(__sparc_v9__)
-	/* Should never get here, all fb drivers should have their own
-	   mmap routines */
-	return -EINVAL;
-#else
-	/* !sparc32... */
 	lock_kernel();
 
 	/* frame buffer memory */
@@ -1209,50 +1194,11 @@ #else
 	vma->vm_pgoff = off >> PAGE_SHIFT;
 	/* This is an IO map - tell maydump to skip this VMA */
 	vma->vm_flags |= VM_IO | VM_RESERVED;
-#if defined(__mc68000__)
-#if defined(CONFIG_SUN3)
-	pgprot_val(vma->vm_page_prot) |= SUN3_PAGE_NOCACHE;
-#elif defined(CONFIG_MMU)
-	if (CPU_IS_020_OR_030)
-		pgprot_val(vma->vm_page_prot) |= _PAGE_NOCACHE030;
-	if (CPU_IS_040_OR_060) {
-		pgprot_val(vma->vm_page_prot) &= _CACHEMASK040;
-		/* Use no-cache mode, serialized */
-		pgprot_val(vma->vm_page_prot) |= _PAGE_NOCACHE_S;
-	}
-#endif
-#elif defined(__powerpc__)
-	vma->vm_page_prot = phys_mem_access_prot(file, off >> PAGE_SHIFT,
-						 vma->vm_end - vma->vm_start,
-						 vma->vm_page_prot);
-#elif defined(__alpha__)
-	/* Caching is off in the I/O space quadrant by design.  */
-#elif defined(__i386__) || defined(__x86_64__)
-	if (boot_cpu_data.x86 > 3)
-		pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
-#elif defined(__mips__) || defined(__sparc_v9__)
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-#elif defined(__hppa__)
-	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
-#elif defined(__arm__) || defined(__sh__) || defined(__m32r__)
-	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
-#elif defined(__avr32__)
-	vma->vm_page_prot = __pgprot((pgprot_val(vma->vm_page_prot)
-				      & ~_PAGE_CACHABLE)
-				     | (_PAGE_BUFFER | _PAGE_DIRTY));
-#elif defined(__ia64__)
-	if (efi_range_is_wc(vma->vm_start, vma->vm_end - vma->vm_start))
-		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
-	else
-		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-#else
-#warning What do we have to do here??
-#endif
+	fb_pgprotect(file, vma, off);
 	if (io_remap_pfn_range(vma, vma->vm_start, off >> PAGE_SHIFT,
 			     vma->vm_end - vma->vm_start, vma->vm_page_prot))
 		return -EAGAIN;
 	return 0;
-#endif /* !sparc32 */
 }
 
 static int
diff --git a/include/asm-alpha/fb.h b/include/asm-alpha/fb.h
new file mode 100644
index 0000000..ca714a4
--- /dev/null
+++ b/include/asm-alpha/fb.h
@@ -0,0 +1,7 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+/* Caching is off in the I/O space quadrant by design.  */
+#define fb_pgprotect(...) do {} while (0)
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-arm/fb.h b/include/asm-arm/fb.h
new file mode 100644
index 0000000..4bf5b88
--- /dev/null
+++ b/include/asm-arm/fb.h
@@ -0,0 +1,13 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#include <linux/fs.h>
+#include <asm/page.h>
+
+static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
+				unsigned long off)
+{
+	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+}
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-arm26/fb.h b/include/asm-arm26/fb.h
new file mode 100644
index 0000000..9f8c88d
--- /dev/null
+++ b/include/asm-arm26/fb.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#define fb_pgprotect(...) do {} while (0)
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-avr32/fb.h b/include/asm-avr32/fb.h
new file mode 100644
index 0000000..d22a4a8
--- /dev/null
+++ b/include/asm-avr32/fb.h
@@ -0,0 +1,15 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#include <linux/fs.h>
+#include <asm/page.h>
+
+static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
+				unsigned long off)
+{
+	vma->vm_page_prot = __pgprot((pgprot_val(vma->vm_page_prot)
+				      & ~_PAGE_CACHABLE)
+				     | (_PAGE_BUFFER | _PAGE_DIRTY));
+}
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-blackfin/fb.h b/include/asm-blackfin/fb.h
new file mode 100644
index 0000000..9f8c88d
--- /dev/null
+++ b/include/asm-blackfin/fb.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#define fb_pgprotect(...) do {} while (0)
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-cris/fb.h b/include/asm-cris/fb.h
new file mode 100644
index 0000000..9f8c88d
--- /dev/null
+++ b/include/asm-cris/fb.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#define fb_pgprotect(...) do {} while (0)
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-frv/fb.h b/include/asm-frv/fb.h
new file mode 100644
index 0000000..9f8c88d
--- /dev/null
+++ b/include/asm-frv/fb.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#define fb_pgprotect(...) do {} while (0)
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-h8300/fb.h b/include/asm-h8300/fb.h
new file mode 100644
index 0000000..9f8c88d
--- /dev/null
+++ b/include/asm-h8300/fb.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#define fb_pgprotect(...) do {} while (0)
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-i386/fb.h b/include/asm-i386/fb.h
new file mode 100644
index 0000000..d30073c
--- /dev/null
+++ b/include/asm-i386/fb.h
@@ -0,0 +1,14 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#include <linux/fs.h>
+#include <asm/page.h>
+
+static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
+				unsigned long off)
+{
+	if (boot_cpu_data.x86 > 3)
+		pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
+}
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-ia64/fb.h b/include/asm-ia64/fb.h
new file mode 100644
index 0000000..c06b45b
--- /dev/null
+++ b/include/asm-ia64/fb.h
@@ -0,0 +1,16 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#include <linux/fs.h>
+#include <asm/page.h>
+
+static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
+				unsigned long off)
+{
+	if (efi_range_is_wc(vma->vm_start, vma->vm_end - vma->vm_start))
+		vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+	else
+		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+}
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-m32r/fb.h b/include/asm-m32r/fb.h
new file mode 100644
index 0000000..4bf5b88
--- /dev/null
+++ b/include/asm-m32r/fb.h
@@ -0,0 +1,13 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#include <linux/fs.h>
+#include <asm/page.h>
+
+static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
+				unsigned long off)
+{
+	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+}
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-m68k/fb.h b/include/asm-m68k/fb.h
new file mode 100644
index 0000000..dc12b5a
--- /dev/null
+++ b/include/asm-m68k/fb.h
@@ -0,0 +1,27 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#include <linux/fs.h>
+#include <asm/page.h>
+#include <asm/setup.h>
+
+#ifdef CONFIG_SUN3
+static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
+				unsigned long off)
+{
+	pgprot_val(vma->vm_page_prot) |= SUN3_PAGE_NOCACHE;
+}
+#else
+static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
+				unsigned long off)
+	if (CPU_IS_020_OR_030)
+		pgprot_val(vma->vm_page_prot) |= _PAGE_NOCACHE030;
+	if (CPU_IS_040_OR_060) {
+		pgprot_val(vma->vm_page_prot) &= _CACHEMASK040;
+		/* Use no-cache mode, serialized */
+		pgprot_val(vma->vm_page_prot) |= _PAGE_NOCACHE_S;
+	}
+}
+#endif /* CONFIG_SUN3 */
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-m68knommu/fb.h b/include/asm-m68knommu/fb.h
new file mode 100644
index 0000000..9f8c88d
--- /dev/null
+++ b/include/asm-m68knommu/fb.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#define fb_pgprotect(...) do {} while (0)
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-mips/fb.h b/include/asm-mips/fb.h
new file mode 100644
index 0000000..ac23d96
--- /dev/null
+++ b/include/asm-mips/fb.h
@@ -0,0 +1,13 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#include <linux/fs.h>
+#include <asm/page.h>
+
+static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
+				unsigned long off)
+{
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+}
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-parisc/fb.h b/include/asm-parisc/fb.h
new file mode 100644
index 0000000..d5e47ed
--- /dev/null
+++ b/include/asm-parisc/fb.h
@@ -0,0 +1,13 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#include <linux/fs.h>
+#include <asm/page.h>
+
+static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
+				unsigned long off)
+{
+	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
+}
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-powerpc/fb.h b/include/asm-powerpc/fb.h
new file mode 100644
index 0000000..e13d6eb
--- /dev/null
+++ b/include/asm-powerpc/fb.h
@@ -0,0 +1,15 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#include <linux/fs.h>
+#include <asm/page.h>
+
+static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
+				unsigned long off)
+{
+	vma->vm_page_prot = phys_mem_access_prot(file, off >> PAGE_SHIFT,
+						 vma->vm_end - vma->vm_start,
+						 vma->vm_page_prot);
+}
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-s390/fb.h b/include/asm-s390/fb.h
new file mode 100644
index 0000000..9f8c88d
--- /dev/null
+++ b/include/asm-s390/fb.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#define fb_pgprotect(...) do {} while (0)
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-sh/fb.h b/include/asm-sh/fb.h
new file mode 100644
index 0000000..4bf5b88
--- /dev/null
+++ b/include/asm-sh/fb.h
@@ -0,0 +1,13 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#include <linux/fs.h>
+#include <asm/page.h>
+
+static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
+				unsigned long off)
+{
+	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+}
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-sh64/fb.h b/include/asm-sh64/fb.h
new file mode 100644
index 0000000..4bf5b88
--- /dev/null
+++ b/include/asm-sh64/fb.h
@@ -0,0 +1,13 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#include <linux/fs.h>
+#include <asm/page.h>
+
+static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
+				unsigned long off)
+{
+	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
+}
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-sparc/fb.h b/include/asm-sparc/fb.h
new file mode 100644
index 0000000..9f8c88d
--- /dev/null
+++ b/include/asm-sparc/fb.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#define fb_pgprotect(...) do {} while (0)
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-sparc64/fb.h b/include/asm-sparc64/fb.h
new file mode 100644
index 0000000..8703c70
--- /dev/null
+++ b/include/asm-sparc64/fb.h
@@ -0,0 +1,12 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+#include <linux/fs.h>
+#include <asm/page.h>
+
+static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
+				unsigned long off)
+{
+	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
+}
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-v850/fb.h b/include/asm-v850/fb.h
new file mode 100644
index 0000000..9f8c88d
--- /dev/null
+++ b/include/asm-v850/fb.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#define fb_pgprotect(...) do {} while (0)
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-x86_64/fb.h b/include/asm-x86_64/fb.h
new file mode 100644
index 0000000..d30073c
--- /dev/null
+++ b/include/asm-x86_64/fb.h
@@ -0,0 +1,14 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#include <linux/fs.h>
+#include <asm/page.h>
+
+static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
+				unsigned long off)
+{
+	if (boot_cpu_data.x86 > 3)
+		pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
+}
+
+#endif /* _ASM_FB_H_ */
diff --git a/include/asm-xtensa/fb.h b/include/asm-xtensa/fb.h
new file mode 100644
index 0000000..9f8c88d
--- /dev/null
+++ b/include/asm-xtensa/fb.h
@@ -0,0 +1,6 @@
+#ifndef _ASM_FB_H_
+#define _ASM_FB_H_
+
+#define fb_pgprotect(...) do {} while (0)
+
+#endif /* _ASM_FB_H_ */



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
