From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] tridentfb.c: make some code static
Date: Sun, 21 Nov 2004 16:36:43 +0100
Message-ID: <20041121153643.GZ2829@stusta.de>
Mime-Version: 1.0
Return-path: <linux-kernel-owner+glk-linux-kernel=40m.gmane.org-S261735AbUKUPn6@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Id: <fbdev-devel.lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jani Monoses <jani@iv.ro>
Cc: Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

The patch below makes some needlessly global code static.


diffstat output:
 drivers/video/tridentfb.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm2-full/drivers/video/tridentfb.c.old	2004-11-21 15:01:33.000000000 +0100
+++ linux-2.6.10-rc2-mm2-full/drivers/video/tridentfb.c	2004-11-21 15:03:19.000000000 +0100
@@ -31,7 +31,7 @@
 	void __iomem * io_virt;	//iospace virtual memory address
 };
 
-unsigned char eng_oper;		//engine operation...
+static unsigned char eng_oper;		//engine operation...
 static struct fb_ops tridentfb_ops;
 
 static struct tridentfb_par default_par;
@@ -91,7 +91,7 @@
 static int chip3D;
 static int chipcyber;
 
-int is3Dchip(int id)
+static int is3Dchip(int id)
 {
 	return 	((id == BLADE3D) || (id == CYBERBLADEE4) ||
 		 (id == CYBERBLADEi7) || (id == CYBERBLADEi7D) ||
@@ -104,7 +104,7 @@
 		 (id ==	CYBERBLADEXPAi1));
 }
 
-int iscyber(int id)
+static int iscyber(int id)
 {
 	switch (id) {
 		case CYBER9388:		
@@ -1223,9 +1223,9 @@
 	.remove		= __devexit_p(trident_pci_remove)
 };
 
-int tridentfb_setup(char *options);
+static int tridentfb_setup(char *options);
 
-int __init tridentfb_init(void)
+static int __init tridentfb_init(void)
 {
 #ifndef MODULE
 	char *option = NULL;
@@ -1238,7 +1238,7 @@
 	return pci_module_init(&tridentfb_pci_driver);
 }
 
-void __exit tridentfb_exit(void)
+static void __exit tridentfb_exit(void)
 {
 	pci_unregister_driver(&tridentfb_pci_driver);
 }
@@ -1249,7 +1249,8 @@
  * example:
  * 	video=trident:800x600,bpp=16,noaccel
  */
-int tridentfb_setup(char *options)
+#ifndef MODULE
+static int tridentfb_setup(char *options)
 {
 	char * opt;
 	if (!options || !*options)
@@ -1279,6 +1280,7 @@
 	}
 	return 0;
 }
+#endif
 
 static struct fb_ops tridentfb_ops = {
 	.owner	= THIS_MODULE,
