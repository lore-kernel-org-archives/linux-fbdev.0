From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 20 Mar 2015 23:18:09 +0000
Subject: [PATCH v1 19/47] video: fbdev: vesafb: use arch_phys_wc_add()
Message-Id: <1426893517-2511-20-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This driver uses the same area for MTRR as for the ioremap_wc(), if
anything it just uses a smaller size in case MTRR reservation fails.
ioremap_wc() API is already used to take advantage of architecture
write-combining when available.

Convert the driver from using the x86 specific MTRR code to
the architecture agnostic arch_phys_wc_add(). arch_phys_wc_add()
will avoid MTRR if write-combining is available.

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
 drivers/video/fbdev/vesafb.c | 29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/video/fbdev/vesafb.c b/drivers/video/fbdev/vesafb.c
index a2261d0..5bc94d3 100644
--- a/drivers/video/fbdev/vesafb.c
+++ b/drivers/video/fbdev/vesafb.c
@@ -19,10 +19,9 @@
 #include <linux/init.h>
 #include <linux/platform_device.h>
 #include <linux/screen_info.h>
+#include <linux/io.h>
 
 #include <video/vga.h>
-#include <asm/io.h>
-#include <asm/mtrr.h>
 
 #define dac_reg	(0x3c8)
 #define dac_val	(0x3c9)
@@ -179,16 +178,10 @@ static int vesafb_setcolreg(unsigned regno, unsigned red, unsigned green,
 
 static void vesafb_destroy(struct fb_info *info)
 {
-#ifdef CONFIG_MTRR
 	struct vesafb_par *par = info->par;
-#endif
 
 	fb_dealloc_cmap(&info->cmap);
-
-#ifdef CONFIG_MTRR
-	if (par->wc_cookie >= 0)
-		mtrr_del(par->wc_cookie, 0, 0);
-#endif
+	arch_phys_wc_del(par->wc_cookie);
 	if (info->screen_base)
 		iounmap(info->screen_base);
 	release_mem_region(info->apertures->ranges[0].base, info->apertures->ranges[0].size);
@@ -419,7 +412,6 @@ static int vesafb_probe(struct platform_device *dev)
 	request_region(0x3c0, 32, "vesafb");
 
 	if (mtrr = 3) {
-#ifdef CONFIG_MTRR
 		unsigned int temp_size = size_total;
 
 		/* Find the largest power-of-two */
@@ -427,18 +419,16 @@ static int vesafb_probe(struct platform_device *dev)
 
 		/* Try and find a power of two to add */
 		do {
-			par->wc_cookie = mtrr_add(vesafb_fix.smem_start,
-						  temp_size,
-						  MTRR_TYPE_WRCOMB, 1);
+			par->wc_cookie +				arch_phys_wc_add(vesafb_fix.smem_start,
+						 temp_size);
 			temp_size >>= 1;
-		} while (temp_size >= PAGE_SIZE && par->wc_cookie = -EINVAL);
-#endif
+		} while (temp_size >= PAGE_SIZE && par->wc_cookie < 0);
+
 		info->screen_base = ioremap_wc(vesafb_fix.smem_start, vesafb_fix.smem_len);
 	} else {
-#ifdef CONFIG_MTRR
 		if (mtrr && mtrr != 3)
 			WARN_ONCE(1, "Only MTRR_TYPE_WRCOMB (3) make sense\n");
-#endif
 		info->screen_base = ioremap(vesafb_fix.smem_start, vesafb_fix.smem_len);
 	}
 
@@ -476,10 +466,7 @@ static int vesafb_probe(struct platform_device *dev)
 	fb_info(info, "%s frame buffer device\n", info->fix.id);
 	return 0;
 err:
-#ifdef CONFIG_MTRR
-	if (par->wc_cookie >= 0)
-		mtrr_del(par->wc_cookie, 0, 0);
-#endif
+	arch_phys_wc_del(par->wc_cookie);
 	if (info->screen_base)
 		iounmap(info->screen_base);
 	framebuffer_release(info);
-- 
2.3.2.209.gd67f9d5.dirty

