From: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] fixes for aty128fb
Date: Mon, 24 Mar 2003 22:48:16 +1100 (EST)
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <15998.61568.388276.241106@nanango.paulus.ozlabs.org>
Reply-To: paulus@samba.org
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from dp.samba.org ([66.70.73.150] helo=lists.samba.org)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 3.31-VA-mm2 #1 (Debian))
	id 18xQYV-00062Y-00
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 24 Mar 2003 03:55:55 -0800
Errors-To: linux-fbdev-devel-admin@lists.sourceforge.net
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
Content-Type: text/plain; charset="us-ascii"
To: James Simmons <jsimmons@infradead.org>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org

The patch below fixes a couple of problems in the aty128fb driver: an
include wasn't finding its file, and it needs to access the
pseudo_palette as 32-bit quantities.

Paul.

diff -urN linux-2.5/drivers/video/aty/aty128fb.c linuxppc-2.5/drivers/video/aty/aty128fb.c
--- linux-2.5/drivers/video/aty/aty128fb.c	2003-03-23 16:29:31.000000000 +1100
+++ linuxppc-2.5/drivers/video/aty/aty128fb.c	2003-03-23 21:42:33.000000000 +1100
@@ -62,7 +62,7 @@
 #ifdef CONFIG_ALL_PPC
 #include <asm/prom.h>
 #include <asm/pci-bridge.h>
-#include "macmodes.h"
+#include "../macmodes.h"
 #endif
 
 #ifdef CONFIG_ADB_PMU
@@ -1994,23 +1994,21 @@
 
 	if (regno < 16) {
 		int i;
+		u32 *pal = info->pseudo_palette;
+
 		switch (par->crtc.depth) {
 		case 15:
-			((u16 *) (info->pseudo_palette))[regno] =
-			    (regno << 10) | (regno << 5) | regno;
+			pal[regno] = (regno << 10) | (regno << 5) | regno;
 			break;
 		case 16:
-			((u16 *) (info->pseudo_palette))[regno] =
-			    (regno << 11) | (regno << 6) | regno;
+			pal[regno] = (regno << 11) | (regno << 6) | regno;
 			break;
 		case 24:
-			((u32 *) (info->pseudo_palette))[regno] =
-			    (regno << 16) | (regno << 8) | regno;
+			pal[regno] = (regno << 16) | (regno << 8) | regno;
 			break;
 		case 32:
 			i = (regno << 8) | regno;
-			((u32 *) (info->pseudo_palette))[regno] =
-			    (i << 16) | i;
+			pal[regno] = (i << 16) | i;
 			break;
 		}
 	}


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
