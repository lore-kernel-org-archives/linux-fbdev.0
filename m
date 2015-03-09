From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Date: Mon, 09 Mar 2015 22:22:10 +0000
Subject: [PATCHv3 08/10] fbdev: ssd1307fb: Add module parameter bitsperpixel.
Message-Id: <1425939732-18386-9-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1425939732-18386-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1425939732-18386-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

This patch adds a module parameter 'bitsperpixel' to adjust the colordepth
of the framebuffer. All values >1 will result in memory map of the requested
color depth. However only the MSB of each pixel will be sent to the device.
The framebuffer identifies itself as a grayscale display with the specified
depth.

Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
---
 drivers/video/fbdev/ssd1307fb.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307f=
b.c
index 7c8e627..3cf4da1 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -44,6 +44,10 @@
 #define	SSD1307FB_SET_VCOMH		0xdb
=20
 #define REFRASHRATE 1
+#define BITSPERPIXEL 1
+
+static u_int bitsperpixel =3D BITSPERPIXEL;
+module_param(bitsperpixel, uint, 0);
=20
 static u_int refreshrate =3D REFRASHRATE;
 module_param(refreshrate, uint, 0);
@@ -99,7 +103,8 @@ static struct fb_fix_screeninfo ssd1307fb_fix =3D {
 };
=20
 static struct fb_var_screeninfo ssd1307fb_var =3D {
-	.bits_per_pixel	=3D 1,
+	.bits_per_pixel	=3D BITSPERPIXEL,
+	.grayscale =3D 1,
 };
=20
 static struct ssd1307fb_array *ssd1307fb_alloc_array(u32 len, u8 type)
@@ -194,10 +199,11 @@ static void ssd1307fb_update_display(struct ssd1307fb=
_par *par)
 			array->data[array_idx] =3D 0;
 			for (k =3D 0; k < 8; k++) {
 				u32 page_length =3D par->width * i;
-				u32 index =3D page_length + (par->width * k + j) / 8;
+				u32 index =3D page_length * bitsperpixel + (par->width * k + j) * bits=
perpixel / 8;
 				u8 byte =3D *(vmem + index);
-				u8 bit =3D byte & (1 << (j % 8));
-				bit =3D bit >> (j % 8);
+				u8 bit =3D byte & (((1 << (bitsperpixel))-1) << (j % 8/bitsperpixel));
+
+				bit =3D (bit >> (j % 8/bitsperpixel)) >> (bitsperpixel-1);
 				array->data[array_idx] |=3D bit << k;
 			}
 		}
@@ -536,7 +542,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	par->dclk_div =3D par->device_info->default_dclk_div;
 	par->dclk_frq =3D par->device_info->default_dclk_frq;
=20
-	vmem_size =3D par->width * par->height / 8;
+	vmem_size =3D par->width * par->height * bitsperpixel / 8;
=20
 	vmem =3D vzalloc(vmem_size);
 	if (!vmem) {
@@ -557,20 +563,21 @@ static int ssd1307fb_probe(struct i2c_client *client,
=20
 	info->fbops =3D &ssd1307fb_ops;
 	info->fix =3D ssd1307fb_fix;
-	info->fix.line_length =3D par->width / 8;
+	info->fix.line_length =3D par->width * bitsperpixel / 8;
 	info->fbdefio =3D ssd1307fb_defio;
=20
 	info->var =3D ssd1307fb_var;
+	info->var.bits_per_pixel =3D bitsperpixel;
 	info->var.xres =3D par->width;
 	info->var.xres_virtual =3D par->width;
 	info->var.yres =3D par->height;
 	info->var.yres_virtual =3D par->height;
=20
-	info->var.red.length =3D 1;
+	info->var.red.length =3D bitsperpixel;
 	info->var.red.offset =3D 0;
-	info->var.green.length =3D 1;
+	info->var.green.length =3D bitsperpixel;
 	info->var.green.offset =3D 0;
-	info->var.blue.length =3D 1;
+	info->var.blue.length =3D bitsperpixel;
 	info->var.blue.offset =3D 0;
=20
 	info->screen_base =3D (u8 __force __iomem *)vmem;
--=20
2.3.0

