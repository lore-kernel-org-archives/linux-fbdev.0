From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH 2/4] cirrusfb: add noaccel module
	parameter
Date: Fri, 5 Sep 2008 23:53:18 +0200
Message-ID: <20080905235318.f961240d.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Kbj8J-0007nz-3E for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 14:46:23 -0700
Received: from smtp239.poczta.interia.pl ([217.74.64.239])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Kbj8I-0001dG-ND
	for linux-fbdev-devel@lists.sourceforge.net;
	Fri, 05 Sep 2008 14:46:23 -0700
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Linux-fbdev-devel <linux-fbdev-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@linux-foundation.org>

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The noaccel parameter is already handled
if the driver is not built as module.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>
---
 drivers/video/cirrusfb.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/video/cirrusfb.c b/drivers/video/cirrusfb.c
index 30c47f1..245005e 100644
--- a/drivers/video/cirrusfb.c
+++ b/drivers/video/cirrusfb.c
@@ -352,7 +352,7 @@ struct cirrusfb_info {
 	void (*unmap)(struct fb_info *info);
 };
 
-static int noaccel;
+static int noaccel __devinitdata;
 static char *mode_option __devinitdata = "640x480@60";
 
 /****************************************************************************/
@@ -2525,6 +2525,8 @@ module_init(cirrusfb_init);
 
 module_param(mode_option, charp, 0);
 MODULE_PARM_DESC(mode_option, "Initial video mode e.g. '648x480-8@60'");
+module_param(noaccel, bool, 0);
+MODULE_PARM_DESC(noaccel, "Disable acceleration");
 
 #ifdef MODULE
 module_exit(cirrusfb_exit);
-- 
1.5.2.2


----------------------------------------------------------------------
Teraz taniej na zagraniczne komorki!
Sprawdz >> http://link.interia.pl/f1ef7 


-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
