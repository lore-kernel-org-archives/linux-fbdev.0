From: Jim Hague <jim.hague@acm.org>
Subject: [PATCH 1/4] pm2fb: module parameters and module-conditional code
Date: Tue, 7 Dec 2004 11:49:49 +0000
Message-ID: <20041207114949.266379ea@hagrid.bear-cave.org.uk>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cbdqx-0002zi-Pn
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Dec 2004 03:49:59 -0800
Received: from cpc1-oxfd2-6-0-cust43.oxfd.cable.ntl.com ([81.103.191.43] helo=fluffy.bear-cave.org.uk)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1Cbdqv-0000zZ-G0
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Dec 2004 03:49:59 -0800
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
To: linux-fbdev-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>, Antonino Daplas <adaplas@pol.net>


- Update MODULE_PARM to module_param.
- Omit some non-module code from module builds and vice-versa.

Signed-off-by: Jim Hague <jim.hague@acm.org>

=== a/drivers/video/pm2fb.c
==================================================================
--- a/drivers/video/pm2fb.c  (revision 104)
+++ b/drivers/video/pm2fb.c  (revision 105)
@@ -29,6 +29,7 @@
 
 #include <linux/config.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
 #include <linux/string.h>
@@ -1230,6 +1231,7 @@
 	return pci_module_init(&pm2fb_driver);
 }
 
+#ifdef MODULE
 /*
  *  Cleanup
  */
@@ -1238,11 +1240,13 @@
 {
 	pci_unregister_driver(&pm2fb_driver);
 }
+#endif
 
 /*
  *  Setup
  */
 
+#ifndef MODULE
 /**
  * Parse user speficied options.
  *
@@ -1268,6 +1272,7 @@
 	}
 	return 0;
 }
+#endif
 
 
 /* ------------------------------------------------------------------------- */
@@ -1277,12 +1282,18 @@
 
 
 module_init(pm2fb_init);
+
+#ifdef MODULE
 module_exit(pm2fb_exit);
 
-MODULE_PARM(mode,"s");
-MODULE_PARM(lowhsync,"i");
-MODULE_PARM(lowvsync,"i");
+module_param(mode, charp, 0);
+MODULE_PARM_DESC(mode, "Preferred video mode e.g. '648x480-8@60'");
+module_param(lowhsync, bool, 0);
+MODULE_PARM_DESC(lowhsync, "Force horizontal sync low regardless of mode");
+module_param(lowvsync, bool, 0);
+MODULE_PARM_DESC(lowvsync, "Force vertical sync low regardless of mode");
 
 MODULE_AUTHOR("Jim Hague <jim.hague@acm.org>");
 MODULE_DESCRIPTION("Permedia2 framebuffer device driver");
 MODULE_LICENSE("GPL");
+#endif


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
