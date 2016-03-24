From: Julian Scheel <julian@jusst.de>
Date: Thu, 24 Mar 2016 21:14:23 +0000
Subject: [PATCHv2] fbdev: ssd1307fb: Fix charge pump setting
Message-Id: <1458854063-9118-1-git-send-email-julian@jusst.de>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Make sure bit 4 is set for the charge pump setting. It is required according
to SSD1306 App Note.

Signed-off-by: Julian Scheel <julian@jusst.de>
---
Changes in v2:
- Simplify commit message
- Use BIT macros to increase readability
---
 drivers/video/fbdev/ssd1307fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 1611215..3b9ee0c 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -389,7 +389,7 @@ static int ssd1307fb_init(struct ssd1307fb_par *par)
 		return ret;
 
 	ret = ssd1307fb_write_cmd(par->client,
-		(par->device_info->need_chargepump & 0x1 << 2) & 0x14);
+		BIT(4) | (par->device_info->need_chargepump ? BIT(2) : 0));
 	if (ret < 0)
 		return ret;
 
-- 
2.7.0

