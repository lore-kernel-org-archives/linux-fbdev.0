From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 21 May 2011 19:42:55 +0000
Subject: [PATCH 2/3] fbdev/amifb: Do not call panic() if there's not enough Chip RAM
Message-Id: <1306006976-32117-2-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1306006976-32117-1-git-send-email-geert@linux-m68k.org>
In-Reply-To: <1306006976-32117-1-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-fbdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>

Fail gracefully instead.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/amifb.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
index 603f84f..1b0185c 100644
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -2230,8 +2230,10 @@ static inline u_long __init chipalloc(u_long size)
 {
 	size += PAGE_SIZE-1;
 	if (!(unaligned_chipptr = (u_long)amiga_chip_alloc(size,
-							   "amifb [RAM]")))
-		panic("No Chip RAM for frame buffer");
+							   "amifb [RAM]"))) {
+		pr_err("amifb: No Chip RAM for frame buffer");
+		return 0;
+	}
 	memset((void *)unaligned_chipptr, 0, size);
 	return PAGE_ALIGN(unaligned_chipptr);
 }
@@ -2385,6 +2387,10 @@ default_chipset:
 	                    DUMMYSPRITEMEMSIZE+
 	                    COPINITSIZE+
 	                    4*COPLISTSIZE);
+	if (!chipptr) {
+		err = -ENOMEM;
+		goto amifb_error;
+	}
 
 	assignchunk(videomemory, u_long, chipptr, fb_info.fix.smem_len);
 	assignchunk(spritememory, u_long, chipptr, SPRITEMEMSIZE);
-- 
1.7.0.4

