From: Adam Ford <aford173@gmail.com>
Date: Tue, 30 Jun 2020 18:26:36 +0000
Subject: [PATCH] omapfb: dss: Fix max fclk divider for omap36xx
Message-Id: <20200630182636.439015-1-aford173@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Adam Ford <aford173@gmail.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Tomi Valkeinen <tomi.valkeinen@ti.com>, dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org

The drm/omap driver was fixed to correct an issue where using a
divider of 32 breaks the DSS despite the TRM stating 32 is a valid
number.  Through experimentation, it appears that 31 works, and
it is consistent with the value used by the drm/omap driver.

This patch fixes the divider for fbdev driver instead of the drm.

Fixes: f76ee892a99e ("omapfb: copy omapdss & displays for omapfb")

Cc: <stable@vger.kernel.org> #4.9+
Signed-off-by: Adam Ford <aford173@gmail.com>
---
Linux 4.4 will need a similar patch, but it doesn't apply cleanly.

The DRM version of this same fix is:
e2c4ed148cf3 ("drm/omap: fix max fclk divider for omap36xx")


diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
index 7252d22dd117..bfc5c4c5a26a 100644
--- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
+++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
@@ -833,7 +833,7 @@ static const struct dss_features omap34xx_dss_feats = {
 };
 
 static const struct dss_features omap3630_dss_feats = {
-	.fck_div_max		=	32,
+	.fck_div_max		=	31,
 	.dss_fck_multiplier	=	1,
 	.parent_clk_name	=	"dpll4_ck",
 	.dpi_select_source	=	&dss_dpi_select_source_omap2_omap3,
-- 
2.25.1
