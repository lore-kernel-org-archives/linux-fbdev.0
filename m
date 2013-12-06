From: Wei Yongjun <weiyj.lk@gmail.com>
Date: Fri, 06 Dec 2013 12:55:12 +0000
Subject: [PATCH] ARM: OMAPFB: panel-sony-acx565akm: fix missing unlock in acx565akm_panel_power_on()
Message-Id: <CAPgLHd_asZkqBEXyx611=NOMfcaR18jZ8Yxkt5yhg7Lbng93MA@mail.gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383773070-15114-1-git-send-email-aaro.koskinen@iki.fi>
In-Reply-To: <1383773070-15114-1-git-send-email-aaro.koskinen@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: tomi.valkeinen@ti.com, plagnioj@jcrosoft.com, aaro.koskinen@iki.fi
Cc: yongjun_wei@trendmicro.com.cn, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Add the missing unlock before return from function
acx565akm_panel_power_on() in the error handling case.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 drivers/video/omap2/displays-new/panel-sony-acx565akm.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c b/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
index d94f35d..69aa4a1 100644
--- a/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
+++ b/drivers/video/omap2/displays-new/panel-sony-acx565akm.c
@@ -536,7 +536,7 @@ static int acx565akm_panel_power_on(struct omap_dss_device *dssdev)
 	r = in->ops.sdi->enable(in);
 	if (r) {
 		pr_err("%s sdi enable failed\n", __func__);
-		return r;
+		goto out;
 	}
 
 	/*FIXME tweak me */
@@ -547,7 +547,8 @@ static int acx565akm_panel_power_on(struct omap_dss_device *dssdev)
 
 	if (ddata->enabled) {
 		dev_dbg(&ddata->spi->dev, "panel already enabled\n");
-		return 0;
+		r = 0;
+		goto out;
 	}
 
 	/*
@@ -571,6 +572,10 @@ static int acx565akm_panel_power_on(struct omap_dss_device *dssdev)
 	mutex_unlock(&ddata->mutex);
 
 	return acx565akm_bl_update_status(ddata->bl_dev);
+
+out:
+	mutex_unlock(&ddata->mutex);
+	return r;
 }
 
 static void acx565akm_panel_power_off(struct omap_dss_device *dssdev)

