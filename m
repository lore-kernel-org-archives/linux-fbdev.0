From: domen@coderock.org
Subject: [patch 2/9] drivers/video/*: convert to pci_register_driver
Date: Sun, 06 Mar 2005 11:36:15 +0100
Message-ID: <20050306103615.CE34C1F208@trashy.coderock.org>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D7t7i-0001g9-6C
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Mar 2005 02:36:34 -0800
Received: from coderock.org
	([193.77.147.115] helo=trashy.coderock.org ident=postfix)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D7t7g-0003Yv-SU
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 06 Mar 2005 02:36:34 -0800
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


 kj-domen/drivers/video/asiliantfb.c  |    2 +-
 kj-domen/drivers/video/chipsfb.c     |    2 +-
 kj-domen/drivers/video/cirrusfb.c    |    2 +-
 kj-domen/drivers/video/cyber2000fb.c |    2 +-
 kj-domen/drivers/video/imsttfb.c     |    2 +-
 kj-domen/drivers/video/pm2fb.c       |    2 +-
 kj-domen/drivers/video/pvr2fb.c      |    2 +-
 kj-domen/drivers/video/radeonfb.c    |    2 +-
 kj-domen/drivers/video/sstfb.c       |    2 +-
 kj-domen/drivers/video/tdfxfb.c      |    2 +-
 kj-domen/drivers/video/tgafb.c       |    2 +-
 kj-domen/drivers/video/tridentfb.c   |    2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff -puN drivers/video/asiliantfb.c~pci_register_driver-drivers_video drivers/video/asiliantfb.c
--- kj/drivers/video/asiliantfb.c~pci_register_driver-drivers_video	2005-03-05 16:12:55.000000000 +0100
+++ kj-domen/drivers/video/asiliantfb.c	2005-03-05 16:12:56.000000000 +0100
@@ -609,7 +609,7 @@ int __init asiliantfb_init(void)
 	if (fb_get_options("asiliantfb", NULL))
 		return -ENODEV;
 
-	return pci_module_init(&asiliantfb_driver);
+	return pci_register_driver(&asiliantfb_driver);
 }
 
 module_init(asiliantfb_init);
diff -puN drivers/video/chipsfb.c~pci_register_driver-drivers_video drivers/video/chipsfb.c
--- kj/drivers/video/chipsfb.c~pci_register_driver-drivers_video	2005-03-05 16:12:55.000000000 +0100
+++ kj-domen/drivers/video/chipsfb.c	2005-03-05 16:12:56.000000000 +0100
@@ -465,7 +465,7 @@ int __init chips_init(void)
 	if (fb_get_options("chipsfb", NULL))
 		return -ENODEV;
 
-	return pci_module_init(&chipsfb_driver);
+	return pci_register_driver(&chipsfb_driver);
 }
 
 module_init(chips_init);
diff -puN drivers/video/cirrusfb.c~pci_register_driver-drivers_video drivers/video/cirrusfb.c
--- kj/drivers/video/cirrusfb.c~pci_register_driver-drivers_video	2005-03-05 16:12:56.000000000 +0100
+++ kj-domen/drivers/video/cirrusfb.c	2005-03-05 16:12:56.000000000 +0100
@@ -2621,7 +2621,7 @@ int __init cirrusfb_init(void)
 	error |= zorro_module_init(&cirrusfb_zorro_driver);
 #endif
 #ifdef CONFIG_PCI
-	error |= pci_module_init(&cirrusfb_pci_driver);
+	error |= pci_register_driver(&cirrusfb_pci_driver);
 #endif
 	return error;
 }
diff -puN drivers/video/cyber2000fb.c~pci_register_driver-drivers_video drivers/video/cyber2000fb.c
--- kj/drivers/video/cyber2000fb.c~pci_register_driver-drivers_video	2005-03-05 16:12:56.000000000 +0100
+++ kj-domen/drivers/video/cyber2000fb.c	2005-03-05 16:12:56.000000000 +0100
@@ -1737,7 +1737,7 @@ int __init cyber2000fb_init(void)
 	}
 #endif
 #ifdef CONFIG_PCI
-	err = pci_module_init(&cyberpro_driver);
+	err = pci_register_driver(&cyberpro_driver);
 	if (!err)
 		ret = 0;
 #endif
diff -puN drivers/video/imsttfb.c~pci_register_driver-drivers_video drivers/video/imsttfb.c
--- kj/drivers/video/imsttfb.c~pci_register_driver-drivers_video	2005-03-05 16:12:56.000000000 +0100
+++ kj-domen/drivers/video/imsttfb.c	2005-03-05 16:12:56.000000000 +0100
@@ -1611,7 +1611,7 @@ int __init imsttfb_init(void)
 
 	imsttfb_setup(option);
 #endif
-	return pci_module_init(&imsttfb_pci_driver);
+	return pci_register_driver(&imsttfb_pci_driver);
 }
  
 static void __exit imsttfb_exit(void)
diff -puN drivers/video/pm2fb.c~pci_register_driver-drivers_video drivers/video/pm2fb.c
--- kj/drivers/video/pm2fb.c~pci_register_driver-drivers_video	2005-03-05 16:12:56.000000000 +0100
+++ kj-domen/drivers/video/pm2fb.c	2005-03-05 16:12:56.000000000 +0100
@@ -1259,7 +1259,7 @@ int __init pm2fb_init(void)
 	pm2fb_setup(option);
 #endif
 
-	return pci_module_init(&pm2fb_driver);
+	return pci_register_driver(&pm2fb_driver);
 }
 
 #ifdef MODULE
diff -puN drivers/video/pvr2fb.c~pci_register_driver-drivers_video drivers/video/pvr2fb.c
--- kj/drivers/video/pvr2fb.c~pci_register_driver-drivers_video	2005-03-05 16:12:56.000000000 +0100
+++ kj-domen/drivers/video/pvr2fb.c	2005-03-05 16:12:56.000000000 +0100
@@ -966,7 +966,7 @@ static struct pci_driver pvr2fb_pci_driv
 
 static int __init pvr2fb_pci_init(void)
 {
-	return pci_module_init(&pvr2fb_pci_driver);
+	return pci_register_driver(&pvr2fb_pci_driver);
 }
 
 static void pvr2fb_pci_exit(void)
diff -puN drivers/video/radeonfb.c~pci_register_driver-drivers_video drivers/video/radeonfb.c
--- kj/drivers/video/radeonfb.c~pci_register_driver-drivers_video	2005-03-05 16:12:56.000000000 +0100
+++ kj-domen/drivers/video/radeonfb.c	2005-03-05 16:12:56.000000000 +0100
@@ -3120,7 +3120,7 @@ int __init radeonfb_old_init (void)
 		return -ENODEV;
 	radeonfb_old_setup(option);
 #endif
-	return pci_module_init (&radeonfb_driver);
+	return pci_register_driver (&radeonfb_driver);
 }
 
 
diff -puN drivers/video/sstfb.c~pci_register_driver-drivers_video drivers/video/sstfb.c
--- kj/drivers/video/sstfb.c~pci_register_driver-drivers_video	2005-03-05 16:12:56.000000000 +0100
+++ kj-domen/drivers/video/sstfb.c	2005-03-05 16:12:56.000000000 +0100
@@ -1574,7 +1574,7 @@ int __devinit sstfb_init(void)
 		return -ENODEV;
 	sstfb_setup(option);
 #endif
-	return pci_module_init(&sstfb_driver);
+	return pci_register_driver(&sstfb_driver);
 }
 
 void __devexit sstfb_exit(void)
diff -puN drivers/video/tdfxfb.c~pci_register_driver-drivers_video drivers/video/tdfxfb.c
--- kj/drivers/video/tdfxfb.c~pci_register_driver-drivers_video	2005-03-05 16:12:56.000000000 +0100
+++ kj-domen/drivers/video/tdfxfb.c	2005-03-05 16:12:56.000000000 +0100
@@ -1331,7 +1331,7 @@ int __init tdfxfb_init(void)
 
 	tdfxfb_setup(option);
 #endif
-        return pci_module_init(&tdfxfb_driver);
+        return pci_register_driver(&tdfxfb_driver);
 }
 
 static void __exit tdfxfb_exit(void)
diff -puN drivers/video/tgafb.c~pci_register_driver-drivers_video drivers/video/tgafb.c
--- kj/drivers/video/tgafb.c~pci_register_driver-drivers_video	2005-03-05 16:12:56.000000000 +0100
+++ kj-domen/drivers/video/tgafb.c	2005-03-05 16:12:56.000000000 +0100
@@ -1540,7 +1540,7 @@ tgafb_init(void)
 		return -ENODEV;
 	tgafb_setup(option);
 #endif
-	return pci_module_init(&tgafb_driver);
+	return pci_register_driver(&tgafb_driver);
 }
 
 /*
diff -puN drivers/video/tridentfb.c~pci_register_driver-drivers_video drivers/video/tridentfb.c
--- kj/drivers/video/tridentfb.c~pci_register_driver-drivers_video	2005-03-05 16:12:56.000000000 +0100
+++ kj-domen/drivers/video/tridentfb.c	2005-03-05 16:12:56.000000000 +0100
@@ -1228,7 +1228,7 @@ int __init tridentfb_init(void)
 	tridentfb_setup(option);
 #endif
 	output("Trident framebuffer %s initializing\n", VERSION);
-	return pci_module_init(&tridentfb_pci_driver);
+	return pci_register_driver(&tridentfb_pci_driver);
 }
 
 void __exit tridentfb_exit(void)
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
