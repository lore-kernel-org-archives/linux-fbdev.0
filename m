From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Fri, 12 Apr 2019 11:53:50 +0000
Subject: [PATCH] video: fbdev: gbefb: add COMPILE_TEST support
Message-Id: <daeed9ce-710b-cf70-88b5-8a493a082211@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190412115351eucas1p1dc215edd8d8c3d2dda99663925939290@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Add COMPILE_TEST support to gbefb driver for better compile
testing coverage.

While at it remove dead x86 specific code.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig |    2 +-
 drivers/video/fbdev/gbefb.c |    9 ++-------
 2 files changed, 3 insertions(+), 8 deletions(-)

Index: b/drivers/video/fbdev/Kconfig
=================================--- a/drivers/video/fbdev/Kconfig	2019-04-12 13:34:54.000000000 +0200
+++ b/drivers/video/fbdev/Kconfig	2019-04-12 13:40:48.246274115 +0200
@@ -673,7 +673,7 @@ config FB_HGA
 
 config FB_GBE
 	bool "SGI Graphics Backend frame buffer support"
-	depends on (FB = y) && SGI_IP32
+	depends on (FB = y) && (SGI_IP32 || COMPILE_TEST)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
Index: b/drivers/video/fbdev/gbefb.c
=================================--- a/drivers/video/fbdev/gbefb.c	2019-04-12 11:39:45.266091209 +0200
+++ b/drivers/video/fbdev/gbefb.c	2019-04-12 13:48:00.142284992 +0200
@@ -39,9 +39,7 @@ struct gbefb_par {
 	int valid;
 };
 
-#ifdef CONFIG_SGI_IP32
 #define GBE_BASE	0x16000000 /* SGI O2 */
-#endif
 
 /* macro for fastest write-though access to the framebuffer */
 #ifdef CONFIG_MIPS
@@ -51,10 +49,6 @@ struct gbefb_par {
 #define pgprot_fb(_prot) (((_prot) & (~_CACHE_MASK)) | _CACHE_CACHABLE_NO_WA)
 #endif
 #endif
-#ifdef CONFIG_X86
-#define pgprot_fb(_prot) (((_prot) & ~_PAGE_CACHE_MASK) |	\
-			  cachemode2protval(_PAGE_CACHE_MODE_UC_MINUS))
-#endif
 
 /*
  *  RAM we reserve for the frame buffer. This defines the maximum screen
@@ -1018,9 +1012,10 @@ static int gbefb_mmap(struct fb_info *in
 
 	/* remap using the fastest write-through mode on architecture */
 	/* try not polluting the cache when possible */
+#ifdef CONFIG_MIPS
 	pgprot_val(vma->vm_page_prot)  		pgprot_fb(pgprot_val(vma->vm_page_prot));
-
+#endif
 	/* VM_IO | VM_DONTEXPAND | VM_DONTDUMP are set by remap_pfn_range() */
 
 	/* look for the starting tile */
