From: "Antonino A. Daplas" <adaplas@hotpop.com>
Subject: [PATCH 2/7] fbdev: fix logo drawing failure for vga16fb
Date: Fri, 10 Sep 2004 05:34:34 +0800
Sender: linux-fbdev-devel-admin@lists.sourceforge.net
Message-ID: <200409100534.34919.adaplas@hotpop.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1C5WYW-0000Av-7t
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Sep 2004 14:34:12 -0700
Received: from smtp-out.hotpop.com ([38.113.3.71])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1C5WYV-0002Be-5Q
	for linux-fbdev-devel@lists.sourceforge.net; Thu, 09 Sep 2004 14:34:12 -0700
Received: from hotpop.com (kubrick.hotpop.com [38.113.3.103])
	by smtp-out.hotpop.com (Postfix) with SMTP id 515F310D67CF
	for <linux-fbdev-devel@lists.sourceforge.net>; Thu,  9 Sep 2004 21:33:56 +0000 (UTC)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>, linux-kernel@vger.kernel.org

This fixes the logo failing to draw in vga16fb due to faulty boolean logic.

Signed-off-by: Antonino Daplas <adaplas@pol.net>
---

  vga16fb.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -uprN linux-2.6.9-rc1-mm4-orig/drivers/video/vga16fb.c linux-2.6.9-rc1-mm4/drivers/video/vga16fb.c
--- linux-2.6.9-rc1-mm4-orig/drivers/video/vga16fb.c	2004-09-07 21:18:35.000000000 +0800
+++ linux-2.6.9-rc1-mm4/drivers/video/vga16fb.c	2004-09-07 21:30:39.059300648 +0800
@@ -1306,7 +1306,7 @@ void vga16fb_imageblit(struct fb_info *i
 {
 	if (image->depth == 1)
 		vga_imageblit_expand(info, image);
-	else if (image->depth <= info->var.bits_per_pixel)
+	else
 		vga_imageblit_color(info, image);
 }
 




-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
