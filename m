From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] tridentfb.c: make some code static
Date: Mon, 7 Feb 2005 00:33:09 +0100
Message-ID: <20050206233309.GH3129@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cxvu3-0004hf-KK
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Feb 2005 15:33:19 -0800
Received: from emailhub.stusta.mhn.de ([141.84.69.5] helo=mailout.stusta.mhn.de)
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Cxvu1-0001Ed-UF
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Feb 2005 15:33:19 -0800
Content-Disposition: inline
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: Jani Monoses <jani@iv.ro>, Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/video/tridentfb.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

This patch was already sent on:
- 21 Nov 2004

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



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
