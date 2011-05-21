From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sat, 21 May 2011 19:42:54 +0000
Subject: [PATCH 1/3] fbdev/amifb: Correct check for video memory size
Message-Id: <1306006976-32117-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paul Mundt <lethal@linux-sh.org>
Cc: linux-fbdev@vger.kernel.org, linux-m68k@lists.linux-m68k.org, Geert Uytterhoeven <geert@linux-m68k.org>

The check should compare the available memory size with the highest allocation
value (VIDEOMEMSIZE_*_2M), not with the lowest value (VIDEOMEMSIZE_*_1M).

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/amifb.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/amifb.c b/drivers/video/amifb.c
index e5d6b56..603f84f 100644
--- a/drivers/video/amifb.c
+++ b/drivers/video/amifb.c
@@ -2295,7 +2295,7 @@ default_chipset:
 			    defmode = amiga_vblank = 50 ? DEFMODE_PAL
 							 : DEFMODE_NTSC;
 			if (amiga_chip_avail()-CHIPRAM_SAFETY_LIMIT >
-			    VIDEOMEMSIZE_ECS_1M)
+			    VIDEOMEMSIZE_ECS_2M)
 				fb_info.fix.smem_len = VIDEOMEMSIZE_ECS_2M;
 			else
 				fb_info.fix.smem_len = VIDEOMEMSIZE_ECS_1M;
@@ -2312,7 +2312,7 @@ default_chipset:
 			maxfmode = TAG_FMODE_4;
 			defmode = DEFMODE_AGA;
 			if (amiga_chip_avail()-CHIPRAM_SAFETY_LIMIT >
-			    VIDEOMEMSIZE_AGA_1M)
+			    VIDEOMEMSIZE_AGA_2M)
 				fb_info.fix.smem_len = VIDEOMEMSIZE_AGA_2M;
 			else
 				fb_info.fix.smem_len = VIDEOMEMSIZE_AGA_1M;
-- 
1.7.0.4

