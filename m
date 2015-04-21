From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 21 Apr 2015 20:16:30 +0000
Subject: [PATCH v3 09/17] video: fbdev: sisfb: use arch_phys_wc_add() and ioremap_wc()
Message-Id: <1429647398-16983-10-git-send-email-mcgrof@do-not-panic.com>
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
Cc: Thomas Winischhofer <thomas@winischhofer.net>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 drivers/video/fbdev/sis/sis.h      |  2 +-
 drivers/video/fbdev/sis/sis_main.c | 27 ++++++---------------------
 2 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/video/fbdev/sis/sis.h b/drivers/video/fbdev/sis/sis.h
index 1987f1b7..ea1d1c9 100644
--- a/drivers/video/fbdev/sis/sis.h
+++ b/drivers/video/fbdev/sis/sis.h
@@ -458,7 +458,7 @@ struct sis_video_info {
 
 	unsigned char	*bios_abase;
 
-	int		mtrr;
+	int		wc_cookie;
 
 	u32		sisfb_mem;
 
diff --git a/drivers/video/fbdev/sis/sis_main.c b/drivers/video/fbdev/sis/sis_main.c
index fcf610e..e923038 100644
--- a/drivers/video/fbdev/sis/sis_main.c
+++ b/drivers/video/fbdev/sis/sis_main.c
@@ -53,9 +53,6 @@
 #include <linux/types.h>
 #include <linux/uaccess.h>
 #include <asm/io.h>
-#ifdef CONFIG_MTRR
-#include <asm/mtrr.h>
-#endif
 
 #include "sis.h"
 #include "sis_main.h"
@@ -4130,13 +4127,13 @@ static void sisfb_post_map_vram(struct sis_video_info *ivideo,
 	if (*mapsize < (min << 20))
 		return;
 
-	ivideo->video_vbase = ioremap(ivideo->video_base, (*mapsize));
+	ivideo->video_vbase = ioremap_wc(ivideo->video_base, (*mapsize));
 
 	if(!ivideo->video_vbase) {
 		printk(KERN_ERR
 			"sisfb: Unable to map maximum video RAM for size detection\n");
 		(*mapsize) >>= 1;
-		while((!(ivideo->video_vbase = ioremap(ivideo->video_base, (*mapsize))))) {
+		while((!(ivideo->video_vbase = ioremap_wc(ivideo->video_base, (*mapsize))))) {
 			(*mapsize) >>= 1;
 			if((*mapsize) < (min << 20))
 				break;
@@ -6186,7 +6183,7 @@ static int sisfb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 		goto error_2;
 	}
 
-	ivideo->video_vbase = ioremap(ivideo->video_base, ivideo->video_size);
+	ivideo->video_vbase = ioremap_wc(ivideo->video_base, ivideo->video_size);
 	ivideo->SiS_Pr.VideoMemoryAddress = ivideo->video_vbase;
 	if(!ivideo->video_vbase) {
 		printk(KERN_ERR "sisfb: Fatal error: Unable to map framebuffer memory\n");
@@ -6254,8 +6251,6 @@ error_3:	vfree(ivideo->bios_abase);
 	ivideo->SiS_Pr.VideoMemoryAddress += ivideo->video_offset;
 	ivideo->SiS_Pr.VideoMemorySize = ivideo->sisfb_mem;
 
-	ivideo->mtrr = -1;
-
 	ivideo->vbflags = 0;
 	ivideo->lcddefmodeidx = DEFAULT_LCDMODE;
 	ivideo->tvdefmodeidx  = DEFAULT_TVMODE;
@@ -6443,14 +6438,8 @@ error_3:	vfree(ivideo->bios_abase);
 
 		printk(KERN_DEBUG "sisfb: Initial vbflags 0x%x\n", (int)ivideo->vbflags);
 
-#ifdef CONFIG_MTRR
-		ivideo->mtrr = mtrr_add(ivideo->video_base, ivideo->video_size,
-					MTRR_TYPE_WRCOMB, 1);
-		if(ivideo->mtrr < 0) {
-			printk(KERN_DEBUG "sisfb: Failed to add MTRRs\n");
-		}
-#endif
-
+		ivideo->wc_cookie = arch_phys_wc_add(ivideo->video_base,
+						     ivideo->video_size);
 		if(register_framebuffer(sis_fb_info) < 0) {
 			printk(KERN_ERR "sisfb: Fatal error: Failed to register framebuffer\n");
 			ret = -EINVAL;
@@ -6507,11 +6496,7 @@ static void sisfb_remove(struct pci_dev *pdev)
 
 	pci_dev_put(ivideo->nbridge);
 
-#ifdef CONFIG_MTRR
-	/* Release MTRR region */
-	if(ivideo->mtrr >= 0)
-		mtrr_del(ivideo->mtrr, ivideo->video_base, ivideo->video_size);
-#endif
+	arch_phys_wc_del(ivideo->wc_cookie);
 
 	/* If device was disabled when starting, disable
 	 * it when quitting.
-- 
2.3.2.209.gd67f9d5.dirty

