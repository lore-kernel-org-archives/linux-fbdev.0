From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date: Thu, 16 Jan 2020 14:53:20 +0000
Subject: [PATCH 1/2] video: fbdev: w100fb: fix sparse warnings
Message-Id: <d438108a-e569-a14a-a9b1-3fefd88fcadc@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20200116145320eucas1p188ed7bed08623bc2c2ba6b863ff223d8@eucas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

* Add missing __iomem annotations where needed.
* Make w100fb_probe() static.
* Return NULL pointer (instead of using plain integer) in
  w100_get_xtal_tabl().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/w100fb.c |   18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

Index: b/drivers/video/fbdev/w100fb.c
=================================--- a/drivers/video/fbdev/w100fb.c
+++ b/drivers/video/fbdev/w100fb.c
@@ -61,9 +61,9 @@ struct w100_pll_info *w100_get_xtal_tabl
 #define BITS_PER_PIXEL    16
 
 /* Remapped addresses for base cfg, memmapped regs and the frame buffer itself */
-static void *remapped_base;
-static void *remapped_regs;
-static void *remapped_fbuf;
+static void __iomem *remapped_base;
+static void __iomem *remapped_regs;
+static void __iomem *remapped_fbuf;
 
 #define REMAPPED_FB_LEN   0x15ffff
 
@@ -635,7 +635,7 @@ static int w100fb_resume(struct platform
 #endif
 
 
-int w100fb_probe(struct platform_device *pdev)
+static int w100fb_probe(struct platform_device *pdev)
 {
 	int err = -EIO;
 	struct w100fb_mach_info *inf;
@@ -807,10 +807,11 @@ static int w100fb_remove(struct platform
 
 static void w100_soft_reset(void)
 {
-	u16 val = readw((u16 *) remapped_base + cfgSTATUS);
-	writew(val | 0x08, (u16 *) remapped_base + cfgSTATUS);
+	u16 val = readw((u16 __iomem *)remapped_base + cfgSTATUS);
+
+	writew(val | 0x08, (u16 __iomem *)remapped_base + cfgSTATUS);
 	udelay(100);
-	writew(0x00, (u16 *) remapped_base + cfgSTATUS);
+	writew(0x00, (u16 __iomem *)remapped_base + cfgSTATUS);
 	udelay(100);
 }
 
@@ -1022,7 +1023,8 @@ struct w100_pll_info *w100_get_xtal_tabl
 			return pll_entry->pll_table;
 		pll_entry++;
 	} while (pll_entry->xtal_freq);
-	return 0;
+
+	return NULL;
 }
 
 
