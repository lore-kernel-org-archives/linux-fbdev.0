From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Date: Sun, 01 Mar 2015 22:27:55 +0000
Subject: [PATCHv2 02/10] fbdev: ssd1307fb: Use vmalloc to allocate video memory.
Message-Id: <1425248883-25367-3-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1425248883-25367-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

It makes sense to use vmalloc to allocate the video buffer since it has to =
be
page aligned memory for using it with mmap. Also deffered io seems buggy in
combination with kmalloc'ed memory (crash on unloading the module).

Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
---
 drivers/video/fbdev/ssd1307fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307f=
b.c
index 61e0ce8..25dd08d 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -11,6 +11,7 @@
 #include <linux/i2c.h>
 #include <linux/fb.h>
 #include <linux/uaccess.h>
+#include <linux/vmalloc.h>
 #include <linux/of_device.h>
 #include <linux/of_gpio.h>
 #include <linux/pwm.h>
@@ -489,7 +490,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
=20
 	vmem_size =3D par->width * par->height / 8;
=20
-	vmem =3D devm_kzalloc(&client->dev, vmem_size, GFP_KERNEL);
+	vmem =3D vzalloc(vmem_size);
 	if (!vmem) {
 		dev_err(&client->dev, "Couldn't allocate graphical memory.\n");
 		ret =3D -ENOMEM;
@@ -559,6 +560,7 @@ panel_init_error:
 		par->ops->remove(par);
 reset_oled_error:
 	fb_deferred_io_cleanup(info);
+	vfree(vmem);
 fb_alloc_error:
 	framebuffer_release(info);
 	return ret;
--=20
2.3.0

