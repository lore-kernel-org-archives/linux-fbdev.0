From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 8/9] [RESEND] fbdev: Detect primary
	display device
Date: Mon, 28 May 2007 18:30:04 +0800
Message-ID: <465AAF2C.6070602@gmail.com>
References: <465952CD.2040409@gmail.com>
	<Pine.LNX.4.64.0705281037080.4790@anakin>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HscUR-0000Ws-Ig for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 May 2007 03:30:16 -0700
Received: from py-out-1112.google.com ([64.233.166.183])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HscUP-0004fY-ST
	for linux-fbdev-devel@lists.sourceforge.net;
	Mon, 28 May 2007 03:30:14 -0700
Received: by py-out-1112.google.com with SMTP id u77so2816892pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Mon, 28 May 2007 03:30:13 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0705281037080.4790@anakin>
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
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Linux Kernel Development <linux-kernel@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>

Add function helper, fb_is_primary_device().  Given struct fb_info, it will
return a nonzero value if the device is the primary display.

Currently, only the i386 is supported where the function checks for the
IORESOURCE_ROM_SHADOW flag.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---
Geert Uytterhoeven wrote:
> On Sun, 27 May 2007, Antonino A. Daplas wrote:
>> Add function helper, fb_is_display_device().  Given struct fb_info, it will
>                              ^^^^^^^
> 			     primary
> 
>> return a nonzero value if the device is the primary display.
> 
>> +static inline int fb_is_primary_device(struct fb_screeninfo *info)
>                                                  ^^^^^^^^^^^^^

Yikes, thanks.  Andrew, here's an updated patch.

Tony

 arch/i386/Makefile         |    1 +
 arch/i386/video/Makefile   |    1 +
 arch/i386/video/fbdev.c    |   34 ++++++++++++++++++++++++++++++++++
 include/asm-alpha/fb.h     |    6 ++++++
 include/asm-arm/fb.h       |    6 ++++++
 include/asm-arm26/fb.h     |    6 ++++++
 include/asm-avr32/fb.h     |    6 ++++++
 include/asm-blackfin/fb.h  |    6 ++++++
 include/asm-cris/fb.h      |    6 ++++++
 include/asm-frv/fb.h       |    6 ++++++
 include/asm-h8300/fb.h     |    6 ++++++
 include/asm-i386/fb.h      |    3 +++
 include/asm-ia64/fb.h      |    6 ++++++
 include/asm-m32r/fb.h      |    6 ++++++
 include/asm-m68k/fb.h      |    6 ++++++
 include/asm-m68knommu/fb.h |    6 ++++++
 include/asm-mips/fb.h      |    6 ++++++
 include/asm-parisc/fb.h    |    6 ++++++
 include/asm-powerpc/fb.h   |    6 ++++++
 include/asm-s390/fb.h      |    6 ++++++
 include/asm-sh/fb.h        |    6 ++++++
 include/asm-sh64/fb.h      |    6 ++++++
 include/asm-sparc/fb.h     |    6 ++++++
 include/asm-sparc64/fb.h   |    6 ++++++
 include/asm-v850/fb.h      |    6 ++++++
 include/asm-x86_64/fb.h    |    7 ++++++-
 include/asm-xtensa/fb.h    |    6 ++++++
 27 files changed, 177 insertions(+), 1 deletions(-)

diff --git a/arch/i386/Makefile b/arch/i386/Makefile
index 3eb063e..01f0ff0 100644
--- a/arch/i386/Makefile
+++ b/arch/i386/Makefile
@@ -111,6 +111,7 @@ drivers-$(CONFIG_PCI)			+= arch/i386/pci
 # must be linked after kernel/
 drivers-$(CONFIG_OPROFILE)		+= arch/i386/oprofile/
 drivers-$(CONFIG_PM)			+= arch/i386/power/
+drivers-$(CONFIG_FB)                    += arch/i386/video/
 
 CFLAGS += $(mflags-y)
 AFLAGS += $(mflags-y)
diff --git a/arch/i386/video/Makefile b/arch/i386/video/Makefile
new file mode 100644
index 0000000..2c447c9
--- /dev/null
+++ b/arch/i386/video/Makefile
@@ -0,0 +1 @@
+obj-$(CONFIG_FB)               += fbdev.o
diff --git a/arch/i386/video/fbdev.c b/arch/i386/video/fbdev.c
new file mode 100644
index 0000000..7fc712c
--- /dev/null
+++ b/arch/i386/video/fbdev.c
@@ -0,0 +1,34 @@
+/*
+ * arch/i386/video/fbdev.c - i386 Framebuffer
+ *
+ * Copyright (C) 2007 Antonino Daplas <adaplas@gmail.com>
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file COPYING in the main directory of this archive
+ * for more details.
+ *
+ */
+#include <linux/fb.h>
+#include <linux/pci.h>
+
+int fb_is_primary_device(struct fb_info *info)
+{
+	struct device *device;
+	struct pci_dev *pci_dev = NULL;
+	struct resource *res = NULL;
+	int retval = 0;
+
+	device = info->device;
+
+	if (device)
+		pci_dev = to_pci_dev(device);
+
+	if (pci_dev)
+		res = &pci_dev->resource[PCI_ROM_RESOURCE];
+
+	if (res && res->flags & IORESOURCE_ROM_SHADOW)
+		retval = 1;
+
+	return retval;
+}
+EXPORT_SYMBOL(fb_is_primary_device);
diff --git a/include/asm-alpha/fb.h b/include/asm-alpha/fb.h
index ca714a4..6d3b5b6 100644
--- a/include/asm-alpha/fb.h
+++ b/include/asm-alpha/fb.h
@@ -1,7 +1,13 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
+#include <linux/device.h>
 
 /* Caching is off in the I/O space quadrant by design.  */
 #define fb_pgprotect(...) do {} while (0)
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-arm/fb.h b/include/asm-arm/fb.h
index 4bf5b88..d92e99c 100644
--- a/include/asm-arm/fb.h
+++ b/include/asm-arm/fb.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
+#include <linux/fb.h>
 #include <linux/fs.h>
 #include <asm/page.h>
 
@@ -10,4 +11,9 @@ static inline void fb_pgprotect(struct f
 	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 }
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-arm26/fb.h b/include/asm-arm26/fb.h
index 9f8c88d..c7df380 100644
--- a/include/asm-arm26/fb.h
+++ b/include/asm-arm26/fb.h
@@ -1,6 +1,12 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
+#include <linux/fb.h>
 
 #define fb_pgprotect(...) do {} while (0)
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-avr32/fb.h b/include/asm-avr32/fb.h
index d22a4a8..41baf84 100644
--- a/include/asm-avr32/fb.h
+++ b/include/asm-avr32/fb.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
+#include <linux/fb.h>
 #include <linux/fs.h>
 #include <asm/page.h>
 
@@ -12,4 +13,9 @@ static inline void fb_pgprotect(struct f
 				     | (_PAGE_BUFFER | _PAGE_DIRTY));
 }
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-blackfin/fb.h b/include/asm-blackfin/fb.h
index 9f8c88d..c7df380 100644
--- a/include/asm-blackfin/fb.h
+++ b/include/asm-blackfin/fb.h
@@ -1,6 +1,12 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
+#include <linux/fb.h>
 
 #define fb_pgprotect(...) do {} while (0)
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-cris/fb.h b/include/asm-cris/fb.h
index 9f8c88d..c7df380 100644
--- a/include/asm-cris/fb.h
+++ b/include/asm-cris/fb.h
@@ -1,6 +1,12 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
+#include <linux/fb.h>
 
 #define fb_pgprotect(...) do {} while (0)
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-frv/fb.h b/include/asm-frv/fb.h
index 9f8c88d..c7df380 100644
--- a/include/asm-frv/fb.h
+++ b/include/asm-frv/fb.h
@@ -1,6 +1,12 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
+#include <linux/fb.h>
 
 #define fb_pgprotect(...) do {} while (0)
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-h8300/fb.h b/include/asm-h8300/fb.h
index 9f8c88d..c7df380 100644
--- a/include/asm-h8300/fb.h
+++ b/include/asm-h8300/fb.h
@@ -1,6 +1,12 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
+#include <linux/fb.h>
 
 #define fb_pgprotect(...) do {} while (0)
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-i386/fb.h b/include/asm-i386/fb.h
index d30073c..d1c6297 100644
--- a/include/asm-i386/fb.h
+++ b/include/asm-i386/fb.h
@@ -1,9 +1,12 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
+#include <linux/fb.h>
 #include <linux/fs.h>
 #include <asm/page.h>
 
+extern int fb_is_primary_device(struct fb_info *info);
+
 static inline void fb_pgprotect(struct file *file, struct vm_area_struct *vma,
 				unsigned long off)
 {
diff --git a/include/asm-ia64/fb.h b/include/asm-ia64/fb.h
index c06b45b..33f2ba6 100644
--- a/include/asm-ia64/fb.h
+++ b/include/asm-ia64/fb.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
+#include <linux/fb.h>
 #include <linux/fs.h>
 #include <asm/page.h>
 
@@ -13,4 +14,9 @@ static inline void fb_pgprotect(struct f
 		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 }
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-m32r/fb.h b/include/asm-m32r/fb.h
index 4bf5b88..d92e99c 100644
--- a/include/asm-m32r/fb.h
+++ b/include/asm-m32r/fb.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
+#include <linux/fb.h>
 #include <linux/fs.h>
 #include <asm/page.h>
 
@@ -10,4 +11,9 @@ static inline void fb_pgprotect(struct f
 	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 }
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-m68k/fb.h b/include/asm-m68k/fb.h
index dc12b5a..6f0c25e 100644
--- a/include/asm-m68k/fb.h
+++ b/include/asm-m68k/fb.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
+#include <linux/fb.h>
 #include <linux/fs.h>
 #include <asm/page.h>
 #include <asm/setup.h>
@@ -24,4 +25,9 @@ static inline void fb_pgprotect(struct f
 }
 #endif /* CONFIG_SUN3 */
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-m68knommu/fb.h b/include/asm-m68knommu/fb.h
index 9f8c88d..f2752d4 100644
--- a/include/asm-m68knommu/fb.h
+++ b/include/asm-m68knommu/fb.h
@@ -1,6 +1,12 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
+#include <linux/fb.h>
 
 #define fb_pgprotect(...) do {} while (0)
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-mips/fb.h b/include/asm-mips/fb.h
index ac23d96..cc740a9 100644
--- a/include/asm-mips/fb.h
+++ b/include/asm-mips/fb.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
+#include <linux/fb.h>
 #include <linux/fs.h>
 #include <asm/page.h>
 
@@ -10,4 +11,9 @@ static inline void fb_pgprotect(struct f
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 }
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-parisc/fb.h b/include/asm-parisc/fb.h
index d5e47ed..4d503a0 100644
--- a/include/asm-parisc/fb.h
+++ b/include/asm-parisc/fb.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
+#include <linux/fb.h>
 #include <linux/fs.h>
 #include <asm/page.h>
 
@@ -10,4 +11,9 @@ static inline void fb_pgprotect(struct f
 	pgprot_val(vma->vm_page_prot) |= _PAGE_NO_CACHE;
 }
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-powerpc/fb.h b/include/asm-powerpc/fb.h
index e13d6eb..411af8d 100644
--- a/include/asm-powerpc/fb.h
+++ b/include/asm-powerpc/fb.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
+#include <linux/fb.h>
 #include <linux/fs.h>
 #include <asm/page.h>
 
@@ -12,4 +13,9 @@ static inline void fb_pgprotect(struct f
 						 vma->vm_page_prot);
 }
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-s390/fb.h b/include/asm-s390/fb.h
index 9f8c88d..c7df380 100644
--- a/include/asm-s390/fb.h
+++ b/include/asm-s390/fb.h
@@ -1,6 +1,12 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
+#include <linux/fb.h>
 
 #define fb_pgprotect(...) do {} while (0)
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-sh/fb.h b/include/asm-sh/fb.h
index 4bf5b88..d92e99c 100644
--- a/include/asm-sh/fb.h
+++ b/include/asm-sh/fb.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
+#include <linux/fb.h>
 #include <linux/fs.h>
 #include <asm/page.h>
 
@@ -10,4 +11,9 @@ static inline void fb_pgprotect(struct f
 	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 }
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-sh64/fb.h b/include/asm-sh64/fb.h
index 4bf5b88..d92e99c 100644
--- a/include/asm-sh64/fb.h
+++ b/include/asm-sh64/fb.h
@@ -1,6 +1,7 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
 
+#include <linux/fb.h>
 #include <linux/fs.h>
 #include <asm/page.h>
 
@@ -10,4 +11,9 @@ static inline void fb_pgprotect(struct f
 	vma->vm_page_prot = pgprot_writecombine(vma->vm_page_prot);
 }
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-sparc/fb.h b/include/asm-sparc/fb.h
index 9f8c88d..c7df380 100644
--- a/include/asm-sparc/fb.h
+++ b/include/asm-sparc/fb.h
@@ -1,6 +1,12 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
+#include <linux/fb.h>
 
 #define fb_pgprotect(...) do {} while (0)
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-sparc64/fb.h b/include/asm-sparc64/fb.h
index 8703c70..d6cd3a1 100644
--- a/include/asm-sparc64/fb.h
+++ b/include/asm-sparc64/fb.h
@@ -1,5 +1,6 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
+#include <linux/fb.h>
 #include <linux/fs.h>
 #include <asm/page.h>
 
@@ -9,4 +10,9 @@ static inline void fb_pgprotect(struct f
 	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
 }
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-v850/fb.h b/include/asm-v850/fb.h
index 9f8c88d..c7df380 100644
--- a/include/asm-v850/fb.h
+++ b/include/asm-v850/fb.h
@@ -1,6 +1,12 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
+#include <linux/fb.h>
 
 #define fb_pgprotect(...) do {} while (0)
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-x86_64/fb.h b/include/asm-x86_64/fb.h
index d30073c..60548e6 100644
--- a/include/asm-x86_64/fb.h
+++ b/include/asm-x86_64/fb.h
@@ -1,6 +1,6 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
-
+#include <linux/fb.h>
 #include <linux/fs.h>
 #include <asm/page.h>
 
@@ -11,4 +11,9 @@ static inline void fb_pgprotect(struct f
 		pgprot_val(vma->vm_page_prot) |= _PAGE_PCD;
 }
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */
diff --git a/include/asm-xtensa/fb.h b/include/asm-xtensa/fb.h
index 9f8c88d..c7df380 100644
--- a/include/asm-xtensa/fb.h
+++ b/include/asm-xtensa/fb.h
@@ -1,6 +1,12 @@
 #ifndef _ASM_FB_H_
 #define _ASM_FB_H_
+#include <linux/fb.h>
 
 #define fb_pgprotect(...) do {} while (0)
 
+static inline int fb_is_primary_device(struct fb_info *info)
+{
+	return 0;
+}
+
 #endif /* _ASM_FB_H_ */

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
