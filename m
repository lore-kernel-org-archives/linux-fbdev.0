From: "Luis R. Rodriguez" <mcgrof@do-not-panic.com>
Date: Wed, 26 Aug 2015 23:34:10 +0000
Subject: [PATCH] S390: add pci_iomap_wc() and pci_iomap_wc_range()
Message-Id: <1440632050-23648-1-git-send-email-mcgrof@do-not-panic.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: mingo@kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org
Cc: bp@suse.de, linux@roeck-us.net, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, fengguang.wu@intel.com, akpm@linux-foundation.org, rostedt@goodmis.org, "Luis R. Rodriguez" <mcgrof@suse.com>

From: "Luis R. Rodriguez" <mcgrof@suse.com>

S390 requires its own implementation of pcio_iomap*() calls
is because it has its "BAR spaces are not disjunctive on s390
so we need the bar parameter of pci_iomap to find the corresponding
device and create the mapping cookie" -- in summary, it has its own
lookup/lock solution.

It does not include asm-generic/pci_iomap.h

Since it currenty maps ioremap_wc() to ioremap_nocache() and that's
the architecture default we can easily just map the wc calls to
the default calls as well.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Borislav Petkov <bp@suse.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Fengguang Wu <fengguang.wu@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Reported-by: 0 day bot
Signed-off-by: Luis R. Rodriguez <mcgrof@suse.com>
---

This broke through some series that went into Ingo's tip tree which
I added. As such I *think* this should go through Ingo's tip tree.
Let me know. Up to you guys.

 arch/s390/include/asm/io.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index cb5fdf3a78fc..437e9af96688 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -57,6 +57,8 @@ static inline void ioport_unmap(void __iomem *p)
  */
 #define pci_iomap pci_iomap
 #define pci_iounmap pci_iounmap
+#define pci_iomap_wc pci_iomap
+#define pci_iomap_wc_range pci_iomap_range
 
 #define memcpy_fromio(dst, src, count)	zpci_memcpy_fromio(dst, src, count)
 #define memcpy_toio(dst, src, count)	zpci_memcpy_toio(dst, src, count)
-- 
2.4.3

