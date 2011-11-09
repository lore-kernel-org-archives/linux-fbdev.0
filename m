From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Wed, 09 Nov 2011 04:35:56 +0000
Subject: [PATCH 14/15] fbdev: sh_mipi_dsi: fixup setup timing of SYSCONF
Message-Id: <87k479ap5i.wl%kuninori.morimoto.gx@renesas.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

SYSCONF should be set after PHYCTRL

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 drivers/video/sh_mipi_dsi.c |   23 +++++++++++------------
 1 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/video/sh_mipi_dsi.c b/drivers/video/sh_mipi_dsi.c
index f2c3f94..187e127 100644
--- a/drivers/video/sh_mipi_dsi.c
+++ b/drivers/video/sh_mipi_dsi.c
@@ -246,18 +246,6 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	/* setup DSI link */
 
 	/*
-	 * Default = ULPS enable |
-	 *	Contention detection enabled |
-	 *	EoT packet transmission enable |
-	 *	CRC check enable |
-	 *	ECC check enable
-	 * additionally enable first two lanes
-	 */
-	bitmap_fill((unsigned long *)&tmp, pdata->lane);
-	tmp |= 0x00003700;
-	iowrite32(tmp, base + SYSCONF);
-
-	/*
 	 * T_wakeup = 0x7000
 	 * T_hs-trail = 3
 	 * T_hs-prepare = 3
@@ -287,6 +275,17 @@ static int __init sh_mipi_setup(struct sh_mipi *mipi,
 	/* Deassert resets, power on */
 	iowrite32(0x03070001, base + PHYCTRL);
 
+	/*
+	 * Default = ULPS enable |
+	 *	Contention detection enabled |
+	 *	EoT packet transmission enable |
+	 *	CRC check enable |
+	 *	ECC check enable
+	 */
+	bitmap_fill((unsigned long *)&tmp, pdata->lane);
+	tmp |= 0x00003700;
+	iowrite32(tmp, base + SYSCONF);
+
 	/* setup l-bridge */
 
 	/*
-- 
1.7.5.4

