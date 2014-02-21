From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 21 Feb 2014 19:56:09 +0000
Subject: [PATCH] fbdev: FB_OPENCORES should depend on HAS_DMA
Message-Id: <1393012569-22560-1-git-send-email-geert@linux-m68k.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>

If NO_DMA=y:

    drivers/built-in.o: In function `ocfb_remove':
    ocfb.c:(.text+0x27fee): undefined reference to `dma_free_coherent'
    drivers/built-in.o: In function `ocfb_probe':
    ocfb.c:(.text+0x28418): undefined reference to `dma_alloc_coherent'
    ocfb.c:(.text+0x284d2): undefined reference to `dma_free_coherent'

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 drivers/video/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 0192900dd183..fb8d31e717bc 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -982,7 +982,7 @@ config FB_PVR2
 
 config FB_OPENCORES
 	tristate "OpenCores VGA/LCD core 2.0 framebuffer support"
-	depends on FB
+	depends on FB && HAS_DMA
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-- 
1.7.9.5

