From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 4/6] pm2fb: X and VT switching crash fix
Date: Sun, 13 Mar 2005 08:34:32 +0800
Message-ID: <200503130834.32363.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DAH5j-0003q0-OH
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 16:36:23 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DAH5j-0008Qa-9j
	for linux-fbdev-devel@lists.sourceforge.net; Sat, 12 Mar 2005 16:36:23 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 98F89F9EC60
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 13 Mar 2005 00:36:17 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Jim Hague <jim.hague@acm.org>

  From Jim Hague:

  This is a bug in pm2fb.c exposed by recent changes to fbcon.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 pm2fb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Nru a/drivers/video/pm2fb.c b/drivers/video/pm2fb.c
--- a/drivers/video/pm2fb.c	2005-03-12 23:23:18 +08:00
+++ b/drivers/video/pm2fb.c	2005-03-11 22:32:03 +08:00
@@ -747,7 +747,7 @@
 	}
 	if ((info->var.vmode & FB_VMODE_MASK)==FB_VMODE_DOUBLE)
 		video |= PM2F_LINE_DOUBLE;
-	if (info->var.activate==FB_ACTIVATE_NOW)
+	if ((info->var.activate & FB_ACTIVATE_MASK)==FB_ACTIVATE_NOW)
 		video |= PM2F_VIDEO_ENABLE;
 	par->video = video;
 




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
