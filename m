From: Jiri Slaby <jslaby@suse.cz>
Date: Tue, 18 Aug 2020 08:56:50 +0000
Subject: [PATCH 3/8] newport_con: make module's init & exit static using module_driver
Message-Id: <20200818085655.12071-3-jslaby@suse.cz>
List-Id: <linux-fbdev.vger.kernel.org>
References: <20200818085655.12071-1-jslaby@suse.cz>
In-Reply-To: <20200818085655.12071-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: gregkh@linuxfoundation.org
Cc: linux-fbdev@vger.kernel.org, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-mips@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>

The compiler complains that newport_console_init and
newport_console_exit are not declared:
   drivers/video/console/newport_con.c:745:12: warning: no previous prototype for 'newport_console_init'
   drivers/video/console/newport_con.c:750:13: warning: no previous prototype for 'newport_console_exit'

Here, it translates into: they should be marked static. Do so by
converting the simple un/registration to module_driver().

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
Cc: linux-mips@vger.kernel.org
---
 drivers/video/console/newport_con.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/video/console/newport_con.c b/drivers/video/console/newport_con.c
index 4d9110393479..0d0989040c58 100644
--- a/drivers/video/console/newport_con.c
+++ b/drivers/video/console/newport_con.c
@@ -751,18 +751,6 @@ static struct gio_driver newport_driver = {
 	.probe = newport_probe,
 	.remove = newport_remove,
 };
-
-int __init newport_console_init(void)
-{
-	return gio_register_driver(&newport_driver);
-}
-
-void __exit newport_console_exit(void)
-{
-	gio_unregister_driver(&newport_driver);
-}
-
-module_init(newport_console_init);
-module_exit(newport_console_exit);
+module_driver(newport_driver, gio_register_driver, gio_unregister_driver);
 
 MODULE_LICENSE("GPL");
-- 
2.28.0
