From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Thu, 05 May 2011 16:35:11 +0000
Subject: [PATCH] fbdev: sh_mobile_hdmi: runtime suspend HDMI on error and
Message-Id: <Pine.LNX.4.64.1105051833570.29735@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_hdmi.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 2b9e56a..6ae40b6 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -1131,15 +1131,19 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 		pm_runtime_get_sync(hdmi->dev);
 
 		ret = sh_hdmi_read_edid(hdmi, &hdmi_rate, &parent_rate);
-		if (ret < 0)
+		if (ret < 0) {
+			pm_runtime_put(hdmi->dev);
 			goto out;
+		}
 
 		hdmi->hp_state = HDMI_HOTPLUG_EDID_DONE;
 
 		/* Reconfigure the clock */
 		ret = sh_hdmi_clk_configure(hdmi, hdmi_rate, parent_rate);
-		if (ret < 0)
+		if (ret < 0) {
+			pm_runtime_put(hdmi->dev);
 			goto out;
+		}
 
 		msleep(10);
 		sh_hdmi_configure(hdmi);
@@ -1336,6 +1340,7 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 ecodec:
 	free_irq(irq, hdmi);
 ereqirq:
+	pm_runtime_suspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	iounmap(hdmi->base);
 emap:
@@ -1372,6 +1377,7 @@ static int __exit sh_hdmi_remove(struct platform_device *pdev)
 	free_irq(irq, hdmi);
 	/* Wait for already scheduled work */
 	cancel_delayed_work_sync(&hdmi->edid_work);
+	pm_runtime_suspend(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_disable(hdmi->hdmi_clk);
 	clk_put(hdmi->hdmi_clk);
-- 
1.7.2.5

