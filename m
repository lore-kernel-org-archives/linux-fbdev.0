From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 4/4] fbdev: Fix module_param in rivafb
Date: Mon, 22 Nov 2004 07:17:00 +0800
Message-ID: <200411220717.00572.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CW10p-0002at-5r
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Nov 2004 15:20:55 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CW10S-0004AF-HT
	for linux-fbdev-devel@lists.sourceforge.net; Sun, 21 Nov 2004 15:20:54 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 5C31F11E7F72
	for <linux-fbdev-devel@lists.sourceforge.net>; Sun, 21 Nov 2004 23:20:07 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Guido Guenther <agx@sigxcpu.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

third argument in module_param is the sysfs permission not a default
value. This fixes things for rivafb in 2.6.10-rc2:

Signed-Off-By: Guido Guenther <agx@sigxcpu.org>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbdev.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Nru a/drivers/video/riva/fbdev.c b/drivers/video/riva/fbdev.c
--- a/drivers/video/riva/fbdev.c	2004-11-22 06:48:45 +08:00
+++ b/drivers/video/riva/fbdev.c	2004-11-20 08:38:47 +08:00
@@ -2210,9 +2210,9 @@
 
 module_param(noaccel, bool, 0);
 MODULE_PARM_DESC(noaccel, "bool: disable acceleration");
-module_param(flatpanel, int, -1);
+module_param(flatpanel, int, 0);
 MODULE_PARM_DESC(flatpanel, "Enables experimental flat panel support for some chipsets. (0 or 1=enabled) (default=0)");
-module_param(forceCRTC, int, -1);
+module_param(forceCRTC, int, 0);
 MODULE_PARM_DESC(forceCRTC, "Forces usage of a particular CRTC in case autodetection fails. (0 or 1) (default=autodetect)");
 #ifdef CONFIG_MTRR
 module_param(nomtrr, bool, 0);




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
