From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 14/15] fbdev: Check if cursor image has changed in intelfb
Date: Fri, 29 Oct 2004 09:58:57 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200410290958.57538.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CNM3J-0006Bv-HI
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:59:41 -0700
Received: from smtp-out.hotpop.com ([38.113.3.61])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1CNM3I-0001c6-7G
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 28 Oct 2004 18:59:41 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id E0A33969BF0
	for <linux-fbdev-devel@lists.sourceforge.net>; Fri, 29 Oct 2004 01:59:28 +0000 (UTC)
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
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, Sylvain Meyer <sylvain.meyer@ifrance.com>

Check if cursor image has changed in intelfb

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---
 intelfbdrv.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -Nru a/drivers/video/intelfb/intelfbdrv.c b/drivers/video/intelfb/intelfbdrv.c
--- a/drivers/video/intelfb/intelfbdrv.c	2004-10-28 20:56:42 +08:00
+++ b/drivers/video/intelfb/intelfbdrv.c	2004-10-29 09:34:24 +08:00
@@ -1573,7 +1573,7 @@
 		intelfbhw_cursor_setcolor(dinfo, bg, fg);
 	}
 
-	if (cursor->set & FB_CUR_SETSHAPE) {
+	if (cursor->set & (FB_CUR_SETSHAPE & FB_CUR_SETIMAGE)) {
 		u32 s_pitch = (ROUND_UP_TO(cursor->image.width, 8) / 8);
 		u32 size = s_pitch * cursor->image.height;
 		u8 *dat = (u8 *) cursor->image.data;




-------------------------------------------------------
This Newsletter Sponsored by: Macrovision 
For reliable Linux application installations, use the industry's leading
setup authoring tool, InstallShield X. Learn more and evaluate 
today. http://clk.atdmt.com/MSI/go/ins0030000001msi/direct/01/
