From: LABBE Corentin <clabbe.montjoie@gmail.com>
Date: Tue, 16 Aug 2016 09:27:17 +0000
Subject: [PATCH 1/2] fbdev: ssd1307fb: constify the device_info pointer
Message-Id: <1471339638-25134-1-git-send-email-clabbe.montjoie@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, LABBE Corentin <clabbe.montjoie@gmail.com>

of_match_device return const data, so instead of casting its return value
this patch constify the device_info pointer.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/video/fbdev/ssd1307fb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index a9c45c8..b6c9ecf 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -64,7 +64,7 @@ struct ssd1307fb_par {
 	u32 contrast;
 	u32 dclk_div;
 	u32 dclk_frq;
-	struct ssd1307fb_deviceinfo *device_info;
+	const struct ssd1307fb_deviceinfo *device_info;
 	struct i2c_client *client;
 	u32 height;
 	struct fb_info *info;
@@ -559,8 +559,8 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	par->info = info;
 	par->client = client;
 
-	par->device_info = (struct ssd1307fb_deviceinfo *)of_match_device(
-			ssd1307fb_of_match, &client->dev)->data;
+	par->device_info = of_match_device(ssd1307fb_of_match,
+					   &client->dev)->data;
 
 	par->reset = of_get_named_gpio(client->dev.of_node,
 					 "reset-gpios", 0);
-- 
2.7.3

