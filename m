From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Wed, 04 May 2016 09:43:18 +0000
Subject: [PATCH v2 3/3] video: fbdev: imxfb: add some error handling
Message-Id: <1462354998-5792-4-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

clk_prepare_enable can fail and if it does the controller must not be
considered enabled. So check for errors, properly unwind and give the
error code back to the caller.

While touching the clock code also enable the clocks in the same
direction and disable in reverse order.

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---

Changes since (implicit) v1, sent with
Message-Id: 1457380425-20244-4-git-send-email-u.kleine-koenig@pengutronix.de

 - Some simplifications suggested and Reviewed-by Philipp Zabel
 - Rework goto labels to have them at the end of the function
   (Tomi Valkeinen).

 drivers/video/fbdev/imxfb.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 18388ca178a2..23a623688f1e 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -473,11 +473,12 @@ static int imxfb_set_par(struct fb_info *info)
 	return 0;
 }
=20
-static void imxfb_enable_controller(struct imxfb_info *fbi)
+static int imxfb_enable_controller(struct imxfb_info *fbi)
 {
+	int ret;
=20
 	if (fbi->enabled)
-		return;
+		return 0;
=20
 	pr_debug("Enabling LCD controller\n");
=20
@@ -496,10 +497,29 @@ static void imxfb_enable_controller(struct imxfb_info=
 *fbi)
 	 */
 	writel(RMCR_LCDC_EN_MX1, fbi->regs + LCDC_RMCR);
=20
-	clk_prepare_enable(fbi->clk_ipg);
-	clk_prepare_enable(fbi->clk_ahb);
-	clk_prepare_enable(fbi->clk_per);
+	ret =3D clk_prepare_enable(fbi->clk_ipg);
+	if (ret)
+		goto err_enable_ipg;
+
+	ret =3D clk_prepare_enable(fbi->clk_ahb);
+	if (ret)
+		goto err_enable_ahb;
+
+	ret =3D clk_prepare_enable(fbi->clk_per);
+	if (ret)
+		goto err_enable_per;
+
 	fbi->enabled =3D true;
+	return 0;
+
+err_enable_per:
+	clk_disable_unprepare(fbi->clk_ahb);
+err_enable_ahb:
+	clk_disable_unprepare(fbi->clk_ipg);
+err_enable_ipg:
+	writel(0, fbi->regs + LCDC_RMCR);
+
+	return ret;
 }
=20
 static void imxfb_disable_controller(struct imxfb_info *fbi)
@@ -510,8 +530,8 @@ static void imxfb_disable_controller(struct imxfb_info =
*fbi)
 	pr_debug("Disabling LCD controller\n");
=20
 	clk_disable_unprepare(fbi->clk_per);
-	clk_disable_unprepare(fbi->clk_ipg);
 	clk_disable_unprepare(fbi->clk_ahb);
+	clk_disable_unprepare(fbi->clk_ipg);
 	fbi->enabled =3D false;
=20
 	writel(0, fbi->regs + LCDC_RMCR);
@@ -532,8 +552,7 @@ static int imxfb_blank(int blank, struct fb_info *info)
 		break;
=20
 	case FB_BLANK_UNBLANK:
-		imxfb_enable_controller(fbi);
-		break;
+		return imxfb_enable_controller(fbi);
 	}
 	return 0;
 }
--=20
2.8.0.rc3

