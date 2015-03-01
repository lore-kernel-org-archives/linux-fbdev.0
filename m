From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Date: Sun, 01 Mar 2015 22:28:00 +0000
Subject: [PATCHv2 07/10] fbdev: ssd1307fb: Add module parameter to set refresh rate of the display
Message-Id: <1425248883-25367-8-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

This patch adds the module parameter "refreshrate" to set delay for the
deferred io. The refresh rate is given in units of Hertz. The default
refresh rate is 1 Hz.

Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
---
 drivers/video/fbdev/ssd1307fb.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307f=
b.c
index c7ed287..ea58e87 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -43,6 +43,11 @@
 #define	SSD1307FB_SET_COM_PINS_CONFIG	0xda
 #define	SSD1307FB_SET_VCOMH		0xdb
=20
+#define REFRASHRATE 1
+
+static u_int refreshrate =3D REFRASHRATE;
+module_param(refreshrate, uint, 0);
+
 static u_int contrast =3D 128;
 module_param(contrast, uint, S_IRUGO);
=20
@@ -270,11 +275,6 @@ static void ssd1307fb_deferred_io(struct fb_info *info,
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
@@ -475,6 +475,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
 {
 	struct fb_info *info;
 	struct device_node *node =3D client->dev.of_node;
+	struct fb_deferred_io *ssd1307fb_defio;
 	u32 vmem_size;
 	struct ssd1307fb_par *par;
 	u8 *vmem;
@@ -544,10 +545,20 @@ static int ssd1307fb_probe(struct i2c_client *client,
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
+	ssd1307fb_defio->delay =3D HZ/refreshrate;
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

