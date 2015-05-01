From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Date: Fri, 01 May 2015 15:38:41 +0000
Subject: [PATCH 4/4] video: fbdev: s3c-fb: Constify platform_device_id
Message-Id: <1430494721-30793-4-git-send-email-k.kozlowski.k@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
References: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
In-Reply-To: <1430494721-30793-1-git-send-email-k.kozlowski.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 drivers/video/fbdev/s3c-fb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/s3c-fb.c b/drivers/video/fbdev/s3c-fb.c
index 7e3a05fc47aa..f72dd12456f9 100644
--- a/drivers/video/fbdev/s3c-fb.c
+++ b/drivers/video/fbdev/s3c-fb.c
@@ -1938,7 +1938,7 @@ static struct s3c_fb_driverdata s3c_fb_data_s3c2443 = {
 	},
 };
 
-static struct platform_device_id s3c_fb_driver_ids[] = {
+static const struct platform_device_id s3c_fb_driver_ids[] = {
 	{
 		.name		= "s3c-fb",
 		.driver_data	= (unsigned long)&s3c_fb_data_64xx,
-- 
2.1.4

