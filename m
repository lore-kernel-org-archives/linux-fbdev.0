From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Date: Tue, 24 Mar 2015 21:23:49 +0000
Subject: [PATCHv5 02/11] fbdev: ssd1307fb: Allocate page aligned video memory.
Message-Id: <1427232238-21099-3-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1427232238-21099-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1427232238-21099-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

Currently the videomemory is allocated by kmalloc, making it a memory
region that is not necessarily page aligend. This leads to problems
upon mmap call, where the video memory's address gets aligned to the
next page boundary. The result is that the userspace program that issued
the mmap call is not able to access the video memory from the start to
the next page boundary.

This patch changes the allocation of the video memory to use
__get_free_pages() in order to obtain memory that is aligned
to page boundaries.

Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/video/fbdev/ssd1307fb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307f=
b.c
index 61e0ce8..8d34c56 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -489,7 +489,8 @@ static int ssd1307fb_probe(struct i2c_client *client,
=20
 	vmem_size =3D par->width * par->height / 8;
=20
-	vmem =3D devm_kzalloc(&client->dev, vmem_size, GFP_KERNEL);
+	vmem =3D (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO,
+					get_order(vmem_size));
 	if (!vmem) {
 		dev_err(&client->dev, "Couldn't allocate graphical memory.\n");
 		ret =3D -ENOMEM;
@@ -573,6 +574,7 @@ static int ssd1307fb_remove(struct i2c_client *client)
 	if (par->ops->remove)
 		par->ops->remove(par);
 	fb_deferred_io_cleanup(info);
+	__free_pages(__va(info->fix.smem_start), get_order(info->fix.smem_len));
 	framebuffer_release(info);
=20
 	return 0;
--=20
2.3.0

