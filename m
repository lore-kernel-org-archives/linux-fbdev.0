From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 18/24] tx3912fb: Fix improper assignment
	of info->pseudo_palette
Date: Sat, 02 Jun 2007 18:22:31 +0800
Message-ID: <466144E7.20407@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuQlP-0000az-Qb for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:23:16 -0700
Received: from py-out-1112.google.com ([64.233.166.177])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQlP-0001zh-HI
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:23:15 -0700
Received: by py-out-1112.google.com with SMTP id u77so1509718pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:23:15 -0700 (PDT)
List-Id: <fbdev-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=linux-fbdev-devel>
List-Post: <mailto:linux-fbdev-devel@lists.sourceforge.net>
List-Help: <mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-fbdev-devel>,
	<mailto:linux-fbdev-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: linux-fbdev-devel-bounces@lists.sourceforge.net
Errors-To: linux-fbdev-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Steven Hill <sjhill@realitydiluted.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

There is no variable pseudo_palette.  Instead, there is u32 cfb8[16]. Use
this for info->pseudo_palette.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/tx3912fb.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/video/tx3912fb.c b/drivers/video/tx3912fb.c
index 07389ba..e6f7c78 100644
--- a/drivers/video/tx3912fb.c
+++ b/drivers/video/tx3912fb.c
@@ -291,7 +291,7 @@ int __init tx3912fb_init(void)
 	fb_info.fbops = &tx3912fb_ops;
 	fb_info.var = tx3912fb_var;
 	fb_info.fix = tx3912fb_fix;
-	fb_info.pseudo_palette = pseudo_palette;
+	fb_info.pseudo_palette = cfb8;
 	fb_info.flags = FBINFO_DEFAULT;
 
 	/* Clear the framebuffer */



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
