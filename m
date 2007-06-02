From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 04/24] epson1355fb: Color setting fixes
Date: Sat, 02 Jun 2007 17:57:14 +0800
Message-ID: <46613EFA.1020209@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuQiI-0000BM-Gv for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:20:02 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQiI-00011W-4G
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:20:02 -0700
Received: by py-out-1112.google.com with SMTP id u77so1508651pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:20:01 -0700 (PDT)
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
Cc: Christopher Hoover <ch@hpl.hp.com>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

- the pseudo_palette is only 16 elements long
- allocate the pseudo_palette as part of epson1355_par

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/epson1355fb.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/video/epson1355fb.c b/drivers/video/epson1355fb.c
index ca2c54c..67f58ba 100644
--- a/drivers/video/epson1355fb.c
+++ b/drivers/video/epson1355fb.c
@@ -63,6 +63,7 @@ #include <video/epson1355.h>
 
 struct epson1355_par {
 	unsigned long reg_addr;
+	u32 pseudo_palette[16];
 };
 
 /* ------------------------------------------------------------------------- */
@@ -635,7 +636,7 @@ int __init epson1355fb_probe(struct plat
 		goto bail;
 	}
 
-	info = framebuffer_alloc(sizeof(struct epson1355_par) + sizeof(u32) * 256, &dev->dev);
+	info = framebuffer_alloc(sizeof(struct epson1355_par), &dev->dev);
 	if (!info) {
 		rc = -ENOMEM;
 		goto bail;
@@ -648,7 +649,7 @@ int __init epson1355fb_probe(struct plat
 		rc = -ENOMEM;
 		goto bail;
 	}
-	info->pseudo_palette = (void *)(default_par + 1);
+	info->pseudo_palette = default_par->pseudo_palette;
 
 	info->screen_base = ioremap(EPSON1355FB_FB_PHYS, EPSON1355FB_FB_LEN);
 	if (!info->screen_base) {




-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
