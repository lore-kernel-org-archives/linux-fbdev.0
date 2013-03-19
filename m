From: Paul Bolle <pebolle@tiscali.nl>
Date: Tue, 19 Mar 2013 10:07:57 +0000
Subject: [PATCH] ARM: OMAP: remove "config FB_OMAP_CONSISTENT_DMA_SIZE"
Message-Id: <1363687677.1390.6.camel@x61.thuisdomein>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org

The only user of Kconfig symbol FB_OMAP_CONSISTENT_DMA_SIZE got removed
in v3.8, with commit 6ba54ab4a49bbad736b0254aa6bdf0cb83013815 ("ARM:
OMAP: Remove omap_init_consistent_dma_size()"). Remove this symbol too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Eyeball tested only.

 drivers/video/omap/Kconfig | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/video/omap/Kconfig b/drivers/video/omap/Kconfig
index e512581..0bc3a93 100644
--- a/drivers/video/omap/Kconfig
+++ b/drivers/video/omap/Kconfig
@@ -39,17 +39,6 @@ config FB_OMAP_LCD_MIPID
 	  the Mobile Industry Processor Interface DBI-C/DCS
 	  specification. (Supported LCDs: Philips LPH8923, Sharp LS041Y3)
 
-config FB_OMAP_CONSISTENT_DMA_SIZE
-	int "Consistent DMA memory size (MB)"
-	depends on FB_OMAP
-	range 1 14
-	default 2
-	help
-	  Increase the DMA consistent memory size according to your video
-	  memory needs, for example if you want to use multiple planes.
-	  The size must be 2MB aligned.
-	  If unsure say 1.
-
 config FB_OMAP_DMA_TUNE
         bool "Set DMA SDRAM access priority high"
         depends on FB_OMAP
-- 
1.7.11.7

