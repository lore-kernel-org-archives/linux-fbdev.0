From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 5/9] fbdev: Check return value of fb_add_videomode
Date: Tue, 21 Dec 2004 23:34:07 +0800
Message-ID: <20041221213653.328C11A0265@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cgrgx-0007Ww-VT
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:37:15 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1Cgrgs-0002Re-Ru
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 21 Dec 2004 13:37:15 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id D3FC1BB4EFB
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 21 Dec 2004 21:36:57 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The function fb_add_videomode can fail, check return value.  

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbmem.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff -Nru a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c	2004-12-21 22:44:55 +08:00
+++ b/drivers/video/fbmem.c	2004-11-29 20:07:51 +08:00
@@ -716,6 +716,7 @@
 		if ((var->activate & FB_ACTIVATE_MASK) == FB_ACTIVATE_NOW) {
 			struct fb_videomode mode;
 			info->var = *var;
+			int err = 0;
 
 			if (info->fbops->fb_set_par)
 				info->fbops->fb_set_par(info);
@@ -728,15 +729,16 @@
 
 			if (info->modelist.prev && info->modelist.next &&
 			    !list_empty(&info->modelist))
-				fb_add_videomode(&mode, &info->modelist);
+				err = fb_add_videomode(&mode, &info->modelist);
 
-			if (info->flags & FBINFO_MISC_USEREVENT) {
+			if (!err && info->flags & FBINFO_MISC_USEREVENT) {
 				struct fb_event event;
 
 				info->flags &= ~FBINFO_MISC_USEREVENT;
 				event.info = info;
 				notifier_call_chain(&fb_notifier_list,
-						    FB_EVENT_MODE_CHANGE, &event);
+						    FB_EVENT_MODE_CHANGE,
+						    &event);
 			}
 		}
 	}




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
