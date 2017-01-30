From: Shailendra Verma <shailendra.v@samsung.com>
Date: Mon, 30 Jan 2017 05:12:58 +0000
Subject: [PATCH] Video: fbdev - Fix possible NULL derefrence.
Message-Id: <1485752458-29955-1-git-send-email-shailendra.v@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <CGME20170130050148epcas1p14f6149d6f0b6f24dc31506ede089724c@epcas1p1.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Tomi Valkeinen <tomi.valkeinen@ti.com>, LABBE Corentin <clabbe.montjoie@gmail.com>, Julian Scheel <julian@jusst.de>, Julia Lawall <Julia.Lawall@lip6.fr>, Boris Brezillon <boris.brezillon@free-electrons.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, p.shailesh@samsung.com, ashish.kalra@samsung.com, Shailendra Verma <shailendra.v@samsung.com>, Shailendra Verma <shailendra.capricorn@gmail.com>

of_device_get_match_data could return NULL, and so can cause
a NULL pointer dereference later.

Signed-off-by: Shailendra Verma <shailendra.v@samsung.com>
---
 drivers/video/fbdev/ssd1307fb.c |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 2925d5c..bdf7d80 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -560,6 +560,10 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	par->client = client;
 
 	par->device_info = of_device_get_match_data(&client->dev);
+	if (!par->device_info) {
+		dev_err(&client->dev, "no device match found\n");
+		return -ENODEV;
+	}
 
 	par->reset = of_get_named_gpio(client->dev.of_node,
 					 "reset-gpios", 0);
-- 
1.7.9.5

