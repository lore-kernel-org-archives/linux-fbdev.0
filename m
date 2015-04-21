From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 21 Apr 2015 20:16:36 +0000
Subject: [PATCH v3 15/17] video: fbdev: tdfxfb: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <1429647398-16983-16-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cocci@systeme.lip6.fr

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
Cc: Rob Clark <robdclark@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
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
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/video/fbdev/tdfxfb.c | 41 ++++++-----------------------------------
 include/video/tdfx.h         |  2 +-
 2 files changed, 7 insertions(+), 36 deletions(-)

diff --git a/drivers/video/fbdev/tdfxfb.c b/drivers/video/fbdev/tdfxfb.c
index f761fe3..621fa44 100644
--- a/drivers/video/fbdev/tdfxfb.c
+++ b/drivers/video/fbdev/tdfxfb.c
@@ -78,24 +78,6 @@
 
 #define DPRINTK(a, b...) pr_debug("fb: %s: " a, __func__ , ## b)
 
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#else
-/* duplicate asm/mtrr.h defines to work on archs without mtrr */
-#define MTRR_TYPE_WRCOMB     1
-
-static inline int mtrr_add(unsigned long base, unsigned long size,
-				unsigned int type, char increment)
-{
-    return -ENODEV;
-}
-static inline int mtrr_del(int reg, unsigned long base,
-				unsigned long size)
-{
-    return -ENODEV;
-}
-#endif
-
 #define BANSHEE_MAX_PIXCLOCK 270000
 #define VOODOO3_MAX_PIXCLOCK 300000
 #define VOODOO5_MAX_PIXCLOCK 350000
@@ -167,7 +149,6 @@ static int nopan;
 static int nowrap = 1;      /* not implemented (yet) */
 static int hwcursor = 1;
 static char *mode_option;
-/* mtrr option */
 static bool nomtrr;
 
 /* -------------------------------------------------------------------------
@@ -1454,8 +1435,8 @@ static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto out_err_regbase;
 	}
 
-	info->screen_base = ioremap_nocache(info->fix.smem_start,
-					    info->fix.smem_len);
+	info->screen_base = ioremap_wc(info->fix.smem_start,
+				       info->fix.smem_len);
 	if (!info->screen_base) {
 		printk(KERN_ERR "fb: Can't remap %s framebuffer.\n",
 				info->fix.id);
@@ -1473,11 +1454,9 @@ static int tdfxfb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	printk(KERN_INFO "fb: %s memory = %dK\n", info->fix.id,
 			info->fix.smem_len >> 10);
 
-	default_par->mtrr_handle = -1;
 	if (!nomtrr)
-		default_par->mtrr_handle -			mtrr_add(info->fix.smem_start, info->fix.smem_len,
-				 MTRR_TYPE_WRCOMB, 1);
+		default_par->wc_cookie= arch_phys_wc_add(info->fix.smem_start,
+							 info->fix.smem_len);
 
 	info->fix.ypanstep	= nopan ? 0 : 1;
 	info->fix.ywrapstep	= nowrap ? 0 : 1;
@@ -1566,9 +1545,7 @@ out_err_iobase:
 #ifdef CONFIG_FB_3DFX_I2C
 	tdfxfb_delete_i2c_busses(default_par);
 #endif
-	if (default_par->mtrr_handle >= 0)
-		mtrr_del(default_par->mtrr_handle, info->fix.smem_start,
-			 info->fix.smem_len);
+	arch_phys_wc_del(default_par->wc_cookie);
 	release_region(pci_resource_start(pdev, 2),
 		       pci_resource_len(pdev, 2));
 out_err_screenbase:
@@ -1604,10 +1581,8 @@ static void __init tdfxfb_setup(char *options)
 			nowrap = 1;
 		} else if (!strncmp(this_opt, "hwcursor=", 9)) {
 			hwcursor = simple_strtoul(this_opt + 9, NULL, 0);
-#ifdef CONFIG_MTRR
 		} else if (!strncmp(this_opt, "nomtrr", 6)) {
 			nomtrr = 1;
-#endif
 		} else {
 			mode_option = this_opt;
 		}
@@ -1633,9 +1608,7 @@ static void tdfxfb_remove(struct pci_dev *pdev)
 #ifdef CONFIG_FB_3DFX_I2C
 	tdfxfb_delete_i2c_busses(par);
 #endif
-	if (par->mtrr_handle >= 0)
-		mtrr_del(par->mtrr_handle, info->fix.smem_start,
-			 info->fix.smem_len);
+	arch_phys_wc_del(par->wc_cookie);
 	iounmap(par->regbase_virt);
 	iounmap(info->screen_base);
 
@@ -1677,10 +1650,8 @@ MODULE_PARM_DESC(hwcursor, "Enable hardware cursor "
 			"(1=enable, 0=disable, default=1)");
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Initial video mode e.g. '648x480-8@60'");
-#ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "Disable MTRR support (default: enabled)");
-#endif
 
 module_init(tdfxfb_init);
 module_exit(tdfxfb_exit);
diff --git a/include/video/tdfx.h b/include/video/tdfx.h
index befbaf0..69674b9 100644
--- a/include/video/tdfx.h
+++ b/include/video/tdfx.h
@@ -196,7 +196,7 @@ struct tdfx_par {
 	u32 palette[16];
 	void __iomem *regbase_virt;
 	unsigned long iobase;
-	int mtrr_handle;
+	int wc_cookie;
 #ifdef CONFIG_FB_3DFX_I2C
 	struct tdfxfb_i2c_chan chan[2];
 #endif
-- 
2.3.2.209.gd67f9d5.dirty

