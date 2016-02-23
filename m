From: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Date: Tue, 23 Feb 2016 12:56:17 +0000
Subject: [PATCH] fbdev: n411: check return value
Message-Id: <1456231457-20806-1-git-send-email-sudipm.mukherjee@gmail.com>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org, Sudip Mukherjee <sudipm.mukherjee@gmail.com>

We were not checking the return value of platform_device_add_data()
which can fail.

Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>
---
 drivers/video/fbdev/n411.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/video/fbdev/n411.c b/drivers/video/fbdev/n411.c
index 935830f..053deac 100644
--- a/drivers/video/fbdev/n411.c
+++ b/drivers/video/fbdev/n411.c
@@ -165,16 +165,22 @@ static int __init n411_init(void)
 	if (!n411_device)
 		return -ENOMEM;
 
-	platform_device_add_data(n411_device, &n411_board, sizeof(n411_board));
+	ret = platform_device_add_data(n411_device, &n411_board,
+				       sizeof(n411_board));
+	if (ret)
+		goto put_plat_device;
 
 	/* this _add binds hecubafb to n411. hecubafb refcounts n411 */
 	ret = platform_device_add(n411_device);
 
 	if (ret)
-		platform_device_put(n411_device);
+		goto put_plat_device;
 
-	return ret;
+	return 0;
 
+put_plat_device:
+	platform_device_put(n411_device);
+	return ret;
 }
 
 static void __exit n411_exit(void)
-- 
1.9.1

