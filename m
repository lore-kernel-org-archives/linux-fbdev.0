From: Emil Goode <emilgoode@gmail.com>
Date: Wed, 05 Jun 2013 17:29:56 +0000
Subject: [PATCH] OMAPDSS: Remove kfree for memory allocated with devm_kzalloc
Message-Id: <1370453396-18043-1-git-send-email-emilgoode@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: archit@ti.com, axel.lin@gmail.com
Cc: linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Emil Goode <emilgoode@gmail.com>

It's not necessary to free memory allocated with devm_kzalloc
in a remove function and using kfree leads to a double free.

Signed-off-by: Emil Goode <emilgoode@gmail.com>
---
 drivers/video/omap2/displays/panel-picodlp.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/omap2/displays/panel-picodlp.c b/drivers/video/omap2/displays/panel-picodlp.c
index 62f2db0..859e111 100644
--- a/drivers/video/omap2/displays/panel-picodlp.c
+++ b/drivers/video/omap2/displays/panel-picodlp.c
@@ -469,8 +469,6 @@ static void picodlp_panel_remove(struct omap_dss_device *dssdev)
 	i2c_unregister_device(picod->picodlp_i2c_client);
 	dev_set_drvdata(&dssdev->dev, NULL);
 	dev_dbg(&dssdev->dev, "removing picodlp panel\n");
-
-	kfree(picod);
 }
 
 static int picodlp_panel_enable(struct omap_dss_device *dssdev)
-- 
1.7.10.4

