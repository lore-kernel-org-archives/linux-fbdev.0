From: niederp@physik.uni-kl.de
Date: Fri, 06 Feb 2015 22:28:14 +0000
Subject: [PATCH 8/8] fbdev: ssd1307fb: Turn off display on driver unload.
Message-Id: <1423261694-5939-9-git-send-email-niederp@physik.uni-kl.de>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
In-Reply-To: <1423261694-5939-1-git-send-email-niederp@physik.uni-kl.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: linux-fbdev@vger.kernel.org, plagnioj@jcrosoft.com, tomi.valkeinen@ti.com, maxime.ripard@free-electrons.com
Cc: linux-kernel@vger.kernel.org, =?UTF-8?q?Thomas=20Niederpr=C3=BCm?= <niederp@physik.uni-kl.de>

From: Thomas Niederprüm <niederp@physik.uni-kl.de>

Signed-off-by: Thomas Niederprüm <niederp@physik.uni-kl.de>
---
 drivers/video/fbdev/ssd1307fb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/video/fbdev/ssd1307fb.c b/drivers/video/fbdev/ssd1307fb.c
index 02931c7..be91dfc 100644
--- a/drivers/video/fbdev/ssd1307fb.c
+++ b/drivers/video/fbdev/ssd1307fb.c
@@ -762,6 +762,11 @@ static int ssd1307fb_remove(struct i2c_client *client)
 {
 	struct fb_info *info = i2c_get_clientdata(client);
 	struct ssd1307fb_par *par = info->par;
+	int ret = 0;
+
+	ret = ssd1307fb_write_cmd(par->client, SSD1307FB_DISPLAY_OFF);
+	if (ret < 0)
+		return ret;
 
 	unregister_framebuffer(info);
 	if (par->device_info->device_id = DEVID_SSD1307) {
-- 
2.1.1

