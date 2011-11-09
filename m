From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 09 Nov 2011 04:36:07 +0000
Subject: [PATCH 15/15] fbdev: sh_mipi_dsi: fixup setup timing DSICTRL
Message-Id: <87ipmtap58.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

DSICTRL should be called after all mipi settings

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mipi_dsi.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index 187e127..05151b8 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -265,8 +265,6 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	iowrite32(0x0fffffff, base + TATOVSET);
 	/* Peripheral reset timeout, default 0xffffffff */
 	iowrite32(0x0fffffff, base + PRTOVSET);
-	/* Enable timeout counters */
-	iowrite32(0x00000f00, base + DSICTRL);
 	/* Interrupts not used, disable all */
 	iowrite32(0, base + DSIINTE);
 	/* DSI-Tx bias on */
@@ -388,6 +386,9 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 			  pixfmt << 4);
 	sh_mipi_dcs(ch->chan, MIPI_DCS_SET_DISPLAY_ON);
 
+	/* Enable timeout counters */
+	iowrite32(0x00000f00, base + DSICTRL);
+
 	return 0;
 }
 
-- 
1.7.5.4

