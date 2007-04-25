From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 26/41] fbdev: Consolidate common drawing
 functions into a header file
Date: Wed, 25 Apr 2007 14:55:24 +0800
Message-ID: <462EFB5C.8090801@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc9v-0001Lo-3h for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:43:27 -0700
Received: from nz-out-0506.google.com ([64.233.162.235])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc9u-0006pM-IL
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:43:27 -0700
Received: by nz-out-0506.google.com with SMTP id i11so418229nzi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:43:26 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Consolidate common drawing functions into a single header file.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/cfbcopyarea.c |   14 +-------
 drivers/video/cfbfillrect.c |   68 +----------------------------------------
 drivers/video/fb_draw.h     |   72 +++++++++++++++++++++++++++++++++++++++++++
 drivers/video/syscopyarea.c |   12 +------
 drivers/video/sysfillrect.c |   68 +----------------------------------------
 5 files changed, 76 insertions(+), 158 deletions(-)

diff --git a/drivers/video/cfbcopyarea.c b/drivers/video/cfbcopyarea.c
index 6faea40..032210f 100644
--- a/drivers/video/cfbcopyarea.c
+++ b/drivers/video/cfbcopyarea.c
@@ -22,8 +22,6 @@
  *  help moving some redundant computations and branches out of the loop, too.
  */
 
-
-
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/string.h>
@@ -31,6 +29,7 @@ #include <linux/fb.h>
 #include <linux/slab.h>
 #include <asm/types.h>
 #include <asm/io.h>
+#include "fb_draw.h"
 
 #if BITS_PER_LONG == 32
 #  define FB_WRITEL fb_writel
@@ -41,17 +40,6 @@ #  define FB_READL  fb_readq
 #endif
 
     /*
-     *  Compose two values, using a bitmask as decision value
-     *  This is equivalent to (a & mask) | (b & ~mask)
-     */
-
-static inline unsigned long
-comp(unsigned long a, unsigned long b, unsigned long mask)
-{
-    return ((a ^ b) & mask) ^ b;
-}
-
-    /*
      *  Generic bitwise copy algorithm
      */
 
diff --git a/drivers/video/cfbfillrect.c b/drivers/video/cfbfillrect.c
index f00b50a..71623b4 100644
--- a/drivers/video/cfbfillrect.c
+++ b/drivers/video/cfbfillrect.c
@@ -21,6 +21,7 @@ #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/fb.h>
 #include <asm/types.h>
+#include "fb_draw.h"
 
 #if BITS_PER_LONG == 32
 #  define FB_WRITEL fb_writel
@@ -31,73 +32,6 @@ #  define FB_READL  fb_readq
 #endif
 
     /*
-     *  Compose two values, using a bitmask as decision value
-     *  This is equivalent to (a & mask) | (b & ~mask)
-     */
-
-static inline unsigned long
-comp(unsigned long a, unsigned long b, unsigned long mask)
-{
-    return ((a ^ b) & mask) ^ b;
-}
-
-    /*
-     *  Create a pattern with the given pixel's color
-     */
-
-#if BITS_PER_LONG == 64
-static inline unsigned long
-pixel_to_pat( u32 bpp, u32 pixel)
-{
-	switch (bpp) {
-	case 1:
-		return 0xfffffffffffffffful*pixel;
-	case 2:
-		return 0x5555555555555555ul*pixel;
-	case 4:
-		return 0x1111111111111111ul*pixel;
-	case 8:
-		return 0x0101010101010101ul*pixel;
-	case 12:
-		return 0x0001001001001001ul*pixel;
-	case 16:
-		return 0x0001000100010001ul*pixel;
-	case 24:
-		return 0x0000000001000001ul*pixel;
-	case 32:
-		return 0x0000000100000001ul*pixel;
-	default:
-		panic("pixel_to_pat(): unsupported pixelformat\n");
-    }
-}
-#else
-static inline unsigned long
-pixel_to_pat( u32 bpp, u32 pixel)
-{
-	switch (bpp) {
-	case 1:
-		return 0xfffffffful*pixel;
-	case 2:
-		return 0x55555555ul*pixel;
-	case 4:
-		return 0x11111111ul*pixel;
-	case 8:
-		return 0x01010101ul*pixel;
-	case 12:
-		return 0x00001001ul*pixel;
-	case 16:
-		return 0x00010001ul*pixel;
-	case 24:
-		return 0x00000001ul*pixel;
-	case 32:
-		return 0x00000001ul*pixel;
-	default:
-		panic("pixel_to_pat(): unsupported pixelformat\n");
-    }
-}
-#endif
-
-    /*
      *  Aligned pattern fill using 32/64-bit memory accesses
      */
 
diff --git a/drivers/video/fb_draw.h b/drivers/video/fb_draw.h
new file mode 100644
index 0000000..c5c4520
--- /dev/null
+++ b/drivers/video/fb_draw.h
@@ -0,0 +1,72 @@
+#ifndef _FB_DRAW_H
+#define _FB_DRAW_H
+
+#include <asm/types.h>
+
+    /*
+     *  Compose two values, using a bitmask as decision value
+     *  This is equivalent to (a & mask) | (b & ~mask)
+     */
+
+static inline unsigned long
+comp(unsigned long a, unsigned long b, unsigned long mask)
+{
+    return ((a ^ b) & mask) ^ b;
+}
+
+    /*
+     *  Create a pattern with the given pixel's color
+     */
+
+#if BITS_PER_LONG == 64
+static inline unsigned long
+pixel_to_pat( u32 bpp, u32 pixel)
+{
+	switch (bpp) {
+	case 1:
+		return 0xfffffffffffffffful*pixel;
+	case 2:
+		return 0x5555555555555555ul*pixel;
+	case 4:
+		return 0x1111111111111111ul*pixel;
+	case 8:
+		return 0x0101010101010101ul*pixel;
+	case 12:
+		return 0x0001001001001001ul*pixel;
+	case 16:
+		return 0x0001000100010001ul*pixel;
+	case 24:
+		return 0x0000000001000001ul*pixel;
+	case 32:
+		return 0x0000000100000001ul*pixel;
+	default:
+		panic("pixel_to_pat(): unsupported pixelformat\n");
+    }
+}
+#else
+static inline unsigned long
+pixel_to_pat( u32 bpp, u32 pixel)
+{
+	switch (bpp) {
+	case 1:
+		return 0xfffffffful*pixel;
+	case 2:
+		return 0x55555555ul*pixel;
+	case 4:
+		return 0x11111111ul*pixel;
+	case 8:
+		return 0x01010101ul*pixel;
+	case 12:
+		return 0x00001001ul*pixel;
+	case 16:
+		return 0x00010001ul*pixel;
+	case 24:
+		return 0x00000001ul*pixel;
+	case 32:
+		return 0x00000001ul*pixel;
+	default:
+		panic("pixel_to_pat(): unsupported pixelformat\n");
+    }
+}
+#endif
+#endif /* FB_DRAW_H */
diff --git a/drivers/video/syscopyarea.c b/drivers/video/syscopyarea.c
index e348893..37af10a 100644
--- a/drivers/video/syscopyarea.c
+++ b/drivers/video/syscopyarea.c
@@ -19,17 +19,7 @@ #include <linux/fb.h>
 #include <linux/slab.h>
 #include <asm/types.h>
 #include <asm/io.h>
-
-    /*
-     *  Compose two values, using a bitmask as decision value
-     *  This is equivalent to (a & mask) | (b & ~mask)
-     */
-
-static inline unsigned long
-comp(unsigned long a, unsigned long b, unsigned long mask)
-{
-    return ((a ^ b) & mask) ^ b;
-}
+#include "fb_draw.h"
 
     /*
      *  Generic bitwise copy algorithm
diff --git a/drivers/video/sysfillrect.c b/drivers/video/sysfillrect.c
index 10de707..a261e9e 100644
--- a/drivers/video/sysfillrect.c
+++ b/drivers/video/sysfillrect.c
@@ -15,73 +15,7 @@ #include <linux/module.h>
 #include <linux/string.h>
 #include <linux/fb.h>
 #include <asm/types.h>
-
-    /*
-     *  Compose two values, using a bitmask as decision value
-     *  This is equivalent to (a & mask) | (b & ~mask)
-     */
-
-static inline unsigned long
-comp(unsigned long a, unsigned long b, unsigned long mask)
-{
-    return ((a ^ b) & mask) ^ b;
-}
-
-    /*
-     *  Create a pattern with the given pixel's color
-     */
-
-#if BITS_PER_LONG == 64
-static inline unsigned long
-pixel_to_pat( u32 bpp, u32 pixel)
-{
-	switch (bpp) {
-	case 1:
-		return 0xfffffffffffffffful*pixel;
-	case 2:
-		return 0x5555555555555555ul*pixel;
-	case 4:
-		return 0x1111111111111111ul*pixel;
-	case 8:
-		return 0x0101010101010101ul*pixel;
-	case 12:
-		return 0x0001001001001001ul*pixel;
-	case 16:
-		return 0x0001000100010001ul*pixel;
-	case 24:
-		return 0x0000000001000001ul*pixel;
-	case 32:
-		return 0x0000000100000001ul*pixel;
-	default:
-		panic("pixel_to_pat(): unsupported pixelformat\n");
-    }
-}
-#else
-static inline unsigned long
-pixel_to_pat( u32 bpp, u32 pixel)
-{
-	switch (bpp) {
-	case 1:
-		return 0xfffffffful*pixel;
-	case 2:
-		return 0x55555555ul*pixel;
-	case 4:
-		return 0x11111111ul*pixel;
-	case 8:
-		return 0x01010101ul*pixel;
-	case 12:
-		return 0x00001001ul*pixel;
-	case 16:
-		return 0x00010001ul*pixel;
-	case 24:
-		return 0x00000001ul*pixel;
-	case 32:
-		return 0x00000001ul*pixel;
-	default:
-		panic("pixel_to_pat(): unsupported pixelformat\n");
-    }
-}
-#endif
+#include "fb_draw.h"
 
     /*
      *  Aligned pattern fill using 32/64-bit memory accesses


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
