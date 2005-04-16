From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/6] fbcon: Fix check after use
Date: Sat, 16 Apr 2005 13:17:57 +0800
Message-ID: <200504161317.57320.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DMfrG-0002B2-Hc
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Apr 2005 22:28:42 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DMfrG-0008Bk-28
	for linux-fbdev-devel@lists.sourceforge.net; Fri, 15 Apr 2005 22:28:42 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 4116F1505C3B
	for <linux-fbdev-devel@lists.sourceforge.net>; Sat, 16 Apr 2005 05:28:26 +0000 (UTC)
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
Cc: Adrian Bunk <bunk@stusta.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

  This patch fixes a check after use found by the Coverity checker.

From: Adrian Bunk <bunk@fs.tum.de>
Signed-off-by: Adrian Bunk <bunk@fs.tum.de>
Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbcon.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletion(-)

diff -Nru a/drivers/video/console/fbcon.c b/drivers/video/console/fbcon.c
--- a/drivers/video/console/fbcon.c	2005-03-22 05:48:50 +08:00
+++ b/drivers/video/console/fbcon.c	2005-03-23 11:53:44 +08:00
@@ -906,10 +906,13 @@
 	struct vc_data *svc = *default_mode;
 	struct display *t, *p = &fb_display[vc->vc_num];
 	int logo = 1, new_rows, new_cols, rows, cols, charcnt = 256;
-	int cap = info->flags;
+	int cap;
 
 	if (info_idx == -1 || info == NULL)
 	    return;
+
+	cap = info->flags;
+
 	if (vc != svc || logo_shown == FBCON_LOGO_DONTSHOW ||
 	    (info->fix.type == FB_TYPE_TEXT))
 		logo = 0;




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
