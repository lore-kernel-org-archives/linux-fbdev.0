From: akpm@osdl.org
Subject: [patch 3/3] tridentfb warning fix
Date: Wed, 09 Feb 2005 22:33:12 -0800
Message-ID: <200502100633.j1A6XEl31955@mail.osdl.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cz7t7-0006HB-HH
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Feb 2005 22:33:17 -0800
Received: from fw.osdl.org ([65.172.181.6] helo=mail.osdl.org)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cz7t5-0001h3-Te
	for linux-fbdev-devel@lists.sourceforge.net; Wed, 09 Feb 2005 22:33:17 -0800
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-fbdev-devel@lists.sourceforge.net
Cc: akpm@osdl.org



drivers/video/tridentfb.c:1219: warning: `tridentfb_setup' declared `static' but never defined

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/video/tridentfb.c |   39 +++++++++++++++++---------------------
 1 files changed, 18 insertions(+), 21 deletions(-)

diff -puN drivers/video/tridentfb.c~tridentfb-warning-fix drivers/video/tridentfb.c
--- 25/drivers/video/tridentfb.c~tridentfb-warning-fix	2005-02-09 22:34:09.000000000 -0800
+++ 25-akpm/drivers/video/tridentfb.c	2005-02-09 22:34:33.000000000 -0800
@@ -1216,27 +1216,6 @@ static struct pci_driver tridentfb_pci_d
 	.remove		= __devexit_p(trident_pci_remove)
 };
 
-static int tridentfb_setup(char *options);
-
-static int __init tridentfb_init(void)
-{
-#ifndef MODULE
-	char *option = NULL;
-
-	if (fb_get_options("tridentfb", &option))
-		return -ENODEV;
-	tridentfb_setup(option);
-#endif
-	output("Trident framebuffer %s initializing\n", VERSION);
-	return pci_module_init(&tridentfb_pci_driver);
-}
-
-static void __exit tridentfb_exit(void)
-{
-	pci_unregister_driver(&tridentfb_pci_driver);
-}
-
-
 /*
  * Parse user specified options (`video=trident:')
  * example:
@@ -1275,6 +1254,24 @@ static int tridentfb_setup(char *options
 }
 #endif
 
+static int __init tridentfb_init(void)
+{
+#ifndef MODULE
+	char *option = NULL;
+
+	if (fb_get_options("tridentfb", &option))
+		return -ENODEV;
+	tridentfb_setup(option);
+#endif
+	output("Trident framebuffer %s initializing\n", VERSION);
+	return pci_module_init(&tridentfb_pci_driver);
+}
+
+static void __exit tridentfb_exit(void)
+{
+	pci_unregister_driver(&tridentfb_pci_driver);
+}
+
 static struct fb_ops tridentfb_ops = {
 	.owner	= THIS_MODULE,
 	.fb_setcolreg = tridentfb_setcolreg,
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
