From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 20 Mar 2015 23:18:17 +0000
Subject: [PATCH v1 27/47] video: fbdev: gbefb: use arch_phys_wc_add() and devm_ioremap_wc()
Message-Id: <1426893517-2511-28-git-send-email-mcgrof@do-not-panic.com>
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
 drivers/video/fbdev/gbefb.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/drivers/video/fbdev/gbefb.c b/drivers/video/fbdev/gbefb.c
index f48ea7e..ef81215 100644
--- a/drivers/video/fbdev/gbefb.c
+++ b/drivers/video/fbdev/gbefb.c
@@ -22,9 +22,6 @@
 #include <linux/module.h>
 #include <linux/io.h>
 
-#ifdef CONFIG_X86
-#include <asm/mtrr.h>
-#endif
 #ifdef CONFIG_MIPS
 #include <asm/addrspace.h>
 #endif
@@ -1176,8 +1173,8 @@ static int gbefb_probe(struct platform_device *p_dev)
 
 	if (gbe_mem_phys) {
 		/* memory was allocated at boot time */
-		gbe_mem = devm_ioremap_nocache(&p_dev->dev, gbe_mem_phys,
-					       gbe_mem_size);
+		gbe_mem = devm_ioremap_wc(&p_dev->dev, gbe_mem_phys,
+					  gbe_mem_size);
 		if (!gbe_mem) {
 			printk(KERN_ERR "gbefb: couldn't map framebuffer\n");
 			ret = -ENOMEM;
@@ -1188,8 +1185,8 @@ static int gbefb_probe(struct platform_device *p_dev)
 	} else {
 		/* try to allocate memory with the classical allocator
 		 * this has high chance to fail on low memory machines */
-		gbe_mem = dma_alloc_coherent(NULL, gbe_mem_size, &gbe_dma_addr,
-					     GFP_KERNEL);
+		gbe_mem = dma_alloc_writecombine(NULL, gbe_mem_size,
+						 &gbe_dma_addr, GFP_KERNEL);
 		if (!gbe_mem) {
 			printk(KERN_ERR "gbefb: couldn't allocate framebuffer memory\n");
 			ret = -ENOMEM;
@@ -1199,10 +1196,7 @@ static int gbefb_probe(struct platform_device *p_dev)
 		gbe_mem_phys = (unsigned long) gbe_dma_addr;
 	}
 
-#ifdef CONFIG_X86
-	info->wc_cookie = mtrr_add(gbe_mem_phys, gbe_mem_size,
-				   MTRR_TYPE_WRCOMB, 1);
-#endif
+	info->wc_cookie = arch_phys_wc_add(gbe_mem_phys, gbe_mem_size);
 
 	/* map framebuffer memory into tiles table */
 	for (i = 0; i < (gbe_mem_size >> TILE_SHIFT); i++)
@@ -1242,10 +1236,7 @@ static int gbefb_probe(struct platform_device *p_dev)
 	return 0;
 
 out_gbe_unmap:
-#ifdef CONFIG_MTRR
-	if (info->wc_cookie >= 0)
-		mtrr_del(info->wc_cookie, 0, 0);
-#endif
+	arch_phys_wc_del(info->wc_cookie);
 	if (gbe_dma_addr)
 		dma_free_coherent(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
 out_tiles_free:
@@ -1265,10 +1256,7 @@ static int gbefb_remove(struct platform_device* p_dev)
 
 	unregister_framebuffer(info);
 	gbe_turn_off();
-#ifdef CONFIG_MTRR
-	if (info->wc_cookie >= 0)
-		mtrr_del(info->wc_cookie, 0, 0);
-#endif
+	arch_phys_wc_del(info->wc_cookie);
 	if (gbe_dma_addr)
 		dma_free_coherent(NULL, gbe_mem_size, gbe_mem, gbe_mem_phys);
 	dma_free_coherent(NULL, GBE_TLB_SIZE * sizeof(uint16_t),
-- 
2.3.2.209.gd67f9d5.dirty

