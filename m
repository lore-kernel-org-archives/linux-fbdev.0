From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 20 Mar 2015 23:18:26 +0000
Subject: [PATCH v1 36/47] video: fbdev: i810: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <1426893517-2511-37-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

The same area used for MTRR is used for the ioremap() area.
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
 drivers/video/fbdev/i810/i810.h      |  3 +--
 drivers/video/fbdev/i810/i810_main.c | 11 +++++++----
 drivers/video/fbdev/i810/i810_main.h | 26 --------------------------
 3 files changed, 8 insertions(+), 32 deletions(-)

diff --git a/drivers/video/fbdev/i810/i810.h b/drivers/video/fbdev/i810/i810.h
index 1414b73..7b1c002 100644
--- a/drivers/video/fbdev/i810/i810.h
+++ b/drivers/video/fbdev/i810/i810.h
@@ -199,7 +199,6 @@
 #define HAS_FONTCACHE               8 
 
 /* driver flags */
-#define HAS_MTRR                    1
 #define HAS_ACCELERATION            2
 #define ALWAYS_SYNC                 4
 #define LOCKUP                      8
@@ -281,7 +280,7 @@ struct i810fb_par {
 	u32 ovract;
 	u32 cur_state;
 	u32 ddc_num;
-	int mtrr_reg;
+	int wc_cookie;
 	u16 bltcntl;
 	u8 interlace;
 };
diff --git a/drivers/video/fbdev/i810/i810_main.c b/drivers/video/fbdev/i810/i810_main.c
index bb674e4..025b882 100644
--- a/drivers/video/fbdev/i810/i810_main.c
+++ b/drivers/video/fbdev/i810/i810_main.c
@@ -41,6 +41,7 @@
 #include <linux/resource.h>
 #include <linux/unistd.h>
 #include <linux/console.h>
+#include <linux/io.h>
 
 #include <asm/io.h>
 #include <asm/div64.h>
@@ -1816,7 +1817,9 @@ static void i810_init_device(struct i810fb_par *par)
 	u8 reg;
 	u8 __iomem *mmio = par->mmio_start_virtual;
 
-	if (mtrr) set_mtrr(par);
+	if (mtrr)
+		par->wc_cookie= arch_phys_wc_add((u32) par->aperture.physical,
+						 par->aperture.size);
 
 	i810_init_cursor(par);
 
@@ -1865,8 +1868,8 @@ static int i810_allocate_pci_resource(struct i810fb_par *par,
 	}
 	par->res_flags |= FRAMEBUFFER_REQ;
 
-	par->aperture.virtual = ioremap_nocache(par->aperture.physical, 
-					par->aperture.size);
+	par->aperture.virtual = ioremap_wc(par->aperture.physical,
+					   par->aperture.size);
 	if (!par->aperture.virtual) {
 		printk("i810fb_init: cannot remap framebuffer region\n");
 		return -ENODEV;
@@ -2096,7 +2099,7 @@ static void i810fb_release_resource(struct fb_info *info,
 				    struct i810fb_par *par)
 {
 	struct gtt_data *gtt = &par->i810_gtt;
-	unset_mtrr(par);
+	arch_phys_wc_del(par->wc_cookie);
 
 	i810_delete_i2c_busses(par);
 
diff --git a/drivers/video/fbdev/i810/i810_main.h b/drivers/video/fbdev/i810/i810_main.h
index a25afaa..7bfaaad 100644
--- a/drivers/video/fbdev/i810/i810_main.h
+++ b/drivers/video/fbdev/i810/i810_main.h
@@ -60,32 +60,6 @@ static inline void flush_cache(void)
 #define flush_cache() do { } while(0)
 #endif 
 
-#ifdef CONFIG_MTRR
-
-#include <asm/mtrr.h>
-
-static inline void set_mtrr(struct i810fb_par *par)
-{
-	par->mtrr_reg = mtrr_add((u32) par->aperture.physical, 
-		 par->aperture.size, MTRR_TYPE_WRCOMB, 1);
-	if (par->mtrr_reg < 0) {
-		printk(KERN_ERR "set_mtrr: unable to set MTRR\n");
-		return;
-	}
-	par->dev_flags |= HAS_MTRR;
-}
-static inline void unset_mtrr(struct i810fb_par *par)
-{
-  	if (par->dev_flags & HAS_MTRR) 
-  		mtrr_del(par->mtrr_reg, (u32) par->aperture.physical, 
-			 par->aperture.size); 
-}
-#else
-#define set_mtrr(x) printk("set_mtrr: MTRR is disabled in the kernel\n")
-
-#define unset_mtrr(x) do { } while (0)
-#endif /* CONFIG_MTRR */
-
 #ifdef CONFIG_FB_I810_GTF
 #define IS_DVT (0)
 #else
-- 
2.3.2.209.gd67f9d5.dirty

