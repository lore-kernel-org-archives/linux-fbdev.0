From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Date: Mon, 28 Oct 2013 22:49:28 +0000
Subject: [PATCH 11/12] fbdev: shmobile-hdmi: Convert to clk_prepare/unprepare
Message-Id: <1383000569-8916-12-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
In-Reply-To: <1383000569-8916-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Turn clk_enable() and clk_disable() calls into clk_prepare_enable() and
clk_disable_unprepare() to get ready for the migration to the common
clock framework.

Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-fbdev@vger.kernel.org
Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/video/sh_mobile_hdmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/sh_mobile_hdmi.c b/drivers/video/sh_mobile_hdmi.c
index bfe4728..190145e 100644
--- a/drivers/video/sh_mobile_hdmi.c
+++ b/drivers/video/sh_mobile_hdmi.c
@@ -1326,7 +1326,7 @@ static int __init sh_hdmi_probe(struct platform_device *pdev)
 		goto erate;
 	}
 
-	ret = clk_enable(hdmi->hdmi_clk);
+	ret = clk_prepare_enable(hdmi->hdmi_clk);
 	if (ret < 0) {
 		dev_err(hdmi->dev, "Cannot enable clock: %d\n", ret);
 		goto erate;
@@ -1404,7 +1404,7 @@ emap_htop1:
 emap:
 	release_mem_region(res->start, resource_size(res));
 ereqreg:
-	clk_disable(hdmi->hdmi_clk);
+	clk_disable_unprepare(hdmi->hdmi_clk);
 erate:
 	clk_put(hdmi->hdmi_clk);
 egetclk:
@@ -1427,7 +1427,7 @@ static int __exit sh_hdmi_remove(struct platform_device *pdev)
 	cancel_delayed_work_sync(&hdmi->edid_work);
 	pm_runtime_put(&pdev->dev);
 	pm_runtime_disable(&pdev->dev);
-	clk_disable(hdmi->hdmi_clk);
+	clk_disable_unprepare(hdmi->hdmi_clk);
 	clk_put(hdmi->hdmi_clk);
 	if (hdmi->htop1)
 		iounmap(hdmi->htop1);
-- 
1.8.1.5

