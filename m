From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 20 Mar 2015 23:18:23 +0000
Subject: [PATCH v1 33/47] video: fbdev: savagefb: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <1426893517-2511-34-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This driver uses the same area for MTRR as for the ioremap().
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
   _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (de33c442e)

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
Cc: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/video/fbdev/savage/savagefb.h        |  4 +---
 drivers/video/fbdev/savage/savagefb_driver.c | 17 +++--------------
 2 files changed, 4 insertions(+), 17 deletions(-)

diff --git a/drivers/video/fbdev/savage/savagefb.h b/drivers/video/fbdev/savage/savagefb.h
index 8ff4ab1..aba04af 100644
--- a/drivers/video/fbdev/savage/savagefb.h
+++ b/drivers/video/fbdev/savage/savagefb.h
@@ -213,9 +213,7 @@ struct savagefb_par {
 		void   __iomem *vbase;
 		u32    pbase;
 		u32    len;
-#ifdef CONFIG_MTRR
-		int    mtrr;
-#endif
+		int    wc_cookie;
 	} video;
 
 	struct {
diff --git a/drivers/video/fbdev/savage/savagefb_driver.c b/drivers/video/fbdev/savage/savagefb_driver.c
index 4dbf45f..6c77ab0 100644
--- a/drivers/video/fbdev/savage/savagefb_driver.c
+++ b/drivers/video/fbdev/savage/savagefb_driver.c
@@ -57,10 +57,6 @@
 #include <asm/irq.h>
 #include <asm/pgtable.h>
 
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
-
 #include "savagefb.h"
 
 
@@ -1775,7 +1771,7 @@ static int savage_map_video(struct fb_info *info, int video_len)
 
 	par->video.pbase = pci_resource_start(par->pcidev, resource);
 	par->video.len   = video_len;
-	par->video.vbase = ioremap(par->video.pbase, par->video.len);
+	par->video.vbase = ioremap_wc(par->video.pbase, par->video.len);
 
 	if (!par->video.vbase) {
 		printk("savagefb: unable to map screen memory\n");
@@ -1787,11 +1783,7 @@ static int savage_map_video(struct fb_info *info, int video_len)
 	info->fix.smem_start = par->video.pbase;
 	info->fix.smem_len   = par->video.len - par->cob_size;
 	info->screen_base    = par->video.vbase;
-
-#ifdef CONFIG_MTRR
-	par->video.mtrr = mtrr_add(par->video.pbase, video_len,
-				   MTRR_TYPE_WRCOMB, 1);
-#endif
+	par->video.wc_cookie = arch_phys_wc_add(par->video.pbase, video_len);
 
 	/* Clear framebuffer, it's all white in memory after boot */
 	memset_io(par->video.vbase, 0, par->video.len);
@@ -1806,10 +1798,7 @@ static void savage_unmap_video(struct fb_info *info)
 	DBG("savage_unmap_video");
 
 	if (par->video.vbase) {
-#ifdef CONFIG_MTRR
-		mtrr_del(par->video.mtrr, par->video.pbase, par->video.len);
-#endif
-
+		arch_phys_wc_del(par->video.wc_cookie);
 		iounmap(par->video.vbase);
 		par->video.vbase = NULL;
 		info->screen_base = NULL;
-- 
2.3.2.209.gd67f9d5.dirty

