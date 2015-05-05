From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 05 May 2015 00:15:51 +0000
Subject: [PATCH v4] staging: sm750fb: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <1430784951-16505-1-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com, devel@driverdev.osuosl.org
Cc: luto@amacapital.net, cocci@systeme.lip6.fr, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Suresh Siddha <sbsiddha@gmail.com>, Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, Juergen Gross <jgross@suse.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Dave Airlie <airlied@redhat.com>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

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
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Teddy Wang <teddy.wang@siliconmotion.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
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
 drivers/staging/sm750fb/sm750.c    | 36 ++++--------------------------------
 drivers/staging/sm750fb/sm750.h    |  3 ---
 drivers/staging/sm750fb/sm750_hw.c |  3 +--
 3 files changed, 5 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750.c b/drivers/staging/sm750fb/sm750.c
index 3c7ea95..cf57e3e 100644
--- a/drivers/staging/sm750fb/sm750.c
+++ b/drivers/staging/sm750fb/sm750.c
@@ -16,9 +16,6 @@
 #include<linux/vmalloc.h>
 #include<linux/pagemap.h>
 #include <linux/console.h>
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
 #include <asm/fb.h>
 #include "sm750.h"
 #include "sm750_hw.h"
@@ -47,9 +44,7 @@ typedef int (*PROC_SPEC_INITHW)(struct lynx_share*, struct pci_dev*);
 /* common var for all device */
 static int g_hwcursor = 1;
 static int g_noaccel;
-#ifdef CONFIG_MTRR
 static int g_nomtrr;
-#endif
 static const char *g_fbmode[] = {NULL, NULL};
 static const char *g_def_fbmode = "800x600-16@60";
 static char *g_settings = NULL;
@@ -1126,11 +1121,8 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 
 	pr_info("share->revid = %02x\n", share->revid);
 	share->pdev = pdev;
-#ifdef CONFIG_MTRR
 	share->mtrr_off = g_nomtrr;
 	share->mtrr.vram = 0;
-	share->mtrr.vram_added = 0;
-#endif
 	share->accel_off = g_noaccel;
 	share->dual = g_dualview;
 	spin_lock_init(&share->slock);
@@ -1158,22 +1150,9 @@ static int lynxfb_pci_probe(struct pci_dev *pdev,
 		goto err_map;
 	}
 
-#ifdef CONFIG_MTRR
-	if (!share->mtrr_off) {
-		pr_info("enable mtrr\n");
-		share->mtrr.vram = mtrr_add(share->vidmem_start,
-					    share->vidmem_size,
-					    MTRR_TYPE_WRCOMB, 1);
-
-		if (share->mtrr.vram < 0) {
-			/* don't block driver with the failure of MTRR */
-			pr_err("Unable to setup MTRR.\n");
-		} else {
-			share->mtrr.vram_added = 1;
-			pr_info("MTRR added succesfully\n");
-		}
-	}
-#endif
+	if (!share->mtrr_off)
+		share->mtrr.vram = arch_phys_wc_add(share->vidmem_start,
+						    share->vidmem_size);
 
 	memset_io(share->pvMem, 0, share->vidmem_size);
 
@@ -1274,12 +1253,7 @@ static void __exit lynxfb_pci_remove(struct pci_dev *pdev)
 		/* release frame buffer */
 		framebuffer_release(info);
 	}
-#ifdef CONFIG_MTRR
-	if (share->mtrr.vram_added)
-		mtrr_del(share->mtrr.vram,
-			 share->vidmem_start,
-			 share->vidmem_size);
-#endif
+	arch_phys_wc_del(share->mtrr.vram);
 
 	iounmap(share->pvReg);
 	iounmap(share->pvMem);
@@ -1321,10 +1295,8 @@ static int __init lynxfb_setup(char *options)
 		/* options that mean for any lynx chips are configured here */
 		if (!strncmp(opt, "noaccel", strlen("noaccel")))
 			g_noaccel = 1;
-#ifdef CONFIG_MTRR
 		else if (!strncmp(opt, "nomtrr", strlen("nomtrr")))
 			g_nomtrr = 1;
-#endif
 		else if (!strncmp(opt, "dual", strlen("dual")))
 			g_dualview = 1;
 		else {
diff --git a/drivers/staging/sm750fb/sm750.h b/drivers/staging/sm750fb/sm750.h
index 0847d2b..5528912 100644
--- a/drivers/staging/sm750fb/sm750.h
+++ b/drivers/staging/sm750fb/sm750.h
@@ -51,13 +51,10 @@ struct lynx_share{
 	struct lynx_accel accel;
 	int accel_off;
 	int dual;
-#ifdef CONFIG_MTRR
 		int mtrr_off;
 		struct{
 			int vram;
-			int vram_added;
 		}mtrr;
-#endif
 	/* all smi graphic adaptor got below attributes */
 	unsigned long vidmem_start;
 	unsigned long vidreg_start;
diff --git a/drivers/staging/sm750fb/sm750_hw.c b/drivers/staging/sm750fb/sm750_hw.c
index 9f0d06d..4b77eb1 100644
--- a/drivers/staging/sm750fb/sm750_hw.c
+++ b/drivers/staging/sm750fb/sm750_hw.c
@@ -85,8 +85,7 @@ int hw_sm750_map(struct lynx_share* share, struct pci_dev* pdev)
 	}
 #endif
 
-	share->pvMem = ioremap(share->vidmem_start,
-							share->vidmem_size);
+	share->pvMem = ioremap_wc(share->vidmem_start, share->vidmem_size);
 
 	if(!share->pvMem){
 		pr_err("Map video memory failed\n");
-- 
2.3.2.209.gd67f9d5.dirty

