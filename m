From: =?UTF-8?q?Lo=C3=AFc=20Minier?= <loic.minier@linaro.org>
Date: Mon, 20 Jun 2011 20:44:17 +0000
Subject: [PATCH] ARM: amba: Link fb device to its parent
Message-Id: <1308602657-28783-1-git-send-email-loic.minier@linaro.org>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: linux-arm-kernel@lists.infradead.org

Some pieces of userspace like debian-installer expect to find the fb0
driver name by readlink-ing /sys/class/graphics/fb0/device/driver but
this was broken with amba-clcd as it sets up fb_info manually and missed
the .device parent pointer.

Signed-off-by: Lo=C3=AFc Minier <loic.minier@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: Paul Mundt <lethal@linux-sh.org>
---
 drivers/video/amba-clcd.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/video/amba-clcd.c b/drivers/video/amba-clcd.c
index 5fc983c..cf03ad0 100644
--- a/drivers/video/amba-clcd.c
+++ b/drivers/video/amba-clcd.c
@@ -447,6 +447,8 @@ static int clcdfb_register(struct clcd_fb *fb)
 		goto out;
 	}
=20
+	fb->fb.device		=3D &fb->dev->dev;
+
 	fb->fb.fix.mmio_start	=3D fb->dev->res.start;
 	fb->fb.fix.mmio_len	=3D resource_size(&fb->dev->res);
=20
--=20
1.7.5.4

