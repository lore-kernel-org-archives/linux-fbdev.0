From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 20 Mar 2015 23:18:29 +0000
Subject: [PATCH v1 39/47] video: fbdev: pm2fb: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <1426893517-2511-40-git-send-email-mcgrof@do-not-panic.com>
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
 drivers/video/fbdev/pm2fb.c | 31 +++++--------------------------
 1 file changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/video/fbdev/pm2fb.c b/drivers/video/fbdev/pm2fb.c
index 3b85b64..aa8d288 100644
--- a/drivers/video/fbdev/pm2fb.c
+++ b/drivers/video/fbdev/pm2fb.c
@@ -38,10 +38,6 @@
 #include <linux/fb.h>
 #include <linux/init.h>
 #include <linux/pci.h>
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
-
 #include <video/permedia2.h>
 #include <video/cvisionppc.h>
 
@@ -81,10 +77,7 @@ static char *mode_option;
 static bool lowhsync;
 static bool lowvsync;
 static bool noaccel;
-/* mtrr option */
-#ifdef CONFIG_MTRR
 static bool nomtrr;
-#endif
 
 /*
  * The hardware state of the graphics card that isn't part of the
@@ -100,7 +93,7 @@ struct pm2fb_par
 	u32		mem_control;	/* MemControl reg at probe */
 	u32		boot_address;	/* BootAddress reg at probe */
 	u32		palette[16];
-	int		mtrr_handle;
+	int		wc_cookie;
 };
 
 /*
@@ -1637,21 +1630,16 @@ static int pm2fb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto err_exit_mmio;
 	}
 	info->screen_base -		ioremap_nocache(pm2fb_fix.smem_start, pm2fb_fix.smem_len);
+		ioremap_wc(pm2fb_fix.smem_start, pm2fb_fix.smem_len);
 	if (!info->screen_base) {
 		printk(KERN_WARNING "pm2fb: Can't ioremap smem area.\n");
 		release_mem_region(pm2fb_fix.smem_start, pm2fb_fix.smem_len);
 		goto err_exit_mmio;
 	}
 
-#ifdef CONFIG_MTRR
-	default_par->mtrr_handle = -1;
 	if (!nomtrr)
-		default_par->mtrr_handle -			mtrr_add(pm2fb_fix.smem_start,
-				 pm2fb_fix.smem_len,
-				 MTRR_TYPE_WRCOMB, 1);
-#endif
+		default_par->wc_cookie = arch_phys_wc_add(pm2fb_fix.smem_start,
+							  pm2fb_fix.smem_len);
 
 	info->fbops		= &pm2fb_ops;
 	info->fix		= pm2fb_fix;
@@ -1733,12 +1721,7 @@ static void pm2fb_remove(struct pci_dev *pdev)
 	struct pm2fb_par *par = info->par;
 
 	unregister_framebuffer(info);
-
-#ifdef CONFIG_MTRR
-	if (par->mtrr_handle >= 0)
-		mtrr_del(par->mtrr_handle, info->fix.smem_start,
-			 info->fix.smem_len);
-#endif /* CONFIG_MTRR */
+	arch_phys_wc_del(par->wc_cookie);
 	iounmap(info->screen_base);
 	release_mem_region(fix->smem_start, fix->smem_len);
 	iounmap(par->v_regs);
@@ -1791,10 +1774,8 @@ static int __init pm2fb_setup(char *options)
 			lowvsync = 1;
 		else if (!strncmp(this_opt, "hwcursor=", 9))
 			hwcursor = simple_strtoul(this_opt + 9, NULL, 0);
-#ifdef CONFIG_MTRR
 		else if (!strncmp(this_opt, "nomtrr", 6))
 			nomtrr = 1;
-#endif
 		else if (!strncmp(this_opt, "noaccel", 7))
 			noaccel = 1;
 		else
@@ -1847,10 +1828,8 @@ MODULE_PARM_DESC(noaccel, "Disable acceleration");
 module_param(hwcursor, int, 0644);
 MODULE_PARM_DESC(hwcursor, "Enable hardware cursor "
 			"(1=enable, 0=disable, default=1)");
-#ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);
 MODULE_PARM_DESC(nomtrr, "Disable MTRR support (0 or 1=disabled) (default=0)");
-#endif
 
 MODULE_AUTHOR("Jim Hague <jim.hague@acm.org>");
 MODULE_DESCRIPTION("Permedia2 framebuffer device driver");
-- 
2.3.2.209.gd67f9d5.dirty

