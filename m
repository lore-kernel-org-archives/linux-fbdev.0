From: Darren Etheridge <detheridge@ti.com>
Date: Tue, 30 Jul 2013 18:26:22 +0000
Subject: [PATCH v2 15/24] video: da8xx-fb: ensure non-null cfg in pdata
Message-Id: <1375208791-15781-16-git-send-email-detheridge@ti.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Afzal Mohammed <afzal@ti.com>

Ensure that platform data contains pointer for lcd_ctrl_config.

Signed-off-by: Afzal Mohammed <afzal@ti.com>
Signed-off-by: Darren Etheridge <detheridge@ti.com>
---
 drivers/video/da8xx-fb.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/drivers/video/da8xx-fb.c b/drivers/video/da8xx-fb.c
index 61150f9..10af07b 100644
--- a/drivers/video/da8xx-fb.c
+++ b/drivers/video/da8xx-fb.c
@@ -1321,6 +1321,11 @@ static int fb_probe(struct platform_device *device)
 
 	lcd_cfg = (struct lcd_ctrl_config *)fb_pdata->controller_data;
 
+	if (!lcd_cfg) {
+		ret = -EINVAL;
+		goto err_pm_runtime_disable;
+	}
+
 	da8xx_fb_info = framebuffer_alloc(sizeof(struct da8xx_fb_par),
 					&device->dev);
 	if (!da8xx_fb_info) {
-- 
1.7.0.4

