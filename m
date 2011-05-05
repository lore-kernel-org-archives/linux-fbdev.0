From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 05 May 2011 16:32:36 +0000
Subject: [PATCH] fbdev: sh_mobile_lcdc: reduce scope of a variable
Message-Id: <Pine.LNX.4.64.1105051831270.29735@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

The "ret" variable in sh_mobile_lcdc_start() is only used at one
location, move its definition to the inner-most scope.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_lcdcfb.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/video/sh_mobile_lcdcfb.c b/drivers/video/sh_mobile_lcdcfb.c
index 9bcc61b..466834c 100644
--- a/drivers/video/sh_mobile_lcdcfb.c
+++ b/drivers/video/sh_mobile_lcdcfb.c
@@ -469,7 +469,6 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 	int bpp = 0;
 	unsigned long ldddsr;
 	int k, m;
-	int ret = 0;
 
 	/* enable clocks before accessing the hardware */
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
@@ -538,11 +537,12 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 		lcdc_write_chan(ch, LDPMR, 0);
 
 		board_cfg = &ch->cfg.board_cfg;
-		if (board_cfg->setup_sys)
-			ret = board_cfg->setup_sys(board_cfg->board_data, ch,
-						   &sh_mobile_lcdc_sys_bus_ops);
-		if (ret)
-			return ret;
+		if (board_cfg->setup_sys) {
+			int ret = board_cfg->setup_sys(board_cfg->board_data,
+						ch, &sh_mobile_lcdc_sys_bus_ops);
+			if (ret)
+				return ret;
+		}
 	}
 
 	/* word and long word swap */
-- 
1.7.2.5

