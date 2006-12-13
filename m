From: "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH 2.6.19 5/6] tgafb: Module support fixes
Date: Wed, 13 Dec 2006 17:10:55 +0000 (GMT)
Message-ID: <Pine.LNX.4.64N.0612131619320.24220@blysk.ds.pg.gda.pl>
Reply-To: Linux on Alpha processors <axp-list@redhat.com>
Mime-Version: 1.0
Return-path: <axp-list-bounces@redhat.com>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://www.redhat.com/mailman/listinfo/axp-list>,
	<mailto:axp-list-request@redhat.com?subject=unsubscribe>
List-Archive: <https://www.redhat.com/archives/axp-list>
List-Post: <mailto:axp-list@redhat.com>
List-Help: <mailto:axp-list-request@redhat.com?subject=help>
List-Subscribe: <https://www.redhat.com/mailman/listinfo/axp-list>,
	<mailto:axp-list-request@redhat.com?subject=subscribe>
Sender: axp-list-bounces@redhat.com
Errors-To: axp-list-bounces@redhat.com
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>
Cc: axp-list@redhat.com, linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

 This is a set of clean-ups for the module support in the driver --
__devinit and __devexit classifiers are now specified correctly, 
initialization functions are marked static and a few unnecessary #ifdefs 
are removed.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---

 Please apply.

  Maciej

patch-mips-2.6.18-20060920-tgafb-module-1
diff -up --recursive --new-file linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c linux-mips-2.6.18-20060920/drivers/video/tgafb.c
--- linux-mips-2.6.18-20060920.macro/drivers/video/tgafb.c	2006-09-20 20:50:52.000000000 +0000
+++ linux-mips-2.6.18-20060920/drivers/video/tgafb.c	2006-12-12 19:00:06.000000000 +0000
@@ -42,8 +42,9 @@ static void tgafb_imageblit(struct fb_in
 static void tgafb_fillrect(struct fb_info *, const struct fb_fillrect *);
 static void tgafb_copyarea(struct fb_info *, const struct fb_copyarea *);
 
-static int tgafb_pci_register(struct pci_dev *, const struct pci_device_id *);
-static void tgafb_pci_unregister(struct pci_dev *);
+static int __devinit tgafb_pci_register(struct pci_dev *,
+					const struct pci_device_id *);
+static void __devexit tgafb_pci_unregister(struct pci_dev *);
 
 static const char *mode_option = "640x480@60";
 
@@ -1479,7 +1480,7 @@ tgafb_pci_register(struct pci_dev *pdev,
 	return ret;
 }
 
-static void __exit
+static void __devexit
 tgafb_pci_unregister(struct pci_dev *pdev)
 {
 	struct fb_info *info = pci_get_drvdata(pdev);
@@ -1494,16 +1495,14 @@ tgafb_pci_unregister(struct pci_dev *pde
 	kfree(info);
 }
 
-#ifdef MODULE
-static void __exit
+static void __devexit
 tgafb_exit(void)
 {
 	pci_unregister_driver(&tgafb_driver);
 }
-#endif /* MODULE */
 
 #ifndef MODULE
-int __init
+static int __devinit
 tgafb_setup(char *arg)
 {
 	char *this_opt;
@@ -1525,7 +1524,7 @@ tgafb_setup(char *arg)
 }
 #endif /* !MODULE */
 
-int __init
+static int __devinit
 tgafb_init(void)
 {
 #ifndef MODULE
@@ -1543,10 +1542,7 @@ tgafb_init(void)
  */
 
 module_init(tgafb_init);
-
-#ifdef MODULE
 module_exit(tgafb_exit);
-#endif
 
 MODULE_DESCRIPTION("framebuffer driver for TGA chipset");
 MODULE_LICENSE("GPL");
