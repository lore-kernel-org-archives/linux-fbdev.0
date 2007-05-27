From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 1/9] skeletonfb: fix of xxxfb_setup ifdef
Date: Sun, 27 May 2007 08:46:08 +0800
Message-ID: <4658D4D0.5030708@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HsFPO-0001vC-Nu for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 02:51:30 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HsFPN-0003fW-59
	for linux-fbdev-devel@lists.sourceforge.net;
	Sun, 27 May 2007 02:51:30 -0700
Received: by py-out-1112.google.com with SMTP id u77so2302792pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sun, 27 May 2007 02:51:28 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes wrong ifdef around the xxxfb_setup. It also moves this
function to remove forward declaration.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/skeletonfb.c |   31 +++++++++++++++----------------
 1 files changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/video/skeletonfb.c b/drivers/video/skeletonfb.c
index 836a612..64779e7 100644
--- a/drivers/video/skeletonfb.c
+++ b/drivers/video/skeletonfb.c
@@ -132,7 +132,6 @@ static struct fb_info info;
 static struct xxx_par __initdata current_par;
 
 int xxxfb_init(void);
-int xxxfb_setup(char*);
 
 /**
  *	xxxfb_open - Optional function. Called when the framebuffer is
@@ -975,6 +974,21 @@ static struct platform_device xxxfb_devi
 	.name = "xxxfb",
 };
 
+#ifndef MODULE
+    /*
+     *  Setup
+     */
+
+/*
+ * Only necessary if your driver takes special options,
+ * otherwise we fall back on the generic fb_setup().
+ */
+int __init xxxfb_setup(char *options)
+{
+    /* Parse user speficied options (`video=xxxfb:') */
+}
+#endif /* MODULE */
+
 static int __init xxxfb_init(void)
 {
 	int ret;
@@ -1006,21 +1020,6 @@ static void __exit xxxfb_exit(void)
 }
 #endif /* CONFIG_PCI */
 
-#ifdef MODULE
-    /*
-     *  Setup
-     */
-
-/* 
- * Only necessary if your driver takes special options,
- * otherwise we fall back on the generic fb_setup().
- */
-int __init xxxfb_setup(char *options)
-{
-    /* Parse user speficied options (`video=xxxfb:') */
-}
-#endif /* MODULE */
-
 /* ------------------------------------------------------------------------- */
 
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
