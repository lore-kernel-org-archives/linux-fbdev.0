From: yalin wang <yalin.wang2010@gmail.com>
Date: Mon, 10 Aug 2015 10:12:50 +0000
Subject: [RFC] fbdev/riva:change to use generice function to implement  reverse_order()
Message-Id: <C21B8761-0447-45A6-B833-742E3B4C13DE@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: adaplas@gmail.com, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, open list <linux-kernel@vger.kernel.org>

This change to use swab32(bitrev32()) to implement reverse_order()
function, have better performance on some platforms.

Signed-off-by: yalin wang <yalin.wang2010@gmail.com>
---
 drivers/video/fbdev/riva/fbdev.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/video/fbdev/riva/fbdev.c b/drivers/video/fbdev/riva/fbdev.c
index f1ad274..4803901 100644
--- a/drivers/video/fbdev/riva/fbdev.c
+++ b/drivers/video/fbdev/riva/fbdev.c
@@ -40,6 +40,7 @@
 #include <linux/init.h>
 #include <linux/pci.h>
 #include <linux/backlight.h>
+#include <linux/swab.h>
 #include <linux/bitrev.h>
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/machdep.h>
@@ -84,6 +85,7 @@
 #define SetBit(n)		(1<<(n))
 #define Set8Bits(value)		((value)&0xff)
 
+#define reverse_order(v) swab32(bitrev32(v))
 /* HW cursor parameters */
 #define MAX_CURS		32
 
@@ -451,15 +453,6 @@ static inline unsigned char MISCin(struct riva_par *par)
 	return (VGA_RD08(par->riva.PVIO, 0x3cc));
 }
 
-static inline void reverse_order(u32 *l)
-{
-	u8 *a = (u8 *)l;
-	a[0] = bitrev8(a[0]);
-	a[1] = bitrev8(a[1]);
-	a[2] = bitrev8(a[2]);
-	a[3] = bitrev8(a[3]);
-}
-
 /* ------------------------------------------------------------------------- *
  *
  * cursor stuff
@@ -497,8 +490,8 @@ static void rivafb_load_cursor_image(struct riva_par *par, u8 *data8,
 
 	for (i = 0; i < h; i++) {
 		b = *data++;
-		reverse_order(&b);
-		
+		b = reverse_order(b);
+
 		for (j = 0; j < w/2; j++) {
 			tmp = 0;
 #if defined (__BIG_ENDIAN)
@@ -1545,7 +1538,7 @@ static void rivafb_imageblit(struct fb_info *info,
 		for (i = 0; i < 16; i++) {
 			tmp = *((u32 *)cdat);
 			cdat = (u8 *)((u32 *)cdat + 1);
-			reverse_order(&tmp);
+			tmp = reverse_order(tmp);
 			NV_WR32(d, i*4, tmp);
 		}
 		size -= 16;
@@ -1555,7 +1548,7 @@ static void rivafb_imageblit(struct fb_info *info,
 		for (i = 0; i < size; i++) {
 			tmp = *((u32 *) cdat);
 			cdat = (u8 *)((u32 *)cdat + 1);
-			reverse_order(&tmp);
+			tmp = reverse_order(tmp);
 			NV_WR32(d, i*4, tmp);
 		}
 	}
-- 
1.9.1

