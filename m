From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Mon, 23 Sep 2013 16:13:10 +0000
Subject: [PATCH] video: mmp: drop needless devm cleanup
Message-Id: <1379952790-13202-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1379951159-8294-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

The nice thing about devm_* is that the driver doesn't need to free the
resources but the driver core takes care about that. This also
simplifies the error path quite a bit and removes the wrong check for a
clock pointer being NULL.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/video/mmp/hw/mmp_ctrl.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/drivers/video/mmp/hw/mmp_ctrl.c b/drivers/video/mmp/hw/mmp_ctr=
l.c
index 75dca19..6ac7552 100644
--- a/drivers/video/mmp/hw/mmp_ctrl.c
+++ b/drivers/video/mmp/hw/mmp_ctrl.c
@@ -514,7 +514,7 @@ static int mmphw_probe(struct platform_device *pdev)
 	if (IS_ERR(ctrl->clk)) {
 		dev_err(ctrl->dev, "unable to get clk %s\n", mi->clk_name);
 		ret =3D -ENOENT;
-		goto failed_get_clk;
+		goto failed;
 	}
 	clk_prepare_enable(ctrl->clk);
=20
@@ -551,21 +551,8 @@ failed_path_init:
 		path_deinit(path_plat);
 	}
=20
-	if (ctrl->clk) {
-		devm_clk_put(ctrl->dev, ctrl->clk);
-		clk_disable_unprepare(ctrl->clk);
-	}
-failed_get_clk:
-	devm_free_irq(ctrl->dev, ctrl->irq, ctrl);
+	clk_disable_unprepare(ctrl->clk);
 failed:
-	if (ctrl) {
-		if (ctrl->reg_base)
-			devm_iounmap(ctrl->dev, ctrl->reg_base);
-		devm_release_mem_region(ctrl->dev, res->start,
-				resource_size(res));
-		devm_kfree(ctrl->dev, ctrl);
-	}
-
 	dev_err(&pdev->dev, "device init failed\n");
=20
 	return ret;
--=20
1.8.4.rc3

