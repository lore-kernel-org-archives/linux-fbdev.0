From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 12 Jan 2020 17:15:21 +0000
Subject: [PATCH] fbdev: c2p: Use BUILD_BUG() instead of custom solution
Message-Id: <20200112171521.22443-1-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, linux-fbdev@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@vger.kernel.org, dri-devel@lists.freedesktop.org

Replace the call to the custom non-existing function by a standard
BUILD_BUG() invocation.

Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/fbdev/c2p_core.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/c2p_core.h b/drivers/video/fbdev/c2p_core.h
index 45a6d895a7d7208e..cf5f1ebce65e6afd 100644
--- a/drivers/video/fbdev/c2p_core.h
+++ b/drivers/video/fbdev/c2p_core.h
@@ -12,6 +12,8 @@
  *  for more details.
  */
 
+#include <linux/build_bug.h>
+
 
     /*
      *  Basic transpose step
@@ -27,8 +29,6 @@ static inline void _transp(u32 d[], unsigned int i1, unsigned int i2,
 }
 
 
-extern void c2p_unsupported(void);
-
 static __always_inline u32 get_mask(unsigned int n)
 {
 	switch (n) {
@@ -48,7 +48,7 @@ static __always_inline u32 get_mask(unsigned int n)
 		return 0x0000ffff;
 	}
 
-	c2p_unsupported();
+	BUILD_BUG();
 	return 0;
 }
 
@@ -91,7 +91,7 @@ static __always_inline void transp8(u32 d[], unsigned int n, unsigned int m)
 		return;
 	}
 
-	c2p_unsupported();
+	BUILD_BUG();
 }
 
 
@@ -118,7 +118,7 @@ static __always_inline void transp4(u32 d[], unsigned int n, unsigned int m)
 		return;
 	}
 
-	c2p_unsupported();
+	BUILD_BUG();
 }
 
 
@@ -138,7 +138,7 @@ static __always_inline void transp4x(u32 d[], unsigned int n, unsigned int m)
 		return;
 	}
 
-	c2p_unsupported();
+	BUILD_BUG();
 }
 
 
-- 
2.17.1
