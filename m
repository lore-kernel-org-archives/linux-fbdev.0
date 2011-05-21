From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 21 May 2011 19:42:56 +0000
Subject: [PATCH 3/3] fbdev/amifb: Remove superfluous alignment of frame buffer memory
Message-Id: <1306006976-32117-3-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306006976-32117-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1306006976-32117-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-fbdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>

amiga_chip_alloc() already aligns to the PAGE_SIZE

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/amifb.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
index 1b0185c..5ea6596 100644
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -2224,24 +2224,23 @@ static int amifb_ioctl(struct fb_info *info,
 	 * Allocate, Clear and Align a Block of Chip Memory
 	 */
 
-static u_long unaligned_chipptr = 0;
+static void *aligned_chipptr;
 
 static inline u_long __init chipalloc(u_long size)
 {
-	size += PAGE_SIZE-1;
-	if (!(unaligned_chipptr = (u_long)amiga_chip_alloc(size,
-							   "amifb [RAM]"))) {
+	aligned_chipptr = amiga_chip_alloc(size, "amifb [RAM]");
+	if (!aligned_chipptr) {
 		pr_err("amifb: No Chip RAM for frame buffer");
 		return 0;
 	}
-	memset((void *)unaligned_chipptr, 0, size);
-	return PAGE_ALIGN(unaligned_chipptr);
+	memset(aligned_chipptr, 0, size);
+	return (u_long)aligned_chipptr;
 }
 
 static inline void chipfree(void)
 {
-	if (unaligned_chipptr)
-		amiga_chip_free((void *)unaligned_chipptr);
+	if (aligned_chipptr)
+		amiga_chip_free(aligned_chipptr);
 }
 
 
-- 
1.7.0.4

