From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH] fbdev: Fix software blanking code
Date: Mon, 25 Oct 2004 05:48:59 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410250549.02808.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CLq7j-0000FS-Ek
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Oct 2004 14:41:59 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CLq7i-0001mo-Kj
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 24 Oct 2004 14:41:59 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 959E99559AC
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 24 Oct 2004 21:41:45 +0000 (UTC)
Content-Disposition: inline
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
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org

The code in fbmem.c:fb_blank() is broken.  For drivers without an fb_blank
hook, an FBIO_BLANK ioctl will produce wrong colors or will segfault.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 fbmem.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2004-10-17 15:03:25 +08:00
+++ b/drivers/video/fbmem.c	2004-10-25 05:45:24 +08:00
@@ -750,18 +750,20 @@
 	
 	if (info->fbops->fb_blank && !info->fbops->fb_blank(blank, info))
 		return 0;
+
+	cmap = info->cmap;
+
 	if (blank) { 
 		black = kmalloc(sizeof(u16) * info->cmap.len, GFP_KERNEL);
-		if (!black) {
+		if (black) {
 			memset(black, 0, info->cmap.len * sizeof(u16));
 			cmap.red = cmap.green = cmap.blue = black;
 			cmap.transp = info->cmap.transp ? black : NULL;
 			cmap.start = info->cmap.start;
 			cmap.len = info->cmap.len;
 		}
-	} else
-		cmap = info->cmap;
-
+	}
+
 	err = fb_set_cmap(&cmap, info);
 	kfree(black);
 




-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
