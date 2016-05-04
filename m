From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Wed, 04 May 2016 09:43:17 +0000
Subject: [PATCH v2 2/3] video: fbdev: imxfb: enable lcd regulator in .probe
Message-Id: <1462354998-5792-3-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
In-Reply-To: <1462354998-5792-1-git-send-email-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

This asserts that the display is on after the driver is initialized.
Otherwise, depending on how the boot loader handled the display, it is
either disabled as the regulator doesn't seem in use, or it stays off.

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---

No changes since (implicit) v1, sent with
Message-Id: 1457380425-20244-3-git-send-email-u.kleine-koenig@pengutronix.de

 drivers/video/fbdev/imxfb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 6d402c1a0f2b..18388ca178a2 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -995,8 +995,17 @@ static int imxfb_probe(struct platform_device *pdev)
 	imxfb_enable_controller(fbi);
 	fbi->pdev =3D pdev;
=20
+	if (!IS_ERR(fbi->lcd_pwr)) {
+		ret =3D regulator_enable(fbi->lcd_pwr);
+		if (ret)
+			goto failed_regulator;
+	}
+
 	return 0;
=20
+failed_regulator:
+	imxfb_disable_controller(fbi);
+
 failed_lcd:
 	unregister_framebuffer(info);
=20
--=20
2.8.0.rc3

