From: SF Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 25 Nov 2017 16:05:26 +0000
Subject: [PATCH 1/2] video: ssd1307fb: Delete an error message for a failed memory allocation in ssd1307fb_pr
Message-Id: <5a697bfd-f2be-7724-c0c4-55dd98ee5006@users.sourceforge.net>
List-Id: <linux-fbdev.vger.kernel.org>
References: <9433118e-4c2b-db31-7064-df692a99c1b2@users.sourceforge.net>
In-Reply-To: <9433118e-4c2b-db31-7064-df692a99c1b2@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Arnd Bergmann <arnd@arndb.de>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Bastian Stender <bst@pengutronix.de>, Jyri Sarha <jsarha@ti.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sat, 25 Nov 2017 16:45:56 +0100

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/video/fbdev/ssd1307fb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index f599520374dd..fb0ef1922d49 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -630,7 +630,6 @@ static int ssd1307fb_probe(struct i2c_client *client,
 
 	ssd1307fb_defio = devm_kzalloc(&client->dev, sizeof(struct fb_deferred_io), GFP_KERNEL);
 	if (!ssd1307fb_defio) {
-		dev_err(&client->dev, "Couldn't allocate deferred io.\n");
 		ret = -ENOMEM;
 		goto fb_alloc_error;
 	}
-- 
2.15.0

