From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 3/11] fbcon: Fix compile error
Date: Thu, 13 Jan 2005 21:01:28 +0800
Message-ID: <20050113214619.299C91A00A1@smtp-1.hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CpCne-000148-RK
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 13:46:38 -0800
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CpCnd-0000BD-CA
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 13 Jan 2005 13:46:38 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id C7B21CAED75
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu, 13 Jan 2005 21:46:23 +0000 (UTC)
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

Fix missing symbol (fb_con)

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbcon.h |    3 +++
 1 files changed, 3 insertions(+)

diff -Nru a/drivers/video/console/fbcon.h b/drivers/video/console/fbcon.h
--- a/drivers/video/console/fbcon.h	2005-01-12 06:10:17 +08:00
+++ b/drivers/video/console/fbcon.h	2005-01-13 05:33:21 +08:00
@@ -162,4 +162,7 @@
 			      struct display *p, struct fbcon_ops *ops);
 #endif
 extern void fbcon_set_bitops(struct fbcon_ops *ops);
+
+extern const struct consw fb_con;
+
 #endif /* _VIDEO_FBCON_H */




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
