From: Martin Kaiser <martin@kaiser.cx>
Date: Tue, 22 Nov 2016 07:54:18 +0000
Subject: [PATCH] video: imxfb: correct the bitmask for DMACR_HM/_TM
Message-Id: <1479801258-3765-1-git-send-email-martin@kaiser.cx>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Sascha Hauer <kernel@pengutronix.de>, linux-fbdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Martin Kaiser <martin@kaiser.cx>

The HM and TM fields in the LCDC DMA Control Register are 7 bits wide.
Use the correct mask to allow setting all possible bits.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---

This bug was discovered on a board that uses DMACR_TM(16). We ended up
with TM=0 in the register, the upper three bits were filtered out.

The LCD DMA Control Register is described in section 33.3.16 of the
IMX25 reference manual.

 include/linux/platform_data/video-imxfb.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/platform_data/video-imxfb.h b/include/linux/platform_data/video-imxfb.h
index 18e9083..858c66d 100644
--- a/include/linux/platform_data/video-imxfb.h
+++ b/include/linux/platform_data/video-imxfb.h
@@ -48,8 +48,8 @@
 #define LSCR1_GRAY1(x)            (((x) & 0xf))
 
 #define DMACR_BURST	(1 << 31)
-#define DMACR_HM(x)	(((x) & 0xf) << 16)
-#define DMACR_TM(x)	((x) & 0xf)
+#define DMACR_HM(x)	(((x) & 0x7f) << 16)
+#define DMACR_TM(x)	((x) & 0x7f)
 
 struct imx_fb_videomode {
 	struct fb_videomode mode;
-- 
1.7.10.4

