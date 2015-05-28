From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Thu, 28 May 2015 19:39:07 +0000
Subject: [PATCH REPOST] staging: xgifb: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <1432841947-11249-1-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Arnaud Patard <arnaud.patard@rtp-net.org>, Aaro Koskinen <aaro.koskinen@iki.fi>, Brian Vandre <bvandre@gmail.com>, Thomas Gummerer <t.gummerer@gmail.com>, Aya Mahfouz <mahfouz.saif.elyazal@gmail.com>, Lubomir Rintel <lkundrak@v3.sk>, Vitor Braga <vitorpybraga@gmail.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Suresh Siddha <sbsiddha@gmail.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Andy Lutomirski <luto@amacapital.net>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org

From: "Luis R. Rodriguez" <mcgrof@suse.com>

The same area used for ioremap() is used for the MTRR area.
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
Cc: Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: Brian Vandre <bvandre@gmail.com>
Cc: Thomas Gummerer <t.gummerer@gmail.com>
Cc: Aya Mahfouz <mahfouz.saif.elyazal@gmail.com>
Cc: Lubomir Rintel <lkundrak@v3.sk>
Cc: Vitor Braga <vitorpybraga@gmail.com>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: devel@driverdev.osuosl.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---

Greg, this is a respost from my March 20th submission which seems
to have fallen through the cracks likely due to me not directing it
to you. Apologies for that. This repost goes unchanged and is rebased
on top of linux-next next-20150528.

 drivers/staging/xgifb/XGI_main_26.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/xgifb/XGI_main_26.c b/drivers/staging/xgifb/XGI_main_26.c
index 74e8820..943d463 100644
--- a/drivers/staging/xgifb/XGI_main_26.c
+++ b/drivers/staging/xgifb/XGI_main_26.c
@@ -8,10 +8,7 @@
 
 #include <linux/sizes.h>
 #include <linux/module.h>
-
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
+#include <linux/pci.h>
 
 #include "XGI_main.h"
 #include "vb_init.h"
@@ -1770,7 +1767,7 @@ static int xgifb_probe(struct pci_dev *pdev,
 	}
 
 	xgifb_info->video_vbase = hw_info->pjVideoMemoryAddress -	ioremap(xgifb_info->video_base, xgifb_info->video_size);
+		ioremap_wc(xgifb_info->video_base, xgifb_info->video_size);
 	xgifb_info->mmio_vbase = ioremap(xgifb_info->mmio_base,
 					    xgifb_info->mmio_size);
 
@@ -2014,12 +2011,8 @@ static int xgifb_probe(struct pci_dev *pdev,
 
 	fb_alloc_cmap(&fb_info->cmap, 256, 0);
 
-#ifdef CONFIG_MTRR
-	xgifb_info->mtrr = mtrr_add(xgifb_info->video_base,
-		xgifb_info->video_size, MTRR_TYPE_WRCOMB, 1);
-	if (xgifb_info->mtrr >= 0)
-		dev_info(&pdev->dev, "Added MTRR\n");
-#endif
+	xgifb_info->mtrr = arch_phys_wc_add(xgifb_info->video_base,
+					    xgifb_info->video_size);
 
 	if (register_framebuffer(fb_info) < 0) {
 		ret = -EINVAL;
@@ -2031,11 +2024,7 @@ static int xgifb_probe(struct pci_dev *pdev,
 	return 0;
 
 error_mtrr:
-#ifdef CONFIG_MTRR
-	if (xgifb_info->mtrr >= 0)
-		mtrr_del(xgifb_info->mtrr, xgifb_info->video_base,
-			xgifb_info->video_size);
-#endif /* CONFIG_MTRR */
+	arch_phys_wc_del(xgifb_info->mtrr);
 error_1:
 	iounmap(xgifb_info->mmio_vbase);
 	iounmap(xgifb_info->video_vbase);
@@ -2059,11 +2048,7 @@ static void xgifb_remove(struct pci_dev *pdev)
 	struct fb_info *fb_info = xgifb_info->fb_info;
 
 	unregister_framebuffer(fb_info);
-#ifdef CONFIG_MTRR
-	if (xgifb_info->mtrr >= 0)
-		mtrr_del(xgifb_info->mtrr, xgifb_info->video_base,
-			xgifb_info->video_size);
-#endif /* CONFIG_MTRR */
+	arch_phys_wc_del(xgifb_info->mtrr);
 	iounmap(xgifb_info->mmio_vbase);
 	iounmap(xgifb_info->video_vbase);
 	release_mem_region(xgifb_info->mmio_base, xgifb_info->mmio_size);
-- 
2.3.2.209.gd67f9d5.dirty

