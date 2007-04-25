From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 01/41] epson1355fb.c: Fix error handling
	code
Date: Wed, 25 Apr 2007 14:16:09 +0800
Message-ID: <462EF229.4080903@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Hgc3t-0000iT-S1 for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:37:13 -0700
Received: from py-out-1112.google.com ([64.233.166.180])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Hgc3s-0002Sk-Bl
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:37:13 -0700
Received: by py-out-1112.google.com with SMTP id a29so115915pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:37:11 -0700 (PDT)
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
Cc: Roland Stigge <stigge@antcom.de>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

From: Roland Stigge <stigge@antcom.de>

Fix error handling code

Signed-off-by: Roland Stigge <stigge@antcom.de>
Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/epson1355fb.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/video/epson1355fb.c b/drivers/video/epson1355fb.c
index 29e07c1..37e297d 100644
--- a/drivers/video/epson1355fb.c
+++ b/drivers/video/epson1355fb.c
@@ -650,9 +650,10 @@ int __init epson1355fb_probe(struct plat
 	}
 
 	info = framebuffer_alloc(sizeof(struct epson1355_par) + sizeof(u32) * 256, &dev->dev);
-	if (!info)
+	if (!info) {
 		rc = -ENOMEM;
 		goto bail;
+	}
 
 	default_par = info->par;
 	default_par->reg_addr = (unsigned long) ioremap(EPSON1355FB_REGS_PHYS, EPSON1355FB_REGS_LEN);


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
