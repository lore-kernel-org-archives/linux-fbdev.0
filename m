From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Fri, 20 Mar 2015 23:17:56 +0000
Subject: [PATCH v1 06/47] mtrr: add __arch_phys_wc_add()
Message-Id: <1426893517-2511-7-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1426893517-2511-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: luto@amacapital.net, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, jgross@suse.com, JBeulich@suse.com, bp@suse.de, suresh.b.siddha@intel.com, venkatesh.pallipadi@intel.com, airlied@redhat.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, x86@kernel.org, xen-devel@lists.xenproject.org, "Luis R. Rodriguez" <mcgrof@suse.com>, Ingo Molnar <mingo@elte.hu>, Daniel Vetter <daniel.vetter@ffwll.ch>, Antonino Daplas <adaplas@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

Ideally on systems using PAT we can expect a swift
transition away from MTRR. There can be a few exceptions
to this, one is where device drivers are known to exist
on PATs with errata, another situation is observed on
old device drivers where devices had combined MMIO
register access with whatever area they typically
later wanted to end up using MTRR for on the same
PCI BAR. This situation can still be addressed by
splitting up ioremap'd PCI BAR into two ioremap'd
calls, one for MMIO registers, and another for whatever
is desirable for write-combining -- in order to
accomplish this though quite a bit of driver
restructuring is required.

Device drivers which are known to require large
amount of re-work in order to split ioremap'd areas
can use __arch_phys_wc_add() to avoid regressions
when PAT is enabled.

For a good example driver where things are neatly
split up on a PCI BAR refer the infiniband qib
driver. For a good example of a driver where good
amount of work is required refer to the infiniband
ipath driver.

This is *only* a transitive API -- and as such no new
drivers are ever expected to use this.

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
 arch/x86/include/asm/io.h       |  4 ++++
 arch/x86/kernel/cpu/mtrr/main.c | 36 +++++++++++++++++++++++++++++-------
 include/linux/io.h              |  4 ++++
 3 files changed, 37 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 34a5b93..a144d05 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -338,6 +338,10 @@ extern bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 #define IO_SPACE_LIMIT 0xffff
 
 #ifdef CONFIG_MTRR
+extern int __must_check __arch_phys_wc_add(unsigned long base,
+					   unsigned long size);
+#define __arch_phys_wc_add __arch_phys_wc_add
+
 extern int __must_check arch_phys_wc_add(unsigned long base,
 					 unsigned long size);
 extern void arch_phys_wc_del(int handle);
diff --git a/arch/x86/kernel/cpu/mtrr/main.c b/arch/x86/kernel/cpu/mtrr/main.c
index 7db9c47..5ae830b 100644
--- a/arch/x86/kernel/cpu/mtrr/main.c
+++ b/arch/x86/kernel/cpu/mtrr/main.c
@@ -538,23 +538,24 @@ int mtrr_del(int reg, unsigned long base, unsigned long size)
 EXPORT_SYMBOL(mtrr_del);
 
 /**
- * arch_phys_wc_add - add a WC MTRR and handle errors if PAT is unavailable
+ * __arch_phys_wc_add - add a WC MTRR even if PAT is available
  * @base: Physical base address
  * @size: Size of region
  *
- * If PAT is available, this does nothing.  If PAT is unavailable, it
- * attempts to add a WC MTRR covering size bytes starting at base and
- * logs an error if this fails.
+ * We typically do not want to use MTRR if PAT is available but there
+ * are some drivers which require significant work to get this to work
+ * properly. This call should only be used by those drivers where it is
+ * clear that hard work is required to modify them to use arch_phys_wc_add()
  *
  * Drivers must store the return value to pass to mtrr_del_wc_if_needed,
  * but drivers should not try to interpret that return value.
  */
-int arch_phys_wc_add(unsigned long base, unsigned long size)
+int __arch_phys_wc_add(unsigned long base, unsigned long size)
 {
 	int ret;
 
-	if (pat_enabled || !mtrr_enabled)
-		return 0;  /* Success!  (We don't need to do anything.) */
+	if (!mtrr_enabled)
+		return 0;
 
 	ret = mtrr_add(base, size, MTRR_TYPE_WRCOMB, true);
 	if (ret < 0) {
@@ -564,6 +565,27 @@ int arch_phys_wc_add(unsigned long base, unsigned long size)
 	}
 	return ret + MTRR_TO_PHYS_WC_OFFSET;
 }
+EXPORT_SYMBOL_GPL(__arch_phys_wc_add);
+
+/**
+ * arch_phys_wc_add - add a WC MTRR and handle errors if PAT is unavailable
+ * @base: Physical base address
+ * @size: Size of region
+ *
+ * If PAT is available, this does nothing.  If PAT is unavailable, it
+ * attempts to add a WC MTRR covering size bytes starting at base and
+ * logs an error if this fails.
+ *
+ * Drivers must store the return value to pass to mtrr_del_wc_if_needed,
+ * but drivers should not try to interpret that return value.
+ */
+int arch_phys_wc_add(unsigned long base, unsigned long size)
+{
+	if (pat_enabled || !mtrr_enabled)
+		return 0;  /* Success!  (We don't need to do anything.) */
+
+	return __arch_phys_wc_add(base, size);
+}
 EXPORT_SYMBOL(arch_phys_wc_add);
 
 /*
diff --git a/include/linux/io.h b/include/linux/io.h
index 91101a1..ecc51c3 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -111,6 +111,10 @@ static inline void arch_phys_wc_del(int handle)
 }
 
 #define arch_phys_wc_add arch_phys_wc_add
+#ifndef __arch_phys_wc_add
+#define __arch_phys_wc_add arch_phys_wc_add
+#endif
+
 #endif
 
 #endif /* _LINUX_IO_H */
-- 
2.3.2.209.gd67f9d5.dirty

