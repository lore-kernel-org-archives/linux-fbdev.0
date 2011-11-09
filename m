From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 09 Nov 2011 04:34:12 +0000
Subject: [PATCH 04/15] fbdev: sh_mipi_dsi: tidyup VMCTR2 parameter expression
Message-Id: <87y5vpap8e.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

VMCTR2 parameter will be supported more in the future.
1 << xx style is easy to understand.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mipi_dsi.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 94bb1bb..20ccc23 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -317,9 +317,9 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	 * HSA period allowed, no commands in LP
 	 */
 	if (pdata->flags & SH_MIPI_DSI_HSABM)
-		vmctr2 |= 0x20;
+		vmctr2 |= 1 << 5;
 	if (pdata->flags & SH_MIPI_DSI_HBPBM)
-		vmctr2 |= 0x10;
+		vmctr2 |= 1 << 4;
 	iowrite32(vmctr2, mipi->linkbase + VMCTR2);
 
 	/*
-- 
1.7.5.4

