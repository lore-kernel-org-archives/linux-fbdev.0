From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?=  <u.kleine-koenig@pengutronix.de>
Date: Mon, 13 Aug 2012 07:44:35 +0000
Subject: [PATCH] video/mx3fb: remove stray l from debug output
Message-Id: <1344843875-8174-1-git-send-email-u.kleine-koenig@pengutronix.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-fbdev@vger.kernel.org

Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
---
 drivers/video/mx3fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/mx3fb.c b/drivers/video/mx3fb.c
index c89f8a8..1dfdeb1 100644
--- a/drivers/video/mx3fb.c
+++ b/drivers/video/mx3fb.c
@@ -771,7 +771,7 @@ static int __set_par(struct fb_info *fbi, bool lock)
 		if (fbi->var.sync & FB_SYNC_SHARP_MODE)
 			mode =3D IPU_PANEL_SHARP_TFT;
=20
-		dev_dbg(fbi->device, "pixclock =3D %ul Hz\n",
+		dev_dbg(fbi->device, "pixclock =3D %u Hz\n",
 			(u32) (PICOS2KHZ(fbi->var.pixclock) * 1000UL));
=20
 		if (sdc_init_panel(mx3fb, mode,
--=20
1.7.10.4

