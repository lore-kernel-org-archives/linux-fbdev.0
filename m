From: Johan Hovold <jhovold@gmail.com>
Date: Tue, 22 Oct 2013 16:36:57 +0000
Subject: [PATCH] atmel_lcdfb: fix module autoload
Message-Id: <1382459817-26990-1-git-send-email-jhovold@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, Johan Hovold <jhovold@gmail.com>

Add missing module device table which is needed for module autoloading.

Signed-off-by: Johan Hovold <jhovold@gmail.com>
---
 drivers/video/atmel_lcdfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/atmel_lcdfb.c b/drivers/video/atmel_lcdfb.c
index 088511a..67b339c 100644
--- a/drivers/video/atmel_lcdfb.c
+++ b/drivers/video/atmel_lcdfb.c
@@ -94,6 +94,7 @@ static const struct platform_device_id atmel_lcdfb_devtypes[] = {
 		/* terminator */
 	}
 };
+MODULE_DEVICE_TABLE(platform, atmel_lcdfb_devtypes);
 
 static struct atmel_lcdfb_config *
 atmel_lcdfb_get_config(struct platform_device *pdev)
-- 
1.8.4

