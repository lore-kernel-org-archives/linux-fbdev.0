From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 12 Jan 2015 19:21:14 +0000
Subject: [PATCH] fbdev: ssd1307fb: drop unused function ssd1307fb_write_data()
Message-Id: <1421090474-4243-1-git-send-email-prabhakar.csengg@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LFBDEV <linux-fbdev@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

this patch drops the unused function ssd1307fb_write_data().

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 drivers/video/fbdev/ssd1307fb.c | 17 -----------------
 1 file changed, 17 deletions(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index a7ecaa6..c891f11 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -122,23 +122,6 @@ static inline int ssd1307fb_write_cmd(struct i2c_client *client, u8 cmd)
 	return ret;
 }
 
-static inline int ssd1307fb_write_data(struct i2c_client *client, u8 data)
-{
-	struct ssd1307fb_array *array;
-	int ret;
-
-	array = ssd1307fb_alloc_array(1, SSD1307FB_DATA);
-	if (!array)
-		return -ENOMEM;
-
-	array->data[0] = data;
-
-	ret = ssd1307fb_write_array(client, array, 1);
-	kfree(array);
-
-	return ret;
-}
-
 static void ssd1307fb_update_display(struct ssd1307fb_par *par)
 {
 	struct ssd1307fb_array *array;
-- 
1.9.1

