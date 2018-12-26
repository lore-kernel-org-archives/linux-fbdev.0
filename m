From: Finn Thain <fthain@telegraphics.com.au>
Date: Wed, 26 Dec 2018 00:37:59 +0000
Subject: [PATCH v8 15/25] powerpc: Clean up nvram includes
Message-Id: <8d58e5de5c72c9137ebb1de3d2979d587d0c38b6.1545784679.git.fthain@telegraphics.com.au>
List-Id: <linux-fbdev.vger.kernel.org>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1545784679.git.fthain@telegraphics.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org

The nvram_read_byte() and nvram_write_byte() definitions in asm/nvram.h
duplicate those in linux/nvram.h. Get rid of the former to prepare for
adoption of struct arch_nvram_ops (which is defined in linux/nvram.h for
general use).

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Stan Johnson <userm57@yahoo.com>
---
 arch/powerpc/include/asm/nvram.h           | 3 ---
 arch/powerpc/kernel/setup_32.c             | 1 +
 drivers/char/generic_nvram.c               | 1 +
 drivers/video/fbdev/matrox/matroxfb_base.c | 2 +-
 4 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/nvram.h b/arch/powerpc/include/asm/nvram.h
index 09a518bb7c03..1443b40f44b9 100644
--- a/arch/powerpc/include/asm/nvram.h
+++ b/arch/powerpc/include/asm/nvram.h
@@ -101,7 +101,4 @@ extern int nvram_write_os_partition(struct nvram_os_partition *part,
 /* Determine NVRAM size */
 extern ssize_t nvram_get_size(void);
 
-/* Normal access to NVRAM */
-extern unsigned char nvram_read_byte(int i);
-extern void nvram_write_byte(unsigned char c, int i);
 #endif /* _ASM_POWERPC_NVRAM_H */
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index 81909600013a..04c0315cfe46 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -17,6 +17,7 @@
 #include <linux/console.h>
 #include <linux/memblock.h>
 #include <linux/export.h>
+#include <linux/nvram.h>
 
 #include <asm/io.h>
 #include <asm/prom.h>
diff --git a/drivers/char/generic_nvram.c b/drivers/char/generic_nvram.c
index 14e728fbb8a0..0381af638fe3 100644
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
-- 
2.19.2
