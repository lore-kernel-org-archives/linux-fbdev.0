From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH] fbdev: Fix return code of edid_checksum
Date: Tue, 25 Jan 2005 21:46:10 +0800
Message-ID: <200501252146.10566.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CtR2i-0005m4-Bq
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 25 Jan 2005 05:47:40 -0800
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1CtR2g-0006YH-Du
	for linux-fbdev-devel@lists.sourceforge.net; Tue, 25 Jan 2005 05:47:40 -0800
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id C256E1357C18
	for <linux-fbdev-devel@lists.sourceforge.net>; Tue, 25 Jan 2005 13:46:34 +0000 (UTC)
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

  edid_checksum always return success (1) although it can fail.  Fix.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

 fbmon.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Nru a/drivers/video/fbmon.c b/drivers/video/fbmon.c
--- a/drivers/video/fbmon.c	2005-01-15 04:33:40 +08:00
+++ b/drivers/video/fbmon.c	2005-01-25 21:27:05 +08:00
@@ -183,7 +183,7 @@
 			err = 0;
 	}
 
-	return 1;
+	return err;
 }
 
 static void parse_vendor_block(unsigned char *block, struct fb_monspecs *specs)




-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
