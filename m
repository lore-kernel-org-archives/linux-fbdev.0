From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 29/41] vga16fb: Restrict to blit
 rectangles with widths of multiples of 8 pixels
Date: Wed, 25 Apr 2007 15:02:31 +0800
Message-ID: <462EFD07.4000802@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HgcAR-0001Mz-UD for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:44:00 -0700
Received: from py-out-1112.google.com ([64.233.166.182])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HgcAR-00044I-LR
	for linux-fbdev-devel@lists.sourceforge.net;
	Wed, 25 Apr 2007 00:43:59 -0700
Received: by py-out-1112.google.com with SMTP id a29so117101pyi
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Wed, 25 Apr 2007 00:43:59 -0700 (PDT)
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
Cc: Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

Advertise that vga16fb can only handle widths that are 8-pixel-multiple only
(software limitation). To ensure that a legal font is available, SELECT an
8x16 font in Kconfig.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/Kconfig   |    1 +
 drivers/video/vga16fb.c |    2 ++
 2 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 61931da..e440caf 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -516,6 +516,7 @@ config FB_VGA16
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
 	select VGASTATE
+	select FONT_8x16 if FRAMEBUFFER_CONSOLE
 	help
 	  This is the frame buffer device driver for VGA 16 color graphic
 	  cards. Say Y if you have such a card.
diff --git a/drivers/video/vga16fb.c b/drivers/video/vga16fb.c
index ec4c7dc..6c580a0 100644
--- a/drivers/video/vga16fb.c
+++ b/drivers/video/vga16fb.c
@@ -1378,6 +1378,8 @@ static int __init vga16fb_probe(struct p
 	info->fbops = &vga16fb_ops;
 	info->var = vga16fb_defined;
 	info->fix = vga16fb_fix;
+	/* supports 8-pixel wide blit rectangles only */
+	info->pixmap.blit_x = 1 << (8 - 1);
 	info->flags = FBINFO_FLAG_DEFAULT |
 		FBINFO_HWACCEL_YPAN;
 


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
