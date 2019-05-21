From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Tue, 21 May 2019 11:51:15 +0000
Subject: [PATCH v2] video: fbdev: gbefb: add COMPILE_TEST support
Message-Id: <8bcfd5b8-347b-89e4-5faf-8569a3d00115@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20190521115115eucas1p28c5743b756e359791a3efcce1e2e16b8@eucas1p2.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org

Add COMPILE_TEST support to gbefb driver for better compile
testing coverage.

While at it convert bogus udelay() calls to mdelay() (needed to
build driver on ARM) and remove dead x86 specific code.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- add missing HAS_IOMEM dependency
- fix build on ARM by converting bogus udelay() calls to mdelay()

 drivers/video/fbdev/Kconfig |    3 ++-
 drivers/video/fbdev/gbefb.c |   19 +++++++------------
 2 files changed, 9 insertions(+), 13 deletions(-)

Index: b/drivers/video/fbdev/Kconfig
=================================--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -670,7 +670,8 @@ config FB_HGA
 
 config FB_GBE
 	bool "SGI Graphics Backend frame buffer support"
-	depends on (FB = y) && SGI_IP32
+	depends on (FB = y) && HAS_IOMEM
+	depends on SGI_IP32 || COMPILE_TEST
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
Index: b/drivers/video/fbdev/gbefb.c
=================================--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
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
@@ -279,7 +273,7 @@ static void gbe_turn_off(void)
 	val = 0;
 	SET_GBE_FIELD(VT_XY, FREEZE, val, 1);
 	gbe->vt_xy = val;
-	udelay(10000);
+	mdelay(10);
 	for (i = 0; i < 10000; i++) {
 		val = gbe->vt_xy;
 		if (GET_GBE_FIELD(VT_XY, FREEZE, val) != 1)
@@ -294,7 +288,7 @@ static void gbe_turn_off(void)
 	val = gbe->dotclock;
 	SET_GBE_FIELD(DOTCLK, RUN, val, 0);
 	gbe->dotclock = val;
-	udelay(10000);
+	mdelay(10);
 	for (i = 0; i < 10000; i++) {
 		val = gbe->dotclock;
 		if (GET_GBE_FIELD(DOTCLK, RUN, val))
@@ -331,7 +325,7 @@ static void gbe_turn_on(void)
 	val = gbe->dotclock;
 	SET_GBE_FIELD(DOTCLK, RUN, val, 1);
 	gbe->dotclock = val;
-	udelay(10000);
+	mdelay(10);
 	for (i = 0; i < 10000; i++) {
 		val = gbe->dotclock;
 		if (GET_GBE_FIELD(DOTCLK, RUN, val) != 1)
@@ -346,7 +340,7 @@ static void gbe_turn_on(void)
 	val = 0;
 	SET_GBE_FIELD(VT_XY, FREEZE, val, 0);
 	gbe->vt_xy = val;
-	udelay(10000);
+	mdelay(10);
 	for (i = 0; i < 10000; i++) {
 		val = gbe->vt_xy;
 		if (GET_GBE_FIELD(VT_XY, FREEZE, val))
@@ -547,7 +541,7 @@ static void gbe_set_timing_info(struct g
 	SET_GBE_FIELD(DOTCLK, P, val, timing->pll_p);
 	SET_GBE_FIELD(DOTCLK, RUN, val, 0);	/* do not start yet */
 	gbe->dotclock = val;
-	udelay(10000);
+	mdelay(10);
 
 	/* setup pixel counter */
 	val = 0;
@@ -1018,9 +1012,10 @@ static int gbefb_mmap(struct fb_info *in
 
 	/* remap using the fastest write-through mode on architecture */
 	/* try not polluting the cache when possible */
+#ifdef CONFIG_MIPS
 	pgprot_val(vma->vm_page_prot)  		pgprot_fb(pgprot_val(vma->vm_page_prot));
-
+#endif
 	/* VM_IO | VM_DONTEXPAND | VM_DONTDUMP are set by remap_pfn_range() */
 
 	/* look for the starting tile */
