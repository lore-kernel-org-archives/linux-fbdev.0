From: Andrey Ryabinin <a.ryabinin@samsung.com>
Date: Wed, 21 Jan 2015 15:06:08 +0000
Subject: [PATCH] backlight: da9052_bl: terminate da9052_wled_ids array with empty element
Message-Id: <1421852768-29622-1-git-send-email-a.ryabinin@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, Support Opensource <support.opensource@diasemi.com>, Jingoo Han <jg1.han@samsung.com>, Lee Jones <lee.jones@linaro.org>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, "open list:FRAMEBUFFER LAYER" <linux-fbdev@vger.kernel.org>
Cc: Andrey Ryabinin <a.ryabinin@samsung.com>

Array of platform_device_id elements should be terminated
with empty element.

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 drivers/video/backlight/da9052_bl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/backlight/da9052_bl.c
index d4bd74bd..b1943e7 100644
--- a/drivers/video/backlight/da9052_bl.c
+++ b/drivers/video/backlight/da9052_bl.c
@@ -165,6 +165,7 @@ static struct platform_device_id da9052_wled_ids[] = {
 		.name		= "da9052-wled3",
 		.driver_data	= DA9052_TYPE_WLED3,
 	},
+	{ },
 };
 
 static struct platform_driver da9052_wled_driver = {
-- 
2.2.1

