From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 15 Nov 2012 15:58:10 +0000
Subject: [PATCH 02/32] OMAPDSS: DPI: fix crash with dpi_verify_dsi_pll()
Message-Id: <1352995120-3288-3-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1352995120-3288-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Archit Taneja <archit@ti.com>, Rob Clark <rob@ti.com>
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>

If the DSI support has not been compiled in or the SoC doesn't have DSI
hardware, dpi_get_dsidev() returns NULL. This NULL is passed to
dpi_verify_dsi_pll() causing a crash. The bug was added with commit
0e8276ef75f5c7811b038d1d23b2b42c16efc5ac (OMAPDSS: DPI: always use DSI
PLL if available).

Fix this by checking if dsidev is NULL before calling
dpi_verify_dsi_pll().

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/dpi.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/dpi.c b/drivers/video/omap2/dss/dpi.c
index 1e103b3..c109fa6 100644
--- a/drivers/video/omap2/dss/dpi.c
+++ b/drivers/video/omap2/dss/dpi.c
@@ -412,7 +412,7 @@ static int __init dpi_init_display(struct omap_dss_device *dssdev)
 	 */
 	dsidev = dpi_get_dsidev(dssdev->channel);
 
-	if (dpi_verify_dsi_pll(dsidev)) {
+	if (dsidev && dpi_verify_dsi_pll(dsidev)) {
 		dsidev = NULL;
 		DSSWARN("DSI PLL not operational\n");
 	}
-- 
1.7.10.4

