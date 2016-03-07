From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Mon, 07 Mar 2016 19:53:45 +0000
Subject: [PATCH 3/3] video: fbdev: imxfb: add some error handling
Message-Id: <1457380425-20244-4-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1457380425-20244-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/video/fbdev/imxfb.c | 33 ++++++++++++++++++++++++++-------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 3dd2824e6773..671b3719db56 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -473,8 +473,9 @@ static int imxfb_set_par(struct fb_info *info)
 	return 0;
 }
=20
-static void imxfb_enable_controller(struct imxfb_info *fbi)
+static int imxfb_enable_controller(struct imxfb_info *fbi)
 {
+	int ret;
=20
 	if (fbi->enabled)
 		return;
@@ -496,10 +497,27 @@ static void imxfb_enable_controller(struct imxfb_info=
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
+	if (ret) {
+		clk_disable_unprepare(fbi->clk_ahb);
+err_enable_ahb:
+		clk_disable_unprepare(fbi->clk_ipg);
+err_enable_ipg:
+		writel(0, fbi->regs + LCDC_RMCR);
+
+		return ret;
+	}
+
 	fbi->enabled =3D true;
+	return 0;
 }
=20
 static void imxfb_disable_controller(struct imxfb_info *fbi)
@@ -510,8 +528,8 @@ static void imxfb_disable_controller(struct imxfb_info =
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
@@ -520,6 +538,7 @@ static void imxfb_disable_controller(struct imxfb_info =
*fbi)
 static int imxfb_blank(int blank, struct fb_info *info)
 {
 	struct imxfb_info *fbi =3D info->par;
+	int ret =3D 0;;
=20
 	pr_debug("imxfb_blank: blank=3D%d\n", blank);
=20
@@ -532,10 +551,10 @@ static int imxfb_blank(int blank, struct fb_info *inf=
o)
 		break;
=20
 	case FB_BLANK_UNBLANK:
-		imxfb_enable_controller(fbi);
+		ret =3D imxfb_enable_controller(fbi);
 		break;
 	}
-	return 0;
+	return ret;
 }
=20
 static struct fb_ops imxfb_ops =3D {
--=20
2.7.0

