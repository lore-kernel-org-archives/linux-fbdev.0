From: Adrian Bunk <bunk@stusta.de>
Subject: [2.6 patch] sstfb.c: make some code static
Date: Fri, 11 Feb 2005 19:54:16 +0100
Message-ID: <20050211185416.GB3736@stusta.de>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Czfwe-0003js-Pq
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Feb 2005 10:55:12 -0800
Received: from mailout.stusta.mhn.de ([141.84.69.5])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.41)
	id 1Czfwe-0007RN-1q
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 11 Feb 2005 10:55:12 -0800
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
Cc: Ghozlane Toumi <gtoumi@laposte.net>, Antonino Daplas <adaplas@pol.net>, linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net

This patch below makes some needlessly global code static.
Additionally, it adds #ifdefs for code only used in the 
modular/nonmodular cases.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 21 Nov 2004

 drivers/video/sstfb.c |   11 +++++++----
 1 files changed, 7 insertions(+), 4 deletions(-)

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


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
