From: Michal Januszewski <spock@gentoo.org>
Subject: [announce 5/7] fbsplash - fbdev updates
Date: Tue, 8 Mar 2005 03:14:17 +0100
Message-ID: <20050308021417.GF26249@spock.one.pl>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8UEn-0003WZ-BK
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 18:14:21 -0800
Received: from ipp23-131.piekary.net ([80.48.23.131] helo=spock.one.pl)
	by sc8-sf-mx2.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41)
	id 1D8UEl-00082y-K3
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 07 Mar 2005 18:14:21 -0800
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
To: linux-kernel@vger.kernel.org
Cc: linux-fbdev-devel@lists.sourceforge.net

Fbcmap.c updates.

Signed-off-by: Michael Januszewski <spock@gentoo.org>

---
diff -Nru a/drivers/video/fbcmap.c b/drivers/video/fbcmap.c
--- a/drivers/video/fbcmap.c	2005-03-07 16:50:34 +01:00
+++ b/drivers/video/fbcmap.c	2005-03-07 16:50:34 +01:00
@@ -16,6 +16,7 @@
 #include <linux/tty.h>
 #include <linux/fb.h>
 #include <linux/slab.h>
+#include "fbsplash.h"
 
 #include <asm/uaccess.h>
 
@@ -235,6 +236,10 @@
 					      info))
 			break;
 	}
+	fb_copy_cmap(cmap, &info->cmap);
+	if (fbsplash_active(info, vc_cons[fg_console].d) &&
+	    info->fix.visual == FB_VISUAL_DIRECTCOLOR) 
+		fbsplash_fix_pseudo_pal(info, vc_cons[fg_console].d);
 	return 0;
 }
 
@@ -265,6 +270,9 @@
 		if (transp)
 			transp++;
 	}
+	if (fbsplash_active(info, vc_cons[fg_console].d) &&
+	    info->fix.visual == FB_VISUAL_DIRECTCOLOR) 
+		fbsplash_fix_pseudo_pal(info, vc_cons[fg_console].d);
 	return 0;
 }




Live long and prosper.
-- 
Michal 'Spock' Januszewski                        Gentoo Linux Developer
cell: +48504917690                         http://dev.gentoo.org/~spock/
JID: spock@im.gentoo.org               freenode: #gentoo-dev, #gentoo-pl



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
