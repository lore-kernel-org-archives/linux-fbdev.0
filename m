From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 09 May 2013 21:04:43 +0000
Subject: [PATCH 01/12] fbdev: FB_GOLDFISH should depend on HAS_DMA
Message-Id: <1368133494-22198-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>, linux-fbdev@vger.kernel.org

If NO_DMA=y:

drivers/built-in.o: In function `goldfish_fb_remove':
drivers/video/goldfishfb.c:301: undefined reference to `dma_free_coherent'
drivers/built-in.o: In function `goldfish_fb_probe':
drivers/video/goldfishfb.c:247: undefined reference to `dma_alloc_coherent'
drivers/video/goldfishfb.c:280: undefined reference to `dma_free_coherent'

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 9669c9c..da01cec 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -2199,7 +2199,7 @@ config FB_XILINX
 
 config FB_GOLDFISH
 	tristate "Goldfish Framebuffer"
-	depends on FB
+	depends on FB && HAS_DMA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.7.0.4

