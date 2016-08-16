From: LABBE Corentin <clabbe.montjoie@gmail.com>
Date: Tue, 16 Aug 2016 09:27:18 +0000
Subject: [PATCH 2/2] fbdev: ssd1307fb: fix a possible NULL dereference
Message-Id: <1471339638-25134-2-git-send-email-clabbe.montjoie@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1471339638-25134-1-git-send-email-clabbe.montjoie@gmail.com>
In-Reply-To: <1471339638-25134-1-git-send-email-clabbe.montjoie@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: plagnioj@jcrosoft.com, tomi.valkeinen@ti.com
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, LABBE Corentin <clabbe.montjoie@gmail.com>

of_match_device could return NULL, and so cause a NULL pointer
dereference later.

For fixing this problem, we use of_device_get_match_data(), this will
simplify the code a little by using a standard function for
getting the match data.

Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
---
 drivers/video/fbdev/ssd1307fb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index b6c9ecf..4265035 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -559,8 +559,7 @@ static int ssd1307fb_probe(struct i2c_client *client,
 	par->info = info;
 	par->client = client;
 
-	par->device_info = of_match_device(ssd1307fb_of_match,
-					   &client->dev)->data;
+	par->device_info = of_device_get_match_data(&client->dev);
 
 	par->reset = of_get_named_gpio(client->dev.of_node,
 					 "reset-gpios", 0);
-- 
2.7.3

