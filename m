From: Emil Goode <emilgoode@gmail.com>
Date: Fri, 20 Jun 2014 21:50:37 +0000
Subject: [PATCH] video: Remove kfree call since devm_kzalloc() is used
Message-Id: <1403301037-10699-1-git-send-email-emilgoode@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, Jingoo Han <jg1.han@samsung.com>, H Hartley Sweeten <hsweeten@visionengravers.com>
Cc: linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Emil Goode <emilgoode@gmail.com>

We use devm_kzalloc() to allocate memory for the struct vt8500lcd_info
pointer fbi, so there is no need to free it in vt8500lcd_remove().

Signed-off-by: Emil Goode <emilgoode@gmail.com>
---
 drivers/video/fbdev/vt8500lcdfb.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/video/fbdev/vt8500lcdfb.c b/drivers/video/fbdev/vt8500lcdfb.c
index a8f2b28..a1134c3 100644
--- a/drivers/video/fbdev/vt8500lcdfb.c
+++ b/drivers/video/fbdev/vt8500lcdfb.c
@@ -474,8 +474,6 @@ static int vt8500lcd_remove(struct platform_device *pdev)
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	release_mem_region(res->start, resource_size(res));
 
-	kfree(fbi);
-
 	return 0;
 }
 
-- 
1.7.10.4

