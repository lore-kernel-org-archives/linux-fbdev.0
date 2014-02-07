From: Levente Kurusa <levex@linux.com>
Date: Fri, 07 Feb 2014 08:43:21 +0000
Subject: [PATCH] backlight: replace kfree with put_device
Message-Id: <1391762601-4560-1-git-send-email-levex@linux.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, Jingoo Han <jg1.han@samsung.com>, Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>, FBDEV list <linux-fbdev@vger.kernel.org>
Cc: Levente Kurusa <levex@linux.com>

As per the comments on device_register, we shouldn't call kfree()
right after a device_register() failure. Instead call put_device(),
which in turn will call bl_device_release resulting in a kfree to the
full structure.

Signed-off-by: Levente Kurusa <levex@linux.com>
---
 drivers/video/backlight/backlight.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/backlight/backlight.c b/drivers/video/backlight/backlight.c
index 5d05555..20b276e 100644
--- a/drivers/video/backlight/backlight.c
+++ b/drivers/video/backlight/backlight.c
@@ -333,7 +333,7 @@ struct backlight_device *backlight_device_register(const char *name,
 
 	rc = device_register(&new_bd->dev);
 	if (rc) {
-		kfree(new_bd);
+		put_device(&new_bd->dev);
 		return ERR_PTR(rc);
 	}
 
-- 
1.8.3.1

