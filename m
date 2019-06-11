From: Colin King <colin.king@canonical.com>
Date: Tue, 11 Jun 2019 17:09:13 +0000
Subject: [PATCH][next] video: fbdev: atmel_lcdfb: remove redundant initialization to variable ret
Message-Id: <20190611170913.20913-1-colin.king@canonical.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Ferre <nicolas.ferre@microchip.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently variable ret is being initialized with -ENOENT however that
value is never read and ret is being re-assigned later on. Hence this
assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/atmel_lcdfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index fb117ccbeab3..930cc3f92e01 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -950,7 +950,7 @@ static int atmel_lcdfb_of_init(struct atmel_lcdfb_info *sinfo)
 	struct fb_videomode fb_vm;
 	struct gpio_desc *gpiod;
 	struct videomode vm;
-	int ret = -ENOENT;
+	int ret;
 	int i;
 
 	sinfo->config = (struct atmel_lcdfb_config*)
-- 
2.20.1
