From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Date: Tue, 24 Mar 2015 21:23:56 +0000
Subject: [PATCHv5 09/11] fbdev: ssd1307fb: Add module parameter to set the initial contrast
Message-Id: <1427232238-21099-10-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1427232238-21099-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1427232238-21099-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

This patch adds the module parameter "contrast" to determine the
contrast value that is used to initialize the display. This
setting applies to all instances of the driver.

Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
---
 drivers/video/fbdev/ssd1307fb.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307f=
b.c
index 6149827..d5aec5c 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -43,6 +43,9 @@
 static u_int refreshrate =3D REFRESHRATE;
 module_param(refreshrate, uint, 0);
=20
+static u_int contrast =3D 127;
+module_param(contrast, uint, S_IRUGO);
+
 struct ssd1307fb_par;
=20
 struct ssd1307fb_deviceinfo {
@@ -525,7 +528,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	par->com_lrremap =3D of_property_read_bool(node, "solomon,com-lrremap");
 	par->com_invdir =3D of_property_read_bool(node, "solomon,com-invdir");
=20
-	par->contrast =3D 127;
+	par->contrast =3D contrast;
 	par->vcomh =3D par->device_info->default_vcomh;
=20
 	/* Setup display timing */
--=20
2.3.0

