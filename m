From: domen@coderock.org
Subject: [patch 3/9] drivers/video/aty/*: convert to pci_register_driver
Date: Sun, 06 Mar 2005 11:36:18 +0100
Message-ID: <20050306103619.0882E1F23B@trashy.coderock.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7t7g-0001g2-6Y
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Mar 2005 02:36:32 -0800
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D7t7d-000617-BZ
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Mar 2005 02:36:32 -0800
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
To: adaplas@pol.net
Cc: linux-fbdev-devel@lists.sourceforge.net, domen@coderock.org, c.lucas@ifrance.com


convert from pci_module_init to pci_register_driver
(from:http://kerneljanitors.org/TODO).

Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/video/aty/aty128fb.c    |    2 +-
 kj-domen/drivers/video/aty/atyfb_base.c  |    2 +-
 kj-domen/drivers/video/aty/radeon_base.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff -puN drivers/video/aty/aty128fb.c~pci_register_driver-drivers_video_aty drivers/video/aty/aty128fb.c
--- kj/drivers/video/aty/aty128fb.c~pci_register_driver-drivers_video_aty	2005-03-05 16:12:57.000000000 +0100
+++ kj-domen/drivers/video/aty/aty128fb.c	2005-03-05 16:12:57.000000000 +0100
@@ -2442,7 +2442,7 @@ int __init aty128fb_init(void)
 	aty128fb_setup(option);
 #endif
 
-	return pci_module_init(&aty128fb_driver);
+	return pci_register_driver(&aty128fb_driver);
 }
 
 static void __exit aty128fb_exit(void)
diff -puN drivers/video/aty/atyfb_base.c~pci_register_driver-drivers_video_aty drivers/video/aty/atyfb_base.c
--- kj/drivers/video/aty/atyfb_base.c~pci_register_driver-drivers_video_aty	2005-03-05 16:12:57.000000000 +0100
+++ kj-domen/drivers/video/aty/atyfb_base.c	2005-03-05 16:12:57.000000000 +0100
@@ -3669,7 +3669,7 @@ int __init atyfb_init(void)
 #endif
 
 #ifdef CONFIG_PCI
-    pci_module_init(&atyfb_driver);
+    pci_register_driver(&atyfb_driver);
 #endif
 #ifdef CONFIG_ATARI
     atyfb_atari_probe();
diff -puN drivers/video/aty/radeon_base.c~pci_register_driver-drivers_video_aty drivers/video/aty/radeon_base.c
--- kj/drivers/video/aty/radeon_base.c~pci_register_driver-drivers_video_aty	2005-03-05 16:12:57.000000000 +0100
+++ kj-domen/drivers/video/aty/radeon_base.c	2005-03-05 16:12:57.000000000 +0100
@@ -2497,7 +2497,7 @@ int __init radeonfb_init (void)
 		return -ENODEV;
 	radeonfb_setup(option);
 #endif
-	return pci_module_init (&radeonfb_driver);
+	return pci_register_driver (&radeonfb_driver);
 }
 
 
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
