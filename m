From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Tue, 21 Apr 2015 20:21:39 +0000
Subject: [PATCH v3 1/4] pci: add pci_iomap_wc() variants
Message-Id: <1429647702-17315-2-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1429647702-17315-1-git-send-email-mcgrof@do-not-panic.com>
In-Reply-To: <1429647702-17315-1-git-send-email-mcgrof@do-not-panic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: cocci@systeme.lip6.fr

From: "Luis R. Rodriguez" <mcgrof@suse.com>

This allows drivers to take advantage of write-combining
when possible. Ideally we'd have pci_read_bases() just
peg an IORESOURCE_WC flag for us but where exactly
video devices memory lie varies *largely* and at times things
are mixed with MMIO registers, sometimes we can address
the changes in drivers, other times the change requires
intrusive changes.

Although there is also arch_phys_wc_add() that makes use of
architecture specific write-combining alternatives (MTRR on
x86 when a system does not have PAT) we void polluting
pci_iomap() space with it and force drivers and subsystems
that want to use it to be explicit.

There are a few motivations for this:

a) Take advantage of PAT when available

b) Help bury MTRR code away, MTRR is architecture specific and on
   x86 its replaced by PAT

c) Help with the goal of eventually using _PAGE_CACHE_UC over
   _PAGE_CACHE_UC_MINUS on x86 on ioremap_nocache() (see commit
   de33c442e titled "x86 PAT: fix performance drop for glx,
   use UC minus for ioremap(), ioremap_nocache() and
   pci_mmap_page_range()")

Cc: Toshi Kani <toshi.kani@hp.com>
Cc: Andy Lutomirski <luto@amacapital.net>
Cc: Suresh Siddha <sbsiddha@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Juergen Gross <jgross@suse.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Dave Airlie <airlied@redhat.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Antonino Daplas <adaplas@gmail.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: venkatesh.pallipadi@intel.com
Cc: Stefan Bader <stefan.bader@canonical.com>
Cc: Ville Syrjälä <syrjala@sci.fi>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Borislav Petkov <bp@suse.de>
Cc: Davidlohr Bueso <dbueso@suse.de>
Cc: konrad.wilk@oracle.com
Cc: ville.syrjala@linux.intel.com
Cc: david.vrabel@citrix.com
Cc: jbeulich@suse.com
Cc: Roger Pau Monné <roger.pau@citrix.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---
 include/asm-generic/pci_iomap.h | 14 ++++++++++
 lib/pci_iomap.c                 | 61 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+)

diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
index 7389c87..b1e17fc 100644
--- a/include/asm-generic/pci_iomap.h
+++ b/include/asm-generic/pci_iomap.h
@@ -15,9 +15,13 @@ struct pci_dev;
 #ifdef CONFIG_PCI
 /* Create a virtual mapping cookie for a PCI BAR (memory or IO) */
 extern void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long max);
+extern void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long max);
 extern void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
 				     unsigned long offset,
 				     unsigned long maxlen);
+extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
+					unsigned long offset,
+					unsigned long maxlen);
 /* Create a virtual mapping cookie for a port on a given PCI device.
  * Do not call this directly, it exists to make it easier for architectures
  * to override */
@@ -34,12 +38,22 @@ static inline void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned lon
 	return NULL;
 }
 
+static inline void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long max)
+{
+	return NULL;
+}
 static inline void __iomem *pci_iomap_range(struct pci_dev *dev, int bar,
 					    unsigned long offset,
 					    unsigned long maxlen)
 {
 	return NULL;
 }
+static inline void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
+					       unsigned long offset,
+					       unsigned long maxlen)
+{
+	return NULL;
+}
 #endif
 
 #endif /* __ASM_GENERIC_IO_H */
diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
index bcce5f1..30b65ae 100644
--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -52,6 +52,46 @@ void __iomem *pci_iomap_range(struct pci_dev *dev,
 EXPORT_SYMBOL(pci_iomap_range);
 
 /**
+ * pci_iomap_wc_range - create a virtual WC mapping cookie for a PCI BAR
+ * @dev: PCI device that owns the BAR
+ * @bar: BAR number
+ * @offset: map memory at the given offset in BAR
+ * @maxlen: max length of the memory to map
+ *
+ * Using this function you will get a __iomem address to your device BAR.
+ * You can access it using ioread*() and iowrite*(). These functions hide
+ * the details if this is a MMIO or PIO address space and will just do what
+ * you expect from them in the correct way. When possible write combining
+ * is used.
+ *
+ * @maxlen specifies the maximum length to map. If you want to get access to
+ * the complete BAR from offset to the end, pass %0 here.
+ * */
+void __iomem *pci_iomap_wc_range(struct pci_dev *dev,
+				 int bar,
+				 unsigned long offset,
+				 unsigned long maxlen)
+{
+	resource_size_t start = pci_resource_start(dev, bar);
+	resource_size_t len = pci_resource_len(dev, bar);
+	unsigned long flags = pci_resource_flags(dev, bar);
+
+	if (len <= offset || !start)
+		return NULL;
+	len -= offset;
+	start += offset;
+	if (maxlen && len > maxlen)
+		len = maxlen;
+	if (flags & IORESOURCE_IO)
+		return __pci_ioport_map(dev, start, len);
+	if (flags & IORESOURCE_MEM)
+		return ioremap_wc(start, len);
+	/* What? */
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(pci_iomap_wc_range);
+
+/**
  * pci_iomap - create a virtual mapping cookie for a PCI BAR
  * @dev: PCI device that owns the BAR
  * @bar: BAR number
@@ -70,4 +110,25 @@ void __iomem *pci_iomap(struct pci_dev *dev, int bar, unsigned long maxlen)
 	return pci_iomap_range(dev, bar, 0, maxlen);
 }
 EXPORT_SYMBOL(pci_iomap);
+
+/**
+ * pci_iomap_wc - create a virtual WC mapping cookie for a PCI BAR
+ * @dev: PCI device that owns the BAR
+ * @bar: BAR number
+ * @maxlen: length of the memory to map
+ *
+ * Using this function you will get a __iomem address to your device BAR.
+ * You can access it using ioread*() and iowrite*(). These functions hide
+ * the details if this is a MMIO or PIO address space and will just do what
+ * you expect from them in the correct way. When possible write combining
+ * is used.
+ *
+ * @maxlen specifies the maximum length to map. If you want to get access to
+ * the complete BAR without checking for its length first, pass %0 here.
+ * */
+void __iomem *pci_iomap_wc(struct pci_dev *dev, int bar, unsigned long maxlen)
+{
+	return pci_iomap_wc_range(dev, bar, 0, maxlen);
+}
+EXPORT_SYMBOL_GPL(pci_iomap_wc);
 #endif /* CONFIG_PCI */
-- 
2.3.2.209.gd67f9d5.dirty

