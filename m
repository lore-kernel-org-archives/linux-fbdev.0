From: Krzysztof Helt <krzysztof.h1@wp.pl>
Subject: [PATCH] skeletonfb: fix of xxxfb_setup ifdef
Date: Sat, 19 May 2007 17:05:46 +0000 (UTC)
Message-ID: <46508238.2000904@wp.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030002060107030302040700"
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HpSN5-00006g-MM for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 19 May 2007 10:05:36 -0700
Received: from mx1.wp.pl ([212.77.101.5])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HpSN4-0001ZT-4O
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 19 May 2007 10:05:35 -0700
Received: from host-87-99-61-239.lanet.net.pl (HELO [87.99.61.239])
	(krzysztof.h1@[87.99.61.239]) (envelope-sender <krzysztof.h1@wp.pl>)
	by smtp.wp.pl (WP-SMTPD) with SMTP
	for <linux-fbdev-devel@lists.sourceforge.net>;
	19 May 2007 19:05:28 +0200
Date: Sun, 20 May 2007 19:15:36 +0200
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
To: linux-fbdev-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------030002060107030302040700
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes wrong ifdef around the xxxfb_setup. It also moves this 
function to remove forward declaration.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

Diff-ed agains 2.6.22-rc2

diff -urp linux-2.6.21/drivers/video/skeletonfb.c 
linux-2.6.21.new/drivers/video/skeletonfb.c
--- linux-2.6.21/drivers/video/skeletonfb.c	2007-05-20 
18:45:05.907358455 +0200
+++ linux-2.6.21.new/drivers/video/skeletonfb.c	2007-05-20 
18:37:48.054406637 +0200
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
  /* 
------------------------------------------------------------------------- */




--------------030002060107030302040700
Content-Type: text/plain;
 name="skeletonfb-setup-ifdef.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="skeletonfb-setup-ifdef.diff"

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes wrong ifdef around the xxxfb_setup. It also moves this function to remove forward declaration.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff -urp linux-2.6.21/drivers/video/skeletonfb.c linux-2.6.21.new/drivers/video/skeletonfb.c
--- linux-2.6.21/drivers/video/skeletonfb.c	2007-05-20 18:45:05.907358455 +0200
+++ linux-2.6.21.new/drivers/video/skeletonfb.c	2007-05-20 18:37:48.054406637 +0200
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
 
 

--------------030002060107030302040700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--------------030002060107030302040700
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-fbdev-devel mailing list
Linux-fbdev-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel

--------------030002060107030302040700--
