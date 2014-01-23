From: Mikulas Patocka <mpatocka@redhat.com>
Date: Thu, 23 Jan 2014 19:41:09 +0000
Subject: [PATCH 6/10] mach64: use unaligned access
Message-Id: <alpine.LRH.2.02.1401231440300.7971@file01.intranet.prod.int.rdu2.redhat.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

This patch fixes mach64 to use unaligned access to the font bitmap.

This fixes unaligned access warning on sparc64 when 14x8 font is loaded.

On x86(64), unaligned access is handled in hardware, so both functions
le32_to_cpup and get_unaligned_le32 perform the same operation.

On RISC machines, unaligned access is not handled in hardware, so we
better use get_unaligned_le32 to avoid the unaligned trap and warning.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Cc: stable@vger.kernel.org

---
 drivers/video/aty/mach64_accel.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-3.4.3-fast/drivers/video/aty/mach64_accel.c
=================================--- linux-3.4.3-fast.orig/drivers/video/aty/mach64_accel.c	2012-07-02 00:10:56.000000000 +0200
+++ linux-3.4.3-fast/drivers/video/aty/mach64_accel.c	2012-07-02 00:13:29.000000000 +0200
@@ -4,6 +4,7 @@
  */
 
 #include <linux/delay.h>
+#include <asm/unaligned.h>
 #include <linux/fb.h>
 #include <video/mach64.h>
 #include "atyfb.h"
@@ -419,7 +420,7 @@ void atyfb_imageblit(struct fb_info *inf
 		u32 *pbitmap, dwords = (src_bytes + 3) / 4;
 		for (pbitmap = (u32*)(image->data); dwords; dwords--, pbitmap++) {
 			wait_for_fifo(1, par);
-			aty_st_le32(HOST_DATA0, le32_to_cpup(pbitmap), par);
+			aty_st_le32(HOST_DATA0, get_unaligned_le32(pbitmap), par);
 		}
 	}
 

