From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: [PATCH 9/10] ps3: cleanup ps3fb before clearing
	HPTE
Date: Thu, 8 Feb 2007 14:59:58 +0100 (CET)
Message-ID: <Pine.LNX.4.62.0702081459470.19437@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HF9om-0001yR-BC for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 06:00:08 -0800
Received: from [80.88.33.193] (helo=vervifontaine.sonycom.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HF9oj-0008Gv-66
	for linux-fbdev-devel@lists.sourceforge.net;
	Thu, 08 Feb 2007 06:00:07 -0800
In-Reply-To: <Pine.LNX.4.62.0702081452080.19437@pademelon.sonytel.be>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Paul Mackerras <paulus@samba.org>, James Simmons <jsimmons@infradead.org>, Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>, Linux/PPC Development <linuxppc-dev@ozlabs.org>

PS3: Cleanup the frame buffer device before clearing the HPTE mapping

Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
---
 arch/powerpc/platforms/ps3/htab.c |    6 +++++-
 include/asm-powerpc/ps3fb.h       |    2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

--- ps3-linux-2.6.20.orig/arch/powerpc/platforms/ps3/htab.c
+++ ps3-linux-2.6.20/arch/powerpc/platforms/ps3/htab.c
@@ -2,7 +2,7 @@
  *  PS3 pagetable management routines.
  *
  *  Copyright (C) 2006 Sony Computer Entertainment Inc.
- *  Copyright 2006 Sony Corp.
+ *  Copyright 2006, 2007 Sony Corporation
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License as published by
@@ -25,6 +25,7 @@
 #include <asm/udbg.h>
 #include <asm/ps3.h>
 #include <asm/lv1call.h>
+#include <asm/ps3fb.h>
 
 #include "platform.h"
 
@@ -234,6 +235,9 @@ static void ps3_hpte_invalidate(unsigned
 
 static void ps3_hpte_clear(void)
 {
+	/* Make sure to clean up the frame buffer device first */
+	ps3fb_cleanup();
+
 	lv1_unmap_htab(htab_addr);
 }
 
--- ps3-linux-2.6.20.orig/include/asm-powerpc/ps3fb.h
+++ ps3-linux-2.6.20/include/asm-powerpc/ps3fb.h
@@ -45,8 +45,10 @@ struct ps3fb_ioctl_res {
 
 #ifdef CONFIG_FB_PS3
 extern void ps3fb_flip_ctl(int on);
+extern void ps3fb_cleanup(void);
 #else
 static inline void ps3fb_flip_ctl(int on) {}
+static inline void ps3fb_cleanup(void) {}
 #endif
 
 #endif /* __KERNEL__ */

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
