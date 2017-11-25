From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 25 Nov 2017 16:06:37 +0000
Subject: [PATCH 2/2] video: ssd1307fb: Improve a size determination in ssd1307fb_probe()
Message-Id: <37c07df9-5d12-63e3-48a6-c349b146b1dc@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <9433118e-4c2b-db31-7064-df692a99c1b2@users.sourceforge.net>
In-Reply-To: <9433118e-4c2b-db31-7064-df692a99c1b2@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bastian Stender <bst@pengutronix.de>, Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 25 Nov 2017 16:50:26 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/ssd1307fb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index fb0ef1922d49..bb32b2dd1f7a 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -628,7 +628,8 @@ static int ssd1307fb_probe(struct i2c_client *client,
 		goto fb_alloc_error;
 	}
 
-	ssd1307fb_defio = devm_kzalloc(&client->dev, sizeof(struct fb_deferred_io), GFP_KERNEL);
+	ssd1307fb_defio = devm_kzalloc(&client->dev, sizeof(*ssd1307fb_defio),
+				       GFP_KERNEL);
 	if (!ssd1307fb_defio) {
 		ret = -ENOMEM;
 		goto fb_alloc_error;
-- 
2.15.0

