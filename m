From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] sstfb.c: make some code static
Date: Sun, 21 Nov 2004 16:36:46 +0100
Message-ID: <20041121153646.GA2829@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261326AbUKUPn5@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ghozlane Toumi <gtoumi@laposte.net>
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

The patch below makes some needlessly global code static.


diffstat output:
 drivers/video/sstfb.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/sstfb.c.old	2004-11-21 14:59:23.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/sstfb.c	2004-11-21 16:02:43.000000000 +0100
@@ -1338,8 +1338,8 @@
 /*
  * Interface to the world
  */
-
-int  __init sstfb_setup(char *options)
+#ifndef MODULE
+static int  __init sstfb_setup(char *options)
 {
 	char *this_opt;
 
@@ -1372,6 +1372,7 @@
 	}
 	return 0;
 }
+#endif
 
 static struct fb_ops sstfb_ops = {
 	.owner		= THIS_MODULE,
@@ -1565,7 +1566,7 @@
 };
 
 
-int __devinit sstfb_init(void)
+static int __devinit sstfb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
@@ -1577,10 +1578,12 @@
 	return pci_module_init(&sstfb_driver);
 }
 
-void __devexit sstfb_exit(void)
+#ifdef MODULE
+static void __devexit sstfb_exit(void)
 {
 	pci_unregister_driver(&sstfb_driver);
 }
+#endif
 
 
 /*
