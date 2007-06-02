From: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: [PATCH 06/24] fm2fb: The pseudo_palette is only
	16 elements long
Date: Sat, 02 Jun 2007 17:57:48 +0800
Message-ID: <46613F1C.50606@gmail.com>
Reply-To: linux-fbdev-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-fbdev-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HuQiR-0000F2-Cv for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:20:11 -0700
Received: from py-out-1112.google.com ([64.233.166.181])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HuQiR-00011W-2y
	for linux-fbdev-devel@lists.sourceforge.net;
	Sat, 02 Jun 2007 03:20:11 -0700
Received: by py-out-1112.google.com with SMTP id u77so1508651pyb
	for <linux-fbdev-devel@lists.sourceforge.net>;
	Sat, 02 Jun 2007 03:20:10 -0700 (PDT)
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
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>

The pseudo_palette is only 16 elements long.

Signed-off-by: Antonino Daplas <adaplas@gmail.com>
---

 drivers/video/fm2fb.c |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/drivers/video/fm2fb.c b/drivers/video/fm2fb.c
index 70ff55b..6c91c61 100644
--- a/drivers/video/fm2fb.c
+++ b/drivers/video/fm2fb.c
@@ -195,13 +195,15 @@ static int fm2fb_blank(int blank, struct
 static int fm2fb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
                          u_int transp, struct fb_info *info)
 {
-	if (regno > info->cmap.len)
-		return 1;
-	red >>= 8;
-	green >>= 8;
-	blue >>= 8;
+	if (regno < 16) {
+		red >>= 8;
+		green >>= 8;
+		blue >>= 8;
+
+		((u32*)(info->pseudo_palette))[regno] = (red << 16) |
+			(green << 8) | blue;
+	}
 
-	((u32*)(info->pseudo_palette))[regno] = (red << 16) | (green << 8) | blue;
 	return 0;
 }
 
@@ -237,7 +239,7 @@ static int __devinit fm2fb_probe(struct 
 	if (!zorro_request_device(z,"fm2fb"))
 		return -ENXIO;
 
-	info = framebuffer_alloc(256 * sizeof(u32), &z->dev);
+	info = framebuffer_alloc(16 * sizeof(u32), &z->dev);
 	if (!info) {
 		zorro_release_device(z);
 		return -ENOMEM;



-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
