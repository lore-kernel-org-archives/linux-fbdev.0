From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 25 Feb 2014 11:43:42 +0000
Subject: [PATCH 2/3] imx-drm: ipu-dc: Use usleep_range instead of msleep
Message-Id: <1393328624-28013-3-git-send-email-p.zabel@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Since msleep(2) can sleep up to 20ms anyway, make this explicit by using
usleep_range(2000, 20000).

Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/staging/imx-drm/ipu-v3/ipu-dc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
index d0e3bc3..d5de8bb 100644
--- a/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
+++ b/drivers/staging/imx-drm/ipu-v3/ipu-dc.c
@@ -262,7 +262,7 @@ void ipu_dc_disable_channel(struct ipu_dc *dc)
 
 	/* Wait for DC triple buffer to empty */
 	while ((readl(priv->dc_reg + DC_STAT) & val) != val) {
-		msleep(2);
+		usleep_range(2000, 20000);
 		timeout -= 2;
 		if (timeout <= 0)
 			break;
-- 
1.8.5.3

