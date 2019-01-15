From: Finn Thain <fthain@telegraphics.com.au>
Date: Tue, 15 Jan 2019 04:18:56 +0000
Subject: [PATCH v9 06/22] powerpc: Replace nvram_* extern declarations with standard header
Message-Id: <0792e10d71abdf3152b74bddbb9da68c1f17e48c.1547525936.git.fthain@telegraphics.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1547525936.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1547525936.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

Remove the nvram_read_byte() and nvram_write_byte() declarations in
powerpc/include/asm/nvram.h and use the cross-platform static functions
in linux/nvram.h instead.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
Changed since v8:
 - Added nvram_read_byte() and nvram_write_byte() functions to avoid a
potential build failure during 'git bisect'.
 - Brought forward some powerpc cleanup to avoid naming collisions with
nvram.h functions.
 - Replaced the ppc_md.nvram_* method wrappers with the ones in nvram.h.
---
 arch/powerpc/include/asm/nvram.h           |  6 ------
 arch/powerpc/kernel/setup_32.c             | 25 +---------------------
 drivers/char/generic_nvram.c               |  1 +
 drivers/video/fbdev/matrox/matroxfb_base.c |  2 +-
 include/linux/nvram.h                      |  3 +++
 5 files changed, 6 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/include/asm/nvram.h b/arch/powerpc/include/asm/nvram.h
index 09a518bb7c03..56a388da9c4f 100644
--- a/arch/powerpc/include/asm/nvram.h
+++ b/arch/powerpc/include/asm/nvram.h
@@ -98,10 +98,4 @@ extern int nvram_write_os_partition(struct nvram_os_partition *part,
 				    unsigned int err_type,
 				    unsigned int error_log_cnt);
 
-/* Determine NVRAM size */
-extern ssize_t nvram_get_size(void);
-
-/* Normal access to NVRAM */
-extern unsigned char nvram_read_byte(int i);
-extern void nvram_write_byte(unsigned char c, int i);
 #endif /* _ASM_POWERPC_NVRAM_H */
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 947f904688b0..f5107796e2d7 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -17,6 +17,7 @@
 #include <linux/console.h>
 #include <linux/memblock.h>
 #include <linux/export.h>
+#include <linux/nvram.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
@@ -149,30 +150,6 @@ __setup("l3cr=", ppc_setup_l3cr);
 
 #ifdef CONFIG_GENERIC_NVRAM
 
-/* Generic nvram hooks used by drivers/char/gen_nvram.c */
-unsigned char nvram_read_byte(int addr)
-{
-	if (ppc_md.nvram_read_val)
-		return ppc_md.nvram_read_val(addr);
-	return 0xff;
-}
-EXPORT_SYMBOL(nvram_read_byte);
-
-void nvram_write_byte(unsigned char val, int addr)
-{
-	if (ppc_md.nvram_write_val)
-		ppc_md.nvram_write_val(addr, val);
-}
-EXPORT_SYMBOL(nvram_write_byte);
-
-ssize_t nvram_get_size(void)
-{
-	if (ppc_md.nvram_size)
-		return ppc_md.nvram_size();
-	return -1;
-}
-EXPORT_SYMBOL(nvram_get_size);
-
 void nvram_sync(void)
 {
 	if (ppc_md.nvram_sync)
diff --git a/drivers/char/generic_nvram.c b/drivers/char/generic_nvram.c
index ff5394f47587..0c22b9503e84 100644
--- a/drivers/char/generic_nvram.c
+++ b/drivers/char/generic_nvram.c
@@ -20,6 +20,7 @@
 #include <linux/fcntl.h>
 #include <linux/init.h>
 #include <linux/mutex.h>
+#include <linux/nvram.h>
 #include <linux/pagemap.h>
 #include <linux/uaccess.h>
 #include <asm/nvram.h>
diff --git a/drivers/video/fbdev/matrox/matroxfb_base.c b/drivers/video/fbdev/matrox/matroxfb_base.c
index 838869c6490c..0a4e5bad33f4 100644
--- a/drivers/video/fbdev/matrox/matroxfb_base.c
+++ b/drivers/video/fbdev/matrox/matroxfb_base.c
@@ -111,12 +111,12 @@
 #include "matroxfb_g450.h"
 #include <linux/matroxfb.h>
 #include <linux/interrupt.h>
+#include <linux/nvram.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
 
 #ifdef CONFIG_PPC_PMAC
 #include <asm/machdep.h>
-unsigned char nvram_read_byte(int);
 static int default_vmode = VMODE_NVRAM;
 static int default_cmode = CMODE_NVRAM;
 #endif
diff --git a/include/linux/nvram.h b/include/linux/nvram.h
index a1e01dc89759..79431dab87a1 100644
--- a/include/linux/nvram.h
+++ b/include/linux/nvram.h
@@ -15,8 +15,11 @@ extern const struct nvram_ops arch_nvram_ops;
 
 static inline ssize_t nvram_get_size(void)
 {
+#ifdef CONFIG_PPC
+#else
 	if (arch_nvram_ops.get_size)
 		return arch_nvram_ops.get_size();
+#endif
 	return -ENODEV;
 }
 
-- 
2.19.2
