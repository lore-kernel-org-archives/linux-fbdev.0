From: Tomi Valkeinen <tomi.valkeinen@ti.com>
Date: Wed, 19 Sep 2012 08:30:34 +0000
Subject: [PATCH 4/8] OMAPDSS: explicitely initialize dssdev->channel for new displays
Message-Id: <1348043438-2624-5-git-send-email-tomi.valkeinen@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
In-Reply-To: <1348043438-2624-1-git-send-email-tomi.valkeinen@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>

HDMI and VENC outputs always use the DIGIT output from DISPC. The dssdev
struct contains "channel" field which is used to specify the DISPC
output for the display, but this was not used for HDMI and VENC.

This patch fills the channel field explicitely for HDMI and VENC
displays so that we can always rely on the channel field.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
 drivers/video/omap2/dss/hdmi.c |    2 ++
 drivers/video/omap2/dss/venc.c |    2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/video/omap2/dss/hdmi.c b/drivers/video/omap2/dss/hdmi.c
index 76d100b..3b10e18 100644
--- a/drivers/video/omap2/dss/hdmi.c
+++ b/drivers/video/omap2/dss/hdmi.c
@@ -946,6 +946,8 @@ static void __init hdmi_probe_pdata(struct platform_device *pdev)
 	hdmi.ls_oe_gpio = priv->ls_oe_gpio;
 	hdmi.hpd_gpio = priv->hpd_gpio;
 
+	dssdev->channel = OMAP_DSS_CHANNEL_DIGIT;
+
 	r = hdmi_init_display(dssdev);
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
diff --git a/drivers/video/omap2/dss/venc.c b/drivers/video/omap2/dss/venc.c
index b9c0a8f..88fa6ea 100644
--- a/drivers/video/omap2/dss/venc.c
+++ b/drivers/video/omap2/dss/venc.c
@@ -773,6 +773,8 @@ static void __init venc_probe_pdata(struct platform_device *pdev)
 	if (!dssdev)
 		return;
 
+	dssdev->channel = OMAP_DSS_CHANNEL_DIGIT;
+
 	r = venc_init_display(dssdev);
 	if (r) {
 		DSSERR("device %s init failed: %d\n", dssdev->name, r);
-- 
1.7.9.5

