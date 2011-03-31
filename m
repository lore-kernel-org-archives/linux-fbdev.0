From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Thu, 31 Mar 2011 10:11:06 +0000
Subject: [PATCH 9/9] OMAP: DSS2: VENC: Add missing start/stop_device calls
Message-Id: <1301566266-11187-10-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1301566266-11187-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

VENC code was missing omap_dss_start/stop_device calls. This didn't
cause any problems as VENC could not be compiled as a module, but
nevertheless it's better to add the calls.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/venc.c |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index fe18800..b845c56 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -476,6 +476,12 @@ static int venc_panel_enable(struct omap_dss_device *dssdev)
 
 	mutex_lock(&venc.venc_lock);
 
+	r = omap_dss_start_device(dssdev);
+	if (r) {
+		DSSERR("failed to start device\n");
+		goto err0;
+	}
+
 	if (dssdev->state != OMAP_DSS_DISPLAY_DISABLED) {
 		r = -EINVAL;
 		goto err1;
@@ -487,7 +493,11 @@ static int venc_panel_enable(struct omap_dss_device *dssdev)
 
 	dssdev->state = OMAP_DSS_DISPLAY_ACTIVE;
 
+	mutex_unlock(&venc.venc_lock);
+	return 0;
 err1:
+	omap_dss_stop_device(dssdev);
+err0:
 	mutex_unlock(&venc.venc_lock);
 
 	return r;
@@ -511,6 +521,8 @@ static void venc_panel_disable(struct omap_dss_device *dssdev)
 	venc_power_off(dssdev);
 
 	dssdev->state = OMAP_DSS_DISPLAY_DISABLED;
+
+	omap_dss_stop_device(dssdev);
 end:
 	mutex_unlock(&venc.venc_lock);
 }
-- 
1.7.1

