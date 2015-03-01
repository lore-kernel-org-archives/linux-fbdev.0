From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Date: Sun, 01 Mar 2015 22:28:03 +0000
Subject: [PATCHv2 10/10] fbdev: ssd1307fb: Turn off display on driver unload.
Message-Id: <1425248883-25367-11-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

This patch turns off the display when the driver is unloaded.

Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
---
 drivers/video/fbdev/ssd1307fb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307f=
b.c
index 2a2e7c3..3b7a69f 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -726,6 +726,8 @@ static int ssd1307fb_remove(struct i2c_client *client)
 	struct fb_info *info =3D i2c_get_clientdata(client);
 	struct ssd1307fb_par *par =3D info->par;
=20
+	ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_OFF);
+
 	unregister_framebuffer(info);
 	if (par->device_info->device_id =3D DEVID_SSD1307) {
 		pwm_disable(par->pwm);
--=20
2.3.0

