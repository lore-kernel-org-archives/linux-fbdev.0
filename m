From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 22 Oct 2014 08:39:34 +0000
Subject: [PATCH 5/5] OMAPDSS: DSI: Fix PLL_SELFEQDCO field width
Message-Id: <1413967174-28009-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1413967174-28009-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1413967174-28009-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

PLL_SELFREQDCO bitfield is from bit 3 to 1, but the driver writes bits
from 4 to 1. The bit 4 is 'reserved', so this probably should not cause
any issues, but it's better to fix it.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/fbdev/omap2/dss/dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/omap2/dss/dsi.c b/drivers/video/fbdev/omap2/dss/dsi.c
index 947bd7b93375..0793bc67a275 100644
--- a/drivers/video/fbdev/omap2/dss/dsi.c
+++ b/drivers/video/fbdev/omap2/dss/dsi.c
@@ -1603,7 +1603,7 @@ int dsi_pll_set_clock_div(struct platform_device *dsidev,
 	} else if (dss_has_feature(FEAT_DSI_PLL_SELFREQDCO)) {
 		f = cinfo->clkin4ddr < 1000000000 ? 0x2 : 0x4;
 
-		l = FLD_MOD(l, f, 4, 1);	/* PLL_SELFREQDCO */
+		l = FLD_MOD(l, f, 3, 1);	/* PLL_SELFREQDCO */
 	}
 
 	l = FLD_MOD(l, 1, 13, 13);		/* DSI_PLL_REFEN */
-- 
2.1.1

