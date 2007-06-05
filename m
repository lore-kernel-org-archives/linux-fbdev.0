From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 4/5] pm3fb: possible cleanups
Date: Tue, 05 Jun 2007 19:23:31 +0800
Message-ID: <466547B3.7070407@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HvXDj-0008W4-0b for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Jun 2007 04:29:03 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HvXDi-0005wq-D5
	for linux-fbdev-devel@lists.sourceforge.net;
	Tue, 05 Jun 2007 04:29:02 -0700
Received: by py-out-1112.google.com with SMTP id u77so2968809pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Tue, 05 Jun 2007 04:29:02 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Adrian Bunk <bunk@stusta.de>

From: Adrian Bunk <bunk@stusta.de>

This patch contains the following possible cleanups:
- remove the empty pm3fb_setup() and corresponding code
- pm3fb_init() can become static
[adaplas]
- retain call to fb_get_options() for global options

Signed-off-by: Adrian Bunk <bunk@stusta.de>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/pm3fb.c |   29 ++---------------------------
 1 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/drivers/video/pm3fb.c b/drivers/video/pm3fb.c
index a9b841c..5b3f54c 100644
--- a/drivers/video/pm3fb.c
+++ b/drivers/video/pm3fb.c
@@ -612,8 +612,6 @@ #endif /* ! __BIG_ENDIAN */
 /*
  * hardware independent functions
  */
-int pm3fb_init(void);
-
 static int pm3fb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 {
 	u32 lpitch;
@@ -1170,35 +1168,12 @@ static struct pci_driver pm3fb_driver = 
 
 MODULE_DEVICE_TABLE(pci, pm3fb_id_table);
 
-#ifndef MODULE
-	/*
-	 *  Setup
-	 */
-
-/*
- * Only necessary if your driver takes special options,
- * otherwise we fall back on the generic fb_setup().
- */
-static int __init pm3fb_setup(char *options)
+static int __init pm3fb_init(void)
 {
-	/* Parse user speficied options (`video=pm3fb:') */
-	return 0;
-}
-#endif /* MODULE */
-
-int __init pm3fb_init(void)
-{
-	/*
-	 *  For kernel boot options (in 'video=pm3fb:<options>' format)
-	 */
 #ifndef MODULE
-	char *option = NULL;
-
-	if (fb_get_options("pm3fb", &option))
+	if (fb_get_options("pm3fb", NULL))
 		return -ENODEV;
-	pm3fb_setup(option);
 #endif
-
 	return pci_register_driver(&pm3fb_driver);
 }
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
