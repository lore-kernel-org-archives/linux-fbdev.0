From: Jingoo Han <jg1.han@samsung.com>
Date: Mon, 09 Sep 2013 05:49:14 +0000
Subject: [PATCH] video: au1100fb: Remove casting the return value which is a void pointer
Message-Id: <005c01cead20$50fe87e0$f2fb97a0$%han@samsung.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

Casting the return value which is a void pointer is redundant.
The conversion from void pointer to any other pointer type is
guaranteed by the C programming language.

Signed-off-by: Jingoo Han <jg1.han@samsung.com>
---
 drivers/video/au1100fb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/au1100fb.c b/drivers/video/au1100fb.c
index a54ccdc..248abd5 100644
--- a/drivers/video/au1100fb.c
+++ b/drivers/video/au1100fb.c
@@ -588,7 +588,7 @@ int au1100fb_drv_remove(struct platform_device *dev)
 	if (!dev)
 		return -ENODEV;
 
-	fbdev = (struct au1100fb_device *) platform_get_drvdata(dev);
+	fbdev = platform_get_drvdata(dev);
 
 #if !defined(CONFIG_FRAMEBUFFER_CONSOLE) && defined(CONFIG_LOGO)
 	au1100fb_fb_blank(VESA_POWERDOWN, &fbdev->info);
-- 
1.7.10.4


