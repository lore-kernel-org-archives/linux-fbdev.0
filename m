From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 20 Mar 2015 23:18:10 +0000
Subject: [PATCH v1 20/47] mtrr: avoid ifdef'ery with phys_wc_to_mtrr_index()
Message-Id: <1426893517-2511-21-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

There is only one user but since we're going to bury
MTRR next out of access to drivers expose this last
piece of API to drivers in a general fashion only
needing io.h for access to helpers.

Cc: Suresh Siddha <suresh.b.siddha@intel.com>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
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
 arch/x86/include/asm/io.h       |  2 ++
 arch/x86/include/asm/mtrr.h     |  5 -----
 arch/x86/kernel/cpu/mtrr/main.c |  6 +++---
 drivers/gpu/drm/drm_ioctl.c     | 14 +-------------
 include/linux/io.h              |  6 ++++++
 5 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index a144d05..5e3f1f2 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -346,6 +346,8 @@ extern int __must_check arch_phys_wc_add(unsigned long base,
 					 unsigned long size);
 extern void arch_phys_wc_del(int handle);
 #define arch_phys_wc_add arch_phys_wc_add
+extern int arch_phys_wc_index(int handle);
+#define arch_phys_wc_index arch_phys_wc_index
 #endif
 
 #endif /* _ASM_X86_IO_H */
diff --git a/arch/x86/include/asm/mtrr.h b/arch/x86/include/asm/mtrr.h
index cade917..380bb4b 100644
--- a/arch/x86/include/asm/mtrr.h
+++ b/arch/x86/include/asm/mtrr.h
@@ -49,7 +49,6 @@ extern void mtrr_aps_init(void);
 extern void mtrr_bp_restore(void);
 extern int mtrr_trim_uncached_memory(unsigned long end_pfn);
 extern int amd_special_default_mtrr(void);
-extern int phys_wc_to_mtrr_index(int handle);
 #  else
 static const int mtrr_enabled;
 static inline u8 mtrr_type_lookup(u64 addr, u64 end)
@@ -86,10 +85,6 @@ static inline int mtrr_trim_uncached_memory(unsigned long end_pfn)
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
index 5ae830b..b68b671 100644
--- a/arch/x86/kernel/cpu/mtrr/main.c
+++ b/arch/x86/kernel/cpu/mtrr/main.c
@@ -607,7 +607,7 @@ void arch_phys_wc_del(int handle)
 EXPORT_SYMBOL(arch_phys_wc_del);
 
 /*
- * phys_wc_to_mtrr_index - translates arch_phys_wc_add's return value
+ * arch_phys_wc_index - translates arch_phys_wc_add's return value
  * @handle: Return value from arch_phys_wc_add
  *
  * This will turn the return value from arch_phys_wc_add into an mtrr
@@ -617,14 +617,14 @@ EXPORT_SYMBOL(arch_phys_wc_del);
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
index a6d773a..e597cdd 100644
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
index ecc51c3..1676437 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -115,6 +115,12 @@ static inline void arch_phys_wc_del(int handle)
 #define __arch_phys_wc_add arch_phys_wc_add
 #endif
 
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

