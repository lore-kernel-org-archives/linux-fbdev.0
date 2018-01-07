From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 07 Jan 2018 18:34:44 +0000
Subject: [PATCH v2] video: ssd1307fb: Improve a size determination in ssd1307fb_probe()
Message-Id: <c2fc8e5c-e4d3-51da-451c-be70e0d3fef0@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20171125160425epcas5p43b2d94fbcc74745017c4c91ff08de685@epcas5p4.samsung.com>
 <9433118e-4c2b-db31-7064-df692a99c1b2@users.sourceforge.net>
 <2091464.qzRHS0Wsad@amdc3058>
In-Reply-To: <2091464.qzRHS0Wsad@amdc3058>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bastian Stender <bst@pengutronix.de>, Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 7 Jan 2018 19:27:28 +0100

Replace the specification of a data structure by a pointer dereference
as the parameter for the operator "sizeof" to make the corresponding size
determination a bit safer according to the Linux coding style convention.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---

v2:
This update suggestion was rebased on source files from the software
"Linux next-20180105".

 drivers/video/fbdev/ssd1307fb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index f599520374dd..6439231f2db2 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -628,7 +628,8 @@ static int ssd1307fb_probe(struct i2c_client *client,
 		goto fb_alloc_error;
 	}
 
-	ssd1307fb_defio = devm_kzalloc(&client->dev, sizeof(struct fb_deferred_io), GFP_KERNEL);
+	ssd1307fb_defio = devm_kzalloc(&client->dev, sizeof(*ssd1307fb_defio),
+				       GFP_KERNEL);
 	if (!ssd1307fb_defio) {
 		dev_err(&client->dev, "Couldn't allocate deferred io.\n");
 		ret = -ENOMEM;
-- 
2.15.1

