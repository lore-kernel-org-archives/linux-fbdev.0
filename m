From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 08 Jan 2015 08:17:59 +0000
Subject: [PATCH 2/2] fbdev: ssd1307fb: check return value while setting offset
Message-Id: <1420705079-3741-3-git-send-email-prabhakar.csengg@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1420705079-3741-1-git-send-email-prabhakar.csengg@gmail.com>
In-Reply-To: <1420705079-3741-1-git-send-email-prabhakar.csengg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LFBDEV <linux-fbdev@vger.kernel.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: LKML <linux-kernel@vger.kernel.org>, "Lad, Prabhakar" <prabhakar.csengg@gmail.com>

this patch checks the return value of write command while
setting the display offset.

Signed-off-by: Lad, Prabhakar <prabhakar.csengg@gmail.com>
---
 drivers/video/fbdev/ssd1307fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 70e3ce8..a7ecaa6 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -342,7 +342,7 @@ static int ssd1307fb_ssd1306_init(struct ssd1307fb_par *par)
 
 	/* set display offset value */
 	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_SET_DISPLAY_OFFSET);
-	ret = ssd1307fb_write_cmd(par->client, 0x20);
+	ret = ret & ssd1307fb_write_cmd(par->client, 0x20);
 	if (ret < 0)
 		return ret;
 
-- 
1.9.1

