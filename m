From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Date: Tue, 31 Mar 2015 18:27:13 +0000
Subject: [PATCHv6 07/10] fbdev: ssd1307fb: Add a module parameter to set the refresh rate
Message-Id: <1427826436-21783-8-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1427826436-21783-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1427826436-21783-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

This patch adds the module parameter "refreshrate" to set delay for the
deferred io. The refresh rate is given in units of Hertz. The default
refresh rate is 1 Hz. The refresh rate set through the newly introduced
parameter applies to all instances of the driver and for now it is not
possible to change it individually.

Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/video/fbdev/ssd1307fb.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307f=
b.c
index f685d24..85eeda0 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -38,6 +38,11 @@
 #define	SSD1307FB_SET_COM_PINS_CONFIG	0xda
 #define	SSD1307FB_SET_VCOMH		0xdb
=20
+#define REFRESHRATE 1
+
+static u_int refreshrate =3D REFRESHRATE;
+module_param(refreshrate, uint, 0);
+
 struct ssd1307fb_par;
=20
 struct ssd1307fb_deviceinfo {
@@ -263,11 +268,6 @@ static void ssd1307fb_deferred_io(struct fb_info *info,
 	ssd1307fb_update_display(info->par);
 }
=20
-static struct fb_deferred_io ssd1307fb_defio =3D {
-	.delay		=3D HZ,
-	.deferred_io	=3D ssd1307fb_deferred_io,
-};
-
 static int ssd1307fb_init(struct ssd1307fb_par *par)
 {
 	int ret;
@@ -466,6 +466,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
 {
 	struct fb_info *info;
 	struct device_node *node =3D client->dev.of_node;
+	struct fb_deferred_io *ssd1307fb_defio;
 	u32 vmem_size;
 	struct ssd1307fb_par *par;
 	u8 *vmem;
@@ -536,10 +537,20 @@ static int ssd1307fb_probe(struct i2c_client *client,
 		goto fb_alloc_error;
 	}
=20
+	ssd1307fb_defio =3D devm_kzalloc(&client->dev, sizeof(struct fb_deferred_=
io), GFP_KERNEL);
+	if (!ssd1307fb_defio) {
+		dev_err(&client->dev, "Couldn't allocate deferred io.\n");
+		ret =3D -ENOMEM;
+		goto fb_alloc_error;
+	}
+
+	ssd1307fb_defio->delay =3D HZ / refreshrate;
+	ssd1307fb_defio->deferred_io =3D ssd1307fb_deferred_io;
+
 	info->fbops =3D &ssd1307fb_ops;
 	info->fix =3D ssd1307fb_fix;
 	info->fix.line_length =3D par->width / 8;
-	info->fbdefio =3D &ssd1307fb_defio;
+	info->fbdefio =3D ssd1307fb_defio;
=20
 	info->var =3D ssd1307fb_var;
 	info->var.xres =3D par->width;
--=20
2.3.0

