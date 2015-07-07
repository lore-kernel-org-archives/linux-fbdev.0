From: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Date: Tue, 07 Jul 2015 13:00:47 +0000
Subject: [PATCH RESEND] video: fbdev: s3c-fb: Constify platform_device_id
Message-Id: <1436274047-3274-1-git-send-email-k.kozlowski.k@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jingoo Han <jingoohan1@gmail.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

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

