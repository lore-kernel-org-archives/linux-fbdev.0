From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 4/6] fbcon: Save blank state last
Date: Tue, 18 Jan 2005 05:41:17 +0800
Message-ID: <200501180541.17021.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Cqecq-00037B-HP
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Jan 2005 13:41:28 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Cqecq-0005TI-2A
	for linux-fbdev-devel@lists.sourceforge.net; Mon, 17 Jan 2005 13:41:28 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 1B7A4CFE032
	for <linux-fbdev-devel@lists.sourceforge.net>; Mon, 17 Jan 2005 21:41:15 +0000 (UTC)
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

Save blank state after do_blank|unblank_screen() since this flag is checked
in fbcon_blank().

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbcon.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2005-01-15 04:25:57 +08:00
+++ b/drivers/video/console/fbcon.c	2005-01-15 08:23:03 +08:00
@@ -2654,13 +2654,13 @@
 		vc = vc_cons[ops->currcon].d;
 
 		if (CON_IS_VISIBLE(vc)) {
-			ops->blank_state = blank;
-
 			if (blank)
 				do_blank_screen(0);
 			else
 				do_unblank_screen(0);
 		}
+		
+		ops->blank_state = blank;
 	}
 }
 




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
