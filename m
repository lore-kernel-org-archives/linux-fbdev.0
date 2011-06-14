From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Date: Tue, 14 Jun 2011 14:27:22 +0000
Subject: [PATCH] fbdev: sh_mobile_hdmi: fix regression: statically enable
Message-Id: <Pine.LNX.4.64.1106141610430.19402@axis700.grange>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

A recent modification to the runtime PM code on mach-shmobile made a wrong 
RTPM implementation in the sh_mobile_hdmi driver apparent, which broke 
HDMI hotplug detection support on ap4evb. This patch does not implement a 
proper dynamic RTPM support for sh_mobile_hdmi, instead it restores the 
previous working state by statically enabling it. A more power-efficient 
solution should be implemented for the next kernel version.

Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
---
 drivers/video/sh_mobile_hdmi.c |   18 +++++-------------
 1 files changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index 6ae40b6..7d54e2c 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -1127,23 +1127,16 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 		struct fb_info *info = hdmi->info;
 		unsigned long parent_rate = 0, hdmi_rate;
 
-		/* A device has been plugged in */
-		pm_runtime_get_sync(hdmi->dev);
-
 		ret = sh_hdmi_read_edid(hdmi, &hdmi_rate, &parent_rate);
-		if (ret < 0) {
-			pm_runtime_put(hdmi->dev);
+		if (ret < 0)
 			goto out;
-		}
 
 		hdmi->hp_state = HDMI_HOTPLUG_EDID_DONE;
 
 		/* Reconfigure the clock */
 		ret = sh_hdmi_clk_configure(hdmi, hdmi_rate, parent_rate);
-		if (ret < 0) {
-			pm_runtime_put(hdmi->dev);
+		if (ret < 0)
 			goto out;
-		}
 
 		msleep(10);
 		sh_hdmi_configure(hdmi);
@@ -1191,7 +1184,6 @@ static void sh_hdmi_edid_work_fn(struct work_struct *work)
 		fb_set_suspend(hdmi->info, 1);
 
 		console_unlock();
-		pm_runtime_put(hdmi->dev);
 	}
 
 out:
@@ -1312,7 +1304,7 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 	INIT_DELAYED_WORK(&hdmi->edid_work, sh_hdmi_edid_work_fn);
 
 	pm_runtime_enable(&pdev->dev);
-	pm_runtime_resume(&pdev->dev);
+	pm_runtime_get_sync(&pdev->dev);
 
 	/* Product and revision IDs are 0 in sh-mobile version */
 	dev_info(&pdev->dev, "Detected HDMI controller 0x%x:0x%x\n",
@@ -1340,7 +1332,7 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 ecodec:
 	free_irq(irq, hdmi);
 ereqirq:
-	pm_runtime_suspend(&pdev->dev);
+	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	iounmap(hdmi->base);
 emap:
@@ -1377,7 +1369,7 @@ static int __exit sh_hdmi_remove(struct platform_device *pdev)
 	free_irq(irq, hdmi);
 	/* Wait for already scheduled work */
 	cancel_delayed_work_sync(&hdmi->edid_work);
-	pm_runtime_suspend(&pdev->dev);
+	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
 	clk_disable(hdmi->hdmi_clk);
 	clk_put(hdmi->hdmi_clk);
-- 
1.7.2.5

