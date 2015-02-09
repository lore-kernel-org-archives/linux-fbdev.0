From: Sanjeev Sharma <sanjeev_sharma@mentor.com>
Date: Mon, 09 Feb 2015 11:14:27 +0000
Subject: [PATCH] video: fbdev: make of_device_id array const
Message-Id: <1423479747-17899-1-git-send-email-sanjeev_sharma@mentor.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel@pengutronix.de, plagnioj@jcrosoft.com
Cc: tomi.valkeinen@ti.com, linux-fbdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Sanjeev Sharma <sanjeev_sharma@mentor.com>, Sanjeev Sharma <Sanjeev_Sharma@mentor.com>

Make of_device_id array const.

Signed-off-by: Sanjeev Sharma <Sanjeev_Sharma@mentor.com>
---
 drivers/video/fbdev/imxfb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/imxfb.c b/drivers/video/fbdev/imxfb.c
index 3b6a3c8..84d1d29 100644
--- a/drivers/video/fbdev/imxfb.c
+++ b/drivers/video/fbdev/imxfb.c
@@ -183,7 +183,7 @@ static struct platform_device_id imxfb_devtype[] = {
 };
 MODULE_DEVICE_TABLE(platform, imxfb_devtype);
 
-static struct of_device_id imxfb_of_dev_id[] = {
+static const struct of_device_id imxfb_of_dev_id[] = {
 	{
 		.compatible = "fsl,imx1-fb",
 		.data = &imxfb_devtype[IMX1_FB],
-- 
1.7.11.7

