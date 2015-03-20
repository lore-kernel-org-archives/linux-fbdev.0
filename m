From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 20 Mar 2015 23:18:30 +0000
Subject: [PATCH v1 40/47] video: fbdev: pm3fb: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <1426893517-2511-41-git-send-email-mcgrof@do-not-panic.com>
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
 drivers/video/fbdev/pm3fb.c | 30 ++++++------------------------
 1 file changed, 6 insertions(+), 24 deletions(-)

diff --git a/drivers/video/fbdev/pm3fb.c b/drivers/video/fbdev/pm3fb.c
index 77b99ed..6ff5077 100644
--- a/drivers/video/fbdev/pm3fb.c
+++ b/drivers/video/fbdev/pm3fb.c
@@ -32,9 +32,6 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
 
 #include <video/pm3fb.h>
 
@@ -58,11 +55,7 @@
 static int hwcursor = 1;
 static char *mode_option;
 static bool noaccel;
-
-/* mtrr option */
-#ifdef CONFIG_MTRR
 static bool nomtrr;
-#endif
 
 /*
  * This structure defines the hardware state of the graphics card. Normally
@@ -76,7 +69,7 @@ struct pm3_par {
 	u32		video;		/* video flags before blanking */
 	u32		base;		/* screen base in 128 bits unit */
 	u32		palette[16];
-	int		mtrr_handle;
+	int		wc_cookie;
 };
 
 /*
@@ -1374,8 +1367,8 @@ static int pm3fb_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 		printk(KERN_WARNING "pm3fb: Can't reserve smem.\n");
 		goto err_exit_mmio;
 	}
-	info->screen_base -		ioremap_nocache(pm3fb_fix.smem_start, pm3fb_fix.smem_len);
+	info->screen_base = ioremap_wc(pm3fb_fix.smem_start,
+				       pm3fb_fix.smem_len);
 	if (!info->screen_base) {
 		printk(KERN_WARNING "pm3fb: Can't ioremap smem area.\n");
 		release_mem_region(pm3fb_fix.smem_start, pm3fb_fix.smem_len);
@@ -1383,12 +1376,9 @@ static int pm3fb_probe(struct pci_dev *dev, const struct pci_device_id *ent)
 	}
 	info->screen_size = pm3fb_fix.smem_len;
 
-#ifdef CONFIG_MTRR
 	if (!nomtrr)
-		par->mtrr_handle = mtrr_add(pm3fb_fix.smem_start,
-						pm3fb_fix.smem_len,
-						MTRR_TYPE_WRCOMB, 1);
-#endif
+		par->wc_cookie = arch_phys_wc_add(pm3fb_fix.smem_start,
+						  pm3fb_fix.smem_len);
 	info->fbops = &pm3fb_ops;
 
 	par->video = PM3_READ_REG(par, PM3VideoControl);
@@ -1478,11 +1468,7 @@ static void pm3fb_remove(struct pci_dev *dev)
 		unregister_framebuffer(info);
 		fb_dealloc_cmap(&info->cmap);
 
-#ifdef CONFIG_MTRR
-		if (par->mtrr_handle >= 0)
-			mtrr_del(par->mtrr_handle, info->fix.smem_start,
-				 info->fix.smem_len);
-#endif /* CONFIG_MTRR */
+		arch_phys_wc_del(par->wc_cookie);
 		iounmap(info->screen_base);
 		release_mem_region(fix->smem_start, fix->smem_len);
 		iounmap(par->v_regs);
@@ -1533,10 +1519,8 @@ static int __init pm3fb_setup(char *options)
 			noaccel = 1;
 		else if (!strncmp(this_opt, "hwcursor=", 9))
 			hwcursor = simple_strtoul(this_opt + 9, NULL, 0);
-#ifdef CONFIG_MTRR
 		else if (!strncmp(this_opt, "nomtrr", 6))
 			nomtrr = 1;
-#endif
 		else
 			mode_option = this_opt;
 	}
@@ -1577,10 +1561,8 @@ MODULE_PARM_DESC(noaccel, "Disable acceleration");
 module_param(hwcursor, int, 0644);
 MODULE_PARM_DESC(hwcursor, "Enable hardware cursor "
 			"(1=enable, 0=disable, default=1)");
-#ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "Disable MTRR support (0 or 1=disabled) (default=0)");
-#endif
 
 MODULE_DESCRIPTION("Permedia3 framebuffer device driver");
 MODULE_LICENSE("GPL");
-- 
2.3.2.209.gd67f9d5.dirty

