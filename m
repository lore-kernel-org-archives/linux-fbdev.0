From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Date: Thu, 03 May 2012 10:57:12 +0000
Subject: [PATCH 2/4] OMAPDSS: VENC: Check for errors from regulator_enable()
Message-Id: <1336042634-28486-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1336042634-28486-1-git-send-email-broonie@opensource.wolfsonmicro.com>
In-Reply-To: <1336042634-28486-1-git-send-email-broonie@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>

It is possible for regulator_enable() to fail and if it does fail that's
generally a bad sign for anything we try to do with the hardware afterwards
so check for and immediately return an error if regulator_enable() fails.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 drivers/video/omap2/dss/venc.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index 9c3daf7..abfbd4a 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -443,7 +443,9 @@ static int venc_power_on(struct omap_dss_device *dssdev)
 	dispc_set_digit_size(dssdev->panel.timings.x_res,
 			dssdev->panel.timings.y_res/2);
 
-	regulator_enable(venc.vdda_dac_reg);
+	r = regulator_enable(venc.vdda_dac_reg);
+	if (r)
+		goto err;
 
 	if (dssdev->platform_enable)
 		dssdev->platform_enable(dssdev);
-- 
1.7.10

