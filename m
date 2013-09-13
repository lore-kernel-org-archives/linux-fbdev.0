From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Sep 2013 19:51:50 +0000
Subject: [PATCH v2] video/matrox/matroxfb_maven: Use module_i2c_driver to register driver
Message-Id: <20130913215150.16089f46@endymion.delvare>
List-Id: <linux-fbdev.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev@vger.kernel.org

From: Peter Huewe <peterhuewe@gmx.de>

Removing some boilerplate by using module_i2c_driver instead of calling
register and unregister in the otherwise empty init/exit functions.
Also removed a useless comment as suggested by Jean Delvare.

Signed-off-by: Peter Huewe <peterhuewe@gmx.de>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
Cc: Tomi Valkeinen <tomi.valkeinen@ti.com>
---
Looks like this patch got lost so I am resending it.

 drivers/video/matrox/matroxfb_maven.c |   14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

--- linux-3.12-rc0.orig/drivers/video/matrox/matroxfb_maven.c	2013-09-13 21:48:12.585102831 +0200
+++ linux-3.12-rc0/drivers/video/matrox/matroxfb_maven.c	2013-09-13 21:48:28.843103072 +0200
@@ -1295,19 +1295,7 @@ static struct i2c_driver maven_driver={
 	.id_table	= maven_id,
 };
 
-static int __init matroxfb_maven_init(void)
-{
-	return i2c_add_driver(&maven_driver);
-}
-
-static void __exit matroxfb_maven_exit(void)
-{
-	i2c_del_driver(&maven_driver);
-}
-
+module_i2c_driver(maven_driver);
 MODULE_AUTHOR("(c) 1999-2002 Petr Vandrovec <vandrove@vc.cvut.cz>");
 MODULE_DESCRIPTION("Matrox G200/G400 Matrox MGA-TVO driver");
 MODULE_LICENSE("GPL");
-module_init(matroxfb_maven_init);
-module_exit(matroxfb_maven_exit);
-/* we do not have __setup() yet */


-- 
Jean Delvare
