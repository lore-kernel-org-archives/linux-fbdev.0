From: Gerd Knorr <kraxel@bytesex.org>
Subject: [patch] fbdev: sysfs fix
Date: Tue, 7 Dec 2004 15:36:06 +0100
Message-ID: <20041207143606.GA23570__6651.15444357998$1102438759$gmane$org@bytesex>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbiVX-0001ow-H3
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Dec 2004 08:48:11 -0800
Received: from witte.sonytel.be ([80.88.33.193])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CbiVW-0005Mn-HF
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 07 Dec 2004 08:48:11 -0800
Received: from waterleaf.sonytel.be (mail.sonytel.be [43.221.60.197])
	by witte.sonytel.be (8.12.10/8.12.10) with ESMTP id iB7Gm6GU005877
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 7 Dec 2004 17:48:06 +0100 (MET)
Content-Disposition: inline
ReSent-To: Linux Frame Buffer Device Development <linux-fbdev-devel@lists.sourceforge.net>
ReSent-Message-ID: <Pine.GSO.4.61.0412071748030.4276@waterleaf.sonytel.be>
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
To: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Make sure the fbdev sysfs class is registered before all drivers,
otherwise some symlinks are missing.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 drivers/video/fbmem.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Index: linux-2004-11-23/drivers/video/fbmem.c
===================================================================
--- linux-2004-11-23.orig/drivers/video/fbmem.c	2004-11-26 16:31:37.110665860 +0100
+++ linux-2004-11-23/drivers/video/fbmem.c	2004-11-26 17:41:14.112220692 +0100
@@ -1165,7 +1165,7 @@ fbmem_init(void)
 	}
 	return 0;
 }
-module_init(fbmem_init);
+subsys_initcall(fbmem_init);
 
 static char *video_options[FB_MAX];
 static int ofonly;

-- 
#define printk(args...) fprintf(stderr, ## args)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
