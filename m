From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] Remove obsolete cruft from aty128fb
Date: Tue, 10 Feb 2004 21:36:38 +1100
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <1076408923.874.0.camel@gaston>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AqVG3-000355-TG
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 02:36:47 -0800
Received: from gate.crashing.org ([63.228.1.57] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.30)
	id 1AqVGA-0001cB-8n
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 10 Feb 2004 02:36:54 -0800
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
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Hi James !

This removes no longer needed includes from aty128fb

diff -urN fbdev-2.5/drivers/video/aty/aty128fb.c linuxppc-2.5-benh/drivers/video/aty/aty128fb.c
--- fbdev-2.5/drivers/video/aty/aty128fb.c	2004-01-28 16:50:07.000000000 +1100
+++ linuxppc-2.5-benh/drivers/video/aty/aty128fb.c	2004-02-09 18:51:35.000000000 +1100
@@ -71,11 +71,6 @@
 #include "../macmodes.h"
 #endif
 
-#ifdef CONFIG_ADB_PMU
-#include <linux/adb.h>
-#include <linux/pmu.h>
-#endif
-
 #ifdef CONFIG_PMAC_BACKLIGHT
 #include <asm/backlight.h>
 #endif




-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
