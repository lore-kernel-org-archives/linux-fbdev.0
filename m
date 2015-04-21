From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 21 Apr 2015 20:16:31 +0000
Subject: [PATCH v3 10/17] video: fbdev: aty: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <1429647398-16983-11-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

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
Cc: Paul Mackerras <paulus@samba.org>
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
 drivers/video/fbdev/aty/aty128fb.c | 36 ++++++------------------------------
 1 file changed, 6 insertions(+), 30 deletions(-)

diff --git a/drivers/video/fbdev/aty/aty128fb.c b/drivers/video/fbdev/aty/aty128fb.c
index 0156954..c42ce2f 100644
--- a/drivers/video/fbdev/aty/aty128fb.c
+++ b/drivers/video/fbdev/aty/aty128fb.c
@@ -80,10 +80,6 @@
 #include <asm/btext.h>
 #endif /* CONFIG_BOOTX_TEXT */
 
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
-
 #include <video/aty128.h>
 
 /* Debug flag */
@@ -399,10 +395,7 @@ static int default_cmode = CMODE_8;
 
 static int default_crt_on = 0;
 static int default_lcd_on = 1;
-
-#ifdef CONFIG_MTRR
 static bool mtrr = true;
-#endif
 
 #ifdef CONFIG_FB_ATY128_BACKLIGHT
 #ifdef CONFIG_PMAC_BACKLIGHT
@@ -456,9 +449,7 @@ struct aty128fb_par {
 	u32 vram_size;                      /* onboard video ram   */
 	int chip_gen;
 	const struct aty128_meminfo *mem;   /* onboard mem info    */
-#ifdef CONFIG_MTRR
-	struct { int vram; int vram_valid; } mtrr;
-#endif
+	int wc_cookie;
 	int blitter_may_be_busy;
 	int fifo_slots;                 /* free slots in FIFO (64 max) */
 
@@ -1725,12 +1716,10 @@ static int aty128fb_setup(char *options)
 #endif
 			continue;
 		}
-#ifdef CONFIG_MTRR
 		if(!strncmp(this_opt, "nomtrr", 6)) {
 			mtrr = 0;
 			continue;
 		}
-#endif
 #ifdef CONFIG_PPC_PMAC
 		/* vmode and cmode deprecated */
 		if (!strncmp(this_opt, "vmode:", 6)) {
@@ -2133,7 +2122,7 @@ static int aty128_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	par->vram_size = aty_ld_le32(CNFG_MEMSIZE) & 0x03FFFFFF;
 
 	/* Virtualize the framebuffer */
-	info->screen_base = ioremap(fb_addr, par->vram_size);
+	info->screen_base = ioremap_wc(fb_addr, par->vram_size);
 	if (!info->screen_base)
 		goto err_unmap_out;
 
@@ -2170,15 +2159,9 @@ static int aty128_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (!aty128_init(pdev, ent))
 		goto err_out;
 
-#ifdef CONFIG_MTRR
-	if (mtrr) {
-		par->mtrr.vram = mtrr_add(info->fix.smem_start,
-				par->vram_size, MTRR_TYPE_WRCOMB, 1);
-		par->mtrr.vram_valid = 1;
-		/* let there be speed */
-		printk(KERN_INFO "aty128fb: Rage128 MTRR set to ON\n");
-	}
-#endif /* CONFIG_MTRR */
+	if (mtrr)
+		par->wc_cookie = arch_phys_wc_add(info->fix.smem_start,
+						  par->vram_size);
 	return 0;
 
 err_out:
@@ -2212,11 +2195,7 @@ static void aty128_remove(struct pci_dev *pdev)
 	aty128_bl_exit(info->bl_dev);
 #endif
 
-#ifdef CONFIG_MTRR
-	if (par->mtrr.vram_valid)
-		mtrr_del(par->mtrr.vram, info->fix.smem_start,
-			 par->vram_size);
-#endif /* CONFIG_MTRR */
+	arch_phys_wc_del(par->wc_cookie);
 	iounmap(par->regbase);
 	iounmap(info->screen_base);
 
@@ -2625,8 +2604,5 @@ MODULE_DESCRIPTION("FBDev driver for ATI Rage128 / Pro cards");
 MODULE_LICENSE("GPL");
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Specify resolution as \"<xres>x<yres>[-<bpp>][@<refresh>]\" ");
-#ifdef CONFIG_MTRR
 module_param_named(nomtrr, mtrr, invbool, 0);
 MODULE_PARM_DESC(nomtrr, "bool: Disable MTRR support (0 or 1=disabled) (default=0)");
-#endif
-
-- 
2.3.2.209.gd67f9d5.dirty

