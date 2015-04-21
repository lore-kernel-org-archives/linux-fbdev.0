From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 21 Apr 2015 20:16:28 +0000
Subject: [PATCH v3 07/17] video: fbdev: nvidia: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <1429647398-16983-8-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429647398-16983-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This driver uses the same area for MTRR and ioremap().
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
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/video/fbdev/nvidia/nv_type.h |  7 +------
 drivers/video/fbdev/nvidia/nvidia.c  | 37 ++++++------------------------------
 2 files changed, 7 insertions(+), 37 deletions(-)

diff --git a/drivers/video/fbdev/nvidia/nv_type.h b/drivers/video/fbdev/nvidia/nv_type.h
index c03f7f5..6ff321a 100644
--- a/drivers/video/fbdev/nvidia/nv_type.h
+++ b/drivers/video/fbdev/nvidia/nv_type.h
@@ -148,12 +148,7 @@ struct nvidia_par {
 	u32 forceCRTC;
 	u32 open_count;
 	u8 DDCBase;
-#ifdef CONFIG_MTRR
-	struct {
-		int vram;
-		int vram_valid;
-	} mtrr;
-#endif
+	int wc_cookie;
 	struct nvidia_i2c_chan chan[3];
 
 	volatile u32 __iomem *REGS;
diff --git a/drivers/video/fbdev/nvidia/nvidia.c b/drivers/video/fbdev/nvidia/nvidia.c
index 4273c6e..ce7dab7 100644
--- a/drivers/video/fbdev/nvidia/nvidia.c
+++ b/drivers/video/fbdev/nvidia/nvidia.c
@@ -21,9 +21,6 @@
 #include <linux/pci.h>
 #include <linux/console.h>
 #include <linux/backlight.h>
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
 #ifdef CONFIG_BOOTX_TEXT
 #include <asm/btext.h>
 #endif
@@ -76,9 +73,7 @@ static int paneltweak = 0;
 static int vram = 0;
 static int bpp = 8;
 static int reverse_i2c;
-#ifdef CONFIG_MTRR
 static bool nomtrr = false;
-#endif
 #ifdef CONFIG_PMAC_BACKLIGHT
 static int backlight = 1;
 #else
@@ -1361,7 +1356,8 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 	par->ScratchBufferStart = par->FbUsableSize - par->ScratchBufferSize;
 	par->CursorStart = par->FbUsableSize + (32 * 1024);
 
-	info->screen_base = ioremap(nvidiafb_fix.smem_start, par->FbMapSize);
+	info->screen_base = ioremap_wc(nvidiafb_fix.smem_start,
+				       par->FbMapSize);
 	info->screen_size = par->FbUsableSize;
 	nvidiafb_fix.smem_len = par->RamAmountKBytes * 1024;
 
@@ -1372,20 +1368,9 @@ static int nvidiafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 
 	par->FbStart = info->screen_base;
 
-#ifdef CONFIG_MTRR
-	if (!nomtrr) {
-		par->mtrr.vram = mtrr_add(nvidiafb_fix.smem_start,
-					  par->RamAmountKBytes * 1024,
-					  MTRR_TYPE_WRCOMB, 1);
-		if (par->mtrr.vram < 0) {
-			printk(KERN_ERR PFX "unable to setup MTRR\n");
-		} else {
-			par->mtrr.vram_valid = 1;
-			/* let there be speed */
-			printk(KERN_INFO PFX "MTRR set to ON\n");
-		}
-	}
-#endif				/* CONFIG_MTRR */
+	if (!nomtrr)
+		par->wc_cookie = arch_phys_wc_add(nvidiafb_fix.smem_start,
+						  par->RamAmountKBytes * 1024);
 
 	info->fbops = &nvidia_fb_ops;
 	info->fix = nvidiafb_fix;
@@ -1443,13 +1428,7 @@ static void nvidiafb_remove(struct pci_dev *pd)
 	unregister_framebuffer(info);
 
 	nvidia_bl_exit(par);
-
-#ifdef CONFIG_MTRR
-	if (par->mtrr.vram_valid)
-		mtrr_del(par->mtrr.vram, info->fix.smem_start,
-			 info->fix.smem_len);
-#endif				/* CONFIG_MTRR */
-
+	arch_phys_wc_del(par->wc_cookie);
 	iounmap(info->screen_base);
 	fb_destroy_modedb(info->monspecs.modedb);
 	nvidia_delete_i2c_busses(par);
@@ -1501,10 +1480,8 @@ static int nvidiafb_setup(char *options)
 			vram = simple_strtoul(this_opt+5, NULL, 0);
 		} else if (!strncmp(this_opt, "backlight:", 10)) {
 			backlight = simple_strtoul(this_opt+10, NULL, 0);
-#ifdef CONFIG_MTRR
 		} else if (!strncmp(this_opt, "nomtrr", 6)) {
 			nomtrr = true;
-#endif
 		} else if (!strncmp(this_opt, "fpdither:", 9)) {
 			fpdither = simple_strtol(this_opt+9, NULL, 0);
 		} else if (!strncmp(this_opt, "bpp:", 4)) {
@@ -1592,11 +1569,9 @@ MODULE_PARM_DESC(bpp, "pixel width in bits"
 		 "(default=8)");
 module_param(reverse_i2c, int, 0);
 MODULE_PARM_DESC(reverse_i2c, "reverse port assignment of the i2c bus");
-#ifdef CONFIG_MTRR
 module_param(nomtrr, bool, false);
 MODULE_PARM_DESC(nomtrr, "Disables MTRR support (0 or 1=disabled) "
 		 "(default=0)");
-#endif
 
 MODULE_AUTHOR("Antonino Daplas");
 MODULE_DESCRIPTION("Framebuffer driver for nVidia graphics chipset");
-- 
2.3.2.209.gd67f9d5.dirty

