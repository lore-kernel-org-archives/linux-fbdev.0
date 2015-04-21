From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 21 Apr 2015 20:42:51 +0000
Subject: [PATCH v3] mtrr: avoid ifdef'ery with phys_wc_to_mtrr_index()
Message-Id: <1429648971-18007-1-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

There is only one user but since we're going to bury
MTRR next out of access to drivers expose this last
piece of API to drivers in a general fashion only
needing io.h for access to helpers.

Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Abhilash Kesavan <a.kesavan@samsung.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Cristian Stoica <cristian.stoica@freescale.com>
Cc: dri-devel@lists.freedesktop.org
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ville Syrjälä <syrjala@sci.fi>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Borislav Petkov <bp@suse.de>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: x86@kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 arch/x86/include/asm/io.h       |  3 +++
 arch/x86/include/asm/mtrr.h     |  5 -----
 arch/x86/kernel/cpu/mtrr/main.c |  6 +++---
 drivers/gpu/drm/drm_ioctl.c     | 14 +-------------
 include/linux/io.h              |  6 ++++++
 5 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 4afc05f..a2b9740 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -339,6 +339,9 @@ extern bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 #define IO_SPACE_LIMIT 0xffff
 
 #ifdef CONFIG_MTRR
+extern int __must_check arch_phys_wc_index(int handle);
+#define arch_phys_wc_index arch_phys_wc_index
+
 extern int __must_check arch_phys_wc_add(unsigned long base,
 					 unsigned long size);
 extern void arch_phys_wc_del(int handle);
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index da8dff1..27e3dc0 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -48,7 +48,6 @@ extern void mtrr_aps_init(void);
 extern void mtrr_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
-extern int phys_wc_to_mtrr_index(int handle);
 #  else
 static inline u8 mtrr_type_lookup(u64 addr, u64 end, u8 *uniform)
 {
@@ -85,10 +84,6 @@ static inline int mtrr_trim_uncached_memory(unsigned long end_pfn)
 static inline void mtrr_centaur_report_mcr(int mcr, u32 lo, u32 hi)
 {
 }
-static inline int phys_wc_to_mtrr_index(int handle)
-{
-	return -1;
-}
 
 #define mtrr_ap_init() do {} while (0)
 #define mtrr_bp_init() do {} while (0)
diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
index 12abdbe..d8c106c 100644
--- a/arch/x86/kernel/cpu/mtrr/main.c
+++ b/arch/x86/kernel/cpu/mtrr/main.c
@@ -580,7 +580,7 @@ void arch_phys_wc_del(int handle)
 EXPORT_SYMBOL(arch_phys_wc_del);
 
 /*
- * phys_wc_to_mtrr_index - translates arch_phys_wc_add's return value
+ * arch_phys_wc_index - translates arch_phys_wc_add's return value
  * @handle: Return value from arch_phys_wc_add
  *
  * This will turn the return value from arch_phys_wc_add into an mtrr
@@ -590,14 +590,14 @@ EXPORT_SYMBOL(arch_phys_wc_del);
  * in printk line.  Alas there is an illegitimate use in some ancient
  * drm ioctls.
  */
-int phys_wc_to_mtrr_index(int handle)
+int arch_phys_wc_index(int handle)
 {
 	if (handle < MTRR_TO_PHYS_WC_OFFSET)
 		return -1;
 	else
 		return handle - MTRR_TO_PHYS_WC_OFFSET;
 }
-EXPORT_SYMBOL_GPL(phys_wc_to_mtrr_index);
+EXPORT_SYMBOL_GPL(arch_phys_wc_index);
 
 /*
  * HACK ALERT!
diff --git a/drivers/gpu/drm/drm_ioctl.c b/drivers/gpu/drm/drm_ioctl.c
index 266dcd6..0a95782 100644
--- a/drivers/gpu/drm/drm_ioctl.c
+++ b/drivers/gpu/drm/drm_ioctl.c
@@ -36,9 +36,6 @@
 
 #include <linux/pci.h>
 #include <linux/export.h>
-#ifdef CONFIG_X86
-#include <asm/mtrr.h>
-#endif
 
 static int drm_version(struct drm_device *dev, void *data,
 		       struct drm_file *file_priv);
@@ -197,16 +194,7 @@ static int drm_getmap(struct drm_device *dev, void *data,
 	map->type = r_list->map->type;
 	map->flags = r_list->map->flags;
 	map->handle = (void *)(unsigned long) r_list->user_token;
-
-#ifdef CONFIG_X86
-	/*
-	 * There appears to be exactly one user of the mtrr index: dritest.
-	 * It's easy enough to keep it working on non-PAT systems.
-	 */
-	map->mtrr = phys_wc_to_mtrr_index(r_list->map->mtrr);
-#else
-	map->mtrr = -1;
-#endif
+	map->mtrr = arch_phys_wc_index(r_list->map->mtrr);
 
 	mutex_unlock(&dev->struct_mutex);
 
diff --git a/include/linux/io.h b/include/linux/io.h
index 986f2bf..6e29acf 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -111,6 +111,12 @@ static inline void arch_phys_wc_del(int handle)
 }
 
 #define arch_phys_wc_add arch_phys_wc_add
+#ifndef arch_phys_wc_index
+static inline int arch_phys_wc_index(int handle)
+{
+	return -1;
+}
+#define arch_phys_wc_index arch_phys_wc_index
 #endif
 
 #endif /* _LINUX_IO_H */
-- 
2.3.2.209.gd67f9d5.dirty

