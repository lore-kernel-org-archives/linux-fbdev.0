From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/5] fbdev: Convert drivers to pci_register_driver
Date: Tue, 15 Mar 2005 07:05:59 +0800
Message-ID: <200503150705.59656.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAyfM-0007tr-Kg
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 15:08:04 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAyfK-0002TU-Ey
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 14 Mar 2005 15:08:04 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 248F2FB0126
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 14 Mar 2005 23:07:46 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, c.lucas@ifrance.com, domen@coderock.org

  convert from pci_module_init to pci_register_driver
  (from:http://kerneljanitors.org/TODO).

Signed-off-by: Christophe Lucas <c.lucas@ifrance.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 asiliantfb.c         |    2 +-
 aty/aty128fb.c       |    2 +-
 aty/atyfb_base.c     |    2 +-
 aty/radeon_base.c    |    2 +-
 chipsfb.c            |    2 +-
 cirrusfb.c           |    2 +-
 console/sticore.c    |    2 +-
 cyber2000fb.c        |    2 +-
 imsttfb.c            |    2 +-
 intelfb/intelfbdrv.c |    2 +-
 kyro/fbdev.c         |    2 +-
 pm2fb.c              |    2 +-
 pvr2fb.c             |    2 +-
 radeonfb.c           |    2 +-
 sstfb.c              |    2 +-
 tdfxfb.c             |    2 +-
 tgafb.c              |    2 +-
 tridentfb.c          |    2 +-
 18 files changed, 18 insertions(+), 18 deletions(-)

diff -Nru a/drivers/video/asiliantfb.c b/drivers/video/asiliantfb.c
--- a/drivers/video/asiliantfb.c	2005-03-12 23:22:41 +08:00
+++ b/drivers/video/asiliantfb.c	2005-03-05 23:12:56 +08:00
@@ -604,7 +604,7 @@
 	if (fb_get_options("asiliantfb", NULL))
 		return -ENODEV;
 
-	return pci_module_init(&asiliantfb_driver);
+	return pci_register_driver(&asiliantfb_driver);
 }
 
 module_init(asiliantfb_init);
diff -Nru a/drivers/video/aty/aty128fb.c b/drivers/video/aty/aty128fb.c
--- a/drivers/video/aty/aty128fb.c	2005-03-12 23:23:48 +08:00
+++ b/drivers/video/aty/aty128fb.c	2005-03-05 23:12:57 +08:00
@@ -2461,7 +2461,7 @@
 	aty128fb_setup(option);
 #endif
 
-	return pci_module_init(&aty128fb_driver);
+	return pci_register_driver(&aty128fb_driver);
 }
 
 static void __exit aty128fb_exit(void)
diff -Nru a/drivers/video/aty/atyfb_base.c b/drivers/video/aty/atyfb_base.c
--- a/drivers/video/aty/atyfb_base.c	2005-03-14 07:02:53 +08:00
+++ b/drivers/video/aty/atyfb_base.c	2005-03-05 23:12:57 +08:00
@@ -3681,7 +3681,7 @@
 #endif
 
 #ifdef CONFIG_PCI
-    pci_module_init(&atyfb_driver);
+    pci_register_driver(&atyfb_driver);
 #endif
 #ifdef CONFIG_ATARI
     atyfb_atari_probe();
diff -Nru a/drivers/video/aty/radeon_base.c b/drivers/video/aty/radeon_base.c
--- a/drivers/video/aty/radeon_base.c	2005-03-12 23:23:54 +08:00
+++ b/drivers/video/aty/radeon_base.c	2005-03-05 23:12:57 +08:00
@@ -2551,7 +2551,7 @@
 		return -ENODEV;
 	radeonfb_setup(option);
 #endif
-	return pci_module_init (&radeonfb_driver);
+	return pci_register_driver (&radeonfb_driver);
 }
 
 
diff -Nru a/drivers/video/chipsfb.c b/drivers/video/chipsfb.c
--- a/drivers/video/chipsfb.c	2005-03-12 23:22:52 +08:00
+++ b/drivers/video/chipsfb.c	2005-03-05 23:12:56 +08:00
@@ -465,7 +465,7 @@
 	if (fb_get_options("chipsfb", NULL))
 		return -ENODEV;
 
-	return pci_module_init(&chipsfb_driver);
+	return pci_register_driver(&chipsfb_driver);
 }
 
 module_init(chips_init);
diff -Nru a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
--- a/drivers/video/cirrusfb.c	2005-03-12 23:22:53 +08:00
+++ b/drivers/video/cirrusfb.c	2005-03-05 23:12:56 +08:00
@@ -2623,7 +2623,7 @@
 	error |= zorro_module_init(&cirrusfb_zorro_driver);
 #endif
 #ifdef CONFIG_PCI
-	error |= pci_module_init(&cirrusfb_pci_driver);
+	error |= pci_register_driver(&cirrusfb_pci_driver);
 #endif
 	return error;
 }
diff -Nru a/drivers/video/console/sticore.c b/drivers/video/console/sticore.c
--- a/drivers/video/console/sticore.c	2005-03-12 23:24:17 +08:00
+++ b/drivers/video/console/sticore.c	2005-03-05 23:12:58 +08:00
@@ -1050,7 +1050,7 @@
 
 	/* Register drivers for native & PCI cards */
 	register_parisc_driver(&pa_sti_driver);
-	pci_module_init(&pci_sti_driver);
+	pci_register_driver(&pci_sti_driver);
 
 	/* if we didn't find the given default sti, take the first one */
 	if (!default_sti)
diff -Nru a/drivers/video/cyber2000fb.c b/drivers/video/cyber2000fb.c
--- a/drivers/video/cyber2000fb.c	2005-03-12 23:22:55 +08:00
+++ b/drivers/video/cyber2000fb.c	2005-03-05 23:12:56 +08:00
@@ -1740,7 +1740,7 @@
 	}
 #endif
 #ifdef CONFIG_PCI
-	err = pci_module_init(&cyberpro_driver);
+	err = pci_register_driver(&cyberpro_driver);
 	if (!err)
 		ret = 0;
 #endif
diff -Nru a/drivers/video/imsttfb.c b/drivers/video/imsttfb.c
--- a/drivers/video/imsttfb.c	2005-03-12 23:23:09 +08:00
+++ b/drivers/video/imsttfb.c	2005-03-05 23:12:56 +08:00
@@ -1611,7 +1611,7 @@
 
 	imsttfb_setup(option);
 #endif
-	return pci_module_init(&imsttfb_pci_driver);
+	return pci_register_driver(&imsttfb_pci_driver);
 }
  
 static void __exit imsttfb_exit(void)
diff -Nru a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
--- a/drivers/video/intelfb/intelfbdrv.c	2005-03-12 23:24:32 +08:00
+++ b/drivers/video/intelfb/intelfbdrv.c	2005-03-05 23:12:59 +08:00
@@ -360,7 +360,7 @@
 	intelfb_setup(option);
 #endif
 
-	return pci_module_init(&intelfb_driver);
+	return pci_register_driver(&intelfb_driver);
 }
 
 static void __exit
diff -Nru a/drivers/video/kyro/fbdev.c b/drivers/video/kyro/fbdev.c
--- a/drivers/video/kyro/fbdev.c	2005-03-12 23:24:40 +08:00
+++ b/drivers/video/kyro/fbdev.c	2005-03-05 23:13:00 +08:00
@@ -802,7 +802,7 @@
 		return -ENODEV;
 	kyrofb_setup(option);
 #endif
-	return pci_module_init(&kyrofb_pci_driver);
+	return pci_register_driver(&kyrofb_pci_driver);
 }
 
 static void __exit kyrofb_exit(void)
diff -Nru a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
--- a/drivers/video/pm2fb.c	2005-03-11 22:32:03 +08:00
+++ b/drivers/video/pm2fb.c	2005-03-05 23:12:56 +08:00
@@ -1282,7 +1282,7 @@
 	pm2fb_setup(option);
 #endif
 
-	return pci_module_init(&pm2fb_driver);
+	return pci_register_driver(&pm2fb_driver);
 }
 
 module_init(pm2fb_init);
diff -Nru a/drivers/video/pvr2fb.c b/drivers/video/pvr2fb.c
--- a/drivers/video/pvr2fb.c	2005-03-12 23:23:22 +08:00
+++ b/drivers/video/pvr2fb.c	2005-03-05 23:12:56 +08:00
@@ -967,7 +967,7 @@
 
 static int __init pvr2fb_pci_init(void)
 {
-	return pci_module_init(&pvr2fb_pci_driver);
+	return pci_register_driver(&pvr2fb_pci_driver);
 }
 
 static void pvr2fb_pci_exit(void)
diff -Nru a/drivers/video/radeonfb.c b/drivers/video/radeonfb.c
--- a/drivers/video/radeonfb.c	2005-03-12 23:23:25 +08:00
+++ b/drivers/video/radeonfb.c	2005-03-05 23:12:56 +08:00
@@ -3150,7 +3150,7 @@
 		return -ENODEV;
 	radeonfb_old_setup(option);
 #endif
-	return pci_module_init (&radeonfb_driver);
+	return pci_register_driver (&radeonfb_driver);
 }
 
 
diff -Nru a/drivers/video/sstfb.c b/drivers/video/sstfb.c
--- a/drivers/video/sstfb.c	2005-03-12 23:23:32 +08:00
+++ b/drivers/video/sstfb.c	2005-03-05 23:12:56 +08:00
@@ -1575,7 +1575,7 @@
 		return -ENODEV;
 	sstfb_setup(option);
 #endif
-	return pci_module_init(&sstfb_driver);
+	return pci_register_driver(&sstfb_driver);
 }
 
 #ifdef MODULE
diff -Nru a/drivers/video/tdfxfb.c b/drivers/video/tdfxfb.c
--- a/drivers/video/tdfxfb.c	2005-03-12 23:23:36 +08:00
+++ b/drivers/video/tdfxfb.c	2005-03-05 23:12:56 +08:00
@@ -1350,7 +1350,7 @@
 
 	tdfxfb_setup(option);
 #endif
-        return pci_module_init(&tdfxfb_driver);
+        return pci_register_driver(&tdfxfb_driver);
 }
 
 static void __exit tdfxfb_exit(void)
diff -Nru a/drivers/video/tgafb.c b/drivers/video/tgafb.c
--- a/drivers/video/tgafb.c	2005-03-12 23:23:37 +08:00
+++ b/drivers/video/tgafb.c	2005-03-05 23:12:56 +08:00
@@ -1540,7 +1540,7 @@
 		return -ENODEV;
 	tgafb_setup(option);
 #endif
-	return pci_module_init(&tgafb_driver);
+	return pci_register_driver(&tgafb_driver);
 }
 
 /*
diff -Nru a/drivers/video/tridentfb.c b/drivers/video/tridentfb.c
--- a/drivers/video/tridentfb.c	2005-03-12 23:23:37 +08:00
+++ b/drivers/video/tridentfb.c	2005-03-05 23:12:56 +08:00
@@ -1264,7 +1264,7 @@
 	tridentfb_setup(option);
 #endif
 	output("Trident framebuffer %s initializing\n", VERSION);
-	return pci_module_init(&tridentfb_pci_driver);
+	return pci_register_driver(&tridentfb_pci_driver);
 }
 
 static void __exit tridentfb_exit(void)




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
