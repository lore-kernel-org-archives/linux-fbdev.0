From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 21 Apr 2015 20:26:05 +0000
Subject: [PATCH v3 1/6] x86: add ioremap_uc() - force strong UC, PCD=1, PWT=1
Message-Id: <1429647970-17479-2-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647970-17479-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429647970-17479-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

ioremap_nocache() currently uses UC- by default.
Our goal is to eventually make UC the default.
Linux maps UC- to PCD=1, PWT=0 page attributes on
non-PAT systems. Linux maps UC to PCD=1, PWT=1
page attributes on non-PAT systems. On non-PAT
systems a WC MTRR has different effects on pages
with either of these attributes. In order to help
with a smooth transition its best to enable use
of UC (PCD,1, PWT=1) on a region as that ensures
a WC MTRR will have no effect on a region, this
however requires us to have an way to declare a
region as UC and we currently do not have a way
to do this.

WC MTRR on non-PAT system with PCD=1, PWT=0 (UC-) yields WC.
WC MTRR on non-PAT system with PCD=1, PWT=1 (UC)  yields UC.

A flip of the default ioremap_nocache() behaviour
from UC- to UC can therefore regress a memory
region from effective memory type WC to UC if MTRRs
are used. Use of MTRRs should be phased out and in
the best case only arch_phys_wc_add() use will remain,
even if this happens arch_phys_wc_add() will have an
effect on non-PAT systems and changes to default
ioremap_nocache() behaviour could regress drivers.

Now, ideally we'd use ioremap_nocache() on the regions
in which we'd need uncachable memory types and avoid
any MTRRs on those regions. There are however some
restrictions on MTRRs use, such as the requirement of
having the base and size of variable sized MTRRs
to be powers of two, which could mean having to use
a WC MTRR over a large area which includes a region
in which write-combining effects are undesirable.

Add ioremap_uc() to help with the both phasing out of
MTRR use and also provide a way to blacklist small
WC undesirable regions in devices with mixed regions
which are size-implicated to use large WC MTRRs. Use
of ioremap_uc() helps phase out MTRR use by avoiding
regressions with an eventual flip of default behaviour
or ioremap_nocache() from UC- to UC.

Drivers working with WC MTRRs can use the below table
to review and consider the use of ioremap*() and similar
helpers to ensure appropriate behaviour long term even
if default ioremap_nocache() behaviour changes from UC-
to UC.

Although ioremap_uc() is being added we leave set_memory_uc()
to use UC- as only initial memory type setup is required
to be able to accomodate existing device drivers and phase
out MTRR use. It should also be clarified that set_memory_uc()
cannot be used with IO memory, even though its use will
not return any errors, it really has no effect.

----------------------------------------------------------------------
MTRR Non-PAT   PAT    Linux ioremap value        Effective memory type
----------------------------------------------------------------------
                                                  Non-PAT |  PAT
     PAT
     |PCD
     ||PWT
     |||
WC   000      WB      _PAGE_CACHE_MODE_WB            WC   |   WC
WC   001      WC      _PAGE_CACHE_MODE_WC            WC*  |   WC
WC   010      UC-     _PAGE_CACHE_MODE_UC_MINUS      WC*  |   UC
WC   011      UC      _PAGE_CACHE_MODE_UC            UC   |   UC
----------------------------------------------------------------------

Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Ville Syrjälä <syrjala@sci.fi>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Mike Travis <travis@sgi.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Borislav Petkov <bp@suse.de>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: x86@kernel.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 arch/x86/include/asm/io.h |  1 +
 arch/x86/mm/ioremap.c     | 36 +++++++++++++++++++++++++++++++++++-
 arch/x86/mm/pageattr.c    |  3 +++
 include/asm-generic/io.h  |  8 ++++++++
 4 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/io.h b/arch/x86/include/asm/io.h
index 34a5b93..4afc05f 100644
--- a/arch/x86/include/asm/io.h
+++ b/arch/x86/include/asm/io.h
@@ -177,6 +177,7 @@ static inline unsigned int isa_virt_to_bus(volatile void *address)
  * look at pci_iomap().
  */
 extern void __iomem *ioremap_nocache(resource_size_t offset, unsigned long size);
+extern void __iomem *ioremap_uc(resource_size_t offset, unsigned long size);
 extern void __iomem *ioremap_cache(resource_size_t offset, unsigned long size);
 extern void __iomem *ioremap_prot(resource_size_t offset, unsigned long size,
 				unsigned long prot_val);
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 70e7444..a493bb8 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -237,7 +237,8 @@ void __iomem *ioremap_nocache(resource_size_t phys_addr, unsigned long size)
 	 *	pat_enabled ? _PAGE_CACHE_MODE_UC : _PAGE_CACHE_MODE_UC_MINUS;
 	 *
 	 * Till we fix all X drivers to use ioremap_wc(), we will use
-	 * UC MINUS.
+	 * UC MINUS. Drivers that are certain they need or can already
+	 * be converted over to strong UC can use ioremap_uc().
 	 */
 	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC_MINUS;
 
@@ -247,6 +248,39 @@ void __iomem *ioremap_nocache(resource_size_t phys_addr, unsigned long size)
 EXPORT_SYMBOL(ioremap_nocache);
 
 /**
+ * ioremap_uc     -   map bus memory into CPU space as strongly uncachable
+ * @phys_addr:    bus address of the memory
+ * @size:      size of the resource to map
+ *
+ * ioremap_uc performs a platform specific sequence of operations to
+ * make bus memory CPU accessible via the readb/readw/readl/writeb/
+ * writew/writel functions and the other mmio helpers. The returned
+ * address is not guaranteed to be usable directly as a virtual
+ * address.
+ *
+ * This version of ioremap ensures that the memory is marked with a strong
+ * preference as completely uncachable on the CPU when possible. For non-PAT
+ * systems this ends up setting page-attribute flags PCD=1, PWT=1. For PAT
+ * systems this will set the PAT entry for the pages as strong UC.  This call
+ * will honor existing caching rules from things like the PCI bus. Note that
+ * there are other caches and buffers on many busses. In particular driver
+ * authors should read up on PCI writes.
+ *
+ * It's useful if some control registers are in such an area and
+ * write combining or read caching is not desirable:
+ *
+ * Must be freed with iounmap.
+ */
+void __iomem *ioremap_uc(resource_size_t phys_addr, unsigned long size)
+{
+	enum page_cache_mode pcm = _PAGE_CACHE_MODE_UC;
+
+	return __ioremap_caller(phys_addr, size, pcm,
+				__builtin_return_address(0));
+}
+EXPORT_SYMBOL_GPL(ioremap_uc);
+
+/**
  * ioremap_wc	-	map memory into CPU space write combined
  * @phys_addr:	bus address of the memory
  * @size:	size of the resource to map
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 89af288..49660c0 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1468,6 +1468,9 @@ int _set_memory_uc(unsigned long addr, int numpages)
 {
 	/*
 	 * for now UC MINUS. see comments in ioremap_nocache()
+	 * If you really need strong UC use ioremap_uc(), but note
+	 * that you cannot override IO areas with set_memory_*() as
+	 * these helpers cannot work with IO memory.
 	 */
 	return change_page_attr_set(&addr, numpages,
 				    cachemode2pgprot(_PAGE_CACHE_MODE_UC_MINUS),
diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 9db0423..90ccba7 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -769,6 +769,14 @@ static inline void __iomem *ioremap_nocache(phys_addr_t offset, size_t size)
 }
 #endif
 
+#ifndef ioremap_uc
+#define ioremap_uc ioremap_uc
+static inline void __iomem *ioremap_uc(phys_addr_t offset, size_t size)
+{
+	return ioremap_nocache(offset, size);
+}
+#endif
+
 #ifndef ioremap_wc
 #define ioremap_wc ioremap_wc
 static inline void __iomem *ioremap_wc(phys_addr_t offset, size_t size)
-- 
2.3.2.209.gd67f9d5.dirty

