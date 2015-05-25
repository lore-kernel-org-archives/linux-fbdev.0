From: =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>
Date: Mon, 25 May 2015 19:29:21 +0000
Subject: [PATCH] fbdev: ssd1307fb: fix logical error
Message-Id: <1432582161-14684-1-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com, kernel@pengutronix.de, dan.carpenter@oracle.com, prabhakar.csengg@gmail.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

The logical not needs to be done after the bit masking.

Fixes: a3998fe03e87 ("fbdev: ssd1307fb: Unify init code and obtain
hw specific bits from DT")

Signed-off-by: Thomas Niederpr=C3=BCm <niederp@physik.uni-kl.de>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/video/fbdev/ssd1307fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307f=
b.c
index 8fc224c..9771d56 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -368,7 +368,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 	if (ret < 0)
 		return ret;
=20
-	compins =3D 0x02 | (!par->com_seq & 0x1) << 4
+	compins =3D 0x02 | !(par->com_seq & 0x1) << 4
 				   | (par->com_lrremap & 0x1) << 5;
 	ret =3D ssd1307fb_write_cmd(par->client, compins);
 	if (ret < 0)
--=20
2.3.0

