From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 21 Apr 2015 20:16:35 +0000
Subject: [PATCH v3 14/17] video: fbdev: rivafb: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <1429647398-16983-15-git-send-email-mcgrof@do-not-panic.com>
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
Cc: Antonino Daplas <adaplas@gmail.com>
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
 drivers/video/fbdev/riva/fbdev.c  | 39 +++++++--------------------------------
 drivers/video/fbdev/riva/rivafb.h |  4 +---
 2 files changed, 8 insertions(+), 35 deletions(-)

diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riva/fbdev.c
index 294a809..f1ad274 100644
--- a/drivers/video/fbdev/riva/fbdev.c
+++ b/drivers/video/fbdev/riva/fbdev.c
@@ -41,9 +41,6 @@
 #include <linux/pci.h>
 #include <linux/backlight.h>
 #include <linux/bitrev.h>
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/machdep.h>
 #include <asm/backlight.h>
@@ -204,9 +201,7 @@ MODULE_DEVICE_TABLE(pci, rivafb_pci_tbl);
 static int flatpanel = -1; /* Autodetect later */
 static int forceCRTC = -1;
 static bool noaccel  = 0;
-#ifdef CONFIG_MTRR
 static bool nomtrr = 0;
-#endif
 #ifdef CONFIG_PMAC_BACKLIGHT
 static int backlight = 1;
 #else
@@ -2010,28 +2005,18 @@ static int rivafb_probe(struct pci_dev *pd, const struct pci_device_id *ent)
 
 	rivafb_fix.smem_len = riva_get_memlen(default_par) * 1024;
 	default_par->dclk_max = riva_get_maxdclk(default_par) * 1000;
-	info->screen_base = ioremap(rivafb_fix.smem_start,
-				    rivafb_fix.smem_len);
+	info->screen_base = ioremap_wc(rivafb_fix.smem_start,
+				       rivafb_fix.smem_len);
 	if (!info->screen_base) {
 		printk(KERN_ERR PFX "cannot ioremap FB base\n");
 		ret = -EIO;
 		goto err_iounmap_pramin;
 	}
 
-#ifdef CONFIG_MTRR
-	if (!nomtrr) {
-		default_par->mtrr.vram = mtrr_add(rivafb_fix.smem_start,
-					   	  rivafb_fix.smem_len,
-					    	  MTRR_TYPE_WRCOMB, 1);
-		if (default_par->mtrr.vram < 0) {
-			printk(KERN_ERR PFX "unable to setup MTRR\n");
-		} else {
-			default_par->mtrr.vram_valid = 1;
-			/* let there be speed */
-			printk(KERN_INFO PFX "RIVA MTRR set to ON\n");
-		}
-	}
-#endif /* CONFIG_MTRR */
+	if (!nomtrr)
+		default_par->wc_cookie +			arch_phys_wc_add(rivafb_fix.smem_start,
+					 rivafb_fix.smem_len);
 
 	info->fbops = &riva_fb_ops;
 	info->fix = rivafb_fix;
@@ -2105,13 +2090,7 @@ static void rivafb_remove(struct pci_dev *pd)
 	unregister_framebuffer(info);
 
 	riva_bl_exit(info);
-
-#ifdef CONFIG_MTRR
-	if (par->mtrr.vram_valid)
-		mtrr_del(par->mtrr.vram, info->fix.smem_start,
-			 info->fix.smem_len);
-#endif /* CONFIG_MTRR */
-
+	arch_phys_wc_del(par->wc_cookie);
 	iounmap(par->ctrl_base);
 	iounmap(info->screen_base);
 	if (par->riva.Architecture = NV_ARCH_03)
@@ -2150,10 +2129,8 @@ static int rivafb_setup(char *options)
 			flatpanel = 1;
 		} else if (!strncmp(this_opt, "backlight:", 10)) {
 			backlight = simple_strtoul(this_opt+10, NULL, 0);
-#ifdef CONFIG_MTRR
 		} else if (!strncmp(this_opt, "nomtrr", 6)) {
 			nomtrr = 1;
-#endif
 		} else if (!strncmp(this_opt, "strictmode", 10)) {
 			strictmode = 1;
 		} else if (!strncmp(this_opt, "noaccel", 7)) {
@@ -2209,10 +2186,8 @@ module_param(flatpanel, int, 0);
 MODULE_PARM_DESC(flatpanel, "Enables experimental flat panel support for some chipsets. (0 or 1=enabled) (default=0)");
 module_param(forceCRTC, int, 0);
 MODULE_PARM_DESC(forceCRTC, "Forces usage of a particular CRTC in case autodetection fails. (0 or 1) (default=autodetect)");
-#ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "Disables MTRR support (0 or 1=disabled) (default=0)");
-#endif
 module_param(strictmode, bool, 0);
 MODULE_PARM_DESC(strictmode, "Only use video modes from EDID");
 
diff --git a/drivers/video/fbdev/riva/rivafb.h b/drivers/video/fbdev/riva/rivafb.h
index d9f107b..61fd37c 100644
--- a/drivers/video/fbdev/riva/rivafb.h
+++ b/drivers/video/fbdev/riva/rivafb.h
@@ -61,9 +61,7 @@ struct riva_par {
 	int FlatPanel;
 	struct pci_dev *pdev;
 	int cursor_reset;
-#ifdef CONFIG_MTRR
-	struct { int vram; int vram_valid; } mtrr;
-#endif
+	int wc_cookie;
 	struct riva_i2c_chan chan[3];
 };
 
-- 
2.3.2.209.gd67f9d5.dirty

