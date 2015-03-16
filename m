From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Date: Mon, 16 Mar 2015 17:11:49 +0000
Subject: [PATCHv4 01/10] fbdev: ssd1307fb: fix memory address smem_start.
Message-Id: <1426525918-12745-2-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1426525918-12745-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1426525918-12745-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

the smem_start pointer of the framebuffer info struct needs to hold the
physical address rather than the logical address. Right now the logical
address returned by kmalloc is stored. This patch converts this address
to a physical address and thus fixes a driver crash on mmaping the
framebuffer memory due to an access to the wrong memory address.

Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 drivers/video/fbdev/ssd1307fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307f=
b.c
index f7ed6d9..61e0ce8 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -515,7 +515,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	info->var.blue.offset =3D 0;
=20
 	info->screen_base =3D (u8 __force __iomem *)vmem;
-	info->fix.smem_start =3D (unsigned long)vmem;
+	info->fix.smem_start =3D __pa(vmem);
 	info->fix.smem_len =3D vmem_size;
=20
 	fb_deferred_io_init(info);
--=20
2.3.0

