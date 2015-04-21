From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 21 Apr 2015 20:16:25 +0000
Subject: [PATCH v3 04/17] video: fbdev: intelfb: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <1429647398-16983-5-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Although this driver gives the framebuffer layer a different
size for the framebuffer it uses the entire aperture PCI BAR
size for the MTRR. Since the framebuffer is included in that
range and MTRR was used on the entire PCI BAR WC will have
been preferred on that range as well. This propagates the
WC preference on the same entire PCI BAR.

Convert the driver from using the x86 specific MTRR code to
the architecture agnostic arch_phys_wc_add(). arch_phys_wc_add()
will avoid MTRR if write-combining is available, in order to
take advantage of that also ensure the ioremap'd area is requested
as write-combining.

There are a few motivations for this:

a) Take advantage of PAT when available

b) Help bury MTRR code away, MTRR is architecture specific and on
   x86 its replaced by PAT

c) Help with the goal of eventually using _PAGE_CACHE_UC over
   _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (see commit
   de33c442e titled "x86 PAT: fix performance drop for glx,
   use UC minus for ioremap(), ioremap_nocache() and
   pci_mmap_page_range()")

The conversion done is expressed by the following Coccinelle
SmPL patch, it additionally required manual intervention to
address all the #ifdery and removal of redundant things which
arch_phys_wc_add() already addresses such as verbose message
about when MTRR fails and doing nothing when we didn't get
an MTRR.

@ mtrr_found @
expression index, base, size;
@@

-index = mtrr_add(base, size, MTRR_TYPE_WRCOMB, 1);
+index = arch_phys_wc_add(base, size);

@ mtrr_rm depends on mtrr_found @
expression mtrr_found.index, mtrr_found.base, mtrr_found.size;
@@

-mtrr_del(index, base, size);
+arch_phys_wc_del(index);

@ mtrr_rm_zero_arg depends on mtrr_found @
expression mtrr_found.index;
@@

-mtrr_del(index, 0, 0);
+arch_phys_wc_del(index);

@ mtrr_rm_fb_info depends on mtrr_found @
struct fb_info *info;
expression mtrr_found.index;
@@

-mtrr_del(index, info->fix.smem_start, info->fix.smem_len);
+arch_phys_wc_del(index);

@ ioremap_replace_nocache depends on mtrr_found @
struct fb_info *info;
expression base, size;
@@

-info->screen_base = ioremap_nocache(base, size);
+info->screen_base = ioremap_wc(base, size);

@ ioremap_replace_default depends on mtrr_found @
struct fb_info *info;
expression base, size;
@@

-info->screen_base = ioremap(base, size);
+info->screen_base = ioremap_wc(base, size);

Generated-by: Coccinelle SmPL
Cc: Maik Broemme <mbroemme@plusserver.de>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/video/fbdev/intelfb/intelfb.h    |  4 +---
 drivers/video/fbdev/intelfb/intelfbdrv.c | 38 ++++----------------------------
 2 files changed, 5 insertions(+), 37 deletions(-)

diff --git a/drivers/video/fbdev/intelfb/intelfb.h b/drivers/video/fbdev/intelfb/intelfb.h
index 6b51175..37f8339 100644
--- a/drivers/video/fbdev/intelfb/intelfb.h
+++ b/drivers/video/fbdev/intelfb/intelfb.h
@@ -285,9 +285,7 @@ struct intelfb_info {
 	/* use a gart reserved fb mem */
 	u8 fbmem_gart;
 
-	/* mtrr support */
-	int mtrr_reg;
-	u32 has_mtrr;
+	int wc_cookie;
 
 	/* heap data */
 	struct intelfb_heap_data aperture;
diff --git a/drivers/video/fbdev/intelfb/intelfbdrv.c b/drivers/video/fbdev/intelfb/intelfbdrv.c
index b847d53..bbec737 100644
--- a/drivers/video/fbdev/intelfb/intelfbdrv.c
+++ b/drivers/video/fbdev/intelfb/intelfbdrv.c
@@ -124,10 +124,6 @@
 
 #include <asm/io.h>
 
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
-
 #include "intelfb.h"
 #include "intelfbhw.h"
 #include "../edid.h"
@@ -411,33 +407,6 @@ module_init(intelfb_init);
 module_exit(intelfb_exit);
 
 /***************************************************************
- *                     mtrr support functions                  *
- ***************************************************************/
-
-#ifdef CONFIG_MTRR
-static inline void set_mtrr(struct intelfb_info *dinfo)
-{
-	dinfo->mtrr_reg = mtrr_add(dinfo->aperture.physical,
-				   dinfo->aperture.size, MTRR_TYPE_WRCOMB, 1);
-	if (dinfo->mtrr_reg < 0) {
-		ERR_MSG("unable to set MTRR\n");
-		return;
-	}
-	dinfo->has_mtrr = 1;
-}
-static inline void unset_mtrr(struct intelfb_info *dinfo)
-{
-	if (dinfo->has_mtrr)
-		mtrr_del(dinfo->mtrr_reg, dinfo->aperture.physical,
-			 dinfo->aperture.size);
-}
-#else
-#define set_mtrr(x) WRN_MSG("MTRR is disabled in the kernel\n")
-
-#define unset_mtrr(x) do { } while (0)
-#endif /* CONFIG_MTRR */
-
-/***************************************************************
  *                        driver init / cleanup                *
  ***************************************************************/
 
@@ -456,7 +425,7 @@ static void cleanup(struct intelfb_info *dinfo)
 	if (dinfo->registered)
 		unregister_framebuffer(dinfo->info);
 
-	unset_mtrr(dinfo);
+	arch_phys_wc_del(dinfo->wc_cookie);
 
 	if (dinfo->fbmem_gart && dinfo->gtt_fb_mem) {
 		agp_unbind_memory(dinfo->gtt_fb_mem);
@@ -675,7 +644,7 @@ static int intelfb_pci_register(struct pci_dev *pdev,
 	/* Allocate memories (which aren't stolen) */
 	/* Map the fb and MMIO regions */
 	/* ioremap only up to the end of used aperture */
-	dinfo->aperture.virtual = (u8 __iomem *)ioremap_nocache
+	dinfo->aperture.virtual = (u8 __iomem *)ioremap_wc
 		(dinfo->aperture.physical, ((offset + dinfo->fb.offset) << 12)
 		 + dinfo->fb.size);
 	if (!dinfo->aperture.virtual) {
@@ -772,7 +741,8 @@ static int intelfb_pci_register(struct pci_dev *pdev,
 	agp_backend_release(bridge);
 
 	if (mtrr)
-		set_mtrr(dinfo);
+		dinfo->wc_cookie = arch_phys_wc_add(dinfo->aperture.physical,
+						    dinfo->aperture.size);
 
 	DBG_MSG("fb: 0x%x(+ 0x%x)/0x%x (0x%p)\n",
 		dinfo->fb.physical, dinfo->fb.offset, dinfo->fb.size,
-- 
2.3.2.209.gd67f9d5.dirty

