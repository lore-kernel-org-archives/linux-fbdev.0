From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 20 Mar 2015 23:18:00 +0000
Subject: [PATCH v1 10/47] video: fbdev: atyfb: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <1426893517-2511-11-git-send-email-mcgrof@do-not-panic.com>
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
 drivers/video/fbdev/aty/atyfb.h      |  4 +---
 drivers/video/fbdev/aty/atyfb_base.c | 41 +++++++++---------------------------
 2 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/drivers/video/fbdev/aty/atyfb.h b/drivers/video/fbdev/aty/atyfb.h
index 89ec439..63c4842 100644
--- a/drivers/video/fbdev/aty/atyfb.h
+++ b/drivers/video/fbdev/aty/atyfb.h
@@ -182,9 +182,7 @@ struct atyfb_par {
 	unsigned long irq_flags;
 	unsigned int irq;
 	spinlock_t int_lock;
-#ifdef CONFIG_MTRR
-	int mtrr_aper;
-#endif
+	int wc_cookie;
 	u32 mem_cntl;
 	struct crtc saved_crtc;
 	union aty_pll saved_pll;
diff --git a/drivers/video/fbdev/aty/atyfb_base.c b/drivers/video/fbdev/aty/atyfb_base.c
index 8875e56..af278bb 100644
--- a/drivers/video/fbdev/aty/atyfb_base.c
+++ b/drivers/video/fbdev/aty/atyfb_base.c
@@ -98,9 +98,6 @@
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
 #endif
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
 
 /*
  * Debug flags.
@@ -303,9 +300,7 @@ static struct fb_ops atyfb_ops = {
 };
 
 static bool noaccel;
-#ifdef CONFIG_MTRR
 static bool nomtrr;
-#endif
 static int vram;
 static int pll;
 static int mclk;
@@ -2628,14 +2623,9 @@ static int aty_init(struct fb_info *info)
 		aty_st_le32(BUS_CNTL, aty_ld_le32(BUS_CNTL, par) |
 			    BUS_APER_REG_DIS, par);
 
-#ifdef CONFIG_MTRR
-	par->mtrr_aper = -1;
-	if (!nomtrr) {
-		par->mtrr_aper = mtrr_add(info->fix.smem_start,
-					  info->fix.smem_len,
-					  MTRR_TYPE_WRCOMB, 1);
-	}
-#endif
+	if (!nomtrr)
+		par->wc_cookie = arch_phys_wc_add(info->fix.smem_start,
+						  info->fix.smem_len);
 
 	info->fbops = &atyfb_ops;
 	info->pseudo_palette = par->pseudo_palette;
@@ -2763,13 +2753,8 @@ aty_init_exit:
 	/* restore video mode */
 	aty_set_crtc(par, &par->saved_crtc);
 	par->pll_ops->set_pll(info, &par->saved_pll);
+	arch_phys_wc_del(par->wc_cookie);
 
-#ifdef CONFIG_MTRR
-	if (par->mtrr_aper >= 0) {
-		mtrr_del(par->mtrr_aper, 0, 0);
-		par->mtrr_aper = -1;
-	}
-#endif
 	return ret;
 }
 
@@ -3478,7 +3463,8 @@ static int atyfb_setup_generic(struct pci_dev *pdev, struct fb_info *info,
 
 	aty_fudge_framebuffer_len(info);
 
-	info->screen_base = ioremap(info->fix.smem_start, info->fix.smem_len);
+	info->screen_base = ioremap_wc(info->fix.smem_start,
+				       info->fix.smem_len);
 	if (info->screen_base = NULL) {
 		ret = -ENOMEM;
 		goto atyfb_setup_generic_fail;
@@ -3652,7 +3638,8 @@ static int __init atyfb_atari_probe(void)
 		 * Map the video memory (physical address given)
 		 * to somewhere in the kernel address space.
 		 */
-		info->screen_base = ioremap(phys_vmembase[m64_num], phys_size[m64_num]);
+		info->screen_base = ioremap_wc(phys_vmembase[m64_num],
+					       phys_size[m64_num]);
 		info->fix.smem_start = (unsigned long)info->screen_base; /* Fake! */
 		par->ati_regbase = ioremap(phys_guiregbase[m64_num], 0x10000) +
 						0xFC00ul;
@@ -3719,12 +3706,8 @@ static void atyfb_remove(struct fb_info *info)
 		aty_bl_exit(info->bl_dev);
 #endif
 
-#ifdef CONFIG_MTRR
-	if (par->mtrr_aper >= 0) {
-		mtrr_del(par->mtrr_aper, 0, 0);
-		par->mtrr_aper = -1;
-	}
-#endif
+	arch_phys_wc_del(par->wc_cookie);
+
 #ifndef __sparc__
 	if (par->ati_regbase)
 		iounmap(par->ati_regbase);
@@ -3840,10 +3823,8 @@ static int __init atyfb_setup(char *options)
 	while ((this_opt = strsep(&options, ",")) != NULL) {
 		if (!strncmp(this_opt, "noaccel", 7)) {
 			noaccel = 1;
-#ifdef CONFIG_MTRR
 		} else if (!strncmp(this_opt, "nomtrr", 6)) {
 			nomtrr = 1;
-#endif
 		} else if (!strncmp(this_opt, "vram:", 5))
 			vram = simple_strtoul(this_opt + 5, NULL, 0);
 		else if (!strncmp(this_opt, "pll:", 4))
@@ -4013,7 +3994,5 @@ module_param(comp_sync, int, 0);
 MODULE_PARM_DESC(comp_sync, "Set composite sync signal to low (0) or high (1)");
 module_param(mode, charp, 0);
 MODULE_PARM_DESC(mode, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
-#ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "bool: disable use of MTRR registers");
-#endif
-- 
2.3.2.209.gd67f9d5.dirty

