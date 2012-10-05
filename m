From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Fri, 05 Oct 2012 09:20:07 +0000
Subject: [PATCH] video/mx3fb: set .owner to prevent module unloading while being used
Message-Id: <1349428807-26373-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/video/mx3fb.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index d738108..ce1d452 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -1568,7 +1568,8 @@ static int mx3fb_remove(struct platform_device *dev)
=20
 static struct platform_driver mx3fb_driver =3D {
 	.driver =3D {
-		   .name =3D MX3FB_NAME,
+		.name =3D MX3FB_NAME,
+		.owner =3D THIS_MODULE,
 	},
 	.probe =3D mx3fb_probe,
 	.remove =3D mx3fb_remove,
--=20
1.7.10.4

