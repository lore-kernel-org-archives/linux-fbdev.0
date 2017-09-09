From: Harsha Sharma <harshasharmaiitr@gmail.com>
Date: Sat, 09 Sep 2017 10:46:47 +0000
Subject: [PATCH] staging: sm750fb: Remove extra blank lines
Message-Id: <1504953287-14740-1-git-send-email-harshasharmaiitr@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org, outreachy-kernel@googlegroups.com, linux-fbdev@vger.kernel.org, Harsha Sharma <harshasharmaiitr@gmail.com>

This was reported by checkpatch.pl

Signed-off-by: Harsha Sharma <harshasharmaiitr@gmail.com>
---
 drivers/staging/sm750fb/sm750_cursor.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/sm750fb/sm750_cursor.c b/drivers/staging/sm750fb/sm750_cursor.c
index aa47a16..6b27b06 100644
--- a/drivers/staging/sm750fb/sm750_cursor.c
+++ b/drivers/staging/sm750fb/sm750_cursor.c
@@ -18,8 +18,6 @@
 #include "sm750.h"
 #include "sm750_cursor.h"
 
-
-
 #define poke32(addr, data) \
 writel((data), cursor->mmio + (addr))
 
@@ -45,7 +43,6 @@
 #define HWC_COLOR_3                         0xC
 #define HWC_COLOR_3_RGB565_MASK             0xffff
 
-
 /* hw_cursor_xxx works for voyager,718 and 750 */
 void sm750_hw_cursor_enable(struct lynx_cursor *cursor)
 {
@@ -134,7 +131,6 @@ void sm750_hw_cursor_setData(struct lynx_cursor *cursor, u16 rop,
 	}
 }
 
-
 void sm750_hw_cursor_setData2(struct lynx_cursor *cursor, u16 rop,
 			      const u8 *pcol, const u8 *pmsk)
 {
-- 
1.9.1

