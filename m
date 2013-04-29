From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Mon, 29 Apr 2013 10:22:37 +0000
Subject: [PATCH 10/10] OMAPDSS: TFP410: return EPROBE_DEFER if the i2c adapter not found
Message-Id: <1367230957-32337-11-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1367230957-32337-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, linux-omap@vger.kernel.org
Cc: Tony Lindgren <tony@atomide.com>, grygorii.strashko@ti.com, chf.fritz@googlemail.com, Archit Taneja <archit@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>

If the I2C adapter needed by the TFP410 device is not available yet,
return EPROBE_DEFER so that the device will get probed again.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/displays/panel-tfp410.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/omap2/displays/panel-tfp410.c b/drivers/video/omap2/displays/panel-tfp410.c
index a1dba868..46039c4 100644
--- a/drivers/video/omap2/displays/panel-tfp410.c
+++ b/drivers/video/omap2/displays/panel-tfp410.c
@@ -135,7 +135,7 @@ static int tfp410_probe(struct omap_dss_device *dssdev)
 		if (!adapter) {
 			dev_err(&dssdev->dev, "Failed to get I2C adapter, bus %d\n",
 					i2c_bus_num);
-			return -EINVAL;
+			return -EPROBE_DEFER;
 		}
 
 		ddata->i2c_adapter = adapter;
-- 
1.7.10.4

