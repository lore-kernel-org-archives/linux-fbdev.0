From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 20 Mar 2015 23:18:15 +0000
Subject: [PATCH v1 25/47] video: fbdev: radeonfb: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <1426893517-2511-26-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

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
 drivers/video/fbdev/aty/radeon_base.c | 29 ++++++-----------------------
 drivers/video/fbdev/aty/radeonfb.h    |  2 +-
 2 files changed, 7 insertions(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/aty/radeon_base.c b/drivers/video/fbdev/aty/radeon_base.c
index 26d80a4..922e8fc 100644
--- a/drivers/video/fbdev/aty/radeon_base.c
+++ b/drivers/video/fbdev/aty/radeon_base.c
@@ -85,10 +85,6 @@
 
 #endif /* CONFIG_PPC_OF */
 
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
-
 #include <video/radeon.h>
 #include <linux/radeonfb.h>
 
@@ -271,9 +267,7 @@ static bool mirror = 0;
 static int panel_yres = 0;
 static bool force_dfp = 0;
 static bool force_measure_pll = 0;
-#ifdef CONFIG_MTRR
 static bool nomtrr = 0;
-#endif
 static bool force_sleep;
 static bool ignore_devlist;
 #ifdef CONFIG_PMAC_BACKLIGHT
@@ -2260,8 +2254,8 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 	rinfo->mapped_vram = min_t(unsigned long, MAX_MAPPED_VRAM, rinfo->video_ram);
 
 	do {
-		rinfo->fb_base = ioremap (rinfo->fb_base_phys,
-					  rinfo->mapped_vram);
+		rinfo->fb_base = ioremap_wc(rinfo->fb_base_phys,
+					    rinfo->mapped_vram);
 	} while (rinfo->fb_base = NULL &&
 		 ((rinfo->mapped_vram /= 2) >= MIN_MAPPED_VRAM));
 
@@ -2359,11 +2353,9 @@ static int radeonfb_pci_register(struct pci_dev *pdev,
 		goto err_unmap_fb;
 	}
 
-#ifdef CONFIG_MTRR
-	rinfo->mtrr_hdl = nomtrr ? -1 : mtrr_add(rinfo->fb_base_phys,
-						 rinfo->video_ram,
-						 MTRR_TYPE_WRCOMB, 1);
-#endif
+	if (!nomtrr)
+		rinfo->wc_cookie = arch_phys_wc_add(rinfo->fb_base_phys,
+						    rinfo->video_ram);
 
 	if (backlight)
 		radeonfb_bl_init(rinfo);
@@ -2428,12 +2420,7 @@ static void radeonfb_pci_unregister(struct pci_dev *pdev)
  #endif
 
 	del_timer_sync(&rinfo->lvds_timer);
-
-#ifdef CONFIG_MTRR
-	if (rinfo->mtrr_hdl >= 0)
-		mtrr_del(rinfo->mtrr_hdl, 0, 0);
-#endif
-
+	arch_phys_wc_del(rinfo->wc_cookie);
         unregister_framebuffer(info);
 
         radeonfb_bl_exit(rinfo);
@@ -2489,10 +2476,8 @@ static int __init radeonfb_setup (char *options)
 			panel_yres = simple_strtoul((this_opt+11), NULL, 0);
 		} else if (!strncmp(this_opt, "backlight:", 10)) {
 			backlight = simple_strtoul(this_opt+10, NULL, 0);
-#ifdef CONFIG_MTRR
 		} else if (!strncmp(this_opt, "nomtrr", 6)) {
 			nomtrr = 1;
-#endif
 		} else if (!strncmp(this_opt, "nomodeset", 9)) {
 			nomodeset = 1;
 		} else if (!strncmp(this_opt, "force_measure_pll", 17)) {
@@ -2552,10 +2537,8 @@ module_param(monitor_layout, charp, 0);
 MODULE_PARM_DESC(monitor_layout, "Specify monitor mapping (like XFree86)");
 module_param(force_measure_pll, bool, 0);
 MODULE_PARM_DESC(force_measure_pll, "Force measurement of PLL (debug)");
-#ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "bool: disable use of MTRR registers");
-#endif
 module_param(panel_yres, int, 0);
 MODULE_PARM_DESC(panel_yres, "int: set panel yres");
 module_param(mode_option, charp, 0);
diff --git a/drivers/video/fbdev/aty/radeonfb.h b/drivers/video/fbdev/aty/radeonfb.h
index cb84604..61812db 100644
--- a/drivers/video/fbdev/aty/radeonfb.h
+++ b/drivers/video/fbdev/aty/radeonfb.h
@@ -340,7 +340,7 @@ struct radeonfb_info {
 
 	struct pll_info		pll;
 
-	int			mtrr_hdl;
+	int			wc_cookie;
 
 	u32			save_regs[100];
 	int			asleep;
-- 
2.3.2.209.gd67f9d5.dirty

