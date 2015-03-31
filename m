From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Date: Tue, 31 Mar 2015 18:27:16 +0000
Subject: [PATCHv6 10/10] fbdev: ssd1307fb: Add blank mode
Message-Id: <1427826436-21783-11-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
 <1427826436-21783-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1427826436-21783-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com, kernel@pengutronix.de, shawn.guo@linaro.org, robh+dt@kernel.org
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

This patch adds ssd1307fb_blank() to make the framebuffer capable
of blanking.

Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
---
 drivers/video/fbdev/ssd1307fb.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307f=
b.c
index 77efed7..8fc224c 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -235,6 +235,16 @@ static ssize_t ssd1307fb_write(struct fb_info *info, c=
onst char __user *buf,
 	return count;
 }
=20
+static int ssd1307fb_blank(int blank_mode, struct fb_info *info)
+{
+	struct ssd1307fb_par *par =3D info->par;
+
+	if (blank_mode !=3D FB_BLANK_UNBLANK)
+		return ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_OFF);
+	else
+		return ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_ON);
+}
+
 static void ssd1307fb_fillrect(struct fb_info *info, const struct fb_fillr=
ect *rect)
 {
 	struct ssd1307fb_par *par =3D info->par;
@@ -260,6 +270,7 @@ static struct fb_ops ssd1307fb_ops =3D {
 	.owner		=3D THIS_MODULE,
 	.fb_read	=3D fb_sys_read,
 	.fb_write	=3D ssd1307fb_write,
+	.fb_blank	=3D ssd1307fb_blank,
 	.fb_fillrect	=3D ssd1307fb_fillrect,
 	.fb_copyarea	=3D ssd1307fb_copyarea,
 	.fb_imageblit	=3D ssd1307fb_imageblit,
--=20
2.3.0

